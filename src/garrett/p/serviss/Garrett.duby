import "android.app.Activity"
import "android.content.Context"
import "android.os.Bundle"

import "android.view.View"
import "android.view.MotionEvent"
import "android.graphics.Canvas"
import "android.graphics.Paint"

class GarrettView < View
  def initialize(a:Context)
    super(a)
    @paint = Paint.new
    @paint.setARGB(250, 50, 50, 200)
    
    @y = @x = @radius = 50
    @vx = @vy = 1
  end

  def bounce
    if @x > (getWidth - @radius) or @x < @radius
      @vx = -@vx
    end
    if @y > (getWidth - @radius) or @y < @radius
      @vy = -@vy
    end
  end

  def move
    @x += @vx
    @y += @vy
  end

  def on_ball(x:float, y:float)
    Math.abs(x - @x) <= @radius and Math.abs(y - @y) <= @radius
  end
  
  def onTouchEvent(event:MotionEvent)
    if on_ball(event.getX, event.getY)
      @x = int(event.getX)
      @y = int(event.getY)
      return true
    end
  end

  def onDraw(canvas:Canvas)
    move
    bounce
    canvas.drawCircle(@x, @y, @radius, @paint)
    Thread.sleep(10)
    invalidate
  end
end

class Garrett < Activity
  def onCreate(state:Bundle)
    @state = state
    super(state)
    @view = GarrettView.new(self)
    setContentView(@view)
  end
end

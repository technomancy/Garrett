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

    @y = @x = @radius = 50.0
    @vx = @vy = 1.0
  end

  def bounce
    # TODO: make sure it bounces the right way instead of flip-flopping
    if @x > (getWidth - @radius) or @x < @radius
      @vx = -@vx
    end
    if @y > (getHeight - @radius) or @y < @radius
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
    if event.getAction == MotionEvent.ACTION_DOWN
      @down = event
      return true
    elsif event.getAction == MotionEvent.ACTION_MOVE
      if on_ball(event.getX, event.getY)
        @x = event.getX
        @y = event.getY
        return true
      end
    elsif event.getAction == MotionEvent.ACTION_UP
      release(event)
      return true
    end
    return false
  end

  def release(event:MotionEvent)
    delta_x = @down.getX - event.getX
    delta_y = @down.getY - event.getY
    if delta_x > delta_y
      @vx = 1.0
      @vy = delta_y / delta_x
    else
      @vx = delta_x / delta_y
      @vy = 1.0
    end
    @down = nil
  end

  def onDraw(canvas:Canvas)
    move # unless @down
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

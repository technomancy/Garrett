import "android.app.Activity"
import "android.content.Context"
import "android.os.Bundle"
import "android.util.Log"

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
      if on_ball(event.getX, event.getY)
        @down = true
        return true
      end
    elsif event.getAction == MotionEvent.ACTION_MOVE
      if @down
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
    delta_x = event.getX - event.getHistoricalX(0)
    delta_y = event.getY - event.getHistoricalY(0)
    Log.i("Garrett", "Delta X: " + Float.new(delta_x).toString +
          ", Delta Y: " + Float.new(delta_y).toString)
    if Math.abs(delta_x) > Math.abs(delta_y)
      @vy = delta_y / Math.abs(delta_x)
      @vx = 1.0 # WTF; 1.0 and -1.0 are different types?!
      @vx = -@vx if delta_x < 0
    else
      @vx = delta_x / Math.abs(delta_y)
      @vy = 1.0
      @vy = -@vy if delta_y < 0
    end
    Log.i("Garrett", Float.new(@vx).toString + "x" + Float.new(@vy).toString)
    @down = false
  end

  def onDraw(canvas:Canvas)
    move unless @down
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

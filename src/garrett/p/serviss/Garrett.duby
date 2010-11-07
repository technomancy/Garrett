import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.util.Log

import android.view.View
import android.view.MotionEvent
import android.graphics.Canvas
import android.graphics.Paint

class GarrettView < View
  def initialize(a:Context)
    super(a)
    @paint = Paint.new
    @paint.setARGB(250, 50, 50, 200)
    @text_paint = Paint.new
    @text_paint.setARGB(250, 250, 250, 250)

    @y = @x = @radius = float(50.0)
    @vx = @vy = float(1.0)
    @bounces = 0
  end

  def bounce
    did_bounce = false
    if @x > (getWidth - @radius)
      did_bounce = true
      @vx = -Math.abs(@vx)
    elsif @x < @radius
      did_bounce = true
      @vx = Math.abs(@vx)
    end

    if @y > (getHeight - @radius)
      did_bounce = true
      @vy = -Math.abs(@vy)
    elsif @y < @radius
      did_bounce = true
      @vy = Math.abs(@vy)
    end
    
    @bounces += 1 if did_bounce
  end

  def move
    @x += @vx
    @y += @vy
    @vx *= float(0.99)
    @vy *= float(0.99)
  end

  def on_ball(x:float, y:float)
    Math.abs(x - @x) <= @radius and Math.abs(y - @y) <= @radius
  end

  def onTouchEvent(event:MotionEvent)
    if event.getAction == MotionEvent.ACTION_DOWN
      if on_ball(event.getX, event.getY)
        @down = true
        @bounces = 0
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
    Log.i("Garrett", "Delta X: " + delta_x +
          ", Delta Y: " + delta_y)
    if delta_x < 0
      @vx = -Math.min(-delta_x, 500)
    else
      @vx = Math.min(delta_x, 500)
    end
    if delta_y < 0
      @vy = -Math.min(-delta_y, 500)
    else
      @vy = Math.min(delta_y, 500)
    end
    Log.i("Garrett", "" + @vx + "x" + @vy)
    @down = false
    @bounces = 0
  end

  def onDraw(canvas:Canvas)
    move unless @down
    bounce
    canvas.drawCircle(@x, @y, @radius, @paint)
    canvas.drawText(String.valueOf(@bounces), @x , @y, @text_paint)
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

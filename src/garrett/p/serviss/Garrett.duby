import "android.app.Activity"
import "android.content.Context"
import "android.os.Bundle"

import "android.view.View"
import "android.graphics.Canvas"
import "android.graphics.Paint"

class GarrettView < View
  def initialize(a:Context)
    super(a)
    @paint = Paint.new
    @paint.setARGB(250, 50, 50, 200)
    @x = 0
    @y = 0
    @vx = 1
    @vy = 1
    @radius = 50
  end

  def bounce
    if @x > getWidth or @x < 0
      @vx = -@vx
    end
    if @y > getWidth or @y < 0
      @vy = -@vy
    end
  end

  def move
    @x += @vx
    @y += @vy
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

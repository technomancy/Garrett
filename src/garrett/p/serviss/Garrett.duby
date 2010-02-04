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
    @frame = 0
    @radius = 50
    @x = @radius
    @y = @radius
    @xv = 1
    @yv = 1
  end

  def bounce
    if @x > (getWidth - @radius) or @x < @radius
      @xv = -@xv
    end
    if @y > (getHeight - @radius) or @y < @radius
      @yv = -@yv
    end
  end

  def onDraw(canvas:Canvas)
    @frame = @frame + 1
    @x = @x + @xv
    @y = @y + @yv
    bounce
    canvas.drawCircle(@x, @y, @radius, @paint)
    invalidate
  end
end

class Garrett < Activity
  def onCreate(savedInstanceState:Bundle)
    super(savedInstanceState)
    v = GarrettView.new(self)
    setContentView(v)
  end
end

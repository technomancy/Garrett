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
  end

  def x
    bounce_to(getWidth)
  end

  def y
    bounce_to(getHeight)
  end

  def bounce_to(limit:int)
    Math.abs((@frame % (2 * limit)) - limit)
  end

  def onDraw(canvas:Canvas)
    @frame = @frame + 1
    canvas.drawCircle(x, y, @radius, @paint)
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

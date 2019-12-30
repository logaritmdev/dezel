package ca.logaritm.dezel.view.drawable

import android.graphics.*
import android.graphics.drawable.Drawable
import ca.logaritm.dezel.view.graphic.LinearGradient
import ca.logaritm.dezel.view.graphic.RadialGradient
import android.graphics.LinearGradient as AndroidLinearGradient

/**
 * @class BackgroundColorDrawable
 * @since 0.7.0
 * @hidden
 */
open class BackgroundColorDrawable() : Drawable() {

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    /**
     * @property color
     * @since 0.7.0
     * @hidden
     */
    open var color: Int? = null
    
    /**
     * @property linearGradient
     * @since 0.7.0
     * @hidden
     */
    open var linearGradient: LinearGradient? = null

    /**
     * @property radialGradient
     * @since 0.7.0
     * @hidden
     */
    open var radialGradient: RadialGradient? = null

    /**
     * @property colorPaint
     * @since 0.7.0
     * @hidden
     */
    private val colorPaint: Paint = Paint()

    /**
     * @property linearGradientPaint
     * @since 0.7.0
     * @hidden
     */
    private val linearGradientPaint: Paint = Paint()

    /**
     * @property radialGradientPaint
     * @since 0.7.0
     * @hidden
     */
    private val radialGradientPaint: Paint = Paint()
    
    /**
     * @property srcRect
     * @since 0.7.0
     * @hidden
     */
    private var srcRect: Rect = Rect()

    /**
     * @property dstRect
     * @since 0.7.0
     * @hidden
     */
    private var dstRect: Rect = Rect()

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    /**
     * @method setAlpha
     * @since 0.7.0
     * @hidden
     */
    override fun setAlpha(alpha: Int) {

    }

    /**
     * @method setColorFilter
     * @since 0.7.0
     * @hidden
     */
    override fun setColorFilter(cf: ColorFilter?) {

    }

    /**
     * @method getOpacity
     * @since 0.7.0
     * @hidden
     */
    override fun getOpacity() : Int {
        return PixelFormat.TRANSLUCENT
    }

    /**
     * @method draw
     * @since 0.7.0
     * @hidden
     */
    override fun draw(canvas: Canvas) {
        this.draw(canvas, null)
    }

    /**
     * @method draw
     * @since 0.7.0
     * @hidden
     */
    open fun draw(canvas: Canvas, xfermode: Xfermode?) {

        val linearGradient = this.linearGradient
        val radialGradient = this.radialGradient

        val color = this.color
        if (color != null &&
            color != Color.TRANSPARENT) {
            this.drawColor(canvas, xfermode, color)
        } else if (linearGradient != null) {
            this.drawLinearGradient(canvas, xfermode, linearGradient)
        } else if (radialGradient != null) {
            this.drawRadialGradient(canvas, xfermode, radialGradient)
        }
    }

    /**
     * @method drawColor
     * @since 0.7.0
     * @hidden
     */
    open fun drawColor(canvas: Canvas, xfermode: Xfermode?, color: Int) {
        this.colorPaint.xfermode = xfermode
        this.colorPaint.color = color
        canvas.drawRect(this.bounds, this.colorPaint)
        this.colorPaint.xfermode = null
    }
    
    /**
     * @method drawLinearGradient
     * @since 0.7.0
     * @hidden
     */
    open fun drawLinearGradient(canvas: Canvas, xfermode: Xfermode?, linearGradient: LinearGradient) {

        val w = this.bounds.width()
        val h = this.bounds.height()

        val x = (linearGradient.angle + Math.PI / 2.0) / (2.0 * Math.PI)

        val a = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.75) / 2.0))), 2.0).toFloat() * w.toFloat()
        val b = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.00) / 2.0))), 2.0).toFloat() * h.toFloat()
        val c = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.25) / 2.0))), 2.0).toFloat() * w.toFloat()
        val d = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.50) / 2.0))), 2.0).toFloat() * h.toFloat()

        val shader = AndroidLinearGradient(a, b, c, d, linearGradient.colors.toIntArray(), linearGradient.points.toFloatArray(), Shader.TileMode.CLAMP)

        this.linearGradientPaint.xfermode = xfermode
        this.linearGradientPaint.shader = shader
        canvas.drawRect(this.bounds, this.linearGradientPaint)
        this.linearGradientPaint.xfermode = null
    }

    /**
     * @method drawRadialGradient
     * @since 0.7.0
     * @hidden
     */
    open fun drawRadialGradient(canvas: Canvas, xfermode: Xfermode?, gradient: RadialGradient) {
    
    }
}
import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.graphic.Canvas')

/**
 * @class Image
 * @since 0.4.0
 */
export class Canvas {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property fillStyle
	 * @since 0.4.0
	 */
	@native public fillStyle!: string

	/**
	 * @property strokeStyle
	 * @since 0.4.0
	 */
	@native public strokeStyle!: string

	/**
	 * @property lineCap
	 * @since 0.4.0
	 */
	@native public lineCap!: string

	/**
	 * @property lineJoin
	 * @since 0.4.0
	 */
	@native public lineJoin!: string

	/**
	 * @property lineWidth
	 * @since 0.4.0
	 */
	@native public lineWidth!: number

	/**
	 * @method jsProperytSet_shadowOffsetX
	 * @since 0.4.0
	 */
	@native public shadowOffsetX!: number

	/**
	 * @property shadowOffsetY
	 * @since 0.4.0
	 */
	@native public shadowOffsetY!: number

	/**
	 * @method jsProperytSet_shadowBlur
	 * @since 0.4.0
	 */
	@native public shadowBlur!: number
	/**
	 * @property shadowColor
	 * @since 0.4.0
	 */
	@native public shadowColor!: string

	/**
	 * @property globalAlpha
	 * @since 0.4.0
	 */
	@native public globalAlpha!: number

	/**
	 * @property globalCompositeOperation
	 * @since 0.4.0
	 */
	@native public globalCompositeOperation!: string

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method rect
	 * @since 0.4.0
	 */
	public rect(x: number, y: number, w: number, h: number) {
		native(this).rect(x, y, w, h)
		return this
	}

	/**
	 * @method fillRect
	 * @since 0.4.0
	 */
	public fillRect(x: number, y: number, w: number, h: number) {
		native(this).fillRect(x, y, w, h)
		return this
	}

	/**
	 * @method strokeRect
	 * @since 0.4.0
	 */
	public strokeRect(x: number, y: number, w: number, h: number) {
		native(this).strokeRect(x, y, w, h)
		return this
	}

	/**
	 * @method clearRect
	 * @since 0.4.0
	 */
	public clearRect(x: number, y: number, w: number, h: number) {
		native(this).clearRect(x, y, w, h)
		return this
	}

	/**
	 * @method fill
	 * @since 0.4.0
	 */
	public fill() {
		native(this).fill()
		return this
	}

	/**
	 * @method stroke
	 * @since 0.4.0
	 */
	public stroke() {
		native(this).stroke()
		return this
	}

	/**
	 * @method beginPath
	 * @since 0.4.0
	 */
	public beginPath() {
		native(this).beginPath()
		return this
	}

	/**
	 * @method closePath
	 * @since 0.4.0
	 */
	public closePath() {
		native(this).closePath()
		return this
	}

	/**
	 * @method moveTo
	 * @since 0.4.0
	 */
	public moveTo(x: number, y: number) {
		native(this).moveTo(x, y)
		return this
	}

	/**
	 * @method lineTo
	 * @since 0.4.0
	 */
	public lineTo(x: number, y: number) {
		native(this).lineTo(x, y)
		return this
	}

	/**
	 * @method clip
	 * @since 0.4.0
	 */
	public clip() {
		native(this).clip()
		return this
	}

	/**
	 * @method quadraticCurveTo
	 * @since 0.4.0
	 */
	public quadraticCurveTo(cx: number, cy: number, x: number, y: number) {
		native(this).quadraticCurveTo(cx, cy, x, y)
		return this
	}

	/**
	 * @method bezierCurveTo
	 * @since 0.4.0
	 */
	public bezierCurveTo(c1x: number, c1y: number, c2x: number, c2y: number, x: number, y: number) {
		native(this).bezierCurveTo(c1x, c1y, c2x, c2y, x, y)
		return this
	}

	/**
	 * @method arc
	 * @since 0.4.0
	 */
	public arc(x: number, y: number, radius: number, sa: number, ea: number, ccw: boolean = false) {
		native(this).arc(x, y, radius, sa, ea, ccw)
		return this
	}

	/**
	 * @method arcTo
	 * @since 0.4.0
	 */
	public arcTo(x1: number, y1: number, x2: number, y2: number, radius: number) {
		native(this).arcTo(x1, y1, x2, y2, radius)
		return this
	}

	/**
	 * @method isPointInPath
	 * @since 0.4.0
	 */
	public isPointInPath(x: number, y: number) {
		return native(this).isPointInPath(x, y)
	}

	/**
	 * @method scale
	 * @since 0.4.0
	 */
	public scale(x: number, y: number) {
		native(this).scale(x, y)
		return this
	}

	/**
	 * @method rotate
	 * @since 0.4.0
	 */
	public rotate(angle: number) {
		native(this).rotate(angle)
		return this
	}

	/**
	 * @method translate
	 * @since 0.4.0
	 */
	public translate(x: number, y: number) {
		native(this).translate(x, y)
		return this
	}

	/**
	 * @method transform
	 * @since 0.4.0
	 */
	public transform(a: number, b: number, c: number, d: number, e: number, f: number) {
		native(this).transform(a, b, c, d, e, f)
		return this
	}

	/**
	 * @method setTransform
	 * @since 0.4.0
	 */
	public setTransform(a: number, b: number, c: number, d: number, e: number, f: number) {
		native(this).setTransform(a, b, c, d, e, f)
		return this
	}

	/**
	 * @method drawImage
	 * @since 0.4.0
	 */
	public drawImage() {

		/*
		if let image = arguments.getArgument(0).cast(ImageTemplate.self) {

			if (count == 3) {

				let x = CGFloat(callback.argument(0).number)
				let y = CGFloat(callback.argument(1).number)
				let p = CGPoint(x:x, y:y)

				image.image.draw(at:p)


			} else if (count == 5) {

				let x = CGFloat(callback.argument(0).number)
				let y = CGFloat(callback.argument(1).number)
				let w = CGFloat(callback.argument(2).number)
				let h = CGFloat(callback.argument(3).number)
				let r = CGRect(x:x, y:y, width:w, height:h)

				image.image.draw(in:r)

			} else if (count == 8) {

				let sx = CGFloat(callback.argument(0).number)
				let sy = CGFloat(callback.argument(1).number)
				let sw = CGFloat(callback.argument(2).number)
				let sh = CGFloat(callback.argument(3).number)
				let dx = CGFloat(callback.argument(4).number)
				let dy = CGFloat(callback.argument(5).number)
				let dw = CGFloat(callback.argument(6).number)
				let dh = CGFloat(callback.argument(7).number)

				let dr = CGRect(x:dx, y:dy, width:dw, height:dh)
				let sr = CGRect(x:sx, y:sy, width:sw, height:sh)

				UIImage(cgImage:image.image.cgImage!.cropping(to:sr)!).draw(in:dr)
			}
		}
		*/
	}

	/**
	 * @method save
	 * @since 0.4.0
	 */
	public save() {
		native(this).save()
		return this
	}

	/**
	 * @method restore
	 * @since 0.4.0
	 */
	public restore() {
		native(this).restore()
		return this
	}

	/**
	 * @method createLinearGradient
	 * @since 0.4.0
	 */
	public createLinearGradient() {

	}

	/**
	 * @method createRadialGradient
	 * @since 0.4.0
	 */
	public createRadialGradient() {

	}

	/**
	 * @method createPattern
	 * @since 0.4.0
	 */
	public createPattern() {

	}

}
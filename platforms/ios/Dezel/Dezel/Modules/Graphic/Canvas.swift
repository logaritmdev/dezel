/**
 * @class Canvas
 * @since 0.4.0
 */
open class Canvas: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property ctx
	 * @since 0.4.0
	 * @hidden
	 */
	private weak var ctx: CGContext?

	/**
	 * The canvas fill style.
	 * @property fillStyle
	 * @since 0.4.0
	 */
	open var fillStyle: Property = Property(string: "black") {
		willSet {
			self.ctx?.setFillColor(CGColorParse(newValue.string))
		}
	}

	/**
	 * The canvas stroke style.
	 * @property strokeStyle
	 * @since 0.4.0
	 */
	open var strokeStyle: Property = Property(string: "black") {
		willSet {
			self.ctx?.setStrokeColor(CGColorParse(newValue.string))
		}
	}

	/**
	 * The canvas line cap mode.
	 * @property lineCap
	 * @since 0.4.0
	 */
	open var lineCap: Property = Property(string: "butt") {
		willSet {
			switch (newValue.string) {
				case "butt":   self.ctx?.setLineCap(.butt)
				case "round":  self.ctx?.setLineCap(.round)
				case "square": self.ctx?.setLineCap(.square)
				default: break
			}
		}
	}

	/**
	 * The canvas line join mode.
	 * @property lineJoin
	 * @since 0.4.0
	 */
	open var lineJoin: Property = Property(string: "miter") {
		willSet {
			switch (newValue.string) {
				case "miter": self.ctx?.setLineJoin(.miter)
				case "round": self.ctx?.setLineJoin(.round)
				case "bevel": self.ctx?.setLineJoin(.bevel)
				default: break
			}
		}
	}

	/**
	 * The canvas line width.
	 * @property lineWidth
	 * @since 0.4.0
	 */
	open var lineWidth: Property = Property(number: 1.0) {
		willSet {
			self.ctx?.setLineWidth(CGFloat(newValue.number))
		}
	}

	/**
	 * The canvas horizontal shadow offset.
	 * @property shadowOffsetX
	 * @since 0.4.0
	 */
	open var shadowOffsetX: Property = Property(number: 0.0) {
		willSet {
			self.measuredShadowOffset.width = CGFloat(newValue.number)
			self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
		}
	}

	/**
	 * The canvas vertical shadow offset.
	 * @property shadowOffsetY
	 * @since 0.4.0
	 */
	open var shadowOffsetY: Property = Property(number: 0.0) {
		willSet {
			self.measuredShadowOffset.height = CGFloat(newValue.number)
			self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
		}
	}

	/**
	 * The canvas shadow blur.
	 * @property shadowBlur
	 * @since 0.4.0
	 */
	open var shadowBlur: Property = Property(number: 0.0) {
		willSet {
			self.measuredShadowBlur = CGFloat(newValue.number)
			self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
		}
	}

	/**
	 * The canvas shadow color.
	 * @property shadowBlur
	 * @since 0.4.0
	 */
	open var shadowColor: Property = Property(number: 0.0) {
		willSet {
			self.computedShadowColor = CGColorParse(newValue.string)
			self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
		}
	}

	/**
	 * The canvas global alpha.
	 * @property globalAlpha
	 * @since 0.4.0
	 */
	open var globalAlpha: Property = Property(number: 1.0) {
		willSet {
			self.ctx?.setAlpha(CGFloat(newValue.number))
		}
	}

	/**
	 * The canvas global alpha.
	 * @property globalAlpha
	 * @since 0.4.0
	 */
	open var globalCompositeOperation: Property = Property(string: "source-over") {
		willSet {
			switch (newValue.string) {
				case "source-in": self.ctx?.setBlendMode(.sourceIn)
				case "source-out":  self.ctx?.setBlendMode(.sourceOut)
				case "source-over": self.ctx?.setBlendMode(.normal)
				case "source-atop": self.ctx?.setBlendMode(.sourceAtop)
				case "destination-in": self.ctx?.setBlendMode(.destinationIn)
				case "destination-out": self.ctx?.setBlendMode(.destinationOut)
				case "destination-over": self.ctx?.setBlendMode(.destinationOver)
				case "destination-atop": self.ctx?.setBlendMode(.destinationAtop)
				case "lighter": self.ctx?.setBlendMode(.lighten)
				case "darker": self.ctx?.setBlendMode(.darken)
				case "copy": self.ctx?.setBlendMode(.copy)
				default: break
			}
		}
	}

	/**
	 * @property shadowOffset
	 * @since 0.4.0
	 * @hidden
	 */
	private var measuredShadowOffset: CGSize = .zero

	/**
	 * @property shadowBlur
	 * @since 0.4.0
	 * @hidden
	 */
	private var measuredShadowBlur: CGFloat = 0

	/**
	 * @property shadowColor
	 * @since 0.4.0
	 * @hidden
	 */
	private var computedShadowColor: CGColor = .black

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Assigns the context to be used.
	 * @method use
	 * @since 0.4.0
	 */
	open func use(_ context: CGContext?) {
		self.ctx = context
	}

	//--------------------------------------------------------------------------
	// MARK: JS Property
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fillStyle
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_fillStyle(callback: JavaScriptSetterCallback) {
		callback.returns(self.fillStyle)
	}

	/**
	 * @method jsSet_fillStyle
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_fillStyle(callback: JavaScriptSetterCallback) {
		self.fillStyle = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_strokeStyle
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_strokeStyle(callback: JavaScriptSetterCallback) {
		callback.returns(self.strokeStyle)
	}

	/**
	 * @method jsSet_strokeStyle
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_strokeStyle(callback: JavaScriptSetterCallback) {
		self.strokeStyle = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineCap
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_lineCap(callback: JavaScriptSetterCallback) {
		callback.returns(self.lineCap)
	}

	/**
	 * @method jsSet_lineCap
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_lineCap(callback: JavaScriptSetterCallback) {
		self.lineCap = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineJoin
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_lineJoin(callback: JavaScriptSetterCallback) {
		callback.returns(self.lineJoin)
	}

	/**
	 * @method jsSet_lineJoin
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_lineJoin(callback: JavaScriptSetterCallback) {
		self.lineJoin = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineWidth
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_lineWidth(callback: JavaScriptSetterCallback) {
		callback.returns(self.lineWidth)
	}

	/**
	 * @method jsSet_lineWidth
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_lineWidth(callback: JavaScriptSetterCallback) {
		self.lineWidth = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetX
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_shadowOffsetX(callback: JavaScriptSetterCallback) {
		callback.returns(self.shadowOffsetX)
	}

	/**
	 * @method jsSet_shadowOffsetX
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_shadowOffsetX(callback: JavaScriptSetterCallback) {
		self.shadowOffsetX = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffGetY
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_shadowOffGetY(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowOffsetY)
	}

	/**
	 * @method jsSet_shadowOffsetY
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_shadowOffsetY(callback: JavaScriptSetterCallback) {
		self.shadowOffsetY = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowBlur
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_shadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowBlur)
	}

	/**
	 * @method jsSet_shadowBlur
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_shadowBlur(callback: JavaScriptSetterCallback) {
		self.shadowBlur = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowColor
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_shadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowColor)
	}

	/**
	 * @method jsSet_shadowColor
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_shadowColor(callback: JavaScriptSetterCallback) {
		self.shadowColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_globalAlpha
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_globalAlpha(callback: JavaScriptGetterCallback) {
		callback.returns(self.globalAlpha)
	}

	/**
	 * @method jsSet_globalAlpha
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_globalAlpha(callback: JavaScriptSetterCallback) {
		self.globalAlpha = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_globalCompositeOperation
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_globalCompositeOperation(callback: JavaScriptGetterCallback) {
		callback.returns(self.globalCompositeOperation)
	}

	/**
	 * @method jsSet_globalCompositeOperation
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_globalCompositeOperation(callback: JavaScriptSetterCallback) {
		self.globalCompositeOperation = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_rect
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_rect(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		let w = CGFloat(callback.argument(2).number)
		let h = CGFloat(callback.argument(3).number)
		let r = CGRect(x: x, y: y, width: w, height: h)
		self.ctx?.addRect(r)
	}

	/**
	 * @method jsFunction_fillRect
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_fillRect(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		let w = CGFloat(callback.argument(2).number)
		let h = CGFloat(callback.argument(3).number)
		let r = CGRect(x: x, y: y, width: w, height: h)
		self.ctx?.fill(r)
	}

	/**
	 * @method jsFunction_strokeRect
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_strokeRect(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		let w = CGFloat(callback.argument(2).number)
		let h = CGFloat(callback.argument(3).number)
		let r = CGRect(x: x, y: y, width: w, height: h)
		self.ctx?.stroke(r)
	}

	/**
	 * @method jsFunction_clearRect
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_clearRect(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		let w = CGFloat(callback.argument(2).number)
		let h = CGFloat(callback.argument(3).number)
		let r = CGRect(x: x, y: y, width: w, height: h)
		self.ctx?.clear(r)
	}

	/**
	 * @method jsFunction_fill
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_fill(callback: JavaScriptFunctionCallback) {
		self.ctx?.fillPath()
	}

	/**
	 * @method jsFunction_stroke
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_stroke(callback: JavaScriptFunctionCallback) {
		self.ctx?.strokePath()
	}

	/**
	 * @method jsFunction_beginPath
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_beginPath(callback: JavaScriptFunctionCallback) {
		self.ctx?.beginPath()
	}

	/**
	 * @method jsFunction_closePath
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_closePath(callback: JavaScriptFunctionCallback) {
		self.ctx?.closePath()
	}

	/**
	 * @method jsFunction_moveTo
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_moveTo(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		self.ctx?.move(to: CGPoint(x: x, y: y))
	}

	/**
	 * @method jsFunction_lineTo
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_lineTo(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		self.ctx?.addLine(to: CGPoint(x: x, y: y))
	}

	/**
	 * @method jsFunction_clip
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_clip(callback: JavaScriptFunctionCallback) {
		self.ctx?.clip()
	}

	/**
	 * @method jsFunction_quadraticCurveTo
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_quadraticCurveTo(callback: JavaScriptFunctionCallback) {
		let cx = CGFloat(callback.argument(0).number)
		let cy = CGFloat(callback.argument(1).number)
		let x = CGFloat(callback.argument(2).number)
		let y = CGFloat(callback.argument(3).number)
		self.ctx?.addQuadCurve(to: CGPoint(x: x, y: y), control: CGPoint(x: cx, y: cy))
	}

	/**
	 * @method jsFunction_bezierCurveTo
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_bezierCurveTo(callback: JavaScriptFunctionCallback) {
		let c1x = CGFloat(callback.argument(0).number)
		let c1y = CGFloat(callback.argument(1).number)
		let c2x = CGFloat(callback.argument(2).number)
		let c2y = CGFloat(callback.argument(3).number)
		let x = CGFloat(callback.argument(4).number)
		let y = CGFloat(callback.argument(5).number)
		self.ctx?.addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: c1x, y: c1y), control2: CGPoint(x: c2x, y: c2y))
	}

	/**
	 * @method jsFunction_arc
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_arc(callback: JavaScriptFunctionCallback) {

		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		let r = CGFloat(callback.argument(2).number)
		let sa = CGFloat(callback.argument(3).number)
		let ea = CGFloat(callback.argument(4).number)

		var ccw = false

		if (callback.arguments >= 6) {
			ccw = callback.argument(5).boolean
		}

		self.ctx?.addArc(center: CGPoint(x: x, y: y), radius: r, startAngle: sa, endAngle: ea, clockwise: ccw)
	}

	/**
	 * @method jsFunction_arcTo
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_arcTo(callback: JavaScriptFunctionCallback) {
		let x1 = CGFloat(callback.argument(0).number)
		let y1 = CGFloat(callback.argument(1).number)
		let x2 = CGFloat(callback.argument(2).number)
		let y2 = CGFloat(callback.argument(3).number)
		let r = CGFloat(callback.argument(4).number)
		self.ctx?.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x2, y: y2), radius: r)
	}

	/**
	 * @method jsFunction_isPointInPath
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_isPointInPath(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		callback.returns(boolean: self.ctx?.pathContains(CGPoint(x: x, y: y), mode: .eoFill) ?? false)
	}

	/**
	 * @method jsFunction_scale
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_scale(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		self.ctx?.scaleBy(x: x, y: y)
	}

	/**
	 * @method jsFunction_rotate
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_rotate(callback: JavaScriptFunctionCallback) {
		self.ctx?.rotate(by: CGFloat(callback.argument(0).number))
	}

	/**
	 * @method jsFunction_translate
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_translate(callback: JavaScriptFunctionCallback) {
		let x = CGFloat(callback.argument(0).number)
		let y = CGFloat(callback.argument(1).number)
		self.ctx?.translateBy(x: x, y: y)
	}

	/**
	 * @method jsFunction_transform
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_transform(callback: JavaScriptFunctionCallback) {
		let a = CGFloat(callback.argument(0).number)
		let b = CGFloat(callback.argument(1).number)
		let c = CGFloat(callback.argument(2).number)
		let d = CGFloat(callback.argument(3).number)
		let e = CGFloat(callback.argument(4).number)
		let f = CGFloat(callback.argument(5).number)
		let t = CGAffineTransform(a: a, b: b, c: c, d: d, tx: e, ty: f)
		self.ctx?.concatenate(t)
	}

	/**
	 * @method jsFunction_setTransform
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_setTransform(callback: JavaScriptFunctionCallback) {

		let a = CGFloat(callback.argument(0).number)
		let b = CGFloat(callback.argument(1).number)
		let c = CGFloat(callback.argument(2).number)
		let d = CGFloat(callback.argument(3).number)
		let e = CGFloat(callback.argument(4).number)
		let f = CGFloat(callback.argument(5).number)
		let t = CGAffineTransform(a: a, b: b, c: c, d: d, tx: e, ty: f)

		if let reverse = self.ctx?.ctm.inverted() {
			self.ctx?.concatenate(reverse)
			self.ctx?.concatenate(t)
		}
	}

	/**
	 * @method jsFunction_drawImage
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_drawImage(callback: JavaScriptFunctionCallback) {

		/*
		// TODO
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
	 * @method jsFunction_save
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_save(callback: JavaScriptFunctionCallback) {
		self.ctx?.saveGState()
	}

	/**
	 * @method jsFunction_restore
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_restore(callback: JavaScriptFunctionCallback) {
		self.ctx?.restoreGState()
	}
}

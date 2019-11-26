/**
 * @class JavaScriptCanvas
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptCanvas: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property ctx
	 * @since 0.7.0
	 * @hidden
	 */
	private weak var ctx: CGContext?

	/**
	 * @property shadowOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private var measuredShadowOffset: CGSize = .zero

	/**
	 * @property shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	private var measuredShadowBlur: CGFloat = 0

	/**
	 * @property shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	private var computedShadowColor: CGColor = .black

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method use
	 * @since 0.7.0
	 */
	open func use(_ context: CGContext?) {
		self.ctx = context
	}

	//--------------------------------------------------------------------------
	// MARK: JS Property
	//--------------------------------------------------------------------------

	/**
	 * @property fillStyle
	 * @since 0.7.0
	 */
	open lazy var fillStyle = JavaScriptProperty(string: "black") { value in
		self.ctx?.setFillColor(CGColorParse(value.string))
	}

	/**
	 * @property strokeStyle
	 * @since 0.7.0
	 */
	open lazy var strokeStyle = JavaScriptProperty(string: "black") { value in
		self.ctx?.setStrokeColor(CGColorParse(value.string))
	}

	/**
	 * @property lineCap
	 * @since 0.7.0
	 */
	open lazy var lineCap = JavaScriptProperty(string: "butt") { value in
		switch (value.string) {
			case "butt":   self.ctx?.setLineCap(.butt)
			case "round":  self.ctx?.setLineCap(.round)
			case "square": self.ctx?.setLineCap(.square)
			default: break
		}
	}

	/**
	 * @property lineJoin
	 * @since 0.7.0
	 */
	open lazy var lineJoin = JavaScriptProperty(string: "miter") { value in
		switch (value.string) {
			case "miter": self.ctx?.setLineJoin(.miter)
			case "round": self.ctx?.setLineJoin(.round)
			case "bevel": self.ctx?.setLineJoin(.bevel)
			default: break
		}
	}

	/**
	 * @property lineWidth
	 * @since 0.7.0
	 */
	open lazy var lineWidth = JavaScriptProperty(number: 1.0) { value in
		self.ctx?.setLineWidth(CGFloat(value.number))
	}

	/**
	 * @property shadowOffsetX
	 * @since 0.7.0
	 */
	open lazy var shadowOffsetX = JavaScriptProperty(number: 0.0) { value in
		self.measuredShadowOffset.width = CGFloat(value.number)
		self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
	}

	/**
	 * @property shadowOffsetY
	 * @since 0.7.0
	 */
	open lazy var shadowOffsetY = JavaScriptProperty(number: 0.0) { value in
		self.measuredShadowOffset.height = CGFloat(value.number)
		self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
	}

	/**
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	open lazy var shadowBlur = JavaScriptProperty(number: 0.0) { value in
		self.measuredShadowBlur = CGFloat(value.number)
		self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
	}

	/**
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	open lazy var shadowColor = JavaScriptProperty(number: 0.0) { value in
		self.computedShadowColor = CGColorParse(value.string)
		self.ctx?.setShadow(offset: self.measuredShadowOffset, blur: self.measuredShadowBlur, color: self.computedShadowColor)
	}

	/**
	 * @property globalAlpha
	 * @since 0.7.0
	 */
	open lazy var globalAlpha = JavaScriptProperty(number: 1.0) { value in
		self.ctx?.setAlpha(CGFloat(value.number))
	}

	/**
	 * @property globalAlpha
	 * @since 0.7.0
	 */
	open lazy var globalCompositeOperation = JavaScriptProperty(string: "source-over") { value in
		switch (value.string) {
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

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fillStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_fillStyle(callback: JavaScriptSetterCallback) {
		callback.returns(self.fillStyle)
	}

	/**
	 * @method jsSet_fillStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_fillStyle(callback: JavaScriptSetterCallback) {
		self.fillStyle.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_strokeStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_strokeStyle(callback: JavaScriptSetterCallback) {
		callback.returns(self.strokeStyle)
	}

	/**
	 * @method jsSet_strokeStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_strokeStyle(callback: JavaScriptSetterCallback) {
		self.strokeStyle.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineCap
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_lineCap(callback: JavaScriptSetterCallback) {
		callback.returns(self.lineCap)
	}

	/**
	 * @method jsSet_lineCap
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_lineCap(callback: JavaScriptSetterCallback) {
		self.lineCap.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineJoin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_lineJoin(callback: JavaScriptSetterCallback) {
		callback.returns(self.lineJoin)
	}

	/**
	 * @method jsSet_lineJoin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_lineJoin(callback: JavaScriptSetterCallback) {
		self.lineJoin.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_lineWidth(callback: JavaScriptSetterCallback) {
		callback.returns(self.lineWidth)
	}

	/**
	 * @method jsSet_lineWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_lineWidth(callback: JavaScriptSetterCallback) {
		self.lineWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowOffsetX(callback: JavaScriptSetterCallback) {
		callback.returns(self.shadowOffsetX)
	}

	/**
	 * @method jsSet_shadowOffsetX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowOffsetX(callback: JavaScriptSetterCallback) {
		self.shadowOffsetX.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffGetY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowOffGetY(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowOffsetY)
	}

	/**
	 * @method jsSet_shadowOffsetY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowOffsetY(callback: JavaScriptSetterCallback) {
		self.shadowOffsetY.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowBlur)
	}

	/**
	 * @method jsSet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowBlur(callback: JavaScriptSetterCallback) {
		self.shadowBlur.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowColor)
	}

	/**
	 * @method jsSet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowColor(callback: JavaScriptSetterCallback) {
		self.shadowColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_globalAlpha
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_globalAlpha(callback: JavaScriptGetterCallback) {
		callback.returns(self.globalAlpha)
	}

	/**
	 * @method jsSet_globalAlpha
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_globalAlpha(callback: JavaScriptSetterCallback) {
		self.globalAlpha.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_globalCompositeOperation
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_globalCompositeOperation(callback: JavaScriptGetterCallback) {
		callback.returns(self.globalCompositeOperation)
	}

	/**
	 * @method jsSet_globalCompositeOperation
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_globalCompositeOperation(callback: JavaScriptSetterCallback) {
		self.globalCompositeOperation.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_rect
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_rect(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptCanvas.rect' requires 4 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number
		let w = callback.argument(2).number
		let h = callback.argument(3).number

		self.ctx?.addRect(CGRect(x: x, y: y, width: w, height: h))
	}

	/**
	 * @method jsFunction_fillRect
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_fillRect(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptCanvas.fillRect() requires 4 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number
		let w = callback.argument(2).number
		let h = callback.argument(3).number

		self.ctx?.fill(CGRect(x: x, y: y, width: w, height: h))
	}

	/**
	 * @method jsFunction_strokeRect
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_strokeRect(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptCanvas.strokeRect() requires 4 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number
		let w = callback.argument(2).number
		let h = callback.argument(3).number

		self.ctx?.stroke(CGRect(x: x, y: y, width: w, height: h))
	}

	/**
	 * @method jsFunction_clearRect
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_clearRect(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptCanvas.clearRect() requires 4 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number
		let w = callback.argument(2).number
		let h = callback.argument(3).number

		self.ctx?.clear(CGRect(x: x, y: y, width: w, height: h))
	}

	/**
	 * @method jsFunction_fill
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_fill(callback: JavaScriptFunctionCallback) {
		self.ctx?.fillPath()
	}

	/**
	 * @method jsFunction_stroke
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_stroke(callback: JavaScriptFunctionCallback) {
		self.ctx?.strokePath()
	}

	/**
	 * @method jsFunction_beginPath
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_beginPath(callback: JavaScriptFunctionCallback) {
		self.ctx?.beginPath()
	}

	/**
	 * @method jsFunction_closePath
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_closePath(callback: JavaScriptFunctionCallback) {
		self.ctx?.closePath()
	}

	/**
	 * @method jsFunction_moveTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_moveTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptCanvas.moveTo() requires 2 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number

		self.ctx?.move(to: CGPoint(x: x, y: y))
	}

	/**
	 * @method jsFunction_lineTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_lineTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptCanvas.lineTo() requires 2 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number

		self.ctx?.addLine(to: CGPoint(x: x, y: y))
	}

	/**
	 * @method jsFunction_clip
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_clip(callback: JavaScriptFunctionCallback) {
		self.ctx?.clip()
	}

	/**
	 * @method jsFunction_quadraticCurveTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_quadraticCurveTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptCanvas.quadraticCurveTo() requires 4 arguments.")
		}

		let cx = callback.argument(0).number
		let cy = callback.argument(1).number
		let x  = callback.argument(2).number
		let y  = callback.argument(3).number

		self.ctx?.addQuadCurve(to: CGPoint(x: x, y: y), control: CGPoint(x: cx, y: cy))
	}

	/**
	 * @method jsFunction_bezierCurveTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_bezierCurveTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptCanvas.bezierCurveTo() requires 6 arguments.")
		}

		let c1x = callback.argument(0).number
		let c1y = callback.argument(1).number
		let c2x = callback.argument(2).number
		let c2y = callback.argument(3).number
		let x   = callback.argument(4).number
		let y   = callback.argument(5).number

		self.ctx?.addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: c1x, y: c1y), control2: CGPoint(x: c2x, y: c2y))
	}

	/**
	 * @method jsFunction_arc
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_arc(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 6) {
			fatalError("Method JavaScriptCanvas.arc() requires 6 arguments.")
		}

		let x   = callback.argument(0).number
		let y   = callback.argument(1).number
		let r   = callback.argument(2).number
		let sa  = callback.argument(3).number
		let ea  = callback.argument(4).number
		let ccw = callback.argument(5).boolean

		self.ctx?.addArc(center: CGPoint(x: x, y: y), radius: CGFloat(r), startAngle: CGFloat(sa), endAngle: CGFloat(ea), clockwise: ccw)
	}

	/**
	 * @method jsFunction_arcTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_arcTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 6) {
			fatalError("Method JavaScriptCanvas.arcTo() requires 6 arguments.")
		}

		let x1 = callback.argument(0).number
		let y1 = callback.argument(1).number
		let x2 = callback.argument(2).number
		let y2 = callback.argument(3).number
		let r  = callback.argument(4).number

		self.ctx?.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x2, y: y2), radius: CGFloat(r))
	}

	/**
	 * @method jsFunction_isPointInPath
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_isPointInPath(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptCanvas.isPointInPath() requires 2 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number

		callback.returns(self.ctx?.pathContains(CGPoint(x: x, y: y), mode: .eoFill) ?? false)
	}

	/**
	 * @method jsFunction_scale
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_scale(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptCanvas.scale() requires 2 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number

		self.ctx?.scaleBy(x: CGFloat(x), y: CGFloat(y))
	}

	/**
	 * @method jsFunction_rotate
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_rotate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptCanvas.rotate() requires 1 argument.")
		}

		self.ctx?.rotate(by: CGFloat(callback.argument(0).number))
	}

	/**
	 * @method jsFunction_translate
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_translate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptCanvas.translate() requires 2 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number

		self.ctx?.translateBy(x: CGFloat(x), y: CGFloat(y))
	}

	/**
	 * @method jsFunction_transform
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_transform(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 6) {
			fatalError("Method JavaScriptCanvas.translate() requires 6 arguments.")
		}

		let a = callback.argument(0).number
		let b = callback.argument(1).number
		let c = callback.argument(2).number
		let d = callback.argument(3).number
		let e = callback.argument(4).number
		let f = callback.argument(5).number

		self.ctx?.concatenate(CGAffineTransform(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(e), ty: CGFloat(f)))
	}

	/**
	 * @method jsFunction_setTransform
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_setTransform(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 6) {
			fatalError("Method JavaScriptCanvas.setTransform() requires 6 arguments.")
		}

		let a = callback.argument(0).number
		let b = callback.argument(1).number
		let c = callback.argument(2).number
		let d = callback.argument(3).number
		let e = callback.argument(4).number
		let f = callback.argument(5).number

		let t = CGAffineTransform(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(e), ty: CGFloat(f))

		if let reverse = self.ctx?.ctm.inverted() {
			self.ctx?.concatenate(reverse)
			self.ctx?.concatenate(t)
		}
	}

	/**
	 * @method jsFunction_drawImage
	 * @since 0.7.0
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
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_save(callback: JavaScriptFunctionCallback) {
		self.ctx?.saveGState()
	}

	/**
	 * @method jsFunction_restore
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_restore(callback: JavaScriptFunctionCallback) {
		self.ctx?.restoreGState()
	}
}

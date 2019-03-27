/**
 * @extension CGMutablePath
 * @since 0.1.0
 * @hidden
 */
internal extension CGMutablePath {

	/**
	 * @method addRoundedRect
	 * @since 0.1.0
	 * @hidden
	 */
	func addRoundedRect(_ rect: CGRect, _ radiuses: [CGFloat]) {

		let radiusTRX = radiuses[0]
		let radiusTRY = radiuses[1]
		let radiusBRX = radiuses[2]
		let radiusBRY = radiuses[3]
		let radiusBLX = radiuses[4]
		let radiusBLY = radiuses[5]
		let radiusTLX = radiuses[6]
		let radiusTLY = radiuses[7]

		let rectX = rect.origin.x
		let rectY = rect.origin.y
		let rectW = rect.size.width
		let rectH = rect.size.height

		self.move(to: CGPoint(x: rectX + radiusTLX, y: rectY))

		self.addLine(to: CGPoint(x: rectX + rectW - radiusTRX, y: rectY))
		self.addRoundedCorner(rectX + rectW, rectY, rectX + rectW, rectY + radiusTRY, radiusTRX, radiusTRY)
		self.addLine(to: CGPoint(x: rectX + rectW, y: rectY + rectH - radiusBRY))
		self.addRoundedCorner(rectX + rectW, rectY + rectH, rectX + rectW - radiusBRX, rectY + rectH, radiusBRX, radiusBRY)
		self.addLine(to: CGPoint(x: rectX + radiusBLX, y: rectY + rectH))
		self.addRoundedCorner(rectX, rectY + rectH, rectX, rectY + rectH - radiusBLY, radiusBLX, radiusBLY)
		self.addLine(to: CGPoint(x: rectX, y: rectY + radiusTLY))
		self.addRoundedCorner(rectX, rectY, rectX + radiusTLX, rectY, radiusTLX, radiusTLY)
	}

	/**
	 * @method addRoundedCorner
	 * @since 0.1.0
	 * @hidden
	 */
	func addRoundedCorner( _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ r1: CGFloat, _ r2: CGFloat) {

		if (r1 == r2) {
			self.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x2, y: y2), radius: r1)
			return
		}

		self.addQuadCurve(to: CGPoint(x: x1, y: y1), control: CGPoint(x: x2, y: y2))
	}
}

/**
 * @function CGOuterRoundedRectPath
 * @since 0.1.0
 * @hidden
 */
internal func CGOuterRoundedRectPath(_ w: CGFloat, _ h: CGFloat, _ radiusTL: CGFloat, _ radiusTR: CGFloat, _ radiusBL: CGFloat, _ radiusBR: CGFloat) -> CGPath {

	let path = CGMutablePath()
	let rect = CGRect(x: 0, y: 0, width: w, height: h)

	if (radiusTL == 0 && radiusTR == 0 &&
		radiusBL == 0 && radiusBR == 0) {

		path.addRect(rect)

	} else {

		path.addRoundedRect(rect, [
			radiusTR, radiusTR,
			radiusBR, radiusBR,
			radiusBL, radiusBL,
			radiusTL, radiusTL
		])

	}

	return path
}

/**
 * @function CGInnerRoundedRectPath
 * @since 0.1.0
 * @hidden
 */
internal func CGInnerRoundedRectPath(_ w: CGFloat, _ h: CGFloat, _ radiusTL: CGPoint, _ radiusTR: CGPoint, _ radiusBL: CGPoint, _ radiusBR: CGPoint, _ borderT: CGFloat, _ borderL: CGFloat, _ borderR: CGFloat, _ borderB: CGFloat) -> CGPath {

	let path = CGMutablePath()
	let rect = CGRect(
		x: borderL,
		y: borderT,
		width:  w - borderL - borderR,
		height: h - borderT - borderB
	)

	if (radiusTL == .zero && radiusTR == .zero &&
		radiusBL == .zero && radiusBR == .zero) {

		path.addRect(rect)

	} else {

		path.addRoundedRect(rect, [
			radiusTR.x, radiusTR.y,
			radiusBR.x, radiusBR.y,
			radiusBL.x, radiusBL.y,
			radiusTL.x, radiusTL.y
		])

	}

	return path
}

/**
 * @function CGMutablePathCreateWithRect
 * @since 0.5.0
 * @hidden
 */
internal func CGMutablePathCreateWithRect(_ rect: CGRect) -> CGMutablePath {
	let path = CGMutablePath()
	path.addRect(rect)
	return path
}

/**
 * @function CGMutablePathCreateWithSize
 * @since 0.5.0
 * @hidden
 */
internal func CGMutablePathCreateWithSize(_ size: CGSize) -> CGMutablePath {
	return CGMutablePathCreateWithRect(CGRect(origin: .zero, size: size))
}

private let colors = [
	"aliceblue": "#f0f8ff",
	"antiquewhite": "#faebd7",
	"aqua": "#00ffff",
	"aquamarine": "#7fffd4",
	"azure": "#f0ffff",
	"beige": "#f5f5dc",
	"bisque": "#ffe4c4",
	"black": "#000000",
	"blanchedalmond": "#ffebcd",
	"blue": "#0000ff",
	"blueviolet": "#8a2be2",
	"brown": "#a52a2a",
	"burlywood": "#deb887",
	"cadetblue": "#5f9ea0",
	"chartreuse": "#7fff00",
	"chocolate": "#d2691e",
	"coral": "#ff7f50",
	"cornflowerblue": "#6495ed",
	"cornsilk": "#fff8dc",
	"crimson": "#dc143c",
	"cyan": "#00ffff",
	"darkblue": "#00008b",
	"darkcyan": "#008b8b",
	"darkgoldenrod": "#b8860b",
	"darkgray": "#a9a9a9",
	"darkgreen": "#006400",
	"darkgrey": "#a9a9a9",
	"darkkhaki": "#bdb76b",
	"darkmagenta": "#8b008b",
	"darkolivegreen": "#556b2f",
	"darkorange": "#ff8c00",
	"darkorchid": "#9932cc",
	"darkred": "#8b0000",
	"darksalmon": "#e9967a",
	"darkseagreen": "#8fbc8f",
	"darkslateblue": "#483d8b",
	"darkslategray": "#2f4f4f",
	"darkslategrey": "#2f4f4f",
	"darkturquoise": "#00ced1",
	"darkviolet": "#9400d3",
	"deeppink": "#ff1493",
	"deepskyblue": "#00bfff",
	"dimgray": "#696969",
	"dimgrey": "#696969",
	"dodgerblue": "#1e90ff",
	"firebrick": "#b22222",
	"floralwhite": "#fffaf0",
	"forestgreen": "#228b22",
	"fuchsia": "#ff00ff",
	"gainsboro": "#dcdcdc",
	"ghostwhite": "#f8f8ff",
	"gold": "#ffd700",
	"goldenrod": "#daa520",
	"gray": "#808080",
	"green": "#008000",
	"greenyellow": "#adff2f",
	"grey": "#808080",
	"honeydew": "#f0fff0",
	"hotpink": "#ff69b4",
	"indianred": "#cd5c5c",
	"indigo": "#4b0082",
	"ivory": "#fffff0",
	"khaki": "#f0e68c",
	"lavender": "#e6e6fa",
	"lavenderblush": "#fff0f5",
	"lawngreen": "#7cfc00",
	"lemonchiffon": "#fffacd",
	"lightblue": "#add8e6",
	"lightcoral": "#f08080",
	"lightcyan": "#e0ffff",
	"lightgoldenrodyellow": "#fafad2",
	"lightgray": "#d3d3d3",
	"lightgreen": "#90ee90",
	"lightgrey": "#d3d3d3",
	"lightpink": "#ffb6c1",
	"lightsalmon": "#ffa07a",
	"lightseagreen": "#20b2aa",
	"lightskyblue": "#87cefa",
	"lightslategray": "#778899",
	"lightslategrey": "#778899",
	"lightsteelblue": "#b0c4de",
	"lightyellow": "#ffffe0",
	"lime": "#00ff00",
	"limegreen": "#32cd32",
	"linen": "#faf0e6",
	"magenta": "#ff00ff",
	"maroon": "#800000",
	"mediumaquamarine": "#66cdaa",
	"mediumblue": "#0000cd",
	"mediumorchid": "#ba55d3",
	"mediumpurple": "#9370db",
	"mediumseagreen": "#3cb371",
	"mediumslateblue": "#7b68ee",
	"mediumspringgreen": "#00fa9a",
	"mediumturquoise": "#48d1cc",
	"mediumvioletred": "#c71585",
	"midnightblue": "#191970",
	"mintcream": "#f5fffa",
	"mistyrose": "#ffe4e1",
	"moccasin": "#ffe4b5",
	"navajowhite": "#ffdead",
	"navy": "#000080",
	"oldlace": "#fdf5e6",
	"olive": "#808000",
	"olivedrab": "#6b8e23",
	"orange": "#ffa500",
	"orangered": "#ff4500",
	"orchid": "#da70d6",
	"palegoldenrod": "#eee8aa",
	"palegreen": "#98fb98",
	"paleturquoise": "#afeeee",
	"palevioletred": "#db7093",
	"papayawhip": "#ffefd5",
	"peachpuff": "#ffdab9",
	"peru": "#cd853f",
	"pink": "#ffc0cb",
	"plum": "#dda0dd",
	"powderblue": "#b0e0e6",
	"purple": "#800080",
	"red": "#ff0000",
	"rosybrown": "#bc8f8f",
	"royalblue": "#4169e1",
	"saddlebrown": "#8b4513",
	"salmon": "#fa8072",
	"sandybrown": "#f4a460",
	"seagreen": "#2e8b57",
	"seashell": "#fff5ee",
	"sienna": "#a0522d",
	"silver": "#c0c0c0",
	"skyblue": "#87ceeb",
	"slateblue": "#6a5acd",
	"slategray": "#708090",
	"slategrey": "#708090",
	"snow": "#fffafa",
	"springgreen": "#00ff7f",
	"steelblue": "#4682b4",
	"tan": "#d2b48c",
	"teal": "#008080",
	"thistle": "#d8bfd8",
	"tomato": "#ff6347",
	"turquoise": "#40e0d0",
	"violet": "#ee82ee",
	"wheat": "#f5deb3",
	"white": "#ffffff",
	"whitesmoke": "#f5f5f5",
	"yellow": "#ffff00",
	"yellowgreen": "#9acd32"
]

/**
 * @function CGColorParse
 * @since 0.1.0
 * @hidden
 */
internal func CGColorParse(_ color: String) -> CGColor {

	var col = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()

	if (col == "transparent" || col == "none") {
		return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 0.0])!
	}

	if (col == "random") {
		col = Array(colors.values)[Int(arc4random_uniform(UInt32(colors.values.count)))]
	}

	let hex = colors[col]
	if (hex != nil) {
		return CGColorParseHexString(hex!)
	}

	if (col.hasPrefix("rgba")) {
		return CGColorParseRGBAString(col)
	}

	if (col.hasPrefix("rgb")) {
		return CGColorParseRGBString(col)
	}

	if (col.hasPrefix("#")) {
		return CGColorParseHexString(col)
	}

	return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])!
}

/**
 * @function CGColorParseHexString
 * @since 0.1.0
 * @hidden
 */
internal func CGColorParseHexString(_ color: String) -> CGColor {
	let hex = String(color.dropFirst())
	if (hex.length == 3) { return CGColorScanHexString(Scanner(string: color + hex)) }
	if (hex.length == 6) { return CGColorScanHexString(Scanner(string: color)) }
	return CGColor.black
}

/**
 * @function CGColorParseRGBString
 * @since 0.1.0
 * @hidden
 */
internal func CGColorParseRGBString(_ color: String) -> CGColor {
	return CGColorScanRGBString(Scanner(string: color))
}

/**
 * @function CGColorParseRGBAString
 * @since 0.1.0
 * @hidden
 */
internal func CGColorParseRGBAString(_ color: String) -> CGColor {
	return CGColorScanRGBAString(Scanner(string: color))
}

/**
 * @function CGColorScanName
 * @since 0.4.0
 * @hidden
 */
internal func CGColorScanName(_ scanner: Scanner) -> CGColor {

	if let color = scanner.scanCharacters(from: CharacterSet.alphanumerics) {
		return CGColorParse(color)
	}

	return CGColor.black
}

/**
 * @function CGColorScanHexString
 * @since 0.4.0
 * @hidden
 */
internal func CGColorScanHexString(_ scanner: Scanner) -> CGColor {

	scanner.scanString("#", into: nil)

	var hex: UInt32 = 0

	if scanner.scanHexInt32(&hex) {

		let r = hex >> 16 & 0x000000FF
		let g = hex >> 8  & 0x000000FF
		let b = hex       & 0x000000FF

		return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [
			CGFloat(UInt(r)) / CGFloat(255.0),
			CGFloat(UInt(g)) / CGFloat(255.0),
			CGFloat(UInt(b)) / CGFloat(255.0),
			1.0
		])!
	}

	return CGColor.black
}

/**
 * @function CGColorScanRGBString
 * @since 0.4.0
 * @hidden
 */
internal func CGColorScanRGBString(_ scanner: Scanner) -> CGColor {

	var r: CInt = 0
	var g: CInt = 0
	var b: CInt = 0

	scanner.charactersToBeSkipped = CharacterSet(charactersIn: "\n, ")
	scanner.scanString("rgb(", into: nil)
	scanner.scanInt32(&r)
	scanner.scanInt32(&g)
	scanner.scanInt32(&b)
	scanner.scanString(")", into: nil)

	return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [
		CGFloat(UInt(r)) / CGFloat(255.0),
		CGFloat(UInt(g)) / CGFloat(255.0),
		CGFloat(UInt(b)) / CGFloat(255.0),
		1.0
	])!
}

/**
 * @function CGColorScanRGBAString
 * @since 0.1.0
 * @hidden
 */
internal func CGColorScanRGBAString(_ scanner: Scanner) -> CGColor {

	var r: CInt = 0
	var g: CInt = 0
	var b: CInt = 0
	var a: CFloat = 0

	scanner.charactersToBeSkipped = CharacterSet(charactersIn: "\n, ")
	scanner.scanString("rgba(", into: nil)
	scanner.scanInt32(&r)
	scanner.scanInt32(&g)
	scanner.scanInt32(&b)
	scanner.scanFloat(&a)
	scanner.scanString(")", into: nil)

	return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [
		CGFloat(UInt(r)) / CGFloat(255.0),
		CGFloat(UInt(g)) / CGFloat(255.0),
		CGFloat(UInt(b)) / CGFloat(255.0),
		CGFloat(a)
	])!
}

/**
 * @function CGColorCreateRGBA
 * @since 0.1.0
 * @hidden
 */
internal func CGColorCreateRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> CGColor {
	return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [
		CGFloat(UInt(r)) / CGFloat(255.0),
		CGFloat(UInt(g)) / CGFloat(255.0),
		CGFloat(UInt(b)) / CGFloat(255.0),
		a
	])!
}

public func == (left: CGColor, right: CGColor) -> Bool {

	let lc = left.numberOfComponents
	let rc = right.numberOfComponents
	if (lc != rc) {
		return false
	}

	if (lc == 4 && rc == 4) {

		let lcols = left.components
		let rcols = right.components

		return (
			lcols![0] == rcols![0] &&
			lcols![1] == rcols![1] &&
			lcols![2] == rcols![2] &&
			lcols![3] == rcols![3]
		)
	}

	return false
}

public func != (left: CGColor, right: CGColor) -> Bool {

	let lc = left.numberOfComponents
	let rc = right.numberOfComponents
	if (lc != rc) {
		return true
	}

	if (lc == 4 && rc == 4) {

		let lcols = left.components
		let rcols = right.components

		return (
			lcols![0] != rcols![0] ||
			lcols![1] != rcols![1] ||
			lcols![2] != rcols![2] ||
			lcols![3] != rcols![3]
		)
	}

	return true
}

/**
 * @extension CGColor
 * @since 0.1.0
 * @hidden
 */
public extension CGColor {

	/**
	 * @property white
	 * @since 0.1.0
	 * @hidden
	 */
	internal static var white: CGColor {
		get {
			return CGColorCreateRGBA(r: 255, g: 255, b: 255, a: 1)
		}
	}

	/**
	 * @property black
	 * @since 0.1.0
	 * @hidden
	 */
	internal static var black: CGColor {
		get {
			return CGColorCreateRGBA(r: 0, g: 0, b: 0, a: 1)
		}
	}

	/**
	 * @property transparent
	 * @since 0.1.0
	 * @hidden
	 */
	internal static var transparent: CGColor {
		get {
			return CGColorCreateRGBA(r: 0, g: 0, b: 0, a: 0)
		}
	}
}

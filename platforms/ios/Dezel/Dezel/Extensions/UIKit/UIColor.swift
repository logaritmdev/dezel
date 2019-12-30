/**
 * @extension UIFont
 * @since 0.1.0
 * @hidden
 */
public extension UIColor {

	/**
	 * @property alpha
	 * @since 0.5.0
	 * @hidden
	 */
	var alpha: CGFloat {
		return self.cgColor.alpha
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init?(color: CGColor?) {

		if let color = color {
			self.init(cgColor: color)
		}

		return nil
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(color: UInt32) {

		let a = (color >> 24) & 0x000000FF
		let r = (color >> 16) & 0x000000FF
		let g = (color >> 8)  & 0x000000FF
		let b = (color)       & 0x000000FF

		self.init(r: r, g: g, b: b, a: a)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(color: String) {

		let color = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

		if (color == "none" ||
			color == "transparent") {
			self.init(r: 0, g: 0, b: 0, a: 0)
			return
		}

		if let color = cache[color] {
			self.init(color: color)
			return
		}

		if let named = names[color] {
			self.init(color: named)
			return
		}

		var value: UInt32 = 0

        let scanner = Scanner(string: color)
		scanner.scanLocation = 1
		scanner.scanHexInt32(&value)

		switch (color.length - 1) {

			case 3 :

				var color = UInt32(0xFF000000)
				color |= UInt32((value & 0xF00) << 12)
				color |= UInt32((value & 0xF00) << 8)
				color |= UInt32((value & 0xF0)  << 8)
				color |= UInt32((value & 0xF0)  << 4)
				color |= UInt32((value & 0xF)   << 4)
				color |= UInt32((value & 0xF))

				self.init(color: color)
				return

			case 4:

				var color = UInt32(0)
				color |= (value & 0xF)    << 28
				color |= (value & 0xF)    << 24
				color |= (value & 0xF000) << 8
				color |= (value & 0xF000) << 4
				color |= (value & 0xF00)  << 4
				color |= (value & 0xF00)
				color |= (value & 0xF0)
				color |= (value & 0xF0)   >> 4

				self.init(color: color)
				return

			case 6:
				self.init(color: value | 0xFF000000)
				return

			case 8:
				self.init(color: value)
				return

			default:
				break
		}

		fatalError("Invalid hex color \(color)")
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(color: JavaScriptProperty) {

		if let function = color.function {
			self.init(color: function)
			return
		}

		self.init(color: color.string)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(color: JavaScriptPropertyValue) {

		if let functions = color as? JavaScriptPropertyFunctionValue {

			if (functions.name == "rgb") {

				assert(functions.arguments.count == 3)

				let r = functions.arguments[0].number
				let g = functions.arguments[1].number
				let b = functions.arguments[2].number

				self.init(r: r, g: g, b: b, a: 255)
				return
			}

			if (functions.name == "rgba") {

				assert(functions.arguments.count == 4)

				let r = functions.arguments[0].number
				let g = functions.arguments[1].number
				let b = functions.arguments[2].number
				let a = functions.arguments[3].number

				self.init(r: r, g: g, b: b, a: a * 255)
				return
			}
		}

		self.init(color: color.string)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(color: UIColor) {

		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0

		color.getRed(&r, green: &g, blue: &b, alpha: &a)

		self.init(red: r, green: g, blue: b, alpha: a)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(r: Int, g: Int, b: Int, a: Int) {

		let r = CGFloat(r) / 255.0
		let g = CGFloat(g) / 255.0
		let b = CGFloat(b) / 255.0
		let a = CGFloat(a) / 255.0

		self.init(red: r, green: g, blue: b, alpha: a)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(r: UInt32, g: UInt32, b: UInt32, a: UInt32) {

		let r = CGFloat(r) / 255.0
		let g = CGFloat(g) / 255.0
		let b = CGFloat(b) / 255.0
		let a = CGFloat(a) / 255.0

		self.init(red: r, green: g, blue: b, alpha: a)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	convenience init(r: Double, g: Double, b: Double, a: Double) {

		let r = CGFloat(r / 255.0)
		let g = CGFloat(g / 255.0)
		let b = CGFloat(b / 255.0)
		let a = CGFloat(a / 255.0)

		self.init(red: r, green: g, blue: b, alpha: a)
	}
}

/**
* @const cache
* @sinne 0.7.0
*/
private let cache: [String: UIColor] = [:]

/**
 * @const names
 * @sinne 0.7.0
 */
private let names: [String: UInt32] = [
	"aliceblue": 0xfff0f8ff,
	"antiquewhite": 0xfffaebd7,
	"aqua": 0xff00ffff,
	"aquamarine": 0xff7fffd4,
	"azure": 0xfff0ffff,
	"beige": 0xfff5f5dc,
	"bisque": 0xffffe4c4,
	"black": 0xff000000,
	"blanchedalmond": 0xffffebcd,
	"blue": 0xff0000ff,
	"blueviolet": 0xff8a2be2,
	"brown": 0xffa52a2a,
	"burlywood": 0xffdeb887,
	"cadetblue": 0xff5f9ea0,
	"chartreuse": 0xff7fff00,
	"chocolate": 0xffd2691e,
	"coral": 0xffff7f50,
	"cornflowerblue": 0xff6495ed,
	"cornsilk": 0xfffff8dc,
	"crimson": 0xffdc143c,
	"cyan": 0xff00ffff,
	"darkblue": 0xff00008b,
	"darkcyan": 0xff008b8b,
	"darkgoldenrod": 0xffb8860b,
	"darkgray": 0xffa9a9a9,
	"darkgreen": 0xff006400,
	"darkgrey": 0xffa9a9a9,
	"darkkhaki": 0xffbdb76b,
	"darkmagenta": 0xff8b008b,
	"darkolivegreen": 0xff556b2f,
	"darkorange": 0xffff8c00,
	"darkorchid": 0xff9932cc,
	"darkred": 0xff8b0000,
	"darksalmon": 0xffe9967a,
	"darkseagreen": 0xff8fbc8f,
	"darkslateblue": 0xff483d8b,
	"darkslategray": 0xff2f4f4f,
	"darkslategrey": 0xff2f4f4f,
	"darkturquoise": 0xff00ced1,
	"darkviolet": 0xff9400d3,
	"deeppink": 0xffff1493,
	"deepskyblue": 0xff00bfff,
	"dimgray": 0xff696969,
	"dimgrey": 0xff696969,
	"dodgerblue": 0xff1e90ff,
	"firebrick": 0xffb22222,
	"floralwhite": 0xfffffaf0,
	"forestgreen": 0xff228b22,
	"fuchsia": 0xffff00ff,
	"gainsboro": 0xffdcdcdc,
	"ghostwhite": 0xfff8f8ff,
	"gold": 0xffffd700,
	"goldenrod": 0xffdaa520,
	"gray": 0xff808080,
	"green": 0xff008000,
	"greenyellow": 0xffadff2f,
	"grey": 0xff808080,
	"honeydew": 0xfff0fff0,
	"hotpink": 0xffff69b4,
	"indianred": 0xffcd5c5c,
	"indigo": 0xff4b0082,
	"ivory": 0xfffffff0,
	"khaki": 0xfff0e68c,
	"lavender": 0xffe6e6fa,
	"lavenderblush": 0xfffff0f5,
	"lawngreen": 0xff7cfc00,
	"lemonchiffon": 0xfffffacd,
	"lightblue": 0xffadd8e6,
	"lightcoral": 0xfff08080,
	"lightcyan": 0xffe0ffff,
	"lightgoldenrodyellow": 0xfffafad2,
	"lightgray": 0xffd3d3d3,
	"lightgreen": 0xff90ee90,
	"lightgrey": 0xffd3d3d3,
	"lightpink": 0xffffb6c1,
	"lightsalmon": 0xffffa07a,
	"lightseagreen": 0xff20b2aa,
	"lightskyblue": 0xff87cefa,
	"lightslategray": 0xff778899,
	"lightslategrey": 0xff778899,
	"lightsteelblue": 0xffb0c4de,
	"lightyellow": 0xffffffe0,
	"lime": 0xff00ff00,
	"limegreen": 0xff32cd32,
	"linen": 0xfffaf0e6,
	"magenta": 0xffff00ff,
	"maroon": 0xff800000,
	"mediumaquamarine": 0xff66cdaa,
	"mediumblue": 0xff0000cd,
	"mediumorchid": 0xffba55d3,
	"mediumpurple": 0xff9370db,
	"mediumseagreen": 0xff3cb371,
	"mediumslateblue": 0xff7b68ee,
	"mediumspringgreen": 0xff00fa9a,
	"mediumturquoise": 0xff48d1cc,
	"mediumvioletred": 0xffc71585,
	"midnightblue": 0xff191970,
	"mintcream": 0xfff5fffa,
	"mistyrose": 0xffffe4e1,
	"moccasin": 0xffffe4b5,
	"navajowhite": 0xffffdead,
	"navy": 0xff000080,
	"oldlace": 0xfffdf5e6,
	"olive": 0xff808000,
	"olivedrab": 0xff6b8e23,
	"orange": 0xffffa500,
	"orangered": 0xffff4500,
	"orchid": 0xffda70d6,
	"palegoldenrod": 0xffeee8aa,
	"palegreen": 0xff98fb98,
	"paleturquoise": 0xffafeeee,
	"palevioletred": 0xffdb7093,
	"papayawhip": 0xffffefd5,
	"peachpuff": 0xffffdab9,
	"peru": 0xffcd853f,
	"pink": 0xffffc0cb,
	"plum": 0xffdda0dd,
	"powderblue": 0xffb0e0e6,
	"purple": 0xff800080,
	"red": 0xffff0000,
	"rosybrown": 0xffbc8f8f,
	"royalblue": 0xff4169e1,
	"saddlebrown": 0xff8b4513,
	"salmon": 0xfffa8072,
	"sandybrown": 0xfff4a460,
	"seagreen": 0xff2e8b57,
	"seashell": 0xfffff5ee,
	"sienna": 0xffa0522d,
	"silver": 0xffc0c0c0,
	"skyblue": 0xff87ceeb,
	"slateblue": 0xff6a5acd,
	"slategray": 0xff708090,
	"slategrey": 0xff708090,
	"snow": 0xfffffafa,
	"springgreen": 0xff00ff7f,
	"steelblue": 0xff4682b4,
	"tan": 0xffd2b48c,
	"teal": 0xff008080,
	"thistle": 0xffd8bfd8,
	"tomato": 0xffff6347,
	"turquoise": 0xff40e0d0,
	"violet": 0xffee82ee,
	"wheat": 0xfff5deb3,
	"white": 0xffffffff,
	"whitesmoke": 0xfff5f5f5,
	"yellow": 0xffffff00,
	"yellowgreen": 0xff9acd32
]


import Foundation

/**
* @class JavaScriptBuilder
* @since 0.1.0
* @hidden
*/
open class JavaScriptBuilder {

	/**
	* @enum Type
	* @since 0.1.0
	* @hidden
	*/
	internal enum `Type` {
		case staticFunction
		case staticGetter
		case staticSetter
		case function
		case getter
		case setter
	}

	/**
	* @alias ForEachCallback
	* @since 0.1.0
	* @hidden
	*/
	internal typealias ForEachCallback = (_ name: String, _ type: Type, _ sel: Selector, _ imp: IMP) -> Void

	/**
	* @method forEach
	* @since 0.1.0
	* @hidden
	*/
	internal class func forEach(_ from: AnyClass, callback: ForEachCallback) {

		var processed = [String: Bool]()

		var clazz: AnyClass = from

		while (true) {

			var count = UInt32(0)
			let items = objc_getMethods(clazz, &count)

			for i in 0 ..< Int(count) {

				let sel = method_getName((items?[i])!)
				let imp = method_getImplementation((items?[i])!)
				let name = NSStringFromSelector(sel)

				let isFunction = name.hasPrefix("jsFunction")
				let isGetter = name.hasPrefix("jsGet")
				let isSetter = name.hasPrefix("jsSet")

				let isStaticFunction = name.hasPrefix("jsStaticFunction")
				let isStaticGetter = name.hasPrefix("jsStaticGet")
				let isStaticSetter = name.hasPrefix("jsStaticSet")

				if (isFunction == false &&
					isGetter == false &&
					isSetter == false &&
					isStaticFunction == false &&
					isStaticGetter == false &&
					isStaticSetter == false) {
					continue
				}

				if (processed[name] == nil) {
					processed[name] = true
				} else {
					continue
				}

				if let s = name.range(of: "_"),
				   let e = name.range(of: "WithCallback:") ?? name.range(of: "Callback:")  {

					let key = name[name.index(s.lowerBound, offsetBy: 1) ... name.index(e.lowerBound, offsetBy: -1)]

					if (isFunction) {
						callback(String(key), .function, sel, imp)
						continue
					}

					if (isGetter) {
						callback(String(key), .getter, sel, imp)
						continue
					}

					if (isSetter) {
						callback(String(key), .setter, sel, imp)
						continue
					}

					if (isStaticFunction) {
						callback(String(key), .staticFunction, sel, imp)
						continue
					}

					if (isStaticGetter) {
						callback(String(key), .staticGetter, sel, imp)
						continue
					}

					if (isStaticSetter) {
						callback(String(key), .staticSetter, sel, imp)
						continue
					}
				}
			}

			free(items)

			let parent: AnyClass! = class_getSuperclass(clazz)
			if (parent == nil ||
				parent == NSObject.self) {
				break
			}

			clazz = parent
		}
	}

	/**
	* @method forEachStatic
	* @since 0.7.0
	* @hidden
	*/
	internal class func forEachStatic(_ from: AnyClass, callback: ForEachCallback) {

		var processed = [String: Bool]()

		var clazz: AnyClass = from

		while (true) {

			var count = UInt32(0)
			let items = class_copyMethodList(object_getClass(clazz), &count)

			for i in 0 ..< Int(count) {

				let sel = method_getName((items?[i])!)
				let imp = method_getImplementation((items?[i])!)
				let name = NSStringFromSelector(sel)

				let isFunction = name.hasPrefix("jsStaticFunction")
				let isGetter = name.hasPrefix("jsStaticGet")
				let isSetter = name.hasPrefix("jsStaticSet")

				if (isFunction == false &&
					isSetter == false &&
					isGetter == false) {
					continue
				}

				if (processed[name] == nil) {
					processed[name] = true
				} else {
					continue
				}

				if let s = name.range(of: "_"),
				   let e = name.range(of: "WithCallback:") ?? name.range(of: "Callback:")  {

					let key = name[name.index(s.lowerBound, offsetBy: 1) ... name.index(e.lowerBound, offsetBy: -1)]

					if (isFunction) {
						callback(String(key), .staticFunction, sel, imp)
						continue
					}

					if (isGetter) {
						callback(String(key), .staticGetter, sel, imp)
						continue
					}

					if (isSetter) {
						callback(String(key), .staticGetter, sel, imp)
						continue
					}
				}
			}

			free(items)

			let parent: AnyClass! = class_getSuperclass(clazz)
			if (parent == nil ||
				parent == NSObject.self) {
				break
			}

			clazz = parent
		}
	}
}


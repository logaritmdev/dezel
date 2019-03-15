import UIKit

/**
 * The root controller of a Dezel application.
 * @class DezelApplicationController
 * @since 0.1.0
 */
open class DezelApplicationController: UIViewController {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * Returns the application controller of the specified context.
	 * @method from
	 * @since 0.1.0
	 */
	public static func from(_ context: JavaScriptContext) -> DezelApplicationController {
		return context.attribute("dezel.application.DezelApplicationController") as! DezelApplicationController
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The status bar visibility status.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	open var statusBarVisible: Bool = true {
		didSet {
			UIView.animate(withDuration: 0.350) {
				self.setNeedsStatusBarAppearanceUpdate()
			}
		}
	}

	/**
	 * The status bar foreground color (white or black)
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	open var statusBarForegroundColor: UIColor = UIColor.black {
		didSet {
			UIView.animate(withDuration: 0.350) {
				self.setNeedsStatusBarAppearanceUpdate()
			}
		}
	}

	/**
	 * The status bar background color.
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	open var statusBarBackgroundColor: UIColor = UIColor.clear {
		didSet {
			UIView.animate(withDuration: 0.350) {
				self.setNeedsStatusBarAppearanceUpdate()
			}
		}
	}

	/**
	 * The application's JavaScript context.
	 * @property context
	 * @since 0.1.0
	 */
	private(set) public var context: JavaScriptContext = JavaScriptContext()

	/**
	 * The application's JavaScript application object.
	 * @property application
	 * @since 0.1.0
	 */
	private(set) public var application: Application?

	/**
	 * The application's stylesheets.
	 * @property styles
	 * @since 0.1.0
	 */
	private(set) public var styles: [String] = []

	/**
	 * The application's scripts.
	 * @property scripts
	 * @since 0.1.0
	 */
	private(set) public var scripts: [String] = []

	/**
	 * The application's modules.
	 * @property modules
	 * @since 0.1.0
	 */
	private(set) public var modules: [String: AnyClass] = [:]

	/**
	 * The application's classes.
	 * @property classes
	 * @since 0.1.0
	 */
	private(set) public var classes: [String: AnyClass] = [:]

	/**
	 * The application's styles manager.
	 * @property styler
	 * @since 0.4.0
	 */
	private(set) public var styler: Styler!

	/**
	 * The application's layout manager.
	 * @property layout
	 * @since 0.4.0
	 */
	private(set) public var layout: Layout!

	/**
	 * The application's update display manager.
	 * @property updateDisplayManager
	 * @since 0.2.0
	 */
	private(set) public var updateDisplayManager: UpdateDisplayManager!

	/**
	 * @property statusBar
	 * @since 0.1.0
	 * @hidden
	 */
	private var statusBar: UIView = UIView(frame: .zero)

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method loadView
	 * @since 0.1.0
	 */
	override open func loadView() {
		self.view = UIView(frame: UIScreen.main.bounds)
	}

	/**
	 * @inherited
	 * @method viewDidLoad
	 * @since 0.1.0
	 */
	override open func viewDidLoad() {

		self.view.translatesAutoresizingMaskIntoConstraints = false
		self.view.backgroundColor = UIColor.black
		self.view.isOpaque = true

		self.view.addSubview(self.statusBar)

		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchBegan), name: Notification.Name("touchesbegan"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchMoved), name: Notification.Name("touchesmoved"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchEnded), name: Notification.Name("touchesended"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchCancelled), name: Notification.Name("touchescancelled"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidHandleLink), name: Notification.Name("handlelink"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrame), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)

		self.context.global.property("_DEV_", boolean: self.isDev())
		self.context.global.property("_SIM_", boolean: self.isSim())
		self.context.attribute("dezel.application.DezelApplicationController", value: self)

		self.context.exception { error in

			var file = "<no file>"
			var line = "<no line>"
			var stack = ""

			if (error.isObject) {
				file = error.property("sourceURL").string
				line = error.property("line").string
				stack = error.property("stack").string
			}

			let message = error.string

			print(
				"JavaScript Error : \(message) \n " +
				"File: \(file) \n " +
				"Line: \(line) \n " +
				"Stack Trace:  \n " +
				"\(stack)"
			)

			let crash = self.applicationDidTriggerError(error: error)
			if (crash) {
				fatalError(message)
			}
		}

		self.styler = Styler()
		self.layout = Layout()
		self.layout.scale = UIScreen.main.scale
		self.layout.viewportWidth = UIScreen.main.bounds.size.width
		self.layout.viewportHeight = UIScreen.main.bounds.size.height

 		self.updateDisplayManager = UpdateDisplayManager(application: self)

		self.context.global.defineProperty("dezel",
			value: self.context.createObject(Dezel.self),
			getter: nil,
			setter: nil,
			writable: false,
			enumerable: true,
			configurable: false
		)

		self.registerModule("dezel.ApplicationModule", module: ApplicationModule.self)
		self.registerModule("dezel.BluetoothModule", module: BluetoothModule.self)
		self.registerModule("dezel.ConnectivityModule", module: ConnectivityModule.self)
		self.registerModule("dezel.DeviceModule", module: DeviceModule.self)
		self.registerModule("dezel.DialogModule", module: DialogModule.self)
		self.registerModule("dezel.FormModule", module: FormModule.self)
		self.registerModule("dezel.GraphicModule", module: GraphicModule.self)
		self.registerModule("dezel.LocaleModule", module: LocaleModule.self)
		self.registerModule("dezel.LocationModule", module: LocationModule.self)
		self.registerModule("dezel.NotificationModule", module: NotificationModule.self)
		self.registerModule("dezel.StorageModule", module: StorageModule.self)
		self.registerModule("dezel.PlatformModule", module: PlatformModule.self)
		self.registerModule("dezel.TranslationModule", module: TranslationModule.self)
		self.registerModule("dezel.ViewModule", module: ViewModule.self)
		self.registerModule("dezel.WebModule", module: WebModule.self)

		self.applicationWillLoad()

		self.loadClasses()
		self.loadModules()

		self.context.initialize()

		self.loadStyles()
		self.loadScripts()
	}

	/**
	 * @inherited
	 * @method viewWillLayoutSubviews
	 * @since 0.1.0
	 */
	override open func viewWillLayoutSubviews() {
		self.view.frame = UIScreen.main.bounds
		self.statusBar.frame = UIApplication.shared.statusBarFrame
	}

	/**
	 * Launches the specified application.
	 * @method launch
	 * @since 0.1.0
	 */
	open func launch(application: Application) {

		self.styler.root = application.window.stylerNode
		self.layout.root = application.window.layoutNode

		let bounds = self.view.bounds
		application.window.width = Property(number: Double(bounds.width), unit: .px)
		application.window.height = Property(number: Double(bounds.height), unit: .px)

		self.application = application

		self.view.addSubview(application.window.wrapper)

		self.applicationDidLoad()

		self.view.bringSubviewToFront(self.statusBar)
	}

	/**
	 * Reloads the current application.
	 * @method reload
	 * @since 0.1.0
	 */
	open func reload() {

		self.applicationDidUnload()

		self.presentedViewController?.dismiss(animated: false, completion: nil)

		self.application?.destroy()
		self.application?.window.wrapper.removeFromSuperview()
		self.application = nil

		self.updateDisplayManager.reset()

		NotificationCenter.default.post(name: Notification.Name("applicationreload"), object: self)

		self.styler = Styler()
		self.layout = Layout()
		self.layout.scale = UIScreen.main.scale
		self.layout.viewportWidth = UIScreen.main.bounds.size.width
		self.layout.viewportHeight = UIScreen.main.bounds.size.height

		self.loadStyles()
		self.loadScripts()
	}

	/**
	 * Registers a style file.
	 * @method registerStyle
	 * @since 0.1.0
	 */
	open func registerStyle(_ style: String) {
		self.styles.append(style)
	}

	/**
	 * Registers a script file.
	 * @method registerScript
	 * @since 0.1.0
	 */
	open func registerScript(_ script: String) {
		self.scripts.append(script)
	}

	/**
	 * Registers a module.
	 * @method registerModule
	 * @since 0.1.0
	 */
	open func registerModule(_ uid: String, module: AnyClass) {
		self.modules[uid] = module
	}

	/**
	 * Registers a class.
	 * @method registerClass
	 * @since 0.1.0
	 */
	open func registerClass(_ uid: String, template: AnyClass) {
		self.classes[uid] = template
	}

	/**
	 * @method loadClasses
	 * @since 0.1.0
	 * @hidden
	 */
	private func loadClasses() {
		self.classes.forEach {
			self.context.registerClass($0.key, type: $0.value)
		}
	}

	/**
	 * @method loadModules
	 * @since 0.1.0
	 * @hidden
	 */
	private func loadModules() {
		self.modules.forEach {
			self.context.registerModule($0.key, type: $0.value)
		}
	}

	/**
	 * @method loadStyles
	 * @since 0.1.0
	 * @hidden
	 */
	private func loadStyles() {

		var insetT: CGFloat = 20
		var insetB: CGFloat = 0

		if #available(iOS 11.0, *) {
			if let window = UIApplication.shared.windows.first {
				insetT = max(window.safeAreaInsets.top, insetT)
				insetB = max(window.safeAreaInsets.bottom, insetB)
			}
		}

		self.styler.setVariable("safe-area-top-inset", value: "\(insetT)px")
		self.styler.setVariable("safe-area-bottom-inset", value: "\(insetB)px")

		for src in self.styles {

			do {

				if (src.hasPrefix("http://") ||
					src.hasPrefix("https://")) {
					self.styler.load(try String(contentsOf: URL(string: src)!), file: src)
					continue
				}

				self.styler.load(try String(contentsOfFile: Bundle.main.path(forResource: "app/" + src, ofType: nil)!), file: src)

			} catch _ {
				fatalError("Cannot load registered stylesheet at \(src), the path is invalid.")
			}
		}
	}

	/**
	 * @method loadScripts
	 * @since 0.1.0
	 * @hidden
	 */
	private func loadScripts() {

		for src in self.scripts {

			do {

				if (src.hasPrefix("http://") ||
					src.hasPrefix("https://")) {
					self.context.evaluate(try String(contentsOf: URL(string: src)!), file: src)
					continue
				}

				self.context.evaluate(try String(contentsOfFile: Bundle.main.path(forResource: "app/" + src, ofType: nil)!), file: src)

			} catch _ {
				fatalError("Cannot load registered script \(src), the path is invalid.")
			}
		}
	}

	/**
	 * @method isDev
	 * @since 0.1.0
	 * @hidden
	 */
	private func isDev() -> Bool {
		#if DEBUG
			return true
		#else
			return false
		#endif
	}

	/**
	 * @method isSim
	 * @since 0.1.0
	 * @hidden
	 */
	private func isSim() -> Bool {
		#if arch(i386) || arch(x86_64)
			return true
		#else
			return false
		#endif
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * Called when the application is about to be loaded.
	 * @method applicationWillLoad
	 * @since 0.1.0
	 */
	open func applicationWillLoad() {

	}

	/**
	 * Called when the application has been loaded.
	 * @method applicationDidLoad
	 * @since 0.1.0
	 */
	open func applicationDidLoad() {
		self.application?.holder.callMethod("nativeLoad")
	}

	/**
	 * Called when the application has been unloaded.
	 * @method applicationDidUnload
	 * @since 0.1.0
	 */
	open func applicationDidUnload() {
		self.application?.holder.callMethod("nativeUnload")
	}

	/**
	 * Called when an exception is triggered from the JavaScript context.
	 * @method applicationDidTriggerError
	 * @since 0.5.0
	 */
	open func applicationDidTriggerError(error: JavaScriptValue) -> Bool {
		return true
	}

	//--------------------------------------------------------------------------
	// MARK: Orientation Transition
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method viewWillTransition
	 * @since 0.6.0
	 */
	open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

		super.viewWillTransition(to: size, with: coordinator)

		guard let window = self.application?.window else {
			return
		}

		coordinator.animate(alongsideTransition: { context in

			let duration = self.getRotationAnimationDuration(context: context)
			let equation = self.getRotationAnimationEquation(context: context)

			Transition.create(application: self, duration: duration, equation: equation, delay: 0) { }

			window.width = Property(number: Double(size.width))
			window.height = Property(number: Double(size.height))

			self.updateDisplayManager.dispatch()

			Transition.commit()

			self.statusBar.frame = UIApplication.shared.statusBarFrame

		}, completion: nil)
	}

	/**
	 * @method getRotationAnimationDuration
	 * @since 0.6.0
 	 * @hidden
	 */
	open func getRotationAnimationDuration(context: UIViewControllerTransitionCoordinatorContext) -> TimeInterval {
		return context.transitionDuration
	}

	/**
	 * @method getRotationAnimationEquation
	 * @since 0.6.0
 	 * @hidden
	 */
	open func getRotationAnimationEquation(context: UIViewControllerTransitionCoordinatorContext) -> CAMediaTimingFunction {

	 	/*
	 	 * Right now, on iOS 12, the context completionCurve does not match the
	 	 * available curves. Ease in out seems to be the closest
	 	 */

		return CAMediaTimingFunction(name: .easeInEaseOut)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application Status Bar Management
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @property prefersStatusBarHidden
	 * @since 0.1.0
	 */
	override open var prefersStatusBarHidden: Bool {

		if (self.statusBar.isHidden == self.statusBarVisible) {
			self.statusBar.isHidden = self.statusBarVisible == false
		}

		return self.statusBarVisible == false
	}

	/**
	 * @inherited
	 * @property preferredStatusBarStyle
	 * @since 0.1.0
	 */
	override open var preferredStatusBarStyle: UIStatusBarStyle {

		if (self.statusBar.backgroundColor != self.statusBarBackgroundColor) {
			UIView.animate(withDuration: 0.25) {
				self.statusBar.backgroundColor = self.statusBarBackgroundColor
			}
		}

		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 1

		if let components = self.statusBarForegroundColor.cgColor.components {

			if (components.count >= 3) {
				r = components[0]
				g = components[1]
				b = components[2]
			}

			if (components.count >= 4) {
				a = components[3]
			}
		}

		return (r == 1 && g == 1 && b == 1 && a == 1) ? .lightContent : .default
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application Keyboard Management
	//--------------------------------------------------------------------------

	/**
	 * @property keyboardVisible
	 * @since 0.1.0
	 * @hidden
	 */
	private var keyboardVisible: Bool = false

	/**
	 * @property keyboardResizing
	 * @since 0.1.0
	 * @hidden
	 */
	private var keyboardResizing: Bool = false

	/**
	 * @method keyboardWillChangeFrame
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func keyboardWillChangeFrame(_ notification: Notification) {

		if let data = (notification as NSNotification).userInfo {

			if (self.keyboardVisible == false) {
				self.keyboardVisible = true
				self.callKeyboardEventMethod("nativeBeforeKeyboardShow", notification: notification)
				return
			}

			let bounds = self.view.bounds
			let fe = (data[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
			let fb = (data[UIResponder.keyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue

			if (fe?.origin.y != fb?.origin.y && fe?.origin.y == bounds.size.height) {
				if (self.keyboardVisible) {
					self.keyboardVisible = false
					self.callKeyboardEventMethod("nativeBeforeKeyboardHide", notification: notification)
					return
				}
			}

			if (self.keyboardResizing == false) {
				self.keyboardResizing = true
				self.callKeyboardEventMethod("nativeBeforeKeyboardResize", notification: notification)
			}
		}
	}

	/**
	 * @method keyboardDidChangeFrame
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func keyboardDidChangeFrame(_ notification: Notification) {

		if (self.keyboardResizing) {
			self.keyboardResizing = false
			self.callKeyboardEventMethod("nativeKeyboardResize", notification: notification)
			return
		}

		if (self.keyboardVisible) {
			self.callKeyboardEventMethod("nativeKeyboardShow", notification: notification)
		} else {
			self.callKeyboardEventMethod("nativeKeyboardHide", notification: notification)
		}
	}

	/**
	 * @method callKeyboardEventMethod
	 * @since 0.1.0
	 * @hidden
	 */
	private func callKeyboardEventMethod(_ name: String, notification: Notification) {

		guard let application = self.application else {
			return
		}

		if let data = (notification as NSNotification).userInfo {

			let frame = (data[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
			let curve = data[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int
			let duration = data[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double

			let equation: String

			switch (curve) {
			case UIView.AnimationCurve.easeInOut.rawValue:
				equation = "easeinout"
			case UIView.AnimationCurve.easeIn.rawValue:
				equation = "easein"
			case UIView.AnimationCurve.easeOut.rawValue:
				equation = "easeout"
			case UIView.AnimationCurve.linear.rawValue:
				equation = "linear"
			default:
				equation = "cubic-bezier(0.380, 0.700, 0.125, 1.000)"
			}

			let height = Double((frame?.size.height)!)

			let args = [
				self.context.createNumber(height),
				self.context.createNumber(duration * 1000),
				self.context.createString(equation)
			]

			application.holder.callMethod(name, arguments: args, result: nil)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application Touch Management
	//--------------------------------------------------------------------------

	/**
	 * Dispatches a touchcancel event.
	 * @method dispatchTouchCancel
	 * @since 0.1.0
	 */
	open func dispatchTouchCancel(_ touches: Set<UITouch>) {
		self.application?.holder.callMethod("dispatchTouchCancel", arguments: [self.toTouchArray(touches, from: self.view)], result: nil)
	}

	/**
	 * Dispatches a touchstart event.
	 * @method dispatchTouchStart
	 * @since 0.1.0
	 */
	open func dispatchTouchStart(_ touches: Set<UITouch>) {
		self.application?.holder.callMethod("dispatchTouchStart", arguments: [self.toTouchArray(touches, from: self.view)], result: nil)
	}

	/**
	 * Dispatches a touchmove event.
	 * @method dispatchTouchMove
	 * @since 0.1.0
	 */
	open func dispatchTouchMove(_ touches: Set<UITouch>) {
		self.application?.holder.callMethod("dispatchTouchMove", arguments: [self.toTouchArray(touches, from: self.view)], result: nil)
	}

	/**
	 * Dispatches a touchend event.
	 * @method dispatchTouchEnd
	 * @since 0.1.0
	 */
	open func dispatchTouchEnd(_ touches: Set<UITouch>) {
		self.application?.holder.callMethod("dispatchTouchEnd", arguments: [self.toTouchArray(touches, from: self.view)], result: nil)
	}

	/**
     * @method handleTouchBegan
     * @since 0.1.0
     * @hidden
     */
	@objc internal func handleTouchBegan(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchStart(touches)
		}
	}

	/**
     * @method handleTouchMoved
     * @since 0.1.0
     * @hidden
     */
	@objc internal func handleTouchMoved(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchMove(touches)
		}
	}

	/**
     * @method handleTouchEnded
     * @since 0.1.0
     * @hidden
     */
	@objc internal func handleTouchEnded(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchEnd(touches)
		}
	}

	/**
     * @method handleTouchCancelled
     * @since 0.1.0
     * @hidden
     */
	@objc internal func handleTouchCancelled(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchCancel(touches)
		}
	}

	/**
	 * @method toTouchArray
	 * @since 0.1.0
	 * @hidden
	 */
	private func toTouchArray(_ changed: Set<UITouch>, from: UIView) -> JavaScriptValue {

		let array = self.context.createEmptyArray()

		for (i, t) in changed.enumerated() {

			let point = t.location(in: from)
			let touch = self.context.createEmptyObject()
			touch.property("identifier", number: Double(unsafeBitCast(t, to: Int.self)))
			touch.property("x", number: Double(point.x))
			touch.property("y", number: Double(point.y))

			array.property(i, value: touch)
		}

		return array
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application related
	//--------------------------------------------------------------------------

	/**
	 * @method applicationDidEnterBackground
	 * @since 0.1.0
 	 * @hidden
	 */
	@objc open func applicationDidEnterBackground() {
		self.application?.holder.callMethod("nativeEnterBackground")
	}

	/**
	 * @method applicationDidEnterForeground
	 * @since 0.1.0
 	 * @hidden
	 */
	@objc open func applicationDidEnterForeground() {
		self.application?.holder.callMethod("nativeEnterForeground")
	}

	/**
	 * @method applicationDidHandleLink
	 * @since 0.5.0
 	 * @hidden
	 */
	@objc open func applicationDidHandleLink(notification: Notification) {
		if let link = notification.userInfo?["url"] as? URL {
			self.application?.holder.callMethod("nativeHandleLink", arguments: [self.context.createString(link.absoluteString)])
		}
	}
}

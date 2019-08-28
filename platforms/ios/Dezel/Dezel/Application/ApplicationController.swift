import UIKit

/**
 * An application view controller.
 * @class ApplicationController
 * @since 0.7.0
 */
open class ApplicationController: UIViewController {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The application's badge.
	 * @property badge
	 * @since 0.7.0
	 */
	open var badge: Int = 0 {
		didSet {
			UIApplication.shared.applicationIconBadgeNumber = self.badge
		}
	}

	/**
	 * The application controller's context.
	 * @property context
	 * @since 0.7.0
	 */
	private(set) public var context: JavaScriptContext = JavaScriptContext()

	/**
	 * The application controller's styler.
	 * @property styler
	 * @since 0.7.0
	 */
	private(set) public var styler: Styler = Styler()

	/**
	 * The application controller's layout.
	 * @property layout
	 * @since 0.7.0
	 */
	private(set) public var layout: Layout = Layout()

	/**
	 * The application controller's application.
	 * @property application
	 * @since 0.7.0
	 */
	private(set) public var application: JavaScriptApplication?

	/**
	 * @property modules
	 * @since 0.7.0
	 * @hidden
	 */
	private var modules: [String: AnyClass] = [:]

	/**
	 * @property classes
	 * @since 0.7.0
	 * @hidden
	 */
	private var classes: [String: AnyClass] = [:]

	/**
	 * @property sources
	 * @since 0.7.0
	 * @hidden
	 */
	private var sources: [Source] = []

	/**
	 * @property running
	 * @since 0.7.0
	 * @hidden
	 */
	private var running: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates the application context and required components.
	 * @method setup
	 * @since 0.7.0
	 */
	open func configure() {

	}

	/**
	 * Creates the application context and required components.
	 * @method setup
	 * @since 0.7.0
	 */
	open func setup() {

		if (self.running) {
			return
		}

		self.running = true

		self.registerObservers()

		self.layout.scale = UIScreen.main.scale
		self.layout.viewportWidth = UIScreen.main.bounds.width
		self.layout.viewportHeight = UIScreen.main.bounds.height

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

		self.context.attribute(kApplicationControllerKey, value: self)
		self.context.global.property("_DEV_", boolean: self.isDev())
		self.context.global.property("_SIM_", boolean: self.isSim())

		self.context.handleError { error in

			var file = "<no file>"
			var line = "<no line>"
			var stack = ""

			if (error.isObject) {
				file = error.property("sourceURL").string
				line = error.property("line").string
				stack = error.property("stack").string
			}

			let message =
				"\(error.string) \n " +
				"File: \(file) \n " +
				"Line: \(line) \n " +
				"Stack Trace:  \n " +
				"\(stack)"

			self.didThrowError(error: error)

			fatalError(message)
		}

		self.registerModule("dezel.CoreModule", with: CoreModule.self)
		self.registerModule("dezel.GlobalModule", with: GlobalModule.self)
		self.registerModule("dezel.LocaleModule", with: LocaleModule.self)
		self.registerModule("dezel.DeviceModule", with: DeviceModule.self)
		self.registerModule("dezel.PlatformModule", with: PlatformModule.self)
		self.registerModule("dezel.DialogModule", with: DialogModule.self)
		self.registerModule("dezel.GraphicModule", with: GraphicModule.self)
		self.registerModule("dezel.ViewModule", with: ViewModule.self)
		self.registerModule("dezel.FormModule", with: FormModule.self)
		self.registerModule("dezel.ApplicationModule", with: ApplicationModule.self)

		self.configure()

		self.context.registerModules(self.modules)
		self.context.registerClasses(self.classes)
		self.context.setup()

		self.sources.forEach { source in
			switch (source.category) {
				case .style:
					self.evaluateStyle(source.data, file: source.location)
				case .script:
					self.evaluateScript(source.data, file: source.location)
			}
		}

		self.didLoad()
	}

	/**
	 * Registers a context module.
	 * @method registerModule
	 * @since 0.7.0
	 */
	open func registerModule(_ uid: String, with value: AnyClass) {
		self.modules[uid] = value
	}

	/**
	 * Registers a context class.
	 * @method registerClass
	 * @since 0.7.0
	 */
	open func registerClass(_ uid: String, with value: AnyClass) {
		self.classes[uid] = value
	}

	/**
	 * Registers a style file.
	 * @method registerStyle
	 * @since 0.7.0
	 */
	open func registerStyle(_ location: String) {
		self.sources.append(Source(location: location, category: .style))
	}

	/**
	 * Registers a script file.
	 * @method registerScript
	 * @since 0.7.0
	 */
	open func registerScript(_ location: String) {
		self.sources.append(Source(location: location, category: .script))
	}

	/**
	 * Evaluates a style file.
	 * @method evaluateStyle
	 * @since 0.7.0
	 */
	open func evaluateStyle(_ source: String, file: String) {
		self.styler.load(source, file: file)
	}

	/**
	 * Evaluates a script file.
	 * @method evaluateScript
	 * @since 0.7.0
	 */
	open func evaluateScript(_ source: String, file: String) {
		self.context.evaluate(source, file: file)
	}

	/**
	 * Launches the specified application.
	 * @method launch
	 * @since 0.7.0
	 */
	open func launch(_ application: JavaScriptApplication, identifier: String = "default") {

		self.application?.destroy()
		self.application = application

		self.styler.root = application.window.stylerNode
		self.layout.root = application.window.layoutNode

		application.window.width.reset(Double(UIScreen.main.bounds.width), unit: .px)
		application.window.height.reset(Double(UIScreen.main.bounds.width), unit: .px)
		self.view.addSubview(application.window)

		self.didLaunchApplication(application: application)
	}

	/**
	 * Reloads the current application.
	 * @method reload
	 * @since 0.7.0
	 */
	open func reload() {

		// TODO
		// FIX THIS

		self.application?.destroy()
		self.application = nil

		Synchronizer.main.reset()

		let scale = self.layout.scale
		let viewportWidth = self.layout.viewportWidth
		let viewportHeight = self.layout.viewportHeight

		self.styler = Styler()
		self.layout = Layout()
		self.layout.scale = scale
		self.layout.viewportWidth = viewportWidth
		self.layout.viewportHeight = viewportHeight
	}

	/**
	 * Opens a resource URL.
	 * @method openResourceURL
	 * @since 0.7.0
	 */
	open func openResourceURL(_ url: URL) {
		self.application?.callMethod("nativeOnOpenResourceURL", arguments: [self.context.createString(url.absoluteString)])
	}

	/**
	 * Opens a universal URL.
	 * @method openUniversalURL
	 * @since 0.7.0
	 */
	open func openUniversalURL(_ url: URL) {
		self.application?.callMethod("nativeOnOpenUniversalURL", arguments: [self.context.createString(url.absoluteString)])
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Touch Management
	//--------------------------------------------------------------------------

	/**
	 * Dispatches a touchcancel event.
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	open func dispatchTouchCancel(_ touches: Set<UITouch>) {
		self.dispatchTouchEvent("nativeOnTouchCancel", touches: touches)
	}

	/**
	 * Dispatches a touchstart event.
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	open func dispatchTouchStart(_ touches: Set<UITouch>) {
		self.dispatchTouchEvent("nativeOnTouchStart", touches: touches)
	}

	/**
	 * Dispatches a touchmove event.
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	open func dispatchTouchMove(_ touches: Set<UITouch>) {
		self.dispatchTouchEvent("nativeOnTouchMove", touches: touches)
	}

	/**
	 * Dispatches a touchend event.
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	open func dispatchTouchEnd(_ touches: Set<UITouch>) {
		self.dispatchTouchEvent("nativeOnTouchEnd", touches: touches)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - State Management
	//--------------------------------------------------------------------------

	/**
	 * Notifies the application it has moved to the background.
	 * @method enterBackground
	 * @since 0.7.0
	 */
	open func didEnterBackground() {
		self.application?.callMethod("nativeOnEnterBackground")
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method enterForeground
	 * @since 0.7.0
	 */
	open func didEnterForeground() {
		self.application?.callMethod("nativeOnEnterForeground")
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Keyboard Management
	//--------------------------------------------------------------------------

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method keyboardWillShow
	 * @since 0.7.0
	 */
	open func keyboardWillShow(_ notification: Notification) {
		self.dispatchKeyboardEvent("nativeOnBeforeKeyboardShow", notification: notification)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method keyboardDidShow
	 * @since 0.7.0
	 */
	open func keyboardDidShow(_ notification: Notification) {
		self.dispatchKeyboardEvent("nativeOnKeyboardShow", notification: notification)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method keyboardWillHide
	 * @since 0.7.0
	 */
	open func keyboardWillHide(_ notification: Notification) {
		self.dispatchKeyboardEvent("nativeOnBeforeKeyboardHide", notification: notification)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method keyboardDidHide
	 * @since 0.7.0
	 */
	open func keyboardDidHide(_ notification: Notification) {
		self.dispatchKeyboardEvent("nativeOnKeyboardHide", notification: notification)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method keyboardWillResize
	 * @since 0.7.0
	 */
	open func keyboardWillResize(_ notification: Notification) {
		self.dispatchKeyboardEvent("nativeOnBeforeKeyboardResize", notification: notification)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method keyboardDidResize
	 * @since 0.7.0
	 */
	open func keyboardDidResize(_ notification: Notification) {
		self.dispatchKeyboardEvent("nativeboardResize", notification: notification)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - View Management
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method loadView
	 * @since 0.7.0
	 */
	override open func loadView() {
		self.view = UIView(frame: UIScreen.main.bounds)
	}

	/**
	 * @inherited
	 * @method viewDidLoad
	 * @since 0.7.0
	 */
	override open func viewDidLoad() {

		self.view.isHidden = false
		self.view.isOpaque = true
		self.view.backgroundColor = UIColor.black

		self.view.addSubview(self.statusBar)

		self.setup()
	}

	/**
	 * @inherited
	 * @method viewWillLayoutSubviews
	 * @since 0.7.0
	 */
	override open func viewWillLayoutSubviews() {

		let bounds = UIScreen.main.bounds

		self.view.frame = bounds

		self.layout.viewportWidth = bounds.width
		self.layout.viewportHeight = bounds.height

		if let application = self.application {
			application.window.width.reset(Double(bounds.width))
			application.window.height.reset(Double(bounds.height))
		}

		self.statusBar.frame = UIApplication.shared.statusBarFrame
	}

	/**
	 * @inherited
	 * @method viewWillTransition
	 * @since 0.7.0
	 */
	override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

		super.viewWillTransition(to: size, with: coordinator)

		coordinator.animate(alongsideTransition: { context in

			let duration = self.getRotationAnimationDuration(context: context)
			let equation = self.getRotationAnimationEquation(context: context)

			Transition.create(
				duration: duration,
				equation: equation,
				delay: 0
			) { }

			self.layout.viewportWidth = size.width
			self.layout.viewportHeight = size.height

			if let application = self.application {
				application.window.width.reset(Double(size.width))
				application.window.height.reset(Double(size.height))
			}

			Synchronizer.main.execute()

			Transition.commit()

			self.statusBar.frame = UIApplication.shared.statusBarFrame

		}, completion: nil)
	}

	/**
	 * @method getRotationAnimationDuration
	 * @since 0.7.0
 	 * @hidden
	 */
	open func getRotationAnimationDuration(context: UIViewControllerTransitionCoordinatorContext) -> TimeInterval {
		return context.transitionDuration
	}

	/**
	 * @method getRotationAnimationEquation
	 * @since 0.7.0
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
	// MARK: Methods - Status Bar Management
	//--------------------------------------------------------------------------

	/**
	 * The application's status bar visibility status.
	 * @property statusBarVisible
	 * @since 0.7.0
	 */
	open var statusBarVisible: Bool = true {
		didSet {
			UIView.animate(withDuration: 0.350) {
				self.setNeedsStatusBarAppearanceUpdate()
			}
		}
	}

	/**
	 * The application's status bar foreground color (white or black)
	 * @property statusBarForegroundColor
	 * @since 0.7.0
	 */
	open var statusBarForegroundColor: UIColor = UIColor.black {
		didSet {
			UIView.animate(withDuration: 0.350) {
				self.setNeedsStatusBarAppearanceUpdate()
			}
		}
	}

	/**
	 * The application's status bar background color.
	 * @property statusBarBackgroundColor
	 * @since 0.7.0
	 */
	open var statusBarBackgroundColor: UIColor = UIColor.clear {
		didSet {
			UIView.animate(withDuration: 0.350) {
				self.setNeedsStatusBarAppearanceUpdate()
			}
		}
	}

	/**
	 * @property statusBar
	 * @since 0.7.0
	 * @hidden
	 */
	private var statusBar: UIView = UIView(frame: .zero)

	/**
	 * @inherited
	 * @property prefersStatusBarHidden
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	// MARK: Methods - Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * Called when the context has been loaded.
	 * @method didLoad
	 * @since 0.7.0
	 */
	open func didLoad() {

	}

	/**
	 * Called when a JavaScript error is thrown.
	 * @method didThrowError
	 * @since 0.7.0
	 */
	open func didThrowError(error: JavaScriptValue) {

	}

	/**
	 * Called when a JavaScript application is launched.
	 * @method didLaunchApplication
	 * @since 0.7.0
	 */
	open func didLaunchApplication(application: JavaScriptApplication) {

	}

	/**
	 * Called when a JavaScript application is reloaded.
	 * @method didReloadApplication
	 * @since 0.7.0
	 */
	open func didReloadApplication(application: JavaScriptApplication) {

	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Handlers
	//--------------------------------------------------------------------------

	/**
	 * @property keyboardVisible
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardVisible: Bool = false

	/**
	 * @property keyboardResizing
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardResizing: Bool = false

	/**
	 * @method handleResourceURL
	 * @since 0.7.0
 	 * @hidden
	 */
	@objc open func handleResourceURL(notification: Notification) {
		if let url = notification.userInfo?["url"] as? URL {
			self.openResourceURL(url)
		}
	}

	/**
	 * @method handleUniversalURL
	 * @since 0.7.0
 	 * @hidden
	 */
	@objc open func handleUniversalURL(notification: Notification) {
		if let url = notification.userInfo?["url"] as? URL {
			self.openUniversalURL(url)
		}
	}

	/**
     * @method handleTouchBegan
     * @since 0.7.0
     * @hidden
     */
	@objc internal func handleTouchBegan(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchStart(touches)
		}
	}

	/**
     * @method handleTouchMoved
     * @since 0.7.0
     * @hidden
     */
	@objc internal func handleTouchMoved(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchMove(touches)
		}
	}

	/**
     * @method handleTouchEnded
     * @since 0.7.0
     * @hidden
     */
	@objc internal func handleTouchEnded(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchEnd(touches)
		}
	}

	/**
     * @method handleTouchCancelled
     * @since 0.7.0
     * @hidden
     */
	@objc internal func handleTouchCancelled(notification: NSNotification) {
		if let touches = notification.userInfo?["touches"] as? Set<UITouch> {
			self.dispatchTouchCancel(touches)
		}
	}

	/**
	 * @method handleEnterBackground
	 * @since 0.7.0
 	 * @hidden
	 */
	@objc open func handleEnterBackground() {
		self.didEnterBackground()
	}

	/**
	 * @method handleEnterForeground
	 * @since 0.7.0
 	 * @hidden
	 */
	@objc open func handleEnterForeground() {
		self.didEnterForeground()
	}

	/**
	 * @method handleKeyboardWillChangeFrame
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func handleKeyboardWillChangeFrame(_ notification: Notification) {

		if let data = (notification as NSNotification).userInfo {

			if (self.keyboardVisible == false) {
				self.keyboardVisible = true
				self.keyboardWillShow(notification)
				return
			}

			let bounds = self.view.bounds
			let fe = (data[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
			let fb = (data[UIResponder.keyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue

			if (fe?.origin.y != fb?.origin.y && fe?.origin.y == bounds.size.height) {
				if (self.keyboardVisible) {
					self.keyboardVisible = false
					self.keyboardWillHide(notification)
					return
				}
			}

			if (self.keyboardResizing == false) {
				self.keyboardResizing = true
				self.keyboardWillResize(notification)
			}
		}
	}

	/**
	 * @method handleKeyboardDidChangeFrame
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func handleKeyboardDidChangeFrame(_ notification: Notification) {

		if (self.keyboardResizing) {
			self.keyboardResizing = false
			self.keyboardDidResize(notification)
			return
		}

		if (self.keyboardVisible) {
			self.keyboardDidShow(notification)
		} else {
			self.keyboardDidHide(notification)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method registerObservers
	 * @since 0.7.0
	 * @hidden
	 */
	private func registerObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchBegan), name: ApplicationDelegate.touchesBeganNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchMoved), name: ApplicationDelegate.touchesMovedNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchEnded), name: ApplicationDelegate.touchesEndedNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTouchCancelled), name: ApplicationDelegate.touchesCancelledNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleResourceURL), name: ApplicationDelegate.openResourceURLNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleUniversalURL), name: ApplicationDelegate.openUniversalURLNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidChangeFrame), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
	}

	/**
	 * @method unregisterObservers
	 * @since 0.7.0
	 * @hidden
	 */
	private func unregisterObservers() {

	}

	/**
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchTouchEvent(_ name: String, touches: Set<UITouch>) {

		guard let application = self.application else {
			return
		}

		let array = self.context.createEmptyArray()

		for (i, t) in touches.enumerated() {

			let point = t.location(
				in: self.view
			)

			let touch = self.context.createEmptyObject()
			touch.property("identifier", number: Double(unsafeBitCast(t, to: Int.self)))
			touch.property("x", number: Double(point.x))
			touch.property("y", number: Double(point.y))

			array.property(i, value: touch)
		}

		application.callMethod(name, arguments: [array], result: nil)
	}

	/**
	 * @method dispatchKeyboardEvent
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchKeyboardEvent(_ name: String, notification: Notification) {

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

			application.callMethod(name, arguments: args, result: nil)
		}
	}

	/**
	 * @method isDev
	 * @since 0.7.0
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
	 * @since 0.7.0
	 * @hidden
	 */
	private func isSim() -> Bool {
		#if arch(i386) || arch(x86_64)
			return true
		#else
			return false
		#endif
	}
}

/**
 * @const kApplicationControllerKey
 * @since 0.7.0
 * @hidden
 */
internal let kApplicationControllerKey = NSObject()

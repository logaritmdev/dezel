/**
 * @class Application
 * @since 0.1.0
 * @hidden
 */
open class Application: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The application's window.
	 * @property window
	 * @since 0.1.0
	 */
	private(set) public var window: Window!

	/**
	 * The application's status bar visibility status.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	@objc open var statusBarVisible: Property = Property(boolean: true) {
		willSet {
			self.context.application.statusBarVisible = newValue.boolean
		}
	}

	/**
	 * The application's status bar foreground color.
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	@objc open var statusBarForegroundColor: Property = Property(string: "black") {
		willSet {
			self.context.application.statusBarForegroundColor = UIColor(string: newValue.string)
		}
	}

	/**
	 * The application's status bar foreground color.
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	@objc open var statusBarBackgroundColor: Property = Property(string: "transparent") {
		willSet {
			self.context.application.statusBarBackgroundColor = UIColor(string: newValue.string)
		}
	}

	/**
	 * The application's badge.
	 * @property badge
	 * @since 0.1.0
	 */
	@objc open var badge: Property = Property(number: 0) {
		willSet(value) {
			UIApplication.shared.applicationIconBadgeNumber = value.number.int()
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Destroys the application.
	 * @method destroy
	 * @since 0.2.0
	 */
	open func destroy() {
		self.holder.callMethod("nativeDestroy")
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(self.window)
	}

	/**
	 * @method jsSet_window
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_window(callback: JavaScriptSetterCallback) {
		self.window = callback.value.cast(Window.self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarVisible
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_statusBarVisible(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusBarVisible)
	}

	/**
	 * @method jsSet_statusBarVisible
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_statusBarVisible(callback: JavaScriptSetterCallback) {
		self.statusBarVisible = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarForegroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_statusBarForegroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusBarForegroundColor)
	}

	/**
	 * @method jsSet_statusBarForegroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_statusBarForegroundColor(callback: JavaScriptSetterCallback) {
		self.statusBarForegroundColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarBackgroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_statusBarBackgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusBarBackgroundColor)
	}

	/**
	 * @method jsSet_statusBarBackgroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_statusBarBackgroundColor(callback: JavaScriptSetterCallback) {
		self.statusBarBackgroundColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_badge
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_badge(callback: JavaScriptGetterCallback) {
		callback.returns(self.badge)
	}

	/**
	 * @method jsSet_badge
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_badge(callback: JavaScriptSetterCallback) {
		self.badge = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_state
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_state(callback: JavaScriptGetterCallback) {
		switch (UIApplication.shared.applicationState) {
			case .active:
				callback.returns(string: "foreground")
			case .inactive:
				callback.returns(string: "foreground")
			case .background:
				callback.returns(string: "background")
			default:
				break
		}
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_run
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_run(callback: JavaScriptFunctionCallback) {
		self.context.application.launch(application: self)
	}

	/**
	 * @method jsFunction_openURL
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_openURL(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			return
		}

		var url = callback.argument(0).string
		if (url == "settings:app") {
			url = UIApplication.openSettingsURLString
		}

		if (url == "settings" ||
			url == "settings:location" ||
			url == "settings:bluetooth") {
			// how come there is no support for this on ios
			url = UIApplication.openSettingsURLString
		}

		if let url = URL(string: url) {
			UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
		}
	}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

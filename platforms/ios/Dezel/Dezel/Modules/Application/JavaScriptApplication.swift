/**
 * @class JavaScriptApplication
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptApplication: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property window
	 * @since 0.7.0
	 */
	private(set) public var window: JavaScriptWindow!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method destroy
	 * @since 0.7.0
	 */
	open func destroy() {
		self.window.wrapper.removeFromSuperview()
		self.callMethod("nativeOnDestroy")
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property statusBarVisible
	 * @since 0.7.0
	 */
	@objc public lazy var statusBarVisible = JavaScriptProperty(boolean: true) { value in
		self.context.controller.statusBarVisible = value.boolean
	}

	/**
	 * @property statusBarForegroundColor
	 * @since 0.7.0
	 */
	@objc public lazy var statusBarForegroundColor = JavaScriptProperty(string: "black") { value in
		self.context.controller.statusBarForegroundColor = UIColor(color: value)
	}

	/**
	 * @property statusBarBackgroundColor
	 * @since 0.7.0
	 */
	@objc public lazy var statusBarBackgroundColor = JavaScriptProperty(string: "transparent") { value in
		self.context.controller.statusBarBackgroundColor = UIColor(color: value)
	}

	/**
	 * @property badge
	 * @since 0.7.0
	 */
	@objc public lazy var badge = JavaScriptProperty(number: 0) { value in
		UIApplication.shared.applicationIconBadgeNumber = value.number.toInt()
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(self.window)
	}

	/**
	 * @method jsSet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_window(callback: JavaScriptSetterCallback) {
		self.window = callback.value.cast(JavaScriptWindow.self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarVisible
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_statusBarVisible(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusBarVisible)
	}

	/**
	 * @method jsSet_statusBarVisible
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_statusBarVisible(callback: JavaScriptSetterCallback) {
		self.statusBarVisible.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarForegroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_statusBarForegroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusBarForegroundColor)
	}

	/**
	 * @method jsSet_statusBarForegroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_statusBarForegroundColor(callback: JavaScriptSetterCallback) {
		self.statusBarForegroundColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarBackgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_statusBarBackgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusBarBackgroundColor)
	}

	/**
	 * @method jsSet_statusBarBackgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_statusBarBackgroundColor(callback: JavaScriptSetterCallback) {
		self.statusBarBackgroundColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_badge
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_badge(callback: JavaScriptGetterCallback) {
		callback.returns(self.badge)
	}

	/**
	 * @method jsSet_badge
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_badge(callback: JavaScriptSetterCallback) {
		self.badge.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_state
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_state(callback: JavaScriptGetterCallback) {
		switch (UIApplication.shared.applicationState) {
			case .active:
				callback.returns("foreground")
			case .inactive:
				callback.returns("foreground")
			case .background:
				callback.returns("background")
			default:
				break
		}
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_openURL
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_openURL(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("openURL requires 1 argument")
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
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}
}

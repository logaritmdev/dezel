/**
 * @class WebGlobal
 * @since 0.1.0
 * @hidden
 */
open class WebGlobal: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduledTimers
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledTimers: [Double: ScheduledTimer] = [:]

	/**
 	 * @property scheduledFrames
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledFrames: [Double: JavaScriptValue] = [:]

	/**
	 * @property scheduledTimersTotal
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledTimersTotal: Double = 0

	/**
	 * @property scheduledFramesTotal
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledFramesTotal: Double = 0

	/**
	 * @property displayLink
	 * @since 0.1.0
	 * @hidden
	 */
	private var displayLink: CADisplayLink!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public required init(context: JavaScriptContext) {
		super.init(context: context)
		self.setupDisplayLink()
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {
		self.scheduledTimers.forEach { $0.value.timer.invalidate() }
		self.scheduledTimers.removeAll()
		self.scheduledFrames.forEach { $0.value.unprotect() }
		self.scheduledFrames.removeAll()
		super.dispose()
	}

	/**
	 * @method scheduledTimerInterval
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func scheduledTimerInterval(_ timer: Timer) {

		guard let identifier = timer.userInfo as? Double else {
			return
		}

		self.scheduledTimers[identifier]?.value.call()
	}

	/**
	 * @method scheduledTimerTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func scheduledTimerTimeout(_ timer: Timer) {

		guard let identifier = timer.userInfo as? Double else {
			return
		}

		if let scheduledTimer = self.scheduledTimers[identifier] {
			scheduledTimer.value.call()
			scheduledTimer.value.unprotect()
			self.scheduledTimers.removeValue(forKey: identifier)
		}
	}

	/**
	 * @method scheduledFrameCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func scheduledFrameCallback() {

		let values = self.scheduledFrames

		self.scheduledFrames = [Double: JavaScriptValue]()

		for (_, value) in values {
			value.call()
			value.unprotect()
		}

		if (self.scheduledFrames.count == 0) {
			self.pauseDisplayLink()
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method scheduleInterval
	 * @since 0.1.0
	 * @hidden
	 */
	private func scheduleInterval(callback: JavaScriptValue, ms: TimeInterval) -> Double {

		self.scheduledTimersTotal += 1

		callback.protect()

		self.scheduledTimers[self.scheduledTimersTotal] = ScheduledTimer(
			timer: Timer.scheduledTimer(timeInterval:(ms / 1000), target: self, selector: #selector(scheduledTimerInterval), userInfo: self.scheduledTimersTotal, repeats: true),
			value: callback
		)

		return self.scheduledTimersTotal
	}

	/**
	 * @method scheduleTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	private func scheduleTimeout(callback: JavaScriptValue, ms: TimeInterval) -> Double {

		self.scheduledTimersTotal += 1

		callback.protect()

		self.scheduledTimers[self.scheduledTimersTotal] = ScheduledTimer(
			timer: Timer.scheduledTimer(timeInterval:(ms / 1000), target: self, selector: #selector(scheduledTimerTimeout), userInfo: self.scheduledTimersTotal, repeats: false),
			value: callback
		)

		return self.scheduledTimersTotal
	}

	/**
	 * @method clearTimers
	 * @since 0.1.0
	 * @hidden
	 */
	private func clearTimers(_ identifier: Double) {
		self.scheduledTimers.removeValue(forKey: identifier)
	}

	/**
	 * @method setupDisplayLink
	 * @since 0.1.0
	 * @hidden
	 */
	private func setupDisplayLink() {
		self.displayLink = CADisplayLink(target: self, selector: #selector(scheduledFrameCallback))
		self.displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
		self.displayLink.isPaused = true
	}

	/**
	 * @method startDisplayLink
	 * @since 0.1.0
	 * @hidden
	 */
	private func startDisplayLink() {
		self.displayLink.isPaused = false
	}

	/**
	 * @method pauseDisplayLink
	 * @since 0.1.0
	 * @hidden
	 */
	private func pauseDisplayLink() {
		self.displayLink.isPaused = true
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @function jsFunction_setImmediate
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_setImmediate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		callback.returns(number: self.scheduleTimeout(callback: callback.argument(0), ms: 0))
	}

	/**
	 * @function jsFunction_setInterval
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_setInterval(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count == 0) {
			return
		}

		var delay = Double(10)
		if (count > 1) {
			delay = max(delay, callback.argument(1).number)
		}

		callback.returns(number: self.scheduleInterval(callback: callback.argument(0), ms: delay))
	}

	/**
	 * @function jsFunction_setTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_setTimeout(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count == 0) {
			return
		}

		let fn = callback.argument(0)

		if (count == 1) {
			callback.returns(number: self.scheduleTimeout(callback: fn, ms: 0))
		} else {
			callback.returns(number: self.scheduleTimeout(callback: fn, ms: callback.argument(1).number))
		}
	}

	/**
	 * @function jsFunction_clearImmediate
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_clearImmediate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		self.clearTimers(callback.argument(0).number)
	}

	/**
	 * @function jsFunction_clearTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_clearTimeout(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		self.clearTimers(callback.argument(0).number)
	}

	/**
	 * @function jsFunction_clearInterval
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_clearInterval(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		self.clearTimers(callback.argument(0).number)
	}

	/**
	 * @function jsFunction_requestAnimationFrame
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_requestAnimationFrame(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		self.startDisplayLink()

		self.scheduledFramesTotal += 1

		let value = callback.argument(0)
		value.protect()
		self.scheduledFrames[self.scheduledFramesTotal] = value

		callback.returns(number: self.scheduledFramesTotal)
	}

	/**
	 * @function jsFunction_cancelAnimationFrame
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_cancelAnimationFrame(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		let identifier = callback.argument(0).number

		if let value = self.scheduledFrames[identifier] {
			value.unprotect()
		}

		self.scheduledFrames.removeValue(forKey: identifier)
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @struct Scheduled Timer
	 * @since 0.1.0
	 */
	private struct ScheduledTimer {
		public var timer: Timer
		public var value: JavaScriptValue
		init(timer: Timer, value: JavaScriptValue) {
			self.timer = timer
			self.value = value
		}
	}
}

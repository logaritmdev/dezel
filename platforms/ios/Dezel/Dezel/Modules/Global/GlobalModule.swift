/**
 * @class GlobalModule
 * @since 0.7.0
 * @hidden
 */
open class GlobalModule : Module {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduledTimers
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledTimers: [Double: ScheduledTimer] = [:]

	/**
 	 * @property scheduledFrames
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledFrames: [Double: ScheduledFrame] = [:]

	/**
	 * @property scheduledTimersTotal
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledTimersTotal: Double = 0

	/**
	 * @property scheduledFramesTotal
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledFramesTotal: Double = 0

	/**
	 * @property displayLink
	 * @since 0.7.0
	 * @hidden
	 */
	private var displayLink: CADisplayLink!

	/**
	 * @property setInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var setImmediate = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("Failed to execute 'setImmediate': 1 argument required but only \(count) present.")
		}

		callback.returns(number: self.scheduleTimeout(callback: callback.argument(0), interval: 0))
	}

	/**
	 * @property setInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var setInterval = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("setInterval must have at least 1 argument, \(count) given.")
		}

		var delay = Double(10)
		if (count > 1) {
			delay = max(delay, callback.argument(1).number)
		}

		callback.returns(number: self.scheduleInterval(callback: callback.argument(0), interval: delay))
	}

	/**
	 * @property setTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var setTimeout = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("setInterval must have at least 2 arguments, \(count) given.")
		}

		if (count == 1) {
			callback.returns(number: self.scheduleTimeout(callback: callback.argument(0), interval: 0))
		} else {
			callback.returns(number: self.scheduleTimeout(callback: callback.argument(0), interval: callback.argument(1).number))
		}
	}

	/**
	 * @property clearImmediate
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var clearImmediate = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("clearImmediate must have at least 1 argument, \(count) given.")
		}

		self.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property clearTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var clearTimeout = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("clearTimeout must have at least 1 argument, \(count) given.")
		}

		self.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property clearInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var clearInterval = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("clearTimeout must have at least 1 argument, \(count) given.")
		}

		self.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property requestAnimationFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var requestAnimationFrame = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 2) {
			fatalError("clearTimeout must have at least 2 argument2, \(count) given.")
		}

		self.startDisplayLink()

		callback.returns(number: self.scheduleFrame(callback: callback.argument(0)))
	}

	/**
	 * @property cancelAnimationFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var cancelAnimationFrame = self.context.createFunction { callback in

		let count = callback.arguments
		if (count < 1) {
			fatalError("clearTimeout must have at least 1 argument, \(count) given.")
		}

		self.removeFrame(callback.argument(0).number)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

    /**
     * @inherited
     * @constructor
     * @since 0.7.0
     */
	public required init(context: JavaScriptContext) {

		super.init(context: context)

		self.displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLinkCallback))
		self.displayLink.setup()
		self.displayLink.isPaused = true
	}

    /**
     * @inherited
     * @method initialize
     * @since 0.7.0
     */
	override open func initialize() {

		self.context.registerClass("dezel.global.WebSocket", with: JavaScriptWebSocket.self)
		self.context.registerClass("dezel.global.XMLHttpRequest", with: JavaScriptXMLHttpRequest.self)

		self.context.global.defineProperty("setImmediate", value: self.setImmediate)
		self.context.global.defineProperty("setInterval", value: self.setInterval)
		self.context.global.defineProperty("setTimeout", value: self.setTimeout)
		self.context.global.defineProperty("clearImmediate", value: self.clearImmediate)
		self.context.global.defineProperty("clearInterval", value: self.clearInterval)
		self.context.global.defineProperty("clearTimeout", value: self.clearTimeout)
		self.context.global.defineProperty("requestAnimationFrame", value: self.requestAnimationFrame)
		self.context.global.defineProperty("cancelAnimationFrame", value: self.cancelAnimationFrame)
	}

	/**
	 * @inherited
	 * @method cancel
	 * @since 0.7.0
	 */
	override open func dispose() {

		self.scheduledTimers.forEach { $0.value.cancel() }
		self.scheduledFrames.forEach { $0.value.cancel() }
		self.scheduledTimers.removeAll()
		self.scheduledFrames.removeAll()

		super.dispose()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Handlers
	//--------------------------------------------------------------------------

	/**
	 * @method handleDisplayLinkCallback
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func handleDisplayLinkCallback() {

		let frames = self.scheduledFrames

		self.scheduledFrames = [Double: ScheduledFrame]()

		for (_, frame) in frames {
			frame.execute()
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
	 * @since 0.7.0
	 * @hidden
	 */
	private func scheduleInterval(callback: JavaScriptValue, interval: TimeInterval) -> Double {
		self.scheduledTimersTotal += 1
		self.scheduledTimers[self.scheduledTimersTotal] = ScheduledTimer(callback: callback, interval: interval, repeated: true, module: self, handle: self.scheduledTimersTotal)
		return self.scheduledTimersTotal
	}

	/**
	 * @method scheduleTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private func scheduleTimeout(callback: JavaScriptValue, interval: TimeInterval) -> Double {
		self.scheduledTimersTotal += 1
		self.scheduledTimers[self.scheduledTimersTotal] = ScheduledTimer(callback: callback, interval: interval, repeated: false, module: self, handle: self.scheduledTimersTotal)
		return self.scheduledTimersTotal
	}

	/**
	 * @method scheduleFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private func scheduleFrame(callback: JavaScriptValue) -> Double {
		self.scheduledFramesTotal += 1
		self.scheduledFrames[self.scheduledFramesTotal] = ScheduledFrame(callback: callback)
		return self.scheduledFramesTotal
	}

	/**
	 * @method removeTimer
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeTimer(_ identifier: Double) {
		self.scheduledTimers[identifier]?.cancel()
		self.scheduledTimers.removeValue(forKey: identifier)
	}

	/**
	 * @method removeFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeFrame(_ identifier: Double) {
		self.scheduledFrames[identifier]?.cancel()
		self.scheduledFrames.removeValue(forKey: identifier)
	}

	/**
	 * @method startDisplayLink
	 * @since 0.7.0
	 * @hidden
	 */
	private func startDisplayLink() {
		self.displayLink.isPaused = false
	}

	/**
	 * @method pauseDisplayLink
	 * @since 0.7.0
	 * @hidden
	 */
	private func pauseDisplayLink() {
		self.displayLink.isPaused = true
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @struct ScheduledTimer
	 * @since 0.7.0
	 * @hidden
	 */
	private class ScheduledTimer: NSObject {

		/**
		 * @property callback
		 * @since 0.7.0
		 * @hidden
		 */
		private var callback: JavaScriptValue

		/**
		 * @property interval
		 * @since 0.7.0
		 * @hidden
		 */
		private var interval: Double

		/**
		 * @property repeated
		 * @since 0.7.0
		 * @hidden
		 */
		private var repeated: Bool

		/**
		 * @property module
		 * @since 0.7.0
		 * @hidden
		 */
		private var module: GlobalModule

		/**
		 * @property handle
		 * @since 0.7.0
		 * @hidden
		 */
		private var handle: Double

		/**
		 * @property timer
		 * @since 0.7.0
		 * @hidden
		 */
		private var timer: Timer?

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		init(callback: JavaScriptValue, interval: Double, repeated: Bool, module: GlobalModule, handle: Double) {

			self.callback = callback
			self.interval = interval
			self.repeated = repeated
			self.module = module
			self.handle = handle

			self.callback.protect()

			super.init()

			self.timer = Timer.scheduledTimer(timeInterval: (interval / 1000), target: self, selector: #selector(handleTimer), userInfo: nil, repeats: repeated)
		}

		/**
		 * @method execute
		 * @since 0.7.0
		 * @hidden
		 */
		public func execute() {

			self.callback.call()

			if (self.repeated == false) {
				self.cancel()
				self.remove()
			}
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 * @hidden
		 */
		public func cancel() {
			self.callback.unprotect()
			self.timer?.invalidate()
			self.timer = nil
		}

		/**
		 * @method remove
		 * @since 0.7.0
		 * @hidden
		 */
		public func remove() {
			self.module.scheduledTimers.removeValue(forKey: self.handle)
		}

		/**
		 * @method handleTimer
		 * @since 0.7.0
		 * @hidden
		 */
		@objc public func handleTimer() {
			self.execute()
		}
	}

	/**
	 * @struct ScheduledFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private class ScheduledFrame: NSObject {

		/**
		 * @property callback
		 * @since 0.7.0
		 * @hidden
		 */
		private var callback: JavaScriptValue

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		init(callback: JavaScriptValue) {
			self.callback = callback
			self.callback.protect()
		}

		/**
		 * @method invalidate
		 * @since 0.7.0
		 * @hidden
		 */
		public func execute() {
			self.callback.call()
			self.callback.unprotect()
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 * @hidden
		 */
		public func cancel() {
			self.callback.unprotect()
		}
	}
}

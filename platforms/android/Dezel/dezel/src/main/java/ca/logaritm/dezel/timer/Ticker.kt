package ca.logaritm.dezel.timer

/**
 * The timer's target interface.
 * @interface Ticker
 * @since 0.7.0
 */
public interface Ticker {

	/**
	 * Called when the timer fires.
	 * @method onTick
	 * @since 0.7.0
	 */
	fun onTick()
}
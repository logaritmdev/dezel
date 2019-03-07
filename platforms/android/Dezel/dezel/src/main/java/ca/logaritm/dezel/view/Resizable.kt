package ca.logaritm.dezel.view

/**
 * Provides the methods to manage a view that's size must be set manually.
 * @interface Resizable
 * @since 0.2.0
 */
public interface Resizable {
	fun onResize(t: Int, l: Int, w: Int, h: Int)
}
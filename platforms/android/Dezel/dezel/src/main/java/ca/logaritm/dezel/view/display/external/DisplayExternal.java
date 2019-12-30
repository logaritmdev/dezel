package ca.logaritm.dezel.view.display.external;

/**
 * @class DisplayExternal
 * @since 0.7.0
 */
public class DisplayExternal {

	/**
	 * @method create
	 * @since 0.7.0
	 * @hidden
	 */
	static native public long create(Object display);

	/**
	 * @method delete
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void delete(long handle);

	/**
	 * @method isInvalid
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean isInvalid(long handle);

	/**
	 * @method isResolving
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean isResolving(long handle);

	/**
	 * @method setWindow
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setWindow(long handle, long window);

	/**
	 * @method setScale
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setScale(long handle, double scale);

	/**
	 * @method setViewportWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setViewportWidth(long handle, double width);

	/**
	 * @method setViewportHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setViewportHeight(long handle, double height);

	/**
	 * @method setStylesheet
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setStylesheet(long handle, long stylesheet);
}

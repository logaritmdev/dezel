package ca.logaritm.dezel.layout;

public class LayoutExternal {

	/**
	 * @method create
	 * @since 0.4.0
	 * @hidden
	 */
	static native public long create(Layout context);

	/**
	 * @method delete
	 * @since 0.4.0
	 * @hidden
	 */
	static native public void delete(long handle);

	/**
	 * @method isInvalid
	 * @since 0.4.0
	 * @hidden
	 */
	static native public boolean isInvalid(long handle);

	/**
	 * @method isResolving
	 * @since 0.4.0
	 * @hidden
	 */
	static native public boolean isResolving(long handle);

	/**
	 * @method setRoot
	 * @since 0.4.0
	 * @hidden
	 */
	static native public void setRoot(long handle, long root);

	/**
	 * @method setViewportWidth
	 * @since 0.4.0
	 * @hidden
	 */
	static native public void setViewportWidth(long handle, double width);

	/**
	 * @method setViewportHeight
	 * @since 0.4.0
	 * @hidden
	 */
	static native public void setViewportHeight(long handle, double height);

	/**
	 * @method setScale
	 * @since 0.4.0
	 * @hidden
	 */
	static native public void setScale(long handle, double scale);
}

package ca.logaritm.dezel.view.display.external;

/**
 * @class DisplayNodeExternal
 * @since 0.7.0
 * @hidden
 */
public class DisplayNodeExternal {

	/**
	 * @method create
	 * @since 0.7.0
	 * @hidden
	 */
	static native public long create(Object layout);

	/**
	 * @method delete
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void delete(long handle);

	/**
	 * @method setDisplay
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setDisplay(long handle, long display);

	/**
	 * @method setOpaque
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setOpaque(long handle);

	/**
	 * @method setName
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setName(long handle, String name);

	/**
	 * @method setType
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setType(long handle, String name);

	/**
	 * @method appendStyle
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void appendStyle(long handle, String style);

	/**
	 * @method removeStyle
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void removeStyle(long handle, String style);

	/**
	 * @method hasStyle
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean hasStyle(long handle, String style);

	/**
	 * @method appendState
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void appendState(long handle, String state);

	/**
	 * @method removeState
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void removeState(long handle, String state);

	/**
	 * @method hasState
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean hasState(long handle, String state);

	/**
	 * @method setAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setAnchorTop(long handle, int type, int unit, double length);

	/**
	 * @method setAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setAnchorLeft(long handle, int type, int unit, double length);

	/**
	 * @method setTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setTop(long handle, int type, int unit, double length);

	/**
	 * @method setMinTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinTop(long handle, double min);

	/**
	 * @method setMaxTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxTop(long handle, double max);

	/**
	 * @method setLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setLeft(long handle, int type, int unit, double length);

	/**
	 * @method setMinLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinLeft(long handle, double min);

	/**
	 * @method setMaxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxLeft(long handle, double max);

	/**
	 * @method setRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setRight(long handle, int type, int unit, double length);

	/**
	 * @method setMinRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinRight(long handle, double min);

	/**
	 * @method setMaxRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxRight(long handle, double max);

	/**
	 * @method setBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setBottom(long handle, int type, int unit, double length);

	/**
	 * @method setMinBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinBottom(long handle, double min);

	/**
	 * @method setMaxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxBottom(long handle, double max);

	/**
	 * @method setWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setWidth(long handle, int type, int unit, double length);

	/**
	 * @method setMinWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinWidth(long handle, double min);

	/**
	 * @method setMaxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxWidth(long handle, double max);

	/**
	 * @method setHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setHeight(long handle, int type, int unit, double length);

	/**
	 * @method setMinHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinHeight(long handle, double min);

	/**
	 * @method setMaxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxHeight(long handle, double max);

	/**
	 * @method setContentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentDirection(long handle, int direction);

	/**
	 * @method setContentDisposition
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentDisposition(long handle, int location);

	/**
	 * @method setContentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentAlignment(long handle, int arrangement);

	/**
	 * @method setContentTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentTop(long handle, int type, int unit, double length);

	/**
	 * @method setContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentLeft(long handle, int type, int unit, double length);

	/**
	 * @method setContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentWidth(long handle, int type, int unit, double length);

	/**
	 * @method setContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setContentHeight(long handle, int type, int unit, double length);

	/**
	 * @method setBorderTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setBorderTop(long handle, int type, int unit, double length);

	/**
	 * @method setBorderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setBorderLeft(long handle, int type, int unit, double length);

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setBorderRight(long handle, int type, int unit, double length);

	/**
	 * @method setBorderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setBorderBottom(long handle, int type, int unit, double length);

	/**
	 * @method setMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMarginTop(long handle, int type, int unit, double length);

	/**
	 * @method setMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMarginLeft(long handle, int type, int unit, double length);

	/**
	 * @method setMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMarginRight(long handle, int type, int unit, double length);

	/**
	 * @method setMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMarginBottom(long handle, int type, int unit, double length);

	/**
	 * @method setMinMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinMarginTop(long handle, double min);

	/**
	 * @method setMaxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxMarginTop(long handle, double max);

	/**
	 * @method setMinMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinMarginLeft(long handle, double min);

	/**
	 * @method setMaxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxMarginLeft(long handle, double max);

	/**
	 * @method setMinMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinMarginRight(long handle, double min);

	/**
	 * @method setMaxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxMarginRight(long handle, double max);

	/**
	 * @method setMinMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinMarginBottom(long handle, double min);

	/**
	 * @method setMaxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxMarginBottom(long handle, double max);

	/**
	 * @method setPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setPaddingTop(long handle, int type, int unit, double length);

	/**
	 * @method setPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setPaddingLeft(long handle, int type, int unit, double length);

	/**
	 * @method setPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setPaddingRight(long handle, int type, int unit, double length);

	/**
	 * @method setPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setPaddingBottom(long handle, int type, int unit, double length);

	/**
	 * @method setMinPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinPaddingTop(long handle, double min);

	/**
	 * @method setMaxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxPaddingTop(long handle, double max);

	/**
	 * @method setMinPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinPaddingLeft(long handle, double min);

	/**
	 * @method setMaxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxPaddingLeft(long handle, double max);

	/**
	 * @method setMinPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinPaddingRight(long handle, double min);

	/**
	 * @method setMaxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxPaddingRight(long handle, double max);

	/**
	 * @method setMinPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMinPaddingBottom(long handle, double min);

	/**
	 * @method setMaxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setMaxPaddingBottom(long handle, double max);

	/**
	 * @method setExpandFactor
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setExpandFactor(long handle, double ratio);

	/**
	 * @method setShrinkFactor
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setShrinkFactor(long handle, double ratio);

	/**
	 * @method setVisible
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setVisible(long handle, boolean visible);

	/**
	 * @method invalidateSize
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void invalidateSize(long handle);

	/**
	 * @method invalidateOrigin
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void invalidateOrigin(long handle);

	/**
	 * @method invalidateLayout
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void invalidateLayout(long handle);

	/**
	 * @method resolve
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void resolve(long handle);

	/**
	 * @method measure
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void measure(long handle);

	/**
	 * @method appendChild
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void appendChild(long handle, long node);

	/**
	 * @method insertChild
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void insertChild(long handle, long node, int index);

	/**
	 * @method removeChild
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void removeChild(long handle, long node);

	/**
	 * @method isFillingParentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean isFillingParentWidth(long handle);

	/**
	 * @method isFillingParentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean isFillingParentHeight(long handle);

	/**
	 * @method isWrappingContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean isWrappingContentWidth(long handle);

	/**
	 * @method isWrappingContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public boolean isWrappingContentHeight(long handle);

	/**
	 * @method getMeasuredTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredTop(long handle);

	/**
	 * @method getMeasuredLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredLeft(long handle);

	/**
	 * @method getMeasuredRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredRight(long handle);

	/**
	 * @method getMeasuredBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredBottom(long handle);

	/**
	 * @method getMeasuredWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredWidth(long handle);

	/**
	 * @method getMeasuredHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredHeight(long handle);

	/**
	 * @method getMeasuredInnerWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredInnerWidth(long handle);

	/**
	 * @method getMeasuredInnerHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredInnerHeight(long handle);

	/**
	 * @method getMeasuredContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredContentWidth(long handle);

	/**
	 * @method getMeasuredContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredContentHeight(long handle);

	/**
	 * @method getMeasuredMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredMarginTop(long handle);

	/**
	 * @method getMeasuredMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredMarginLeft(long handle);

	/**
	 * @method getMeasuredMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredMarginRight(long handle);

	/**
	 * @method getMeasuredMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredMarginBottom(long handle);

	/**
	 * @method getMeasuredBorderTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredBorderTop(long handle);

	/**
	 * @method getMeasuredBorderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredBorderLeft(long handle);

	/**
	 * @method getMeasuredBorderRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredBorderRight(long handle);

	/**
	 * @method getMeasuredBorderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredBorderBottom(long handle);

	/**
	 * @method getMeasuredPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredPaddingTop(long handle);

	/**
	 * @method getMeasuredPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredPaddingLeft(long handle);

	/**
	 * @method getMeasuredPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredPaddingRight(long handle);

	/**
	 * @method getMeasuredPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	static native public double getMeasuredPaddingBottom(long handle);
}

package ca.logaritm.dezel.style;

/**
 * @class StylerNodeExternal
 * @since 0.1.0
 * @hidden
 */
public class StylerNodeExternal {

	public static int kDLStylerStyleItemUnitPX = 0;
	public static int kDLStylerStyleItemUnitPC = 1;
	public static int kDLStylerStyleItemUnitVW = 2;
	public static int kDLStylerStyleItemUnitVH = 3;
	public static int kDLStylerStyleItemUnitPW = 4;
	public static int kDLStylerStyleItemUnitPH = 5;
	public static int kDLStylerStyleItemUnitCW = 6;
	public static int kDLStylerStyleItemUnitCH = 7;
	public static int kDLStylerStyleItemUnitDeg = 8;
	public static int kDLStylerStyleItemUnitRad = 9;
	public static int kDLStylerStyleItemUnitNone = 10;

	public static int kDLStylerStyleItemTypeNull = 0;
	public static int kDLStylerStyleItemTypeString = 1;
	public static int kDLStylerStyleItemTypeNumber = 2;
	public static int kDLStylerStyleItemTypeBoolean = 3;

	/**
	 * @method parse
	 * @since 0.1.0
	 * @hidden
	 */
	static native long create(Object style);

	/**
	 * @method delete
	 * @since 0.1.0
	 * @hidden
	 */
	static native void delete(long handle);

	/**
	 * @method setId
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setId(long handle, String context);

	/**
	 * @method setStyler
	 * @since 0.1.0
	 * @hidden
	 */
	static native void setStyler(long handle, long context);

	/**
	 * @method setType
	 * @since 0.1.0
	 * @hidden
	 */
	static native void setType(long handle, String type);

	/**
	 * @method setVisible
	 * @since 0.1.0
	 * @hidden
	 */
	static native void setVisible(long handle, boolean visible);

	/**
	 * @method appendChild
	 * @since 0.1.0
	 * @hidden
	 */
	static native void appendChild(long handle, long node);

	/**
	 * @method insertChild
	 * @since 0.1.0
	 * @hidden
	 */
	static native void insertChild(long handle, long node, int index);

	/**
	 * @method removeChild
	 * @since 0.1.0
	 * @hidden
	 */
	static native void removeChild(long handle, long node);

	/**
	 * @method appendShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	static native void appendShadowedNode(long handle, long node);

	/**
	 * @method removeShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	static native void removeShadowedNode(long handle, long node);

	/**
	 * @method appendStyle
	 * @since 0.1.0
	 * @hidden
	 */
	static native void appendStyle(long handle, String trait);

	/**
	 * @method removeStyle
	 * @since 0.1.0
	 * @hidden
	 */
	static native void removeStyle(long handle, String trait);

	/**
	 * @method appendState
	 * @since 0.1.0
	 * @hidden
	 */
	static native void appendState(long handle, String state);

	/**
	 * @method removeState
	 * @since 0.1.0
	 * @hidden
	 */
	static native void removeState(long handle, String state);

	/**
	 * @method resolve
	 * @since 0.1.0
	 * @hidden
	 */
	static native void resolve(long handle);

	/**
	 * @method getData
	 * @since 0.3.0
	 * @hidden
	 */
	static native Object getData(long handle);

	/**
	 * @method getItemProperty
	 * @since 0.3.0
	 * @hidden
	 */
	static native String getItemProperty(long handle);

	/**
	 * @method setItemValueType
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setItemValueType(long handle, int type);

	/**
	 * @method getItemValueType
	 * @since 0.3.0
	 * @hidden
	 */
	static native int getItemValueType(long handle);

	/**
	 * @method setItemValueUnit
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setItemValueUnit(long handle, int unit);

	/**
	 * @method getItemValueUnit
	 * @since 0.3.0
	 * @hidden
	 */
	static native int getItemValueUnit(long handle);

	/**
	 * @method setItemValueWithString
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setItemValueWithString(long handle, String value);

	/**
	 * @method getItemValueAsString
	 * @since 0.3.0
	 * @hidden
	 */
	static native String getItemValueAsString(long handle);

	/**
	 * @method setItemValueWithNumber
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setItemValueWithNumber(long handle, double value);

	/**
	 * @method getItemValueAsNumber
	 * @since 0.3.0
	 * @hidden
	 */
	static native double getItemValueAsNumber(long handle);

	/**
	 * @method setItemValueWithBoolean
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setItemValueWithBoolean(long handle, boolean value);

	/**
	 * @method getItemValueAsBoolean
	 * @since 0.3.0
	 * @hidden
	 */
	static native boolean getItemValueAsBoolean(long handle);

	/**
	 * @method setItemData
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setItemData(long handle, Object data);

	/**
	 * @method getItemData
	 * @since 0.3.0
	 * @hidden
	 */
	static native Object getItemData(long handle);
}

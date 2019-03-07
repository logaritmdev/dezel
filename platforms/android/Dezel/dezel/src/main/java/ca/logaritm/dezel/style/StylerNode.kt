package ca.logaritm.dezel.style

import ca.logaritm.dezel.core.Property
import ca.logaritm.dezel.core.PropertyType
import ca.logaritm.dezel.core.PropertyUnit
import ca.logaritm.dezel.extension.Delegates

/**
 * Manages the stylerNode of a single node.
 * @class StylerNode
 * @since 0.1.0
 */
open class StylerNode(styler: Styler) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The stylerNode container observer.
	 * @property listener
	 * @since 0.1.0
	 */
	public var listener: StylerNodeListener? = null

	/**
	 * @property id
	 * @since 0.1.0
	 */
	open var id: String by Delegates.OnSet("") { value ->
		StylerNodeExternal.setId(this.handle, value)
	}

	/**
	 * @property type
	 * @since 0.1.0
	 * @hidden
	 */
	open var type: String by Delegates.OnSet("") { value ->
		StylerNodeExternal.setType(this.handle, value)
	}

	/**
	 * @property visible
	 * @since 0.1.0
	 * @hidden
	 */
	open var visible: Boolean by Delegates.OnSet(true) { value ->
		StylerNodeExternal.setVisible(this.handle, value)
	}

	/**
	 * @property handle
	 * @since 0.1.0
	 * @hidden
	 */
	internal var handle: Long = 0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.handle = StylerNodeExternal.create(this)
		StylerNodeExternal.setStyler(this.handle, styler.handle)
		StylerNodeReference.register(this)
	}
	/**
	 * @method appendChild
	 * @since 0.1.0
	 * @hidden
	 */
	open fun appendChild(node: StylerNode) {
		StylerNodeExternal.appendChild(this.handle, node.handle)
	}

	/**
	 * @method insertChild
	 * @since 0.1.0
	 * @hidden
	 */
	open fun insertChild(node: StylerNode, at: Int) {
		StylerNodeExternal.insertChild(this.handle, node.handle, at)
	}

	/**
	 * @method removeChild
	 * @since 0.1.0
	 * @hidden
	 */
	open fun removeChild(node: StylerNode) {
		StylerNodeExternal.removeChild(this.handle, node.handle)
	}

	/**
	 * @method appendShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	open fun appendShadowedNode(node: StylerNode) {
		StylerNodeExternal.appendShadowedNode(this.handle, node.handle)
	}

	/**
	 * @method removeShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	open fun removeShadowedNode(node: StylerNode) {
		StylerNodeExternal.removeShadowedNode(this.handle, node.handle)
	}

	/**
	 * @method appendStyle
	 * @since 0.1.0
	 * @hidden
	 */
	open fun appendStyle(trait: String) {
		StylerNodeExternal.appendStyle(this.handle, trait)
	}

	/**
	 * @method removeStyle
	 * @since 0.1.0
	 * @hidden
	 */
	open fun removeStyle(trait: String) {
		StylerNodeExternal.removeStyle(this.handle, trait)
	}

	/**
	 * @method appendState
	 * @since 0.1.0
	 * @hidden
	 */
	open fun appendState(state: String) {
		StylerNodeExternal.appendState(this.handle, state)
	}

	/**
	 * @method removeState
	 * @since 0.1.0
	 * @hidden
	 */
	open fun removeState(state: String) {
		StylerNodeExternal.removeState(this.handle, state)
	}

	/**
	 * @method resolve
	 * @since 0.1.0
	 * @hidden
	 */
	open fun resolve() {
		StylerNodeExternal.resolve(this.handle)
	}

	//-------------------------------------------------------------------------
	// Private API
	//-------------------------------------------------------------------------

	/**
	 * @method applyCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun applyCallback(node: Long, item: Long) {

		val stylerNode = StylerNodeExternal.getData(node)
		if (stylerNode == null) {
			return
		}

		if (stylerNode is StylerNode) {

			val name = StylerNodeExternal.getItemProperty(item)
			val type = StylerNodeExternal.getItemValueType(item)
			val unit = StylerNodeExternal.getItemValueUnit(item)
			val data = StylerNodeExternal.getItemData(item)

			if (data != null &&
				data is Property) {
				stylerNode.listener?.applyStyleProperty(stylerNode, name, data)
				return
			}

			val value: Property

			if (type == StylerNodeExternal.kDLStylerStyleItemTypeNumber) {

				when (unit) {

					StylerNodeExternal.kDLStylerStyleItemUnitPX   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.PX)
					StylerNodeExternal.kDLStylerStyleItemUnitPC   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.PC)
					StylerNodeExternal.kDLStylerStyleItemUnitVW   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.VW)
					StylerNodeExternal.kDLStylerStyleItemUnitVH   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.VH)
					StylerNodeExternal.kDLStylerStyleItemUnitPW   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.PW)
					StylerNodeExternal.kDLStylerStyleItemUnitPH   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.PH)
					StylerNodeExternal.kDLStylerStyleItemUnitCW   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.CW)
					StylerNodeExternal.kDLStylerStyleItemUnitCH   -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.CH)
					StylerNodeExternal.kDLStylerStyleItemUnitDeg  -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.DEG)
					StylerNodeExternal.kDLStylerStyleItemUnitRad  -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.RAD)
					StylerNodeExternal.kDLStylerStyleItemUnitNone -> value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.NONE)

					else                                          -> {
						value = Property(StylerNodeExternal.getItemValueAsNumber(item), PropertyUnit.NONE)
					}
				}

			} else if (type == StylerNodeExternal.kDLStylerStyleItemTypeString) {

				value = Property(StylerNodeExternal.getItemValueAsString(item))

			} else if (type == StylerNodeExternal.kDLStylerStyleItemTypeBoolean) {

				value = Property(StylerNodeExternal.getItemValueAsBoolean(item))

			} else {
				value = Property()
			}

			StylerNodeExternal.setItemData(item, value)

			stylerNode.listener?.applyStyleProperty(stylerNode, name, value)
		}
	}

	/**
	 * @method fetchCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun fetchCallback(node: Long, item: Long): Boolean {

		val stylerNode = StylerNodeExternal.getData(node)
		if (stylerNode == null) {
			return false
		}

		if (stylerNode is StylerNode) {

			val result = stylerNode.listener?.fetchStyleProperty(stylerNode, StylerNodeExternal.getItemProperty(item))
			if (result == null) {
				return false
			}

			if (result.type == PropertyType.STRING) {
				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeString)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				StylerNodeExternal.setItemValueWithString(item, result.string)
				return true
			}

			if (result.type == PropertyType.NUMBER) {

				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeNumber)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				StylerNodeExternal.setItemValueWithNumber(item, result.number)

				when (result.unit) {
					PropertyUnit.PX   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPX)
					PropertyUnit.PC   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPC)
					PropertyUnit.VW   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitVW)
					PropertyUnit.VH   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitVH)
					PropertyUnit.PW   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPW)
					PropertyUnit.PH   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPH)
					PropertyUnit.CW   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitCW)
					PropertyUnit.CH   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitCH)
					PropertyUnit.DEG  -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitDeg)
					PropertyUnit.RAD  -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitRad)
					PropertyUnit.NONE -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				}

				return true
			}

			if (result.type == PropertyType.BOOLEAN) {
				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeBoolean)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				StylerNodeExternal.setItemValueWithBoolean(item, result.boolean)
				return true
			}

			if (result.type == PropertyType.NULL) {
				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeNull)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				return true
			}
		}

		return false
	}

	/**
	 * @method invalidateCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun invalidateCallback() {
		this.listener?.onInvalidateStyleNode(this)
	}
}

package ca.logaritm.dezel.style

import ca.logaritm.dezel.core.JavaScriptPropertyType
import ca.logaritm.dezel.core.JavaScriptPropertyUnit
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.modules.view.JavaScriptView

/**
 * Manages the stylerNode of a single node.
 * @class StylerNode
 * @since 0.1.0
 */
open class StylerNode(styler: Styler, view: JavaScriptView) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The stylerNode container observer.
	 * @property listener
	 * @since 0.1.0
	 */
	public var listener: StylerNodeListener? = null

	public var view: JavaScriptView = view

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
	 * @method hasStyle
	 * @since 0.7.0
	 * @hidden
	 */
	open fun hasStyle(style: String): Boolean {
		return StylerNodeExternal.hasStyle(this.handle, style)
	}

	/**
	 * @method setStyle
	 * @since 0.7.0
	 * @hidden
	 */
	open fun setStyle(style: String, enable: Boolean = true) {
		StylerNodeExternal.setStyle(this.handle, style, enable)
	}

	/**
	 * @method hasState
	 * @since 0.7.0
	 * @hidden
	 */
	open fun hasState(state: String): Boolean {
		return StylerNodeExternal.hasState(this.handle, state)
	}

	/**
	 * @method setState
	 * @since 0.7.0
	 * @hidden
	 */
	open fun setState(state: String, enable: Boolean = true) {
		StylerNodeExternal.setState(this.handle, state, enable)
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

			if (type == StylerNodeExternal.kDLStylerStyleItemTypeNumber) {

				when (unit) {
					StylerNodeExternal.kDLStylerStyleItemUnitPX   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.PX)
					StylerNodeExternal.kDLStylerStyleItemUnitPC   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.PC)
					StylerNodeExternal.kDLStylerStyleItemUnitVW   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.VW)
					StylerNodeExternal.kDLStylerStyleItemUnitVH   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.VH)
					StylerNodeExternal.kDLStylerStyleItemUnitPW   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.PW)
					StylerNodeExternal.kDLStylerStyleItemUnitPH   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.PH)
					StylerNodeExternal.kDLStylerStyleItemUnitCW   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.CW)
					StylerNodeExternal.kDLStylerStyleItemUnitCH   -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.CH)
					StylerNodeExternal.kDLStylerStyleItemUnitDeg  -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.DEG)
					StylerNodeExternal.kDLStylerStyleItemUnitRad  -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.RAD)
					StylerNodeExternal.kDLStylerStyleItemUnitNone -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.NONE)
					else                                          -> this.view.setProperty(name, StylerNodeExternal.getItemValueAsNumber(item), JavaScriptPropertyUnit.NONE)
				}

			} else if (type == StylerNodeExternal.kDLStylerStyleItemTypeString) {
				this.view.setProperty(name, StylerNodeExternal.getItemValueAsString(item))
			} else if (type == StylerNodeExternal.kDLStylerStyleItemTypeBoolean) {
				this.view.setProperty(name, StylerNodeExternal.getItemValueAsBoolean(item))
			} else {
				this.view.setProperty(name, null)
			}
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

			val result = this.view.getProperty(StylerNodeExternal.getItemProperty(item))
			if (result == null) {
				return false
			}

			if (result.type == JavaScriptPropertyType.STRING) {
				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeString)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				StylerNodeExternal.setItemValueWithString(item, result.string)
				return true
			}

			if (result.type == JavaScriptPropertyType.NUMBER) {

				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeNumber)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				StylerNodeExternal.setItemValueWithNumber(item, result.number)

				when (result.unit) {
					JavaScriptPropertyUnit.PX   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPX)
					JavaScriptPropertyUnit.PC   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPC)
					JavaScriptPropertyUnit.VW   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitVW)
					JavaScriptPropertyUnit.VH   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitVH)
					JavaScriptPropertyUnit.PW   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPW)
					JavaScriptPropertyUnit.PH   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitPH)
					JavaScriptPropertyUnit.CW   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitCW)
					JavaScriptPropertyUnit.CH   -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitCH)
					JavaScriptPropertyUnit.DEG  -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitDeg)
					JavaScriptPropertyUnit.RAD  -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitRad)
					JavaScriptPropertyUnit.NONE -> StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				}

				return true
			}

			if (result.type == JavaScriptPropertyType.BOOLEAN) {
				StylerNodeExternal.setItemValueType(item, StylerNodeExternal.kDLStylerStyleItemTypeBoolean)
				StylerNodeExternal.setItemValueUnit(item, StylerNodeExternal.kDLStylerStyleItemUnitNone)
				StylerNodeExternal.setItemValueWithBoolean(item, result.boolean)
				return true
			}

			if (result.type == JavaScriptPropertyType.NULL) {
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

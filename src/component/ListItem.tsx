import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { Component } from './Component'
import './ListItem.ds.android'
import './ListItem.ds.ios'
import './ListItem.ds'


/**
 * The base class for items displayed in a list.
 * @class ListItem
 * @super Component
 * @since 0.1.0
 */
export class ListItem extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the state of this item is pressed.
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * Whether the state of this item is selected.
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * Whether the state of this item is disabled.
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	/**
	 * Whether this item is selectable.
	 * @property selectable
	 * @since 0.4.0
	 */
	public selectable: boolean = true

}

import { Dictionary } from 'lodash'
import { View } from '../view/View'
import { Component } from './Component'

/**
 * @symbol PROPERTIES
 * @since 0.7.0
 */
export const PROPERTIES = Symbol('properties')

/**
 * @symbol CHILDREN
 * @since 0.7.0
 */
export const CHILDREN = Symbol('children')

/**
 * @class Host
 * @sine 0.7.0
 */
export class Host {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The host's properties.
	 * @since 0.7.0
	 * @hidden
	 */
	public get properties(): Dictionary<any> | null {
		return this[PROPERTIES]
	}

	/**
	 * The host's children.
	 * @hidden
	 * @since 0.7.0
	 */
	public get children(): Array<View> | null {
		return this[CHILDREN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Appends the childrends to the specified view.
	 * @method appendTo
	 * @param view
	 */
	public appendTo(component: Component) {

		let children = this.children
		if (children) {

			for (let child of children) {
				component.append(child)
			}

		}

		// TODO
		// Manage properties

		this[PROPERTIES] = null
		this[CHILDREN] = null

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property PROPERTIES
	 * @since 0.7.0
	 * @hidden
	 */
	private [PROPERTIES]: Dictionary<any> | null = null

	/**
	 * @property CHILDREN
	 * @since 0.7.0
	 * @hidden
	 */
	private [CHILDREN]: Array<View> | null = null
}

export function setProperties(host: Host, properties: any) {
	host[PROPERTIES] = properties
}

export function setChildren(host: Host, children: Array<View>) {
	host[CHILDREN] = children
}
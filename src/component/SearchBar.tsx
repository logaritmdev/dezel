import { ref } from '../decorator/ref'
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Fragment } from '../view/Fragment'
import { TextInput } from '../form/TextInput'
import { Component } from './Component'
import { Button } from './Button'

import './SearchBar.ds'
import './SearchBar.ds.ios'
import './SearchBar.ds.android'

/**
 * Displays an bar with a search input element.
 * @class SearchBar
 * @super Component
 * @since 0.1.0
 */
export class SearchBar extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------
	// TODO
	// Use Watch
	/**
	 * @property placeholder
	 * @since 0.1.0
	 */
	public get placeholder(): string {
		return this.input.placeholder
	}

	/**
	 * @property placeholder
	 * @since 0.1.0
	 */
	public set placeholder(value: string) {
		this.input.placeholder = value
	}

	/**
	 * @property input
	 * @since 0.1.0
	 */
	@ref public input!: TextInput

	/**
	 * @property clearButton
	 * @since 0.1.0
	 */
	@ref public clearButton!: Button

	/**
	 * @property cancelButton
	 * @since 0.1.0
	 */
	@ref public cancelButton!: Button

	/**
	 * @property cancelable
	 * @since 0.1.0
	 */
	public cancelable: boolean = true

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<Fragment>
				<TextInput
					id="input"
					style="input"
					onChange={this.onSearchInputChange}
					onFocus={this.onSearchInputFocus}
					onBlur={this.onSearchInputBlur}
				/>
				<Button id="cancelButton" style="cancel-button" label="Cancel" onTap={this.onCancelButtonTap} />
			</Fragment>
		)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method onSearchInputChange
	 * @since 0.1.0
	 */
	@bound private onSearchInputChange(event: Event) {
		this.emit<SearchBarChangeEvent>('change', { data: { value: event.data.value } })
	}

	/**
	 * @method onSearchInputFocus
	 * @since 0.1.0
	 */
	@bound private onSearchInputFocus(event: Event) {
		this.setState('focused')
		this.emit(event)
	}

	/**
	 * @method onSearchInputBlur
	 * @since 0.1.0
	 */
	@bound private onSearchInputBlur(event: Event) {
		this.setState('focused', false)
		this.emit(event)
	}

	/**
	 * @method onCancelButtonTap
	 * @since 0.1.0
	 */
	@bound private onCancelButtonTap(event: Event) {
		this.input.blur()
	}
}

/**
 * @type SearchBarChangeEvent
 * @since 0.1.0
 */
export type SearchBarChangeEvent = {
	value: string
}
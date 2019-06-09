import { bound } from '../decorator/bound'
import { Event } from '../event/Event'
import { TextInput } from '../form/TextInput'
import { Reference } from '../util/Reference'
import { Fragment } from '../view/Fragment'
import { Button } from './Button'
import { Component } from './Component'
import './SearchBar.ds'
import './SearchBar.ds.android'
import './SearchBar.ds.ios'

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
	public get input(): TextInput {
		return this.inputRef.value!
	}

	/**
	 * @property clearButton
	 * @since 0.1.0
	 */
	public get clearButton(): Button {
		return this.clearButtonRef.value!
	}

	/**
	 * @property cancelButton
	 * @since 0.1.0
	 */
	public get cancelButton(): Button {
		return this.cancelButton.value!
	}

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
					ref={this.inputRef}
					style="input"
					onChange={this.onSearchInputChange}
					onFocus={this.onSearchInputFocus}
					onBlur={this.onSearchInputBlur}
				/>
				<Button ref={this.cancelButtonRef} style="cancel-button" label="Cancel" onTap={this.onCancelButtonTap} />
			</Fragment>
		)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property inputRef
	 * @since 0.7.0
	 * @hidden
	 */
	private inputRef = new Reference<TextInput>(this)

	/**
	 * @property clearButtonRef
	 * @since 0.7.0
	 * @hidden
	 */
	private clearButtonRef = new Reference<Button>(this)

	/**
	 * @property cancelButtonRef
	 * @since 0.7.0
	 * @hidden
	 */
	private cancelButtonRef = new Reference<Button>(this)

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
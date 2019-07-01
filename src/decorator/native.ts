/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(prototype: object, property: string) {

	function get(this: any) {
		return this.native[property]
	}

	function set(this: any, value: any) {
		this.native[property] = value == null ? value : (value.native || value)
	}

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * TODO: Decorator description
 * @function native
 * @since 0.1.0
 */
export function native(prototype: object, property: string) {
	decorate(prototype, property)
}

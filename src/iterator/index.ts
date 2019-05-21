/**
 * Creates an iterator for the specified array.
 * @function iterator
 * @since 0.6.0
 */
export function iterator<T>(array: Array<T>) {

	let index = 0

	return {

		next() {

			let value: T | null = null
			if (index < array.length) {
				value = array[index++]
			}

			return { done: value == null, value } as any as IteratorResult<T>
		}
	}
}
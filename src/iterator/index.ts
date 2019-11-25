/**
 * @function iterator
 * @since 0.6.0
 * @hidden
 */
export function iterator<T>(array: Array<T> | any) {

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
/**
 * @function append
 * @since 0.7.0
 * @hidden
 */
export function append(array: Array<any>, value: any) {

	let index = array.indexOf(value)
	if (index > -1) {
		return
	}

	array.push(value)
}

/**
 * @function insert
 * @since 0.7.0
 * @hidden
 */
export function insert(array: Array<any>, value: any, at: number) {

	let index = array.indexOf(value)
	if (index > -1) {
		return
	}

	array.splice(at, 0, value)
}

/**
 * @function remove
 * @since 0.7.0
 * @hidden
 */
export function remove(array: Array<any>, value: any) {

	let index = array.indexOf(value)
	if (index == -1) {
		return
	}

	array.splice(index, 1)

}
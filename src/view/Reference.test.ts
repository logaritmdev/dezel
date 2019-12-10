import { Reference } from './Reference'

describe('Reference', () => {

	let reference: Reference<any>

	beforeEach(() => {
		reference = new Reference<any>()
	})

	it('should set the reference', () => {
		let val = {}
		reference.set(val)
		expect(reference.value).toBe(val)
	})

	it('should set the reference only once', () => {
		let val = {}
		reference.set(val)
		expect(() => { reference.set(val) }).toThrow()
	})

	it('should throw an exception when getting a null reference', () => {
		expect(() => { reference.get() }).toThrow()
	})

})
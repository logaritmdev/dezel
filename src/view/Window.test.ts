import { Window } from './Window'

describe('Window', () => {

	let window: Window

	beforeEach(() => {
		window = new Window()
	})

	it('should have a native object', () => {
		expect(window.native).not.toBeUndefined()
		expect(window.native.holder).toBe(window)
	})
})
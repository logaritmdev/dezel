import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { native } from '../native/native'
import { Window } from './Window'

describe('Window', () => {

	let window: Window

	beforeAll(() => {
		Dezel.registerApplication(new Application)
	})

	beforeEach(() => {
		window = new Window()
	})

	it('should have a native object', () => {
		expect(native(window)).not.toBeUndefined()
	})

})
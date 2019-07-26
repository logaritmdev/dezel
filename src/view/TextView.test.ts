import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { TextView } from './TextView'

describe('TextView', () => {

	let view: TextView

	beforeAll(() => {
		Dezel.registerApplication(new Application)
	})

	beforeEach(() => {
		view = new TextView()
	})

	it('should have a native object', () => {
		expect(view.native).not.toBeUndefined()
	})

	it('should have a native object with an holder value', () => {
		expect(view.native.holder).toBe(view)
	})

})

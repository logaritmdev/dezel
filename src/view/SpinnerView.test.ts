import { native } from '../native/native'
import { SpinnerView } from './SpinnerView'

describe('SpinnerView', () => {

	let view: SpinnerView

	beforeEach(() => {
		view = new SpinnerView()
	})

	it('should have a native object', () => {
		expect(native(view)).not.toBeUndefined()
	})

	it('should have a valid initial spin property value', () => {
		expect(view.spin).toBe(false)
	})

	it('should have a valid initial tint property value', () => {
		expect(view.tint).toBe('#000')
	})
})

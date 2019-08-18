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

	it('should have a valid initial active property value', () => {
		expect(view.active).toBe(false)
	})

	it('should have a valid initial fontWeight property value', () => {
		expect(view.color).toBe('#000')
	})

})

import { SpinnerView } from './SpinnerView'

describe('SpinnerView', () => {

	let view: SpinnerView

	beforeEach(() => {
		view = new SpinnerView()
	})

	it('should have a native object', () => {
		expect(view.native).not.toBeUndefined()
		expect(view.native.holder).toBe(view)
	})
})

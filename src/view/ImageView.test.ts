import { ImageView } from './ImageView'

describe('ImageView', () => {

	let view: ImageView

	beforeEach(() => {
		view = new ImageView()
	})

	it('should have a native object', () => {
		expect(view.native).not.toBeUndefined()
		expect(view.native.holder).toBe(view)
	})
})

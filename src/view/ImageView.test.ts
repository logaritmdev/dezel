import { native } from '../native/native'
import { ImageView } from './ImageView'

describe('ImageView', () => {

	let view: ImageView

	beforeEach(() => {
		view = new ImageView()
	})

	it('should have a native object', () => {
		expect(native(view)).not.toBeUndefined()
	})

	it('should have a valid initial source property value', () => {
		expect(view.source).toBe(null)
	})

	it('should have a valid initial imageFit property value', () => {
		expect(view.imageFit).toBe('contain')
	})

	it('should have a valid initial imagePosition property value', () => {
		expect(view.imagePosition).toBe('center')
	})

	it('should have a valid initial tint property value', () => {
		expect(view.tint).toBe('transparent')
	})

})

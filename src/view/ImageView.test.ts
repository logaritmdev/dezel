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

	it('should have a native object with an holder value', () => {
		expect(native(view).holder).toBe(view)
	})

	it('should have a valid initial source property value', () => {
		expect(view.source).toBe(null)
	})

	it('should have a valid initial imageFit property value', () => {
		expect(view.imageFit).toBe('contain')
	})

	it('should have a valid initial imageAnchorTop property value', () => {
		expect(view.imageAnchorTop).toBe(0.5)
	})

	it('should have a valid initial imageAnchorLeft property value', () => {
		expect(view.imageAnchorLeft).toBe(0.5)
	})

	it('should have a valid initial imageTop property value', () => {
		expect(view.imageTop).toBe('50%')
	})

	it('should have a valid initial imageLeft property value', () => {
		expect(view.imageLeft).toBe('50%')
	})

	it('should have a valid initial imageWidth property value', () => {
		expect(view.imageWidth).toBe('auto')
	})

	it('should have a valid initial imageHeight property value', () => {
		expect(view.imageHeight).toBe('auto')
	})

	it('should have a valid initial imageFilter property value', () => {
		expect(view.imageFilter).toBe('none')
	})

	it('should have a valid initial imageTint property value', () => {
		expect(view.imageTint).toBe('transparent')
	})

})

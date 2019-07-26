import { WebView } from './WebView'

describe('WebView', () => {

	it('should have a native object', () => {
		let view = new WebView
		expect(view.native).not.toBeUndefined()
	})

})
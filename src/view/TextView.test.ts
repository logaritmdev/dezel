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

	it('should have a valid initial fontFamily property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial fontWeight property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial fontStyle property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial fontSize property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})


	it('should have a valid initial minFontSize property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial maxFontSize property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial text property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textAlignment property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textLocation property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textBaseline property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textKerning property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textLeading property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textShadowBlur property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textShadowColor property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textShadowOffsetTop property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textShadowOffsetLeft property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textDecoration property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textTransform property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial textOverflow property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial linkColor property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial lines property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

})

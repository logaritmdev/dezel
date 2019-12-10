import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { native } from '../native/native'
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
		expect(native(view)).not.toBeUndefined()
	})

	it('should have a valid initial fontFamily property value', () => {
		expect(view.fontFamily).toBe('default')
	})

	it('should have a valid initial fontWeight property value', () => {
		expect(view.fontWeight).toBe('normal')
	})

	it('should have a valid initial fontStyle property value', () => {
		expect(view.fontStyle).toBe('normal')
	})

	it('should have a valid initial fontSize property value', () => {
		expect(view.fontSize).toBe(17)
	})

	it('should have a valid initial minFontSize property value', () => {
		expect(view.minFontSize).toBe(0)
	})

	it('should have a valid initial maxFontSize property value', () => {
		expect(view.maxFontSize).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial text property value', () => {
		expect(view.text).toBe('')
	})

	it('should have a valid initial textColor property value', () => {
		expect(view.textColor).toBe('#000')
	})

	it('should have a valid initial textAlign property value', () => {
		expect(view.textAlign).toBe('left')
	})

	it('should have a valid initial textBaseline property value', () => {
		expect(view.textBaseline).toBe(0)
	})

	it('should have a valid initial textKerning property value', () => {
		expect(view.textKerning).toBe(0)
	})

	it('should have a valid initial textLeading property value', () => {
		expect(view.textLeading).toBe(0)
	})

	it('should have a valid initial textTransform property value', () => {
		expect(view.textTransform).toBe('none')
	})

	it('should have a valid initial textOverflow property value', () => {
		expect(view.textOverflow).toBe('ellipsis')
	})

	it('should have a valid initial textShadowBlur property value', () => {
		expect(view.textShadowBlur).toBe(0)
	})

	it('should have a valid initial textShadowColor property value', () => {
		expect(view.textShadowColor).toBe('#000')
	})

	it('should have a valid initial textShadowOffsetTop property value', () => {
		expect(view.textShadowOffsetTop).toBe(0)
	})

	it('should have a valid initial textShadowOffsetLeft property value', () => {
		expect(view.textShadowOffsetLeft).toBe(0)
	})

	it('should have a valid initial textDecoration property value', () => {
		expect(view.textDecoration).toBe('none')
	})

	it('should have a valid initial linkColor property value', () => {
		expect(view.linkColor).toBe('blue')
	})

	it('should have a valid initial lines property value', () => {
		expect(view.maxLines).toBe(0)
	})

})

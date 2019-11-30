import { setEventSender } from './private/Event'
import { setEventTarget } from './private/Event'
import { Emitter } from './Emitter'
import { Event } from './Event'
import { EventOptions } from './Event'

function create<T extends any = any>(type: string, options: EventOptions<T> = {}) {
	return new Event(type, options)
}

describe('Event', () => {

	it('should lowercase the event type', () => {
		let event = new Event('TEST')
		expect(event.type).toBe('test')
	})

	it('should not be propagable by default', () => {
		let event = new Event('test')
		expect(event.propagable).toBe(false)
	})

	it('should not be capturable by default', () => {
		let event = new Event('test')
		expect(event.capturable).toBe(false)
	})

	it('should not be cancelable by default', () => {
		let event = new Event('test')
		expect(event.cancelable).toBe(false)
	})

	it('should be propagable if required', () => {
		let event = new Event('test', { propagable: true })
		expect(event.propagable).toBe(true)
	})

	it('should be capturable if required', () => {
		let event = new Event('test', { capturable: true })
		expect(event.capturable).toBe(true)
	})

	it('should be cancelable if required', () => {
		let event = new Event('test', { cancelable: true })
		expect(event.cancelable).toBe(true)
	})

	it('should allow custom data', () => {
		let event = new Event('test', { data: { key: 'val' } })
		expect(event.data).toEqual(jasmine.objectContaining({ key: 'val' }))
	})

	it('should prevent event capturing if capturable is false', () => {

		let event = create('test', { capturable: false })

		let capture = () => {
			event.capture()
		}

		expect(capture).toThrow()
		expect(event.captured).toBe(false)
	})

	it('should prevent event canceling if cancelable is false', () => {

		let event = create('test', { cancelable: false })

		let cancel = () => {
			event.cancel()
		}

		expect(cancel).toThrow()
		expect(event.canceled).toBe(false)
	})

	it('should support event capturing', () => {
		let event = create('test', { capturable: true })
		event.capture()
		expect(event.captured).toBe(true)
	})

	it('should support event canceling', () => {
		let event = create('test', { cancelable: true })
		event.cancel()
		expect(event.canceled).toBe(true)
	})

	it('should not capture a canceled touch', () => {
		let event = create('test', { capturable: true, cancelable: true })
		event.cancel()
		event.capture()
		expect(event.canceled).toBe(true)
		expect(event.captured).toBe(false)
	})

	it('should set the sender', () => {

		let value = new Emitter()
		let event = create('test')
		setEventSender(event, value)

		expect(event.sender).toBe(value)
	})

	it('shluld set the target', () => {

		let value = new Emitter()
		let event = create('test')
		setEventTarget(event, value)

		expect(event.target).toBe(value)
	})

})
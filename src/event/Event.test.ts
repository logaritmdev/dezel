import { Emitter } from './Emitter'
import { Event } from './Event'
import { EventOptions } from './Event'

function create<T extends any = any>(type: string, options: EventOptions<T> = {}) {
	return new Event(type, options)
}

it('should lowercase the event type', () => {
	let event = new Event('TEST')
	expect(event.type).toBe('test')
})

it('should not be propagable by default', () => {
	let event = new Event('test')
	expect(event.propagable).toBe(false)
})

it('should not be cancelable by default', () => {
	let event = new Event('test')
	expect(event.cancelable).toBe(false)
})

it('should be propagable if required', () => {
	let event = new Event('test', { propagable: true })
	expect(event.propagable).toBe(true)
})

it('should be cancelable if required', () => {
	let event = new Event('test', { cancelable: true })
	expect(event.cancelable).toBe(true)
})

it('should allow custom data', () => {
	let event = new Event('test', { data: { key: 'val' } })
	expect(event.data).toEqual(jasmine.objectContaining({ key: 'val' }))
})

it('should prevent event canceling if cancelable is true', () => {

	let event = create('test', { cancelable: false })

	let cancel = () => {
		event.cancel()
	}

	expect(cancel).toThrow()
	expect(cancel).toThrowError('Event error: This event cannot be stopped because it is not cancelable.')
	expect(event.canceled).toBe(false)
})

it('should support event canceling if cancelable is true', () => {
	let event = create('test', { cancelable: true })
	event.cancel()
	expect(event.canceled).toBe(true)
})

it('should set the sender', () => {

	let value = new Emitter()
	let event = create('test')
	event.setSender(value)

	expect(event.sender).toBe(value)
})

it('shluld set the target', () => {

	let value = new Emitter()
	let event = create('test')
	event.setTarget(value)

	expect(event.target).toBe(value)
})
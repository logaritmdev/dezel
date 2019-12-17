import { $listeners } from './private/Emitter'
import { $responder } from './private/Emitter'
import { Emitter } from './Emitter'
import { Event } from './Event'

describe('Emitter', () => {

	let emitter: Emitter

	beforeEach(() => {
		emitter = new Emitter()
	})

	it('should initialize the responder property', () => {
		expect(emitter.responder).toBe(null)
	})

	it('should register an event listener', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.on('event', l1)
		emitter.on('EVENT', l2)

		let listeners = getListeners(emitter, 'event')
		expect(listeners[0]).toBe(l1)
		expect(listeners[1]).toBe(l2)

	})

	it('should register an event that will run only once', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.once('event', l1)
		emitter.once('EVENT', l2)

		let listeners = getListeners(emitter, 'event')
		expect(listeners[0]).not.toBeUndefined()
		expect(listeners[1]).not.toBeUndefined()
	})

	it('should unregister an event listener', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.on('event', l1)
		emitter.on('EVENT', l2)

		emitter.off('event', l1)
		emitter.off('EVENT', l2)

		let listeners = getListeners(emitter, 'event')
		expect(listeners[0]).toBeUndefined()
		expect(listeners[1]).toBeUndefined()
	})

	it('should emit an event', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.on('event', l1)
		emitter.on('EVENT', l2)

		emitter.emit('event')

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)
	})

	it('should emit an event with a specific event object', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.on('event', l1)
		emitter.on('EVENT', l2)

		emitter.emit(new Event('event'))

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)
	})

	it('should execute the listener', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.on('event', l1)
		emitter.on('EVENT', l2)

		emitter.emit('event')
		emitter.emit('event')
		emitter.emit('event')

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(3)
		expect(l2).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l2).toHaveBeenCalledTimes(3)
	})

	it('should execute the listener only once', () => {

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()

		emitter.once('event', l1)
		emitter.once('EVENT', l2)

		emitter.emit('event')
		emitter.emit('event')
		emitter.emit('event')

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)
	})

	it('should execute the listener only once when using the same callback', () => {

		let l1 = jasmine.createSpy()

		let em1 = new Emitter()
		let em2 = new Emitter()

		em1.once('event', l1)
		em2.once('event', l1)

		em1.emit('event')
		em1.emit('event')
		em1.emit('event')

		em2.emit('event')
		em2.emit('event')
		em2.emit('event')

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(2)
	})

	it('should execute the internal onEvent listener', () => {

		emitter.onEvent = jasmine.createSpy()

		emitter.emit('event')
		emitter.emit('event')
		emitter.emit('event')

		expect(emitter.onEvent).toHaveBeenCalledWith(jasmine.any(Event))
		expect(emitter.onEvent).toHaveBeenCalledTimes(3)
	})

	it('should property set the target and sender', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(emitter, [r1, r2])

		let l1 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.target).toBe(emitter)
			expect(event.sender).toBe(emitter)
		})

		let l2 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.target).toBe(emitter)
			expect(event.sender).toBe(r1)
		})

		let l3 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.target).toBe(emitter)
			expect(event.sender).toBe(r2)
		})

		emitter.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		emitter.emit(new Event('event', { propagable: true }))
	})

	it('should propagate a propagable event', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(emitter, [r1, r2])

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()
		let l3 = jasmine.createSpy()

		emitter.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		emitter.emit(new Event('event', { propagable: true }))

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)
		expect(l3).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l3).toHaveBeenCalledTimes(1)
	})

	it('should not propagate a non-propagable event', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(emitter, [r1, r2])

		let l1 = jasmine.createSpy()
		let l2 = jasmine.createSpy()
		let l3 = jasmine.createSpy()

		emitter.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		emitter.emit(new Event('event', { propagable: false }))

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).not.toHaveBeenCalled()
		expect(l3).not.toHaveBeenCalled()
	})

	it('should stop event propagation when the event is canceled', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(emitter, [r1, r2])

		let l1 = jasmine.createSpy().and.callFake((event: Event) => {
			event.cancel()
		})

		let l2 = jasmine.createSpy()
		let l3 = jasmine.createSpy()

		emitter.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		emitter.emit(new Event('event', {
			propagable: true,
			cancelable: true
		}))

		expect(l1).toHaveBeenCalledWith(jasmine.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).not.toHaveBeenCalled()
		expect(l3).not.toHaveBeenCalled()
	})

})

function getListeners(emitter: Emitter, type: string) {
	return emitter[$listeners][type]
}

function setResponders(emitter: Emitter, responders: Array<Emitter>) {

	emitter[$responder] = responders[0]

	for (let i = 0; i < responders.length - 1; i++) {
		responders[i][$responder] = responders[i + 1]
	}
}

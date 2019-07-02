import { Emitter } from '../Emitter'
import { LISTENERS } from '../Emitter'
import { Event } from '../Event'

describe('Emitter', () => {

	let e: Emitter

	beforeEach(() => {
		e = new Emitter()
	})

	it('should initialize the responder property', () => {
		expect(e.responder).toBe(null)
	})

	it('should register an event listener', () => {

		let l1 = jest.fn()
		let l2 = jest.fn()

		e.on('event', l1)
		e.on('EVENT', l2)

		let listeners = getListeners(e, 'event')
		expect(listeners[0]).toBe(l1)
		expect(listeners[1]).toBe(l2)

	})

	it('should register an event that will run only once', () => {

		let l1 = jest.fn()
		let l2 = jest.fn()

		e.one('event', l1)
		e.one('EVENT', l2)

		let listeners = getListeners(e, 'event')
		expect(listeners[0]).not.toBeUndefined()
		expect(listeners[1]).not.toBeUndefined()

	})

	it('should unregister an event listener', () => {

		let l1 = jest.fn()
		let l2 = jest.fn()

		e.on('event', l1)
		e.on('EVENT', l2)

		e.off('event', l1)
		e.off('EVENT', l2)

		let listeners = getListeners(e, 'event')
		expect(listeners[0]).toBe(undefined)
		expect(listeners[1]).toBe(undefined)

	})

	it('should emit an event', () => {

		let l1 = jest.fn()
		let l2 = jest.fn()

		e.on('event', l1)
		e.on('EVENT', l2)

		e.emit('event')

		expect(l1).toHaveBeenCalledWith(expect.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(expect.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)

	})

	it('should emit an event with a specific event object', () => {

		let l1 = jest.fn()
		let l2 = jest.fn()

		e.on('event', l1)
		e.on('EVENT', l2)

		e.emit(new Event('event'))

		expect(l1).toHaveBeenCalledWith(expect.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(expect.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)

	})

	it('should execute the listener the right amount of time', () => {

		let l1 = jest.fn()
		let l2 = jest.fn()
		let l3 = jest.fn()
		let l4 = jest.fn()

		e.on('event', l1)
		e.on('EVENT', l2)

		e.one('event', l3)
		e.one('EVENT', l4)

		e.emit('event')
		e.emit('event')
		e.emit('event')

		expect(l1).toHaveBeenCalledWith(expect.any(Event))
		expect(l1).toHaveBeenCalledTimes(3)
		expect(l2).toHaveBeenCalledWith(expect.any(Event))
		expect(l2).toHaveBeenCalledTimes(3)
		expect(l3).toHaveBeenCalledWith(expect.any(Event))
		expect(l3).toHaveBeenCalledTimes(1)
		expect(l4).toHaveBeenCalledWith(expect.any(Event))
		expect(l4).toHaveBeenCalledTimes(1)
	})

	it('should execute the internal onEmit listener', () => {

		e.onEmit = jest.fn()

		e.emit('event')
		e.emit('event')
		e.emit('event')

		expect(e.onEmit).toHaveBeenCalledWith(expect.any(Event))
		expect(e.onEmit).toHaveBeenCalledTimes(3)
	})

	it('should property set the target and sender', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(e, [r1, r2])

		let l1 = jest.fn(event => {
			expect(event.target).toBe(e)
			expect(event.sender).toBe(e)
		})

		let l2 = jest.fn(event => {
			expect(event.target).toBe(e)
			expect(event.sender).toBe(r1)
		})

		let l3 = jest.fn(event => {
			expect(event.target).toBe(e)
			expect(event.sender).toBe(r2)
		})

		e.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		e.emit(new Event('event', { propagable: true }))

	})

	it('should propagate a propagable event', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(e, [r1, r2])

		let l1 = jest.fn()
		let l2 = jest.fn()
		let l3 = jest.fn()

		e.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		e.emit(new Event('event', { propagable: true }))

		expect(l1).toHaveBeenCalledWith(expect.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).toHaveBeenCalledWith(expect.any(Event))
		expect(l2).toHaveBeenCalledTimes(1)
		expect(l3).toHaveBeenCalledWith(expect.any(Event))
		expect(l3).toHaveBeenCalledTimes(1)

	})

	it('should not propagate a non-propagable event', () => {

		let r1 = new Emitter()
		let r2 = new Emitter()

		setResponders(e, [r1, r2])

		let l1 = jest.fn()
		let l2 = jest.fn()
		let l3 = jest.fn()

		e.on('event', l1)
		r1.on('event', l2)
		r2.on('event', l3)

		e.emit(new Event('event', { propagable: false }))

		expect(l1).toHaveBeenCalledWith(expect.any(Event))
		expect(l1).toHaveBeenCalledTimes(1)
		expect(l2).not.toHaveBeenCalled()
		expect(l3).not.toHaveBeenCalled()

	})

})

function getListeners(emitter: Emitter, type: string) {
	return emitter[LISTENERS][type]
}

function setResponders(emitter: Emitter, responders: Array<Emitter>) {

	emitter.setResponder(responders[0])

	for (let i = 0; i < responders.length - 1; i++) {
		responders[i].setResponder(
			responders[i + 1]
		)
	}
}

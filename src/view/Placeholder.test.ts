import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { Event } from '../event/Event'
import { Placeholder } from './Placeholder'
import { View } from './View'

describe('Placeholder', () => {

	let placeholder: Placeholder

	beforeAll(() => {
		Dezel.registerApplication(new Application)
	})

	beforeEach(() => {
		placeholder = new Placeholder()
	})

	it('should insert the placeholder at the beginning of the view', () => {

		let view = new View()

		view.append(placeholder)

		expect(placeholder.parent).toBe(view)
	})

	it('should insert the placeholder view in the containing view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()

		view.append(placeholder)

		placeholder.append(child1)
		placeholder.append(child2)

		expect(placeholder.children[0]).toBe(child1)
		expect(placeholder.children[1]).toBe(child2)
		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
	})

	it('should insert the initial placeholder views in the containing view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()

		placeholder.append(child1)
		placeholder.append(child2)

		view.append(placeholder)

		expect(placeholder.children.length).toBe(2)
		expect(placeholder.children[0]).toBe(child1)
		expect(placeholder.children[1]).toBe(child2)

		expect(view.children.length).toBe(2)
		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
	})

	it('should insert the placeholder view correctly', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.append(placeholder)
		view.append(child1)
		view.append(child2)

		placeholder.append(child3)
		placeholder.append(child4)

		expect(placeholder.children[0]).toBe(child3)
		expect(placeholder.children[1]).toBe(child4)

		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
		expect(view.children[2]).toBe(child3)
		expect(view.children[3]).toBe(child4)

	})

	it('should remove the placeholder view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.append(placeholder)
		view.append(child1)
		view.append(child2)

		placeholder.append(child3)
		placeholder.append(child4)

		placeholder.remove(child3)
		placeholder.remove(child4)

		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
		expect(view.children[2]).toBeUndefined()
		expect(view.children[3]).toBeUndefined()

	})

	it('should emit an insert event', () => {

		let child1 = new View()
		let child2 = new View()

		let fn1 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(child1)
			expect(event.data.index).toBe(0)
		})

		let fn2 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(child2)
			expect(event.data.index).toBe(1)
		})

		placeholder.one('insert', fn1)
		placeholder.append(child1)
		placeholder.one('insert', fn2)
		placeholder.append(child2)

		expect(fn1).toHaveBeenCalled()
		expect(fn2).toHaveBeenCalled()
	})

	it('should emit an remove event', () => {

		let child1 = new View()
		let child2 = new View()

		let fn1 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(child2)
			expect(event.data.index).toBe(1)
		})

		let fn2 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(child1)
			expect(event.data.index).toBe(0)
		})

		placeholder.append(child1)
		placeholder.append(child2)

		placeholder.one('remove', fn1)
		placeholder.remove(child2)
		placeholder.one('remove', fn2)
		placeholder.remove(child1)

		expect(fn1).toHaveBeenCalled()
		expect(fn2).toHaveBeenCalled()
	})

})
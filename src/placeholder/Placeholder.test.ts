import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { Location } from './Placeholder'
import { Placeholder } from './Placeholder'

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

		view.insertPlaceholder(placeholder)

		expect(placeholder.view).toBe(view)
		expect(placeholder.position).toBe(0)
		expect(placeholder.location).toBe(Location.Float)
	})

	it('should insert the placeholder at the end of the receiver', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()

		view.append(child1)
		view.append(child2)

		view.insertPlaceholder(placeholder)

		expect(placeholder.view).toBe(view)
		expect(placeholder.position).toBe(2)
		expect(placeholder.location).toBe(Location.Float)
	})

	it('should insert the placeholder view in the containing view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()

		view.insertPlaceholder(placeholder)

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

		view.insertPlaceholder(placeholder)

		expect(placeholder.children.length).toBe(2)
		expect(placeholder.children[0]).toBe(child1)
		expect(placeholder.children[1]).toBe(child2)

		expect(view.children.length).toBe(2)
		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)

		expect(placeholder.position).toBe(0)
	})

	it('should insert the placeholder view correctly using Location.Start', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.insertPlaceholder(placeholder, Location.Start)
		view.append(child1)
		view.append(child2)

		placeholder.append(child3)
		placeholder.append(child4)

		expect(placeholder.children[0]).toBe(child3)
		expect(placeholder.children[1]).toBe(child4)
		expect(placeholder.position).toBe(0)

		expect(view.children[0]).toBe(child4)
		expect(view.children[1]).toBe(child3)
		expect(view.children[2]).toBe(child1)
		expect(view.children[3]).toBe(child2)

	})

	it('should insert the placeholder view correctly using the Location.Fixed method', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		child1.id = 'child 1'
		child2.id = 'child 2'
		child3.id = 'child 3'
		child4.id = 'child 4'

		view.insertPlaceholder(placeholder, Location.Fixed, 1)
		view.append(child1)
		view.append(child2)

		placeholder.append(child3)
		placeholder.append(child4)

		expect(placeholder.children[0]).toBe(child3)
		expect(placeholder.children[1]).toBe(child4)
		expect(placeholder.position).toBe(1)

		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child4)
		expect(view.children[2]).toBe(child3)
		expect(view.children[3]).toBe(child2)

	})

	it('should insert the placeholder view correctly using Location.Float', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.insertPlaceholder(placeholder)
		view.append(child1)
		view.append(child2)

		placeholder.append(child3)
		placeholder.append(child4)

		expect(placeholder.children[0]).toBe(child3)
		expect(placeholder.children[1]).toBe(child4)
		expect(placeholder.position).toBe(2)

		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
		expect(view.children[2]).toBe(child3)
		expect(view.children[3]).toBe(child4)

	})

	it('should insert the placeholder view correctly using Location.End', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.insertPlaceholder(placeholder, Location.End)
		view.append(child1)
		view.append(child2)

		placeholder.append(child3)
		placeholder.append(child4)

		expect(placeholder.children[0]).toBe(child3)
		expect(placeholder.children[1]).toBe(child4)
		expect(placeholder.position).toBe(0)

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

		view.insertPlaceholder(placeholder, Location.End)
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
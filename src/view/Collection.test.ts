import { $target } from './private/Collection'
import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { Event } from '../event/Event'
import { Collection } from './Collection'
import { View } from './View'

describe('Collection', () => {

	let collection: Collection

	beforeAll(() => {
		Dezel.registerApplication(new Application)
	})

	beforeEach(() => {
		collection = new Collection()
	})

	it('should insert the collection at the beginning of the view', () => {

		let view = new View()

		view.append(collection)

		expect(collection[$target]).toBe(view)
	})

	it('should insert the collection view in the containing view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()

		view.append(collection)

		collection.append(child1)
		collection.append(child2)

		expect(collection.get(0)).toBe(child1)
		expect(collection.get(1)).toBe(child2)
		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
	})

	it('should insert the initial collection views in the containing view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()

		collection.append(child1)
		collection.append(child2)

		view.append(collection)

		expect(collection.get.length).toBe(2)
		expect(collection.get(0)).toBe(child1)
		expect(collection.get(1)).toBe(child2)

		expect(view.children.length).toBe(2)
		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
	})

	it('should insert the collection view correctly', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.append(collection)
		view.append(child1)
		view.append(child2)

		collection.append(child3)
		collection.append(child4)

		expect(collection.get(0)).toBe(child3)
		expect(collection.get(1)).toBe(child4)

		expect(view.children[0]).toBe(child1)
		expect(view.children[1]).toBe(child2)
		expect(view.children[2]).toBe(child3)
		expect(view.children[3]).toBe(child4)

	})

	it('should remove the collection view', () => {

		let view = new View()
		let child1 = new View()
		let child2 = new View()
		let child3 = new View()
		let child4 = new View()

		view.append(collection)
		view.append(child1)
		view.append(child2)

		collection.append(child3)
		collection.append(child4)

		collection.remove(child3)
		collection.remove(child4)

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

		collection.one('insert', fn1)
		collection.append(child1)
		collection.one('insert', fn2)
		collection.append(child2)

		expect(fn1).toHaveBeenCalled()
		expect(fn2).toHaveBeenCalled()
	})

	it('should emit a remove event', () => {

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

		collection.append(child1)
		collection.append(child2)

		collection.one('remove', fn1)
		collection.remove(child2)
		collection.one('remove', fn2)
		collection.remove(child1)

		expect(fn1).toHaveBeenCalled()
		expect(fn2).toHaveBeenCalled()
	})

})
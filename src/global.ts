/* disable-sort-imports */
/// <reference path="global.d.ts" />
import { Event } from './global/Event'
import { EventTarget } from './global/EventTarget'
import { XMLHttpRequest } from './global/XMLHttpRequest'
import { XMLHttpRequestUpload } from './global/XMLHttpRequestUpload'
import { WebSocket } from './global/WebSocket'
import { Dezel } from './core/Dezel'

global.Event = Event
global.EventTarget = EventTarget
global.XMLHttpRequest = XMLHttpRequest
global.XMLHttpRequestUpload = XMLHttpRequestUpload
global.WebSocket = WebSocket

global.postMessage = function () {

}

/**
 * The global location object.
 * @global location
 * @since 0.1.0
 */
Object.defineProperty(global, 'location', {
	value: {
		protocol: 'http:',
		hostname: '0.0.0.0',
		port: '',
		href: 'http://localhost',
		search: '',
		reload: function () {
			Dezel.reloadApplication()
		}
	}
})
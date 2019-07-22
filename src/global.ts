/* disable-sort-imports */
/// <reference path="global.d.ts" />
import { EventTarget } from './global/EventTarget'
import { Event } from './global/Event'
import { XMLHttpRequest } from './global/XMLHttpRequest'
import { XMLHttpRequestUpload } from './global/XMLHttpRequestUpload'
import { WebSocket } from './global/WebSocket'

global.Event = Event
global.EventTarget = EventTarget
global.XMLHttpRequest = XMLHttpRequest
global.XMLHttpRequestUpload = XMLHttpRequestUpload
global.WebSocket = WebSocket

global.toNative = function (object: any) {
	return object.native
}
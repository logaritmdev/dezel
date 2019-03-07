
import './web/Event'
import './web/EventTarget'
import './web/CloseEvent'
import './web/MessageEvent'
import './web/ProgressEvent'
import './web/WebSocket'
import './web/XMLHttpRequest'
import './web/XMLHttpRequestUpload'

declare const dezel: any

/**
 * @function globalize
 * @since 0.1.0
 * @hidden
 */
const globalize = function (object: any) {

	for (let key in object) {

		let method = object[key]
		if (method == null) {
			continue
		}

		if (typeof method == 'function') {

			Object.defineProperty(self, key, {
				value: method.bind(object),
				writable: false,
				enumerable: false,
				configurable: true
			})

		}
	}
}

/**
 * The global event target.
 * @const events
 * @since 0.1.0
 */
globalize(new EventTarget)

/**
 * The global functions.
 * @const events
 * @since 0.1.0
 */
globalize(new (dezel.imports('dezel.web.WebGlobal')))

self.postMessage = function () {

}

/**
 * The global location object.
 * @global location
 * @since 0.1.0
 */
Object.defineProperty(self, 'location', {
	value: {
		protocol: 'http:',
		hostname: '0.0.0.0',
		port: '',
		href: 'http://localhost',
		search: '',
		reload: function () {
			dezel.reload()
		}
	}
})
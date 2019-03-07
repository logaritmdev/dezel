/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./index.ts");
/******/ })
/************************************************************************/
/******/ ({

/***/ "../../src/decorator/bridge.ts":
/*!************************************************************!*\
  !*** /Users/jpdery/Projects/dezel/src/decorator/bridge.ts ***!
  \************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var decorate = function (constructor, classname) {
    var symbol = Symbol('native');
    var get = function () {
        var native = this[symbol];
        if (native == null) {
            native = this[symbol] = new (dezel.imports(classname));
            native.holder = this;
        }
        return native;
    };
    dezel.exports(classname, constructor);
    Object.defineProperty(constructor.prototype, 'native', { get: get });
};
/**
 * TODO: Decorator description
 * @function bridge
 * @since 0.1.0
 */
function bridge(classname) {
    return function (constructor) {
        decorate(constructor, classname);
    };
}
exports.bridge = bridge;


/***/ }),

/***/ "../../src/decorator/native.ts":
/*!************************************************************!*\
  !*** /Users/jpdery/Projects/dezel/src/decorator/native.ts ***!
  \************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var decorate = function (prototype, property) {
    var get = function () {
        return this.native[property];
    };
    var set = function (value) {
        this.native[property] = isNative(value) ? value.native : value;
    };
    Object.defineProperty(prototype, property, { get: get, set: set });
};
/**
 * @function isNative
 * @since 0.1.0
 */
var isNative = function (value) {
    return value && typeof value == 'object' && 'native' in value;
};
/**
 * TODO: Decorator description
 * @function native
 * @since 0.1.0
 */
function native(prototype, property) {
    decorate(prototype, property);
}
exports.native = native;


/***/ }),

/***/ "./index.ts":
/*!******************!*\
  !*** ./index.ts ***!
  \******************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
__webpack_require__(/*! ./web/Event */ "./web/Event.ts");
__webpack_require__(/*! ./web/EventTarget */ "./web/EventTarget.ts");
__webpack_require__(/*! ./web/CloseEvent */ "./web/CloseEvent.ts");
__webpack_require__(/*! ./web/MessageEvent */ "./web/MessageEvent.ts");
__webpack_require__(/*! ./web/ProgressEvent */ "./web/ProgressEvent.ts");
__webpack_require__(/*! ./web/WebSocket */ "./web/WebSocket.ts");
__webpack_require__(/*! ./web/XMLHttpRequest */ "./web/XMLHttpRequest.ts");
__webpack_require__(/*! ./web/XMLHttpRequestUpload */ "./web/XMLHttpRequestUpload.ts");
/**
 * @function globalize
 * @since 0.1.0
 * @hidden
 */
var globalize = function (object) {
    for (var key in object) {
        var method = object[key];
        if (method == null) {
            continue;
        }
        if (typeof method == 'function') {
            Object.defineProperty(self, key, {
                value: method.bind(object),
                writable: false,
                enumerable: false,
                configurable: true
            });
        }
    }
};
/**
 * The global event target.
 * @const events
 * @since 0.1.0
 */
globalize(new EventTarget);
/**
 * The global functions.
 * @const events
 * @since 0.1.0
 */
globalize(new (dezel.imports('dezel.web.WebGlobal')));
self.postMessage = function () {
};
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
            dezel.reload();
        }
    }
});


/***/ }),

/***/ "./web/CloseEvent.ts":
/*!***************************!*\
  !*** ./web/CloseEvent.ts ***!
  \***************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * @class CloseEvent
 * @since 0.1.0
 */
var CloseEvent = /** @class */ (function (_super) {
    __extends(CloseEvent, _super);
    function CloseEvent() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return CloseEvent;
}(Event));
exports.CloseEvent = CloseEvent;
/**
 * @global CloseEvent
 * @since 0.1.0
 */
Object.defineProperty(self, "CloseEvent", {
    value: CloseEvent,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/Event.ts":
/*!**********************!*\
  !*** ./web/Event.ts ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Symbols
 */
exports.TYPE = Symbol('type');
/**
 * @class Event
 * @since 0.1.0
 */
var Event = /** @class */ (function () {
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    /**
     * @constructor
     * @since 0.1.0
     */
    function Event(type, options) {
        this[exports.TYPE] = type;
        if (options) {
            Object.assign(this, options);
        }
    }
    Object.defineProperty(Event.prototype, "type", {
        //--------------------------------------------------------------------------
        // Properties
        //--------------------------------------------------------------------------
        /**
         * @property type
         * @since 0.1.0
         */
        get: function () {
            return this[exports.TYPE];
        },
        enumerable: true,
        configurable: true
    });
    /**
     * @method preventDefault
     * @since 0.1.0
     */
    Event.prototype.preventDefault = function () {
    };
    /**
     * @method stopPropagation
     * @since 0.1.0
     */
    Event.prototype.stopPropagation = function () {
    };
    /**
     * @method stopImmediatePropagation
     * @since 0.1.0
     */
    Event.prototype.stopImmediatePropagation = function () {
    };
    return Event;
}());
exports.Event = Event;
/**
 * @global Event
 * @since 0.1.0
 */
Object.defineProperty(self, "Event", {
    value: Event,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/EventTarget.ts":
/*!****************************!*\
  !*** ./web/EventTarget.ts ***!
  \****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var _a;
"use strict";
/**
 * Symbols
 */
exports.LISTENERS = Symbol('listeners');
/**
 * @class Event
 * @since 0.1.0
 */
var EventTarget = /** @class */ (function () {
    function EventTarget() {
        //--------------------------------------------------------------------------
        // Methods
        //--------------------------------------------------------------------------
        //--------------------------------------------------------------------------
        // Private api
        //--------------------------------------------------------------------------
        /**
         * @property listeners
         * @since 0.1.0
         */
        this[_a] = {};
    }
    /**
     * @method addEventListener
     * @since 0.1.0
     */
    EventTarget.prototype.addEventListener = function (type, listener, options) {
        var listeners = this[exports.LISTENERS][type];
        if (listeners == null) {
            listeners = this[exports.LISTENERS][type] = [];
        }
        if (listeners.indexOf(listener) == -1) {
            listeners.push(listener);
        }
        return this;
    };
    /**
     * @method dispatchEvent
     * @since 0.1.0
     */
    EventTarget.prototype.dispatchEvent = function (event) {
        var callback = this['on' + event.type];
        if (callback) {
            callback.apply(this, arguments);
        }
        var listeners = this[exports.LISTENERS][event.type];
        if (listeners == null) {
            return false;
        }
        listeners = listeners.slice(0);
        for (var _i = 0, listeners_1 = listeners; _i < listeners_1.length; _i++) {
            var listener = listeners_1[_i];
            listener.call(event);
        }
        return true;
    };
    /**
     * @method removeEventListener
     * @since 0.1.0
     */
    EventTarget.prototype.removeEventListener = function (type, listener, options) {
        var listeners = this[exports.LISTENERS][type];
        if (listeners == null) {
            return;
        }
        var index = listeners.indexOf(listener);
        if (index > -1) {
            listeners.splice(index, 1);
        }
        if (listeners.length == 0) {
            delete this[exports.LISTENERS][type];
        }
        return this;
    };
    return EventTarget;
}());
_a = exports.LISTENERS;
exports.EventTarget = EventTarget;
/**
 * @global EventTarget
 * @since 0.1.0
 */
Object.defineProperty(self, "EventTarget", {
    value: EventTarget,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/MessageEvent.ts":
/*!*****************************!*\
  !*** ./web/MessageEvent.ts ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * @class MessageEvent
 * @since 0.1.0
 */
var MessageEvent = /** @class */ (function (_super) {
    __extends(MessageEvent, _super);
    function MessageEvent() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return MessageEvent;
}(Event));
exports.MessageEvent = MessageEvent;
/**
 * @global MessageEvent
 * @since 0.1.0
 */
Object.defineProperty(self, "MessageEvent", {
    value: MessageEvent,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/ProgressEvent.ts":
/*!******************************!*\
  !*** ./web/ProgressEvent.ts ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * @class ProgressEvent
 * @since 0.1.0
 */
var ProgressEvent = /** @class */ (function (_super) {
    __extends(ProgressEvent, _super);
    function ProgressEvent() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return ProgressEvent;
}(Event));
exports.ProgressEvent = ProgressEvent;
/**
 * @global ProgressEvent
 * @since 0.1.0
 */
Object.defineProperty(self, "ProgressEvent", {
    value: ProgressEvent,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/WebSocket.ts":
/*!**************************!*\
  !*** ./web/WebSocket.ts ***!
  \**************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
var bridge_1 = __webpack_require__(/*! ../../../src/decorator/bridge */ "../../src/decorator/bridge.ts");
var native_1 = __webpack_require__(/*! ../../../src/decorator/native */ "../../src/decorator/native.ts");
/**
 * @const Ready States
 * @since 0.1.0
 */
var ReadyState;
(function (ReadyState) {
    ReadyState[ReadyState["Connecting"] = 0] = "Connecting";
    ReadyState[ReadyState["Open"] = 1] = "Open";
    ReadyState[ReadyState["Closing"] = 2] = "Closing";
    ReadyState[ReadyState["Closed"] = 3] = "Closed";
})(ReadyState = exports.ReadyState || (exports.ReadyState = {}));
var WebSocket = /** @class */ (function (_super) {
    __extends(WebSocket, _super);
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    /**
     * @constructor
     * @since 0.1.0
     */
    function WebSocket(url, protocols) {
        var _this = _super.call(this) || this;
        /**
         * @property binaryType
         * @since 0.1.0
         */
        _this.binaryType = 'blob';
        if (protocols) {
            protocols = Array.isArray(protocols) ? protocols : [protocols];
        }
        _this.native.open(url, protocols);
        return _this;
    }
    Object.defineProperty(WebSocket.prototype, "url", {
        //--------------------------------------------------------------------------
        // Properties
        //--------------------------------------------------------------------------
        /**
         * The URL as resolved by the constructor.
         * @property url
         * @since 0.1.0
         */
        get: function () {
            return this.native.url;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(WebSocket.prototype, "protocol", {
        /**
         * The protocol selected by the server.
         * @property protocol
         * @since 0.1.0
         */
        get: function () {
            return this.native.protocol;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(WebSocket.prototype, "extensions", {
        /**
         * The extensions selected by the server.
         * @property extensions
         * @since 0.1.0
         */
        get: function () {
            return this.native.extensions;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(WebSocket.prototype, "readyState", {
        /**
         * The current state of the connection.
         * @property readyState
         * @since 0.1.0
         */
        get: function () {
            return this.native.readyState;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(WebSocket.prototype, "bufferedAmount", {
        /**
         * @property bufferedAmount
         * @since 0.1.0
         */
        get: function () {
            return this.native.bufferedAmount;
        },
        enumerable: true,
        configurable: true
    });
    /**
     * Enqueues the specified data to be transmitted to the server.
     * @method send
     * @since 0.1.0
     */
    WebSocket.prototype.send = function (data) {
        this.native.send(data);
    };
    /**
     * Closes the WebSocket connection or connection attempt, if any.
     * @method close
     * @since 0.1.0
     */
    WebSocket.prototype.close = function (code, reason) {
        this.native.close(code, reason);
    };
    __decorate([
        native_1.native
    ], WebSocket.prototype, "binaryType", void 0);
    WebSocket = __decorate([
        bridge_1.bridge("dezel.web.WebSocket")
        /**
         * @class WebSocket
         * @since 0.1.0
         */
    ], WebSocket);
    return WebSocket;
}(EventTarget));
/**
 * @global WebSocket
 * @since 0.1.0
 */
Object.defineProperty(self, "WebSocket", {
    value: WebSocket,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/XMLHttpRequest.ts":
/*!*******************************!*\
  !*** ./web/XMLHttpRequest.ts ***!
  \*******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
var bridge_1 = __webpack_require__(/*! ../../../src/decorator/bridge */ "../../src/decorator/bridge.ts");
var native_1 = __webpack_require__(/*! ../../../src/decorator/native */ "../../src/decorator/native.ts");
/**
 * @const Ready States
 * @since 0.1.0
 */
var ReadyState;
(function (ReadyState) {
    ReadyState[ReadyState["Unsent"] = 0] = "Unsent";
    ReadyState[ReadyState["Opened"] = 1] = "Opened";
    ReadyState[ReadyState["HeadersReceived"] = 2] = "HeadersReceived";
    ReadyState[ReadyState["Loading"] = 3] = "Loading";
    ReadyState[ReadyState["Done"] = 4] = "Done";
})(ReadyState = exports.ReadyState || (exports.ReadyState = {}));
var XMLHttpRequest = /** @class */ (function (_super) {
    __extends(XMLHttpRequest, _super);
    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------
    /**
     * @constructor
     * @since 0.1.0
     */
    function XMLHttpRequest() {
        return _super.call(this) || this;
    }
    /**
     * @method open
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.open = function (method, url, async, username, password) {
        this.native.open(method, url, async, username, password);
    };
    /**
     * @method send
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.send = function (data) {
        this.native.send(data);
    };
    /**
     * @method abort
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.abort = function () {
        this.native.abort();
    };
    /**
     * @method overrideMimeType
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.overrideMimeType = function (mime) {
        this.native.overrideMimeType(mime);
    };
    /**
     * @method setRequestHeader
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.setRequestHeader = function (header, value) {
        this.native.setRequestHeader(header, value);
    };
    /**
     * @method getAllResponseHeaders
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.getAllResponseHeaders = function () {
        return this.native.getAllResponseHeaders();
    };
    /**
     * @method getResponseHeader
     * @since 0.1.0
     */
    XMLHttpRequest.prototype.getResponseHeader = function () {
        return this.native.getResponseHeader();
    };
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "readyState", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "response", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "responseText", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "responseType", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "responseURL", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "responseXML", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "status", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "statusText", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "timeout", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "upload", void 0);
    __decorate([
        native_1.native
    ], XMLHttpRequest.prototype, "withCredentials", void 0);
    XMLHttpRequest = __decorate([
        bridge_1.bridge("dezel.web.XMLHttpRequest")
        /**
         * @class XMLHttpRequest
         * @since 0.1.0
         */
    ], XMLHttpRequest);
    return XMLHttpRequest;
}(EventTarget));
/**
 * @global XMLHttpRequest
 * @since 0.1.0
 */
Object.defineProperty(self, "XMLHttpRequest", {
    value: XMLHttpRequest,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ }),

/***/ "./web/XMLHttpRequestUpload.ts":
/*!*************************************!*\
  !*** ./web/XMLHttpRequestUpload.ts ***!
  \*************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
var bridge_1 = __webpack_require__(/*! ../../../src/decorator/bridge */ "../../src/decorator/bridge.ts");
/**
 * @const Ready States
 * @since 0.1.0
 */
var ReadyState;
(function (ReadyState) {
    ReadyState[ReadyState["Unsent"] = 0] = "Unsent";
    ReadyState[ReadyState["Opened"] = 1] = "Opened";
    ReadyState[ReadyState["HeadersReceived"] = 2] = "HeadersReceived";
    ReadyState[ReadyState["Loading"] = 3] = "Loading";
    ReadyState[ReadyState["Done"] = 4] = "Done";
})(ReadyState = exports.ReadyState || (exports.ReadyState = {}));
var XMLHttpRequestUpload = /** @class */ (function (_super) {
    __extends(XMLHttpRequestUpload, _super);
    /**
     * @class XMLHttpRequest
     * @since 0.1.0
     */
    function XMLHttpRequestUpload() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    XMLHttpRequestUpload = __decorate([
        bridge_1.bridge("dezel.web.XMLHttpRequestUpload")
        /**
         * @class XMLHttpRequest
         * @since 0.1.0
         */
    ], XMLHttpRequestUpload);
    return XMLHttpRequestUpload;
}(EventTarget));
/**
 * @global XMLHttpRequestUpload
 * @since 0.1.0
 */
Object.defineProperty(self, "XMLHttpRequestUpload", {
    value: XMLHttpRequest,
    writable: false,
    enumerable: false,
    configurable: true
});


/***/ })

/******/ });
//# sourceMappingURL=runtime.js.map
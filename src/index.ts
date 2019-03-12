/// <reference path="global.d.ts" />

/*
 * Application
 */

export { Application } from './application/Application'
export { ApplicationKeyboardEvent } from './application/Application'
export { ApplicationHandleLinkEvent } from './application/Application'
export { ApplicationReceiveRemoteNotificationsTokenEvent } from './application/Application'
export { ApplicationLauncher } from './application/ApplicationLauncher'

/*
 * Bluetooth
 */

export { BluetoothManager } from './bluetooth/BluetoothManager'
export { BluetoothManagerOptions } from './bluetooth/BluetoothManager'

/*
 * Connectivity
 */

export { ConnectivityManager } from './connectivity/ConnectivityManager'
export { ConnectivityManagerOptions } from './connectivity/ConnectivityManager'

/*
 * Screen
 */

export { Screen } from './screen/Screen'
export { Switch } from './screen/Switch'
export { SwitchBeforeSelectEvent } from './screen/Switch'
export { SwitchSelectEvent } from './screen/Switch'
export { SwitchDeselectEvent } from './screen/Switch'
export { Header } from './screen/Header'
export { Footer } from './screen/Footer'
export { Content } from './screen/Content'
export { ScreenBeforePresentEvent } from './screen/Screen'
export { ScreenPresentEvent } from './screen/Screen'
export { ScreenBeforeDismissEvent } from './screen/Screen'
export { ScreenDismissEvent } from './screen/Screen'
export { ScreenBeforeEnterEvent } from './screen/Screen'
export { ScreenEnterEvent } from './screen/Screen'
export { ScreenBeforeLeaveEvent } from './screen/Screen'
export { ScreenLeaveEvent } from './screen/Screen'
export { ScreenTransition } from './screen/transition/ScreenTransition'
export { ScreenTransitionRegistry } from './screen/transition/ScreenTransition'
export { ScreenNoneTransition } from './screen/transition/ScreenNoneTransition'
export { ScreenFadeTransition } from './screen/transition/ScreenFadeTransition'
export { ScreenSlideTransition } from './screen/transition/ScreenSlideTransition'
export { ScreenCoverTransition } from './screen/transition/ScreenCoverTransition'
export { ScreenDissolveTransition } from './screen/transition/ScreenDissolveTransition'
export { ScreenDismissGesture } from './screen/gesture/ScreenDismissGesture'
export { ScreenSlideDismissGesture } from './screen/gesture/ScreenSlideDismissGesture'

/*
 * Component
 */

export { Component } from './component/Component'
export { Button } from './component/Button'
export { Dots } from './component/Dots'
export { NavigationBar } from './component/NavigationBar'
export { NavigationBarButton } from './component/NavigationBarButton'
export { NavigationBarBackButton } from './component/NavigationBarBackButton'
export { NavigationBarCloseButton } from './component/NavigationBarCloseButton'
export { List } from './component/List'
export { ListSelectEvent } from './component/List'
export { ListDeselectEvent } from './component/List'
export { ListManager } from './component/ListManager'
export { ListItem } from './component/ListItem'
export { SegmentedBar } from './component/SegmentedBar'
export { SegmentedBarBeforeSelectEvent } from './component/SegmentedBar'
export { SegmentedBarSelectEvent } from './component/SegmentedBar'
export { SegmentedBarDeselectEvent } from './component/SegmentedBar'
export { SegmentedBarButton } from './component/SegmentedBarButton'
export { TabBar } from './component/TabBar'
export { TabBarBeforeSelectEvent } from './component/TabBar'
export { TabBarSelectEvent } from './component/TabBar'
export { TabBarDeselectEvent } from './component/TabBar'
export { TabBarButton } from './component/TabBarButton'
export { SearchBar } from './component/SearchBar'
export { SearchBarChangeEvent } from './component/SearchBar'
export { Refresher } from './component/Refresher'
export { Pager } from './component/Pager'
export { PagerItem } from './component/PagerItem'
export { Spinner } from './component/Spinner'

/*
 * Data
 */

export { DataSource } from './data/DataSource'
export { DataSourceOptions } from './data/DataSource'

/*
 * Decorator
 */

export { ref } from './decorator/ref'
export { bound } from './decorator/bound'
export { state } from './decorator/state'
export { watch } from './decorator/watch'
export { bridge } from './decorator/bridge'
export { native } from './decorator/native'

/*
 * Device
 */

import { Device } from './device/Device'

/*
 * Dialog
 */

export { Alert } from './dialog/Alert'
export { AlertOptions } from './dialog/Alert'
export { AlertButton } from './dialog/AlertButton'
export { AlertButtonOptions } from './dialog/AlertButton'

/*
 * Event
 */

export { Emitter } from './event/Emitter'
export { Event } from './event/Event'
export { EventOptions } from './event/Event'

/*
 * Form
 */

export { Form } from './form/Form'
export { Field } from './form/Field'
export { Label } from './form/Label'
export { TextArea } from './form/TextArea'
export { TextAreaChangeEvent } from './form/TextArea'
export { TextInput } from './form/TextInput'
export { TextInputChangeEvent } from './form/TextInput'

/*
 * Geom
 */

export { Size } from './geom/Size'
export { Point2D } from './geom/Point2d'
export { Point3D } from './geom/Point3d'
export { Transform2D } from './geom/Transform2d'
export { Transform3D } from './geom/Transform3d'

/*
 * Gesture
 */

export { Gesture } from './gesture/Gesture'
export { GestureOptions } from './gesture/Gesture'
export { GestureEvent } from './gesture/GestureEvent'
export { GestureEventOptions } from './gesture/GestureEvent'
export { TapGesture } from './gesture/TapGesture'
export { TapGestureEvent } from './gesture/TapGestureEvent'
export { TapGestureEventOptions } from './gesture/TapGestureEvent'
export { PanGesture } from './gesture/PanGesture'
export { PanGestureEvent } from './gesture/PanGestureEvent'
export { PanGestureEventOptions } from './gesture/PanGestureEvent'

/*
 * Graphic
 */

export { Image } from './graphic/Image'
export { Canvas } from './graphic/Canvas'

/*
 * Location
 */

export { LocationManager } from './location/LocationManager'
export { LocationManagerOptions } from './location/LocationManager'

/*
 * Notification
 */

export { NotificationManager } from './notification/NotificationManager'
export { NotificationManagerOptions } from './notification/NotificationManager'

/*
 * Translation
 */

export { TranslationManager } from './translation/TranslationManager'
import { __ } from './translation/TranslationManager'
import { _x } from './translation/TranslationManager'
import { t } from './translation/TranslationManager'

/*
 * Content Optimizer
 */

export { ContentOptimizer } from './optimize/ContentOptimizer'
export { ContentOptimizerTransition } from './optimize/ContentOptimizerTransition'
export { ContentOptimizerFadeTransition } from './optimize/ContentOptimizerFadeTransition'
export { ListOptimizer } from './optimize/ListOptimizer'

/*
 * Platform
 */

import { Platform } from './platform/Platform'

/*
 * Storage
 */

import { Storage } from './storage/Storage'

/*
 * Touch
 */

export { Touch } from './touch/Touch'
export { TouchEvent } from './touch/TouchEvent'
export { TouchEventOptions } from './touch/TouchEvent'

/*
 * View
 */

export { Fragment } from './view/Fragment'
export { SpinnerView } from './view/SpinnerView'
export { View } from './view/View'
export { ViewInsertEvent } from './view/View'
export { ViewMoveToWindowEvent } from './view/View'
export { ViewMoveToParentEvent } from './view/View'
export { ViewRedrawEvent } from './view/View'
export { ViewTransitionOptions } from './view/View'
export { TextView } from './view/TextView'
export { ImageView } from './view/ImageView'
export { WebView } from './view/WebView'
export { Window } from './view/Window'
export { AnimationDurationRegistry } from './view/View'
export { AnimationEquationRegistry } from './view/View'

/*
 * View
 */

export { createElement } from './jsx/createElement'

/**
 * The device.
 * @const device
 * @since 0.4.0
 */
Object.defineProperty(self, 'device', {
	value: new Device(),
	writable: false,
	enumerable: true,
	configurable: true
})

/**
 * The application storage.
 * @const storage
 * @since 0.1.0
 */
Object.defineProperty(self, 'storage', {
	value: new Storage(),
	writable: false,
	enumerable: true,
	configurable: true
})

/**
 * The application storage.
 * @const storage
 * @since 0.1.0
 */
Object.defineProperty(self, 'storage', {
	value: new Storage(),
	writable: false,
	enumerable: true,
	configurable: true
})

/**
 * The application platform.
 * @const platform
 * @since 0.1.0
 */
Object.defineProperty(self, 'platform', {
	value: new Platform(),
	writable: false,
	enumerable: true,
	configurable: true
})

/**
 * Text translation function.
 * @const t
 * @since 0.5.0
 */
Object.defineProperty(self, 't', {
	value: t,
	writable: false,
	enumerable: true,
	configurable: true
})

/**
 * Text translation function.
 * @const __
 * @since 0.5.0
 */
Object.defineProperty(self, '__', {
	value: __,
	writable: false,
	enumerable: true,
	configurable: true
})

/**
 * Text translation function.
 * @const _x
 * @since 0.5.0
 */
Object.defineProperty(self, '_x', {
	value: _x,
	writable: false,
	enumerable: true,
	configurable: true
})

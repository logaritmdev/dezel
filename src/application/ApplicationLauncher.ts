import { Application } from './Application'

/**
 * The application launcher.
 * @class Application
 * @super Emitter
 * @since 0.5.0
 */
export class ApplicationLauncher {

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
	 * The application's main instance.
	 * @method launch
	 * @since 0.5.0
	 */
	public static launch(application: Application) {
		application.native.run()
		application.emit('create')
	}
}

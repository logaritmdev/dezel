/**
 * @class ApplicationModule
 * @since 0.1.0
 */
public class ApplicationModule: Module {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	public override func initialize() {
		self.context.registerClass("dezel.application.Application", value: Application.self)
	}
}

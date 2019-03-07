/**
 * @class PlatformModule
 * @since 0.1.0
 * @hidden
 */
public class PlatformModule : Module {

    /**
     * @inherited
     * @method initialize
     * @since 0.1.0
     */
	public override func initialize() {
		self.context.registerClass("dezel.platform.Platform", type: Platform.self)
	}
}

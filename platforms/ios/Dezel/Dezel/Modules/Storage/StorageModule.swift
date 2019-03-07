/**
 * @class StorageModule
 * @since 0.1.0
 * @hidden
 */
public class StorageModule : Module {

    /**
     * @inherited
     * @method initialize
     * @since 0.1.0
     */
	public override func initialize() {
		self.context.registerClass("dezel.storage.Storage", type: Storage.self)
	}
}

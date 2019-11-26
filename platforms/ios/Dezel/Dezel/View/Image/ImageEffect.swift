/**
 * @class ImageEffect
 * @since 0.5.0
 */
public class ImageEffect {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.5.0
	 * @hidden
	 */
	private static var context: CIContext = CIContext(options: nil)

	/**
	 * @property filters
	 * @since 0.5.0
	 * @hidden
	 */
	private static var filters: [ImageFilter: CIFilter] = [:]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method grayscale
	 * @since 0.5.0
	 */
	public static func grayscale(_ source: CGImage) -> CGImage? {

		guard let filter = self.filter(named: .grayscale) else {
			return nil
		}

		filter.setValue(CIImage(cgImage: source), forKey: kCIInputImageKey)

		return self.process(filter)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method filter
	 * @since 0.5.0
	 * @hidden
	 */
	private static func filter(named name: ImageFilter) -> CIFilter? {

		if let filter = self.filters[name] {
			return filter
		}

		var filter: CIFilter?

		switch (name) {

			case .sepia:
				filter = CIFilter(name: "CISepiaTone")
			case .grayscale:
				filter = CIFilter(name: "CIPhotoEffectNoir")

			default:
				filter = nil
		}

		self.filters[name] = filter

		return filter
	}

	/**
	 * @method process
	 * @since 0.5.0
	 * @hidden
	 */
	private static func process(_ filter: CIFilter) -> CGImage? {

		guard let output = filter.outputImage else {
        	return nil
		}

        return self.context.createCGImage(output, from: output.extent)
	}
}

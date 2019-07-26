/**
 * @extension JavaScriptContext
 * @since 0.7.0
 * @hidden
 */
internal extension HTTPURLResponse {
	var statusText: String {
		return HTTPURLResponse.localizedString(forStatusCode: self.statusCode)
	}
}

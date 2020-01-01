/**
 * @protocol TouchCancelable
 * @since 0.7.0
 */
public protocol TouchCancelable {

    /**
     * @method cancelTouchEvent
     * @since 0.7.0
     */
    func cancelTouchEvent(touches: Set<UITouch>, with event: UIEvent)

}

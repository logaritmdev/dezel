package ca.logaritm.dezel.view.trait

import android.view.MotionEvent

/**
 * @interface TouchCancelable
 * @since 0.7.0
 */
public interface TouchCancelable {

    /**
     * @method cancelTouchEvent
     * @since 0.7.0
     */
    fun cancelTouchEvent(event: MotionEvent)

}
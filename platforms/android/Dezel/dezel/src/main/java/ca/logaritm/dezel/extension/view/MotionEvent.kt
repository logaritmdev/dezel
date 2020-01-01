package ca.logaritm.dezel.extension.view

import android.view.MotionEvent

/**
 * @property MotionEvent.pointer
 * @since 0.7.0
 */
val MotionEvent.pointer
    get() = this.getPointerId(this.actionIndex)
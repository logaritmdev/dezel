package ca.logaritm.dezel.text.span

import android.text.TextPaint
import android.text.style.URLSpan
import ca.logaritm.dezel.view.ContentTextView
import ca.logaritm.dezel.view.type.TextDecoration

open class LinkSpan(url: String, color: Int, decoration: TextDecoration): URLSpan(url) {

	private var color: Int = color

	private var decoration: TextDecoration = decoration

	override fun updateDrawState(ds: TextPaint) {

		ds.color = this.color

		when (this.decoration) {
			TextDecoration.UNDERLINE   -> ds.isUnderlineText = true
			TextDecoration.LINETHROUGH -> ds.isStrikeThruText = true
		}
	}

	open fun onClick(textView: ContentTextView) {
		textView.contentViewListener?.onPressLink(textView, this.url)
	}
}
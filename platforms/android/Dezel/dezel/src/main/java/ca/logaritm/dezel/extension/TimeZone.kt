package ca.logaritm.dezel.extension

import java.util.*

internal object Timezone {
	internal val utc: TimeZone
		get() = TimeZone.getTimeZone("UTC")
}

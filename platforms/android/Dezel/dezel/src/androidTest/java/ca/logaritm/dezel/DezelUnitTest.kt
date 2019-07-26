package ca.logaritm.dezel

import android.app.Instrumentation
import android.content.Intent
import android.support.test.InstrumentationRegistry
import android.support.test.annotation.UiThreadTest
import android.support.test.rule.ActivityTestRule
import android.support.test.runner.AndroidJUnit4
import android.util.Log
import ca.logaritm.dezel.test.TestRunner
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import java.util.concurrent.CountDownLatch

@RunWith(AndroidJUnit4::class)
class DezelUnitTest {

	@Rule @JvmField
	public var rule: ActivityTestRule<TestRunner> = ActivityTestRule<TestRunner>(TestRunner::class.java, false, true)

	@Test
	fun testAPI() {

		val signal = CountDownLatch(1)

		this.rule.runOnUiThread {
			this.rule.activity.start("192.168.11.115", "9876")
		}

		signal.await()
	}
}
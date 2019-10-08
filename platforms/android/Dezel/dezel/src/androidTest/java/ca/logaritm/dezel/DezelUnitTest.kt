package ca.logaritm.dezel

import android.support.test.rule.ActivityTestRule
import android.support.test.runner.AndroidJUnit4
import ca.logaritm.dezel.test.TestRunner
import org.junit.Rule
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class DezelUnitTest {

	@Rule @JvmField
	public var rule: ActivityTestRule<TestRunner> = ActivityTestRule<TestRunner>(TestRunner::class.java, false, true)

//	@Test
//	fun testAPI() {
//
//		val signal = CountDownLatch(1)
//
//		this.rule.runOnUiThread {
//			this.rule.activity.start("192.168.11.115", "9876")
//		}
//
//		signal.await()
//	}
}
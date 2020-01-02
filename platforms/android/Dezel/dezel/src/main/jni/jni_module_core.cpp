#include "jni_module_core.h"

jclass StringClass;
jclass JavaScriptValueClass;
jclass JavaScriptObjectClass;
jclass JavaScriptContextClass;

jclass JavaScriptFinalizeWrapperClass;
jclass JavaScriptFunctionWrapperClass;
jclass JavaScriptPropertyGetterWrapperClass;
jclass JavaScriptPropertySetterWrapperClass;
jclass JavaScriptExceptionWrapperClass;

jclass JavaScriptFinalizeCallbackClass;
jclass JavaScriptFunctionCallbackClass;
jclass JavaScriptGetterCallbackClass;
jclass JavaScriptSetterCallbackClass;
jclass JavaScriptValueForEachWrapperClass;
jclass JavaScriptValueForOwnWrapperClass;

jfieldID JavaScriptFunctionCallbackResult;
jfieldID JavaScriptGetterCallbackResult;
jfieldID JavaScriptSetterCallbackResult;

jmethodID JavaScriptValueReset;
jmethodID JavaScriptValueConstructor;

jmethodID JavaScriptFinalizeCallbackConstructor;
jmethodID JavaScriptFunctionCallbackConstructor;
jmethodID JavaScriptGetterCallbackConstructor;
jmethodID JavaScriptSetterCallbackConstructor;

jmethodID JavaScriptFinalizeWrapperExecute;
jmethodID JavaScriptFunctionWrapperExecute;
jmethodID JavaScriptGetterWrapperExecute;
jmethodID JavaScriptSetterWrapperExecute;
jmethodID JavaScriptExceptionWrapperExecute;

jmethodID JavaScriptValueForEachWrapperExecute;
jmethodID JavaScriptValueForOwnWrapperExecute;

const long long kJavaScriptFinalizeWrapperKey = reinterpret_cast<long long>(new int(0));
const long long kJavaScriptExceptionWrapperKey = reinterpret_cast<long long>(new int(0));

void
JNICoreModule(JNIEnv* env)
{
	StringClass = JNIGetClass(
		env,
		"java/lang/String"
	);

	JavaScriptValueClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptValue"
	);

	JavaScriptObjectClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptObject"
	);

	JavaScriptContextClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptContext"
	);

	//----------------------------------------------------------------------------------------------

	JavaScriptFinalizeWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptFinalizeWrapper"
	);

	JavaScriptFunctionWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptFunctionWrapper"
	);

	JavaScriptPropertyGetterWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptGetterWrapper"
	);

	JavaScriptPropertySetterWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptSetterWrapper"
	);

	JavaScriptExceptionWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptExceptionWrapper"
	);

	//----------------------------------------------------------------------------------------------

	JavaScriptFinalizeCallbackClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptFinalizeCallback"
	);

	JavaScriptFunctionCallbackClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptFunctionCallback"
	);

	JavaScriptGetterCallbackClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptGetterCallback"
	);

	JavaScriptSetterCallbackClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptSetterCallback"
	);

	JavaScriptValueForEachWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptValueForEachWrapper"
	);

	JavaScriptValueForOwnWrapperClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/core/JavaScriptValueForOwnWrapper"
	);

	//----------------------------------------------------------------------------------------------

	JavaScriptFunctionCallbackResult = JNIGetField(
		env,
		JavaScriptFunctionCallbackClass,
		"result",
		"J"
	);

	JavaScriptGetterCallbackResult = JNIGetField(
		env,
		JavaScriptGetterCallbackClass,
		"result",
		"J"
	);

	JavaScriptSetterCallbackResult = JNIGetField(
		env,
		JavaScriptSetterCallbackClass,
		"result",
		"J"
	);

	//----------------------------------------------------------------------------------------------

	JavaScriptValueReset = JNIGetMethod(
		env,
		JavaScriptValueClass,
		"reset",
		"(JZZ)V"
	);

	JavaScriptValueConstructor = JNIGetMethod(
		env,
		JavaScriptValueClass,
		"<init>",
		"(Lca/logaritm/dezel/core/JavaScriptContext;)V"
	);

	//----------------------------------------------------------------------------------------------

	JavaScriptFinalizeCallbackConstructor = JNIGetMethod(
		env,
		JavaScriptFinalizeCallbackClass,
		"<init>",
		"(Lca/logaritm/dezel/core/JavaScriptContext;J)V"
	);

	JavaScriptFunctionCallbackConstructor = JNIGetMethod(
		env,
		JavaScriptFunctionCallbackClass,
		"<init>",
		"(Lca/logaritm/dezel/core/JavaScriptContext;JJI[J)V"
	);

	JavaScriptGetterCallbackConstructor = JNIGetMethod(
		env,
		JavaScriptGetterCallbackClass,
		"<init>",
		"(Lca/logaritm/dezel/core/JavaScriptContext;JJI[J)V"
	);

	JavaScriptSetterCallbackConstructor = JNIGetMethod(
		env,
		JavaScriptSetterCallbackClass,
		"<init>",
		"(Lca/logaritm/dezel/core/JavaScriptContext;JJI[J)V"
	);

	//----------------------------------------------------------------------------------------------

	JavaScriptFinalizeWrapperExecute = JNIGetMethod(
		env,
		JavaScriptFinalizeWrapperClass,
		"execute",
		"(Lca/logaritm/dezel/core/JavaScriptFinalizeCallback;)V"
	);

	JavaScriptFunctionWrapperExecute = JNIGetMethod(
		env,
		JavaScriptFunctionWrapperClass,
		"execute",
		"(Lca/logaritm/dezel/core/JavaScriptFunctionCallback;)V"
	);

	JavaScriptGetterWrapperExecute = JNIGetMethod(
		env,
		JavaScriptPropertyGetterWrapperClass,
		"execute",
		"(Lca/logaritm/dezel/core/JavaScriptGetterCallback;)V"
	);

	JavaScriptSetterWrapperExecute = JNIGetMethod(
		env,
		JavaScriptPropertySetterWrapperClass,
		"execute",
		"(Lca/logaritm/dezel/core/JavaScriptSetterCallback;)V"
	);

	JavaScriptExceptionWrapperExecute = JNIGetMethod(
		env,
		JavaScriptExceptionWrapperClass,
		"execute",
		"(Lca/logaritm/dezel/core/JavaScriptValue;)V"
	);

	JavaScriptValueForEachWrapperExecute = JNIGetMethod(
		env,
		JavaScriptValueForEachWrapperClass,
		"execute",
		"(IJ)V"
	);

	JavaScriptValueForOwnWrapperExecute = JNIGetMethod(
		env,
		JavaScriptValueForOwnWrapperClass,
		"execute",
		"(Ljava/lang/String;J)V"
	);

	StringClass                           = (jclass) env->NewGlobalRef(StringClass);
	JavaScriptValueClass                  = (jclass) env->NewGlobalRef(JavaScriptValueClass);
	JavaScriptObjectClass                 = (jclass) env->NewGlobalRef(JavaScriptObjectClass);
	JavaScriptContextClass                = (jclass) env->NewGlobalRef(JavaScriptContextClass);
	JavaScriptFinalizeWrapperClass        = (jclass) env->NewGlobalRef(JavaScriptFinalizeWrapperClass);
	JavaScriptFunctionWrapperClass        = (jclass) env->NewGlobalRef(JavaScriptFunctionWrapperClass);
	JavaScriptPropertyGetterWrapperClass  = (jclass) env->NewGlobalRef(JavaScriptPropertyGetterWrapperClass);
	JavaScriptPropertySetterWrapperClass  = (jclass) env->NewGlobalRef(JavaScriptPropertySetterWrapperClass);
	JavaScriptExceptionWrapperClass       = (jclass) env->NewGlobalRef(JavaScriptExceptionWrapperClass);
	JavaScriptFinalizeCallbackClass       = (jclass) env->NewGlobalRef(JavaScriptFinalizeCallbackClass);
	JavaScriptFunctionCallbackClass       = (jclass) env->NewGlobalRef(JavaScriptFunctionCallbackClass);
	JavaScriptGetterCallbackClass         = (jclass) env->NewGlobalRef(JavaScriptGetterCallbackClass);
	JavaScriptSetterCallbackClass         = (jclass) env->NewGlobalRef(JavaScriptSetterCallbackClass);
	JavaScriptValueForEachWrapperClass    = (jclass) env->NewGlobalRef(JavaScriptValueForEachWrapperClass);
	JavaScriptValueForOwnWrapperClass     = (jclass) env->NewGlobalRef(JavaScriptValueForOwnWrapperClass);
}

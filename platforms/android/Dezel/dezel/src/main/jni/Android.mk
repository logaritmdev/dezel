LOCAL_PATH  := $(call my-dir)
SHARED_PATH := $(call my-dir)/../../../../../../shared

include $(CLEAR_VARS)
LOCAL_MODULE    := jsc
LOCAL_SRC_FILES := libs/$(TARGET_ARCH_ABI)/libjsc.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE    := dezel
LOCAL_SRC_FILES := wrappers/JavaScriptFunction.cpp \
                   wrappers/JavaScriptGetter.cpp \
                   wrappers/JavaScriptSetter.cpp \
                   wrappers/JavaScriptExceptionWrapper.cpp \
                   wrappers/JavaScriptFinalizeWrapper.cpp \
                   wrappers/JavaScriptFunctionWrapper.cpp \
                   wrappers/JavaScriptGetterWrapper.cpp \
                   wrappers/JavaScriptSetterWrapper.cpp \
                   wrappers/JavaScriptClassConstructorWrapper.cpp \
                   wrappers/JavaScriptClassFunctionWrapper.cpp \
                   wrappers/JavaScriptClassGetterWrapper.cpp \
                   wrappers/JavaScriptClassSetterWrapper.cpp \
                   wrappers/JavaScriptClassStaticFunctionWrapper.cpp \
                   wrappers/JavaScriptClassStaticGetterWrapper.cpp \
                   wrappers/JavaScriptClassStaticSetterWrapper.cpp \
                   wrappers/JavaScriptValueForEachWrapper.cpp \
                   wrappers/JavaScriptValueForOwnWrapper.cpp \
                   wrappers/DisplayWrapper.cpp \
                   wrappers/DisplayNodeWrapper.cpp \
                   jni_init.cpp \
                   jni_module_core.cpp \
                   jni_module_display.cpp \
                   ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal.cpp \
                   ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal.cpp \
                   ca_logaritm_dezel_core_external_JavaScriptContextExternal.cpp \
                   ca_logaritm_dezel_core_external_JavaScriptValueExternal.cpp \
                   ca_logaritm_dezel_view_display_external_DisplayExternal.cpp \
                   ca_logaritm_dezel_view_display_external_DisplayNodeExternal.cpp \
                   ca_logaritm_dezel_view_display_external_StylesheetExternal.cpp \
                   ca_logaritm_dezel_view_display_external_ValueExternal.cpp \
                   ca_logaritm_dezel_view_display_external_ValueListExternal.cpp \
                   ca_logaritm_dezel_view_display_external_FunctionValueExternal.cpp \
                   ca_logaritm_dezel_view_display_external_PropertyExternal.cpp \
                   $(wildcard $(SHARED_PATH)/core/*.cpp) \
                   $(wildcard $(SHARED_PATH)/display/*.cpp) \
                   $(wildcard $(SHARED_PATH)/display/style/*.cpp) \
                   $(wildcard $(SHARED_PATH)/display/layout/*.cpp)

LOCAL_SHARED_LIBRARIES := jsc

LOCAL_CPPFLAGS := -std=c++17 \
                  -frtti \
                  -fexceptions \
                  -I$(LOCAL_PATH)/include \
                  -I$(SHARED_PATH)/core \
                  -I$(SHARED_PATH)/display \
                  -I$(SHARED_PATH)/display/style \
                  -I$(SHARED_PATH)/display/layout \
                  -O3 \
                  -DANDROID

LOCAL_LDFLAGS  := -llog

include $(BUILD_SHARED_LIBRARY)
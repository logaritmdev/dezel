LOCAL_PATH  := $(call my-dir)
SHARED_PATH := $(call my-dir)/../../../../../../shared

include $(CLEAR_VARS)
LOCAL_MODULE    := jsc
LOCAL_SRC_FILES := libs/$(TARGET_ARCH_ABI)/libjsc.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := style
LOCAL_SRC_FILES := $(SHARED_PATH)/style/lib/jni/$(TARGET_ARCH_ABI)/libstyle.so
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
                   wrappers/StylerNodeWrapper.cpp \
                   wrappers/LayoutWrapper.cpp \
                   wrappers/LayoutNodeWrapper.cpp \
                   wrappers/DisplayWrapper.cpp \
                   wrappers/DisplayNodeWrapper.cpp \
                   jni_init.cpp \
                   jni_module_core.cpp \
                   jni_module_view.cpp \
                   jni_module_style.cpp \
                   jni_module_layout.cpp \
                   ca_logaritm_dezel_core_JavaScriptClassBuilderExternal.cpp \
                   ca_logaritm_dezel_core_JavaScriptObjectBuilderExternal.cpp \
                   ca_logaritm_dezel_core_JavaScriptContextExternal.cpp \
                   ca_logaritm_dezel_core_JavaScriptValueExternal.cpp \
                   ca_logaritm_dezel_layout_LayoutExternal.cpp \
                   ca_logaritm_dezel_layout_LayoutNodeExternal.cpp \
                   ca_logaritm_dezel_style_StylerExternal.cpp \
                   ca_logaritm_dezel_style_StylerNodeExternal.cpp \
                   ca_logaritm_dezel_view_display_DisplayExternal.cpp \
                   ca_logaritm_dezel_view_display_DisplayNodeExternal.cpp \
                   $(wildcard $(SHARED_PATH)/core/*.cpp) \
                   $(wildcard $(SHARED_PATH)/view/display/*.cpp) \
                   $(wildcard $(SHARED_PATH)/view/layout/*.cpp) \
                   $(wildcard $(SHARED_PATH)/view/style/*.cpp) \
                   $(wildcard $(SHARED_PATH)/style/*.cpp) \
                   $(wildcard $(SHARED_PATH)/layout/*.cpp) \

LOCAL_SHARED_LIBRARIES := jsc style

LOCAL_CPPFLAGS := -std=c++11 \
                  -fexceptions \
                  -I$(LOCAL_PATH)/include \
                  -I$(SHARED_PATH)/core \
                  -I$(SHARED_PATH)/style \
                  -I$(SHARED_PATH)/style/include \
                  -I$(SHARED_PATH)/style/include/css \
                  -I$(SHARED_PATH)/style/include/dls \
                  -I$(SHARED_PATH)/style/include/value \
                  -I$(SHARED_PATH)/layout \
                  -I$(SHARED_PATH)/view/display \
                  -I$(SHARED_PATH)/view/layout \
                  -I$(SHARED_PATH)/view/style \
                  -O3 \
                  -DANDROID

LOCAL_LDFLAGS  := -llog

include $(BUILD_SHARED_LIBRARY)
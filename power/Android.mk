LOCAL_PATH := $(call my-dir)

# Hey Mr. Make Author, DIAF PLX
ifeq ($(TARGET_POWERHAL_VARIANT),cheeseburger)

# HAL module implemenation stored in
# hw/<POWERS_HARDWARE_MODULE_ID>.<ro.hardware>.so
include $(CLEAR_VARS)

LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_SRC_FILES := power.c metadata-parser.c utils.c list.c hint-data.c

# Include target-specific files.
ifeq ($(call is-board-platform-in-list, msm8998), true)
LOCAL_SRC_FILES += power-8998.c
LOCAL_CFLAGS += -DMPCTLV3
endif

# Double tap to wake
ifneq ($(TARGET_TAP_TO_WAKE_NODE),)
  LOCAL_CFLAGS += -DTAP_TO_WAKE_NODE=\"$(TARGET_TAP_TO_WAKE_NODE)\"
endif

# High Brightness Mode
ifneq ($(TARGET_HIGH_BRIGHTNESS_MODE_NODE),)
ifneq ($(POWER_FEATURE_HIGH_BRIGHTNESS_MODE),)
LOCAL_CFLAGS += -DHIGH_BRIGHTNESS_MODE_NODE=\"$(TARGET_HIGH_BRIGHTNESS_MODE_NODE)\"
LOCAL_CFLAGS += -DPOWER_FEATURE_HIGH_BRIGHTNESS_MODE=$(POWER_FEATURE_HIGH_BRIGHTNESS_MODE)
endif
endif

LOCAL_MODULE := power.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif

.RECIPEPREFIX = >
ARCHS = arm64
TARGET = iphone:clang:latest:12.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GeminiMenu
GeminiMenu_FILES = Tweak.xm
GeminiMenu_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

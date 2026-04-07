# Change "com.yourname.ffmenu" to whatever you like
MODULE_NAME = GeminiMenu
$(MODULE_NAME)_FILES = Tweak.xm
$(MODULE_NAME)_CFLAGS = -fobjc-arc
$(MODULE_NAME)_FRAMEWORKS = UIKit Foundation

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

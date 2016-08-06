THEOS_DEVICE_IP = localhost -p 2222
ARCHS = armv7 arm64
TARGET = iphone:clang:9.3:8.0

include theos/makefiles/common.mk

TWEAK_NAME = WeekCount
WeekCount_FILES = Tweak.xm
WeekCount_FRAMEWORKS = UIKit
#WeekCount_PRIVATE_FRAMEWORKS = SpringBoardFoundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

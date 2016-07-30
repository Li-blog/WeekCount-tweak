ARCHS = armv7 arm64
TARGET = iphone:latest:8.0

include theos/makefiles/common.mk

TWEAK_NAME = WeekCount
WeekCount_FILES = Tweak.xm
WeekCount_PRIVATE_FRAMEWORKS = NotificationsUI SpringBoardFoundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

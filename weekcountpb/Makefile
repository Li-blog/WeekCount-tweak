include theos/makefiles/common.mk

BUNDLE_NAME = WeekCountPB
WeekCountPB_FILES = WeekCountPB.mm
WeekCountPB_INSTALL_PATH = /Library/PreferenceBundles
WeekCountPB_FRAMEWORKS = UIKit
WeekCountPB_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WeekCountPB.plist$(ECHO_END)

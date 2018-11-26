GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TOOL_NAME = Infigo
Infigo_FILES = main.mm
Infigo_INSTALL_PATH = /usr/libexec
Infigo_PACKAGE_TARGET_DIR = /usr/libexec

include $(THEOS_MAKE_PATH)/tool.mk

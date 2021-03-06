# Versioning System
PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0
ifdef BOLT_BUILD_EXTRA
    BOLT_POSTFIX := -$(BOLT_BUILD_EXTRA)
endif
ifndef BOLT_BUILD_TYPE
    BOLT_BUILD_TYPE := OFFICIAL
endif

BOLT_POSTFIX := $(shell date +"%Y%m%d-%H%M")
BOLT_DEVICE_SHORT := $(BOLT_DEVICE)
BOLT_DEVICE_SHORT := $(subst bolt,,$(BOLT_DEVICE_SHORT))

# Set all versions
BOLT_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(BOLT_BUILD_TYPE)-$(BOLT_POSTFIX)
BOLT_MOD_VERSION := bolt-$(BOLT_DEVICE_SHORT)-$(BOLT_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.ota.version=$(PRODUCT_VERSION_MAJOR)-$(BOLT_POSTFIX) \
    ro.bolt.version=$(BOLT_VERSION) \
    ro.modversion=$(BOLT_MOD_VERSION) \
    ro.bolt.buildtype=$(BOLT_BUILD_TYPE)


# Brand
PRODUCT_BRAND ?= Bolt-Os

# Local path for prebuilts
LOCAL_PATH:= vendor/bolt/prebuilts/common/system

# Jack server heap size
export ANDROID_JACK_VM_ARGS += "-Xmx4g"

# Common build prop overrides 
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    keyguard.no_require_sim=true \
    ro.facelock.black_timeout=400 \
    ro.facelock.det_timeout=1500 \
    ro.facelock.rec_timeout=2500 \
    ro.facelock.lively_timeout=2500 \
    ro.facelock.est_max_time=600 \
    ro.facelock.use_intro_anim=false \
    ro.build.selinux=1 \
    ro.adb.secure=1 \
    persist.sys.dun.override=0 \
    ro.storage_manager.enabled=1 \
    net.tethering.noprovisioning=true

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/bolt/overlays/common

# Needed Packages
PRODUCT_PACKAGES += \
    Busybox \
    Superuser \
    Eleven \
    Launcher3

# Superuser
PRODUCT_COPY_FILES += \
    vendor/bolt/prebuilts/common/superuser/su:root/sbin/su \
    vendor/bolt/prebuilts/common/superuser/init.superuser.rc:root/init.superuser.rc

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter saosp_shamu saosp_mako,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/bolt/prebuilts/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif


# Enable sip+voip on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Blobs for media effects
 ifneq ($(filter saosp_shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    $(LOCAL_PATH)/vendor/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    $(LOCAL_PATH)/vendor/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd
endif

# Backuptool support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/addon.d/50-bolt.sh:system/addon.d/50-bolt.sh \
    $(LOCAL_PATH)/bin/backuptool.functions:system/bin/backuptool.functions \
    $(LOCAL_PATH)/bin/backuptool.sh:system/bin/backuptool.sh

# Bootanimation support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/bootanimation.zip:system/media/bootanimation.zip

# init file
PRODUCT_COPY_FILES += \
    vendor/bolt/prebuilts/common/bin/sysinit:system/bin/sysinit \
    vendor/bolt/prebuilts/common/etc/init.bolt.rc:root/init.bolt.rc \
    vendor/bolt/prebuilts/common/init.d/00banner:system/etc/init.d/00banner \
    vendor/bolt/prebuilts/common/init.d/init.d.rc:root/init.d.rc

# Addons APKs
-include vendor/addons/config.mk

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Inherit common product build prop overrides
-include vendor/bolt/configs/version.mk

TEMPLATE = app

QT += qml quick widgets dbus x11extras network

SOURCES += main.cpp \
    helper.cpp \
    xwrapper.cpp \
    vkdbusinterface.cpp \
    adaptor.cpp \
    xkblibwrapper.cpp \
    settings.cpp \
    etalocalserver.cpp \
    localserverinterface.cpp

RESOURCES += qml.qrc images.qrc

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    helper.h \
    xwrapper.h \
    vkdbusinterface.h \
    adaptor.h \
    xkblibwrapper.h \
    settings.h \
    etalocalserver.h \
    localserverinterface.h
LIBS += -lxcb -lxkbcommon -lxkbcommon-x11 -lX11 -lXtst -lxcb-xkb



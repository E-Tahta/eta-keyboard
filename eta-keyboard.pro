TEMPLATE = app

QT += qml quick widgets dbus x11extras network

SOURCES += src/xwrapper.cpp \
    src/xkblibwrapper.cpp \
    src/vkdbusinterface.cpp \
    src/singleinstance.cpp \
    src/settings.cpp \
    src/main.cpp \
    src/localserverinterface.cpp \
    src/helper.cpp \
    src/etalocalserver.cpp \
    src/adaptor.cpp

RESOURCES += qml.qrc images.qrc

# Default rules for deployment.
include(deployment.pri)

HEADERS += src/xwrapper.h \
    src/xkblibwrapper.h \
    src/vkdbusinterface.h \
    src/singleinstance.h \
    src/settings.h \
    src/localserverinterface.h \
    src/helper.h \
    src/etalocalserver.h \
    src/adaptor.h
LIBS += -lxcb -lxkbcommon -lxkbcommon-x11 -lX11 -lXtst -lxcb-xkb



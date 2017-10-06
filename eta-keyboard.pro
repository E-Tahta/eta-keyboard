QT += qml quick widgets dbus x11extras network svg

TARGET = eta-keyboard
TEMPLATE = app

SOURCES += src/xwrapper.cpp \
    src/xkblibwrapper.cpp \
    src/vkdbusinterface.cpp \
    src/singleinstance.cpp \
    src/settings.cpp \
    src/main.cpp \
    src/helper.cpp \
    src/adaptor.cpp \
    src/signalhandler.cpp

RESOURCES += qml.qrc images.qrc

HEADERS += src/xwrapper.h \
    src/xkblibwrapper.h \
    src/vkdbusinterface.h \
    src/singleinstance.h \
    src/settings.h \
    src/helper.h \
    src/adaptor.h \
    src/signalhandler.h

LIBS += -lxcb -lxkbcommon -lxkbcommon-x11 -lX11 -lXtst -lxcb-xkb

target.path = /usr/bin/

desktop_file.files = eta-keyboard.desktop
desktop_file.path = /usr/share/applications/

autostart_file.files = eta-keyboard-autostart.desktop
autostart_file.commands = mkdir -p /etc/xdg/autostart
autostart_file.path = /etc/xdg/autostart/

icon.files = keyboard.svg
icon.commands = mkdir -p /usr/share/eta/eta-keyboard
icon.path = /usr/share/eta/eta-keyboard/

INSTALLS += target desktop_file autostart_file icon

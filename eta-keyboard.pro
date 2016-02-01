TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    helper.cpp

RESOURCES += qml.qrc images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    helper.h

LIBS += -lxcb -lxkbcommon -lxkbcommon-x11 -lX11 -lXtst


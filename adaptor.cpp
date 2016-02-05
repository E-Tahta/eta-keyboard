#include "adaptor.h"

#include <QtCore/QMetaObject>
#include <QtCore/QByteArray>
#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QVariant>


VirtualKeyboardInterfaceAdaptor::VirtualKeyboardInterfaceAdaptor(QObject *parent)
: QDBusAbstractAdaptor(parent)
{
    setAutoRelaySignals(true);
}
VirtualKeyboardInterfaceAdaptor::~VirtualKeyboardInterfaceAdaptor()
{

}

void VirtualKeyboardInterfaceAdaptor::toggle()
{
    QMetaObject::invokeMethod(parent(), "toggleSlot");
}

void VirtualKeyboardInterfaceAdaptor::hide()
{
    QMetaObject::invokeMethod(parent(), "hideSlot");
}

void VirtualKeyboardInterfaceAdaptor::showFromLeft()
{
    QMetaObject::invokeMethod(parent(), "fromLeftSlot");
}

void VirtualKeyboardInterfaceAdaptor::showFromRight()
{
    QMetaObject::invokeMethod(parent(), "fromRightSlot");
}

void VirtualKeyboardInterfaceAdaptor::showFromBottom()
{
    QMetaObject::invokeMethod(parent(), "fromBottomSlot");
}

void VirtualKeyboardInterfaceAdaptor::toggleAutoShow()
{
    QMetaObject::invokeMethod(parent(), "toggleAutoShowSlot");
}

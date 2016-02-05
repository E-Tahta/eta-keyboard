#include "vkdbusinterface.h"
#include "adaptor.h"
#include <QDebug>

VkDbusInterface::VkDbusInterface(QObject *parent) :
    QObject(parent)
{
    new VirtualKeyboardInterfaceAdaptor(this);
    QDBusConnection connection = QDBusConnection::sessionBus();
    connection.registerObject("/VirtualKeyboard", this);
    connection.registerService("org.eta.virtualkeyboard");
}

void VkDbusInterface::toggleSlot()
{
    emit toggle();
}
void VkDbusInterface::hideSlot()
{
    emit hide();
}
void VkDbusInterface::fromLeftSlot()
{
    emit showFromLeft();
}
void VkDbusInterface::fromRightSlot()
{
    emit showFromRight();
}
void VkDbusInterface::fromBottomSlot()
{
    emit showFromBottom();
}
void VkDbusInterface::toggleAutoShowSlot()
{
    emit toggleAutoShow();
}

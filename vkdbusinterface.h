#ifndef VKDBUSINTERFACE_H
#define VKDBUSINTERFACE_H

#include <QObject>
#include <QDBusConnection>

class VkDbusInterface : public QObject
{
    Q_OBJECT
public:
    explicit VkDbusInterface(QObject *parent = 0);

signals:
    void toggle();
    void hide();
    void showFromLeft();
    void showFromRight();
    void showFromBottom();
    void toggleAutoShow();
public Q_SLOTS:
    void toggleSlot();
    void hideSlot();
    void fromLeftSlot();
    void fromRightSlot();
    void fromBottomSlot();
    void toggleAutoShowSlot();
};

#endif // VKDBUSINTERFACE_H

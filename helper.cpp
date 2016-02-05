#include "adaptor.h"
#include "helper.h"

Helper::Helper(QObject *parent):
    QObject (parent)

{
    xw = new XWrapper(this);
    vkdi = new VkDbusInterface(this);


    connect(vkdi,SIGNAL(hide()),this,SIGNAL(hideCalled()));
    connect(vkdi,SIGNAL(showFromLeft()),this,SIGNAL(showFromLeftCalled()));
    connect(vkdi,SIGNAL(showFromRight()),this,SIGNAL(showFromRightCalled()));
    connect(vkdi,SIGNAL(showFromBottom()),this,SIGNAL(showFromBottomCalled()));
    connect(vkdi,SIGNAL(toggle()),this,SIGNAL(toggleCalled()));
    connect(vkdi,SIGNAL(toggleAutoShow()),this,SIGNAL(toggleAutoShowCalled()));


    QDBusConnection dbus = QDBusConnection::sessionBus();
    interface = new QDBusInterface("org.kde.keyboard","/Layouts","org.kde.KeyboardLayouts",dbus,this);

    dbus.connect("org.kde.keyboard", "/Layouts", "org.kde.KeyboardLayouts", "currentLayoutChanged", this, SLOT(layoutChangedSlot()));

}

Helper::~Helper()
{

}
void Helper::layoutChangedSlot()
{
    emit layoutChanged();
}

void Helper::setLayout(const QString& layout)
{
    interface->call("setLayout",layout);
}

QString Helper::getLayoutName(int layoutIndex) const
{
    QList<QVariant> tmp;
    tmp = interface->call("getLayoutsList").arguments();
    QStringList qsl;
    qsl = tmp.at(0).toStringList();
    return qsl.at(layoutIndex);
}

QString Helper::getCurrentLayout() const
{
    QList<QVariant> tmp;
    tmp = interface->call("getCurrentLayout").arguments();
    return tmp.at(0).toString();
}
QString Helper::layout() const
{
    return Helper::getCurrentLayout();
}

int Helper::getCapslockStatus()
{
    return xw->getCapslockStatus();
}

int Helper::getNumberOfLayouts()
{
    return xw->getNumberOfLayouts();
}

QString Helper::getSymbol(int keycode, int layoutIndex, int keyLevel) const
{
    return xw->getSymbol(keycode,layoutIndex,keyLevel);
}

void Helper::fakeKeyPress( unsigned int code)
{
   xw->fakeKeyPress(code);
}

void Helper::fakeKeyRelease(unsigned int code)
{
    xw->fakeKeyRelease(code);
}


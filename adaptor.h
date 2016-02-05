#ifndef ADAPTOR_H
#define ADAPTOR_H


#include <QtCore/QObject>
#include <QtDBus/QtDBus>

class QByteArray;
template<class T> class QList;
template<class Key, class Value> class QMap;
class QString;
class QStringList;
class QVariant;

class VirtualKeyboardInterfaceAdaptor : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.eta.virtualkeyboard")
    Q_CLASSINFO("D-Bus Introspection", ""
"  <interface name=\"org.eta.virtualkeyboard\">\n"
"    <method name=\"toggle\"/>\n"
"    <method name=\"hide\"/>\n"
"    <method name=\"showFromLeft\"/>\n"
"    <method name=\"showFromRight\"/>\n"
"    <method name=\"showFromBottom\"/>\n"
"    <method name=\"toggleAutoShow\"/>\n"
"  </interface>\n"
        "")

public:
    VirtualKeyboardInterfaceAdaptor(QObject *parent);
    virtual ~VirtualKeyboardInterfaceAdaptor();


public Q_SLOTS:
    void toggle();
    void hide();
    void showFromLeft();
    void showFromRight();
    void showFromBottom();
    void toggleAutoShow();


};

#endif // ADAPTOR_H

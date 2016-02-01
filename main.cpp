#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <helper.h>

int main(int argc, char *argv[])
{
    qmlRegisterType<Helper>("eta.helper",1,0,"Helper");
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

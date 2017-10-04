/*****************************************************************************
 *   Copyright (C) 2016 by Yunusemre Senturk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/
#include "src/helper.h"
#include "src/singleinstance.h"
#include "src/signalhandler.h"
#include "signal.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QDir>
#include <QCursor>

#define SINGLE_INSTANCE ".virtualkeyboard"
static int setup_unix_signal_handlers();

int main(int argc, char *argv[])
{
    if (argc == 2 && QString(argv[1]) == "login") {
        Helper::login = true;
    } else if (argc == 2 && QString(argv[1]) == "show") {
        Helper::showOnStart = true;
    }

    qmlRegisterType<Helper>("eta.helper",1,0,"Helper");
    QApplication app(argc, argv);

    app.setOverrideCursor(QCursor(Qt::BlankCursor));

    SignalHandler sh;

    setup_unix_signal_handlers();

    QString name = SINGLE_INSTANCE;

    SingleInstance cInstance;

    QObject::connect(&sh, SIGNAL(signalRecieved()), &cInstance, SLOT(cleanUp()));

    if(cInstance.hasPrevious(name, QCoreApplication::arguments()))
    {
        if (argc == 2 && QString(argv[1]) == "show") {
            qInfo("Trying to show");
            return system("qdbus org.eta.virtualkeyboard /VirtualKeyboard "
                          "org.eta.virtualkeyboard.showFromBottom");
        } else {
            qInfo("eta-keyboard is allready running");
            return 0;
        }

    }

    if (cInstance.listen(name)) {
        qDebug() << "Creating single instance";
    } else {
        qFatal("Couldn't create single instance aborting");
    }

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/ui/main.qml")));

    return app.exec();
}

static int setup_unix_signal_handlers()
{
    struct sigaction sig;
    sig.sa_handler = SignalHandler::handleSignals;
    sigemptyset(&sig.sa_mask);
    sig.sa_flags = 0;
    sig.sa_flags |= SA_RESTART;

    if (sigaction(SIGINT, &sig, 0)) {
        return 1;
    }

    if (sigaction(SIGTERM, &sig, 0)) {
        return 2;
    }

    return 0;
}

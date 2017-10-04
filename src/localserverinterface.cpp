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
#include "src/localserverinterface.h"
#include "src/etalocalserver.h"
#include <QFileInfo>
#include <QDir>

LocalServerInterface::LocalServerInterface(QObject *parent) :
    QObject(parent)
{
    server = new EtaLocalServer(this);
    Q_CHECK_PTR(server);
    const QString fullServerName =  QString(QDir::homePath()+"/"+SERVER_NAME);

    QFile file(fullServerName);
    if (file.exists()) {
        file.remove();
    }
    if (server->listen(QDir::homePath()+"/"+SERVER_NAME)) {
        qDebug() << "Listenning";
    } else {
        qDebug() << "Failed to listen";
    }
    connect(server, SIGNAL(showSignal()), this, SLOT(showSlot()));
    connect(server, SIGNAL(hideSignal()), this, SLOT(hideSlot()));
    connect(server, SIGNAL(passwordSignal()),this,SLOT(passwordSlot()));
}

void LocalServerInterface::hideSlot()
{
    emit hideSignal();
}

void LocalServerInterface::showSlot()
{
    emit showSignal();
}

void LocalServerInterface::passwordSlot()
{
    emit passwordSignal();
}

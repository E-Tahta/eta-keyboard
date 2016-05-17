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
#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QString>
#include "src/etalocalserver.h"

class XWrapper;
class VkDbusInterface;
class QDBusInterface;
class XKBLibWrapper;
class Settings;
class LocalServerInterface;

class Helper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString layout READ layout
               NOTIFY hideCalled
               NOTIFY layoutChanged
               NOTIFY showFromLeftCalled
               NOTIFY showFromRightCalled
               NOTIFY showFromBottomCalled
               NOTIFY toggleCalled
               NOTIFY toggleAutoShowCalled
               NOTIFY passwordDetected)
public:
    explicit Helper(QObject *parent = 0);
    ~Helper();
    QString layout() const;
    Q_INVOKABLE QString getSymbol(int keycode, int layoutIndex,
                                  int keyLevel) const;
    Q_INVOKABLE void fakeKeyPress(unsigned int code);
    Q_INVOKABLE void fakeKeyRelease(unsigned int code);
    Q_INVOKABLE int getNumberOfLayouts();
    Q_INVOKABLE QString getLayoutName(int layoutIndex) const;
    Q_INVOKABLE QString getCurrentLayout() const;
    Q_INVOKABLE bool isLogin() const;
    Q_INVOKABLE int getCurrentLayoutIndex();
    Q_INVOKABLE void setLayout(unsigned int layoutIndex);
    Q_INVOKABLE int getCapslockStatus();

    Q_INVOKABLE void setSettings(const QString& color,
                                 const QString& layoutType,
                                 double scale,
                                 unsigned int languageLayoutIndex,
                                 bool autoShow);
    Q_INVOKABLE QString getColor() const;
    Q_INVOKABLE QString getLayoutType() const;
    Q_INVOKABLE double getScale();
    Q_INVOKABLE unsigned int getLanguageLayoutIndex();
    Q_INVOKABLE bool getAutoShow();
    Q_INVOKABLE void saveSettings();
    Q_INVOKABLE void layoutChangedCallback();

    static bool login;
private:
    XWrapper *xw;
    VkDbusInterface *vkdi;
    QDBusInterface *interface;
    XKBLibWrapper *xkblw;
    Settings *s;
    LocalServerInterface *lsi;
private slots:
    void hideSlot();
    void showSlot();
    void passwordDetectedSlot();
signals:
    void hideCalled();
    void layoutChanged();
    void showFromLeftCalled();
    void showFromRightCalled();
    void showFromBottomCalled();
    void toggleCalled();
    void toggleAutoShowCalled();
    void passwordDetected();
};

#endif // HELPER_H

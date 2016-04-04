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
#include "src/adaptor.h"
#include "src/helper.h"
#include "src/xwrapper.h"
#include "src/vkdbusinterface.h"
#include "src/xkblibwrapper.h"
#include "src/settings.h"
#include "src/localserverinterface.h"
#include <QAbstractEventDispatcher>
#include <QFileInfo>
#include <QTimer>
#include <QDebug>

Helper::Helper(QObject *parent):
    QObject (parent)

{
    xw = new XWrapper;
    xw->setHelper(this);
    QAbstractEventDispatcher::instance()->installNativeEventFilter(xw);
    vkdi = new VkDbusInterface(this);
    xkblw = new XKBLibWrapper(this);
    s = new Settings(this);
    lsi = new LocalServerInterface(this);

    connect(lsi,SIGNAL(hideSignal()),this,SLOT(hideSlot()));
    connect(lsi,SIGNAL(showSignal()),this,SLOT(showSlot()));
    connect(lsi,SIGNAL(passwordSignal()),this,SLOT(passwordDetectedSlot()));

    connect(vkdi,SIGNAL(hide()),this,SIGNAL(hideCalled()));
    connect(vkdi,SIGNAL(showFromLeft()),this,SIGNAL(showFromLeftCalled()));
    connect(vkdi,SIGNAL(showFromRight()),this,SIGNAL(showFromRightCalled()));
    connect(vkdi,SIGNAL(showFromBottom()),this,SIGNAL(showFromBottomCalled()));
    connect(vkdi,SIGNAL(toggle()),this,SIGNAL(toggleCalled()));
    connect(vkdi,SIGNAL(toggleAutoShow()),this,SIGNAL(toggleAutoShowCalled()));

}

Helper::~Helper()
{
    delete xw;
}

void Helper::passwordDetectedSlot()
{
    if(s->getAutoShow()) {
        emit passwordDetected();
    }
}

void Helper::hideSlot()
{
    if(s->getAutoShow()) {
        emit hideCalled();
    }
}

void Helper::showSlot()
{
    if(s->getAutoShow()) {
        emit showFromBottomCalled();
    }
}

void Helper::setSettings(const QString& color,
                         const QString& layoutType,
                         double scale,
                         unsigned int languageLayoutIndex,
                         bool autoShow)
{
    s->setSettings(color, layoutType, scale, languageLayoutIndex, autoShow);
}

QString Helper::getColor() const
{
    return s->getColor();
}

QString Helper::getLayoutType() const
{
    return s->getLayoutType();
}

double Helper::getScale()
{
    return s->getScale();
}

unsigned int Helper::getLanguageLayoutIndex()
{
    return s->getLanguageLayoutIndex();
}

bool Helper::getAutoShow()
{
    return s->getAutoShow();
}

void Helper::saveSettings()
{
    s->saveSettings();
}

void Helper::layoutChangedCallback()
{
    emit layoutChanged();
}

void Helper::setLayout(unsigned int layoutIndex)
{    
    xkblw->setLayout(layoutIndex);
}

int Helper::getCurrentLayoutIndex()
{
    return xkblw->getCurrentLayoutIndex();
}

QString Helper::getLayoutName(int layoutIndex) const
{
    return xkblw->getLayoutName(layoutIndex);
}

QString Helper::getCurrentLayout() const
{
    return xkblw->getCurrentLayout();
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


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
#include <QDir>
#include <QFileInfo>
#include "src/settings.h"
#include <QSettings>
#include <QVariant>
#include <QDebug>

Settings::Settings(QObject *parent) :
    QObject(parent), m_autoShow(true)
{
    configpath = QDir::homePath() + "/.config/eta/virtualkeyboard/config.ini";

    QFileInfo checkConfig(configpath);

    if (checkConfig.exists() && checkConfig.isFile()) {
        preferences = new QSettings(configpath,QSettings::IniFormat);
        preferences->beginGroup("virtualkeyboard");
        m_color = preferences->value("Color").toInt();
        m_layoutType = preferences->value("LayoutType").toString();
        m_scale = preferences->value("Scale").toDouble();
        m_languageLayoutIndex = preferences->
                value("LanguageLayoutIndex").toUInt();
        m_autoShow = preferences->value("AutoShow").toBool();
        m_opacity = preferences->value("Opacity").toDouble();
        preferences->endGroup();
    }
}

void Settings::setSettings(const int color, const QString& layoutType,
                           double scale,
                           unsigned int languageLayoutIndex, bool autoShow,
                           double opacity)
{
    this->m_color = color;
    this->m_layoutType = layoutType;
    this->m_scale = scale;
    this->m_languageLayoutIndex = languageLayoutIndex;
    this->m_autoShow = autoShow;
    this->m_opacity = opacity;
}

int Settings::getColor() const
{
    return this->m_color;
}

QString Settings::getLayoutType() const
{
    return this->m_layoutType;
}

double Settings::getScale()
{
    return this->m_scale;
}

unsigned int Settings::getLanguageLayoutIndex()
{
    return this->m_languageLayoutIndex;
}

bool Settings::getAutoShow()
{
    return this->m_autoShow;
}

double Settings::getOpacity()
{
    return this->m_opacity;
}

void Settings::saveSettings()
{
    preferences = new QSettings(configpath,QSettings::IniFormat);
    preferences->beginGroup("virtualkeyboard");
    QVariant varColor(this->m_color);
    preferences->setValue("Color",varColor);
    QVariant varLayoutType(this->m_layoutType);
    preferences->setValue("LayoutType",varLayoutType);
    QVariant varScale(this->m_scale);
    preferences->setValue("Scale",varScale);
    QVariant varLanguage(this->m_languageLayoutIndex);
    preferences->setValue("LanguageLayoutIndex",varLanguage);
    QVariant varAutoShow(this->m_autoShow);
    preferences->setValue("AutoShow",varAutoShow);
    QVariant varOpacity(this->m_opacity);
    preferences->setValue("Opacity",varOpacity);
    preferences->endGroup();
}

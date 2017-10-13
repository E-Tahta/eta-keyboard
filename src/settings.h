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
#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

class QString;
class QSettings;

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = 0);
    void setSettings(const int color, const QString& layoutType,
                     double scale,
                     unsigned int languageLayoutIndex, bool autoShow,
                     double opacity);
    int getColor() const;
    QString getLayoutType() const;
    double getScale();
    unsigned int getLanguageLayoutIndex();
    bool getAutoShow();
    double getOpacity();
    void saveSettings();
private:
    int m_color;
    QString m_layoutType;
    double m_scale;
    unsigned int m_languageLayoutIndex;
    bool m_autoShow;
    QString configpath;
    QSettings *preferences;
    double m_opacity;
};

#endif // SETTINGS_H

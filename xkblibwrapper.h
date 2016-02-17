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
#ifndef XKBLIBWRAPPER_H
#define XKBLIBWRAPPER_H

#include <QObject>
#include <QDebug>
#include <QStringList>
typedef struct _XDisplay Display;

struct XkbConfig {
    QString keyboardModel;
    QStringList layouts;
    QStringList variants;
    QStringList options;
    bool isValid() { return ! layouts.empty(); }
};

struct LayoutUnit {
    QString layout;
    QString variant;
    QString toString() const;
};

class XKBLibWrapper : public QObject
{
    Q_OBJECT
public:
    explicit XKBLibWrapper(QObject *parent = 0);
    QString getCurrentLayout();
    QString getLayoutName(unsigned int layoutIndex);
    void setLayout(unsigned int layoutIndex);
    int getCurrentLayoutIndex();
private:
    QList<LayoutUnit> getLayoutsList();
    bool getGroupNames(XkbConfig* xkbConfig);
    Display *display;
};

#endif // XKBLIBWRAPPER_H

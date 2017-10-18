# **eta-keyboard**

## Qt virtual Keyboard

It is an advanced virtual keyboard based on x11 keycode relations and server-client programming for UNIX like systems. Major Features are:

* Floating
* Fast
* Ability to change system wide keyboard layout
* dbus interface can be reached in session
* a11y support with the help of simple at-spi client [eta-tif](https://github.com/E-Tahta/eta-tif)
* full and tablet keyboard layout support
* EOE (easy on eyes) color themes
* Easy to configure with the help of self contain settings

![tablet](/screenshots/vk-tablet.png)

![full](/screenshots/vk-full.png)

![blue](/screenshots/vk-blue.png)

![brown](/screenshots/vk-brown.png)

![green](/screenshots/vk-green.png)

![white](/screenshots/vk-white.png)

![a11y](/screenshots/vk-a11y-support.png)

![settings](/screenshots/vk-settings.png)


### Build

Clone the project
```bash
git clone https://github.com/E-Tahta/eta-keyboard.git
```
Install build dependencies
```bash
sudo apt install build-essential libc6 libgcc1 libgl1-mesa-glx | libgl1 libqt5core5a libqt5dbus5 libqt5gui5  libqt5network5 libqt5qml5 libqt5quick5 libqt5svg5-dev libqt5widgets5 libqt5x11extras5-dev libstdc++6 libx11-6 libx11-xcb-dev libxcb-xkb-dev libxcb1-dev libxkbcommon-x11-0 libxkbcommon-x11-dev libxkbcommon0   libxkbcommon-dev libxkbfile-dev libxtst-dev qtdeclarative5-dev
```

Build
```bash
cd eta-keyboard
mkdir build
cd build
qmake ../
make
```

Install Runtime dependencies
```bash
sudo apt install libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-window2 qml-module-qtquick2
```

Run
```bash
./eta-keyboard show
```

You can also test remote calling
```bash
sudo apt install qdbus-qt5
qdbus org.eta.virtualkeyboard /VirtualKeyboard org.eta.virtualkeyboard.toggle
```

### Debian packaging

```bash
cd eta-keyboard
sudo apt install build-essential debmake debhelper git-buildpackage
sudo mk-build-deps -ir
gbp buildpackage --git-export-dir=/tmp/build-area -b -us -uc
cd /tmp/build-area
```

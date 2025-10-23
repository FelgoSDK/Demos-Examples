# Felgo Apps PropertyCross

Visit the [Felgo page](https://felgo.com/doc/felgo-appdemos-propertycross-example/) for more details and screenshots.

## Overview

[Felgo Apps](https://felgo.com/apps/) allows to create feature-rich, cross-platform native apps for iOS, Android, Windows Phone and others. Felgo Apps was designed with mobile-first in mind, providing components that look and feel native on all supported platforms. The main highlights are:

- **Native Look and Feel**: Get a native look and feel from a single code base, like a navigation drawer on Android vs tabs on iOS.
- **Auto-adapting UI**: Create one app and support every device, with responsive layout components that adapt to any screen.
- **Animations**: Polish your App with smooth and easy-to-use animations and transitions.
- **Native Performance**: Felgo Apps run fully native on devices. No wrapper, no hybrid. Enjoy full performance instead.
- **Controls**: Buttons, Switches, List Views, Input Controls and more.
- **Device Features & Sensors**: Access to camera, microphone, accelerometer, GPS or file system and add custom C++, Obj-C / Java or native SDKs where needed.
- **Multimedia**: Play a wide range of video and audio formats within your app.
- **Networking & Connectivity**: Powerful components for HTTP connections, Bluetooth, WebSockets and more.
- SQL **Database**, web storage and **localization**/**internationalization** support
- Use **Felgo Plugins** for monetization, analytics, push notifications and social services like Facebook.

Felgo Apps is part of [Felgo SDK](https://felgo.com/), a framework powered by popular Qt framework.


## Building the Application

1. Sign up for a free account at [felgo.com](https://felgo.com/) and download the Felgo SDK.
2. After installation make sure to install the Android and iOS targets with the Maintenance Tool.
3. You can then open `PropertyCross.pro` with Qt Creator, select your build target and run the app.


## Application Structure

+ `\android` - Resource files used for bundling the Android app
+ `\ios` - Resource files used for bundling the iOS app
+ `\PropertyCross.pro` - Main project file for the Felgo app
+ `\qml` - The actual source code implementation files
+ `\qml\PropertyCrossMain.qml` - Main source file, app entry point
+ `\main.cpp` - Entry point for the native application

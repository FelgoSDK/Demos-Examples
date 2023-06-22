import Felgo 4.0
import QtQuick 2.9
import "../common"

FlickablePage {
  id: mainPage
  title: "Main"
//  backgroundColor: app.secondaryTintColor

  // Timer for countdown until conference start
//  Timer {
//    running: parent.visible
//    interval: 1000
//    repeat: true

//    property int conferenceStartTime: 1507622400 // 2017-10-10 10am GMT+2
//    Component.onCompleted: triggered()
//    onTriggered: {
//      var remain = conferenceStartTime - (Date.now() / 1000)
//      if(remain <= 0) {
//        running = false
//        remainDaysColumn.visible = false
////        qwsWrapper.height = dp(150)
//        return
//      }

//      remainDays.value = remain / 60 / 60 / 24
//      remain -= remainDays.value * 60 * 60 * 24

//      remainHours.value = remain / 60 / 60
//      remain -= remainHours.value * 60 * 60

//      remainMins.value = remain / 60
//      remain -= remainMins.value * 60

//      remainSecs.value = remain
//    }
//  }

  // add hard coded menu item in main page to fix occasional missing menu item on Android on start
  leftBarItem: ButtonBarItem {

    Component.onCompleted: {
      if (!Theme.isAndroid) {
        leftBarItem = null
      }
    }

    contentItem: AppIcon { // @disable-check M16
      id: menuIcon
      anchors.centerIn: parent
      color: "#fff"
      iconType: Theme.isAndroid ? "menu" : IconType.navicon
      textItem.font.family: Theme.isAndroid ? Theme.androidIconFont.name : Theme.iconFont.name
      size: Theme.isAndroid ? dp(Theme.navigationBar.androidIconSize) : dp(Theme.navigationBar.defaultIconSize)
    }

    z: 100
    visible: Theme.isAndroid
    RippleMouseArea {
      enabled: parent.visible
      rippleEffectEnabled: true
      fillColor: "#20ffffff"
      backgroundColor: "#10ffffff"
      anchors.fill: parent
      centerAnimation: true
      touchPoint: Qt.point(width/2,height/2)
      onClicked: {
        navigation.drawer.open()
      }
    }
//    onClicked: {
//      navigation.drawer.open()
//    }
  }

//  leftBarItem: navigation.navDrawerButton
//  Component.onCompleted: {
//    navigation.drawerVisible = false
//    drawerIconFix.start()//navigation.tabs.updateAppDrawerIcon()
//  }
//  leftBarItem: NavigationBarItem {
//    Rectangle {
////      width: dp(40)
////      height: parent.height
//      anchors.fill: parent
//      color: "#f00"
//      MouseArea {
//        anchors.fill: parent
//        onClicked: {
//          console.debug("TEST")
//        }
//      }
//    }
//  }

//  Timer {
//    id: drawerIconFix
//    interval: 250
//    onTriggered: navigation.drawerVisible = true//navigation.tabs.updateAppDrawerIcon()
//  }

  // set up navigation bar
  titleItem: Item {
    width: dp(50)
    implicitWidth: img.width
    height: dp(Theme.navigationBar.height)

    Image {
      id: img
//      source: Theme.isIos && Theme.tabBar.backgroundColor != "#080808" ? "../../assets/QtWS2019_globe_black.png" : "../../assets/QtWS2019_globe_white.png"
      source: "../../assets/Qt_logo.png"
      width: dp(50)
      height: parent.height * 0.6
      fillMode: Image.PreserveAspectFit
      y: Theme.isAndroid ? dp(Theme.navigationBar.titleBottomMargin) + dp(10) : dp(10)
    }
  }

  flickable.contentWidth: width
  flickable.contentHeight: Math.max(flickable.height, content.height + demosArea.height)

  Rectangle {
    width: parent.width
    height: dp(1000)
    color: app.secondaryTintColor
    anchors.bottom: parent.top
  }

  // page content
  Column {
    id: content
    width: parent.width
//    spacing: dp(10)

    property real descriptionTextMaxWidth: Math.min(parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2, dp(600))

    Column {
      width: parent.width

      Rectangle {
        id: qwsWrapper
        height: dp(300)
//        height: bannerImage.height
        width: parent.width
        color: app.secondaryTintColor
//        color: Theme.secondaryBackgroundColor

        AppImage {
          id: bannerImage
          width: parent.width
          anchors.bottom: parent.bottom
          height: mainPage.flickable.contentY < 0 ? parent.height - mainPage.flickable.contentY : parent.height
          fillMode: AppImage.PreserveAspectCrop
          source: "../../assets/herobg_qtws17-1.jpg"
          opacity: 0.35
        }

        Rectangle {
          opacity: 0.5
          anchors.centerIn: bannerImage
          height: bannerImage.width
          width: bannerImage.height
          rotation: -90
          transformOrigin: Item.Center
          gradient: Gradient {
            GradientStop { position: 0.0; color: "#41cd52" }
            GradientStop { position: 1.0; color: "#0041cd52" }
          }
        }
//        AppImage {
//          id: bannerImage
//          width: parent.width
//          source: "../../assets/QtWS2019_web banner1.png"
//          fillMode: AppImage.PreserveAspectFit
//        }

        Column {
          width: parent.width
          anchors.verticalCenter: parent.verticalCenter
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)

          AppText {
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            color: "white"
            text: "The Future is\nWritten with Qt"
            font.pixelSize: sp(22)
          }

          AppImage {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../assets/QtWS2019_globe_white.png"
            width: dp(120)
            fillMode: AppImage.PreserveAspectFit
          }

          AppText {
            width: parent.width
            horizontalAlignment: AppText.AlignHCenter
            color: "white"
            text: "Berlin, Germany / 4 - 6 November"
            font.pixelSize: sp(14)
          }

          // remaining days
//          Column {
//            id: remainDaysColumn
//            anchors.horizontalCenter: parent.horizontalCenter
//            spacing: parent.spacing * 0.5

//            AppText {
//              text: "\nstarting in"
//              color: "white"
//              font.pixelSize: sp(11)
//              font.bold: true
//              anchors.horizontalCenter: parent.horizontalCenter
//            }

//            Row {
//              anchors.horizontalCenter: parent.horizontalCenter
//              spacing: dp(5)
//              CountDownBlock { id: remainDays; titleText: "Days" }
//              CountDownBlock { id: remainHours; titleText: "Hours" }
//              CountDownBlock { id: remainMins; titleText: "Min" }
//              CountDownBlock { id: remainSecs; titleText: "Sec" }
//            }
//          }
        }
      } // colored section


      Rectangle {
        width: parent.width
        color: Theme.secondaryBackgroundColor
        height: qtIntroCol.height

        Column {
          id: qtIntroCol
          width: parent.width
          topPadding: dp(15)
          bottomPadding: dp(15)

          AppText {
            width: content.descriptionTextMaxWidth
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: sp(13)
            wrapMode: Text.WordWrap
      //      color: Theme.secondaryTextColor
      //      text: "With Qt you can build applications for tomorrow, while delivering value to your customers today. The Qt World Summit offers insight and inspiration to leading technology innovators, industry experts, startups, and the community."
//            text: "With Qt you can build applications for tomorrow, while delivering value to your customers today!"
            text: "Qt is the fastest and smartest way to produce industry-leading software that users love."
          }
        }
      }

      Rectangle {
        width: parent.width
        height: felgoBlockColumn.height
        color: Theme.backgroundColor//Theme.secondaryBackgroundColor

        Column {
          id: felgoBlockColumn
          width: parent.width
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)

          Item {
            width: parent.width
            height: px(1)
          }

          AppText {
            width: content.descriptionTextMaxWidth
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: sp(13)
//            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "This cross-platform mobile app<br/>was made with <b>Qt & the Felgo SDK</b>!"
          }

          AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.min(parent.width - dp(Theme.navigationBar.defaultBarItemPadding), implicitWidth + dp(Theme.navigationBar.defaultBarItemPadding))
            font.pixelSize: sp(13)
            wrapMode: Text.WordWrap
            textFormat: AppText.RichText
            onLinkActivated: nativeUtils.openUrl(link)
            text: "<style>a:link { color: "+Theme.tintColor+";}</style>
<ul><li><b>Only ~2900 lines of code</b> - download the full source on GitHub below</li>

<li><b>Build cross-platform native apps</b> for" + (system.isPlatform(System.IOS) ? " all major mobile platforms, desktop and embedded devices</li>" : "</li>")
          }

          AppImage {
            width: parent.width * 0.8
            fillMode: AppImage.PreserveAspectFit
            source: "../../assets/platforms.png"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !system.isPlatform(System.IOS) // hide on iOS, instead display text above
          }

          AppButton {
            flat: false
            anchors.horizontalCenter: parent.horizontalCenter
            text: "More Info & Source Code"
            onClicked: {
              amplitude.logEvent("Click MainPage Button",{"label" : text})
              confirmOpenUrl("https://felgo.com/qws-conference-in-app-2019")
            }
            verticalMargin: 0
          }

          Item {
            width: parent.width
            height: px(1)
          }

        } // felgo block column
      } // felgo block area
    } // main intro block

    Column {
      width: parent.width
//      topPadding: dp(15)

      Rectangle {
        width: parent.width
        height: dp(220)
//        color: app.secondaryTintColor
        color: Theme.secondaryBackgroundColor

        Column {
          anchors.centerIn: parent
          spacing: dp(10)

          AppImage {
            source: "../../assets/felgo_black.png"
            width: dp(200)
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
          }

          // Spacer
          Item {
            width: parent.width
            height: px(1)
          }

          AppText {
//            color: "#fff"
            text: "WE MADE THIS APP FOR YOU!"
            font.bold: true
            font.pixelSize: sp(18)
            anchors.horizontalCenter: parent.horizontalCenter
          }

          AppText {
//            color: "#fff"
            text: "And there is <b>much more</b> we can do."
            anchors.horizontalCenter: parent.horizontalCenter
          }

          // Spacer
          Item {
            width: parent.width
            height: dp(5)
          }

          AppImage {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../assets/qt_tech_partner.png"
            width: dp(180)
            fillMode: Image.PreserveAspectFit
          }
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {
            amplitude.logEvent("Click MainPage Button",{"label" : "WE MADE THIS APP FOR YOU!"})
            confirmOpenUrl("https://felgo.com/qws-2019-felgo-offer")
          }
        }
      }
    }

    Item {
      width: parent.width
      height: dp(15)
    }

    // More Felgo Features
    AppText {
      width: content.descriptionTextMaxWidth
      anchors.horizontalCenter: parent.horizontalCenter
      font.pixelSize: sp(13)
      wrapMode: Text.WordWrap
//      color: Theme.secondaryTextColor
      text: "Felgo <b>extends Qt</b> with:"
    }

    Item {
      width: parent.width
      height: dp(10)
    }

    AppText {
      anchors.horizontalCenter: parent.horizontalCenter
      width: content.descriptionTextMaxWidth
      font.pixelSize: sp(13)
      wrapMode: Text.WordWrap
//      color: Theme.secondaryTextColor
      textFormat: AppText.RichText
      text: "<ul>
<li><b>200+ Extra Qt APIs</b>: faster development thanks to more components</li>
<li><b>Live & Hot Code Reload</b>: higher efficiency thanks to rapid testing cycles</li>
<li><b>Specialized Qt CI/CD</b>: save time with continuous integration and testing for Qt projects</li>
<li><b>60+ polished Qt demos</b> with best practices for <b>UI/UX</b> and application architecture for <b>Mobile, Desktop, Embedded & Web</b></li>
</ul>"
    }

    Rectangle {
      color: Theme.backgroundColor//Theme.secondaryBackgroundColor
      width: parent.width
      height: dp(70)

      AppButton {
        flat: false
        anchors.centerIn: parent
        text: "How Felgo accelerates Qt development"
        onClicked: {
          amplitude.logEvent("Click MainPage Button",{"label" : text})
          confirmOpenUrl("https://felgo.com/qws-2019-felgo-offer")
        }
        verticalMargin: 0
      }
    }

//    Rectangle {
//      color: Theme.secondaryBackgroundColor
//      width: parent.width
//      height: dp(90)

//      Column {
//        width: parent.width
//        spacing: dp(10)
//        anchors.centerIn: parent

//        AppText {
//          anchors.horizontalCenter: parent.horizontalCenter
//          color: Theme.textColor
//          font.pixelSize: sp(13)
//          text: "Felgo is proud to be:"
//          font.bold: true
//        }

//        AppImage {
//          anchors.horizontalCenter: parent.horizontalCenter
//          source: "../../assets/qt_tech_partner.png"
//          width: dp(180)
//          fillMode: Image.PreserveAspectFit
//        }
//      }
//    }
  } // Column


  // Link to Demos
  Rectangle {
    id: demosArea
    anchors.bottom: parent.bottom
    width: parent.width
    height: demosContent.height + 2 * dp(Theme.navigationBar.defaultBarItemPadding)
    color: Theme.secondaryBackgroundColor

    Column {
      id: demosContent
      width: parent.width
      anchors.verticalCenter: parent.verticalCenter
      spacing: content.spacing

      AppText {
        id: demosText
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: sp(13)
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        color: Theme.secondaryTextColor
        text: "Try more of the open-source Qt & Felgo apps:"
      }

      // Demos Grid
      Grid {
        id: grid
        property real itemWidth: Math.min(parent.width/2,dp(200))
        property real itemHeight: dp(130)
        columns: 2
        topPadding: dp(15)
        bottomPadding: dp(15)
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
          width: grid.itemWidth
          height: grid.itemHeight

          Column {
            width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
            spacing: dp(5)
//            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter

            AppText {
              text: "Jira Tima"
              font.pixelSize: sp(13)
              font.bold: true
              anchors.horizontalCenter: parent.horizontalCenter
            }

            AppImage {
              width: parent.width * 0.4
              fillMode: AppImage.PreserveAspectFit
              anchors.horizontalCenter: parent.horizontalCenter
              source: "../../assets/logo-tima.png"
            }

            AppText {
              width: parent.width
              font.pixelSize: sp(12)
              color: Theme.secondaryTextColor
              horizontalAlignment: AppText.AlignHCenter
              text: "Master Jira time tracking on the go!"
            }
          }

          MouseArea {
            anchors.fill: parent
            onClicked: {
              amplitude.logEvent("Click MainPage Button",{"label" : "Jira Tima"})
              var url = Theme.isAndroid ? "https://play.google.com/store/apps/details?id=net.vplay.tima" : "https://itunes.apple.com/us/app/id1440145973?mt=8"
              nativeUtils.openUrl(url)
            }
          }
        }

        Item {
          width: grid.itemWidth
          height: grid.itemHeight

          Column {
            width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
            spacing: dp(5)
//            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter

            AppText {
              text: "WTR - Weather Pro"
              font.pixelSize: sp(13)
              font.bold: true
              anchors.horizontalCenter: parent.horizontalCenter
            }

            AppImage {
              width: parent.width * 0.4
              fillMode: AppImage.PreserveAspectFit
              anchors.horizontalCenter: parent.horizontalCenter
              source: "../../assets/logo-wtr.png"
            }

            AppText {
              width: parent.width
              font.pixelSize: sp(12)
              color: Theme.secondaryTextColor
              horizontalAlignment: AppText.AlignHCenter
              text: "The Qt-est weather app in the app stores!"
            }
          }

          MouseArea {
            anchors.fill: parent
            onClicked: {
              amplitude.logEvent("Click MainPage Button",{"label" : "WTR"})
              var url = Theme.isAndroid ? "https://play.google.com/store/apps/details?id=net.vplay.demos.apps.weatherapp" : "https://itunes.apple.com/us/app/weather-pro-forecast-history/id1438432642?mt=8"
              nativeUtils.openUrl(url)
            }
          }
        }

        Item {
          width: grid.itemWidth
          height: grid.itemHeight

          Column {
            width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
            spacing: dp(5)
//            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter

            AppText {
              text: "Felgo Developer App"
              font.pixelSize: sp(13)
              font.bold: true
              anchors.horizontalCenter: parent.horizontalCenter
            }

            AppImage {
              width: parent.width * 0.4
              fillMode: AppImage.PreserveAspectFit
              anchors.horizontalCenter: parent.horizontalCenter
              source: "../../assets/logo-showcase.png"
            }

            AppText {
              width: parent.width
              font.pixelSize: sp(12)
              color: Theme.secondaryTextColor
              horizontalAlignment: AppText.AlignHCenter
              text: "This app includes all open-source demos of Felgo!"
            }
          }

          MouseArea {
            anchors.fill: parent
            onClicked: {
              amplitude.logEvent("Click MainPage Button",{"label" : "Developer App"})
              var url = Theme.isAndroid ? "https://play.google.com/store/apps/details?id=com.felgo.apps.FelgoLiveQt6" : "https://itunes.apple.com/us/app/qt-quick-felgo-qml-dev-app/id1669213808"
              nativeUtils.openUrl(url)
            }
          }
        }

        Item {
          width: grid.itemWidth
          height: grid.itemHeight

          Column {
            width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
            spacing: dp(5)
//            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter

            AppText {
              text: "31 Online"
              font.pixelSize: sp(13)
              font.bold: true
              anchors.horizontalCenter: parent.horizontalCenter
            }

            AppImage {
              width: parent.width * 0.4
              fillMode: AppImage.PreserveAspectFit
              anchors.horizontalCenter: parent.horizontalCenter
              source: "../../assets/logo-31.png"
            }

            AppText {
              width: parent.width
              font.pixelSize: sp(12)
              color: Theme.secondaryTextColor
              horizontalAlignment: AppText.AlignHCenter
              text: "Top-5 Card Game in the app stores, single- and multiplayer powered by Felgo and Qt"
            }
          }

          MouseArea {
            anchors.fill: parent
            onClicked: {
              amplitude.logEvent("Click MainPage Button",{"label" : "Hosn Obe"})
              var url = Theme.isAndroid ? "https://play.google.com/store/apps/details?id=com.donkeycat.hosnobeol" : "https://itunes.apple.com/us/app/hosn-obe-online/id1207752026?mt=8"
              nativeUtils.openUrl(url)
            }
          }
        }
      } // Demos Grid
    } // Demos Content
  } // Demos Area

  Rectangle {
    width: parent.width
    height: dp(1000)
    color: Theme.secondaryBackgroundColor
    anchors.top: parent.bottom
  }

  // confirmOpenUrl - display confirm dialog before opening Felgo url
  function confirmOpenUrl(url) {
    NativeDialog.confirm("Open Website?","This action opens your browser to visit "+url,function(ok) {
      if(ok)
        nativeUtils.openUrl(url)
    })
  }


}

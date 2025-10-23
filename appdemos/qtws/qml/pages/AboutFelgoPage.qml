import Felgo
import QtQuick
import "../common"
import "../details"

FlickablePage {
  title: "About this app"

  flickable.contentWidth: width
  flickable.contentHeight: Math.max(flickable.height, content.height)

  property real descriptionTextMaxWidth: parent ? Math.min(parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2, dp(600)) : 0

  Rectangle {
    width: parent.width
    height: content.height + 1000
    color: Theme.backgroundColor
    anchors.bottom: content.top
  }

  // page content
  Column {
    id: content
    width: parent.width
    spacing: dp(Theme.navigationBar.defaultBarItemPadding)

    Column {
      width: parent.width

      // Banner
      Rectangle {
        width: parent.width
        height: dp(200)
        color: Theme.backgroundColor

        Column {
          anchors.centerIn: parent
          spacing: dp(15)

          Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: appDetails.darkMode ? "../../assets/felgo.png" : "../../assets/felgo_black.png"
            width: dp(150)
            fillMode: Image.PreserveAspectFit
          }

          AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.textColor
            font.pixelSize: sp(15)
            text: "We made this App for you!"
            font.bold: true
            font.capitalization: Font.AllUppercase
          }

          AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.textColor
            font.pixelSize: sp(13)
            text: "And there is <b>much more</b> we can do."
          }

          Row {
            spacing: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            AppImage {
              id: techPartnerImg
              source: appDetails.darkMode ? "../../assets/qt_tech_partner_white.png" : "../../assets/qt_tech_partner_black.png"
              width: dp(150)
              fillMode: Image.PreserveAspectFit
            }
            AppImage {
              source: appDetails.darkMode ? "../../assets/qt_service_partner_white.png" : "../../assets/qt_service_partner_black.png"
              height: techPartnerImg.height
              fillMode: Image.PreserveAspectFit
            }
          }
        }
      }

      Rectangle {
        width: parent.width
        height: partnerCol.height + dp(Theme.navigationBar.defaultBarItemPadding)*2
        color: Theme.secondaryBackgroundColor

        Column {
          id: partnerCol
          width: parent.width
          anchors.centerIn: parent
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)

          AppTextWithBullet {
            anchors.horizontalCenter: parent.horizontalCenter
            width: descriptionTextMaxWidth
            text: "<b>Specialized Qt Tools and Components:</b> Felgo saves time and simplifies development for customers across all industries."
          }

          AppTextWithBullet {
            anchors.horizontalCenter: parent.horizontalCenter
            width: descriptionTextMaxWidth
            text: "<b>Technical Consulting:</b> Access the knowledge of experts with 10+ years of Qt experience in <b>Mobile, Desktop and Embedded</b> applications."
          }

          AppTextWithBullet {
            anchors.horizontalCenter: parent.horizontalCenter
            width: descriptionTextMaxWidth
            text: "<b>Development Services:</b> High-quality Qt application development that meets your requirements and timeline."
          }

          AppTextWithBullet {
            anchors.horizontalCenter: parent.horizontalCenter
            width: descriptionTextMaxWidth
            text: "<b>Team Extension:</b> Partner with Felgo to flexibly develop applications together with your own development team."
          }

          AppTextWithBullet {
            anchors.horizontalCenter: parent.horizontalCenter
            width: descriptionTextMaxWidth
            text: "<b>Qt Training and Workshops:</b> Tailored to your specific needs and level of experience, remote or on-site."
          }

          AppButton {
            flat: false
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Request a Free Intro Call"
            onClicked: {
              utils.confirmOpenUrl(publisherDetails.offerUrl)
            }
          }
        } // Column
      } // Wrapper Rectangle
    }

    // More Felgo Features
    AppText {
      width: descriptionTextMaxWidth
      anchors.horizontalCenter: parent.horizontalCenter
      font.pixelSize: sp(13)
      text: "<b>Develop fast & efficiently</b> with unique Qt tools and services:"
    }

    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Felgo QML Hot Reload</b>: Skip build & deployment when developing Qt/QML projects. Felgo QML Hot Reload applies code changes instantly after saving."
    }
    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Felgo Cloud Builds</b>: Rely on the only CI/CD solution exclusively for Qt to build and distribute apps with minimum effort and maximum speed."
    }
    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Visual Studio Plugins:</b> Develop how and where you want. Felgo has you covered with QML plugins for Visual Studio and VS Code."
    }

    AppText {
      width: descriptionTextMaxWidth
      anchors.horizontalCenter: parent.horizontalCenter
      font.pixelSize: sp(13)
      topPadding: dp(Theme.contentPadding)
      text: "<b>Create better apps</b> with the Felgo SDK, which extends Qt with 200+ QML APIs:"
    }

    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Responsive UI/UX</b>: Felgo apps can adapt to all screen sizes and provide a native look & feel on every target platform."
    }
    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Less Code</b>: Leverage a wide range of visual and functional components to save code and development time."
    }
    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Native APIs</b>: Directly access  iOS & Android platform-APIs and third-party plugins for <b>Analytics, Push Notifications, Firebase</b> and more."
    }
    AppTextWithBullet {
      anchors.horizontalCenter: parent.horizontalCenter
      width: descriptionTextMaxWidth
      text: "<b>Native Integration</b>: Embed Qt views and cross-platform code in your mobile projects created with Android Studio or Xcode."
    }

    Rectangle {
      color: Theme.backgroundColor
      width: parent.width
      height: dp(70)

      AppButton {
        flat: false
        anchors.centerIn: parent
        text: "How Felgo accelerates Qt development"
        onClicked: {
          utils.confirmOpenUrl(publisherDetails.qtDevelopersUrl)
        }
        verticalMargin: 0
      }
    }

    // Link to Demos
    Rectangle {
      id: demosArea
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
          color: Theme.textColor
          text: "Try more of the open-source Qt & Felgo apps:"
        }

        // Demos Grid
        Column {
          id: grid
          property real itemWidth: Math.min(parent.width/2,dp(200))
          property real itemHeight: dp(135)
          topPadding: dp(15)
          bottomPadding: dp(15)
          anchors.horizontalCenter: parent.horizontalCenter
          spacing: dp(30)

          Row {
            Item {
              width: grid.itemWidth
              height: grid.itemHeight

              Column {
                width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
                spacing: dp(5)
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
                  var url = Theme.isAndroid ? "https://play.google.com/store/apps/details?id=net.vplay.demos.apps.weatherapp" : "https://itunes.apple.com/us/app/weather-pro-forecast-history/id1438432642?mt=8"
                  nativeUtils.openUrl(url)
                }
              }
            }
          }

          Item {
            width: grid.itemWidth
            height: grid.itemHeight
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
              width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
              spacing: dp(5)
              anchors.horizontalCenter: parent.horizontalCenter

              AppText {
                text: "Felgo Dev App"
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
                var url = Theme.isAndroid ? "https://play.google.com/store/apps/details?id=com.felgo.apps.FelgoLiveQt6" : "https://apps.apple.com/us/app/felgo-4-qml-dev-app/id1669213808"
                nativeUtils.openUrl(url)
              }
            }
          }
        } // Demos Grid
      } // Demos Content
    } // Demos Area
  } // Column
}

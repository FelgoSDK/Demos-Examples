import QtQuick
import QtQuick.Controls
import Qt.labs.settings as QtLabs
import QtQuick.Controls.Material
import QtLocation
import QtPositioning
import QtMultimedia
import Qt5Compat.GraphicalEffects
import Felgo
import "../controls"
import "../common"


AppPage {
  id: controlsPage

  // define quick controls colors
  Material.accent: Theme.tintColor

  rightBarItem: IconButtonBarItem {
    iconType: IconType.paintbrush
    onClicked: {
      themeModal.open()
    }
  }

  AppFlickable {
    id: scroll
    anchors.fill: parent
    contentHeight: content.height

    // remove focus from controls if clicked outside
    MouseArea {
      anchors.fill: parent
      onClicked: {
        scroll.forceActiveFocus()
      }
    }

    Column {
      id: content
      width: parent.width

      GridSection {
        title: "Felgo Controls"
        topPadding: 0

        SectionItem {
          title: "AppSwitch"

          Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: parent.spacing

            AppText {
              anchors.verticalCenter: parent.verticalCenter
              text: system.isPlatform(System.IOS) ? "Material Theme:" : "iOS Theme:"
            }

            AppSwitch {
              anchors.verticalCenter: parent.verticalCenter
              checked: Theme.isAndroid && system.isPlatform(System.IOS) || Theme.isIos
                       && !system.isPlatform(System.IOS)
              updateChecked: false
              onToggled: {
                if (system.isPlatform(System.IOS))
                  Theme.platform = checked ? "ios" : "android"
                else
                  Theme.platform = checked ? "android" : "ios"
              }
            }
          }
        }

        SectionItem {
          title: "AppButton"

          Row {
            anchors.horizontalCenter: parent.horizontalCenter

            AppButton {
              id: normButton
              verticalMargin: 0
              text: "Normal"
              flat: false
              onClicked: text = text === "Normal" ? "Clicked" : "Normal"
            }

            AppButton {
              id: flatButton
              verticalMargin: 0
              text: "Flat"
              flat: true
              onClicked: {
                text = text === "Flat" ? "Clicked" : "Flat"
              }
            }
          }
        }

        SectionItem {
          title: "AppSlider"

          AppSlider {
            implicitWidth: dp(200)
            anchors.horizontalCenter: parent.horizontalCenter

            value: 0.4
          }
        }

        SectionItem {
          title: "AppRangeSlider"

          AppRangeSlider {
            implicitWidth: dp(200)
            anchors.horizontalCenter: parent.horizontalCenter
          }
        }

        SectionItem {
          title: "AppTextField"

          AppTextField {
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: parent.width * 0.7

            backgroundColor: Theme.secondaryBackgroundColor
            leftPadding: dp(10)
            placeholderText: "Enter text ..."
          }

          AppTextField {
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: parent.width * 0.7

            backgroundColor: Theme.secondaryBackgroundColor
            inputMode: inputModePassword
            leftPadding: dp(10)
            placeholderText: "Enter password..."
          }
        }

        SectionItem {
          title: "SimpleRow"
          horizontalMargin: 0
          spacing: 0

          SimpleRow {
            width: parent.width

            text: "Simple row with text"
          }

          SimpleRow {
            width: parent.width

            iconSource: IconType.info
            text: "Simple row with text and icon"
          }

          SimpleRow {
            width: parent.width

            text: "Simple row with text"
            detailText: "And detail text"
          }

          SimpleRow {
            width: parent.width

            text: "Simple row with text"
            detailText: "Detail text and image"
            imageSource: Qt.resolvedUrl("../../assets/architecture-1477041_960_720.jpg")
          }
        }

        SectionItem {
          title: "TextFieldRow"
          horizontalMargin: 0
          spacing: 0

          TextFieldRow {
            width: parent.width
            label: "Text"
            placeHolder: "Add some text"
          }

          TextFieldRow {
            id: dateRow
            width: parent.width
            label: "Date"
            placeHolder: "Select date"
            clickEnabled: true
            onClicked: {
              nativeUtils.displayDatePicker()
            }

            Connections {
              target: nativeUtils
              function onDatePickerFinished(accepted, date) {
                if (accepted) {
                  dateRow.value = date.toDateString()
                }
              }
            }
          }
        }

        SectionItem {
          title: "SwipeOptionsContainer"
          width: parent.width
          horizontalMargin: 0

          SwipeOptionsContainer {
            id: container
            clip: true
            overshoot: false

            SimpleRow {
              //actual content to be displayed in the list rows
              id: row
              text: "Swipe me!"
              detailText: "Left or right, whatever you like!"
            }

            leftOption: SwipeButton {
              //left options, displayed when swiped list row to the right
              text: "Option"
              iconType: IconType.gear
              height: row.height
              hideOptionsOnClick: false //currrently not working, manually hide on click
              onClicked: {
                row.text = "Option clicked"
                container.hideOptions() //hide when button clicked
              }
            }

            rightOption: AppActivityIndicator {
              //right options, displayed when swiped list row to the left
              height: row.height
              width: height
            }

            onRightOptionShown: {
              closeSwipeTimer.start()
            }
          }
        }

        SectionItem {
          title: "Checkbox"

          AppCheckBox {
            text: !checked ? "Check Me!" : "Checked"
            anchors.horizontalCenter: parent.horizontalCenter
          }
        }

        SectionItem {
          title: "BusyIndicator"

          AppActivityIndicator {
            anchors.horizontalCenter: parent.horizontalCenter
          }
        }

        // original busy indicator
        //        SectionContent { contentItem: Column {
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            spacing: dp(10)
        //            AppText { width: parent.width; font.pixelSize: sp(12); text: "BusyIndicator"; horizontalAlignment: Text.AlignHCenter }
        //            BusyIndicator {
        //              anchors.horizontalCenter: parent.horizontalCenter
        //              running: true; implicitWidth: dp(48); implicitHeight: width
        //              visible: !Theme.isIos
        //            }
        //            AppImage {
        //              id: iosActivity
        //              anchors.horizontalCenter: parent.horizontalCenter
        //              source: "../../assets/iosactivity.png"
        //              width: dp(28)
        //              height: dp(28)
        //              smooth: true
        //              antialiasing: true

        //              Timer {
        //                running: true
        //                repeat: true
        //                interval: 100
        //                onTriggered: {
        //                  iosActivity.rotation += 30
        //                  if(iosActivity.rotation === 360)
        //                    iosActivity.rotation = 0
        //                }
        //              }
        //              visible: Theme.isIos
        //            }
        //          }
        //          color: Theme.secondaryBackgroundColor
        //        }


        SectionItem {
          title: "DatePicker"

          DatePicker {
            id: datePicker
            width: parent.width
            dateFormat: "MMM dd yyyy"
            datePickerMode: dateTimeMode
            color: "transparent"
          }

          AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Date: "
                  + datePicker.selectedDate.toDateString()
                  + ", Time: "
                  + leadingZero(datePicker.selectedDate.getHours())
                  + ":"
                  + leadingZero(datePicker.selectedDate.getMinutes())

            function leadingZero(number) {
              return ('00' + number).slice(-2)
            }
          }
        }

        SectionItem {
          title: "FloatingActionButton"

          FloatingActionButton {
            anchors.horizontalCenter: parent.horizontalCenter
            iconType: IconType.star
            anchors.bottom: undefined
            anchors.right: undefined
            visible: true

            onClicked: {
              iconType === IconType.star ? iconType = IconType.envelope : iconType = IconType.star
            }
          }
        }

        SectionItem {
          title: "IconButton"

          IconButton {
            height: dp(30)
            anchors.horizontalCenter: parent.horizontalCenter
            iconType: IconType.hearto
            selectedIconType: IconType.heart
            toggle: true
          }
        }

        // to fill entire row
        SectionItem {
          visible: app.tablet
        }

      } // felgo controls section

      GridSection {
        title: "Qt Quick 2 Controls"
        topPadding: 0

        SectionItem {
          title: "ComboBox"

          CustomComboBox {
            anchors.horizontalCenter: parent.horizontalCenter
            model: ["First", "Second", "Third"]
          }
        }

        SectionItem {
          title: "Dial"

          Dial {
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: dp(96)
            implicitHeight: implicitWidth
            padding: 0
            AppText {
              anchors.centerIn: parent
              text: Math.round(parent.position * 100)
              font.pixelSize: sp(10)
            }
          }
        }

        SectionItem {
          title: "ProgressBar"

          ProgressBar {
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: dp(200)
            indeterminate: true
          }

          ProgressBar {
            id: progressBar
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: dp(200)

            PropertyAnimation {
              target: progressBar
              property: "value"
              from: 0
              to: 1
              duration: 3000
              running: true
              loops: Animation.Infinite
            }
          }
        }

        SectionItem {
          title: "RadioButton"

          Column {
            anchors.horizontalCenter: parent.horizontalCenter

            CustomRadioButton {
              checked: true
              text: "One"
            }

            CustomRadioButton {
              text: "Two"
            }

            CustomRadioButton {
              text: "Three"
            }
          }
        }

        SectionItem {
          title: "SpinBox"

          SpinBox {
            id: spinBox
            anchors.horizontalCenter: parent.horizontalCenter
            implicitHeight: dp(40)

            from: 0
            to: 100
            stepSize: 1
            editable: true

            contentItem: AppText {
              text: spinBox.value
              width: parent.width
              horizontalAlignment: Text.AlignHCenter
              color: spinBox.activeFocus ? Theme.tintColor : Theme.textColor
              wrapMode: Text.NoWrap
            }
          }
        }

        SectionItem {
          title: "ToolTip"

          AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            verticalMargin: 0

            ToolTip.visible: pressed
            ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
            ToolTip.text: "A simple ToolTip"
            text: "Press and Hold"
          }
        }
      } // qt quick 2 controls section

      Section {
        title: "Convenience Controls"

        SectionItem {
          title: "AppCard"
          anchors.horizontalCenter: parent.horizontalCenter

          AppCard {
            id: card

            width: dp(300)
            property real resetX: parent.width/2 - width/2
            x: resetX
            margin: dp(15)

            swipeEnabled: true
            cardSwipeArea.rotationFactor: 0.02
            cardSwipeArea.swipeOutThreshold: dp(180)
            cardSwipeArea.swipeOutDuration: 500

            paper.radius: dp(5)

            header: SimpleRow {
              imageSource: Qt.resolvedUrl("../../assets/architecture-1477041_960_720.jpg")
              text: "Title"
              detailText: "AppCard detailed text"

              image.radius: image.width / 2
              image.fillMode: Image.PreserveAspectCrop
              style: StyleSimpleRow {
                showDisclosure: false
                backgroundColor: "transparent"
              }
            }

            media: AppImage {
              width: parent.width
              fillMode: Image.PreserveAspectFit
              source: Qt.resolvedUrl("../../assets/architecture-1477041_960_720.jpg")
            }

            content: AppText{
              width: parent.width
              padding: dp(15)
              text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
            }

            actions: Row {
              IconButton {
                iconType: IconType.thumbsup
              }
              IconButton {
                iconType: IconType.sharealt
              }
              AppButton {
                text: "Follow"
                flat: true
              }
            }

            cardSwipeArea.onSwipeOutCompleted: {
              card.x = card.resetX
              card.y = 0
              card.rotation = 0
            }
          }
        } // AppCard section

        SectionItem {
          title: "SwipeView"
          width: parent.width

          SwipeView {
            id: swipeView

            anchors.horizontalCenter: parent.horizontalCenter

            property int calculatedWith: (parent.width - dp(30)) > dp(400) ? dp(400) : parent.width - dp(30)
            width: calculatedWith
            height: width / 1.5

            clip: true
            spacing: (parent.width - width) / 2

            Item {
              AppImage {
                source: "../../assets/onu.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
              }
            }
            Item {
              AppImage {
                source: "../../assets/squaby.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
              }
            }
            Item {
              AppImage {
                source: "../../assets/stack.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
              }
            }
          }

          // indicates current SwipeView index
          PageControl {
            id: pageControl
            height: implicitHeight + dp(5)
            pages: swipeView.count
            currentPage: swipeView.currentIndex
            clickableIndicator: true
            spacing: dp(10)
            onPageSelected: {
              swipeView.currentIndex = index
            }
          }
        } // SwipeView section
      } // convenience controls section

      Section {
        title: "Custom Dialogs"

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Dialog"
          flat: false
          onClicked: {
            customDialog.open()
          }
        }
        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "AppModal (fullscreen)"
          flat: false
          onClicked: {
            fullscreenModal.open()
          }
        }
        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "AppModal (custom)"
          flat: false
          onClicked: {
            partialModal.open()
          }
        }
      }

      Section {
        title: "Native Dialogs"
        bottomPadding: dp(Theme.navigationBar.defaultBarItemPadding)

        Grid {
          anchors.horizontalCenter: parent.horizontalCenter
          columns: 2
          horizontalItemAlignment: Grid.AlignHCenter

          AppButton {
            text: "Alert Dialog"
            flat: false
            onClicked: {
              nativeUtils.displayAlertDialog(qsTr("Alert Dialog Title"),
                                             qsTr("Description"), qsTr("OK"),
                                             qsTr("Cancel"))
            }
          }

          AppButton {
            text: "Alert Sheet"
            flat: false
            onClicked: {
              nativeUtils.displayAlertSheet(qsTr("Title"),
                                            ["Option 1", "Option 2"], true)
            }
          }

          AppButton {
            text: "Camera Picker"
            flat: false
            onClicked: {
              nativeUtils.displayCameraPicker()
            }
          }

          AppButton {
            text: "Image Picker"
            flat: false
            onClicked: {
              nativeUtils.displayImagePicker(qsTr("Title"))
            }
          }

          AppButton {
            text: "Date Picker"
            flat: false
            onClicked: {
              nativeUtils.displayDatePicker()
            }
          }

          AppButton {
            text: "Message Box"
            flat: false
            onClicked: {
              nativeUtils.displayMessageBox(qsTr("Message Box Title"),
                                            qsTr("Description"), 1)
            }
          }

          AppButton {
            text: "Text Input"
            flat: false
            onClicked: {
              nativeUtils.displayTextInput(qsTr("Text Input Dialog Title"),
                                           qsTr("Description"),
                                           qsTr("Placeholder"), "")
            }
          }

          AppButton {
            text: "Share"
            flat: false
            onClicked: {
              nativeUtils.share("Felgo is a blast!", "https://felgo.com")
            }
          }
        }
      } // native dialogs section

      Section {
        title: "Native Utils"
        bottomPadding: dp(Theme.navigationBar.defaultBarItemPadding)

        Grid {
          anchors.horizontalCenter: parent.horizontalCenter
          columns: 2
          horizontalItemAlignment: Grid.AlignHCenter

          AppButton {
            text: "Open App"
            flat: false
            onClicked: {
              var launchParam = Theme.isIos ? "fb://profile" : "com.facebook.katana"
              if (!nativeUtils.openApp(launchParam)) {
                NativeDialog.confirm("Facebook app could not be launched.", "",
                                     function () {}, false)
              }
            }
          }

          AppButton {
            text: "Open Url"
            flat: false
            onClicked: {
              nativeUtils.openUrl("https://www.felgo.com")
            }
          }

          AppButton {
            text: "Send Mail"
            flat: false
            onClicked: {
              nativeUtils.sendEmail("", "I just wanted to ...",
                                    "wish you a cool day! ;)")
            }
          }

          AppButton {
            text: "Store Contact"
            flat: false
            onClicked: {
              var vCard = "BEGIN:VCARD
VERSION:2.1
N:Felgo;Office;;;
FN:Felgo
TEL;WORK:0123456789
EMAIL;WORK:help@felgo.com
ADR;WORK:;;Kolonitzgasse;Wien;;1030;Austria
ORG:Felgo
URL:https://www.felgo.com
END:VCARD"
              var success = nativeUtils.storeContacts(vCard)
              if (Theme.isIos) {
                // handle success/error on iOS to give feedback to user
                if (success)
                  NativeDialog.confirm("Contact stored.", "",
                                       function () {}, false)
                else
                  NativeDialog.confirm(
                        "Could not store contact",
                        "The app does not have permission to access the AddressBook, please allow access in the device settings.",
                        function () {}, false)
              } else if (Theme.isAndroid) {
                // only react to error on Android, if successful the device will open the vcard data file
                if (!success) {
                  NativeDialog.confirm(
                        "Could not store contact",
                        "Error when trying to store the vCard to the user documents folder.",
                        function () {}, false)
                }
              } else {
                // platform not supported
                NativeDialog.confirm(
                      "Could not store contact",
                      "Storing contacts is only possible on iOS and Android.",
                      function () {}, false)
              }
            }
          }

          AppButton {
            text: "Vibrate"
            flat: false
            onClicked: {
              nativeUtils.vibrate()
            }
          }
        }
      } // native utils section

      Section {
        title: "Maps and Positioning"
        topPadding: 0

        AppMap {
          id: map
          width: parent.width
          height: dp(300)
          showUserPosition: true

          // Note: Vector maps with MapLibre GL require to use the OpenGL graphics backend
          // Felgo does not force OpenGL on macOS and iOS, as it may cause problems with other Qt components like the Camera or Qt 3D
          // If you do not require such features, you can safely activate OpenGL and use vector maps on all target platforms
          plugin: {
            if (system.isPlatform(System.Wasm)) {
              return mapboxPlugin
            } else if (system.isPlatform(System.Mac) || system.isPlatform(System.IOS)) {
              return osmPlugin
            }
            return mapLibrePlugin
          }

          Plugin {
            id: osmPlugin
            name: "osm"
            parameters: [
              PluginParameter {
                name: "osm.mapping.highdpi_tiles"
                value: true
              },
              PluginParameter {
                name: "osm.mapping.providersrepository.disabled"
                value: "true"
              },
              PluginParameter {
                name: "osm.mapping.providersrepository.address"
                value: "http://maps-redirect.qt.io/osm/5.6/"
              }
            ]
          }

          Plugin {
            id: mapLibrePlugin
            name: "maplibre"

            // Set your own map_id and access_token here
            parameters: [
              PluginParameter {
                name: "maplibre.map.styles"
                value: "https://api.maptiler.com/maps/streets/style.json?key=Po06mqlH0Kut19dceSyI"
              }
            ]
          }

          Plugin {
            id: mapboxPlugin
            name: "mapbox"

            // Set your own map_id and access_token here
            parameters: [
              PluginParameter {
                name: "mapbox.mapping.map_id"
                value: "mapbox/streets-v11"
              },
              PluginParameter {
                name: "mapbox.access_token"
                value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
              },
              PluginParameter {
                name: "mapbox.mapping.highdpi_tiles"
                value: true
              }
            ]
          }

          // set initial map coordinate and zoom level
          center: QtPositioning.coordinate(48.210380, 16.389081)
          zoomLevel: 12

          // add marker item to map
          MapQuickItem {
            // overlay will be placed below Felgo office coordinates
            coordinate: QtPositioning.coordinate(48.210380, 16.389081)

            // the anchor point specifies the point of the sourceItem that will be placed at the given coordinate
            anchorPoint: Qt.point(sourceItem.width / 2, sourceItem.height)

            // place above user position and accuracy items
            z: 3

            // source item holds the actual item that is displayed on the map
            sourceItem: AppImage {
              width: dp(50)
              height: width

              source: "../../assets/map-marker-felgo.png"

              layer.effect: DropShadow {
                horizontalOffset: 2
                verticalOffset: 2
                radius: 16.0
                color: "#80000000"
              }
              layer.enabled: true
            }
          } // MapQuickItem

          // column for zoom in/out buttons
          Column {
            anchors {
              bottom: parent.bottom
              left: parent.left
              margins: dp(5)
            }

            // button to zoom in
            AppButton {
              iconType: IconType.plus
              flat: false
              minimumWidth: height
              onClicked: {
                map.zoomLevel += 1
              }
            }

            // button to zoom out
            AppButton {
              iconType: IconType.minus
              flat: false
              minimumWidth: height
              onClicked: {
                map.zoomLevel -= 1
              }
            }
          }
        }

        Row {
          id: positionRow
          anchors.horizontalCenter: parent.horizontalCenter
          spacing: dp(10)
          width: posButton.width + spacing + posText.contentWidth
          visible: map.userPositionAvailable
          AppButton {
            id: posButton
            text: "Zoom to Position"
            onClicked: map.zoomToUserPosition()
          }
          AppText {
            id: posText
            text: "<b>Lat:</b> "
                  + (map.userPositionAvailable ? map.userPosition.coordinate.latitude.toFixed(
                                                   8) : "Not available") + "<br/><b>Lng:</b> "
                  + (map.userPositionAvailable ? map.userPosition.coordinate.longitude.toFixed(
                                                   8) : "Not available")
            font.pixelSize: sp(11)
            anchors.verticalCenter: parent.verticalCenter
          }
        }
      } // maps section

      Section {
        title: "Device Info"
        bottomPadding: dp(15)

        Row {
          width: parent.width - dp(30)
          anchors.horizontalCenter: parent.horizontalCenter
          spacing: dp(5)

          Column {
            id: firstInfoColumn
            spacing: dp(5)
            width: (parent.width - parent.spacing) * 0.5
            AppText {
              text: "<b>OS Type:</b> " + system.osType
              font.pixelSize: sp(11)
              visible: system.osType !== "undefined"
            }
            AppText {
              text: "<b>OS Version:</b> " + system.osVersion
              font.pixelSize: sp(11)
              visible: system.osVersion !== "undefined"
            }
            AppText {
              text: "<b>Device Model:</b> " + nativeUtils.deviceModel()
              font.pixelSize: sp(11)
              visible: nativeUtils.deviceModel() !== "undefined"
            }
            AppText {
              text: qsTr("<b>Device Online:</b> %1 (%2)").arg(app.isOnline ? "Yes" : "No").arg(nativeUtils.connectionType)
              font.pixelSize: sp(11)
            }
            AppText {
              text: "<b>MAC Address:</b> " + system.macAddress
              font.pixelSize: sp(11)
              width: parent.width
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere
              visible: system.macAddress !== "undefined"
            }
            AppText {
              text: "<b>Unique Device Id:</b> " + system.UDID
              font.pixelSize: sp(11)
              width: parent.width
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere
              visible: system.UDID !== "undefined"
            }
          }

          Column {
            id: secondInfoColumn
            spacing: dp(5)
            width: firstInfoColumn.width
            AppText {
              text: "<b>Orientation:</b> " + (Theme.isPortrait ? "portrait" : "landscape")
              font.pixelSize: sp(11)
            }
            AppText {
              text: "<b>Statusbar Height:</b> " + Theme.statusBarHeight
              font.pixelSize: sp(11)
            }
            AppText {
              text: "<b>App Identifier:</b> " + system.appIdentifier
              font.pixelSize: sp(11)
              width: parent.width
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere
              visible: system.appIdentifier !== "undefined"
            }
            AppText {
              text: "<b>App Version:</b> " + system.appVersionCode
              font.pixelSize: sp(11)
            }
            AppText {
              text: "<b>Qt Version:</b> " + system.qtVersion
              font.pixelSize: sp(11)
            }
            AppText {
              text: "<b>Felgo Version:</b> " + system.felgoVersion + " (" + system.felgoVersionRef + ")"
              font.pixelSize: sp(11)
            }
          }
        }
      } // device info section
    } // content column
  } // flickable

  // scroll indicator
  AppScrollIndicator {
    flickable: scroll
  }

  // timer automatically closing swipe row
  Timer {
    id: closeSwipeTimer
    interval: 1000
    onTriggered: {
      container.hideOptions()
    }
  }

  ThemeModal {
    id: themeModal

    pushBackContent: navigationStack
  } // theme modal

  Dialog {
    id: customDialog
    title: "Do you think this is awesome?"
    autoSize: true
    positiveActionLabel: "Yes"
    negativeActionLabel: "No"
    onCanceled: title = "Think again!"
    onAccepted: close()

    AppText {
      padding: dp(Theme.dialog.defaultContentPadding)
      wrapMode: Text.WordWrap
      width: parent.width
      text: "This is a very long sentence to get some line breaks in this content!"
      // Colors and alignment are platform depending for the best appearance
      color: Theme.isIos ? Theme.colors.textColor : Theme.colors.secondaryTextColor
      horizontalAlignment: Theme.isIos ? Text.AlignHCenter : Text.AlignLeft
    }
  } // custom dialog

  AppModal {
    id: fullscreenModal

    pushBackContent: navigation

    // content with page and native navigation bar
    NavigationStack {
      AppPage {
        title: "Modal"
        rightBarItem: TextButtonBarItem {
          text: "Close"
          textItem.font.pixelSize: sp(16)
          onClicked: fullscreenModal.close()
        }
      }
    }
  } // navigation bar modal

  AppModal {
    id: partialModal

    pushBackContent: navigation

    // Disable fullscreen to use as partial modal
    fullscreen: false
    // Set a custom height for the modal
    modalHeight: dp(300)

    // Button to close the modal
    AppButton {
      text: "Close"
      anchors.centerIn: parent
      onClicked: partialModal.close()
    }
  }
} // page

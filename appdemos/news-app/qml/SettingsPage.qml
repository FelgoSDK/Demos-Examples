import QtQuick
import Felgo


AppPage {

  title: qsTr("Settings")
  tabBarHidden: true

  Column {
      id: settingsCol
      width: parent.width
      anchors.left: parent.left
      anchors.right: parent.right
      AppListItem {
        id: darkModeSetting
        text: qsTr("Dark mode turned ") + (darkModeSwitch.checked ? qsTr("ON") : qsTr("OFF"))
        disclosureItem: AppSwitch {
          id: darkModeSwitch
          checked: dataModel.darkMode
          anchors.verticalCenter: parent.verticalCenter
          onCheckedChanged: {
            dataModel.darkMode = checked
          }
          knobColorOn: "white"
          backgroundColorOn: "#d40000"
        }
      }

      AppListItem {
          id: fontSizeSetting
          disclosureItem: null
          text: qsTr("Font size: ") + (fontSlider.value) +"x"
          AppSlider {
            id: fontSlider
            width: parent.width /  3
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            from: 0.5
            value:  app.spScale
            to: 1.5
            stepSize: 0.25
            onMoved: app.spScale = fontSlider.value
            tintedTrackColor: "red"
            trackColor: "gray"
            knobColor: "white"
          }
      }
  }
}

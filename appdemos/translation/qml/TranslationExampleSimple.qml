import Felgo 4.0

App {
  NavigationStack {
    AppPage {
      // create a localizable text with qsTr() and
      // make it dynamically change by binding to translation.language
      title: qsTr("Hello World") + translation.language

      // toggle language between german and english on button press
      AppButton {
        readonly property bool isEnglish: settings.language === "en_EN"

        anchors.centerIn: parent

        text: "Switch to " + (isEnglish ? "German" : "English")
        onClicked: settings.language = isEnglish ? "de_DE" : "en_EN"
      }
    }
  }
}

import Felgo 4.0
import QtQuick 2.5

App {
  NavigationStack {
    AppPage {
      // create a localizable text with qsTr() and
      // make it dynamically change by binding to translation.language
      title: qsTr("Hello World") + translation.language

      Column {
        AppText {
          id: textItem
          text: qsTr("Hello World") + translation.language
          color: "red"
        }

        AppText {
          text: qsTr("Current language: %1").arg(settings.language || "none")
        }

        AppText {
          text: qsTr("Translation Folder:") + " /" + translation.translationFolder
        }

        AppButton { text: "English"; onClicked: settings.language = "en_EN"; }
        AppButton { text: "German"; onClicked: settings.language = "de_DE";  }
        AppButton { text: "Austrian"; onClicked: settings.language = "de_AT"; }
        AppButton { text: "French"; onClicked: settings.language = "fr_FR"; }
        AppButton { text: "Chinese"; onClicked: settings.language = "cn_CN"; }

        AppButton {
          text: "Use System Language: " + translation.useSystemLanguage
          onClicked: translation.useSystemLanguage = !translation.useSystemLanguage
        }
      }
    }
  }
}

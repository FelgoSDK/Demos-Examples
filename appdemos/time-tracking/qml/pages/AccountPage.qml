import Felgo
import QtQuick

AppPage {
  title: "Jira Account"

  AppButton {
    anchors.centerIn: parent
    text: "Logout"
    onClicked: dataModel.logout()
  }
}

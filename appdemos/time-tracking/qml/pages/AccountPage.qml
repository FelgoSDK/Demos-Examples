import Felgo 4.0
import QtQuick 2.0

AppPage {
  title: "Jira Account"

  AppButton {
    anchors.centerIn: parent
    text: "Logout"
    onClicked: dataModel.logout()
  }
}

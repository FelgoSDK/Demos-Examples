import Felgo 3.0
import QtQuick 2.0

Page {
  title: "Jira Account"

  AppButton {
    anchors.centerIn: parent
    text: "Logout"
    onClicked: dataModel.logout()
  }
}

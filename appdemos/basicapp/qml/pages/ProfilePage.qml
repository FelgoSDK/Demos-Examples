import Felgo 4.0

AppPage {
  title: qsTr("Profile")

  signal logoutClicked

  AppButton {
    anchors.centerIn: parent
    text: qsTr("Logout")
    onClicked: logoutClicked()
  }
}

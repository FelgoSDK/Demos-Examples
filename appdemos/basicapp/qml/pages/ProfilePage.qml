import Felgo

AppPage {
  title: qsTr("Profile")

  signal logoutClicked

  AppButton {
    anchors.centerIn: parent
    text: qsTr("Logout")
    onClicked: logoutClicked()
  }
}

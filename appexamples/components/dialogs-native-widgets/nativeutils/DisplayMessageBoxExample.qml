import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "Message Box"

      AppButton {
        flat: false
        text: "Message Box"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.displayMessageBox("Hi I'm a MessageBox!", "", 2)
        }
      }
    }
  }
}

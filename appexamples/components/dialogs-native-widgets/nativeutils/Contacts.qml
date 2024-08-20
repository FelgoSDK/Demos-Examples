import Felgo 4.0

App {
  NavigationStack {
    AppPage {
      title: "Contacts"

      AppListView {
        anchors.fill: parent
        model: nativeUtils.contacts

        delegate: SimpleRow {
          text: modelData.name
          detailText: modelData.phoneNumbers.join(", ") // Join all numbers into a string separated by a comma
        }
      }
    }
  }
}

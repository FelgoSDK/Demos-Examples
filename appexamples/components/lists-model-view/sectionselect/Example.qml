import Felgo 3.0


App {
  NavigationStack {

    ListPage {
      id: listPage
      title: "SectionSelect"

      // Add dummy entries for list page
      model: {
        var model = []
        for (var i = 0; i < 26; i++) {
          for (var j = 0; j < 5; j++) {
            var entry = {
              text: String.fromCharCode(65 + i) + " " + j,
              // For section display in list
              section: "Section: " + String.fromCharCode(65 + i),
              // Only for SectionSelect, the actual sections all start with 'Section ...'
              letter: String.fromCharCode(65 + i)
            }
            model.push(entry)
          }
        }
        return model
      }
      delegate: SimpleRow { }

      // Activate sections
      section.property: "section"

      SectionSelect {
        id: sectionSelect
        anchors.right: parent.right
        target: listPage.listView
        sectionProperty: "letter"
      }
    }
  }
}

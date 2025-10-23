import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "Foldable Sub-Sections in List Delegate"

      AppListView {
        id: listView
        model: [
          { letter: "A" }, { letter: "B" }, { letter: "C" }, { letter: "D" }, { letter: "E" },
          { letter: "F" }, { letter: "G" }, { letter: "H" }
        ]

        // One sub-array for each list item
        property var subsectionModel: [
          [ { word: "Apple" }, { word: "Ananas"}, { word: "Apricot"}, { word: "Avocado"} ],
          [ { word: "Banana" }, { word: "Blackberry" }, { word: "Blueberry" }, { word: "Blackcurrant"} ],
          [ { word: "Cactus pear" }, { word: "Cherry"}, { word: "Coconut"}, { word: "Cranberry"} ],
          [ { word: "Date" }, { word: "Dragonfruit" }, { word: "Durian" } ],
          [ { word: "Egg Fruit" }, { word: "Elderberry" } ],
          [ { word: "Feijoa" }, { word: "Fig" } ],
          [ { word: "Goji berry" }, { word: "Gooseberry" }, { word: "Grape" }, { word: "Grapefruit" } ],
          [ { word: "Honeyberry" }, { word: "Huckleberry" } ]
        ]

        spacing: dp(20)

        delegate: Item {
          x: dp(10) // left margin
          // the height is bigger if the subsection is visible
          height: letterText.height + (subsectionColumn.visible ? subsectionColumn.height : 0)
          width: parent.width

          AppText {
            id: letterText
            text: modelData.letter
            font.bold: true
          }

          MouseArea {
            // Fill the whole area, so if a subsection is clicked it will be unfolded
            anchors.fill: parent
            onClicked: {
              // Unfold subsection here
              console.debug("Letter clicked:", modelData.letter)
              subsectionColumn.visible = !subsectionColumn.visible // toggle subsection visibility when clicked
            }
          }

          Column {
            id: subsectionColumn
            anchors {
              top: letterText.bottom // position below letterText area
              topMargin: dp(10)
              left: parent.left
              leftMargin: dp(10)
            }
            visible: false // start invisible, show when clicked
            spacing: dp(10)

            Repeater {
              // Automatically set the model here, we could also set the model dynamically when clicking to load later
              model: listView.subsectionModel[index]

              delegate: AppText {
                text: modelData.word
                color: index%2 === 1 ? "salmon" : "lightslategrey"
              }
            }
          }
        }
      }
    }
  }
}

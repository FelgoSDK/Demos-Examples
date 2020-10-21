import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "GridView"

      // A gridview takes a linear model and displays it as a grid
      GridView {
        id: gridView
        anchors.fill: parent
        model: 100

        // We force the cellWidth to be exactly one fourth of total width (so that 4 columns are displayed)
        cellWidth: gridView.width / 4

        // We force the cell to be squared
        cellHeight: cellWidth

        delegate: Item {
          // We force the delegate to have the exact size of the cell
          width: gridView.cellWidth
          height: gridView.cellHeight

          AppPaper {
            anchors { 
              margins: dp(10)
              fill: parent 
            }
          }

          AppText {
            anchors.centerIn: parent
            text: index
          }
        }
      }
    }
  }
}

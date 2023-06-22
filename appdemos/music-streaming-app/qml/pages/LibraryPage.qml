import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QuickControls2
import "../components"
import "../model"


AppPage {
  id: root

  title: "Library"

  DataModel {
    id: favoritesModel
  }

  AppListView {
    model: favoritesModel
    delegate: SearchPageRow {
      onSelected: {
        root.navigationStack.push(previewPageComponent, {"modelEntry": model})
      }
    }

    section.property: "type"
    section.delegate: SimpleSection {

      style.fontBold: true
      style.fontCapitalization: Font.Capitalize
      style.fontSize: 18
      style.showDividers: false
      style.textColor: Theme.textColor
    }

    emptyView.children: [
      AppText {
        anchors.centerIn: parent

        fontSize: 16
        font.bold: true
        text: qsTr("No saved music")
      }
    ]
  }

  Connections {
    target: logic
    onFavoritesChanged: favorite => favoritesModel.showFavorites()
  }

  onPushed: favoritesModel.showFavorites()
}

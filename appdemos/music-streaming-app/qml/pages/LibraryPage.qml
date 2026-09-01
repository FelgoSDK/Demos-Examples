import Felgo
import QtQuick
import QtQuick.Controls as QuickControls2
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
    function onFavoritesChanged(favorite) {
      favoritesModel.showFavorites()
    }
  }

  onPushed: favoritesModel.showFavorites()
}

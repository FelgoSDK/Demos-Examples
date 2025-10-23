import Felgo
import QtQuick
import "../../components"


AppPage {
  id: root

  title: qsTr("Feed")

  rightBarItem: NavigationBarRow {
    IconButtonBarItem {
      color: Theme.navigationBar.titleColor
      iconType: IconType.plus

      onClicked: {
        addPostModal.open()
      }
    }
  }

  AppListView {
    id: listView

    anchors.fill: parent
    interactive: contentHeight > height
    spacing: dp(15)

    model: dataModel

    delegate: FeedListDelegate {
      modelIndex: index
      modelItem: model

      onCommentClicked: {
        root.navigationStack.push(postPageComponent, {"modelIndex": modelIndex, "modelItem": modelItem, "state": "addingComment"})
      }

      onPostClicked: {
        root.navigationStack.push(postPageComponent, {"modelIndex": modelIndex, "modelItem": modelItem})
      }
    }
  }
}

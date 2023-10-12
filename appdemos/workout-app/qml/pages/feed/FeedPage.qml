import Felgo 3.0
import QtQuick 2.0
import "../../components"


Page {
  id: root

  title: qsTr("Feed")

  rightBarItem: NavigationBarRow {
    IconButtonBarItem {
      color: Theme.navigationBar.titleColor
      icon: IconType.plus

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

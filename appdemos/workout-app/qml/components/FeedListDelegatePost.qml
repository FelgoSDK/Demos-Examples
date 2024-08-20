import Felgo 4.0
import QtQuick 2.0


AppImage {
  id: root

  width: parent.width
  height: (width / sourceSize.width) * sourceSize.height

  state: parent.isOnPostPage ? "" : "feedPage"

  states: [
    State {
      name: "feedPage"
      PropertyChanges {
        target: root
        fillMode: Image.PreserveAspectCrop
        height: dp(250)
      }
    }
  ]

  fillMode: Image.PreserveAspectFit
  source: visible ? modelItem.image: ""
  visible: modelItem.image !== undefined && modelItem.image !== ""
}

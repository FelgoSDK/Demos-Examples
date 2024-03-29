import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts 1.11
import "../ui"

Item {
  id: root

  property int todoId
  property bool todoDraft
  property string todoTitle
  property bool todoComplete

  // Each entry will have its pseudo random color (or grey if in draft)
  property color color: todoDraft ? "lightgray" : colorsManager.getPseudoRandomColor(todoId)
  property color textColor: "#99000000"
  property color iconColor: Qt.darker(color, 1.5)
  property real margins: dp(8)

  height: Math.max(title.contentHeight + 6 * margins, dp(64))
  width: parent != null ? parent.width : implicitWidth

  AppPaper {
    anchors.fill: parent
    anchors.margins: margins
    background.color: color
    background.radius: margins
    elevated: true
    shadowColor: "#44000000"

    // The todo text will be displayed as striked out and bold when completed
    AppText {
      id: title
      anchors { left: parent.left; right: icon.left; top: parent.top; margins: root.margins * 2 }
      color: textColor
      text: todoTitle
      font.bold: completed
      font.strikeout: completed
    }

    // A checked icon will be displayed when the task is completed
    AppIcon {
      id: icon
      anchors { right: parent.right; verticalCenter: parent.verticalCenter }
      width: dp(48)
      height: dp(48)
      color: iconColor
      visible: todoComplete || todoDraft
      iconType: todoDraft ? IconType.pencil : IconType.checkcircle
    }

    MouseArea {
      anchors.fill: parent
      onClicked: page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, { todoId: root.todoId })
    }
  }
}

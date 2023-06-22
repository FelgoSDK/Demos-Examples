import QtQuick 2.12


Section {
  id: root

  default property alias content: gridContent.children

  Grid {
    id: gridContent

    width: parent.width

    columns: app.tablet ? 2 : 1
    horizontalItemAlignment: Grid.AlignHCenter
    rowSpacing: dp(30)
  }
}

import Felgo
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

GridLayout {
  id: grid
  anchors.horizontalCenter: parent.horizontalCenter
  width: parent.width > dp(400) ? dp(400) : parent.width
  height: implicitHeight
  columns: 3
  rows: 3
  columnSpacing: 0
  rowSpacing: 0

  property int bpm: -1
  property int min: -1
  property int max: -1
  property int avg: -1
  property bool beating: false

  Behavior on bpm {
    enabled: beating
    NumberAnimation {}
  }

  Behavior on min {
    enabled: beating
    NumberAnimation {}
  }

  Behavior on max {
    enabled: beating
    NumberAnimation {}
  }

  Behavior on avg {
    enabled: (avg > 40) && beating > 0
    NumberAnimation {
      duration: 9500
    }
  }

  Item {
    Layout.column: 0
    Layout.row: 0
    Layout.rowSpan: 3
    Layout.preferredWidth: grid.width/3
    Layout.preferredHeight: dp(80)
    AppText {
      anchors.centerIn: parent
      text: min > 0 ? min : "--"
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignBottom
      fontSize: 30
      AppText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: dp(2)
        text: qsTr("MIN")
      }
    }
  }

  Item {
    Layout.column: 1
    Layout.row: 0
    Layout.rowSpan: 1
    Layout.preferredWidth: grid.width/3
    Layout.preferredHeight: dp(90)

    AppText {
      anchors.bottom: parent.bottom
      anchors.bottomMargin: dp(5)
      anchors.horizontalCenter: parent.horizontalCenter
      text: "%1".arg(beating ? grid.bpm : "--")
      fontSize: 72
      layer.enabled: true
      layer.effect: DropShadow {
        verticalOffset: 3
        color: "#80000000"
        radius: dp(10)
        //samples: radius*2+1
      }
    }
  }

  Item {
    Layout.column: 1
    Layout.row: 1
    Layout.rowSpan: 1
    Layout.preferredWidth: grid.width/3
    Layout.preferredHeight: dp(60)
    width: Layout.preferredWidth
    height: Layout.preferredHeight

    AppText {
      anchors.centerIn: parent
      text: "bpm"
      fontSize: 30
      layer.enabled: true
      layer.effect: DropShadow {
        verticalOffset: 3
        color: "#80000000"
        radius: dp(10)
        //samples: radius*2+1
      }
    }
  }

  Item {
    Layout.column: 1
    Layout.row: 2
    Layout.rowSpan: 1
    Layout.preferredWidth: grid.width/3
    Layout.preferredHeight: dp(60)
    width: Layout.preferredWidth
    height: Layout.preferredHeight

    AppText {
      anchors.centerIn: parent
      text: avg > 0 ? avg : "--"
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignBottom
      fontSize: 30
      AppText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: dp(2)
        text: qsTr("AVG")
      }
    }
  }

  Item {
    Layout.column: 2
    Layout.row: 0
    Layout.rowSpan: 3
    Layout.preferredWidth: grid.width/3
    Layout.preferredHeight: dp(80)

    AppText {
      anchors.centerIn: parent
      text: max > 0 ? max : "--"
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignBottom
      fontSize: 30
      AppText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: dp(2)
        text: qsTr("MAX")
      }
    }
  }
}

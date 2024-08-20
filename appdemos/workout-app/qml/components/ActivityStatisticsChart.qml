import Felgo 4.0
import QtQuick 2.0
import QtCharts 2.3


AppPaper {
  id: root

  property real totalValue: 1
  property real value: 0
  property string activity: "Ride"

  radius: dp(2)
  shadowColor: "#40000000"

  ChartView {
    id: chart
    anchors.fill: parent
    legend.alignment: Qt.AlignBottom
    legend.visible: false
    margins {
      top: 0
      bottom: 0
      left: 0
      right: 0
    }

    antialiasing: true

    PieSeries {
      id: pieSeries
      holeSize: 0.8
      size: 0.9
      startAngle: 20
      endAngle: 380

      PieSlice {
        value: root.value
        color: Theme.tintColor

        Behavior on value {
          NumberAnimation {
            duration: 1000
          }
        }
      }

      PieSlice {
        value: root.totalValue
        color: Theme.secondaryBackgroundColor
      }
    }
  }

  Column {
    anchors.centerIn: parent
    spacing: dp(2)

    AppImage {
      anchors.horizontalCenter: parent.horizontalCenter

      width: dp(30)
      height: width

      source: "../../assets/icons/sports/" + root.activity + ".png"
    }

    AppText {
      anchors.horizontalCenter: parent.horizontalCenter

      font.pixelSize: dp(15)
      text: root.activity + " " + Math.floor(100 * root.value / root.totalValue) + "%"
    }
  }

  function loadData(totalValue, value) {
    if (totalValue === root.totalValue) {
      return
    }

    root.totalValue = totalValue
    root.value = value
  }
}

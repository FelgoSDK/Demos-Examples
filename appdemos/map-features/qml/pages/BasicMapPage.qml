import Felgo 4.0
import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import "../"

AppPage {
  id: root
  title: qsTr("Basic map")

  AppMap {
    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    // Configure map provider
    plugin: MapPlugin {}
  }
}

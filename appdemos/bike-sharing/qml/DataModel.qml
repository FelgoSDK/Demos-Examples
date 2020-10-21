import QtQuick 2.0
import Felgo 3.0

Item {
  signal stationsLoaded()

  readonly property alias stationsModel: jsonStationsModel

  // Use requestStations to load JSON from a REST API, load data into JsonListModel
  function requestStations() {
    HttpRequest.get(Qt.resolvedUrl("data/citybike.json"))
    .timeout(5000)
    .then(function(res) {
      jsonStationsModel.source = JSON.parse(res.body)["station"]
      stationsLoaded()
    })
    .catch(function(err) { console.error(err) });
  }

  JsonListModel {
    id: jsonStationsModel
    source: []
    keyField: "id"
  }

  // How to use XML for data exchange
  /*XmlListModel {
    id: xmlStationsModel

    source: "http://dynamisch.citybikewien.at/citybike_xml.php"
    query: "/stations/station"

    XmlRole { name: "internalId"; query: "internal_id/number()" }
    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "description"; query: "description/string()" }

    XmlRole { name: "latitude"; query: "latitude/number()" }
    XmlRole { name: "longitude"; query: "longitude/number()" }

    XmlRole { name: "availability"; query: "status/string()" }
    XmlRole { name: "boxes"; query: "boxes/string()" }
    XmlRole { name: "freeBoxes"; query: "free_boxes/number()" }
    XmlRole { name: "freeBikes"; query: "free_bikes/number()" }

    onStatusChanged: {
      if (status === XmlListModel.Ready) {
        stationsLoaded()
      }
    }
  }*/

}

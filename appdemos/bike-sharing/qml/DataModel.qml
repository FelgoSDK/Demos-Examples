import QtQuick 2.0
import Felgo 3.0

Item {
  signal stationsLoaded()

  readonly property alias stations: stationsModelJson

  function requestStations() {
    stationsModelJson.request()
  }

  // Load JSON from a REST API into JsonListModel
  JsonListModel {
    id: stationsModelJson
    keyField: "id"

    function request(){
      HttpRequest.get(Qt.resolvedUrl("data/citybike.json"))
      .timeout(5000)
      .then(function(res) {
        stationsModelJson.source = JSON.parse(res.body)["station"]
        stationsLoaded()
      })
      .catch(function(err) { console.error(err) });
    }
  }

  /* // How to use XML for data exchange
    XmlListModel {
      id: stationsModelXml

      source: "https://dynamisch.citybikewien.at/citybike_xml.php"
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
    }
    */
}

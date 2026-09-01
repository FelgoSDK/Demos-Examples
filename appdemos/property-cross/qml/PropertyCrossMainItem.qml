import QtQuick
import "pages"
import "model"

Item {
  anchors.fill: parent

  DataModel {
    id: dataModel
    dispatcher: logic
  }

  Logic {
    id: logic
  }

  PropertyCrossMainPage { }
}

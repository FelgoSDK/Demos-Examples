import QtQuick
import "pages"
import "model"

Item {
  anchors.fill: parent

  Component.onCompleted: logic.fetchTwitterData()

  DataModel {
    id: dataModel
    dispatcher: logic
  }

  Logic {
    id: logic
  }

  TwitterMainPage { }
}

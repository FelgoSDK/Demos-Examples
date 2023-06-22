import Felgo 4.0
import QtQuick 2.0


SimpleRow {
  id: root

  showDisclosure: true
  text: model.name
  imageSource: Qt.resolvedUrl(dataModel.getCover(model))

  style: StyleSimpleRow {
    backgroundColor: Theme.colors.backgroundColor
    selectedBackgroundColor: backgroundColor
    textColor: Theme.colors.textColor
    detailTextColor: Theme.colors.textColor
    selectedTextColor: Theme.colors.secondaryTextColor
    dividerHeight: 0
  }

  detailText: {
    if (model.type === "Song" || model.type === "Podcast") {

      var author = ""
      if (model.album !== "" && model.album !== undefined) {
        author =  dataModel.findAndGetFieldValue(model.album, "author")
      } else if (model.author !== "" && model.author !== undefined) {
        author = model.author
      }

      if (author !== "") {
        return model.type + " • " + author
      }

      if (model.tags.length > 0) {
        return model.type + " • " + model.tags[0]
      }
    }

    return model.type
  }
}

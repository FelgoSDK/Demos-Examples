import Felgo 3.0
import QtQuick 2.0
import "../common"

ListPage {
  id: tracksPage

  property var tracksModel: dataModel.tracks !== undefined ? dataModel.tracks : { }

  title: "Tracks"

  model: JsonListModel {
    id: listModel
    source: dataModel.preparedTracks//viewHelper.prepareTracks(tracksModel)
    keyField: "title"
    fields: ["title", "talks", "color"]
  }

  delegate: TrackRow {
    track: listModel.get(index)
    onClicked: {
      if(Theme.isAndroid)
        //tracksPage.navigationStack.popAllExceptFirstAndPush(Qt.resolvedUrl("TrackDetailPage.qml"), { track: track })
        tracksPage.navigationStack.popAllExceptFirstAndPush(trackDetailPageComponent, { track: track })
      else
        //tracksPage.navigationStack.push(Qt.resolvedUrl("TrackDetailPage.qml"), { track: track })
        tracksPage.navigationStack.push(trackDetailPageComponent, { track: track })
    }
  }
}

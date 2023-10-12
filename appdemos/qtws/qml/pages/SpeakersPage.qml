import Felgo 3.0
import QtQuick 2.0
import "../common"

ListPage {
  id: speakersPage

  //property var speakersModel: dataModel.speakers !== undefined ? dataModel.speakers : {}

  title: "Speakers"
//  listView.cacheBuffer: 100

  model: JsonListModel {
    id: listModel
    source: dataModel.preparedSpeakers//prepareSpeakers(speakersModel)
    keyField: "id"
    fields: [ "id","first_name","last_name","abstract","avatar","talks","firstLetter" ]
  }
  section.property: "firstLetter"
  section.delegate: SimpleSection {
    style.compactStyle: Theme.isIos
  }

  delegate: SpeakerRow {
    speaker: listModel.get(index)
    small: true
    onClicked: {
      if(Theme.isAndroid)
        //speakersPage.navigationStack.popAllExceptFirstAndPush(Qt.resolvedUrl("SpeakerDetailPage.qml"), { speakerID: speaker.id })
        speakersPage.navigationStack.popAllExceptFirstAndPush(speakerDetailPageComponent, { speakerID: speaker.id })
      else
        //speakersPage.navigationStack.push(Qt.resolvedUrl("SpeakerDetailPage.qml"), { speakerID: speaker.id })
        speakersPage.navigationStack.push(speakerDetailPageComponent, { speakerID: speaker.id })
    }
  }

  listView.scrollIndicatorVisible: false

  SectionSelect {
    id: sectionSelect
    anchors.right: parent.right
    target: speakersPage.listView
  }
}

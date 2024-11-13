import Felgo
import QtQuick
import "../common"
import "../details"

ListPage {
  id: speakersPage

  title: qsTr("Speakers")
  backgroundColor: Theme.colors.secondaryBackgroundColor

  model: SortFilterProxyModel {
    sourceModel: JsonListModel {
      source: Object.values(dataModel.speakers)
      keyField: "id"
      fields: [ "id","full_name","title","avatar","talks","firstLetter" ]
    }

    sorters: [
      LocaleAwareSorter {
        roleName: "firstLetter"
      }]
  }

  section.property: "firstLetter"
  section.delegate: SimpleSection {
    style.compactStyle: Theme.isIos
  }

  listView.anchors.rightMargin: dp(20)
  listView.bottomMargin: dp(Theme.contentPadding)

  delegate: SpeakerRow {
    speaker: speakersPage.model.get(index)

    onSelected: {
      if(Theme.isAndroid)
        speakersPage.navigationStack.popAllExceptFirstAndPush(speakerDetailPageComponent, { speakerID: speaker.id })
      else
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

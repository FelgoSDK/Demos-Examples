import QtQuick 2.4
import Felgo 4.0

ListPage {
  id: page
  title: qsTr("Chats")

  emptyText.text: qsTr("No recent messages")

  // Use a predefined delegate but change some of its layout parameters
  delegate: SimpleRow {
    image.radius: image.height
    image.fillMode: Image.PreserveAspectCrop
    imageMaxSize: dp(56)

    textItem.x: detailTextItem.x
    textItem.font.bold: true

    detailTextItem.maximumLineCount: 1
    detailTextItem.elide: Text.ElideRight

    style.showDisclosure: false

    onSelected: {
      page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, {
                                     personData: item,
                                     newMsgs: [{me: true, text: item.detailText}]
                                   })
    }
  }

  Component { id: detailPageComponent;  ConversationPage { } }


  // Model should be loaded from your messaging backend
  model: [
    { text: "Tom McEloy", detailText: "Sorry for the late reply ...", image: Qt.resolvedUrl("../../assets/portrait0.jpg") },
    { text: "Leah Douglas", detailText: "Hahaha :D", image: Qt.resolvedUrl("../../assets/portrait1.jpg") }
  ]
}

import QtQuick 2.0
import Felgo 3.0

Page {
  id: page
  property string category

  Component.onCompleted: {
    dataModel.createModelForCategory(category, function (result) {
      listModel.source = result
    })

  }

  // Incoming category looks like "general"
  // Remove quotes from the category string and make the first char upper case.
  title: qsTr(JSON.stringify(category).replace(/\"/g, "").charAt(0).toUpperCase() + category.slice(1))

  AppListView {
    id: listView
    model: JsonListModel {
      id: listModel
      fields: ["articleTitle", "detailText", "image", "model", "shareUrl"]
    }

    spacing: dp(Theme.contentPadding)

    delegate: Rectangle {
      id: articleRect
      color: dataModel.backgroundColor
      width: listView.width
      implicitHeight: dp(30) + text1.implicitHeight + Math.max(text2.implicitHeight, img1.implicitHeight)

      MouseArea {
        width: parent.width
        anchors.fill: parent
        onClicked: page.navigationStack.push(articleDetailPage, {articleModel: model, articleCategory: category})

        Column {
          id: contentCol
          width: parent.width
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.margins: dp(10)
          spacing: dp(10)
          x: dp(Theme.navigationBar.defaultBarItemPadding)
          y: x

          AppText {
            id: text1
            text: model.title
            wrapMode: "WrapAtWordBoundaryOrAnywhere"
            width: parent.width
            font.family: ebgaramondFont.name
            font.pixelSize: sp(22)
            font.bold: true
            color: dataModel.articleTextColor
          }

          Row {
            width: parent.width
            spacing: dp(5)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: dp(20)

            AppText {
              id:text2
              visible: (model.description !== null && model.description !== "")
              text: model.description
              wrapMode: "WrapAtWordBoundaryOrAnywhere"
              width: parent.width
              font.family: nunitoFont.name
              font.pixelSize: sp(17)
              color: dataModel.articleTextColor
            }

            Image {
              id: img1
              visible: false
              source: model.urlToImage || ""
              width: text2.visible ? (parent.width / 5*2) : parent.width
              fillMode: Image.PreserveAspectFit
            }

            states: [
              State {
                name: "loaded"
                when: img1.status == Image.Ready
                PropertyChanges { target: text2; width: (parent.width / 5) * 3 }
                PropertyChanges { target: img1; visible: true }
              }
            ]
          }
        }
      }
    }
  }
}

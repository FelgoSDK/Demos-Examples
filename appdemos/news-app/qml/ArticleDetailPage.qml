import QtQuick
import Felgo

FlickablePage {
  property var articleModel
  property string articleCategory

  backgroundColor: dataModel.backgroundColor
  flickable.contentHeight: articleCol.height * 1.1
  tabBarHidden: true

  title: qsTr(JSON.stringify(articleCategory).replace(/\"/g, "").charAt(0).toUpperCase() + articleCategory.slice(1))

  rightBarItem: IconButtonBarItem {
    iconType: IconType.share
    visible: system.isPlatform(System.IOS) || system.isPlatform(System.Android)
    onClicked: nativeUtils.share(qsTr("Check out this article!"), articleModel.url)
  }

  Column {
    id: articleCol
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: dp(10)
    anchors.top: parent.top
    spacing: dp(15)

    Image {
      source: articleModel.urlToImage
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width
      fillMode: Image.PreserveAspectFit
    }

    AppText {
      id: titleText
      text: articleModel.title
      wrapMode: "WrapAtWordBoundaryOrAnywhere"
      width: parent.width
      font.family: ebgaramondFont.name
      font.pixelSize: sp(24)
      font.bold: true
      color: dataModel.articleTextColor
    }

    AppText {
      id: descriptionText
      text: articleModel.description
      wrapMode: "WrapAtWordBoundaryOrAnywhere"
      width: parent.width
      font.family: nunitoFont.name
      font.pixelSize: sp(20)
      color: dataModel.articleTextColor
    }

    AppText {
      id: contentText
      text: articleModel.content
      wrapMode: "WrapAtWordBoundaryOrAnywhere"
      width: parent.width
      font.family: nunitoFont.name
      font.pixelSize: sp(17)
      color: dataModel.articleTextColor
    }
  }
}


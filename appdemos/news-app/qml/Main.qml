import Felgo 3.0
import QtQuick 2.0
import "model"
import Qt.labs.settings 1.0
 import QtQml.Models 2.1

App {
  id: app

  onInitTheme: {
    Theme.normalFont = baskervvilleFont
    Theme.navigationBar.backgroundColor = Qt.binding(function () { return dataModel.redColor })
    Theme.navigationBar.titleColor = "white"
    Theme.navigationBar.itemColor = "white"
    Theme.colors.backgroundColor = Qt.binding(function () { return dataModel.darkMode ? "black" : "gainsboro" })
    Theme.contentPadding = 15
    Theme.navigationTabBar.backgroundColor = Qt.binding(function () { return dataModel.backgroundColor })
    Theme.navigationTabBar.titleColor = "red"
    Theme.navigationTabBar.titleOffColor = Qt.binding(function () { return dataModel.darkMode ? "white" : "dimgray" })
    Theme.colors.statusBarStyle = 1
    Theme.listItem.fontSizeText = 25
    Theme.listItem.minimumHeight = 70
    Theme.listItem.backgroundColor = Qt.binding(function () { return dataModel.backgroundColor })
    Theme.listItem.textColor = Qt.binding(function () { return dataModel.darkMode ? "white" : "black" })
    Theme.appCheckBox.fillColorOn = Qt.binding(function () { return dataModel.redColor })
    Theme.appCheckBox.borderColorOn = Qt.binding(function () { return dataModel.redColor })
    Theme.colors.tintColor = Qt.binding(function () { return dataModel.backgroundColor })
    Theme.colors.secondaryBackgroundColor = Qt.binding(function () { return dataModel.darkMode ? "black" : "gainsboro" })
    Theme.colors.textColor = Qt.binding(function () { return dataModel.darkMode ? "white" : "black" })
    Theme.colors.secondaryTextColor = Qt.binding(function () { return dataModel.darkMode ? "white" : "#262626" })
    Theme.listItem.dividerColor = Qt.binding(function () { return dataModel.darkMode ? "dimgray" : "gainsboro" })
    Theme.listItem.selectedBackgroundColor = Qt.binding(function () { return dataModel.darkMode ? "#141414" : "ghostwhite" })
  }

  FontLoader {
    id: baskervvilleFont
    source: "../assets/Baskervville-Regular.ttc"
  }

  FontLoader {
    id: ebgaramondFont
    source: "../assets/EBGaramond-Bold.ttc"
  }

  FontLoader {
    id: nunitoFont
    source: "../assets/Nunito-Regular.ttc"
  }

  Logic {
    id: logic
  }

  DataModel {
    id: dataModel
    dispatcher: logic
  }

  ListModel {
    id: menuModel

    ListElement {
      name: "business"
      listText: "Business"
      favorite: false
    }
    ListElement {
      name: "health"
      listText: "Health"
      favorite: false
    }
    ListElement {
      name: "science"
      listText: "Science"
      favorite: false
    }
    ListElement {
      name: "technology"
      listText: "Technology"
      favorite: false
    }
    ListElement {
      name: "sports"
      listText: "Sports"
      favorite: true
    }
    ListElement {
      name: "entertainment"
      listText: "Entertainment"
      favorite: true
    }
  }


  MainPage {}

  Component {
    id: settingsPage
    SettingsPage {}
  }

  Component {
    id: articleDetailPage
    ArticleDetailPage {}
  }

  Component {
    id: categoryPage
    CategoryPage {}
  }

  Component {
    id: morePage
    MorePage {}
  }
}

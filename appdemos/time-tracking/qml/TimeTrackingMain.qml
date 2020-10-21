import Felgo 3.0
import QtQuick 2.0
import "pages"
import "model"

App {
  id: app

  onInitTheme: {
    Theme.colors.tintColor = "#0052CC"
  }

  DataModel {
    id: dataModel
  }

  LoginPage {
    visible: !dataModel.loggedIn
    onLogin: dataModel.login()
  }

  Navigation {
    id: navigation
    drawerMinifyEnabled: true
    drawerLogoSource: Qt.resolvedUrl("../assets/jira-logo.png")

    NavigationItem {
      title: "Jira Worklogs"
      icon: IconType.clocko

      NavigationStack {
        splitView: app.tablet && app.landscape
        leftColumnWidth: parent.width/2

        WorklogsPage {}
      }
    }

    NavigationItem {
      title: "Jira Issues"
      icon: IconType.magic

      NavigationStack {
        splitView: app.tablet && app.landscape
        leftColumnWidth: parent.width/2

        IssuesPage {}
      }
    }

    NavigationItem {
      title: "Jira Account"
      icon: IconType.user

      NavigationStack {

        AccountPage {}
      }
    }
  }
}

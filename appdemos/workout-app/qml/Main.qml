import Felgo
import QtQuick
import QtQml

import "model"
import "pages/feed"
import "pages/profile"
import "pages/workout"

App {
  id: app

  property date currentDate: new Date()
  property string dateString

  Component.onCompleted: {
    print(new Date().toLocaleString(Qt.locale("en_US"), Locale.ShortFormat));
  }

  onInitTheme: {

    Theme.colors.tintColor = "#004FAC"

    Theme.navigationTabBar.backgroundColor = "#f8f8f8"
    Theme.navigationTabBar.titleOffColor = "#4C004FAC"
    Theme.navigationTabBar.titleColor = "#004FAC"

    Theme.navigationBar.titleAlignLeft = false
  }

  DataModel {
    id: dataModel
  }

  Statistics {
    id: statistics
  }

  Storage {
    id: storage
  }

  Navigation {
    id: navigation

    navigationMode: navigationModeTabs

    property int previousIndex: 0

    onCurrentIndexChanged: {
      if (currentIndex == 1) {

        if (workoutModal.workout.isActive) {
          navigation.currentIndex = navigation.previousIndex
          workoutModal.open()
        }
        return
      }

      navigation.previousIndex = navigation.currentIndex
    }

    NavigationItem {
      title: qsTr("Feed")
      iconComponent: iconComponent

      NavigationStack {
        id: feedNavigationStack
        initialPage: FeedPage { }
      }
    }

    NavigationItem {
      title: qsTr("Workout")
      iconComponent: iconComponent

      NavigationStack {
        initialPage: WorkoutActivitiesPage { }
      }
    }

    NavigationItem {
      title: qsTr("Profile")
      iconComponent: iconComponent

      NavigationStack {
        id: profileNavigationStack
        initialPage: ProfilePage { }
      }
    }
  }

  Component {
    id: postPageComponent

    PostPage { }
  }

  Component {
    id: feedMapPageComponent

    FeedMapPage { }
  }

  Component {
    id: workoutMapPageComponent

    WorkoutActivitiesPage { }
  }

  // icon component for custom icons in navigation tabs
  Component {
    id: iconComponent

    Image {
      anchors.fill: parent
      anchors.margins: dp(2)

      opacity: parent.selected ? 1 : 0.3

      source: parent.navItem ? "../assets/icons/" + parent.navItem.title.toLowerCase() + ".png" : ""
    }
  }

  AddPostModal {
    id: addPostModal

    modalHeight: Theme.isAndroid ? app.screenHeight - Theme.statusBarHeight : app.screenHeight
  }

  WorkoutModal {
    id: workoutModal

    modalHeight: Theme.isAndroid ? app.screenHeight - Theme.statusBarHeight : app.screenHeight

    onClosed: {
      if (workoutModal.workout.isActive) {
        navigation.currentIndex = navigation.previousIndex
      }
    }
  }
}

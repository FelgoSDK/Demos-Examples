import Felgo 3.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import "../../components"
import "../../model"


AppModal {
  id: root

  property Workout workout: Workout { }

  pushBackContent: navigation
  overlayColor: "#fff"
  overlayOpacity: 0.05

  fullscreen: false

  NavigationStack {
    id: navigationStack

    navigationBar.backgroundColor: Theme.navigationTabBar.backgroundColor
    navigationBar.titleItem: AppText {
      text: navigationStack.currentTitle
      color: Theme.textColor
    }

    initialPage: WorkoutMapPage {
      workout: root.workout

      onClosedButtonClicked: {
        root.close()
      }
    }

    Component {
      id: workoutSavePageComponent

      WorkoutSavePage { }
    }
  } // navigation stack
}

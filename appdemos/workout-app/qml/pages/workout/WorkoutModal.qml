import Felgo
import QtQuick
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

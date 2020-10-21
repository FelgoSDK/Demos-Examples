import Felgo 3.0
import "pages"


App {
  id: app
  color: "#000"

  onInitTheme: {
    if (system.desktopPlatform) {
      Theme.platform = "ios"
    }
  }

  Navigation {
    id: navigation

    NavigationItem {
      id: uiComponentsItem
      title: "UI Components"
      icon: IconType.calculator

      NavigationStack {
        ControlsPage {
          title: uiComponentsItem.title
        }
      }
    }

    NavigationItem {
      id: animationsItem
      title: "Animations"
      icon: IconType.bomb

      NavigationStack {
        navigationBarShadow: false
        AnimationsPage {
          title: animationsItem.title
        }
      }
    }

    NavigationItem {
      id: effectsItem
      title: "Effects"
      icon: IconType.bolt

      NavigationStack {
        EffectsPage {
          title: effectsItem.title
        }
      }
    }
  }
}

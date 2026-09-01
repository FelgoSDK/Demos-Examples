import Felgo
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
      iconType: IconType.calculator

      NavigationStack {
        ControlsPage {
          title: uiComponentsItem.title
        }
      }
    }

    NavigationItem {
      id: animationsItem
      title: "Animations"
      iconType: IconType.bomb

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
      iconType: IconType.bolt

      NavigationStack {
        EffectsPage {
          title: effectsItem.title
        }
      }
    }
  }
}

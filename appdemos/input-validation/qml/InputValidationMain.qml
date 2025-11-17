import Felgo
import QtQuick

App {
  Navigation {
    id: navigation

    NavigationItem {
      title: qsTr("Signup")
      iconType: IconType.key

      NavigationStack {
        SignupPage {
          id: mainPage
        }
      }
    }

    NavigationItem {
      title: qsTr("Profile")
      iconType: IconType.user

      NavigationStack {
        ProfilePage {
          id: profilePage
        }
      }
    }

    function navigateToProfilePage() {
      currentIndex = 1
    }
  }
}

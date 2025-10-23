import QtQuick // Required for Grid.horizontalItemAlignment
import Felgo


App {
  NavigationStack {
    FlickablePage {
      title: "AppTextField with Validator"
      flickable.contentHeight: grid.height
      flickable.topMargin: dp(20)

      Grid {
        id: grid
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 2
        spacing: dp(20)

        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter

        AppText {
          text: "inputModeDefault"
        }

        AppTextField {
          inputMode: inputModeDefault
          width: dp(200)
        }

        AppText {
          text: "inputModeUsername"
        }

        AppTextField {
          inputMode: inputModeUsername
          width: dp(200)
        }

        AppText {
          text: "inputModeEmail"
        }

        AppTextField {
          inputMode: inputModeEmail
          width: dp(200)
        }

        AppText {
          text: "inputModeUrl"
        }

        AppTextField {
          inputMode: inputModeUrl
          width: dp(200)
        }

        AppText {
          text: "inputModePassword"
        }

        AppTextField {
          inputMode: inputModePassword
          width: dp(200)
        }
      }
    }
  }
}

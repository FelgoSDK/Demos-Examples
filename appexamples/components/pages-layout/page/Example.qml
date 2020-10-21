import Felgo 3.0
import QtQuick 2.0


App {
  id: app

  property int count: 0

  NavigationStack {
    Page {
      id: mainPage
      title: "Page"

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Current count " + app.count
        }

        AppButton {
          text: "Push Counter Page"
          onClicked: {
            // Push page with buttons to change counter
            mainPage.navigationStack.push(counterPageComponent)
          }
        }
      }
    }
  }

  // Inline-definition of a component, which is later pushed on the stack
  Component {
    id: counterPageComponent
    Page {
      title: "Change Count"
      property Page target: null

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        // Buttons to increase/decrease the count, which is displayed on the main page
        AppButton {
          text: "Count +1 "
          onClicked: {
            app.count++
          }
        }

        AppButton {
          text: "Count -1"
          onClicked: {
            app.count--
          }
        }
      }
    }
  }
}

import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    AppPage {
      id: page
      title: "PageControl"

      QC2.SwipeView {
        id: view

        currentIndex: 0
        anchors.fill: parent

        Rectangle {
          id: firstPage
          width: page.width
          height: page.height
          color: "oldlace"

          AppText {
            anchors.centerIn: parent
            text: "Swipe right"
          }
        }

        Rectangle {
          id: secondPage
          width: page.width
          height: page.height
          color: "navajowhite"

          AppText {
            anchors.centerIn: parent
            text: "Swipe left or right"
          }
        }

        Rectangle {
          id: thirdPage
          width: page.width
          height: page.height
          color: "mistyrose"

          AppText {
            anchors.centerIn: parent
            text: "Swipe left"
          }
        }
      }

      PageControl {
        pages: 3
        anchors {
          bottom: parent.bottom
          bottomMargin: dp(Theme.contentPadding) + nativeUtils.safeAreaInsets.bottom
        }
        currentPage: view.currentIndex
      }
    }
  }
}

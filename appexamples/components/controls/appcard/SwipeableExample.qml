import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "Swipeable AppCard"

      AppCard {
        id: card
        width: parent.width
        margin: dp(20)
        paper.radius: dp(5)
        swipeEnabled: true
        cardSwipeArea.rotationFactor: 0.05

        // If the card is swiped out, this signal is fired with the direction as parameter
        cardSwipeArea.onSwipedOut: {
          console.log("Card swiped out: " + direction)
        }

        // We use a slightly adapted SimpleRow as header cell, this gives us nice styling with low effort
        header: SimpleRow {
          imageSource: "https://raw.githubusercontent.com/FelgoSDK/Demos-Examples/qt5/preview-assets/appexamples/components/appcard/architecture-1477041_960_720.jpg"
          text: "Lorem ipsum"
          detailText: "Ut enim ad minim veniam"

          enabled: false
          image {
            radius: image.width/2
            fillMode: Image.PreserveAspectCrop
          }
          style: StyleSimpleRow {
            showDisclosure: false
            backgroundColor: "transparent"
          }
        }

        // For the media cell, we use a simple AppImage
        media: AppImage {
          width: parent.width
          fillMode: Image.PreserveAspectFit
          source: "https://cdn.pixabay.com/photo/2016/06/24/10/47/architecture-1477041_960_720.jpg"
        }

        // For the content cell, we use some placeholder text
        content: AppText{
          width: parent.width
          padding: dp(15)
          text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        }

        // Some useless buttons to display in the actions cell
        actions: Row {
          IconButton {
            icon: IconType.thumbsup
          }
          IconButton {
            icon: IconType.sharealt
          }
          AppButton {
            text: "Follow"
            flat: true
          }
        }
      }
    }
  }
}

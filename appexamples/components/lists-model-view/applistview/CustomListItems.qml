import Felgo
import QtQuick


App {

  onInitTheme: {
    Theme.colors.backgroundColor = "steelblue"
    Theme.colors.secondaryBackgroundColor = Theme.colors.backgroundColor
    Theme.colors.textColor = "white"
  }

  NavigationStack {
    AppPage {
      title: "Custom List Delegate"

      AppListView {
        id: myListView

        x: dp(20) // left margin
        y: dp(20) // top margin

        property real widthDay: dp(120)
        property real widthTempMaxMin: dp(90)
        property real widthRain: dp(60)
        property real itemRowSpacing: dp(30)
        spacing: dp(5) // Vertical spacing between list items/rows/delegates

        // Model will usually come from a web server, copy it here for faster development & testing
        model: [
          { day: "Monday",    tempMax: 21, tempMin: 15, rainProbability: 0.8, rainAmount: 3.153 },
          { day: "Tuesday",   tempMax: 24, tempMin: 15, rainProbability: 0.2, rainAmount: 0.13 },
          { day: "Wednesday", tempMax: 26, tempMin: 16, rainProbability: 0.01, rainAmount: 0.21 },
          { day: "Thursday",  tempMax: 32, tempMin: 21, rainProbability: 0, rainAmount: 0 },
          { day: "Friday",    tempMax: 28, tempMin: 20, rainProbability: 0, rainAmount: 0 },
          { day: "Saturday",  tempMax: 26, tempMin: 19, rainProbability: 0, rainAmount: 0 },
          { day: "Sunday",    tempMax: 25, tempMin: 19, rainProbability: 0, rainAmount: 0 }
        ]

        header: Row {
          spacing: myListView.itemRowSpacing

          // Empty list item to reserve the space in the row
          Item {
            width: myListView.widthDay
            height: 1
          }

          AppText {
            id: maxMinTempHeader
            text: "Max/Min"
            horizontalAlignment: Text.AlignHCenter
            width: myListView.widthTempMaxMin
            font.bold: true
            style: Text.Raised
          }

          AppText {
            text: "Rain"
            horizontalAlignment: Text.AlignHCenter
            width: myListView.widthRain
            font.bold: true
            style: Text.Raised
          }
        }

        delegate: Row {
          id: dailyWeatherDelegate
          spacing: myListView.itemRowSpacing

          AppText {
            text: {
              if (index === 0) {
                return "Today"
              } else if (index === 1) {
                return "Tomorrow"
              } else {
                return modelData.day
              }
            }
            style: Text.Raised
            width: myListView.widthDay
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
          }

          AppText {
            // \u00B0 -- is UTF-8 code for Degree Sign
            text: modelData.tempMax + "\u00B0/" + modelData.tempMin + "\u00B0"
            horizontalAlignment: Text.AlignHCenter
            width: myListView.widthTempMaxMin
            anchors.verticalCenter: parent.verticalCenter
          }

          Column {
            width: myListView.widthRain
            anchors.verticalCenter: parent.verticalCenter

            AppText {
              text: Math.round(modelData.rainAmount*10)/10 + "l" // round to 1 decimal
              fontSize: 18
              anchors.horizontalCenter: parent.horizontalCenter
            }

            AppText {
              id: precipProbability
              text: Math.round(modelData.rainProbability * 1000)/10 + "%" // round percent to 1 decimal
              fontSize: 11
              anchors.horizontalCenter: parent.horizontalCenter
            }
          }
        }
      }
    }
  }
}

import Felgo 3.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5

ListPage {
  id: root

  title: qsTr("Select activity")

  model: [
    {
      text: "Run",
      image: Qt.resolvedUrl("../../../assets/icons/sports/Run.png")
    },
    {
      text: "Ride",
      image: Qt.resolvedUrl("../../../assets/icons/sports/Ride.png")
    },
    {
      text: "Swim",
      image: Qt.resolvedUrl("../../../assets/icons/sports/Swim.png")
    },
    {
      text: "Canoe",
      image: Qt.resolvedUrl("../../../assets/icons/sports/Canoe.png")
    }
  ]

  delegate: SimpleRow {
    badgeColor: Theme.colors.tintColor
    badgeValue: Math.floor(statistics.activityDistanceMap[text])
    showDisclosure: false

    onSelected: {
      workoutModal.workout.setActivity(text)
      workoutModal.open()
    }
  }
}

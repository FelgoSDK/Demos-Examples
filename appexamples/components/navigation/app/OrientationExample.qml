import Felgo 3.0


App {
  id: app
  onPortraitChanged: {
    if (portrait) {
      console.log("Orientation changed to portrait")
    } else {
      console.log("Orientation changed to landscape")
    }
  }

  AppText {
    anchors.centerIn: parent
    text: app.landscape ? "Landscape Mode" : "Portrait Mode"
  }
}

import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "YouTubeWebPlayer"

      YouTubeWebPlayer {
        // -> https://www.youtube.com/watch?v=y0_RMWd3h9U
        videoId: "y0_RMWd3h9U"
        autoplay: true
      }
    }
  }
}

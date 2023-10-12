import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "YouTubeWebPlayer"

      YouTubeWebPlayer {
        // -> https://www.youtube.com/watch?v=y0_RMWd3h9U
        videoId: "y0_RMWd3h9U"
        autoplay: true
      }
    }
  }
}

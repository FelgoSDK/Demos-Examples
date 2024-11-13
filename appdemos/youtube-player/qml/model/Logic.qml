import QtQuick 2.0
import Felgo 4.0

Item {
  id: dataModel

  signal loadYouTubeData()

  signal loadMainPlaylistVideos()

  signal clearData()

  signal fetchPlaylistVideos(var playlist)

  signal setSpotlightPlaylist(var playlist)

  signal setUserName(string name)

}

import QtQuick
import Felgo

Item {
  id: dataModel

  signal loadYouTubeData()

  signal loadMainPlaylistVideos()

  signal clearData()

  signal fetchPlaylistVideos(var playlist)

  signal setSpotlightPlaylist(var playlist)

  signal setUserName(string name)

}

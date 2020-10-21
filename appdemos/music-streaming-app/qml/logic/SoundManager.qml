import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.12


Item {
  id: root

  property alias music: music

  readonly property bool isPlaying: music.playbackState === Audio.PlayingState
  property var currentTrack: storage.getValue("currentTrack")
  property int currentTrackIndex: -1
  property var tracks: storage.getValue("tracks")
  property int passedTime: 0

  Audio {
    id: music

    autoPlay: false

    source: !!root.currentTrack ? currentTrack.pathToTrack : ""

    onStatusChanged: {
      if (status == Audio.EndOfMedia) {
        console.log("Status changed to end of media")
        root.playNextTrack()
      }
    }
  }

  // Audio type can't detect passed playback and audio tracks duration if they are hosted online
  // This timer is used to mock passed playback
  Timer {
    id: timer

    repeat: true
    running: false
    interval: 1000

    onTriggered: {
      root.passedTime += 1000
    }

    function reset() {
      timer.stop()
      root.passedTime = 0
    }
  }

  function shufflePlay(entry) {
    timer.reset()
    // find related tracks and play first one
    root.tracks = dataModel.relatedTracks(entry)
    root.currentTrack = tracks.length > 0 ? tracks[0] : undefined
    root.currentTrackIndex = 0

    storage.setValue("currentTrack", root.currentTrack)
    storage.setValue("tracks", root.tracks)

    music.play()
    timer.start()
  }

  function playNextTrack() {
    timer.reset()
    if (root.currentTrackIndex < root.tracks.length - 1) {
      root.currentTrackIndex++
      root.playCurrentTrack()
    } else {
      if (root.tracks.length === 1) {
        music.source = ""
      }


      root.currentTrackIndex = 0
      root.playCurrentTrack()
    }
  }

  function playPreviousTrack() {
    if (root.currentTrackIndex > 0) {
      root.currentTrackIndex--
      root.playCurrentTrack()
    }
  }

  function playCurrentTrack() {
    root.currentTrack = root.tracks[root.currentTrackIndex]
    music.source = root.currentTrack.pathToTrack
    music.play()
    timer.reset()
    timer.start()
    storage.setValue("currentTrack", root.currentTrack)
  }

  function findCurrentIndex() {
    for (var i = 0; i < root.tracks.length; ++i) {
      if (root.tracks[i].name === root.currentTrack.name) {
        root.currentTrackIndex = i
        return
      }
    }
  }

  function hideCurrentTrack() {

    if (root.tracks.length === 1) {
      actuallyPlayingModal.close()
      timer.reset()
      music.stop()

      root.tracks = []
      root.currentTrack = undefined
      root.currentTrackIndex = -1

      storage.setValue("currentTrack", root.currentTrack)
      storage.setValue("tracks", root.tracks)
    } else {
      var cachedTrackIndex = root.currentTrackIndex
      root.playNextTrack()
      root.tracks.splice(cachedTrackIndex, 1)
      storage.setValue("tracks", root.tracks)
    }
  }

  function clear() {
    music.stop()

    root.tracks = []
    root.currentTrack = undefined
    root.currentTrackIndex = -1
  }

  function play() {
    timer.start()
    music.play()
  }

  function pause() {
    timer.stop()
    music.pause()
  }

  onCurrentTrackChanged: {
    var recentlyPlayed = storage.getValue("recentlyPlayed")
    if (recentlyPlayed === undefined) {
      recentlyPlayed = []
    }

    if (root.currentTrack !== undefined) {

      var alreadyThere = false
      for (const track of recentlyPlayed) {
        if (track.name === root.currentTrack.name) {
          alreadyThere = true
        }
      }

      if (!alreadyThere) {
        recentlyPlayed.push(root.currentTrack)
      }
    }

    storage.setValue("recentlyPlayed", recentlyPlayed)
  }

  Component.onCompleted: {
    findCurrentIndex()
  }
}

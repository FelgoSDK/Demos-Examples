import QtQuick

QtObject {
  readonly property string idUrl: "com.felgo"

  readonly property string url: "https://felgo.com"
  readonly property string offerUrl: "https://felgo.com/meetings/intro-call"
  readonly property string qtDevelopersUrl: "https://felgo.com/qt-app-developers"

  readonly property QtObject productId: QtObject{
    readonly property string android: idUrl + '.' + eventDetails.id
    readonly property string ios: "id6472174826"
  }

  readonly property QtObject ratingUrls: QtObject{
    readonly property string android: "http://play.google.com/store/apps/details?id=" + productId.android
    readonly property string ios: "itms-apps://itunes.apple.com/at/app/" + productId.ios + "?mt=8"
  }
}

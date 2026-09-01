import QtQuick
import Felgo

QtObject {
    // confirmOpenUrl - display confirm dialog before opening a url
    function confirmOpenUrl(url) {
      NativeDialog.confirm("Leave the app?","This action opens your browser to visit " + url +".", function(ok) {
        if(ok)
          nativeUtils.openUrl(url)
      })
    }
}

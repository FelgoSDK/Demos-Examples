import Felgo 4.0
import QtQuick 2.0

NativeView {
  id: dynamicNativeWebView

  property url url
  signal clicked

  onUrlChanged: if(binding) binding.updateUrl()

  androidBinding: NativeViewBinding {
    readonly property int _View_LAYER_TYPE_HARDWARE: 2
    readonly property NativeClass _WebView: NativeObjectUtils.getClass("android/webkit/WebView")
    readonly property NativeClass _Color: NativeObjectUtils.getClass("android/graphics/Color")
    readonly property NativeClass _WebViewClient: NativeObjectUtils.getClass("android/webkit/WebViewClient")
    readonly property NativeClass _WebChromeClient: NativeObjectUtils.getClass("android/webkit/WebChromeClient")

    viewClassName: "android.webkit.WebView"

    onCreateView: {
      var view = _WebView.newInstance([NativeObjectUtils.getContext()], "", NativeObject.UiThread)

      return view
    }

    onViewCreated: {
      view.callMethod("setLayerType", [_View_LAYER_TYPE_HARDWARE, null], NativeObject.UiThread)
      view.callMethod("setBackgroundColor", _Color.getStaticProperty("TRANSPARENT"), NativeObject.UiThread)

      // TODO create mechanism to be able to override methods in these instances:
      var client = _WebViewClient.newInstance()
      view.callMethod("setWebViewClient", client, NativeObject.UiThread)

      var chromeClient = _WebChromeClient.newInstance()
      view.callMethod("setWebChromeClient", chromeClient, NativeObject.UiThread)

      view.callMethod("getSettings", [], NativeObject.UiThread, function(settings) {
        settings.callMethod("setJavaScriptEnabled", true)
        settings.callMethod("setUseWideViewPort", true)
        settings.callMethod("setSupportZoom", true)
        settings.callMethod("setBuiltInZoomControls", false)
      })

      updateUrl()
    }

    function updateUrl() {
      view.callMethod("loadUrl", dynamicNativeWebView.url.toString(), NativeObject.UiThread)
    }
  }

  iosBinding: NativeViewBinding {
    // imports
    readonly property NativeClass _WKWebView: NativeObjectUtils.getClass("WKWebView")
    readonly property NativeClass _WKWebViewConfiguration: NativeObjectUtils.getClass("WKWebViewConfiguration")
    readonly property NativeClass _NSURL: NativeObjectUtils.getClass("NSURL")
    readonly property NativeClass _NSURLRequest: NativeObjectUtils.getClass("NSURLRequest")
    readonly property NativeClass _UIColor: NativeObjectUtils.getClass("UIColor")

    // WKWebViewConfiguration must be passed on constructor
    // -> use custom initialization block:
    onCreateView: {
      var config = _WKWebViewConfiguration.newInstance()

      config.setProperty("allowsInlineMediaPlayback", true)

      return _WKWebView.newInstance([null, config], "initWithFrame:configuration:")
    }

    onViewCreated: {
      view.setProperty("backgroundColor", _UIColor.getProperty("grayColor"))

      // set object with JS functions as delegate:
      view.setProperty("navigationDelegate", {
        "webView:didCommitNavigation:": function(webView, navigation) {
          console.log("web view did commit navigation")
        },
        "webView:didFinishNavigation:": function(webView, navigation) {
          console.log("web view did finish navigation")
        }
      })

      // While scrolling, the whole Qt application is stopped
      // as the UI thread is moved to a different "run loop mode"
      // this would stop the native view from updating
      // -> show the actual native view while scrolling

      var layer = view.getProperty("layer")
      var scrollView = view.getProperty("scrollView")
      scrollView.setProperty("delegate", {
        "scrollViewWillBeginDragging:": function(scrollView) {
          layer.setProperty("zPosition", 1)
        },
        // manual method signature required because of non-object parameter bool decelerate
        // more information about method signatures: https://developer.apple.com/documentation/foundation/nsmethodsignature?language=objc
        "v@:@B scrollViewDidEndDragging:willDecelerate:": function(scrollView, decelerate) {
          if(!decelerate) {
            layer.setProperty("zPosition", 0)
          }
        },
        "scrollViewDidEndDecelerating:": function(scrollView) {
          layer.setProperty("zPosition", 0)
        }
      })

      updateUrl()
    }

    function updateUrl() {
      // must convert to NSURL from string, TODO maybe automatically convert QML url <-> NSURL
      var url = _NSURL.callMethod("URLWithString:", dynamicNativeWebView.url.toString())
      var request = _NSURLRequest.callMethod("requestWithURL:", url)

      console.log("URL request:", url, request)

      view.callMethod("loadRequest:", request)
    }
  }
}

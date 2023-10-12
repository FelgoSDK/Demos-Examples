import Felgo 3.0
import QtQuick 2.0

NativeView {
  id: dynamicNativeMapView

  property real latitude
  property real longitude

  // the Google Maps API key for iOS. the one for Android is configured in AndroidManifest.xml
  property string iosApiKey

  function updateMapLocation() {
    if(binding) {
      binding.updateMapLocation()
    }
  }

  androidBinding: NativeViewBinding {
    readonly property NativeClass _LatLng: NativeObjectUtils.getClass("com/google/android/gms/maps/model/LatLng")
    readonly property NativeClass _CameraUpdateFactory: NativeObjectUtils.getClass("com/google/android/gms/maps/CameraUpdateFactory")

    readonly property NativeObject application: NativeObjectUtils.getActivity().callMethod("getApplication")

    property NativeObject mapObj: null // GoogleMap object

    viewClassName: "com.google.android.gms.maps.MapView"

    onViewCreated: {
      // activity is currently resumed, so call the initial lifecycle methods:
      view.callMethod("onCreate", [null], NativeObject.UiThread)
      view.callMethod("onStart", [], NativeObject.UiThread)
      view.callMethod("onResume", [], NativeObject.UiThread)

      // get map using async callback interface:
      view.callMethod("getMapAsync", {
                        onMapReady: function mapReady(map) {
                          mapObj = map
                          updateMapLocation()

                          mapObj.callMethod("setBuildingsEnabled", false, NativeObject.UiThread)

                          var uiSettings = map.callMethod("getUiSettings", [], NativeObject.UiThread)
                          uiSettings.callMethod("setZoomControlsEnabled", true, NativeObject.UiThread)
                        }
                      }, NativeObject.UiThread)

      // forward pause/resume lifecycle methods
      application.callMethod("registerActivityLifecycleCallbacks", {
                               onActivityPaused: function() {
                                 view.callMethod("onPause", [], NativeObject.UiThread)
                               },
                               onActivityResumed: function() {
                                 view.callMethod("onResume", [], NativeObject.UiThread)
                               },
                             })

      updateMapLocation()
    }

    function updateMapLocation() {
      if(mapObj) {
        // java code: map.animateCamera(CameraUpdateFactory.newLatLngZoom(latitude, longitude))
        var latLng = _LatLng.newInstance([latitude, longitude])
        var update = _CameraUpdateFactory.callStaticMethod("newLatLngZoom", [latLng, 20])
        mapObj.callMethod("animateCamera", update, NativeObject.UiThread)
      } else {
        console.debug("updateMapLocation() called, but map is not yet ready.")
      }
    }
  }

  iosBinding: NativeViewBinding {
    readonly property NativeClass _GMSCameraPosition: NativeObjectUtils.getClass("GMSCameraPosition")
    readonly property NativeClass _GMSServices: NativeObjectUtils.getClass("GMSServices")

    viewClassName: "GMSMapView"

    Component.onCompleted: {
      // must be called before creating view, so do not call in onViewCreated:
      _GMSServices.callMethod("provideAPIKey:", dynamicNativeMapView.iosApiKey)
    }

    onViewCreated: {
      view.setProperty("buildingsEnabled", false)

      updateMapLocation()
    }

    function updateMapLocation() {
      if(view) {
        var position = _GMSCameraPosition.callStaticMethod("cameraWithLatitude:longitude:zoom:",
                                                           [dynamicNativeMapView.latitude, dynamicNativeMapView.longitude, 25])
        view.callMethod("animateToCameraPosition:", position)
      }
    }
  }
}

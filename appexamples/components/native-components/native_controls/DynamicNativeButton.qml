import Felgo 4.0
import QtQuick 2.0

NativeView {
  id: dynamicNativeButton

  property string text
  signal clicked

  onTextChanged: if(binding) binding.updateText()

  androidBinding: NativeViewBinding {
    readonly property NativeClass _ContextThemeWrapper: NativeObjectUtils.getClass("android/view/ContextThemeWrapper")
    readonly property NativeClass _Button: NativeObjectUtils.getClass("android/widget/Button")
    readonly property NativeClass _R_drawable: NativeObjectUtils.getClass("android/R$drawable")
    readonly property NativeClass _R_style: NativeObjectUtils.getClass("android/R$style")

    onCreateView: {
      // use custom button constructor to override theme:

      // use holo theme because material's ripple effect doesn't work on a different thread
      var style = _R_style.getStaticProperty("Widget_Holo_Light_Button")

      var wrapper = _ContextThemeWrapper.newInstance([NativeObjectUtils.getContext(), style])
      return _Button.newInstance([wrapper, null, style])
    }

    onViewCreated: {
      updateText()

      // add OnClickListener:
      view.callMethod("setOnClickListener", function(v) {
        // call QML signal:
        dynamicNativeButton.clicked()
      })
    }

    function updateText() {
      view.callMethod("setText", dynamicNativeButton.text, NativeObject.UiThread)
    }
  }

  iosBinding: NativeViewBinding {
    // TODO define in C++ somewhere
    readonly property int _UIControlStateNormal: 0
    readonly property int _UIControlStateHighlighted: 1
    readonly property int _UIControlEventTouchUpInside: 1 << 6
    readonly property NativeObject _UIColor: NativeObjectUtils.getClass("UIColor")

    viewClassName: "UIButton"

    onViewCreated: {
      updateText()

      // configure button visuals:
      view.setProperty("backgroundColor", _UIColor.getProperty("grayColor"))
      view.callMethod("setTitleColor:forState:", [_UIColor.getProperty("blackColor"), _UIControlStateNormal])
      view.callMethod("setTitleColor:forState:", [_UIColor.getProperty("whiteColor"), _UIControlStateHighlighted])

      view.callMethod("addTarget:action:forControlEvents:", [{
        // note: selector name contains colon ':', so this key must also contain it
        "onClick:forEvent:": function(view, event) {
          dynamicNativeButton.clicked()
        }
      }, "onClick:forEvent:", _UIControlEventTouchUpInside])
      // target selectors can either be "doSomething", "doSomething:(id)sender" or "doSomething:(id)sender forEvent:(UIEvent*)event"
      // selector name must be exactly the same as the function's key in the JS object
    }

    function updateText() {
      view.callMethod("setTitle:forState:", [dynamicNativeButton.text, _UIControlStateNormal])
    }
  }
}

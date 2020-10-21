import QtQuick 2.0
import Felgo 3.0

Column {
  id: root
  anchors { left: parent.left; right: parent.right }

  property real secondaryTextSize: sp(12)
  property bool isInputCorrect: textInput.acceptableInput && !hasError && textInput.text.length > 0
  property bool hasError: false
  property string errorMessage: qsTr("Error")

  property alias label: label.text
  property alias textField: textInput
  property alias placeholderText: textInput.placeholderText
  property alias validator: textInput.validator

  QtObject {
    id: internal
    // we only display the error message when textfield is not in focus
    property bool displayError: root.hasError && !textInput.activeFocus
    readonly property color errorColor: "red"
    readonly property real borderWidth: dp(1)
  }

  AppText {
    id: label
  }

  AppTextField {
    id: textInput
    anchors { left: parent.left; right: parent.right }
    borderWidth: internal.borderWidth

    // here we change borderColor depending on the current textinput state
    states: [
      State {
        when: internal.displayError
        PropertyChanges {
          target: textInput
          borderColor: internal.errorColor
        }
      },
      State {
        when: textInput.activeFocus
        PropertyChanges {
          target: textInput
          borderColor: Theme.colors.tintColor
        }
      },
      State {
        PropertyChanges {
          target: textInput
          borderColor: Theme.colors.dividerColor
        }
      }
    ]

    // display a nice color transition when changing borderColor
    Behavior on borderColor { ColorAnimation { } }
  }

  AppText {
    id: textError
    text: root.errorMessage
    color: internal.errorColor
    font.pixelSize: secondaryTextSize
    opacity: internal.displayError ? 1.0 : 0.0

    // we display a short fade animation when the error message changes state
    Behavior on opacity { NumberAnimation { } }
  }
}

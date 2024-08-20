import Felgo 4.0
import QtQuick 2.5
import QtQuick.Controls 2.0

ComboBox {
  id: comboBox
  implicitWidth: dp(90) + 20
  implicitHeight: dp(24) + topPadding + bottomPadding
  padding: dp(12)

  // overwrite style for density independent sizes
  delegate: ItemDelegate {
    width: comboBox.implicitWidth
    height: comboBox.implicitHeight
    padding: dp(12)
    contentItem: AppText {
      text: modelData
      color: highlighted ? Theme.tintColor : Theme.textColor
      wrapMode: Text.NoWrap
    }
    background: Rectangle {
      color: Theme.backgroundColor
    }

    highlighted: comboBox.highlightedIndex == index
  }

  popup: Popup {
    width: comboBox.width
    y: comboBox.height - 1

    implicitHeight: contentItem.implicitHeight
    padding: 1

    contentItem: ListView {
      clip: true
      implicitHeight: contentHeight
      model: comboBox.popup.visible ? comboBox.delegateModel : null
      currentIndex: comboBox.highlightedIndex
    }

    background: Rectangle {
      color: Theme.backgroundColor
      border.color: Theme.textColor
      border.width: dp(1)
      radius: 2
    }
  }

  contentItem: AppText {
    width: comboBox.width - (comboBox.indicator ? comboBox.indicator.width : 0) - comboBox.spacing
    text: comboBox.displayText
    wrapMode: Text.NoWrap
  }
}

import Felgo
import QtQml.Models
import QtQuick


App {
  NavigationStack {

    AppPage {
      id: page
      readonly property int animTime: 200 // ms
      title: "Draggable ListModel items"

      Component {
        id: dragDelegate

        MouseArea {
          id: dragArea

          property bool held: false

          anchors {
            left: parent.left
            right: parent.right
          }
          height: content.height

          drag.target: held ? content : undefined
          drag.axis: Drag.YAxis

          onPressAndHold: held = true
          onReleased: held = false

          Rectangle {
            id: content
            anchors {
              horizontalCenter: parent.horizontalCenter
              verticalCenter: parent.verticalCenter
            }
            width: dragArea.width
            height: label.height + dp(10)
            radius: dp(6)
            border.width: dp(2)
            border.color: "lightsteelblue"
            color: dragArea.held ? "lightsteelblue" : "white"

            Behavior on color {
              ColorAnimation {
                duration: page.animTime
              }
            }

            Drag.active: dragArea.held
            Drag.source: dragArea
            Drag.hotSpot.x: width / 2
            Drag.hotSpot.y: height / 2

            AppText {
              id: label
              anchors.centerIn: parent
              height: dp(60)

              states: State {
                when: dragArea.held

                ParentChange {
                  target: content
                  parent: page
                }

                AnchorChanges {
                  target: content
                  anchors {
                    horizontalCenter: undefined
                    verticalCenter: undefined
                  }
                }
              }
              text: "<b>" + name + ":</b> $" + cost
            }
          }

          DropArea {
            anchors {
              fill: parent
              margins: dp(10)
            }

            onEntered: {
              visualModel.items.move(
                    drag.source.DelegateModel.itemsIndex,
                    dragArea.DelegateModel.itemsIndex)
            }
          }
        }
      }

      DelegateModel {
        id: visualModel

        model: ListModel {
          id: fruitModel

          ListElement {
            name: "Apple"
            cost: 2.45
          }
          ListElement {
            name: "Orange"
            cost: 3.25
          }
          ListElement {
            name: "Banana"
            cost: 1.95
          }
        }
        delegate: dragDelegate
      }

      AppListView {
        id: view
        model: visualModel

        addDisplaced: Transition {
          NumberAnimation { properties: "x, y"; duration: page.animTime }
        }
        moveDisplaced: Transition {
          NumberAnimation { properties: "x, y"; duration: page.animTime }
        }
        remove: Transition {
          NumberAnimation { properties: "x, y"; duration: page.animTime }
          NumberAnimation { properties: "opacity"; duration: page.animTime }
        }
        removeDisplaced: Transition {
          NumberAnimation { properties: "x, y"; duration: page.animTime }
        }
        displaced: Transition {
          NumberAnimation { properties: "x, y"; duration: page.animTime }
        }

        anchors {
          fill: parent
          margins: dp(6)
        }
        spacing: dp(10)
      }
    }
  }
}

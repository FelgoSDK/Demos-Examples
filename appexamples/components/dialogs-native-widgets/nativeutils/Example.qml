import Felgo 3.0
import QtQuick 2.0

App {
  NavigationStack {
    FlickablePage {
      id: mainPage
      title: "Native Utils"

      flickable.contentHeight: column.height

      Column {
        id: column
        anchors { left: parent.left; right: parent.right }

        SimpleRow {
          text: "Alert Dialog"
          onSelected: nativeUtils.displayAlertDialog("Hello!", "I'm an alert dialog", "Ok", "Cancel")
        }

        SimpleRow {
          text: "Alert Sheet"
          onSelected: nativeUtils.displayAlertSheet("Choose wisely!", ["Option A", "Option B", "Option C"], false)

          Connections {
            target: nativeUtils

            onAlertSheetFinished: function (index) {
              nativeUtils.displayAlertDialog("Congratulations", "You chose option " + index)
            }
          }
        }

        SimpleRow {
          text: "Camera Picker"
          onSelected: nativeUtils.displayCameraPicker("Take a selfie!")

          Connections {
            target: nativeUtils

            // Let's have a look at this selfie
            onCameraPickerFinished: {
              if (accepted) {
                imageDialog.displayImageDialog(path)
              }
            }
          }
        }

        SimpleRow {
          text: "Pick image"
          onSelected: nativeUtils.displayImagePicker("Show me your best shot!")

          Connections {
            target: nativeUtils

            // Let's handle the new picture
            onImagePickerFinished: function (accepted, path) {
              if (accepted) {
                imageDialog.displayImageDialog(path)
              }
            }
          }
        }

        SimpleRow {
          text: "Message Box"
          onSelected: nativeUtils.displayMessageBox("Hi I'm a MessageBox!", "", 2)
        }

        SimpleRow {
          text: "Date Picker"
          onSelected: nativeUtils.displayDatePicker("Pick your favorite date!")

          Connections {
            target: nativeUtils

            // Here we get notified of the date picked signal
            onDatePickerFinished: function (accepted, date) {
              if (accepted) {
                nativeUtils.displayAlertDialog("Date Picked", date)
              }
            }
          }
        }

        SimpleRow {
          text: "Share"
          onSelected: nativeUtils.share("Check this out!", "https://felgo.com")
        }

        SimpleRow {
          text: "Open Url"
          onSelected: nativeUtils.openUrl("https://felgo.com")
        }

        SimpleRow {
          text: "Send Email"
          onSelected: nativeUtils.send("Check this out!", "https://felgo.com")
        }

        SimpleRow {
          text: "Show Contacts"
          onSelected: mainPage.navigationStack.push(contactsPageComponent)
        }

        SimpleRow {
          text: "Show Gallery"
          onSelected: mainPage.navigationStack.push(galleryPageComponent)
        }
      }
    }
  }

  Component {
    id: contactsPageComponent
    Page {
      title: "Contacts"

      AppListView {
        anchors.fill: parent
        model: nativeUtils.contacts

        delegate: SimpleRow {
          text: modelData.name
          detailText: modelData.phoneNumbers.join(", ") // Join all numbers into a string separated by a comma
        }
      }
    }
  }

  Component {
    id: galleryPageComponent
    Page {

      // Fetch photos from gallery
      Component.onCompleted: nativeUtils.fetchGalleryPhotos()

      AppListView {
        anchors.fill: parent

        // Show fetched photos in list
        model: nativeUtils.galleryPhotos

        delegate: AppImage {
          width: parent.width
          height: width
          fillMode: Image.PreserveAspectCrop
          source: modelData.assetPath
        }
      }
    }
  }

  // A simple dialog for displaying images coming from pickers
  Dialog {
    id: imageDialog
    title: "This looks great"
    onAccepted: close()
    onCanceled: close()


    AppImage {
      id: imageDialogPicture
      anchors { fill: parent; margins: dp(Theme.contentPadding) }
      fillMode: Image.PreserveAspectFit
    }

    function displayImageDialog(path) {
      imageDialogPicture.source = path
      imageDialog.open()
    }
  }
}

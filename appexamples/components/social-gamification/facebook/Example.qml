import QtQuick
import Felgo


App {
  licenseKey: ""
  property string facebookAppId: "2004354536245706"

  NavigationStack {
    AppPage {
      title: "Facebook"

      // User image and name
      Row {
        id: userProfile
        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
          margins: dp(20)
        }
        spacing: dp(20)

        RoundedImage {
          width: dp(100)
          height: dp(100)
          source: facebook.profile.pictureUrl
          visible: facebook.loggedIn
        }

        AppText {
          text: facebook.loggedIn ? "Logged in as: \n" + facebook.profile.firstName : "Please log in"
        }
      }

      // Login/logout button
      AppButton {
        id: loginButton
        text: facebook.loggedIn ? "Logout" : "Login"
        flat: false
        anchors.top: userProfile.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
          if (facebook.loggedIn) {
            facebook.closeSession()
          } else {
            facebook.openSession()
          }
        }
      }

      // Only if logged in: allow post to wall and show friends
      Column {
        id: facebookActions
        visible: facebook.loggedIn
        anchors.top: loginButton.bottom
        width: parent.width

        // post a message to facebook
        AppText {
          id: postHeader
          text: "Post a Message: "
          font.bold: true
          x: userProfile.anchors.margins
          height: implicitHeight + userProfile.spacing
        }

        // rectangle with text area
        Rectangle {
          width: parent.width - 2 * userProfile.spacing
          height: messageField.height + dp(8)
          color: "white"
          border {
            color: Theme.tintColor
            width: 1
          }
          anchors.horizontalCenter: parent.horizontalCenter

          AppTextEdit {
            id: messageField
            placeholderText: "What are you up to?"
            text: "I just posted this message with the Felgo Facebook Plugin. \n https://www.felgo.com/plugins"
            width: parent.width - dp(16)
            height: messageField.lineCount * messageField.lineHeight
            wrapMode: TextEdit.WordWrap
            font.pixelSize: sp(13)
            horizontalAlignment: TextEdit.AlignLeft
            verticalAlignment: TextEdit.AlignTop
            anchors.centerIn: parent

            property real lineHeight: 0
            Component.onCompleted: lineHeight = messageField.contentHeight / messageField.lineCount
          }
        }

        // Post message button
        AppButton {
          text: "Post the message above to Facebook"
          onClicked: facebook.postGraphRequest( "me/feed", { message: messageField.text } )
          anchors.horizontalCenter: parent.horizontalCenter
        }

        // show facebook friends
        AppText {
          id: friendsHeader
          width: parent.width - 2 * x
          text: "Friends (who also used Facebook login with this app): "
          font.bold: true
          wrapMode: AppText.WordWrap
          height: implicitHeight + userProfile.anchors.margins
          x: userProfile.anchors.margins
        }

        // list view with friends
        Repeater {
          id: friendsList
          width: parent.width
          model: []
          delegate: SimpleRow {
            text: modelData.name
            imageSource: modelData.picture.data.url
            style.showDisclosure: false
          }
        }
      }
    }

    Facebook {
      id: facebook

      readonly property bool loggedIn: sessionState === Facebook.SessionOpened

      appId: facebookAppId
      readPermissions: [ "public_profile", "email", "user_friends" ]
      publishPermissions: ["publish_actions"]

      // Fetch data after log in
      onSessionStateChanged: {
        if (sessionState === Facebook.SessionOpened) {
          fetchUserDetails() // Get user details
          facebook.getGraphRequest( "me/friends", { fields: "id,name,picture" } ) // Get friends that use the app
        }
      }

      // Handle completed get-friends graph request
      onGetGraphRequestFinished: {
        if (resultState !== Facebook.ResultOk) {
          NativeDialog.confirm("Retrieving Friends Failed", "", function(){ }, false)
        }

        // Show friends
        if (graphPath === "me/friends") {
          friendsList.model = JSON.parse(result).data
        }
      }

      // Handle completed post-message graph request
      onPostGraphRequestFinished: {
        if (resultState !== Facebook.ResultOk) {
          NativeDialog.confirm("Post Request Failed", "", function(){ }, false)
        } else {
          NativeDialog.confirm("Message Posted Successfully", "", function(){ }, false)
        }
      }
    }
  }
}

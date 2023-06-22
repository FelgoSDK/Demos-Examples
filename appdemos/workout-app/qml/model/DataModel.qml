import Felgo 4.0
import QtQuick 2.0


JsonListModel {
  id: root

  signal userDataChanged()

  readonly property var users: {
    "Alex": Qt.resolvedUrl("../../assets/user1.jpg"),
    "Lukas": Qt.resolvedUrl("../../assets/user3.jpg")
  }

  property var dataSource: [
    {
      "type": "Workout",
      "workout": {
        "activity": "Ride",
        "timePassed": 225900,
        "distance": 1728,
        "path": [
          {
            "latitude": 48.34209055369235,
            "longitude": 13.116597625935173
          },
          {
            "latitude": 48.25438629002869,
            "longitude": 11.270894500935173
          },
          {
            "latitude": 47.754547459688794,
            "longitude": 10.084371063435173
          },
          {
            "latitude": 47.160294601890826,
            "longitude": 9.117574188435173
          },
          {
            "latitude": 46.740318769643984,
            "longitude": 7.4915976259351735
          },
          {
            "latitude": 46.37771544714972,
            "longitude": 4.9427695009351735
          },
          {
            "latitude": 46.22591540494151,
            "longitude": 2.3060507509351735
          },
          {
            "latitude": 45.95161451519369,
            "longitude": 0.6800741884351735
          },
          {
            "latitude": 45.552993411728956,
            "longitude": -0.06699612406482647
          },
          {
            "latitude": 44.934169677586596,
            "longitude": -1.2095742490648265
          }
        ]
      },
      "author": "Alex",
      "content": "Who's the boss? :-]",
      "activity": "Ride",
      "comments": [
        {
          "author": "Lukas",
          "message": "Is this your record?"
        },
        {
          "author": "Alex",
          "message": "It's just a warm-up!"
        }
      ]
    },
    {
      "type": "Post",
      "author": "currentUser",
      "content": "Definitely the best possible weather for canone!",
      "image": "../../assets/lake.jpg",
      "activity": "Canoe",
      "comments": [
        {
          "author": "Alex",
          "message": "Have fun :)"
        }
      ],
    },
    {
      "type": "Workout",
      "workout": {
        "activity": "Run",
        "timePassed": 1590,
        "distance": 4.57,
        "path": [
          {
            "latitude": 40.76420,
            "longitude": -73.97304
          },
          {
            "latitude": 40.76791,
            "longitude": -73.97034
          },
          {
            "latitude": 40.76882,
            "longitude": -73.97236
          },
          {
            "latitude": 40.76937,
            "longitude": -73.97403
          },
          {
            "latitude": 40.77145,
            "longitude": -73.97742
          },
          {
            "latitude": 40.77470,
            "longitude": -73.97528
          },
          {
            "latitude": 40.77483,
            "longitude": -73.97429
          },
          {
            "latitude": 40.77555,
            "longitude": -73.97403
          },
          {
            "latitude": 40.77708,
            "longitude": -73.97407
          },
          {
            "latitude": 40.77789,
            "longitude": -73.97369
          },
          {
            "latitude": 40.77880,
            "longitude": -73.97214
          },
          {
            "latitude": 40.77961,
            "longitude": -73.97030
          },
          {
            "latitude": 40.77808,
            "longitude": -73.96652
          },
          {
            "latitude": 40.77688,
            "longitude": -73.96373
          },
          {
            "latitude": 40.76430,
            "longitude": -73.97296
          }
        ]
      },
      "author": "currentUser",
      "content": "Evening run in Central Park NY",
      "activity": "Run",
      "comments": []
    },
    {
      "type": "Post",
      "author": "Alex",
      "content": "Austria to France",
      "activity": "Ride",
      "image": "../../assets/bike-trip.jpg",
      "comments": []
    },
    {
      "type": "Workout",
      "workout": {
        "activity": "Swim",
        "timePassed": 30600,
        "distance": 40,
        "path": [
          {
            "latitude": 51.12202,
            "longitude": 1.33519
          },
          {
            "latitude": 51.07200,
            "longitude": 1.42171
          },
          {
            "latitude": 51.00810,
            "longitude": 1.63319
          },
          {
            "latitude": 50.96920,
            "longitude": 1.83232
          }
        ]
      },
      "author": "currentUser",
      "content": "English channel for first time in my life!",
      "activity": "Swim",
      "comments": [
        {
          "author": "Lukas",
          "message": "Was the water cold :)?"
        }
      ]
    },
    {
      "type": "Post",
      "author": "Lukas",
      "content": "Thirty years old man from good house would like to meet people passionated in running.",
      "comments": [
        {
          "author": "currentUser",
          "message": "Don't count on me ;)"
        }
      ],
      "image": ""
    },
    {
      "type": "Workout",
      "workout": {
        "activity": "Canoe",
        "timePassed": 12400,
        "distance": 28,
        "path": [
          {
            "latitude": 48.33420,
            "longitude": 16.09362
          },
          {
            "latitude": 48.33876,
            "longitude": 16.16435
          },
          {
            "latitude": 48.34834,
            "longitude": 16.21035
          },
          {
            "latitude": 48.35382,
            "longitude": 16.24743
          },
          {
            "latitude": 48.35017,
            "longitude": 16.28451
          },
          {
            "latitude": 48.33283,
            "longitude": 16.3277
          },
          {
            "latitude": 48.30132,
            "longitude": 16.34493
          },
          {
            "latitude": 48.28761,
            "longitude": 16.34905
          },
          {
            "latitude": 48.23642,
            "longitude": 16.39300
          }
        ]
      },
      "author": "currentUser",
      "content": "The Blue Danube <3",
      "activity": "Canoe",
      "comments": []
    }
  ]

  fields: [
    "activity",
    "author",
    "comments",
    "content",
    "image",
    "liked",
    "type",
    "workout"
  ]

  function imageForUser(user) {
    if (user === "currentUser") {
      var userAvatar = storage.getValue("userAvatar")
      if (userAvatar === undefined) {
        userAvatar = Qt.resolvedUrl("../../assets/user2.jpg")
        storage.setValue("userAvatar", userAvatar)
      }

      return userAvatar
    }

    if (user in root.users) {
      return root.users[user]
    }

    return ""
  }

  function nickForUser(user) {
    if (user === "currentUser") {
      var userName = storage.getValue("userName")
      if (userName === undefined) {
        userName = "Guenther"
        storage.setValue("userName", userName)
      }

      return userName
    }

    return user
  }

  function likeFeed(index) {
    var isLiked = root.get(index).liked

    root.setProperty(index, "liked", !isLiked)
    root.updateStorage()
  }

  function addPost(content, image) {
    var postObj = {}
    postObj.type = "Post"
    postObj.author = "currentUser"
    postObj.content = content
    postObj.image = image
    postObj.comments = []

    root.insert(0, postObj)
    root.updateStorage()
  }

  function addWorkout(workout) {

    var workoutObj = {};
    workoutObj.type = "Workout"
    workoutObj.author = "currentUser"
    workoutObj.content = workout.title
    workoutObj.activity = workout.activity
    workoutObj.workout = workout
    workoutObj.comments = []

    root.insert(0, workoutObj)
    root.updateStorage()
  }

  function addComment(index, message) {
    var comments = root.get(index).comments

    var newComment = {
      "author": "currentUser",
      "message": message
    }

    comments.push(newComment)
    root.setProperty(index, "comments", comments)

    updateStorage()
  }

  function updateStorage() {
    var data = []

    for (var i = 0; i < root.count; ++i) {
      data.push(root.get(i))
    }

    storage.setValue("feed", data)
  }

  function updateUserAvatar(path) {
    storage.setValue("userAvatar", path)
    root.userDataChanged()
  }

  function updateUserName(name) {
    storage.setValue("userName", name)
    root.userDataChanged()
  }

  function purge() {
    storage.clearAll()

    dataModel.userDataChanged()
    root.remove(0, root.count)
    root.source = root.dataSource
  }

  Component.onCompleted: {
    var feed = storage.getValue("feed")
    if (feed === undefined) {
      feed = root.dataSource
    }

    root.source = feed
  }
}

import Felgo 4.0
import QtQuick 2.0
import "../components"

AppPage {
  id: page
  title: "New worklog"

  property var issue // is set if existing worklog, ie when editing a worklog
  property var worklog // is set if existing worklog, ie when editing a worklog
  property date startDate: worklog ? new Date(worklog.started) : new Date()

  rightBarItem: TextButtonBarItem {
    text: "Save"
    onClicked: {
      save()
    }
  }

  leftBarItem: TextButtonBarItem {
    text: "Cancel"
    onClicked: {
      page.navigationStack.pop()
    }
  }

  Column {
    id: contentCol
    width: parent.width

    IssueHeader {
      issue: page.issue
    }

    TextFieldRow {
      label: "Date Started"
      value: dataModel.formatDateTime(startDate)
      clickEnabled: true
      onClicked: {
        startTimePickerDialog.open()
        //nativeUtils.displayDatePicker() // alternative, with native UI
      }
    }

    TextFieldRow {
      id: timeSpent
      label: "Time Spent"
      value: worklog ? worklog.timeSpent : "0m"

      //clickEnabled: true // by default it is false
      clickEnabled: !Theme.isDesktop // false on desktop, true otherwise
      onClicked: {
        timeSpentPickerDialog.open()
      }
    }

    TextFieldRow {
      id: comment
      label: "Comment"
      placeHolder: "Add a comment..."
      value: worklog ? worklog.comment : ""
    }
  }

  FloatingActionButton {
    id: saveButton
    iconType: IconType.save
    //visible: true // only show on Android by default
    onClicked: {
      save()
    }

    PropertyAnimation {
      target: saveButton
      property: "anchors.bottomMargin"
      duration: 500
      easing.type: Easing.InQuart
      from: -8*saveButton.anchors.bottomMargin
      to: saveButton.anchors.bottomMargin
      running: true
    }
  }

  DateTimePickerDialog {
    id: startTimePickerDialog
    datePicker.datePickerMode: datePicker.dateTimeMode
    datePicker.minuteInterval: 5
    onAccepted: {
      startDate = datePicker.selectedDate
    }
  }

  DateTimePickerDialog {
    id: timeSpentPickerDialog
    datePicker.datePickerMode: datePicker.countDownMode
    datePicker.minuteInterval: 5
    datePicker.countDownDuration: dataModel.getTimeSpentInSecondsFromString(timeSpent.value)/60
    onAccepted: {
      timeSpent.value = dataModel.formatDuration(datePicker.countDownDuration*60)
    }
  }

  function save() {
    if(worklog) {
      dataModel.updateWorklog(issue, worklog, startDate, timeSpent.value, comment.value)
    } else {
      dataModel.addWorklog(issue, startDate, timeSpent.value, comment.value)
    }
    page.navigationStack.popAllExceptFirst()
    navigation.currentIndex = 0 // after adding a new worklog, change to the worklog view
  }

}

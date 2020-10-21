import Felgo 3.0
import QtQuick 2.0
import "../components"

ListPage {
  id: page
  title: "Jira Worklogs"

  model: dataModel.worklogModel

  delegate: SwipeOptionsContainer {

    SimpleRow {
      imageSource: Qt.resolvedUrl(model.imageSrc)
      imageMaxSize: dp(40)
      //detailTextItem.maximumLineCount: 2
      text: model.title
      detailText: model.description
      badgeValue: model.timeSpent
      onSelected: {
        page.navigationStack.popAllExceptFirstAndPush(worklogDetailPageComponent, {title: "Edit Worklog", issue: dataModel.getIssueForId(model.issueId), worklog: model})
      }
    }

    leftOption: SwipeButton {
      text: "Log Work"
      icon: IconType.clocko
      onClicked: {
        page.navigationStack.popAllExceptFirstAndPush(worklogDetailPageComponent, {issue: dataModel.getIssueForId(model.issueId)})
      }
    }

    rightOption: SwipeButton {
      text: "Delete"
      icon: IconType.trash
      backgroundColor: "red"
      onClicked: {
        dataModel.removeWorklog(model.id)
      }
    }
  }

  listView.headerPositioning: ListView.OverlayHeader
  listView.header: WorklogsHeader {
    onClickedNew: {
      page.navigationStack.popAllExceptFirstAndPush(issuesPageComponent)
    }
  }

  Component {
    id: issuesPageComponent
    IssuesPage {
    }
  }

  Component {
    id: worklogDetailPageComponent
    WorklogDetailPage {
    }
  }
}

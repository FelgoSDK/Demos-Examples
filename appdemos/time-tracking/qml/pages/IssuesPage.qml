import Felgo 3.0
import QtQuick 2.0

ListPage {
  id: page
  title: "Jira Issues"

  model: dataModel.filteredIssuesModel

  showSearch: true
  onSearch: {
    dataModel.issuesSearchTerm = term
  }

  delegate: SimpleRow {
    imageSource: Qt.resolvedUrl(model.imageSrc)
    text: model.title
    detailText: model.label
    badgeValue: dataModel.getStatus(model.status)
    badgeColor: dataModel.getStatusColor(model.status)
    onSelected: {
      page.navigationStack.push(worklogDetailPageComponent, {issue: model})
    }
  }

  Component {
    id: worklogDetailPageComponent
    WorklogDetailPage {

    }
  }

}

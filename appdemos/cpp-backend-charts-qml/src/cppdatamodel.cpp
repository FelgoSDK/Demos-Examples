#include "cppdatamodel.h"
#include <QTime>
#include <QRandomGenerator>

CppDataModel::CppDataModel(QObject *parent) : QObject(parent)
{

  // set timer to send new data every 3 seconds
  timer = new QTimer(this);
  connect(timer, SIGNAL(timeout()), this, SLOT(update()));
  timer->start(500);
}

void CppDataModel::loadData() {
  // load data asynchronously or do C++ calculations here
  // for simplicity this example uses dummy data
  QString dummyData = createRandomData();

  // signal that new data is available
  emit dataLoaded(dummyData);
}

QString CppDataModel::createRandomData() {
  QString dummyData = "[";
  dummyData.append(createRandomEntry(2017,"Braunau")).append(",");
  dummyData.append(createRandomEntry(2017,"Munich")).append(",");
  dummyData.append(createRandomEntry(2017,"Vienna")).append(",");
  dummyData.append(createRandomEntry(2017,"Tokyo")).append(",");
  dummyData.append(createRandomEntry(2018,"Braunau")).append(",");
  dummyData.append(createRandomEntry(2018,"Munich")).append(",");
  dummyData.append(createRandomEntry(2018,"Vienna")).append(",");
  dummyData.append(createRandomEntry(2018,"Tokyo"));
  dummyData.append("]");

  return dummyData;
}

QString CppDataModel::createRandomEntry(int year, const QString& city) {
  auto &rand { *QRandomGenerator::global() };
  return "{ \"year\": \"" + QString::number(year) + "\", \"city\": \"" + city + "\", \"expenses\": " + QString::number(rand.bounded(5000)) +" }";
}

void CppDataModel::update() {
  loadData();
}


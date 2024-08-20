#ifndef CPPDATAMODEL_H
#define CPPDATAMODEL_H

#include <QObject>
#include <QTimer>

class CppDataModel : public QObject
{
  Q_OBJECT
public:
  explicit CppDataModel(QObject *parent = nullptr);

signals:
  void dataLoaded(const QString& jsonDataString);

public slots:
  void loadData();

private:
  QTimer *timer;

  QString createRandomData();
  QString createRandomEntry(int year, const QString& city);

private slots:
  void update();
};

#endif // CPPDATAMODEL_H

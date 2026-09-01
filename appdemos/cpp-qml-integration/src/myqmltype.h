#ifndef MYQMLTYPE_H
#define MYQMLTYPE_H

#include <QObject>

class MyQMLType : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged) // this makes message available as a QML property

public:
  MyQMLType();

public slots: // slots are public methods available in QML
  int increment(int value);
  void startCppTask(); // starts internal calculations of doCppTask()

signals:
  void messageChanged();
  void cppTaskFinished(); // triggered after calculations in doCppTask()

public:
  QString message() const;
  void setMessage(const QString& value);

private:
  void doCppTask(); // method for internal calculations
  QString m_message;

};

#endif // MYQMLTYPE_H

#ifndef MYGLOBALOBJECT_H
#define MYGLOBALOBJECT_H

#include <QObject>

class MyGlobalObject : public QObject
{
  Q_OBJECT
  Q_PROPERTY(int counter READ counter WRITE setCounter NOTIFY counterChanged) // this makes counter available as a QML property

public:
  MyGlobalObject();

public slots: // slots are public methods available in QML
  void doSomething(const QString &text);

signals:
  void counterChanged();

public:
  int counter() const;
  void setCounter(int value);

private:
  int m_counter;

};

#endif // MYGLOBALOBJECT_H

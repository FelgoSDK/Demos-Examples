#include "myglobalobject.h"
#include <QDebug>

MyGlobalObject::MyGlobalObject() : m_counter(0)
{
  // perform custom initialization steps here
}

void MyGlobalObject::doSomething(const QString &text) {
  qDebug() << "MyGlobalObject doSomething called with" << text;
  setCounter(m_counter + 1);
}

int MyGlobalObject::counter() const {
  return m_counter;
}

void MyGlobalObject::setCounter(int value) {
  if(m_counter != value) {
    m_counter = value;
    counterChanged(); // trigger signal of counter change (e.g. updates QML text that uses counter property)
  }
}

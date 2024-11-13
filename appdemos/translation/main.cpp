#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
// Uncomment this line to add Felgo Hot Reload and use hot reloading with your custom C++ code
//#include <FelgoHotReload>

int main(int argc, char *argv[])
{
  QApplication app(argc, argv);
  FelgoApplication felgo;

  // QQmlApplicationEngine is the preferred way to start qml projects since Qt 5.2
  // if you have older projects using Qt App wizards from previous QtCreator versions than 3.1, please change them to QQmlApplicationEngine
  QQmlApplicationEngine engine;
  felgo.initialize(&engine);

  felgo.setMainQmlFileName(QStringLiteral("qml/TranslationExampleMain.qml"));
  //felgo.setMainQmlFileName(QStringLiteral("qml/TranslationExampleSimple.qml"));

  engine.load(QUrl(felgo.mainQmlFileName()));

  return app.exec();
}

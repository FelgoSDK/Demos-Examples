#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>

// Uncomment this line to add Felgo Hot Reload and use hot reloading with your custom C++ code
//#include <FelgoHotReload>

int main(int argc, char *argv[])
{

  QApplication app(argc, argv);

  FelgoApplication felgo;

  QQmlApplicationEngine engine;
  felgo.initialize(&engine);

  // Set an optional license key from project file
  // This does not work if using Felgo Developer App, only for Felgo Cloud Builds and local builds
  felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

  // use this during development
  // for PUBLISHING, use the entry point below
  felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

  // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
  // this is the preferred deployment option for publishing apps to the app stores, because then your qml files and js files are protected
  // to avoid deployment of your qml files and images, also comment the deploy_resources command in the CMakeLists file
  // also see the CMakeLists.txt file for more details
  //felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

  engine.load(QUrl(felgo.mainQmlFileName()));

  // to start your project with Felgo Hot Reload, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
  // and uncomment the line below
  //FelgoHotReload felgoHotReload(&engine);

  return app.exec();
}

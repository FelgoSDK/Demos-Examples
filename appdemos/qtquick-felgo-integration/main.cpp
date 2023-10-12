#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <FelgoApplication> // 1 - include FelgoApplication

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    FelgoApplication felgo; // 2 - create FelgoApplication instance

    QQmlApplicationEngine engine;
    felgo.initialize(&engine); // 3 - initialize Felgo

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    return app.exec();
}

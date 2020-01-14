#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Nantia");
    QGuiApplication::setOrganizationName("Skydev");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/QML/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

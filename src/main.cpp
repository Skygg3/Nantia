#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "TextHandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Nantia");
    QGuiApplication::setOrganizationName("Skydev");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<TextHandler>("skydev.nantia", 1, 0, "TextHandler");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/QML/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

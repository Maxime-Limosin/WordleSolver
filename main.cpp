#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include "src/Controllers/solvercontroller.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    SolverController solverController;

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/res/Icons/icon.png"));
    app.setApplicationName("WordleSolver");

    // Expose controller to QML
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Solver", &solverController);

    const QUrl url(QStringLiteral("qrc:/src/View/main.qml")); // Load main.qml
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}

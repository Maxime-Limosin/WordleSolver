#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QQuickStyle>

#include "src/Controllers/solvercontroller.h"

int main(int argc, char *argv[])
{
    SolverController solverController;

    QQuickStyle::setStyle("Basic");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    app.setWindowIcon(QIcon(":/res/Icons/icon.png"));
    app.setApplicationName("WordleSolver");

    // Expose controller to QML
    engine.rootContext()->setContextProperty("Solver", &solverController);

    // Load main.qml from the WordleSolver QML module
    engine.loadFromModule("WordleSolver", "Main");

    return app.exec();
}

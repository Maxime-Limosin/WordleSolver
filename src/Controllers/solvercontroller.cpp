#include "solvercontroller.h"

SolverController::SolverController(QObject *parent)
    : QObject{parent}
{

}


void SolverController::solveGame(const QVariantList &solvedLetters, const QVariantList &guessedLetters, const QVariantList &incorrectLetters)
{
    qDebug() << "=== Solved Letters ===";
    for (const QVariant &item : solvedLetters)
    {
        QVariantMap letterData = item.toMap();
        QString letter = letterData["letter"].toString();
        int column = letterData["column"].toInt();

        qDebug() << "Letter:" << letter << "| Column:" << column;
    }

    qDebug() << "\n=== Guessed Letters ===";
    for (const QVariant &item : guessedLetters)
    {
        QVariantMap letterData = item.toMap();
        QString letter = letterData["letter"].toString();
        int column = letterData["column"].toInt();

        qDebug() << "Letter:" << letter << "| Column:" << column;
    }

    qDebug() << "\n=== Incorrect Letters ===";
    for (const QVariant &item : incorrectLetters)
    {
        QString letter = item.toString();
        qDebug() << "Letter:" << letter;
    }

    qDebug() << "=====================\n";
}

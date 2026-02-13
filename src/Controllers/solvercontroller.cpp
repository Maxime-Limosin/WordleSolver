#include "solvercontroller.h"

SolverController::SolverController(QObject *parent)
    : QObject{parent}
{

}


void SolverController::solveGame(const QVariantList &rawSolvedLetters, const QVariantList &rawGuessedLetters, const QVariantList &rawIncorrectLetters)
{
    QList<IndexedLetter> solvedLetters, guessedLetters;
    QList<QChar> incorrectLetters;

    // Create solvedLetters
    for (const QVariant &item : rawSolvedLetters)
    {
        QVariantMap letterData = item.toMap();
        QChar letter = letterData["letter"].toString().at(0); // .toChar() expect a char in the JSON, but it's encoded as a string
        int index = letterData["column"].toInt();

        solvedLetters.push_back({ letter, index });
    }

    // Create solvedLetters
    for (const QVariant &item : rawGuessedLetters)
    {
        QVariantMap letterData = item.toMap();
        QChar letter = letterData["letter"].toString().at(0);
        int index = letterData["column"].toInt();

        guessedLetters.push_back({ letter, index });
    }

    // Create solvedLetters
    for (const QVariant &item : rawIncorrectLetters)
        incorrectLetters << item.toString().at(0);

    // Call solveGame function
    auto gameAnswers = _solver.solveGame(solvedLetters, guessedLetters, incorrectLetters);
    emit answersChanged(gameAnswers);
}

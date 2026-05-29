#include "solvercontroller.h"

#include <QtConcurrent/QtConcurrent>

SolverController::SolverController(QObject *parent)
    : QObject{parent} {}

void SolverController::solveGameAsync(const QVariantList &rawSolvedLetters, const QVariantList &rawGuessedLetters, const QVariantList &rawIncorrectLetters)
{
    // If WorldleSolver is currently trying to solve the game, cancel it before running a new solver
    if(_solveGameFuture.isRunning())
    {
        _cancelSolveGame = true;
        _solveGameFuture.waitForFinished(); // Waiting for thread to finish before starting a new one
        _cancelSolveGame = false;
    }

    _solveGameFuture = QtConcurrent::run([this, rawSolvedLetters, rawGuessedLetters, rawIncorrectLetters]
    {
        solveGame(rawSolvedLetters, rawGuessedLetters, rawIncorrectLetters);
    });
}

void SolverController::solveGame(const QVariantList &rawSolvedLetters, const QVariantList &rawGuessedLetters, const QVariantList &rawIncorrectLetters)
{
    using std::sort;

    QList<IndexedLetter> solvedLetters, guessedLetters;
    QList<QChar> incorrectLetters;

    emit solvingGame();

    // Create solvedLetters
    for (const QVariant &item : rawSolvedLetters)
    {
        QVariantMap letterData = item.toMap();
        QChar letter = letterData["letter"].toString().at(0); // .toChar() expect a char in the JSON, but it's encoded as a string
        int index = letterData["column"].toInt();

        solvedLetters.push_back({ letter, index });
    }

    // Create guessedLetters
    for (const QVariant &item : rawGuessedLetters)
    {
        QVariantMap letterData = item.toMap();
        QChar letter = letterData["letter"].toString().at(0);
        int index = letterData["column"].toInt();

        guessedLetters.push_back({ letter, index });
    }

    // Create incorrectLetters
    for (const QVariant &item : rawIncorrectLetters)
        incorrectLetters << item.toString().at(0);

    // Filter candidates
    auto candidates  = _solver.solveGame(solvedLetters, guessedLetters, incorrectLetters);

    // Score each candidate and build a sorted QVariantList for QML
    // This function can take a lot of time: O(n²) complexity
    QMap<QString, double> scores = _entropyCalculator.scoreWords(candidates, _cancelSolveGame);

    // Create and fill an object for QML with entropy results
    QVariantList gameAnswers;
    gameAnswers.reserve(candidates.size());
    for (const QString &word : qAsConst(candidates))
    {
        QVariantMap entry;
        entry["word"]    = word;
        entry["entropy"] = scores.value(word, 0.0); // Default value is 0 if "word" key doesn't exist in map
        gameAnswers.append(entry);
    }

    // Sort by entropy descending (best guess first)
    sort(gameAnswers.begin(), gameAnswers.end(), [](const QVariant &a, const QVariant &b) {
        return a.toMap()["entropy"].toDouble() > b.toMap()["entropy"].toDouble();
    });

    emit answersChanged(gameAnswers);
}

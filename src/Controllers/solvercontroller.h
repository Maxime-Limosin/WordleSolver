#pragma once

#include <QObject>
#include <QDebug>
#include <QFuture>
#include <QVariantList>

#include "src/Model/solver.h"
#include "src/Model/entropycalculator.h"

class SolverController : public QObject
{
    Q_OBJECT
public:
    explicit SolverController(QObject *parent = nullptr);

    Q_INVOKABLE void solveGameAsync(const QVariantList &rawSolvedLetters, const QVariantList &rawGuessedLetters, const QVariantList &rawIncorrectLetters);

signals:
    void solvingGame();
    void answersChanged(const QVariantList& gameAnswers);

private:
    // Classes to solve the game
    Solver            _solver;
    EntropyCalculator _entropyCalculator;

    // Variables for solver cancellation, as it's running async
    // In the solveGame function, the entropy calculation can be really long: O(n²) were n is the number of inputed words
    QFuture<void>     _solveGameFuture;
    std::atomic<bool> _cancelSolveGame {false};

    void solveGame(const QVariantList &rawSolvedLetters, const QVariantList &rawGuessedLetters, const QVariantList &rawIncorrectLetters);
};


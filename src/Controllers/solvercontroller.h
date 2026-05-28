#pragma once

#include <QObject>
#include <QDebug>

#include "src/Model/solver.h"
#include "src/Model/entropycalculator.h"

class SolverController : public QObject
{
    Q_OBJECT
public:
    explicit SolverController(QObject *parent = nullptr);

    Q_INVOKABLE void solveGame(const QVariantList &rawSolvedLetters, const QVariantList &rawGuessedLetters, const QVariantList &rawIncorrectLetters);

signals:
    void answersChanged(const QVariantList& gameAnswers);

private:
    Solver _solver;
    EntropyCalculator _entropyCalculator;
};


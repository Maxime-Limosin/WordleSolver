#pragma once

#include <QObject>
#include <QDebug>

class SolverController : public QObject
{
    Q_OBJECT
public:
    explicit SolverController(QObject *parent = nullptr);

    Q_INVOKABLE void solveGame(const QVariantList &solvedLetters, const QVariantList &guessedLetters, const QVariantList &incorrectLetters);

};


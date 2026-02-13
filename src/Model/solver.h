#pragma once

#include <QObject>
#include <QFile>

#include "indexedLetter.h"

class Solver : public QObject
{
    Q_OBJECT
public:
    explicit Solver(QObject *parent = nullptr);
    ~Solver();

    QStringList solveGame(const QList<IndexedLetter> &solvedLetters, const QList<IndexedLetter> &guessedLetters, const QList<QChar> &incorrectLetters);

private:
    const QString PATH_TO_DIC = ":/res/dictionnary_en_5_letters.txt";
    QFile _dictionary;

    // Check if the word matches the inputed lists
    bool checkWordMatches(const QString &word, const QList<IndexedLetter> &solvedLetters, const QList<IndexedLetter> &guessedLetters, const QList<QChar> &incorrectLetters);
};


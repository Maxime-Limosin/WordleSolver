#include "solver.h"
#include <QDebug>

Solver::Solver(QObject *parent)
    : QObject{parent}, _dictionary(PATH_TO_DIC)
{
    if (!_dictionary.open(QIODevice::ReadOnly | QIODevice::Text))
        qWarning() << "Failed to open dictionary:" << _dictionary.errorString();
}

Solver::~Solver() {
    if(_dictionary.isOpen())
        _dictionary.close();
}

QStringList Solver::solveGame(const QList<IndexedLetter> &solvedLetters, const QList<IndexedLetter> &guessedLetters, const QList<QChar> &incorrectLetters)
{
    QStringList possibleWords;

    if(!_dictionary.isOpen())
        return {};

    // Reset to start of file
    _dictionary.seek(0);
    QTextStream input(&_dictionary);

    // Iterate line by line over the huge file without keeping every line in memory
    while (!input.atEnd()) {
        QString word = input.readLine().trimmed().toUpper();

        if (word.isEmpty())
            continue;

        bool matches = checkWordMatches(word, solvedLetters, guessedLetters, incorrectLetters);

        if (matches)
            possibleWords.append(word);
    }

    return possibleWords;
}

bool Solver::checkWordMatches(const QString &word, const QList<IndexedLetter> &solvedLetters, const QList<IndexedLetter> &guessedLetters, const QList<QChar> &incorrectLetters)
{
    qDebug() << "\n" << word;

    // Check if the word has every solved letter in the right position
    for(const auto &indexedLetter : solvedLetters) {
        //qDebug() << indexedLetter.letter << indexedLetter.index;

        if(word[indexedLetter.index] != indexedLetter.letter)
            return false;
    }

    // Check if the word has every guessed letter, but not in the corresponding index
    for(const auto &indexedLetter : guessedLetters)
    {
        qDebug() << indexedLetter.letter << indexedLetter.index;

        if(!word.contains(indexedLetter.letter)) {// If the letter is missing in the word
            qDebug() << "Word doesn't containt letter";
            return false;
        }

        if(word.contains(indexedLetter.letter) && word[indexedLetter.index] == indexedLetter.letter) { // If the letter is in the incorrect index
            qDebug() << "Contains word in wrong place:" << word[indexedLetter.index];
            return false;
        }
    }

    // Check if the word doesn't have any of the incorrect letters
    for(const QChar &letter : incorrectLetters)
        if(word.contains(letter))
            return false;

    return true; // The word matches the filters !
}

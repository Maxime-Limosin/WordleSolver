#include "entropycalculator.h"

#include <QDebug>
#include <cmath>


QMap<QString, double> EntropyCalculator::scoreWords(const QStringList &possibleWords, std::atomic<bool> &cancelOperation)
{
    using std::log2;

    QMap<QString, double> wordEntropies;
    double numberOfWords = possibleWords.size();

    foreach (const auto &wordToTest, possibleWords)
    {
        double wordToTestEntropy = 0;
        QMap<QString, int> patterns;

        foreach(const auto &word, possibleWords)
        {
            QString pattern = computePattern(wordToTest, word);
            if(pattern.isEmpty())
                continue;

            if(cancelOperation)
                return wordEntropies;

            patterns[pattern]++;
        }

        for (auto it = patterns.keyValueBegin(); it != patterns.keyValueEnd(); ++it)
        {
            double patternProbability = it->second / numberOfWords;
            wordToTestEntropy += patternProbability * log2(1/patternProbability);
        }

        wordEntropies[wordToTest] = wordToTestEntropy;
    }

    return wordEntropies;
}

QString EntropyCalculator::computePattern(const QString &input, const QString &word)
{
    QString pattern;

    if(input.length() != 5 || word.length() != 5)
        return "";

    for(int i = 0; i < word.length(); i++)
    {
        QChar inputLetter = input[i];
        QChar wordLetter = word[i];

        if(inputLetter == wordLetter)
            pattern.append("V");
        else if (word.contains(inputLetter))
            pattern.append("J");
        else
            pattern.append("G");
    }

    return pattern;
}

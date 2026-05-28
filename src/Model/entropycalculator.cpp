#include "entropycalculator.h"

#include <QDebug>

QMap<QString, double> EntropyCalculator::scoreWords(const QStringList &a)
{
    return {};
}

void EntropyCalculator::test()
{
    using std::log2;

    //QStringList wordList = {"CRANE", "CRAVE", "TRACE", "BRACE"};
    QStringList wordList = {"CRANE", "CRAVE", "TRACE", "BRACE", "FLOOD", "MOIST", "PYGMY"};
    QMap<QString, double> wordEntropies;
    double numberOfWords = wordList.size();

    for (const auto &wordToTest : qAsConst(wordList))
    {
        double wordToTestEntropy = 0;
        QMap<QString, int> patterns;

        for(const auto &word: qAsConst(wordList))
        {
            QString pattern = computePattern(wordToTest, word);
            if(pattern.isEmpty())
                return;

            patterns[pattern]++;
        }

        for (auto it = patterns.keyValueBegin(); it != patterns.keyValueEnd(); ++it)
        {
            double patternProbability = it->second / numberOfWords;
            wordToTestEntropy += patternProbability * log2(1/patternProbability);
        }

        wordEntropies[wordToTest] = wordToTestEntropy;
    }

    for (auto it = wordEntropies.keyValueBegin(); it != wordEntropies.keyValueEnd(); ++it)
    {
        qDebug() << it->first << it->second;
    }
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

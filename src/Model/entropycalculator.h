#pragma once

#include <QMap>
#include <QStringList>

class EntropyCalculator
{

public:
    QMap<QString, double> scoreWords(const QStringList &possibleWords);

    void test();

private:
    QString computePattern(const QString &input, const QString &word)
};


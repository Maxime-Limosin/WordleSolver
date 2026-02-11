import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../Elements"
import "../Theme.js" as Theme

GlassPanel {
    component Key: LetterField {
        enabled: backgroundColorWhenLetterFilled != backgroundColor
        backgroundColorWhenLetterFilled: {
            for (var i = 0; i < solvedLetters.length; i++)
                if (solvedLetters[i].letter === text)
                    return Theme.green

            for (var j = 0; j < guessedLetters.length; j++)
                if (guessedLetters[j].letter === text)
                    return Theme.orange

            if (incorrectLetters.indexOf(text) !== -1)
                return Theme.red

            return backgroundColor
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 2

        Row {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["A", "Z", "E", "R", "T", "Y", "U", "I", "O", "P"]

                Key {
                    text: modelData
                }
            }
        }

        Row {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["Q", "S", "D", "F", "G", "H", "J", "K", "L", "M"]

                Key {
                    text: modelData
                }
            }
        }

        Row {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["W", "X", "C", "V", "B", "N"]

                Key {
                    text: modelData
                }
            }
        }
    }
}


import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../Elements"

GlassPanel {
    component Key: LetterField {
        enabled: backgroundColorWhenLetterFilled != backgroundColor
        backgroundColorWhenLetterFilled: {
            // Check if letter is in guessedLetters (orange)
            for (var i = 0; i < solvedLetters.length; i++) {
                if (solvedLetters[i].letter === text)
                    return "#92EC13"  // Green
            }

            // Check if letter is in guessedLetters (orange)
            for (var j = 0; j < guessedLetters.length; j++) {
                if (guessedLetters[j].letter === text)
                    return "#efba34"  // Orange
            }

            // Check if letter is in incorrectLetters (red)
            if (incorrectLetters.indexOf(text) !== -1)
                return "#FF0000"  // Red

            // Default background color (unchanged)
            return backgroundColor
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 2

        // Row 1: A Z E R T Y U I O P
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

        // Row 2: Q S D F G H J K L M
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

        // Row 3: W X C V B N
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


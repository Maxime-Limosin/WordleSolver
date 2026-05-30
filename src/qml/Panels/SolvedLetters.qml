import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"
import "../Theme.js" as Theme

Item {
    property int titleMargin: 10

    function updateSolvedLetters() {
        let inputedLetters = []

        for (let i = 0; i < lettersRepeater.count; i++) {
            let letterField = lettersRepeater.itemAt(i)

            if (letterField && letterField.text !== "")
                inputedLetters.push({letter: letterField.text, column: i})
        }

        solvedLetters = inputedLetters
    }

    WText {
        id: title
        text: "Solved letters"
    }

    GlassPanel {
        anchors.fill: parent
        anchors.topMargin: title.height + titleMargin


        RowLayout {
            spacing: 10
            anchors.centerIn: parent

            Repeater {
                id: lettersRepeater
                model: 5

                LetterField {
                    backgroundColorWhenLetterFilled: Theme.green
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 40

                    lfTextChanged: function() {
                        updateSolvedLetters()
                    }
                }
            }
        }
    }
}

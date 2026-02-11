import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../Elements"

GlassPanel {
    component Key: LetterField {
        backgroundColorWhenLetterFilled: backgroundColor
        enabled: backgroundColorWhenLetterFilled != backgroundColor
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


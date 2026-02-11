import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3

import "Elements"
import "Panels"

Window {
    visible: true
    title: "WordleSolver 🕵️‍"

    // Window dimensions
    height: 760
    width: 1150
    minimumHeight: 760
    minimumWidth: 1150
    maximumHeight: 1400
    maximumWidth: 2240

    property alias blurryBg: appBg.backgroundItem // Allow every GlassPanel to properly blurry the background

    readonly property int panelSpacing: 30

    property var solvedLetters: []    // [{letter: A, column: 0}, {letter: A, column: 1}, ... ]
    property var guessedLetters: []   // [{letter: A, column: 0}, {letter: A, column: 1}, ... ]
    property var incorrectLetters: [] // [A, B, C, ... ]

    AppBackground {
        id: appBg
        anchors.fill: parent
        z: -100
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 50
        spacing: panelSpacing

        ColumnLayout {
            Layout.alignment: Qt.AlignTop
            spacing: panelSpacing

            RowLayout {
                spacing: panelSpacing

                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    Layout.fillHeight: true
                    spacing: panelSpacing

                    SolvedLetters {
                        Layout.preferredHeight: 150
                        Layout.preferredWidth: 400
                    }

                    IncorrectLetters {
                        Layout.fillHeight: true
                        Layout.minimumHeight: 280
                        Layout.preferredWidth: 400
                    }
                }

                GuessedLetters {
                    Layout.alignment: Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.preferredWidth: 300
                }
            }

            WKeyboard {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 200
                Layout.preferredWidth: 500
            }
        }

        GameAnswers {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 200
        }
    }
}

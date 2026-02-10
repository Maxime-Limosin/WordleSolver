import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3

import "Elements"
import "Panels"

Window {
    visible: true
    title: "WordleSolver 🕵️‍"

    // Window dimensions
    height: 740
    width: 1150
    minimumHeight: 740
    minimumWidth: 1150
    maximumHeight: 1400
    maximumWidth: 2240

    property alias blurryBg: appBg.backgroundItem // Allow every GlassPanel to properly blurry the background

    readonly property int panelSpacing: 30

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
                id: lettresRow
                spacing: panelSpacing

                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    Layout.fillHeight: true
                    spacing: panelSpacing

                    SolvedLetters {
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: 400
                    }

                    IncorrectLetters {
                        Layout.fillHeight: true
                        Layout.minimumHeight: 200
                        Layout.preferredWidth: 400
                    }
                }

                GuessedLetters {
                    Layout.alignment: Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.preferredWidth: 400
                }
            }

            WKeyboard {
                Layout.preferredHeight: 200
                Layout.preferredWidth: lettresRow.width
            }
        }

        GameAnswers {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 200
        }
    }
}

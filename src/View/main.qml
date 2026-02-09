import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3

import "Elements"

Window {
    id: win
    width: 1280
    height: 720
    visible: true
    title: "WordleSolver 🕵️‍"

    property alias blurryBg: appBg.backgroundItem // Allow every GlassPanel to properly blurry the background

    AppBackground {
        id: appBg
        anchors.fill: parent
        z: -100
    }

    GridLayout {
        columns: 3
        columnSpacing: 30
        rowSpacing: 30

        anchors.fill: parent
        anchors.margins: 50

        // Solved letters
        ColumnLayout {
            WText {
                text: "Solved letters"
            }

            GlassPanel {
                Layout.topMargin: 10
                Layout.preferredHeight: 200
                Layout.preferredWidth: 400
            }
        }

        // Found letters
        ColumnLayout {
            Layout.rowSpan: 2

            WText {
                text: "Found letters"
            }

            GlassPanel {
                Layout.fillHeight: true
                Layout.preferredWidth: 200
            }
        }

        // Answers
        ColumnLayout {
            Layout.rowSpan: 3

            WText {
                text: "Answers"
            }

            GlassPanel {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 200
            }
        }

        // Incorrect letters
        ColumnLayout {
            WText {
                text: "Incorrect letters"
            }

            GlassPanel {
                Layout.preferredHeight: 200
                Layout.preferredWidth: 400
            }
        }

        // Keyboard
        GlassPanel {
            Layout.columnSpan: 2
            Layout.preferredHeight: 200
            Layout.preferredWidth: 600
        }
    }
}

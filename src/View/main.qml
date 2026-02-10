import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3

import "Elements"
import "Panels"

Window {
    height: 850
    width: 1280
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

        SolvedLetters {
            Layout.preferredHeight: 200
            Layout.preferredWidth: 400
        }

        GuessedLetters {
            Layout.rowSpan: 2
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: 400
            Layout.preferredWidth: 400
        }

        GameAnswers {
            Layout.rowSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 200
        }

        IncorrectLetters {
            Layout.preferredHeight: 200
            Layout.preferredWidth: 400
        }

        WKeyboard {
            Layout.columnSpan: 2
            Layout.preferredHeight: 200
            Layout.preferredWidth: 600
        }
    }
}

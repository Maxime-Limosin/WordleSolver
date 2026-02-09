import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3

import "Elements"
import "Panels"

Window {
    id: win
    width: 1280
    height: 850
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
        }

        GuessedLetters {
            Layout.rowSpan: 2
        }

        GameAnswers {
            Layout.rowSpan: 3
        }

        IncorrectLetters {

        }

        WKeyboard {
            Layout.columnSpan: 2
            Layout.preferredHeight: 200
            Layout.preferredWidth: 600
        }
    }
}

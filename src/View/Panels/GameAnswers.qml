import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import "../Elements"
import "../Theme.js" as Theme

Item {
    readonly property int titleMargin: 10
    readonly property int titleAnimationDuration: 100 // Value in ms

    property int numberOfAnswers: 0
    property bool solvingGame: false

    Connections {
        target: Solver

        // Update the displayed text
        function onAnswersChanged(answers) {
            let t = ""
            for(let i = 0; i < answers.length; i++) {
                let item = answers[i]
                t += item["word"] + " (" + item["entropy"].toFixed(2) + " bits)\n"
            }

            answersText.text = t
            numberOfAnswers = answers.length
            solvingGame = false
        }

        function onSolvingGame() {
            solvingGame = true
        }
    }

    RowLayout {
        id: titleRow
        spacing: 5

        WText {
            id: possibleAnswsersText
            text: "Possible answers"
            Layout.alignment: Qt.AlignBottom
        }

        WText {
            text: numberOfAnswers === 0 ? "" : "(" + numberOfAnswers + ")"
            color: Theme.lightGray
            font.pointSize: 16
            Layout.alignment: Qt.AlignBottom
        }

        WBusyIndicator {
            height: possibleAnswsersText.height
            width: height
            Layout.alignment: Qt.AlignRight
            opacity: solvingGame ? 1 : 0
        }
    }

    GlassPanel {
        anchors.fill: parent
        anchors.topMargin: titleRow.height + titleMargin

        Flickable {
            contentWidth: width
            contentHeight: answersText.height

            anchors.fill: parent
            anchors.margins: 20

            clip: true
            interactive: true
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }

            Text {
                id: answersText
                color: Theme.white
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}

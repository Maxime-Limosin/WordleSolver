import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import "../Elements"
import "../Theme.js" as Theme

Item {
    readonly property int titleMargin: 10
    readonly property int titleAnimationDuration: 100 // Value in ms

    property int numberOfAnswers: 0

    Connections {
        target: Solver

        // Update the displayed text
        function onAnswersChanged(answers) {
            let t = ""
            for(let i = 0; i < answers.length; i++)
                t += answers[i] + "\n"

            answersText.text = t
            numberOfAnswers = answers.length
        }
    }

    RowLayout {
        id: titleRow
        spacing: 5

        WText {
            text: "Possible answers"
            Layout.alignment: Qt.AlignBottom
        }

        WText {
            text: numberOfAnswers === 0 ? "" : "(" + numberOfAnswers + ")"
            color: Theme.lightGray
            font.pointSize: 16
            Layout.alignment: Qt.AlignBottom
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

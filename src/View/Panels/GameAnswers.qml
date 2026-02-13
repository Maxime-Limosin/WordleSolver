import QtQuick 2.15
import QtQuick.Controls 2.15

import "../Elements"
import "../Theme.js" as Theme

Item {
    property int titleMargin: 10

    Connections {
        target: Solver

        function onAnswersChanged(answers) {
            // Update the displayed text
            let t = ""
            for(let i = 0; i < answers.length; i++)
                t += answers[i] + "\n"

            answersText.text = t
        }
    }

    WText {
        id: title
        text: "Possible answers"
    }

    GlassPanel {
        anchors.fill: parent
        anchors.topMargin: title.height + titleMargin

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

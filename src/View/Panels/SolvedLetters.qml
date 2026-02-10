import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"

Item {
    property int titleMargin: 10

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
                model: 5

                LetterField {
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 40
                }
            }
        }
    }
}

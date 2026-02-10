import QtQuick 2.15
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
    }
}

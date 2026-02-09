import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"

ColumnLayout {
    WText {
        text: "Answers"
    }

    GlassPanel {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumWidth: 200
    }
}

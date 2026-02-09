import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"

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

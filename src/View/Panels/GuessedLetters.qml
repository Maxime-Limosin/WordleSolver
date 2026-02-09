import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"

ColumnLayout {
    WText {
        text: "Found letters"
    }

    GlassPanel {
        Layout.fillHeight: true
        Layout.preferredWidth: 200
    }
}

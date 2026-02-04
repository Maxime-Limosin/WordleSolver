import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15

Window {
    id: win
    width: 1280
    height: 720
    visible: true
    title: "WordleSolver 🕵️‍"

    property alias blurryBg: appBg.backgroundItem // Allow every GlassPanel to properly blurry the background

    AppBackground {
        id: appBg
        anchors.fill: parent
        z: -100
    }

    GlassPanel {
        anchors.centerIn: parent
        width: 700
        height: 400

        Column {
            anchors.fill: parent
            anchors.margins: 22
            spacing: 8

            Text {
                text: "Teeeeest"
                color: "white"
                font.pointSize: 20
                font.bold: true
            }
            Text {
                text: "This is a test bla bla blaaaaaaaaaaaaaaaa"
                color: "white"
            }
        }
    }
}

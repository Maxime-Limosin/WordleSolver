import QtQuick
import Qt5Compat.GraphicalEffects

import "../Theme.js" as Theme

Item {
    height: 64
    width: height

    property color spinnerColor: Theme.white
    property color backColor: Theme.darkGray

    readonly property real arcRadius: Math.min(width, height) * 0.35
    readonly property real lineWidth: Math.min(width, height) * 0.07

    Behavior on opacity { OpacityAnimator { duration: 150 }}

    // Spinner background
    GlassPanel {
        anchors.fill: parent
        cornerRadius: parent.width / 2
        backgroundItem: blurryBg
    }

    // Spinning arc
    Canvas {
        id: arc
        anchors.fill: parent

        property real angle: 0

        // Trigger repaint whenever angle changes
        onAngleChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.lineWidth = lineWidth
            ctx.lineCap = "round"

            // Background arc
            ctx.strokeStyle = backColor
            ctx.beginPath()
            ctx.arc(width/2, height/2, arcRadius, 0, Math.PI * 2)
            ctx.stroke()

            // Foreground arc
            ctx.strokeStyle = spinnerColor
            ctx.beginPath()
            ctx.arc(width/2, height/2, arcRadius, angle, angle + Math.PI * 0.5)
            ctx.stroke()
        }

        NumberAnimation on angle {
            from: 0; to: Math.PI * 2
            duration: 800
            loops: Animation.Infinite
            easing.type: Easing.InOutQuad
        }
    }
}

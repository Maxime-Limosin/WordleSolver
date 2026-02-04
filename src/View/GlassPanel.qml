import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    // Panel style properties
    property int blurRadius: 28
    property int cornerRadius: 18
    property color glassColor: "#22FFFFFF"
    property color glassBorderColor: "#33FFFFFF"
    property color shadowColor: "#14000000"

    property Item backgroundItem: blurryBg // Background to blurry with graphical effetcs

    clip: true

    // Compute the area that should be blur
    ShaderEffectSource {
        id: bgCrop
        sourceItem: parent.backgroundItem
        live: true
        recursive: false
        hideSource: false
        sourceRect: Qt.rect(parent.x, parent.y, parent.width, parent.height)
    }

    // Blur the background
    FastBlur {
        anchors.fill: parent
        source: bgCrop
        radius: parent.blurRadius
        transparentBorder: true
    }

    // Create the glass aspect
    Rectangle {
        anchors.fill: parent
        radius: parent.cornerRadius
        color: glassColor
        border.color: glassBorderColor
        border.width: 1
    }

    // Add little shadows (cause it looks great)
    Rectangle {
        anchors.fill: parent
        radius: parent.cornerRadius
        color: shadowColor
    }
}

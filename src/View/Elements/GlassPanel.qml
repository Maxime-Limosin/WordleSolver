import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    // Panel style properties
    property int blurRadius: 50
    property int cornerRadius: 20
    property color glassColor: "#22FFFFFF"
    property color glassBorderColor: "#33FFFFFF"
    property color shadowColor: "#14000000"

    property Item backgroundItem: blurryBg // Background to blurry with graphical effetcs

    // Compute the area that should be blured
    ShaderEffectSource {
        id: bgCrop
        sourceItem: parent.backgroundItem
        live: true
        recursive: false
        hideSource: false
        sourceRect: {
                const p = parent.mapToItem(
                    parent.backgroundItem,
                    0, 0
                )
                return Qt.rect(p.x, p.y, parent.width, parent.height)
            }
    }

    // Blur the background, but in a rectangurlar shape
    FastBlur {
        id: blurItem
        anchors.fill: parent
        source: bgCrop
        radius: blurRadius
        transparentBorder: true
        visible: false // We don't want to display this rectangle but the mask
    }

    // Create a mask with round corners
    Rectangle {
        id: roundedMask
        anchors.fill: parent
        radius: cornerRadius
        visible: false
    }

    // Add the blured background into a rectangle with round corners
    OpacityMask {
        anchors.fill: parent
        source: blurItem
        maskSource: roundedMask
    }

    // Create the glass aspect
    Rectangle {
        anchors.fill: parent
        radius:cornerRadius
        color: glassColor
        border.color: glassBorderColor
        border.width: 1
    }

    // Add little shadows (cause it looks great)
    Rectangle {
        anchors.fill: parent
        radius: cornerRadius
        color: shadowColor
    }
}

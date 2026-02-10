import QtQuick 2.15
import QtQuick.Controls 2.5

TextField {
    id: field

    readonly property color backgroundColor: "#6A7D81"
    readonly property color backgroundColorWhenLetterFilled: "#92EC13"
    readonly property color borderColor: "#242424"

    property bool textFilled: text.length === 1

    width: 40
    height: 60
    hoverEnabled: true
    font.pointSize: 20

    // Center text
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    scale: field.activeFocus ? 1 :field.hovered ? 0.95 : 0.9

    // Only allow one letter
    maximumLength: 1
    inputMethodHints: Qt.ImhUppercaseOnly
    validator: RegularExpressionValidator { regularExpression: /^[A-Za-z]$/ }

    // Disable the cursor by setting it to a blank element
    cursorDelegate: Item {}

    // Create the background
    background: Rectangle {
        radius: field.width / 2
        opacity: 0.8

        color: {
            if(textFilled)
                return backgroundColorWhenLetterFilled

            let color = backgroundColor
            if(field.activeFocus)
                color = Qt.lighter(color, 1.4)

            else if(field.hovered)
                color = Qt.lighter(color, 1.2)

            return color
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    // Force to upper case
    onTextChanged: {
        if (text.length === 1)
            text = text.toUpperCase()
    }

    // Set the cursor at the end, even if the user clicked to the left of the letter
    onActiveFocusChanged: {
        if (activeFocus) {
            cursorPosition = text.length
        }
    }
}

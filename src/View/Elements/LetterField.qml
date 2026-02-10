import QtQuick 2.15
import QtQuick.Controls 2.5

TextField {
    id: field

    property color backgroundColor: "white"
    property color backgroundColorWhenLetterFilled: "limegreen"
    //property color borderColor: "darkolivegreen"
    property color borderColor: "black"


    width: 40
    height: 60
    hoverEnabled: true

    // Center text
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.pointSize: 20
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    // Only allow one letter
    maximumLength: 1
    inputMethodHints: Qt.ImhUppercaseOnly
    validator: RegularExpressionValidator { regularExpression: /^[A-Za-z]$/ }

    // Disable the cursor by setting it to a blank element
    cursorDelegate: Item {}

    // Create the background
    background: Rectangle {
        radius: field.width / 2
        border.width: field.activeFocus ? 2 : 0
        border.color: borderColor // Emphasize the selected TextField (as the cursor is disabled)

        color: {
            let color = (text.length === 0 ? backgroundColor : backgroundColorWhenLetterFilled)

            // Add a small dark effect when the TextField hovered
            if(field.hovered)
                color = Qt.darker(color, 1.3)

            return color
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        Behavior on border.width {
            NumberAnimation {
                duration: 200
            }
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

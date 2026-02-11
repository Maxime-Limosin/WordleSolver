import QtQuick 2.15
import QtQuick.Controls 2.5

import "../Theme.js" as Theme

TextField {
    id: field

    property color backgroundColor: Theme.letterFieldBg
    property color backgroundColorWhenLetterFilled: Theme.letterFieldBg
    property color borderColor: Theme.letterFieldBorder

    property bool textFilled: text.length === 1

    property var lfTextChanged: function() {} // Allow other component to add code to exectute when textChanged event is raised

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

    // Handle text input
    Keys.onPressed: function(event) {
        if(event.text.length !== 1 || /[A-Za-z]/.test(event.text)) // Ensure a letter is pressed
            return

        // If field already has text, replace it
        if (text.length === 1) {
            text = event.text.toUpperCase()
            event.accepted = true
        }
    }

    // Force to upper case
    onTextChanged: {
        if (text.length === 1)
            text = text.toUpperCase()

        lfTextChanged()
    }

    // Set the cursor at the end, even if the user clicked to the left of the letter
    onActiveFocusChanged: {
        if (activeFocus) {
            cursorPosition = text.length
        }
    }
}

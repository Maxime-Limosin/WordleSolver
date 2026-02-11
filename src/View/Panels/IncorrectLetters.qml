import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"

Item {
    property int titleMargin: 10
    property int maxIncorrectLetterField: 21

    // Create a new LetterField in the given column
    function createLetterField() {
        let fields = gridLayout.children
        if(fields.length >= maxIncorrectLetterField)
            return

        let component = Qt.createComponent("../Elements/LetterField.qml")
        if (component.status === Component.Ready) {
            let letterField = component.createObject(gridLayout, {
                                                         "Layout.preferredHeight": 60,
                                                         "Layout.preferredWidth": 40,
                                                         "backgroundColorWhenLetterFilled": "#ff5757"
                                                     })

            // Set focus to the newly created field
            letterField.forceActiveFocus()

            // Connect to text changed signal
            letterField.textChanged.connect(function() {
                handleLetterInput(letterField)
            })
        }
    }

    // Function called when the text of a dynamically created LetterField changed
    function handleLetterInput(field) {
        if (field.text !== "")
            handleLetterAdded(field)
        else
            handleLetterDeleted(field)
    }

    // Check if we should delete the LetterField in the column (excluding current field)
    function handleLetterAdded(field) {
        let fields = gridLayout.children

        // Check for duplicate
        for (let i = 0; i < fields.length; i++) {
            let currentField = fields[i]

            if (currentField !== field && currentField.text && currentField.text.toLowerCase() === field.text.toLowerCase()) {
                field.text = ""
                return
            }
        }

        // If letter is unique, add new field if this is the last one
        ensureEmptyFieldExists()
    }

    // Check if the letter exist in another LetterField of the column
    function handleLetterDeleted(field) {
        let fields = gridLayout.children

        // Only destroy if there's more than one field
        if (fields.length > 1) {
            field.destroy()

            // Ensure there's always an empty field
            Qt.callLater(function() {
                ensureEmptyFieldExists()
            })
        }
    }

    // Ensure there's always an empty LetterField at the end to let the user input a new letter
    function ensureEmptyFieldExists() {
        let fields = gridLayout.children
        let lastLetterField = fields[fields.length - 1]

        if(lastLetterField.text !== "")
            createLetterField()
    }

    WText {
        id: title
        text: "Incorrect letters"
    }

    GlassPanel {
        anchors.fill: parent
        anchors.topMargin: title.height + titleMargin

        GridLayout {
            id: gridLayout
            columns: 7
            columnSpacing: 10
            rowSpacing: 10

            anchors.top: parent.top; anchors.topMargin: 20
            anchors.left: parent.left; anchors.leftMargin: 30

            Component.onCompleted: {
                createLetterField()
            }
        }
    }
}

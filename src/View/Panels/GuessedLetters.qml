import QtQuick 2.15
import QtQuick.Layouts 1.3

import "../Elements"

Item {
    property int titleMargin: 10
    property int maxLetterFieldPerColumn: 5

    function updateGuessedLetters() {
        let allLetters = []

        // Loop through each column
        for (let i = 0; i < columnRepeater.count; i++) {
            let column = columnRepeater.itemAt(i)

            if (!column)
                continue

            // Loop through each child in the column
            for (let j = 0; j < column.children.length; j++) {
                let letterField = column.children[j]

                // Check if it's a LetterField (you might need to adjust this check)
                if (letterField && letterField.text !== undefined && letterField.text !== "")
                    allLetters.push({letter: letterField.text, column: i})
            }

            guessedLetters = allLetters
        }
    }

    // Create a new LetterField in the given column
    function createLetterFieldInColumn(column) {
        let fields = column.children
        if(fields.length >= maxLetterFieldPerColumn)
            return

        let component = Qt.createComponent("../Elements/LetterField.qml")
        if (component.status === Component.Ready) {
            var letterField = component.createObject(column, {
                                                         "Layout.preferredHeight": 60,
                                                         "Layout.preferredWidth": 40,
                                                         "Layout.alignment": Qt.AlignTop,
                                                         "backgroundColorWhenLetterFilled": "#efba34"
                                                     })

            // Add the function after creation
            letterField.lfTextChanged = function() {
               updateGuessedLetters()
            }

            // Set focus to the newly created field
            letterField.forceActiveFocus()

            // Connect to text changed signal
            letterField.textChanged.connect(function() {
                handleLetterInput(letterField, column)
            })
        }
    }

    // Function called when the text of a dynamically created LetterField changed
    function handleLetterInput(field, column) {
        if (field.text.length > 0)
            handleLetterAdded(field, column)
        else
            handleLetterDeleted(field, column)
    }

    // Check if we should add a new LetterField in the column (excluding current field)
    function handleLetterAdded(field, column) {
        if (letterExistsInColumn(column, field.text, field)) {
            field.text = ""
            return
        }

        // If letter is unique, add new field if this is the last one
        if (isLastFieldInColumn(field, column) && column.children.length < maxLetterFieldPerColumn)
            createLetterFieldInColumn(column)
    }

    // Check if we should delete the LetterField in the column
    function handleLetterDeleted(field, column) {
        let fields = column.children

        // Only destroy if there's more than one field
        if (fields.length > 1) {
            field.destroy()

            // Ensure there's always an empty field at the bottom
            Qt.callLater(function() {
                ensureEmptyFieldExists(column)
            })
        }
    }

    // Check if the letter exist in another LetterField of the column
    function letterExistsInColumn(column, letter, excludeField) {
        if (!letter || letter.length === 0) {
            return false
        }

        var children = column.children
        for (var i = 0; i < children.length; i++) {
            // Skip the excluded field (current field being edited)
            if (excludeField && children[i] === excludeField) {
                continue
            }

            if (children[i].text && children[i].text.toLowerCase() === letter.toLowerCase()) {
                return true
            }
        }
        return false
    }

    function isLastFieldInColumn(field, column) {
        let fields = column.children
        return fields[fields.length - 1] === field
    }

    function ensureEmptyFieldExists(column) {
        if (!columnHasEmptyField(column))
            createLetterFieldInColumn(column)
    }

    function columnHasEmptyField(column) {
        let fields = column.children

        for (let i = 0; i < fields.length; i++) {
            if (fields[i].text === "")
                return true
        }
        return false
    }

    WText {
        id: title
        text: "Guessed letters"
    }

    GlassPanel {
        anchors.fill: parent
        anchors.topMargin: title.height + titleMargin

        RowLayout {
            id: rowLayout
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top; anchors.topMargin: 10

            Repeater {
                id: columnRepeater
                model: 5

                ColumnLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignTop

                    Component.onCompleted: {
                        createLetterFieldInColumn(this)
                    }
                }
            }
        }
    }

}

import QtQuick 2.15

Item {
    property alias backgroundItem: bgImage // Expose the image that needs to be blurried

    Image {
        id: bgImage
        anchors.fill: parent
        source: "qrc:/res/background.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true // Make rendering a bit slower but better
        cache: true
    }
}

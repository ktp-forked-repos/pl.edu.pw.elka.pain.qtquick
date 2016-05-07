import QtQuick 2.0

Item {
    id: gameBoard
    property var elements: [1, 2, 3, 4, 5, 6]
    property real mouseAngle: Math.atan2(mouseArea.mouseX - width / 2, mouseArea.mouseY - height / 2)

    anchors.fill: parent
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            //Qt.quit();
        }
    }
    Pointer {
        angle: mouseAngle
        intervalsCount: elements.length
    }
}


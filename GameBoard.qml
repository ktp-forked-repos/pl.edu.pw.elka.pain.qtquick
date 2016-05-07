import QtQuick 2.0

Item {
    id: gameBoard
    property real mouseAngle: Math.atan2(mouseArea.mouseX - width / 2, mouseArea.mouseY - height / 2)

    anchors.fill: parent
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            //Qt.quit();
        }
    }
    Rectangle {
        anchors.centerIn: parent
        width: parent.width > parent.height ? parent.height : parent.width;
        height: width
        color: "white"
        border.width: 1
        radius: width * 0.5
    }

    Pointer {
        angle: mouseAngle
        intervalsCount: gameElements.elements.length
    }
    GameElements {
        id: gameElements
    }
}


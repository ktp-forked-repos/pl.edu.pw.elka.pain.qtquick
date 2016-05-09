
import "Actions.js" as Actions
import QtQuick 2.0

Item {
    id: gameBoard
    property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180;
    property var element: Actions.createNextElement()

    anchors.fill: parent

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            gameElements.elements.insert(pointer.index, element);
            element = Actions.createNextElement()
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
        id: pointer
        angle: mouseAngle
        intervalsCount: gameElements.elements.count
    }
    GameElements {
        id: gameElements
    }
    GameElement {
        id: gameElement
        value: element.val
        type: element.type
    }
    Component.onCompleted: {
        gameElements.elements.append(Actions.createNextElement());
    }
}


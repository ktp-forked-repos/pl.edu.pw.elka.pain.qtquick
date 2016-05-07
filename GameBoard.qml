
import "Actions.js" as Actions
import QtQuick 2.0

Item {
    id: gameBoard
    property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180;

    anchors.fill: parent

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            var element = Actions.createElement();
            Actions.addElementAt(gameElements.elements, pointer.index, element);
            gameElement.value++;
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
        value: 1
    }

    Component.onCompleted: Actions.createElements(gameElements.elements, 5);

}


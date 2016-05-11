
import "Actions.js" as Actions
import QtQuick 2.0

Item {
    id: gameBoard
    property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180;
    property var element: Actions.createNextElement()
    readonly property real angleStep: 360 / repeaterModel.count
    property int minElemOnBoardVal: 1;
    property int maxElemOnBoardVal: 1;

    anchors.fill: parent

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            repeaterModel.insert(pointer.index, element);
            element = Actions.createNextElement()
        }
    }
    Rectangle {
        width: parent.width < parent.height ? parent.width : parent.height
        height: width
        radius: 0.5 * width
        anchors.centerIn: parent;
        color: "white"
        border.width: 1
        border.color: "black"
    }
    Pointer {
        id: pointer
        angle: mouseAngle
        intervalsCount: repeaterModel.count
    }
    Repeater {
        id: repeater
        model: ListModel {
            id: repeaterModel
        }
        ActiveGameElement {
            angle: -index * angleStep
            onAnimatedIn: {
                Actions.removeItems(index);
            }
        }
        onItemAdded: {
            item.animateIn()
        }
    }
    GameElement {
        id: gameElement
        value: element.val
        type: element.type
    }
    Component.onCompleted: {
        repeaterModel.append(Actions.createNextElement());
    }
}


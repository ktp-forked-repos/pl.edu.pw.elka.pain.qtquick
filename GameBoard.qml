
import "Actions.js" as Actions
import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: gameBoard
    property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180;
    property var element: Actions.createNextElement()
    readonly property real angleStep: 360 / repeaterModel.count
    property int minElemOnBoardVal: 1;
    property int maxElemOnBoardVal: 1;
    anchors.fill: parent

    RadialGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "red" }
            GradientStop { position: 0.8; color: "yellow" }
            GradientStop { position: 0.9; color: "white" }
        }
    }
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
        border.width: 1
        border.color: "black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "white" }
            GradientStop { position: 0.94; color: "black" }
            GradientStop { position: 1.0; color: "white" }
        }
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
            onAnimatedIn: { Actions.tryRemoveItems(index); }
            onAnimatedOut: {
                repeaterModel.remove(index)
                Actions.recalculateMinMaxElemOnBoard()
            }
        }
        onItemAdded: { item.animateIn() }
    }
    GameElement {
        id: gameElement
        value: element.value
        type: element.type
    }
    Component.onCompleted: {
        repeaterModel.append(Actions.createNextElement());
    }
}


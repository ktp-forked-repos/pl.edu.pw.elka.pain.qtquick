import "Actions.js" as Actions
import "Constants.js" as Const
import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: background
    anchors.centerIn: parent;
    anchors.fill: parent
    gradient: Gradient {
        id: bgGrad
        property real stopDown: Math.pow(1 - repeater.count / Const.MAX_ELEMENTS, 2)
        property real stopUp: 1 - Math.pow(repeater.count / Const.MAX_ELEMENTS, 2)
        GradientStop { position: -0.01; color: "white" }
        GradientStop { position: bgGrad.stopUp; color: "red" }
        GradientStop { position: bgGrad.stopDown; color: "white" }
        GradientStop { position: 1.01; color: "red" }
        Behavior on stopUp { NumberAnimation { duration: 500 }}
        Behavior on stopDown { NumberAnimation { duration: 500 }}
    }

    Rectangle {
        id: gameBoard
        property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180;
        property var element: Actions.createNextElement()
        property int minElemOnBoardVal: 1;
        property int maxElemOnBoardVal: 1;
        readonly property real angleStep: 360 / repeaterModel.count
        width: parent.width < parent.height ? parent.width : parent.height
        height: width
        anchors.centerIn: parent;
        radius: 0.5 * width
        gradient: Gradient {
            GradientStop { position: 0.0; color: "white" }
            GradientStop { position: 1.0; color: "black" }
        }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: { Actions.addItemAt(pointer.index) }
        }
        Pointer {
            id: pointer
            angle: gameBoard.mouseAngle
            intervalsCount: repeaterModel.count
        }
        Repeater {
            id: repeater
            model: ListModel { id: repeaterModel }
            GameElement {
                angle: -index * gameBoard.angleStep
                value: model.value
                type: model.type
                onAnimatedIn: { Actions.onAnimatedIn(index) }
                onAnimatedOut: { Actions.remove(index) }
            }
            onItemAdded: { item.animateIn() }
        }
        GameElement {
            id: gameElement
            value: gameBoard.element.value
            type: gameBoard.element.type
        }
        Component.onCompleted: { repeaterModel.append(Actions.createNextElement()); }
    }
}

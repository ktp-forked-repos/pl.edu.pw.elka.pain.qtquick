import "Actions.js" as Actions
import "Constants.js" as Const
import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: gameBoard
    property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180;
    property var element: Actions.createNextElement()
    property int minElemOnBoardVal: 1;
    property int maxElemOnBoardVal: 1;
    readonly property real angleStep: 360 / repeaterModel.count
    readonly property real size: (width > height ? height : width) / 2
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
        onClicked: { Actions.onClicked(pointer.index) }
    }
    Pointer {
        id: pointer
        angle: mouseAngle
        intervalsCount: repeaterModel.count
    }
    Repeater {
        id: repeater
        model: ListModel { id: repeaterModel }
        GameElement {
            angle: -index * angleStep
            value: model.value
            type: model.type
            onAnimatedIn: { Actions.onAnimatedIn(index) }
            onAnimatedOut: { Actions.onAnimatedOut(index) }
        }
        onItemAdded: { item.animateIn() }
    }
    GameElement {
        id: gameElement
        value: element.value
        type: element.type
    }
    Component.onCompleted: { repeaterModel.append(Actions.createNextElement()); }
}


import "Actions.js" as Actions
import "Constants.js" as Const
import QtQuick 2.0
import QtGraphicalEffects 1.0

Circle {
    id: gameBoard
    readonly property real mouseAngle: Math.atan2(-mouseArea.mouseX + width / 2, -mouseArea.mouseY + height / 2) / Math.PI * 180 + 180
    readonly property real angleStep: 360 / repeaterModel.count
    property var element: Actions.createNextElement()
    property int minElemOnBoardVal: 1
    property int maxElemOnBoardVal: 1
    property int activeElemCount: 0
    size: parent.width < parent.height ? parent.width : parent.height
    anchors.centerIn: parent
    RadialGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(1.0, 0.4, 0.4, 1) }
            GradientStop { position: 0.499; color: Qt.rgba(0.4, 0.2, 0.2, 1) }
            GradientStop { position: 0.5; color: Qt.rgba(0, 0, 0, 0) }
            GradientStop { position: 1; color: Qt.rgba(0, 0, 0, 0) }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: Actions.addItemAt(pointer.index)
    }
    Pointer {
        id: pointer
        angle: gameBoard.mouseAngle
        intervalsCount: repeaterModel.count
    }
    Repeater {
        id: repeater
        model: ListModel { id: repeaterModel }
        delegate: GameElement {
            angle: -index * gameBoard.angleStep
            value: model.value
            type: model.type
            onAnimatedIn: Actions.onAnimatedIn(index)
            onAnimatedOut: Actions.onAnimatedOut(index)
        }
        onItemAdded: Actions.animateIn(item)
    }
    GameElement {
        id: gameElement
        value: gameBoard.element.value
        type: gameBoard.element.type
    }
    Component.onCompleted: repeaterModel.append(Actions.createNextElement())
}

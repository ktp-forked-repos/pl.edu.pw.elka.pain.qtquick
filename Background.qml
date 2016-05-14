import QtQuick 2.0
import "Constants.js" as Const

Rectangle {
    property real fillLevel
    anchors.centerIn: parent;
    anchors.fill: parent
    gradient: Gradient {
        id: bgGrad
        property real stopDown: Math.min(1, Math.pow(1 - fillLevel, 2))
        property real stopUp: Math.max(0, 1 - Math.pow(fillLevel, 2))
        GradientStop { position: 0; color: "white" }
        GradientStop { position: bgGrad.stopUp; color: "red" }
        GradientStop { position: bgGrad.stopDown; color: "white" }
        GradientStop { position: 1; color: "red" }
        Behavior on stopUp { NumberAnimation { duration: Const.ANIMATION_DURATION }}
        Behavior on stopDown { NumberAnimation { duration: Const.ANIMATION_DURATION }}
    }
}


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
        readonly property color red: Qt.rgba(0.5, 0, 0, 1)
        readonly property color white: Qt.rgba(1, 1, 1, 1)
        GradientStop { position: 0; color: bgGrad.white }
        GradientStop { position: bgGrad.stopUp; color: bgGrad.red }
        GradientStop { position: bgGrad.stopDown; color: bgGrad.white }
        GradientStop { position: 1; color: bgGrad.red }
        Behavior on stopUp { NumberAnimation { duration: Const.ANIMATION_DURATION }}
        Behavior on stopDown { NumberAnimation { duration: Const.ANIMATION_DURATION }}
    }
}


import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    anchors.centerIn: parent;
    property real intervalsCount: 0;
    property real angle: 0;

    readonly property real angleStep: 360 / intervalsCount
    readonly property int index: Math.floor(angle / angleStep + 1)
    readonly property real displayAngle: -(index - 1/2) * angleStep;

    width: gameBoard.size * 0.003
    height: gameBoard.size / 2
    color: Qt.rgba(0, 0, 0, 1)
    opacity: 0.1
    transform: [
        Rotation { angle: displayAngle },
        Translate { y: gameBoard.size / 4 }
    ]
}

import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    anchors.centerIn: parent;
    property real intervalsCount: 0;
    property real angle: 0;

    readonly property real angleStep: 360 / intervalsCount
    readonly property int index: Math.floor(angle / angleStep + 1)
    readonly property real displayAngle: -(index + intervalsCount / 2 - 1/2)* angleStep;

    Rectangle {
        width: gameBoard.size * 0.003
        height: gameBoard.size / 2
        color: "black"
        opacity: 0.1
        transform: [
            Translate { y: -gameBoard.size / 2 },
            Rotation { angle: displayAngle }
        ]
    }
}

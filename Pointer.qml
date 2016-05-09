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
        width:1
        opacity: 0.1
        height:200
        color: "black"
        transform: [
            Translate {
                y: -200
            },
            Rotation {
                angle: displayAngle
            }
        ]
        RectangularGlow {
            anchors.fill: parent
            glowRadius: 2
            spread: 0.1
            color: "black"
            cornerRadius: parent.radius + glowRadius
        }
    }
}

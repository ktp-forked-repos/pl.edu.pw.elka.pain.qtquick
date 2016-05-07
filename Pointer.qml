import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    anchors.centerIn: parent;
    property real intervalsCount: 0;
    property real angle: 0;

    readonly property real angleStep: Math.PI * 2 / intervalsCount
    readonly property int index: Math.floor(angle / angleStep)
    readonly property real displayAngle: index * angleStep + angleStep / 2

    Rectangle {
        width:1
        height:200
        color: "black"
        transform: [
            Rotation {
                angle: -displayAngle / Math.PI * 180
            }
        ]
        RectangularGlow {
            anchors.fill: rect
            glowRadius: 2
            spread: 0.1
            color: "black"
            cornerRadius: radius + glowRadius
        }
    }
}


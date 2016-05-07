import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    anchors.centerIn: parent;
        property real intervalsCount: 0;
        property real angle: 0;

    Rectangle {
        id: rect
        property real angleStep: Math.PI * 2 / intervalsCount
        property int pointerPosition: Math.floor(angle / angleStep)
        property real displayAngle: pointerPosition * angleStep + angleStep / 2

        //anchors.centerIn: parent
        width:1
        height:200
        color: "black"
        transform: [
            Rotation {
                angle: -rect.displayAngle / Math.PI * 180
            },
            Translate {
                //y: 100
            }
        ]
        RectangularGlow {
            anchors.fill: rect
            glowRadius: 2
            spread: 0.1
            color: "black"
            cornerRadius: rect.radius + glowRadius
        }
    }
}


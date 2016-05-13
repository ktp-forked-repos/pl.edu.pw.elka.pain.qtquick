import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    anchors.centerIn: parent;
    anchors.fill: parent
    RadialGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "red" }
            GradientStop { position: 0.8; color: "yellow" }
            GradientStop { position: 0.9; color: "white" }
        }
    }
}


import QtQuick 2.0

Item {
    property var elements: [1, 2, 3]
    readonly property real angleStep: 360 / elements.length
    anchors.centerIn: parent;

    Repeater {
        model: elements
        Rectangle {
            id: rect
            width: 40
            height: width
            color: "red"
            border.width: 1
            radius: width * 0.5
            Text {
                 anchors.centerIn: parent
                 color: "black"
                 text: modelData.toString();
            }
            transform: [
                Translate {
                    x: -rect.width / 2
                    y: -rect.height / 2 + 200
                },
                Rotation {
                    angle: angleStep * index
                }
            ]

        }
    }
}


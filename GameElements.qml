import QtQuick 2.0

Item {
    property var elements: repeaterModel
    readonly property real angleStep: 360 / repeaterModel.count
    anchors.centerIn: parent;

    Repeater {
        id: repeater;
        model: ListModel {
            id: repeaterModel
        }
        GameElement {
            id: element
            value: model.txt
            transform: [
                Translate {
                    y: 200
                },
                Rotation {
                    angle: -index * angleStep
                    Behavior on angle {
                        NumberAnimation { duration: 500 }
                    }
                }
            ]
        }
    }
}


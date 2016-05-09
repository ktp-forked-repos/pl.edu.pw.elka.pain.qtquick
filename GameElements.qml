import QtQuick 2.0
import "Actions.js" as Actions
import "Constants.js" as Const

Item {
    property var elements: repeaterModel
    readonly property real angleStep: 360 / repeaterModel.count

    property int minElemOnBoardVal: 1;
    property int maxElemOnBoardVal: 1;

    anchors.centerIn: parent;

    Repeater {
        id: repeater;
        model: ListModel {
            id: repeaterModel
        }
        GameElement {
            id: element
            value: model.val
            type: model.type
            transform: [
                Translate {
                    y: 0
                    Behavior on y { NumberAnimation {
                            duration: 300
                            onRunningChanged: {
                                Actions.onItemAddedAnimationEnd(index, this.running)
                            }
                        } }
                },
                Rotation {
                    angle: -index * angleStep
                    Behavior on angle { NumberAnimation { duration: 300 } }
                }
            ]
        }
        onItemAdded: { Actions.onItemAdded(index, item) }

    }
}


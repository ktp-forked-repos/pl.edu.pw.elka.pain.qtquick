import QtQuick 2.0
import QtGraphicalEffects 1.0
import "Constants.js" as Const
import "Actions.js" as Actions

Item {
    id: element
    property int value: 0;
    property string type: Const.TYPE_ELEMENT
    property real translate: 0
    property real angle: 0
    signal animatedIn();
    signal animatedOut();
    anchors.centerIn: parent;
    Circle {
        id: rect
        anchors.centerIn: parent;
        size: gameBoard.size * 0.1
        color: Actions.getColor(element)
        Text {
             anchors.centerIn: parent
             font.pixelSize: parent.size * 0.4
             color: "black"
             text: value
             rotation: -element.angle
        }
    }
    transform: [
        Translate { y: element.translate },
        Rotation {
            angle: element.angle
            Behavior on angle { NumberAnimation { duration: Const.ANIMATION_DURATION } }
        }
    ]
    states: [
        State {
            name: Const.STATE_ANIMATE_IN
            PropertyChanges { target: element; translate: gameBoard.width * 0.4 }
        },
        State {
            name: Const.STATE_ANiMATE_OUT
            PropertyChanges { target: element; translate: 0 }
        }

    ]
    transitions: [
        Transition {
            to: Const.STATE_ANIMATE_IN
            SequentialAnimation {
                NumberAnimation {
                    property: "translate"
                    duration: Const.ANIMATION_DURATION
                }
                ScriptAction { script: element.animatedIn() }
            }
        },
        Transition {
            to: Const.STATE_ANiMATE_OUT
            SequentialAnimation {
                NumberAnimation {
                    property: "translate"
                    duration: Const.ANIMATION_DURATION
                }
                ScriptAction { script: element.animatedOut() }
            }
        }
    ]
}


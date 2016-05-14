import QtQuick 2.0
import "Constants.js" as Const
import "Actions.js" as Actions

Item {
    id: element
    property int value: 0;
    property string type: Const.TYPE_ELEMENT
    property real translate: 0
    property real angle: 0
    property var animateIn: function() { element.state = Const.STATE_ANIMATE_IN }
    property var animateOut: function() { element.state = Const.STATE_ANiMATE_OUT }
    signal animatedIn();
    signal animatedOut();
    anchors.centerIn: parent;
    Rectangle {
        id: rect
        anchors.centerIn: parent;
        width: gameBoard.width * 0.1
        height: width
        color: Actions.getColor(element)
        border.width: 2
        radius: width * 0.5
        Text {
             anchors.centerIn: parent
             color: "black"
             text: value
             rotation: -element.angle
        }
    }
    transform: [
        Translate { y: element.translate },
        Rotation {
            angle: element.angle
            Behavior on angle { NumberAnimation { duration: 500 } }
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
                    duration: 400
                }
                ScriptAction { script: element.animatedIn() }
            }
        },
        Transition {
            to: Const.STATE_ANiMATE_OUT
            SequentialAnimation {
                NumberAnimation {
                    property: "translate"
                    duration: 400
                }
                ScriptAction { script: element.animatedOut() }
            }
        }
    ]
}


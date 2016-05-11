import QtQuick 2.0

GameElement {
    id: element
    property real radius: 0
    property real angle: 0
    property real animateOutAngle: 0
    property var animateIn: function() {
        element.state = "animateIn"
    }
    property var animateOut: function(toAngle) {
        animateOutAngle = toAngle
        element.state = "animateOut"
    }
    signal animatedIn();
    signal animatedOut();
    value: model.val
    type: model.type
    transform: [
        Translate { y: element.radius },
        Rotation {
            angle: element.angle
            Behavior on angle { NumberAnimation {
                    duration: 500
                } }
        }
    ]
    states: [
        State {
            name: "animateIn"
            PropertyChanges { target: element; radius: 200 }
        },
        State {
            name: "animateOut"
            PropertyChanges { target: element; angle: animateOutAngle}
        }

    ]
    transitions: [
        Transition {
            to: "animateIn"
            SequentialAnimation {
                NumberAnimation {
                    property: "radius"
                    duration: 500
                }
                ScriptAction {
                    script: element.animatedIn()
                }
            }
        },
        Transition {
            to: "animateOut"
            SequentialAnimation {
                NumberAnimation {
                    property: "angle"
                    duration: 500
                }
                ScriptAction {
                    script: element.animatedOut()
                }
            }
        }
    ]
}


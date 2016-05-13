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
        element.animateOutAngle = toAngle
        element.state = "animateOut"
    }
    signal animatedIn();
    signal animatedOut();
    value: model.value
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
            PropertyChanges { target: element; radius: 0 }
        }

    ]
    transitions: [
        Transition {
            to: "animateIn"
            SequentialAnimation {
                NumberAnimation {
                    property: "radius"
                    duration: 400
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
                    property: "radius"
                    duration: 400
                }
                ScriptAction {
                    script: element.animatedOut()
                }
            }
        }
    ]
}


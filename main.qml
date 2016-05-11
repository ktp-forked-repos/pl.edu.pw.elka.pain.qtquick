import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    title: "Atomas by wzielin3"
    minimumHeight: 500
    minimumWidth: 500

    GameBoard {

    }

//    Rectangle {
//        id: signal
//        width: 200; height: 200
//        state: "NORMAL"

//        states: [
//            State {
//                name: "NORMAL"
//                PropertyChanges { target: signal; color: "green"}
//                PropertyChanges { target: flag; state: "FLAG_DOWN"}
//            },
//            State {
//                name: "CRITICAL"
//                PropertyChanges { target: signal; color: "red"}
//                PropertyChanges { target: flag; state: "FLAG_UP"}
//            }
//        ]
//    }
//    Rectangle {
//        id: signalswitch
//        width: 75; height: 75
//        color: "blue"

//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                if (signal.state == "NORMAL")
//                    signal.state = "CRITICAL"
//                else
//                    signal.state = "NORMAL"
//            }
//        }
//    }

//    Rectangle {
//    id: element
//    property real radius: 0
//    property real angle: 0
//    property var animateIn: function() {
//        element.state = "animateIn"
//    }
//    signal animatedIn();
//    value: model.val
//    type: model.type
//    transform: [
//        Translate {
//            y: element.radius
//        },
//        Rotation {
//            angle: element.angle
//            Behavior on angle { NumberAnimation {
//                    duration: 500
//                } }
//        }
//    ]
//    states: [
//        State {
//            name: "animateIn"
//            PropertyChanges { target: element; radius: 100 }
//        }
//    ]
//    Transition {
//        to: "animateIn"
//        NumberAnimation {
//            property: "radius"
//            duration: 500
//        }
//        ScriptAction {
//            script: element.animatedIn()
//        }
//    }
//    }

}


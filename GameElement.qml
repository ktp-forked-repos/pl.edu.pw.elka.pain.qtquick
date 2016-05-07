import QtQuick 2.0

Item {
    property int value: 0;
    anchors.centerIn: parent;
    Rectangle {
        anchors.centerIn: parent;
        id: rect
        width: 40
        height: width
        color: "red"
        border.width: 1
        radius: width * 0.5
        Text {
             anchors.centerIn: parent
             color: "black"
             text: value
        }
    }
}


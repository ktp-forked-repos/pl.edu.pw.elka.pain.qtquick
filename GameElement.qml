import QtQuick 2.0
import "Constants.js" as Const
import "Actions.js" as Actions

Item {

    property int value: 0;
    property string type: Const.TYPE_ELEMENT
    anchors.centerIn: parent;
    Rectangle {
        anchors.centerIn: parent;
        width: 40
        height: width
        color: type === Const.TYPE_ELEMENT ? "red" : "black"
        border.width: 1
        radius: width * 0.5
        Text {
             anchors.centerIn: parent
             color: "black"
             text: value
        }
    }
}


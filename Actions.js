function createElements(listModel, count) {
    while(count-- > 0) {
        listModel.append(createElement());
    }

}

function createElement() {
    return { txt: (count++).toString() }
}

function addElementAt(listModel, index, element)
{
    listModel.insert(index, element);
}

function createElement1() {
//    var component = Qt.createComponent("GameElement.qml");
//    var object = component.createObject(gameBoard, {value: 1});
//    object.parent = gameBoard;
//    object.anchors.centerIn = object.parent;
}

var count = 0;

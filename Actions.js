.import "Constants.js" as Const

function createNextElement() {
    var value = Math.floor(Math.random() * (
        gameBoard.maxElemOnBoardVal - gameBoard.minElemOnBoardVal + 1))
            + gameBoard.minElemOnBoardVal;
    var type = Math.random() > 0.8 ? Const.TYPE_PLUS : Const.TYPE_ELEMENT
    return { val: value, type: type }
}

function removeItems(index)
{
    var item = repeater.itemAt(index)
    if(item.type === Const.TYPE_PLUS) {
        var left = getValidIndex(index - 1);
        var right = getValidIndex(index + 1)
        repeater.itemAt(left).animateOut(item.angle)
        repeater.itemAt(right).animateOut(item.angle)
    }
}

function getValidIndex(index) {
    if(index < 0) return index + repeaterModel.count
    if(index > repeaterModel.count) return index - repeaterModel.count
    return index
}

.import "Constants.js" as Const

var tilPlusTimeDefault = 5;
var tilPlusTime = tilPlusTimeDefault;

function createNextElement() {
    var value
    var type
    if(tilPlusTime === 0) {
        type = Const.TYPE_PLUS
        tilPlusTime = tilPlusTimeDefault
        value = -1
    }
    else {
        type = Const.TYPE_ELEMENT
        value = Math.floor(Math.random() * (
            gameBoard.maxElemOnBoardVal - gameBoard.minElemOnBoardVal + 1))
            + gameBoard.minElemOnBoardVal;
        tilPlusTime--
    }
    return { value: value, type: type }
}

function tryRemoveItems(index)
{
    var left = getValidIndex(index - 1)
    var right = getValidIndex(index + 1)
    if(removeItems(index) || removeItems(left) || removeItems(right)) {
        recalculateMinMaxElemOnBoard()
    }
}

function removeItems(index)
{
    var item = repeater.itemAt(index)
    var elementCount = repeater.count - 3
    var summedValue = 0
    if(item.type === Const.TYPE_PLUS) {
        var removedCount = 0;
        var left = repeater.itemAt(getValidIndex(index - 1))
        var right = repeater.itemAt(getValidIndex(index + 1))
        while(elementCount >= 0 && left.value === right.value)
        {
            left.animateOut(item.angle)
            right.animateOut(item.angle)
            removedCount++
            elementCount -= 2
            if(left.value < summedValue) summedValue++
            else summedValue = left.value + 2
            left = repeater.itemAt(getValidIndex(index - 1 - removedCount))
            right = repeater.itemAt(getValidIndex(index + 1 + removedCount))
        }
        if(removedCount > 0) {
            item.type = Const.TYPE_ELEMENT
            item.value = summedValue
            return true;
        }
    }
}

function recalculateMinMaxElemOnBoard() {
    var min, max, i, val;
    for(i = 0; i < repeaterModel.count; ++i) {
        if(repeaterModel.get(i).type === Const.TYPE_ELEMENT) {
            val = repeaterModel.get(i).value
            max = val
            min = val
            ++i
            break
        }
    }
    for(; i < repeaterModel.count; ++i) {
        if(repeaterModel.get(i).type === Const.TYPE_ELEMENT) {
            val = repeaterModel.get(i).value
            if(min > val) min = val
            if(max < val) max = val
        }
    }
    gameBoard.maxElemOnBoardVal = max
    gameBoard.minElemOnBoardVal = min
}

function getValidIndex(index) {
    var allCount = repeaterModel.count
    if(index < 0) return index + allCount
    if(index >= allCount) return index - allCount
    return index
}

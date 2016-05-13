.import "Constants.js" as Const

var defaultPlusChance = 0.1
var plusChanceIncrement = 0.05
var plusChance = defaultPlusChance

function createNextElement() {
    var value
    var type
    if(Math.random() < plusChance) {
        type = Const.TYPE_PLUS
        plusChance = defaultPlusChance
        value = -1
    }
    else {
        var min = gameBoard.minElemOnBoardVal
        var max = Math.min(gameBoard.maxElemOnBoardVal, min + 10)
        type = Const.TYPE_ELEMENT
        value = Math.floor(Math.random() * (max - min + 1)) + min;
        plusChance += plusChanceIncrement
    }
    return { value: value, type: type }
}

function getColor(item) {
    if(item.type === Const.TYPE_PLUS) return "black"
    var r = (Math.sin(item.value) + 1) * 0.9 + 0.1
    var g = (Math.cos(item.value) + 1) * 0.9 + 0.1
    var b = (Math.sin(item.value) - Math.cos(item.value) + 2) * 0.45 + 0.1
    return Qt.rgba(r, g, b, 1)
}

function onClicked(index) {
    repeaterModel.insert(index, gameBoard.element);
    gameBoard.element = createNextElement()
}

function onAnimatedIn(index)
{
    removeItems(index)
    removeItems(index - 1)
    removeItems(index + 1)
}

function removeItems(index)
{
    index = getValidIndex(index)
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
            else if(0 === summedValue) summedValue = left.value + 1
            else summedValue += 2
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

function onAnimatedOut(index) {
    repeaterModel.remove(index)
    removeItems(index)
    removeItems(index - 1)
    var min, max, i, val;
    for(i = 0; i < repeaterModel.count; ++i) {
        if(repeater.itemAt(i).type === Const.TYPE_ELEMENT) {
            val = repeater.itemAt(i).value
            max = val
            min = val
            ++i
            break
        }
    }
    for(; i < repeaterModel.count; ++i) {
        if(repeater.itemAt(i).type === Const.TYPE_ELEMENT) {
            val = repeater.itemAt(i).value
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

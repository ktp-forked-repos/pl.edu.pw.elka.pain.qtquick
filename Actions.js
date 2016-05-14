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
    var sin = Math.sin(item.value)
    var cos = Math.cos(item.value)
    var r = (sin + 1) * 0.9 + 0.1
    var g = (cos + 1) * 0.9 + 0.1
    var b = (sin - cos + 2) * 0.45 + 0.1
    return Qt.rgba(r, g, b, 1)
}

function addItemAt(index) {
    if(index >= repeater.count || index < 0) index = 0
    repeaterModel.insert(index, gameBoard.element)
    gameBoard.element = createNextElement()
}

function onAnimatedIn(index)
{
    removeItems(index)
    removeItems(index - 1)
    removeItems(index + 1)
    if(repeater.count >= Const.MAX_ELEMENTS) {
        for(var i = 0; i < repeater.count; ++i) {
            repeater.itemAt(i).animateOut()
        }
        gameBoard.element.value = 1
    }
}

function removeItems(index)
{
    index = getValidIndex(index)
    var item = repeater.itemAt(index)
    if(item.state === Const.STATE_ANiMATE_OUT) return
    var elementCount = repeater.count - 3
    var summedValue = 0
    if(item.type === Const.TYPE_PLUS) {
        var removedCount = 0;
        var left = repeater.itemAt(getValidIndex(index - 1))
        var right = repeater.itemAt(getValidIndex(index + 1))
        while(elementCount >= 0 && left.value === right.value
              && left.type !== Const.TYPE_PLUS
              && left.state !== Const.STATE_ANIMATE_OUT
              && right.state !== Const.STATE_ANIMATE_OUT)
        {
            left.animateOut(item.angle)
            right.animateOut(item.angle)
            removedCount++
            elementCount -= 2
            if(summedValue === 0) summedValue = left.value + 1
            else if(summedValue < left.value) summedValue = left.value + 2
            else summedValue++
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

function remove(index) {
    repeaterModel.remove(index)
    removeItems(index)
    removeItems(index - 1)
    var min, max
    var found = false
    for(var i = 0; i < repeaterModel.count; ++i) {
        var item = repeater.itemAt(i)
        if(item.type === Const.TYPE_ELEMENT
                && item.state !== Const.STATE_ANiMATE_OUT) {
            var val = repeater.itemAt(i).value
            if(!found) {
                found = true
                min = val;
                max = val
            }
            else if(min > val) min = val
            else if(max < val) max = val
        }
    }
    if(!found) {
        gameBoard.maxElemOnBoardVal = 1
        gameBoard.minElemOnBoardVal = 1
        gameBoard.element = createNextElement()
        addItemAt(0)
    }
    else {
        gameBoard.maxElemOnBoardVal = max
        gameBoard.minElemOnBoardVal = min
    }
}

function getValidIndex(index) {
    var allCount = repeaterModel.count
    if(index < 0) return index + allCount
    if(index >= allCount) return index - allCount
    return index
}

.import "Constants.js" as Const

function createNextElement() {
    var value = Math.floor(Math.random() * (
        gameElements.maxElemOnBoardVal - gameElements.minElemOnBoardVal + 1))
            + gameElements.minElemOnBoardVal;
    var type = Math.random() > 0.8 ? Const.TYPE_PLUS : Const.TYPE_ELEMENT
    return { val: value, type: type }
}

function onItemAdded(index, item) {
    item.transform[0].y = 200
    if(item.type === Const.TYPE_ELEMENT) {
        if(item.val > gameElements.maxElemOnBoardVal) gameElements.maxElemOnBoardVal = item.val
        if(item.val < gameElements.minElemOnBoardVal) gameElements.minElemOnBoardVal = item.val
    }
}

function onItemAddedAnimationRunningChanged(index, running) {
}

function collapsePlus(index) {

}

function getValidIndex(index) {
    if(index < 0) return index + gameElements.elements.count
    if(index > gameElements.elements.count) return index - gameElements.elements.count
}

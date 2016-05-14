import QtQuick 2.3
import QtQuick.Window 2.2
import "Constants.js" as Const

Window {
    visible: true
    title: "Atomas by wzielin3"
    minimumHeight: 500
    minimumWidth: 500

    Background { fillLevel: gameBoard.activeElemCount / Const.MAX_ELEMENTS }
    GameBoard { id: gameBoard }
}


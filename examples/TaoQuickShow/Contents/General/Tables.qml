import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent

    Rectangle {
        id: mainItem
        width: 800
        height: 600
        border.color: "steelblue"
        anchors.centerIn: parent
        Row {
            spacing: 10
            CusLabel {
                text: qsTr("selectCount: %1").arg(deviceAddModel.selectedCount) + trans.transString
            }
            CusLabel {
                text: qsTr("checkedCount: %1").arg(deviceAddModel.checkedCount) + trans.transString
            }
            CusLabel {
                text: qsTr("visibledCount: %1").arg(deviceAddModel.visibledCount) + trans.transString
            }
        }
        CusTextField_Search {
            anchors {
                right: parent.right
                rightMargin: 10
                top: parent.top
            }
            onTextChanged: {
                deviceAddModel.search(text)
            }
            placeholderText: qsTr("Search") + trans.transString
        }
        CusTableHeader {
            id: cusHeader
            y: 50
            width: parent.width
            height: 30
            averageCount: 4
            averageSize: 1.0
            dataObj: deviceAddModel
            headerNames: deviceAddModel.headerRoles
            headerRoles: deviceAddModel.headerRoles
            widthList: cusView.widthList
            xList: cusView.xList
        }
        CusTableView {
            id: cusView
            y: cusHeader.y + cusHeader.height
            width: parent.width
            height: parent.height - y - 40
            model: deviceAddModel
            onPressed: {
                doPress(mouseX, mouseY)
            }
            onReleased: {
                doRelease()
            }
            onPositionChanged: {
                doPositionChanged(mouseX, mouseY)
            }
            onDoubleClicked: {
                var index = indexAt(mouseX, mouseY + contentY)
                if (index < 0 || index >= count) {
                    return
                }
                if (cusHeader.xList[1] <= mouseX && mouseX <= cusHeader.xList[2]) {

                    editInput.x = cusHeader.xList[1]
                    editInput.y = cusView.y + (parseInt(mouseY / CusConfig.fixedHeight)) * CusConfig.fixedHeight
                    editInput.width = cusHeader.widthList[1]
                    editInput.height = CusConfig.fixedHeight
                    editInput.index = index
                    var dataObj = deviceAddModel.data(index)
                    editInput.text = dataObj[deviceAddModel.headerRoles[0]]
                    editInput.visible = true
                    editInput.focus = true
                }
            }
            delegate: CusTableRow {
                width: cusView.width
                roles: cusView.model.headerRoles
                dataObj: model.display
                widthList: cusHeader.widthList
                xList: cusHeader.xList
                onCheckedChanged: {
                    deviceAddModel.check(index, checked)
                }
            }
        }
        CusTextField {
            id: editInput
            visible: false
            onEditingFinished: {
                deviceAddModel.doUpdateName(index, text)
                visible = false
            }
            property int index: -1
            onFocusChanged: {
                if (!focus) {
                    deviceAddModel.doUpdateName(index, text)
                    visible = false
                }
            }
        }
        Column {
            x: cusHeader.x + cusHeader.mouseX
            y: cusView.y
            visible: cusHeader.isSpliting && !cusHeader.isOut
            height: cusView.height
            width: 1
            spacing: 2
            Repeater {
                model: (cusHeader.isSpliting
                        && !cusHeader.isOut) ? parent.height / 6 : 0
                Rectangle {
                    width: 1
                    height: 4
                    color: CusConfig.splitLineColor
                }
            }
        }
    }
}

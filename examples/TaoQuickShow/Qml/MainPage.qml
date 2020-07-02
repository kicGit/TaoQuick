import QtQuick 2.12
import "./Page"

import TaoQuick 1.0
import "qrc:/TaoQuick"

Item {
    anchors.fill: parent
    ContentData {
        id: gConfig
        objectName: "gConfig"
    }
    QtObject {
        id: appInfo
        objectName: "appInfo"
        property string appName
        property string appVersion
        property string latestVersion
        property string buildDateTime
        property string buildRevision
        property string copyRight
        property string descript
        property string compilerVendor
    }
    AboutDialog {
        id: aboutDialog

    }
    TitlePage {
        id: titleRect
        width: rootView.width - 2
        height: 60
        color: gConfig.titleBackground
//        TMoveArea {
//            height: parent.height
//            anchors {
//                left: parent.left
//                right: parent.right
//                rightMargin: 200
//            }
//            control: view
//        }
    }
    ContentPage {
        id: contentRect
        width: parent.width
        color: gConfig.background
        anchors.top: titleRect.bottom
        anchors.bottom: parent.bottom
    }
    NotifyBox {
        id: notifyBox
    }
}

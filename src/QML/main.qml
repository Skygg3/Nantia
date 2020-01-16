import QtQuick 2.13
import QtQuick.Controls 1.2
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQuick.Window 2.13
import Qt.labs.platform 1.0

import skydev.nantia 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: document.fileName + " - Nantia"

    Component.onCompleted: {
        x = Screen.width / 2 - width / 2

        y = Screen.height / 2 - height / 2
    }

    Shortcut {
        sequence: StandardKey.Open
        onActivated: openDialog.open()
    }

    MenuBar {
        Menu {
            title: qsTr("&File")

            MenuItem {
                text: qsTr("&Open")
                onTriggered: openDialog.open()
            }
            MenuItem {
                text: qsTr("&Quit")
                onTriggered: Qt.quit()
            }
        }

        Menu {
            title: qsTr("&Help")

            MenuItem {
                text: qsTr("&About")
                onTriggered: {
                    aboutDialog.open()
                }
            }
        }
    }

    AboutDialog {
        id: aboutDialog
        anchors.centerIn: parent
    }

    header : ToolBar {
        width: parent.width
        leftPadding: 8

        Flow {
            id: flow
            width: parent.width

            Row {
                id: fileRow
                ToolButton {
                    id: openButton
                    icon.source: "qrc:/resources/icons/open-file.svg"
                    icon.width: 20
                    icon.height: 20
                    onClicked: openDialog.open()
                }
            }
        }
    }

    footer : StatusBar {
        id: statusBar
        RowLayout {
            anchors.fill: parent
            Label {
                text: qsTr("Importing file ...")
                Layout.alignment: Qt.AlignLeft
            }
            ProgressBar {
                Layout.alignment: Qt.AlignRight
                value: 0.5
            }
        }
    }

    ScrollView {
        id: view
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        TextEdit {
            id: textArea
            leftPadding: 10
            topPadding: 5
            bottomPadding: 5
            anchors.fill: parent
            font.pointSize: 10
        }
    }

    TextHandler {
        id: document
        onLoaded: {
            textArea.text = text
        }
    }

    FileDialog {
        id: openDialog
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 1
        nameFilters: ["Text files (*.txt)"]
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: {
            document.load(file)
        }
    }
}

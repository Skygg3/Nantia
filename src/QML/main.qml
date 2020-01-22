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
    title: textHandler.fileName + " - Nantia"

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
            title: qsTr("&View")

            MenuItem {
                text: qsTr("Switch &Theme")
                onTriggered: openDialog.open()
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
                ToolButton {
                    id: changeThemeButton
                    icon.source: "qrc:/resources/icons/change-theme.png"
                    icon.width: 30
                    icon.height: 30
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: {
            if (wheel.angleDelta.y > 0)
            {
                textViewer.currentLine = Math.max(textViewer.currentLine - textViewer.incrementStep, 1);
            }
            else
            {
                textViewer.currentLine = Math.min(textViewer.currentLine + textViewer.incrementStep, textHandler.numberOfLine());
            }
            textViewer.maxNumberLine = (textViewer.currentLine + parent.height / 30) > textHandler.numberOfLine() ? (textHandler.numberOfLine() - textViewer.currentLine) : parent.height / 30;
        }

        TextViewer {
            id: textViewer
            maxNumberLine: Math.min(parent.height / 30, textHandler.numberOfLine())
        }
    }

    Connections
    {
        target: textHandler
        onThreadStarted:
        {
            statusBarLabel.visible = true;
            progressLabel.visible = true;
            progressBar.visible = true;
            progressLabel.text = "0%";
            progressBar.value = 0;
        }
        onThreadProgress: {
            var progressPercent = Math.round(progress * 100);
            progressLabel.text = progressPercent.toString() + '%'
            progressBar.value = progress;
        }
        onThreadFinished: {
            statusBarLabel.visible = false;
            progressLabel.visible = false;
            progressBar.visible = false;
        }
    }

    footer : StatusBar {
        id: statusBar
        RowLayout {
            width: parent.width
            Label {
                id: statusBarLabel
                visible: false
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Importing file ...")
            }

            Item {
                Layout.fillWidth: true
            }

            Label {
                id: progressLabel
                visible: false
                Layout.alignment: Qt.AlignRight
                rightPadding: 10
            }
            ProgressBar {
                id: progressBar
                rightPadding: 10
                visible: false
                Layout.alignment: Qt.AlignRight
            }
        }
    }

    FileDialog {
        id: openDialog
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 1
        nameFilters: ["Text files (*.txt)"]
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: {
            textHandler.load(file)
        }
    }
}

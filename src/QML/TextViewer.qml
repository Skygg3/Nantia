import QtQuick 2.0
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.12

import skydev.nantia 1.0

Item {
    property int currentLine: 1
    property int maxNumberLine: 0
    property int incrementStep: 5

    id: viewer

    function refresh() {
        currentLine +=1;
        currentLine -= 1;
    }

    function goToFirstLine() {
        currentLine = 2;
        currentLine = 1;
        maxNumberLine = (currentLine + parent.height / 30) > textHandler.numberOfLine() ? (textHandler.numberOfLine() - currentLine) : parent.height / 30;
    }

    RowLayout {
        id: rowLayout
        ColumnLayout {
            spacing: 0
            Repeater {
                model: textHandler.hasFile ? Math.min(currentLine + maxNumberLine, textHandler.numberOfLine()) : 0

                Rectangle {
                    color: "#e4e4e4"
                    Text {
                        text: index + currentLine
                        font.pointSize: 10
                        anchors.centerIn: parent
                    }
                    width: 40
                    height: 30
                }
            }
        }

        ColumnLayout {
            Layout.leftMargin: 10
            Layout.topMargin: 15
            spacing: 0
            width: 100
            Repeater {
                model: textHandler.hasFile ? Math.min(currentLine + maxNumberLine, textHandler.numberOfLine()) : 0

                Rectangle {
                    color: "transparent"
                    Layout.fillWidth: true
                    Text {
                        text: {
                            textHandler.getLine(index + currentLine)
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                    }
                    height: 30
                }
            }
        }
    }
}

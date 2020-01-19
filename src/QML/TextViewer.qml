import QtQuick 2.0
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.12

import skydev.nantia 1.0

Item {
    property int minLine: 5
    property int maxLine: 20

    property int incrementStep: 5

    id: viewer

    RowLayout {
        id: rowLayout
        ColumnLayout {
            spacing: 0
            Repeater {
                model: Math.max(maxLine - minLine + 1, 0)

                Rectangle {
                    color: "#e4e4e4"
                    Text {
                        text: index + minLine
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
                model: Math.max(maxLine - minLine + 1, 0)

                Rectangle {
                    color: "transparent"
                    Layout.fillWidth: true
                    Text {
                        text: {
                            textHandler.getLine(index + minLine)
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

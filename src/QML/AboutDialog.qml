import QtQuick 2.6
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.1

Dialog {
    id: aboutDialog
    modal: true
    standardButtons: Dialog.Ok
    onAccepted: close()

    GridLayout {
        anchors.fill: parent
        columnSpacing: 20
        rowSpacing: 20

        Image {
            source: "qrc:/resources/images/about_img.png"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            fillMode: Image.PreserveAspectFit
            mipmap: true
            sourceSize: Qt.size(width, height)
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                text: "Nantia"
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
            }

            Label {
                text: "<i>" + qsTr("A simple text editor") + "</i>"
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
            }

            Label {
                text: "<b>" + qsTr("License:") + "</b> TBD"
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
            }

            Label {
                text: qsTr("Copyright © 2020 Nantia developers and contributors")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                Layout.preferredWidth: contentWidth
                horizontalAlignment: Qt.AlignHCenter
            }

            Button {
                icon.source: "qrc:/resources/icons/GitHub.png"
                icon.height: 30
                icon.width: 30
                onClicked: Qt.openUrlExternally("https://github.com/Skygg3/Nantia")
                flat: true
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}

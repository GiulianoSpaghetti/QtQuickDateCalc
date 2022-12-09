import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page {
    Settings {
        id: settings
        property string data: "2022-12-25"
    }
    width: window.width
    height: window.height

    title: "QTQuickDateCalc"

    Image {
        id: background
        source: "qrc:///Background.jpg"
        width: parent.width
        height: parent.height
    }

    ColumnLayout {
        width: parent.width
        height: parent.height
        Label {
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Insert the date")
            color: "black"
            Layout.fillWidth: true
        }

        DatePicker {
            id: datePicker
            Component.onCompleted: set(Date.parse(settings.data,
                                                  "yyyy-MM-dd")) // today
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Button {
            text: qsTr("Calculate")
            onClicked: {
                var actual = datePicker.selectedDate
                var now = new Date()
                var data = actual.getTime() - now
                data = Math.floor(data / (1000 * 3600 * 24))
                result.text = qsTr("There are ") + data + qsTr(" days left.")
                settings.setValue("data",
                                  Qt.formatDate(datePicker.selectedDate,
                                                "yyyy-MM-dd"))
                settings.sync
            }
            Layout.fillWidth: true
        }
        Label {
            id: result
            text: qsTr("Press calculate")
            color: "white"
            Layout.fillWidth: true
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Page {
    width: window.width
    height: window.height

    title: qsTr("Informations")
    Image {
        id: background
        source: "qrc:///Background.jpg"
        width: parent.width
        height: parent.height
    }
    ColumnLayout {
        Label {
            text: "© 2022 Giulio Sorrentino"
            color: "black"
            Layout.fillWidth: true
        }
        Label {
            text: "Sotto licenza GPL v3 o, secondo la tua opinione, qualsiasi versione successiva."
            color: "black"
            Layout.fillWidth: true
        }
        Label {
            text: "Pagina del progetto: https://github.com/numerunix/qtquickdatecalc"
            color: "black"
            Layout.fillWidth: true
        }
    }
}

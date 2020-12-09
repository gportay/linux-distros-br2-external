/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2015 Teo Mrnjavac <teo@kde.org>
 *   SPDX-FileCopyrightText: 2018 Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    function nextSlide() {
        console.log("QML Component (default slideshow) Next slide");
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 10000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
        Image {
            id: logo
            source: "logo.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: logo.horizontalCenter
            anchors.top: logo.bottom
            text: "<b>Buildroot</b><br/>"+
                  "Making Embedded Linux Easy"
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        centeredText: qsTr("Buildroot is a simple, efficient and easy-to-use tool to generate embedded Linux systems through cross-compilations.")
    }

    Slide {
        Image {
            id: tux_flat
            source: "tux-flat.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: tux_flat.horizontalCenter
            anchors.top: tux_flat.bottom
            text: "<b>Can handle everything</b><br/>"+
                  "Cross-compilation toolchain, root filesystem generation, kernel image compilation and bootloader compilation."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        Image {
            id: hammer
            source: "hammer.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: hammer.horizontalCenter
            anchors.top: hammer.bottom
            text: "<b>Is very easy</b><br/>"+
                  "Thanks to its kernel-like menuconfig, gconfig and xconfig configuration interfaces, building a basic system with Buildroot is easy and typically takes 15-30 minutes."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        Image {
            id: gift
            source: "gift.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: gift.horizontalCenter
            anchors.top: gift.bottom
            text: "<b>Supports several thousand packages</b><br/>"+
                  "X.org stack, Gtk3, Qt 5, GStreamer, Webkit, Kodi, a large number of network-related and system-related utilities are supported."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        centeredText: qsTr("<b>Buildroot is for Everyone.</b><br/>"+
                           "Has a simple structure that makes it easy to understand and extend. It relies only on the well-known Makefile language.")
    }

    Slide {
        Image {
            id: menuconfig 
            source: "menuconfig.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: menuconfig.horizontalCenter
            anchors.top: menuconfig.bottom
            text: "<b>Buildroot is for Everyone</b><br/>"+
                  "Has a simple structure that makes it easy to understand and extend. It relies only on the well-known Makefile language."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        Image {
            id: xconfig 
            source: "xconfig.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: xconfig.horizontalCenter
            anchors.top: xconfig.bottom
            text: "<b>Buildroot is for Everyone</b><br/>"+
                  "Has a simple structure that makes it easy to understand and extend. It relies only on the well-known Makefile language."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        Image {
            id: nconfig 
            source: "nconfig.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: nconfig.horizontalCenter
            anchors.top: nconfig.bottom
            text: "<b>Buildroot is for Everyone</b><br/>"+
                  "Has a simple structure that makes it easy to understand and extend. It relies only on the well-known Makefile language."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        centeredText: qsTr("Buildroot is an open source project: many developers contribute to it daily.")
    }

    // When this slideshow is loaded as a V1 slideshow, only
    // activatedInCalamares is set, which starts the timer (see above).
    //
    // In V2, also the onActivate() and onLeave() methods are called.
    // These example functions log a message (and re-start the slides
    // from the first).
    function onActivate() {
        console.log("QML Component (default slideshow) activated");
        presentation.currentSlide = 0;
    }

    function onLeave() {
        console.log("QML Component (default slideshow) deactivated");
    }

}

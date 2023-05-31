# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import os
from pathlib import Path
import sys
from PySide6.QtCore import QCoreApplication, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
import ShutDown




if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    QQuickStyle.setStyle("Fusion")
    engine = QQmlApplicationEngine()
    qml_file = os.fspath(Path(__file__).resolve().parent / 'mainwindow.qml')
    engine.load(QUrl.fromLocalFile(qml_file))

    rootObjects = engine.rootObjects()
    #root.textRotationChanged.connect(sayThis)
    #mainwindow=rootObjects[0]
    #mainwindow.setClicked.connect(getTimeSet)

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
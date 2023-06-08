import os,sys,time
from pathlib import Path
from typing import Optional
from PySide6.QtCore import QObject, QUrl, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtQml import QmlElement

# To be used on the @QmlElement decorator
# (QML_IMPORT_MINOR_VERSION is optional)
QML_IMPORT_NAME = "ShutDownWin10"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class Win10ShutDown(QObject):
    def __init__(self) -> None:
        super().__init__()
    
    @Slot(result=int)
    def countOnce(self,counts:int):
        print(counts-1)
        return counts-1
    
    @Slot(str,result=int)
    def getTimeSet(self,timestring:str):
        print(timestring.split(":"))
        hh,mm,ss=timestring.split(":")
        Total_seconds=int(hh)*3600+int(mm)*60+int(ss)
        print(Total_seconds)
        return Total_seconds
    
    @Slot()
    def shutdown(self):
        print('shut down now')
        os.system('shutdown -s -f -t 1')
        #time.sleep(1000)
        #self.close()
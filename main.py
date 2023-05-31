import PySide6,sys
from PySide6.QtWidgets import QWidget, QApplication, QMainWindow
    
from Auto_shutdown_win10 import *

"""Main entrance  

Start Project program
"""
"""
for bat file:

@echo off
E:
cd E:\Coding\Eline20U_Control\Counter_Energy_plot
start python main.py
pause

"""

if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = Win10Shutdown()
    win.show()
    sys.exit(app.exec())
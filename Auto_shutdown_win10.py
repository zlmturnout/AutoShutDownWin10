import sys, os, time
from PySide6.QtWidgets import QWidget, QPushButton, QApplication, QMainWindow, QGridLayout, QLabel, QToolBar
from PySide6.QtCore import Qt, QTimer, Slot, QThread, Signal, QTime
from PySide6 import QtCore, QtWidgets
from PySide6.QtGui import QPixmap, QImage, QIcon,QAction
from PySide6.QtWidgets import  QStatusBar, QFileDialog, QGraphicsPixmapItem, QGraphicsView, QGraphicsScene
from UI.UI_Auto_shutdown import Ui_MainWindow


class Win10Shutdown(QMainWindow, Ui_MainWindow):

    def __init__(self, parent=None):
        super(Win10Shutdown, self).__init__()
        self.setupUi(self)
        self.setWindowTitle("My Win10 auto shutdown")
        # self.setWindowFlags(Qt.FramelessWindowHint)
        #self.desktop = QApplication.desktop()
        #self.screenRect = self.desktop.screenGeometry()
        #self.height = self.screenRect.height()
        #self.width = self.screenRect.width()

        self._countdown_num = 10000
        self._setTime = QTime(0, 0)
        self._delay_t = 1000
        self._timer = QTimer(self)
        self._cur_timer = QTimer(self)
        self._cur_timer.timeout.connect(self.set_cur_time)
        self._cur_timer.start(1000)
        # count down flag
        self._countdown_on=False
        self._count_stopped=False

    def set_cur_time(self):
        t_stamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        self.Now_time.setText(t_stamp)

    @Slot()
    def on_Timeset_clicked(self):
        self._setTime = self.timeEdit.time()
        # get the offset seconds
        self._countdown_num = QTime(0, 0).secsTo(self._setTime)
        print(self._countdown_num)
        self.lcdNumber.display(self._countdown_num)
        self._countdown_on = True
        self._stopped_flag = False
        self._timer.start(self._delay_t)  # 1s
        self._timer.timeout.connect(self.set_countdown)


    def set_countdown(self):
        if self._countdown_on:
            self._countdown_num -= 1
            self.lcdNumber.display(self._countdown_num)
        if self._countdown_num == 0:
            self.shutdown()


    @Slot()
    def on_Stopcount_clicked(self):
        if self._countdown_on:
            self._countdown_on = False
            self._timer.timeout.disconnect(self.set_countdown)
            self.Stopcount.setText("Resume")
            self._count_stopped=True
        elif self._count_stopped:
            self._countdown_on = True
            self._count_stopped = False
            self._timer.timeout.connect(self.set_countdown)
            self.Stopcount.setText("STOP")


    def shutdown(self):
        print('shut down now')
        os.system('shutdown -s -f -t 1')
        time.sleep(1000)
        self.close()


if __name__ == "__main__":
    img_path = "F:\\Images\\"
    app = QApplication(sys.argv)
    window = Win10Shutdown()
    window.show()
    app.exec_()

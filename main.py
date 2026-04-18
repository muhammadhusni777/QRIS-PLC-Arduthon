######  PROGRAM MEMANGGIL WINDOWS PYQT5 ##########################

####### memanggil library PyQt5 ##################################
#----------------------------------------------------------------#
from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import * 

from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *  
import sys
import time
import random
from datetime import datetime
import threading

from qrispy import Mayar
import requests
from PIL import Image
from io import BytesIO
import matplotlib.pyplot as plt
import numpy as np


# Initialize the API client with your Mayar API Key

api = Mayar("")

time_now = datetime.now()
id_order = ""
payment_link = ""


espresso = 0
espresso_time = 0
milk = 0
milk_time = 0
foam = 0
foam_time = 0

success_pay = 0

vending_balance = 0
balance_prev = 0

show_qr = 0
boot = 0
#----------------------------------------------------------------#

class Worker(QThread):
    state_updated = pyqtSignal(float) 
    
    def __init__(self):
        super().__init__()
        self.running = True
        
    def run(self):
        global balance
        while self.running:
            global vending_balance
            global balance_prev
            global success_pay
            global show_qr
            global boot
            balance = api.balance()
            
            
            if balance.status_code == 200:
                vending_balance = balance.balance
                
                if (boot == 0):
                    balance_prev = balance.balance
                    boot = 1
                    
                #print(f"Balance: {vending_balance}")
            else:
                print(f"Error: {balance.message}")
            
            
            if (vending_balance != balance_prev):
                if (int(vending_balance - balance_prev) == int(price)):
                    success_pay = 1
                    print("BERHASIL")
                    show_qr = 0
            balance_prev = vending_balance
            time.sleep(1)
                
           



########## mengisi class table dengan instruksi pyqt5#############
#----------------------------------------------------------------#
class table(QObject):    
    def __init__(self, parent = None):
        super().__init__(parent)
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine(self)
        self.engine.rootContext().setContextProperty("backend", self)    
        self.engine.load(QUrl("main.qml"))
        
        self.worker = Worker()
        self.worker.state_updated.connect(self.update_state)
        self.worker.start()
        
        
        sys.exit(self.app.exec_())
    
    
    @pyqtSlot(float)
    def update_state(self, price):
        pass
    
    @pyqtSlot(str)
    def cancel_payment (self, status):
        global show_qr
        show_qr = 0
    
    @pyqtSlot(str)
    def bayar (self, status):
        global show_qr
        print("yang harus dibayar : ", price)
        
        qris = api.create_qris(price)  # amount in rupiah
        if qris.status_code == 200:
            print(qris.url)  # QRIS image URL
            url = qris.url
            
            r = requests.get(url, timeout=10)
            if r.status_code != 200:
                raise Exception("Gagal download")

            if "image" not in r.headers.get("Content-Type", ""):
                raise Exception("Bukan gambar")
            
            # ================= LOAD IMAGE =================
            img = Image.open(BytesIO(r.content))

            # ================= CONVERT =================
            img = img.convert("L")  # grayscale

            # ================= RESIZE =================
            img = img.resize((400, 400))
            
            img_array = np.array(img)
            
            bw = np.array(img)
            bw = (bw > 128).astype(np.uint8) * 255  # 0 atau 255 (biar valid PNG)

            # ================= SAVE BINARY =================
            img_bw = Image.fromarray(bw)
            img_bw.save("qr_binary.png")
            print("Saved: qr_binary.png (black-white)")

            
            show_qr = 1
            
            
        else:
            print(f"Error: {qris.message}")
            
        
        
        
        
        
        
        
    @pyqtSlot(result=str)
    def vending_balance(self): return str(vending_balance)
    
    @pyqtSlot(result=str)
    def payment_link(self): return payment_link
    
    @pyqtSlot(result=str)
    def foam_time(self): return str(foam_time)
    
    @pyqtSlot(result=str)
    def espresso_time(self): return str(espresso_time)
    
    @pyqtSlot(result=str)
    def milk_time(self): return str(milk_time)
    
    @pyqtSlot(result=str)
    def show_qr(self): return str(show_qr)
    
    
    @pyqtSlot(int, int, int)
    def recipe (self, recipe1, recipe2, recipe3):
        global espresso
        global milk
        global foam
        
        espresso = recipe1
        milk = recipe2
        foam = recipe3
        
    @pyqtSlot(str)
    def price(self, value):
        global price
        price = float(value)
        
        #print(price)
        
    
    

        
#----------------------------------------------------------------#

########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":  
    main = table()
    
    
#----------------------------------------------------------------#

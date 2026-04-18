import QtQuick 2.15
import QtQuick.Window 2.15
import QtWebEngine 1.9
import QtQuick 2.15
import QtQuick.Controls 2.15

import QtQuick 2.12
import QtQuick.Window 2.13
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Window {
    width: 900
    height: 630
	maximumWidth : 900
	minimumWidth : 900
	maximumHeight : 630
	minimumHeight : 630
    visible: true
	color : "black"

    // property supaya url bisa diganti-ganti
    
	property int total_payment : 0;
	property var coffee_type : ""
	property var color1 : "white"
	property var color2 : "white"
	property var pesanan: ({})  // kosong dulu


	
	
	Image{
		x : 20
		y : 10
		width : 60
		height : 60
		source : "outseal_white.png"
	
	}


	Text{
	//anchors.horizontalCenter: parent.horizontalCenter
	x : 100
	y:0
	text : "ARDUMEKA CAFE"
	color : color1
	font.pixelSize : 30
	font.bold : true
	}
	
	Text{
	//anchors.horizontalCenter: parent.horizontalCenter
	x : 100
	y:40
	text : "PLC Vending Machine Payment Gateway Simulation"
	color : color1
	font.pixelSize : 15
	visible : true
	}
	
	Text{
	//anchors.horizontalCenter: parent.horizontalCenter
	x : 100
	y:70
	text : "Written by : Muhammad Husni Muttaqin"
	color : color1
	font.pixelSize : 15
	}
	
	
	
	Rectangle {
		x : 30
		y : 100
		width : 500
		height : 450
		color : "transparent"
		border.color : color1
		border.width : 3
		
		Button {
		id : macchiato
		x : 20
		y : 10
		
		width : 200
		height : 200
		checkable : true
		
		Image{
		width : parent.width - 5
		height : parent.height - 5
		source : "macchiato.png"
		
		}
		
		
		onClicked:{
			latte.checked = false
			cappucino.checked = false
			flat_white.checked = false
			total_payment = 30;
			
			backend.recipe(5, 20, 0)  //espresso, milk, foam
			espresso_gauge.maximumValue = 5;
			milk_gauge.maximumValue = 20;
			foam_gauge.maximumValue = 0;
			coffee_type = "machiatto"
		
		}
		
		
		}
		
		
		Button {
		id : latte
		x : 280
		y : 10
		
		width : 200
		height : 200
		checkable : true
		
		
		Image{
		width : parent.width - 5
		height : parent.height - 5
		source : "latte.png"
		
		}
		
		onClicked:{
			macchiato.checked = false
			cappucino.checked = false
			flat_white.checked = false
			total_payment = 20;
			backend.recipe(20, 20, 10)  //espresso, milk, foam
			espresso_gauge.maximumValue = 20;
			milk_gauge.maximumValue = 20;
			foam_gauge.maximumValue = 10;
			coffee_type = "latte"
		
		}
		
		}
		
		
		Button {
		id : cappucino
		x : 20
		y : 230
		width : 200
		height : 200
		checkable : true
		
		Image{
		width : parent.width - 5
		height : parent.height - 5
		source : "cappucino.png"
		
		}
		
		
		onClicked:{
			latte.checked = false
			macchiato.checked = false
			flat_white.checked = false
			total_payment = 25;
			
			backend.recipe(10, 5, 10)  //espresso, milk, foam
			
			espresso_gauge.maximumValue = 10;
			milk_gauge.maximumValue = 5;
			foam_gauge.maximumValue = 10;
			coffee_type = "cappucino"
		
		}
		
		}
		
		Button {
		id : flat_white
		x : 280
		y : 230
	
		width : 200
		height : 200
		checkable : true
		
		Image{
		width : parent.width - 5
		height : parent.height - 5
		source : "flat_white.png"
		
		}
		
		
		onClicked:{
			latte.checked = false
			cappucino.checked = false
			macchiato.checked = false
			total_payment = 23;
			backend.recipe(15, 15, 0)  //espresso, milk, foam
			espresso_gauge.maximumValue = 15;
			milk_gauge.maximumValue = 15;
			foam_gauge.maximumValue = 0;
			coffee_type = "flat white"
		
		}
		
		}
		
	
	Item {
        
        anchors.fill: parent
        width: root.width
        height: root.height
		visible : false

        

	
	
	}	

	}
	
	
	Rectangle {
	x : 550
    width : 350
	height : 630
	color : "transparent"
	border.color : color1
	border.width : 3
	
	Text{
		//anchors.horizontalCenter: parent.horizontalCenter
		//anchors.verticalCenter: parent.verticalCenter
		id : balance
		x : 5
		y:20
		text : "Balance : Rp."
		color : color1
		font.pixelSize : 18
		font.bold : false
		}
		
	StatusIndicator{
		id : machine_status
		x : 270
		y : 15
		width : 40
		height : 40
		active: true
		color : "red"
		
	}
					
					
	Gauge {
		id : milk_gauge
		x: 20
		y: 50
		height : 250
		width : 250
		minimumValue: 0
		value: 0
		maximumValue: 10
		tickmarkStepSize: 1
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "#79AEF2"
				implicitWidth: 50
			}
		}
		
		Text{
			x : 30
			y : 250
			text : "MILK"
			color : "white"
			font.pixelSize : 16
			
		}
	}
	
	
	Gauge {
		id : espresso_gauge
		x: 120
		y: 50
		height : 250
		width : 250
		minimumValue: 0
		value: 0
		maximumValue: 10
		tickmarkStepSize: 1
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "#A64B17"
				implicitWidth: 50
			}
		}
		
		Text{
			x : 30
			y : 250
			text : "ESPRESSO"
			color : "white"
			font.pixelSize : 16
			
		}
	}
	
	
	Gauge {
		id : foam_gauge
		x: 240
		y: 50
		height : 250
		width : 250
		minimumValue: 0
		value: 0
		maximumValue: 10
		tickmarkStepSize: 1
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "#F2F2F2"
				implicitWidth: 50
			}
		}
		
		Text{
			x : 30
			y : 250
			text : "FOAM"
			color : "white"
			font.pixelSize : 16
			
		}
	}
	
	
	Rectangle{
		y: 320
		width : 300
		height : 300
		anchors.horizontalCenter: parent.horizontalCenter
		border.width : 3
		border.color : "white"
		color : "transparent"
		
		Text{
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			text : "QRIS"
			color : "white"
			font.pixelSize : 16
			
		}
	Image{
		id : img_result
		width : parent.width
		height : parent.height
		visible : false
		source : "image_update1.png"
		
		 
		
	}
	
	}
	
	}



    Rectangle {
        x : 250
		y : 550
		width: 100
        height: 40
        //anchors.bottom: parent.bottom
        //anchors.horizontalCenter: parent.horizontalCenter
        color: "lightblue"

        Text {
            anchors.centerIn: parent
            text: "BAYAR"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
				backend.bayar("yes")
            }
        }
    }
	
	
	Rectangle {
        x : 400
		y : 550
		width: 100
        height: 40
        //anchors.bottom: parent.bottom
        //anchors.horizontalCenter: parent.horizontalCenter
        color: "pink"

        Text {
            anchors.centerIn: parent
            text: "cancel"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
				backend.cancel_payment("yes")
            }
        }
    }
	
	
	
	Text{
					id : total_payment_text
					
					x : 30
					y:550
					text : "Total Pembayaran : "
					color : color1
					font.pixelSize : 20
					font.bold : false
					}
		

	property string latestUrl: ""
	Timer {
    interval: 1000 
    repeat: true
    running: true
	


    onTriggered: {
		balance.text = "Balance : Rp." + backend.vending_balance()
		foam_gauge.value = backend.foam_time()
		milk_gauge.value = backend.milk_time()
		espresso_gauge.value = backend.espresso_time()
		
		backend.price(total_payment)
		
		//console.log(coffee_type)
		
		img_result.source = "qr_binary.png?" + new Date().getTime();
		
		if (backend.show_qr() == "1"){
			img_result.visible = true
		} else {
			img_result.visible = false
			total_payment_text.text = "Total Pembayaran : \n Rp." + total_payment + "\nItem : "+coffee_type
		
		}
	
	}
	
	}
	
	Timer {
    id: checkpayment
    interval: 3000 
    repeat: true
    running: true
	
	onTriggered:{
		
		//backend.check_payment("yes")
		
	}
	}
}

package Menu {
	import flash.utils.Timer;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import Events.*;
	
	public class ConnectMenu extends MenuItem {
		private var pingTimer:Timer;
		private var pingList:Array;
		private var latency:latencyMeter;

		public function ConnectMenu(m_x:int, m_y:int, p:String){
			super();
						
			setup(m_x, m_y, p);
			skin();
			width=120;
			
			latency=new latencyMeter();
			latency.y=height/2;
			latency.x=10;
			latency.mouseEnabled=false;
			latency.dot1.mouseEnabled=false;
			latency.dot2.mouseEnabled=false;
			latency.dot3.mouseEnabled=false;
			latency.dot4.mouseEnabled=false;
			latency.dot5.mouseEnabled=false;
			addChild(latency);
			
			pingList=new Array(10);
			pingTimer=new Timer(1000);
			pingTimer.addEventListener(TimerEvent.TIMER, sendPing);
			
			disconnected();
			
			addEventListener(Event.CHANGE, Selected);			
		}
		
		private function sendPing(event:TimerEvent){
			var ping=new Ping("sneezymud.com", 80);
			ping.addEventListener(PingEvent.PING, updatePing);
			ping.addEventListener(PingEvent.FAILED, updateFailedPing);
			ping.send();
		}
		private function updateFailedPing(event:PingEvent){
			pingList.shift();
			pingList.push(event.timer.currentCount);
			latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);			
		}
		private function updatePing(event:PingEvent){
			pingList.shift();
			pingList.push(event.timer.currentCount);
						
			var avg=getPingAvg();
			
			if(avg >= 200){
				latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
				latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
				latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
				latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
				latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
			} else if(avg >= 150){
				latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
				latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
				latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
				latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
				latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);				
			} else if(avg >= 100){
				latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 0, 0);
				latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 0, 0);
				latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 0, 0);
				latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
				latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
			} else if(avg >= 50){
				latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 32, 32, 32, 0);
			} else {
				latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
				latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);				
			}
		}
		private function getPingAvg(){			
			var avg=0;
			var count=0;
			for(var i=0;i<pingList.length;++i){
				if(pingList[i] != undefined){
					avg+=pingList[i];
					count++;
				}
			}
			return int(avg / count);
		}
		
		private function Selected(event:Event){
			if(selectedItem.data=="Connect"){
				dispatchEvent(new MenuConnectionEvent(MenuConnectionEvent.CONNECT));
				connected();
			} else if(selectedItem.data=="Disconnect"){
				dispatchEvent(new MenuConnectionEvent(MenuConnectionEvent.DISCONNECT));
				disconnected();
			}
			
			selectedIndex=-1;
		}

		public function connected(){
			prompt=" ";
			pingTimer.start();
			latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
			latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
			latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
			latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
			latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 255, 0, 0);
			
			removeAll();
			addItem({label:"Disconnect", data:"Disconnect"});			
		}
		
		public function disconnected(){			
			prompt=" ";
			pingTimer.stop();
			latency.dot1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot2.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot3.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			latency.dot5.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
			
			removeAll();
			addItem({label:"Connect", data:"Connect"});							
		}
		
	}
}
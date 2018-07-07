package {
	import flash.utils.Timer;
	import flash.net.Socket;
	import flash.events.*;
	import Events.*;
	
	public class Ping extends EventDispatcher {
		private var socket:Socket;
		private var timer:Timer;
		private var address:String;
		private var port:int;
		
		public function Ping(a:String, p:int){
			address=a;
			port=p;
		}
		
		public function send(){
			socket=new Socket();
			timer=new Timer(1);

			socket.addEventListener(Event.CONNECT, pingEnd);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);

			timer.start();
			socket.connect(address, port);
		}
		
		private function pingEnd(event:Event){
			timer.stop();
			socket.close();
			dispatchEvent(new PingEvent(timer, PingEvent.PING));
		}
		
		private function ioError(event:IOErrorEvent){
			timer.stop();
			socket.close();
			dispatchEvent(new PingEvent(timer, PingEvent.FAILED));
		}
		
		private function securityError(event:SecurityErrorEvent){
			timer.stop();
			socket.close();
			dispatchEvent(new PingEvent(timer, PingEvent.FAILED));			
		}
	}
}
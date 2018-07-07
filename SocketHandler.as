package {
	import flash.net.Socket;
	import flash.events.*;
  import flash.display.MovieClip;
	import flash.utils.ByteArray;
	import flash.text.*;
	import Events.*;

	public class SocketHandler extends EventDispatcher {		
		var socket:Socket;
		var host:String;
		var port:int;
		
		var buffer:ByteArray=new ByteArray();
	
		public function SocketHandler(){
			XML.ignoreWhitespace=false;

			socket=new Socket();
			setupListeners();
			Connect();
		}
		
		private function Connect(){
			if(socket.connected)
				Disconnect();
			
			socket.connect("sneezymud.com", 7901);			
		}
		private function Disconnect(){
			if(socket.connected)
				socket.close();
		}
		
		private function setupListeners(){
			socket.addEventListener(Event.CLOSE, closeHandler);
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
		}
		
		public function sendInput(buf:String){
			if(socket.connected){
				socket.writeMultiByte(buf + "\n", "UTF-8");
				socket.flush();
			}
		}
		
		public function menuDisconnectHandler(event:MenuConnectionEvent){
			Disconnect();
		}
		public function menuConnectHandler(event:MenuConnectionEvent){
			Connect();
		}
		
		private function closeHandler(event:Event){
			dispatchEvent(new SocketConnectionEvent(SocketConnectionEvent.DISCONNECTED));
		}

		private function connectHandler(event:Event){
			dispatchEvent(new SocketConnectionEvent(SocketConnectionEvent.CONNECTED));
		}
		
		private function hasCompleteXML():Boolean{
			for(var i=buffer.position;i<buffer.length;++i){
				if(buffer[i]==0){
					return true;
				}
			}
		
			return false;
		}
		
		private function dataHandler(event:ProgressEvent){
			// grab the new data
			socket.readBytes(buffer, buffer.length);
		
			var b:int;
			var xmlBuffer:String="";
		
			while(hasCompleteXML()){
				while(b=buffer.readUnsignedByte()){
				// telnet commands
					if(b == 255){
						TelnetCodeHandler();
						continue;
					}
	
					// ANSI command				
					if(b == 27){
						ANSICodeHandler();
						continue;
					}
					if(b != 13)
						xmlBuffer+=String.fromCharCode(b);
				}
		
				dispatchEvent(new SocketXMLEvent(new XML(xmlBuffer), SocketXMLEvent.SOCKET_XML));
				xmlBuffer="";
			}			
		}


		private function TelnetCodeHandler(){
			var cmd:int = buffer.readUnsignedByte();
			var opt:int = buffer.readUnsignedByte();
					
			if(cmd==251 && opt==1){
				dispatchEvent(new SocketPasswordEvent(true, SocketPasswordEvent.SOCKET_PASSWORD));
			} else if(cmd==252 && opt==1){
				dispatchEvent(new SocketPasswordEvent(false, SocketPasswordEvent.SOCKET_PASSWORD));
			}
		}
		
		private function ANSICodeHandler(){
			var bracket:int = buffer.readUnsignedByte();
			var buf:String;
			var i:int;
			while((i=buffer.readUnsignedByte())){
				if((i>=48 && i<=57) || i==59)
					buf += String.fromCharCode(i);
				else
					break;
			}
			// 109=="m" is ansi code for color

			trace("found ansi code: "+i);
		}
		
	}
}
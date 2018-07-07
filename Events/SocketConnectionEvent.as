package Events {
	import flash.events.Event;
	
	public class SocketConnectionEvent extends Event{
		static public var CONNECTED:String = "Connected";
		static public var DISCONNECTED:String= "Disconnected";
		
		public function SocketConnectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles,cancelable);
		}
	}
}
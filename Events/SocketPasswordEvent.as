package Events {
	import flash.events.Event;
	
	public class SocketPasswordEvent extends Event{
		static public var SOCKET_PASSWORD:String = "SocketPassword";
		public var password:Boolean;
			
		public function SocketPasswordEvent(p:Boolean, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles,cancelable);
			password=p;
		}
	}
}
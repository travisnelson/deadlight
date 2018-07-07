package Events {
	import flash.events.Event;
	
	public class MenuConnectionEvent extends Event{
		static public var CONNECT:String = "Connected";
		static public var DISCONNECT:String= "Disconnected";
		
		public function MenuConnectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles,cancelable);
		}
	}
}
package Events {
	import flash.events.Event;
	import flash.utils.Timer;
	import Windows.Window;
	
	public class PingEvent extends Event{
		static public var PING:String = "Ping";
		static public var FAILED:String = "Failed";
		public var timer:Timer;
			
		public function PingEvent(t:Timer, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles,cancelable);
			timer=t;
		}
	}
}
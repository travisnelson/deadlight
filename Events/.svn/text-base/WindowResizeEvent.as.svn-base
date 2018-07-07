package Events {
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class WindowResizeEvent extends Event{
		static public var RESIZE:String = "Resize";
		public var rect:Rectangle;

		public function WindowResizeEvent(r:Rectangle, type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles,cancelable);
			rect=r;
		}
	}
}
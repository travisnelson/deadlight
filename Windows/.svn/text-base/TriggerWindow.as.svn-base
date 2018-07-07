package Windows {
	import flash.display.Sprite;
	import flash.text.*;
	import fl.controls.*;
	import fl.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.*;
	import Events.*;

	public class TriggerWindow extends DataInputWindow {
		public function TriggerWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			super(title, m_x, m_y, w,h, v);
			
			dataGrid.getColumnAt(0).headerText="Trigger";
			dataGrid.getColumnAt(1).headerText="Action";
			
			// triggers are wide
			dataGrid.getColumnAt(0).width=200;
		}
		
		override public function get newDataLabel(){
			return "<New Trigger>";
		}
	}
}
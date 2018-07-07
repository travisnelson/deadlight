package Menu {
	import flash.events.*;
	import flash.net.SharedObject;
	
	public class WindowMenu extends MenuItem {
		public function WindowMenu(m_x:int, m_y:int, p:String){
			super();
						
			setup(m_x, m_y, p);
			skin();
			
			width=120;
			rowCount=10;

			addEventListener(Event.CHANGE, windowSelected);
		}
		
		private function windowSelected(event:Event){
			var so=SharedObject.getLocal("deadlight");
			so.data[selectedItem.data.titleLabel.text+".visible"]=true;
			selectedItem.data.visible=true;
			selectedItem.data.bringToFront();
			selectedIndex=-1;
		}
		
	}
}
package Windows {
	import flash.display.Sprite;
	import flash.text.*;
	import fl.controls.*;
	import fl.controls.dataGridClasses.DataGridColumn;	
	import fl.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.*;
	import flash.net.*;
	import Events.*;

	public class DataInputWindow extends DataWindow {
		public function DataInputWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			super(title, m_x, m_y, w,h,v );
			updateNewEntry();
			dataGrid.addEventListener(DataGridEvent.ITEM_EDIT_END, updateNewEntryHandler);
		}	
		
		public function get newDataLabel(){
			return "<New Data>";
		}

		protected function updateNewEntryHandler(event:DataGridEvent){
			updateNewEntry();
		}

		private function updateNewEntry(){
			var found=false;

			for each (var item in dataList){
				if(item.name=="")
					dataGrid.dataProvider.removeItem(item);
				else if(item.name==newDataLabel)
					found=true;			
			}
			if(!found)
				addDataItem(newDataLabel, "");
			
			saveData();
		}
		
	}
}
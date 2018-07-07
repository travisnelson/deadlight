package Windows {
	import flash.display.Sprite;
	import flash.text.*;
	import fl.controls.*;
	import fl.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.*;
	import flash.net.*;
	import Events.*;
	import Style.*;

	public class DataWindow extends Window {
		public var dataList:Array;
		public var dataGrid:DataGrid;
		
		public function DataWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			super(title, m_x, m_y, w,h, v);

			dataList=new Array();
		
			var coords=getInteriorCoords();

			dataGrid = new DataGrid();
			dataGrid.setStyle("headerTextFormat",DeadlightStyle.getTextFormatMenu());
			dataGrid.setStyle("skin", DataGrid_skinCustom);
			dataGrid.setStyle("headerUpSkin", HeaderRenderer_upSkinCustom);
			dataGrid.alpha=0.8;
			dataGrid.editable=true;
			dataGrid.resizableColumns=true;
      dataGrid.move(coords.x+1,coords.y+1);
      dataGrid.setSize(coords.width-2,coords.height-2);
      dataGrid.columns = ["name", "data"];
			dataGrid.getColumnAt(0).width=100;
			for each (var item in dataList){
				dataGrid.addItem(item);
			}
			
      addChild(dataGrid);
	
			loadData();

			dataGrid.addEventListener(DataGridEvent.ITEM_EDIT_END, saveHandler);
			dataGrid.addEventListener(MouseEvent.MOUSE_DOWN, bringToFrontHandler);
			addEventListener(WindowResizeEvent.RESIZE, resizeHandler);
		}

		public function addDataItem(n:String, d:String){
			var item={name:n,data:d};
			dataList.push(item);
			dataGrid.addItem(item);
			saveData();
		}
	
	  // save data in a shared object, name is title of window
		protected function loadData(){
			var so=SharedObject.getLocal("deadlight");
			for each (var item in so.data[titleLabel.text]){
				addDataItem(item.name, item.data);
			}
		}
		
		private function saveHandler(event:DataGridEvent){
			saveData();
		}
		
		protected function saveData(){
			var so=SharedObject.getLocal("deadlight");
			
			so.data[titleLabel.text]=new Array();
			for each (var item in dataGrid.dataProvider.toArray()){
				so.data[titleLabel.text].push(item);
			}
		}		
		
		private function resizeHandler(event:WindowResizeEvent){
			resize(event.rect);
		}
		
		protected function resize(rect:Rectangle){
			var coords=getInteriorCoords();
      dataGrid.setSize(coords.width-2,coords.height-2);
		}


	}
}
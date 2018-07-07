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
	import flash.ui.*;
	import Events.*;

	public class KeypressWindow extends DataWindow {
		public var keyNames:Array;
		
		public function KeypressWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			super(title, m_x, m_y, w,h,v );

			dataGrid.getColumnAt(0).headerText="Keypress";
			dataGrid.getColumnAt(0).editable=false;
			dataGrid.getColumnAt(1).headerText="Action";

			keyNames=new Array();
			keyNames.push({name:"Numpad 0",key:Keyboard.NUMPAD_0});
			keyNames.push({name:"Numpad 1",key:Keyboard.NUMPAD_1});
			keyNames.push({name:"Numpad 2",key:Keyboard.NUMPAD_2});
			keyNames.push({name:"Numpad 3",key:Keyboard.NUMPAD_3});
			keyNames.push({name:"Numpad 4",key:Keyboard.NUMPAD_4});
			keyNames.push({name:"Numpad 5",key:Keyboard.NUMPAD_5});
			keyNames.push({name:"Numpad 6",key:Keyboard.NUMPAD_6});
			keyNames.push({name:"Numpad 7",key:Keyboard.NUMPAD_7});
			keyNames.push({name:"Numpad 8",key:Keyboard.NUMPAD_8});
			keyNames.push({name:"Numpad 9",key:Keyboard.NUMPAD_9});
			keyNames.push({name:"Numpad +",key:Keyboard.NUMPAD_ADD});
			keyNames.push({name:"Numpad -",key:Keyboard.NUMPAD_SUBTRACT});
			keyNames.push({name:"Numpad *",key:Keyboard.NUMPAD_MULTIPLY});
			keyNames.push({name:"Numpad /",key:Keyboard.NUMPAD_DIVIDE});

			
			for each(var item in keyNames){
				addKey(item.name);
			}
			addEventListener(Event.ADDED, addedToStage);

		}		

		private function addedToStage(event:Event){
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressUpHandler);
		}

		private function getKeyAction(name:String){
			for each (var item in dataList){
				if(item.name==name)
					return item.data;
			}
			return "";
		}
		
		private function keyPressUpHandler(event:KeyboardEvent){
			if(event.target.parent is TextInput)
				event.target.parent.editable=true;
		}

		private function keyPressHandler(event:KeyboardEvent){
			var action;

			for each(var item in keyNames){
				if(item.key == event.keyCode &&
					 (action=getKeyAction(item.name)) != ""){
					if(event.target.parent is TextInput){
						event.target.parent.editable=false;
						dispatchEvent(new InputEvent(action, InputEvent.INPUT));
					}
				}
			}
		}

		private function addKey(name:String){
			var found=false;
			for each (var item in dataList){
				if(item.name==name)
					return;
			}
			
			addDataItem(name, "");
		}
		
	}
}
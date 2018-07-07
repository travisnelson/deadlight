package Menu {
	import flash.display.Sprite;
	import flash.text.*;
	import fl.controls.*;
	import flash.events.*;
	import flash.geom.*;
	import Windows.*;
	import Events.*;
	
	public class MenuBar extends Sprite {
		public var windowMenu:WindowMenu;		
		public var connectMenu:ConnectMenu;
		public var adminMenu:WindowMenu;

		public function MenuBar(){
			connectMenu=new ConnectMenu(0, 0, "Disconnected");
			addChild(connectMenu);

			windowMenu=new WindowMenu(connectMenu.width, 0, "Window");
			addChild(windowMenu);

			adminMenu=new WindowMenu(connectMenu.width+windowMenu.width, 0, "Admin");
			addChild(adminMenu);
			
			addEventListener(Event.ADDED, addedToStage);			
		}

		public function connectMenuHandler(event:Event){
			if(event.type == SocketConnectionEvent.CONNECTED){
				connectMenu.connected();
			} else if(event.type == SocketConnectionEvent.DISCONNECTED){
				connectMenu.disconnected();
			}
		}

		public function addAdminItem(lbl:String, window:Window){
			adminMenu.addItem({label:lbl,data:window});
		}

		public function addWindowItem(lbl:String, window:Window){
			windowMenu.addItem({label:lbl,data:window});
		}

		private function drawBar(){
			graphics.beginFill(0x202020);
			graphics.drawRect(0,0,stage.stageWidth,22);
			graphics.endFill();
		}

		private function resizeHandler(event:Event){
			drawBar();
		}

		private function addedToStage(event:Event){
			stage.addEventListener(Event.RESIZE, resizeHandler);			
			drawBar();
		}
		
	}
}
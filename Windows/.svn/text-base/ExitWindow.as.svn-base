package Windows {
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import Events.*;

	public class ExitWindow extends Window {
		private var compass;
		
		public function ExitWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			super(title, m_x, m_y, w,h, v);
		
			compass=new CompassRose();
			addChild(compass);

			resize(getInteriorCoords());
			addEventListener(WindowResizeEvent.RESIZE, resizeHandler);
			compass.addEventListener(MouseEvent.MOUSE_DOWN, clickMove);
		}
		
		private function clickMove(event:MouseEvent){		
			if(event.target==compass.north)
				dispatchEvent(new InputEvent("north", InputEvent.INPUT));
			else if(event.target==compass.northeast)
				dispatchEvent(new InputEvent("northeast", InputEvent.INPUT));
			else if(event.target==compass.east)
				dispatchEvent(new InputEvent("east", InputEvent.INPUT));
			else if(event.target==compass.southeast)
				dispatchEvent(new InputEvent("southeast", InputEvent.INPUT));
			else if(event.target==compass.south)
				dispatchEvent(new InputEvent("south", InputEvent.INPUT));
			else if(event.target==compass.southwest)
				dispatchEvent(new InputEvent("southwest", InputEvent.INPUT));
			else if(event.target==compass.west)
				dispatchEvent(new InputEvent("west", InputEvent.INPUT));
			else if(event.target==compass.northwest)
				dispatchEvent(new InputEvent("northwest", InputEvent.INPUT));
			else if(event.target==compass.up)
				dispatchEvent(new InputEvent("up", InputEvent.INPUT));
			else if(event.target==compass.down)
				dispatchEvent(new InputEvent("down", InputEvent.INPUT));
				
		}
		
		private function resizeHandler(event:WindowResizeEvent){
			resize(event.rect);
		}
		
		public function xmlHandler(xml:XML){
			compass.north.visible=false;
			compass.northeast.visible=false;
			compass.east.visible=false;
			compass.southeast.visible=false;
			compass.south.visible=false;
			compass.southwest.visible=false;
			compass.west.visible=false;
			compass.northwest.visible=false;
			compass.up.visible=false;
			compass.down.visible=false;
						
			for each (var exit in xml.elements("exit")){
				if(exit.elements("direction").text()=="north")
					compass.north.visible=true;
				else if(exit.elements("direction").text()=="northeast")
					compass.northeast.visible=true;
				else if(exit.elements("direction").text()=="east")
					compass.east.visible=true;
				else if(exit.elements("direction").text()=="southeast")
					compass.southeast.visible=true;
				else if(exit.elements("direction").text()=="south")
					compass.south.visible=true;
				else if(exit.elements("direction").text()=="southwest")
					compass.southwest.visible=true;
				else if(exit.elements("direction").text()=="west")
					compass.west.visible=true;
				else if(exit.elements("direction").text()=="northwest")
					compass.northwest.visible=true;
				else if(exit.elements("direction").text()=="up")
					compass.up.visible=true;
				else if(exit.elements("direction").text()=="down")
					compass.down.visible=true;
			}
			
		}
		
		protected function resize(rect:Rectangle){
			compass.x=rect.x+(rect.width/2);
			compass.y=rect.y+(rect.height/2);
			
			if(rect.width < rect.height){
				compass.width=compass.height=rect.width;
			} else {
				compass.width=compass.height=rect.height;
			}
		}
		
	}
}
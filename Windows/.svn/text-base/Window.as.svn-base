package Windows {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.filters.DropShadowFilter;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import Events.*;
	import Style.*;
	import Menu.*;

	public class Window extends Sprite {
		protected var window:WindowTemplate;
		protected var closeBtn:WindowCloseBtn;
		private var resizeBtn:WindowResizeBtn;
		public var titleLabel:TextField;

		private var resizing:Boolean=false;
		private var resizeX:Number;
		private var resizeY:Number;
		
		private var dragging:Boolean=false;
		private var dragX:Number;
		private var dragY:Number;
		private var dragLocX:Number;
		private var dragLocY:Number;

		private var snapDistance=5;

		private var flashTimer:Timer;
		private var flashWhich:Boolean;

		public function Window(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			var so=SharedObject.getLocal("deadlight");
			
			if(so.data[title+".x"]!=undefined)
				x=so.data[title+".x"];
			else
				x=m_x;
			if(so.data[title+".y"]!=undefined)
				y=so.data[title+".y"];
			else
				y=m_y;
			if(so.data[title+".visible"]!=undefined)
				visible=so.data[title+".visible"];
			else	
				visible=v;
	

			window=new WindowTemplate();
			window.alpha=0.8;

			if(so.data[title+".width"]!=undefined)
				window.width=so.data[title+".width"];
			else
				window.width=w;

			if(so.data[title+".height"]!=undefined)
				window.height=so.data[title+".height"];
			else
				window.height=h;

			addChild(window);


			closeBtn=new WindowCloseBtn();
			closeBtn.gotoAndStop(1);
			addChild(closeBtn);
			
			resizeBtn=new WindowResizeBtn();
			resizeBtn.gotoAndStop(1);
			addChild(resizeBtn);

			titleLabel=new TextField();
			titleLabel.autoSize=TextFieldAutoSize.CENTER;
			titleLabel.selectable=false;
			titleLabel.mouseEnabled=false;
			titleLabel.defaultTextFormat=DeadlightStyle.getTextFormatMenu();
			titleLabel.antiAliasType = AntiAliasType.ADVANCED;
			titleLabel.text=title;
			addChild(titleLabel);
			
			updateControls();
		
			flashTimer=new Timer(500);
			stopFlashing();
		
			var myFilters=filters;
			myFilters.push(new DropShadowFilter(8.0, 45, 0x000000, 1, 8, 8, 0.5));
			filters=myFilters;
		
			addEventListener(Event.ADDED, addedToStage);
			
			window.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownWindow);
			window.addEventListener(MouseEvent.MOUSE_DOWN, bringToFrontHandler);
			closeBtn.addEventListener(MouseEvent.MOUSE_OVER, mouseOverBtn);
			closeBtn.addEventListener(MouseEvent.MOUSE_OUT, mouseOutBtn);
			closeBtn.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownClose);
			resizeBtn.addEventListener(MouseEvent.MOUSE_OVER, mouseOverBtn);
			resizeBtn.addEventListener(MouseEvent.MOUSE_OUT, mouseOutBtn);
			resizeBtn.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownResize);
		}
		
		public function getTitle():String {
			return titleLabel.text;
		}
		
		public function getInteriorCoords():Rectangle {
			var m_x=window.x+1; // border
			var m_y=window.y+18.6; // top bar
			var m_w=window.width-2; // borders
			var m_h=window.height - (18.6 + 1 + 14); // border, top bar, bottom bar
			
			return new Rectangle(m_x, m_y, m_w, m_h);
		}
		
		private function addedToStage(event:Event){
			if(event.target==this){
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveResize);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveWindow);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpResize);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpWindow);
			}
		}
		private function updateControls(){
			closeBtn.x=window.x+window.width-9;
			closeBtn.y=window.y+9;
			
			resizeBtn.x=window.x+window.width-7;
			resizeBtn.y=window.y+window.height-7;
			
			titleLabel.x=(window.x+window.width/2)-titleLabel.width/2;
			titleLabel.y=window.y;
			
		}
		
		private function resizeWindow(m_w:int, m_h:int){
			var so=SharedObject.getLocal("deadlight");
			window.width=Math.max(m_w, titleLabel.width+30);
			window.height=Math.max(m_h, 50);
			updateControls();
			dispatchEvent(new WindowResizeEvent(getInteriorCoords(), WindowResizeEvent.RESIZE));
			so.data[titleLabel.text+".width"]=window.width;
			so.data[titleLabel.text+".height"]=window.height;
		}
		
		private function mouseDownClose(event:MouseEvent){
			var so=SharedObject.getLocal("deadlight");
			visible=false;
			so.data[titleLabel.text+".visible"]=false;			
		}

		private function mouseDownResize(event:MouseEvent){
			resizing=true;

			var globalCoords:Point=localToGlobal(new Point(window.x,window.y));
			
			// offset where the mouse cursor is
			resizeX=globalCoords.x - (event.stageX-window.width);
			resizeY=globalCoords.y - (event.stageY-window.height);
		}
		private function mouseUpResize(event:MouseEvent){
			resizing=false;
		}		
		private function mouseMoveResize(event:MouseEvent){
			if(!resizing)
				return;
				
			var globalCoords:Point=localToGlobal(new Point(window.x,window.y));
			
			var newX=(event.stageX-globalCoords.x)+resizeX;
			var newY=(event.stageY-globalCoords.y)+resizeY;

			resizeWindow(newX, newY);
		}
		
		private function mouseOverBtn(event:MouseEvent){
			event.target.gotoAndStop(2);
		}
		private function mouseOutBtn(event:MouseEvent){
			event.target.gotoAndStop(1);
		}
		
		public function bringToFront(){
			// move to front
			var topPosition = parent.numChildren - 1;
			parent.setChildIndex(this, topPosition);
			stopFlashing();
		}
		protected function bringToFrontHandler(event:MouseEvent){
			bringToFront();
		}
		
		private function mouseDownWindow(event:MouseEvent){
			// drag if they clicked on the top bar or the bottom bar
			if(((event.localY*event.target.scaleY) < 19) ||
				 ((event.localY*event.target.scaleY) > event.target.height-16)){
				dragging=true;
				
				dragX=event.stageX;
				dragY=event.stageY;

				dragLocX=x;
				dragLocY=y;

			}
		}
		private function mouseUpWindow(event:MouseEvent){
			var so=SharedObject.getLocal("deadlight");
			dragging=false;
			so.data[titleLabel.text+".x"]=x;
			so.data[titleLabel.text+".y"]=y;
		}
		private function mouseMoveWindow(event:MouseEvent){
			if(!dragging)
				return;

			x=dragLocX-(dragX-event.stageX);
			y=dragLocY-(dragY-event.stageY);

			// if within 5 pixels of another window border, snap to it
			for(var i=0;i<parent.numChildren;++i){
				var w=parent.getChildAt(i);
				
				if((w is Window || w is MenuBar) && w.visible && w!=this){
					// my left side with target right side
					if(x < (w.x+w.width+snapDistance) && x > ((w.x+w.width)-snapDistance))
						x=w.x+w.width;
					// my right with target left
					if((x+width) < (w.x+snapDistance) && (x+width) > (w.x-snapDistance))
						x=w.x-width;
					// my top with target bottom
					if(y < (w.y+w.height+snapDistance) && y > ((w.y+w.height)-snapDistance))
						y=w.y+w.height;
					// my bottom with target top
					if((y+height) < (w.y+snapDistance) && (y+height) > (w.y-snapDistance))
						y=w.y-height;
					
					// stage left
					if(x > 0 && x < snapDistance)
						x=0;
					// stage right
					if((x+width) < stage.stageWidth && (x+width) > (stage.stageWidth-snapDistance))
						x=stage.stageWidth-width;
					// stage bottom
					if((y+height) < stage.stageHeight && (y+height) > (stage.stageHeight-snapDistance))
						y=stage.stageHeight-height;
				}
			}
		}
		
		public function startFlashing(){
			flashTimer.addEventListener(TimerEvent.TIMER, doFlash);
			flashTimer.start();
		}
		
		public function stopFlashing(){
			flashTimer.stop();
			window.transform.colorTransform = new ColorTransform(1, 1, 1, window.alpha, 0, 0, 0, 0);
		}

		private function doFlash(event:TimerEvent){
			if(flashWhich){				
				window.transform.colorTransform = new ColorTransform(1, 1, 1, window.alpha, 0, 0, 0, 0);
			} else {
				window.transform.colorTransform = new ColorTransform(1, 1, 1, window.alpha, 32, 32, 32, 0);
			}
			flashWhich=!flashWhich;			

		}
		
	}
}
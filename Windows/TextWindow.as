package Windows {
	import flash.display.Sprite;
	import flash.text.*;
	import fl.controls.UIScrollBar;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.system.System;
	import Events.*;
	import Style.*;

	public class TextWindow extends Window {
		public var m_Text:TextField;
		protected var m_ScrollBar:UIScrollBar;
		
		private const scrollBarWidth:int=15;
		
		private var lastTextPos:int;
		public var lastXMLSent:String;
		
		public function TextWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			super(title, m_x, m_y, w,h,v);
			
			createContents();
			addEventListener(WindowResizeEvent.RESIZE, resizeHandler);
		}
		
		private function resizeHandler(event:WindowResizeEvent){
			resize(event.rect);
		}
		
		protected function resize(rect:Rectangle){
			m_Text.x=rect.x;
			m_Text.y=rect.y;
			m_Text.width=rect.width-m_ScrollBar.width;
			m_Text.height=rect.height;
			
			m_ScrollBar.x=rect.x+m_Text.width;
			m_ScrollBar.y=rect.y;
			m_ScrollBar.height=rect.height;
			
		}

		private function createContents(){
			m_Text=new TextField();
      m_Text.defaultTextFormat=DeadlightStyle.getTextFormat();
			m_Text.wordWrap=true;
			m_Text.multiline=true;
			m_Text.antiAliasType = AntiAliasType.ADVANCED;
			addChild(m_Text);			

			m_ScrollBar = new UIScrollBar();
			m_ScrollBar.scrollTarget = m_Text;			
			addChild(m_ScrollBar);
			
			resize(getInteriorCoords());

			m_Text.addEventListener(MouseEvent.MOUSE_UP, bringToFrontHandler);
			m_ScrollBar.addEventListener(MouseEvent.MOUSE_DOWN, bringToFrontHandler);
		}		
		
		override protected function bringToFrontHandler(event:MouseEvent){
			if(event.target == m_Text)
				System.setClipboard(m_Text.text.substr(m_Text.selectionBeginIndex, m_Text.selectionEndIndex));
			bringToFront();
		}
		
		public function sendText(buf:String){
			// check if we are scrolled to the bottom of the text
			var scrolling=(m_Text.scrollV==m_Text.maxScrollV);
			// save the location of the scroll bar, so we can restore it later
			var scrollV=m_Text.scrollV;
			
			m_Text.appendText(buf);
			m_ScrollBar.update();

			if(scrolling) // auto scroll for new output
				m_Text.scrollV=m_Text.maxScrollV;
			else // we're looking at scrollback, so restore our location
				m_Text.scrollV=scrollV;
		}

		public function textFormat(format:TextFormat){
			if(lastTextPos!=m_Text.length){
				m_Text.setTextFormat(format, lastTextPos, m_Text.length);
				lastTextPos=m_Text.length;
			}			
		}
		
		public function clear(){
			m_Text.text="";
			lastTextPos=0;
		}
		
	}
}
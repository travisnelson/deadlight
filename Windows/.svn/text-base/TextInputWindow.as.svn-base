package Windows {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.controls.TextInput;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.system.System;
	

	public class TextInputWindow extends TextWindow {
		public var input:TextInput;
		protected var inputHasFocus:Boolean;
		protected var textHasFocus:Boolean;
		
		public function TextInputWindow(title:String, m_x:int, m_y:int, w:int, h:int, v:Boolean){
			input=new TextInput();
			super(title, m_x, m_y, w,h, v);
			addChild(input);
			input.addEventListener(MouseEvent.MOUSE_DOWN, bringToFrontHandler);
		}
		
		override protected function bringToFrontHandler(event:MouseEvent){
			if(event.target == m_Text)
				System.setClipboard(m_Text.text.substr(m_Text.selectionBeginIndex, m_Text.selectionEndIndex-m_Text.selectionBeginIndex));
			bringToFront();
			input.setFocus();
		}
		
		override protected function resize(rect:Rectangle){
			input.x=rect.x;
			input.y=(rect.y+rect.height)-input.height;
			input.width=rect.width;
			
			m_Text.x=rect.x;
			m_Text.y=rect.y;
			m_Text.width=rect.width-m_ScrollBar.width;
			m_Text.height=rect.height-input.height;
			
			m_ScrollBar.x=rect.x+m_Text.width;
			m_ScrollBar.y=rect.y;
			m_ScrollBar.height=rect.height-input.height;			
		}

	}
}
package {
	import fl.events.ComponentEvent;
	import fl.controls.TextInput;
	import flash.events.*;
	import flash.ui.*;
	import Windows.*;
	import Events.*;
	
	public class InputHandler extends EventDispatcher {
		protected var display:TextInputWindow;
		protected var cmdHistory:CommandHistory;
		
		public function InputHandler(w:TextInputWindow){
			display=w;
			display.input.addEventListener(ComponentEvent.ENTER, processInputHandler);
			cmdHistory=new CommandHistory();
			display.input.addEventListener(KeyboardEvent.KEY_UP, keyPressHandler);			
		}
		
		public function processInput(buf:String){			
			if(!display.input.displayAsPassword)
				cmdHistory.addCmd(buf);
				
			dispatchEvent(new InputEvent(buf, InputEvent.INPUT));
		}
		
		private function processInputHandler(event:ComponentEvent):void {
			processInput(event.target.text);
			display.input.text="";
			display.lastXMLSent="input";
		} 
		
		private function keyPressHandler(event:KeyboardEvent):void {		
			if(event.keyCode==Keyboard.UP){
				display.input.text=cmdHistory.scrollUp();
				display.input.setSelection(display.input.text.length,display.input.text.length);
			} else if(event.keyCode==Keyboard.DOWN){
				display.input.text=cmdHistory.scrollDown();
				display.input.setSelection(display.input.text.length,display.input.text.length);
			}
		}
		
		public function passwordHandler(event:SocketPasswordEvent){
			if(event.password==true){
				display.input.displayAsPassword=true;				
			} else {
				display.input.displayAsPassword=false;
			}
		}

	}
	
}
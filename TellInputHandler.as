package {
	import fl.events.ComponentEvent;
	import fl.controls.TextInput;
	import flash.events.*;
	import Windows.*;
	import Events.*;
	
	public class TellInputHandler extends InputHandler {
		public function TellInputHandler(w:TextInputWindow){
			super(w);
		}
		
		override public function processInput(buf:String){
			display.input.text="";
			
			if(!display.input.displayAsPassword)
				cmdHistory.addCmd(buf);

			var who:String=display.getTitle();
			dispatchEvent(new InputEvent("tell "+who+" "+buf, InputEvent.INPUT));
		}
	}
}
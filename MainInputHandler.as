package {
	import fl.events.ComponentEvent;
	import fl.controls.TextInput;
	import flash.events.*;
	import Windows.*;
	import Events.*;
	
	public class MainInputHandler extends InputHandler {
		private var aliases:Array;
		private var cmdRecursionLimit:int;


		public function MainInputHandler(w:TextInputWindow, a:Array){
			super(w);
			aliases=a;
		}
		
		private function getAliasedCmd(buf:String):String {
			var newBuf:String;
			
			for each (var item in aliases){
				newBuf=buf.replace(new RegExp("^"+item.name+"$"), item.data);
				
				if(newBuf != buf)
					break;
			}
			return newBuf;
		}
		
		private function repeatString(s:String, n:int){
			var buf:String=s;
			while(--n)
				buf+=s;
			return buf;
		}
		
		private function processCmd(cmd:String){
			var buf:String;
			var i:int;

			if((--cmdRecursionLimit) <= 0){
				if(!cmdRecursionLimit)
					display.sendText("## Hit recursion limit.\n");
				return;
			}

			cmd=cmd.replace(/\n/g, "");
			var cmdSplit=cmd.split(/(.*[^\\]);/);
			
			if(cmdSplit.length > 1){
				for each (cmd in cmdSplit){
					if(cmd!="")
						processCmd(cmd);
				}
				return;
			}

			if(getAliasedCmd(cmd) != cmd)
				return processCmd(getAliasedCmd(cmd));

			if(cmd.length>1 && cmd!="news" && 
				 cmd.search(/^(\d*[newsud])+$/)!=-1){
				cmdSplit=cmd.split(/(\d*)([newsud])/);

				var lastNum=1;

				for each (cmd in cmdSplit){
					if(cmd!=""){
						if(cmd.search(/\d/)!=-1)
							lastNum=cmd;
						else {
							processCmd(repeatString(cmd, lastNum));
							lastNum=1;
						}
					}
				}
				return;
			}

			if(!display.input.displayAsPassword)
				display.sendText(cmd+"\n");
			else
				display.sendText("\n");
								
			// now send it off so the socket (or whatever) can handle it
			dispatchEvent(new InputEvent(cmd, InputEvent.INPUT));
		}


		override public function processInput(buf:String){
			if(!display.input.displayAsPassword)
				cmdHistory.addCmd(buf);

				cmdRecursionLimit=1000;
				processCmd(buf);
		}
	}
}
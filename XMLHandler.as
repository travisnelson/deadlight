package {
  import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.*;
	import fl.events.*;
	import Events.*;
	import Windows.*;
	import CommHandlers.*;
	
	public class XMLHandler extends EventDispatcher {
		private var myStage:MovieClip;

		private var mainDisplay:TextInputWindow;
		private var mainInput:InputHandler;

		private var debugDisplay:TextWindow;
		private var mudLogDisplay:TextWindow;
		private var snoopDisplay:TextWindow;

		private var whoDisplay:TextWindow;
		private var whoList:Array;
		
		private var compassDisplay:ExitWindow;
		
		private var tellDisplays:Array;
	
		private var triggers:Array;
		
		private var soundHandler:SoundHandler;

		public function XMLHandler(s:MovieClip){
			myStage=s;
			tellDisplays=new Array();
			whoList=new Array();
		}
	
		public function setMainDisplay(db:TextInputWindow, h:MainInputHandler){
			mainDisplay=db;
			mainInput=h;
		}
		public function setDebugDisplay(db:TextWindow){
			debugDisplay=db;
		}
		public function setMudLogDisplay(db:TextWindow){
			mudLogDisplay=db;
		}
		public function setWhoDisplay(db:TextWindow){
			whoDisplay=db;
		}
		public function setTriggerList(tl:Array){
			triggers=tl;
		}
		public function setCompassDisplay(db:ExitWindow){
			compassDisplay=db;
		}
		public function setSoundHandler(h:SoundHandler){
			soundHandler=h;
		}
		public function setSnoopDisplay(db:TextWindow){
			snoopDisplay=db;
		}

		private function triggerHandler(buf:String){
			var match:Function=function(item:*, index:int, array:Array) {
				if(buf.search(item.name)!=-1){
					mainInput.processInput(item.data);
				}
			}
			triggers.forEach(match);
		}

		private function XMLTextHandler(xml:XMLList, output:TextWindow) {
			var format:TextFormat = new TextFormat();
			var lastTextPos=0;
			var boldOn=false;
			var outputBuf:String="";

			if(output.lastXMLSent == "prompt")
				output.sendText("\n");

			for each(var item in xml) {
				if(item.localName() == "font"){
					output.textFormat(format);
					
					switch(item.attribute("style").toString()){
						case "bold":
							boldOn=true;
							break;
						case "under":
							format.underline=true;
							break;
						default:
						// flash and invert are unhandled
					}
					
					if(item.attribute("color")=="norm"){
						format.underline=false;
						boldOn=false;
						format.color=0xCCCCCC;
					}

					if(boldOn){
						switch(item.attribute("color").toString()){
							case "white": format.color=0xFFFFFF; break;
							case "black": format.color=0x666666; break;
							case "red": format.color=0xFF6666; break;
							case "blue": format.color=0x6666FF; break;
							case "cyan": format.color=0x66FFFF; break;
							case "green": format.color=0x66FF66; break;
							case "orange": format.color=0xFFFF66; break;
							case "purple": format.color=0xFF66FF; break;
							case "norm": 
							default:
								format.color=0xFFFFFF; 
								break;
						}						
					} else {
						switch(item.attribute("color").toString()){
							case "white": format.color=0xCCCCCC; break;
							case "black": format.color=0x000000; break;
							case "red": format.color=0xCC0000; break;
							case "blue": format.color=0x0000CC; break;
							case "cyan": format.color=0x00CCCC; break;
							case "green": format.color=0x00CC00; break;
							case "orange": format.color=0xCCCC00; break;
							case "purple": format.color=0xCC00CC; break;
							case "norm": format.color=0xCCCCCC; break;
							default:
						}
					}
				} else {
					outputBuf+=item;
					output.sendText(item);
				}
			}

			output.textFormat(format);
			
			triggerHandler(outputBuf);
		}

		public function dataHandler(event:SocketXMLEvent){
			XMLData(event.xml);			
		}

		private function tellInputHandler(event:InputEvent){
			dispatchEvent(new InputEvent(event.input, InputEvent.INPUT));
		}

		private function findTellWindow(who:String){
			var found=false;
			
			for each (var tellWindow in tellDisplays){
				if(tellWindow.titleLabel.text==who){
					found=true;
					break;
				}
			}
			if(!found){
				tellWindow=new TextInputWindow(who, 10, 25, 400, 200, true);
				myStage.addChild(tellWindow);
				var inputHandler=new TellInputHandler(tellWindow);
				inputHandler.addEventListener(InputEvent.INPUT, tellInputHandler);
				tellDisplays.push(tellWindow);
				tellWindow.bringToFront();
			} else if(!tellWindow.visible){
				tellWindow.visible=true;
				tellWindow.bringToFront();
			} else if(tellWindow.parent.getChildIndex(tellWindow) != (tellWindow.parent.numChildren - 1)){
				tellWindow.startFlashing();
			}
				
			return tellWindow;
		}

		private function XMLData(xml:XML){
			var debugOutput:String="";
			var tellWindow;
			var xmlBuf;

			if(!xml.name())
				return;

			switch(xml.localName()){
				case "uncategorized":
					if(xml.children()!="\n"){
						XMLTextHandler(new UncategorizedComm(xml).output, mainDisplay);
						mainDisplay.lastXMLSent=xml.localName();
					}
					debugOutput="uncategorized";
					break;
				case "login":
					XMLTextHandler(new LoginComm(xml).output, mainDisplay);
					whoList=[];
					whoDisplay.m_Text.text="";
					debugOutput="login: prompt="+xml.attribute("prompt");
					mainDisplay.lastXMLSent=xml.localName();
					break;
				case "log":
					XMLTextHandler(new LogComm(xml).output, mudLogDisplay);
					debugOutput="log";
					mudLogDisplay.lastXMLSent=xml.localName();
					break;
				case "prompt":
					if(mainDisplay.lastXMLSent != "prompt"){
						XMLTextHandler(new PromptComm(xml).output, mainDisplay);
					}
					debugOutput="prompt";
					mainDisplay.lastXMLSent=xml.localName();
					break;
				case "cmdmsg":
					XMLTextHandler(new CmdmsgComm(xml).output, mainDisplay);
					mainDisplay.lastXMLSent=xml.localName();
					debugOutput="cmdmsg";
					break;
				case "tellfrom":
					if(xml.elements("mob")=="true"){
						XMLTextHandler(new TellFromComm(xml).output, mainDisplay);
						mainDisplay.lastXMLSent=xml.localName();
					} else {
						tellWindow=findTellWindow(xml.elements("from").text());
						XMLTextHandler(new TellFromComm(xml).output, tellWindow);
						tellWindow.lastXMLSent=xml.localName();
					}
					debugOutput=xml.localName();
					break;
				case "tellto":
					tellWindow=findTellWindow(xml.elements("to").text());		
					tellWindow.stopFlashing();
					XMLTextHandler(new TellToComm(xml).output, tellWindow);
					debugOutput=xml.localName();
					tellWindow.lastXMLSent=xml.localName();					
					break;
				case "wholist":
					whoDisplay.clear();
					var wlc=new WhoListComm(xml, whoList);
					whoList=wlc.getWhoList();
					
					XMLTextHandler(wlc.output, whoDisplay);						
					debugOutput="wholist";
					whoDisplay.lastXMLSent=xml.localName();				
					break;
				case "roomexits":
					compassDisplay.xmlHandler(xml);
					debugOutput=xml.localName();
					break;
				case "sound":
					soundHandler.xmlHandler(xml);					
					debugOutput=xml.localName();
					break;
				case "snoop":
					XMLTextHandler(new SnoopComm(xml).output, snoopDisplay);
					snoopDisplay.lastXMLSent=xml.localName();
					debugOutput="snoop";
					break;
				default:
					debugOutput="unhandled xml: "+xml.localName();
			}

			debugDisplay.sendText(debugOutput+"\n");
		}
	}
	
}
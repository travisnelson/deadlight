package {
	import flash.display.*;
	import flash.events.*;
	import fl.events.ComponentEvent;
	import fl.controls.TextInput;
	import flash.text.*;
	import flash.net.SharedObject;
	import Events.*;
	import Windows.*;
	import Menu.*;
	
	public class Deadlight extends MovieClip {
		var xmlHandler;
		var socket;
		var inputHandler;
		var soundHandler;
		
		var mainInput;

		var mainDisplay;
		var debugDisplay;
		var mudLogDisplay;
		var whoDisplay;
		var aliasDisplay;
		var triggerDisplay;
		var keypressDisplay;
		var exitDisplay;
		var snoopDisplay;

		public function Deadlight(){
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			socket=new SocketHandler();
			xmlHandler=new XMLHandler(this);

			// display windows
			mainDisplay=new TextInputWindow("SneezyMUD", 10, 25, 600, 560, true);
			addChild(mainDisplay);

			debugDisplay=new TextWindow("Debug", 630, 25, 385,275, false);
			xmlHandler.setDebugDisplay(debugDisplay);
			addChild(debugDisplay);

			mudLogDisplay=new TextWindow("Mud Logs", 630, 305, 385,275, false);
			xmlHandler.setMudLogDisplay(mudLogDisplay);
			addChild(mudLogDisplay);

			whoDisplay=new TextWindow("Who's Online", 630, 305, 385,275, false);
			whoDisplay.m_Text.wordWrap=false;
			xmlHandler.setWhoDisplay(whoDisplay);
			addChild(whoDisplay);

			aliasDisplay=new AliasWindow("Aliases", 300, 30, 350, 175, false);
			addChild(aliasDisplay);

			triggerDisplay=new TriggerWindow("Triggers", 350, 60, 350, 150, false);
			xmlHandler.setTriggerList(triggerDisplay.dataList);
			addChild(triggerDisplay);

			keypressDisplay=new KeypressWindow("Key Mapping", 300, 30, 350, 175, false);
			addChild(keypressDisplay);	

			exitDisplay=new ExitWindow("Compass Rose", 300, 30, 150, 150, false);
			xmlHandler.setCompassDisplay(exitDisplay);
			addChild(exitDisplay);
			
			snoopDisplay=new TextWindow("Snoop", 50, 30, 600, 560, false);
			xmlHandler.setSnoopDisplay(snoopDisplay);
			addChild(snoopDisplay);

			var menuDisplay=new MenuBar();
			menuDisplay.addWindowItem(mainDisplay.getTitle(), mainDisplay);
			menuDisplay.addWindowItem(aliasDisplay.getTitle(), aliasDisplay);
			menuDisplay.addWindowItem(triggerDisplay.getTitle(), triggerDisplay);
			menuDisplay.addWindowItem(keypressDisplay.getTitle(), keypressDisplay);
			menuDisplay.addWindowItem(whoDisplay.getTitle(), whoDisplay);
			menuDisplay.addWindowItem(exitDisplay.getTitle(), exitDisplay);
			menuDisplay.addAdminItem(debugDisplay.getTitle(), debugDisplay);
			menuDisplay.addAdminItem(mudLogDisplay.getTitle(), mudLogDisplay);
			menuDisplay.addAdminItem(snoopDisplay.getTitle(), snoopDisplay);
			addChild(menuDisplay);

			inputHandler=new MainInputHandler(mainDisplay, aliasDisplay.dataList);
			xmlHandler.setMainDisplay(mainDisplay, inputHandler);
			soundHandler=new SoundHandler();
			xmlHandler.setSoundHandler(soundHandler);
			
			sendVersionUpdate();

			// listeners
			socket.addEventListener(SocketXMLEvent.SOCKET_XML, xmlHandler.dataHandler);
			socket.addEventListener(SocketPasswordEvent.SOCKET_PASSWORD, inputHandler.passwordHandler);
			socket.addEventListener(SocketConnectionEvent.CONNECTED, menuDisplay.connectMenuHandler);
			socket.addEventListener(SocketConnectionEvent.DISCONNECTED, menuDisplay.connectMenuHandler);
			menuDisplay.connectMenu.addEventListener(MenuConnectionEvent.CONNECT, socket.menuConnectHandler);
			menuDisplay.connectMenu.addEventListener(MenuConnectionEvent.DISCONNECT, socket.menuDisconnectHandler);
			inputHandler.addEventListener(InputEvent.INPUT, myInputHandler);
			xmlHandler.addEventListener(InputEvent.INPUT, myInputHandler);
			exitDisplay.addEventListener(InputEvent.INPUT, triggerInputHandler);
			keypressDisplay.addEventListener(InputEvent.INPUT, triggerInputHandler);
		}
	
		public function triggerInputHandler(event:InputEvent){
			inputHandler.processInput(event.input);
		}

		public function myInputHandler(event:InputEvent){
			socket.sendInput(event.input);			
		}

		public function sendVersionUpdate(){
			var version="Beta 4";	
				
			var so=SharedObject.getLocal("deadlight");
			if(!so.data.version || so.data.version != version){
				var versionInfo=new TextWindow("Welcome to Deadlight "+version, 10, 25, 600, 300, true);
				versionInfo.m_Text.multiline=true;

				versionInfo.m_Text.htmlText+="Deadlight is a client for the online game <a href=\"http://www.sneezymud.com\"><b><u>SneezyMUD</u></b></a>.  ";
				versionInfo.m_Text.htmlText+="Please visit the <a href=\"http://forums.sneezymud.com/smf/index.php/topic,6211.0.html\"><b><u>Deadlight thread</u></b></a> in the <a href=\"http://forums.sneezymud.com/smf/\"><b><u>SneezyMUD forums</u></b></a> for more detailed information, as well as bug reports and feature requests.\n\n";
				versionInfo.m_Text.htmlText+="Changes in this version:<p>";
				versionInfo.m_Text.htmlText+="- Installation as an Adobe AIR app is now available.<br>";
				versionInfo.m_Text.htmlText+="- Stacked shorthand movement commands are now supported, eg: nen, 3n, ne3n10e<br>";
				versionInfo.m_Text.htmlText+="- Aliases may now call on other aliases.<br>";
				versionInfo.m_Text.htmlText+="- The compass rose is now clickable for movement.<br>";
				versionInfo.m_Text.htmlText+="- The cursor will now be placed at the end of the input line when the command history is used.<br>";
				versionInfo.m_Text.htmlText+="- Text windows will no longer snap to bottom on new input, if you have scrolled up to view text.<br>";
				versionInfo.m_Text.htmlText+="- Output will no longer be printed on the same line as the prompt.<br><br>";
				versionInfo.m_Text.htmlText+="Changes in beta 3:<p>";
				versionInfo.m_Text.htmlText+="- The connection menu has been replaced with a graphical latency meter.<br>";
				versionInfo.m_Text.htmlText+="- Sound support has been added.  This mirrors the MSP sound support the mud provides.<br>";
				versionInfo.m_Text.htmlText+="- There is now a separate snoop window (for administrators).<br>";
				versionInfo.m_Text.htmlText+="- Chat windows no longer steal focus if they are already visible, but will instead flash in the background.<br>";
				versionInfo.m_Text.htmlText+="- Text that is highlighted is auto-matically copied to the clipboard.<br>";
				versionInfo.m_Text.htmlText+="- Some minor bugs have been fixed with the who list and various coloration errors have been fixed.<br>";

				addChild(versionInfo);
				versionInfo.visible=true;
				versionInfo.bringToFront();
				so.data.version=version;
			}

		}
			
	}
}
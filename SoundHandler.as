package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;	
	import flash.events.*;
	import flash.errors.*;
	
	public class SoundHandler {
		private var url:String;
		private var soundChannel:SoundChannel;
		private var soundPriority:int=-1;
		private var musicChannel:SoundChannel;
		private var musicPriority:int=-1;
		
		public function SoundHandler(){
			url="";
		}
		
		public function xmlHandler(xml:XML){
			var loops=1;
			var vol=100;
			var priority=50;
			var soundtype=xml.attribute("type");

			if(xml.elements("url") != undefined)
				url=xml.elements("url").text();
			
			if(xml.elements("file").text()=="Off"){
				if(soundChannel != null && soundtype=="sound"){
					soundChannel.stop();
					soundChannel=null;
				}
				if(musicChannel != null && soundtype=="music"){
					musicChannel.stop();
					musicChannel=null;
				}
				
				return;
			}

			if(xml.elements("loops") != undefined)
				loops=int(xml.elements("loops").text());

			if(xml.elements("volume") != undefined)
				vol=int(xml.elements("volume").text());

			if(xml.elements("priority") != undefined)
				priority=int(xml.elements("priority").text());

			if(soundtype=="sound" && soundChannel != null){
				if(priority <= soundPriority)
					return;
				else
					soundChannel.stop();
			}
			
			if(soundtype=="music" && musicChannel != null){
				if(priority <= musicPriority)
					return;
				else
					musicChannel.stop();
			}

			var soundURL=url+xml.elements("file").text()+".mp3";
	
			var sound=new Sound();
			sound.addEventListener(IOErrorEvent.IO_ERROR, ioError);		
			sound.load(new URLRequest(soundURL));

			if(soundtype=="sound"){
				soundChannel=sound.play(0, loops);
				soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
				soundPriority=priority;
			} else if(soundtype=="music"){
				musicChannel=sound.play(0, loops);
				musicChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
				musicPriority=priority;
			}
		}
		
		private function ioError(event:IOErrorEvent){
		}
		
		private function soundComplete(event:Event){
			if(event.target==soundChannel){
				soundChannel=null;
				soundPriority=-1;
			} else if(event.target==musicChannel){
				musicChannel=null;
				musicPriority=-1;
			}
		}
		
	}
}
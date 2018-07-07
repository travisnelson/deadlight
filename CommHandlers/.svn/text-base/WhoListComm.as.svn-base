package CommHandlers {
	public class WhoListComm extends CommHandler {
		var whoList:Array;
		
		public function WhoListComm(xml:XML, w:Array){
			super(xml);
			whoList=w;
			
			var removal:Function=function(item:*, index:int, array:Array){
				if(item.name==xml.elements("name")){
// client code is just too buggy for this
//					if(xml.elements("linkdead")=="true")
//						item.linkdead=true;
//					else
						return false;
				}
				return true;
			}

			if(xml.elements("online")=="false")
				whoList=whoList.filter(removal);

			if(xml.elements("online")=="true")
				whoList.push({name: xml.elements("name").children(),
											level: xml.elements("level"),
											idle: xml.elements("idle"),
											prof: xml.elements("prof"),
											title: xml.elements("title").children(),
											linkdead: xml.elements("linkdead")});
							
			for each (var item in whoList){
				if(item.linkdead=="false")
					xmlOut+=new XML(pad(item.name, 10));
				else
					xmlOut+=new XML(pad("["+item.name+"]", 10));

				if(item.idle!=-1)
					xmlOut+=new XML(" Idle:["+pad(item.idle,3)+"]");

				xmlOut+=new XML(" Lvl:[");

				if(item.level!=-1)
					xmlOut+=new XML(pad(item.level,2));
				else
					xmlOut+=new XML("Anonymous");
					
				xmlOut+=new XML("] ");
				
				if(item.level > 50)
					xmlOut+=<font color="purple" />;
				
				xmlOut+=new XML(pad(item.prof, 14));
				xmlOut+=<font color="norm" />;
				xmlOut+=new XML(" | ");
				xmlOut+=item.title;
					
				xmlOut+=new XML("\n");
			}
		}
		
		private function pad(s:String, l:int):String{
			for(var i=s.length;i<l;++i)
				s+=" ";
			return s;
		}
		
		public function getWhoList(){
			return whoList;
		}
	}
}
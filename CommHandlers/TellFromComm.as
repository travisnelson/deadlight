package CommHandlers {
	public class TellFromComm extends CommHandler {
		public function TellFromComm(xml:XML){
			super(xml);
			
			if(xml.elements("mob")=="true")
				tellFromMob(xml);
			else
				tellFromPlayer(xml);
		}

		private function tellFromPlayer(xml:XML){
			xmlOut+=<font color="purple" />;
			xmlOut+=xml.elements("from").children();
			xmlOut+=<font color="norm" />;
			xmlOut+=new XML(": ");
			xmlOut+=<font color="cyan" />;
			xmlOut+=xml.elements("tell").children();
			xmlOut+=<font color="norm" />;
			xmlOut+=new XML("\n");			
		}

		private function tellFromMob(xml:XML){
			xmlOut+=<font color="purple" />;
			xmlOut+=xml.elements("from").children();
			xmlOut+=<font color="norm" />;
			xmlOut+=new XML(" tells you, \"");
			xmlOut+=<font color="cyan" />;
			xmlOut+=xml.elements("tell").children();
			xmlOut+=<font color="norm" />;
			xmlOut+=new XML("\"\n");			
		}
		
	}
}
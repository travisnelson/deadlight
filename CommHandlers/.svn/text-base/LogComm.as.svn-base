package CommHandlers {
	public class LogComm extends CommHandler {
		public function LogComm(xml:XML){
			super(xml);

			xmlOut+=new XML("\n// ");
			xmlOut+=xml.elements("type");
			xmlOut+=new XML(": ");
			xmlOut+=xml.elements("msg").children();
		}		
	}
}
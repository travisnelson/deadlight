package CommHandlers {
	public class TellToComm extends CommHandler {
		public function TellToComm(xml:XML){
			super(xml);

			xmlOut+=<font color="purple" />;
			xmlOut+=xml.elements("from").children();
			xmlOut+=<font color="norm" />;
			xmlOut+=new XML(": ");
			xmlOut+=<font color="cyan" />;
			xmlOut+=xml.elements("tell").children();
			xmlOut+=<font color="norm" />;
			xmlOut+=new XML("\n");
		}
	}
}
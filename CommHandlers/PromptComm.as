package CommHandlers {
	public class PromptComm extends CommHandler {
		public function PromptComm(xml:XML){
			super(xml);

			xmlOut+=new XML("\n");
			xmlOut+=xml.children();
		}		
	}
}
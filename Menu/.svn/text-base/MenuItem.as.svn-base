package Menu {
	import flash.display.Sprite;
	import flash.text.*;
	import fl.controls.*;
	import flash.events.*;
	import flash.geom.*;
	import Style.*;
	
	
	public class MenuItem extends ComboBox {
		public function MenuItem(){
		}
		
		protected function skin(){
			var tf:TextFormat = DeadlightStyle.getTextFormatMenu();
			tf.color=0xFFFFFF;
			textField.setStyle("textFormat",tf);
//			textField.setStyle("embedFonts", true);

			dropdown.setRendererStyle("textFormat", tf);
			
			// specify "disabledTextFormat" to overwrite default
			textField.setStyle("disabledTextFormat", tf);
			setStyle("upSkin", ComboBox_upSkinCustom);
			setStyle("downSkin", ComboBox_downSkinCustom);
			setStyle("overSkin", ComboBox_downSkinCustom);
			
			dropdown.setStyle("cellRenderer", CellRendererCustom);			
		}

		
		protected function setup(m_x:Number, m_y:Number, p:String){
			prompt=p;
			move(m_x, m_y);
		}		
		
	}
}
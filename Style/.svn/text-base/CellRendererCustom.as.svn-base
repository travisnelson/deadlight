package Style {
	import fl.controls.listClasses.CellRenderer;
	import flash.text.TextFormat;	
	
	public class CellRendererCustom extends CellRenderer {
		public function CellRendererCustom(){
			super();
			var format:TextFormat = new TextFormat();
			format.color = 0xFFFFFF;
			format.font="Bitstream Vera Sans Mono";
			setStyle("textFormat", format);
			setStyle("upSkin", CellRenderer_upSkinCustom);
			setStyle("downSkin", CellRenderer_downSkinCustom);
			setStyle("overSkin", CellRenderer_downSkinCustom);
		}
	}
	
}
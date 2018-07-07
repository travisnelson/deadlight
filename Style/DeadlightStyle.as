package Style {
	import flash.text.TextFormat;
	import flash.text.Font;
		
	public class DeadlightStyle {
		public function DeadlightStyle(){
		}
		
		// default text style
		public static function getTextFormat():TextFormat {
			var findFont:Function = function(item:*, index:int, array:Array):Boolean {
				if(item.fontName=="Bitstream Vera Sans Mono")
					return true;
				return false;
			}
			var format=new TextFormat();
			format.color=0xCCCCCC;
			format.size=12;
			
			if(Font.enumerateFonts(true).some(findFont))
				format.font="Bitstream Vera Sans Mono";
			else
				format.font="Courier New";

			return format;
		}

		public static function getTextFormatMenu():TextFormat {
			var format=getTextFormat();
			format.color=0xFFFFFF;
			return format;
		}
		
	}
}
package {
	public class CommandHistory {
		var history:Array;
		var pos:int;
		
		public function CommandHistory(){
			history=new Array;
			history.push("");
			pos=0;
		}
		
		public function addCmd(cmd:String){
			if(history[history.length-2]!=cmd){			
				history[history.length-1]=cmd;
				history.push("");
				pos=history.length-1;
			}
		}
		
		public function scrollUp():String {
			if(pos!=0)
				pos--;
			
			return history[pos];
		}
		
		public function scrollDown():String {
			if(pos!=(history.length-1))
				pos++;
			
			return history[pos];
		}
		
	}
}
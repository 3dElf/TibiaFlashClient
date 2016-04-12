package tibia.input.staticaction
{
    import tibia.input.gameaction.*;

    public class SendBugReport extends StaticAction
    {

        public function SendBugReport(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            new SendBugReportActionImpl().perform(param1);
            return;
        }// end function

    }
}

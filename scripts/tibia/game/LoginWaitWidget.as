package tibia.game
{

    public class LoginWaitWidget extends TimeoutWaitWidget
    {
        private static const BUNDLE:String = "Tibia";

        public function LoginWaitWidget()
        {
            title = resourceManager.getString(BUNDLE, "DLG_LOGINWAIT_TITLE");
            return;
        }// end function

        override protected function updateMessage() : void
        {
            var _loc_1:* = remainingTime;
            m_UIMessage.htmlText = resourceManager.getString(BUNDLE, "DLG_LOGINWAIT_TEXT", [message, getTimeString(_loc_1)]);
            return;
        }// end function

    }
}

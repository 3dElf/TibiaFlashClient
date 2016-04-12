package tibia.game
{

    public class ConnectionLostWidget extends TimeoutWaitWidget
    {
        private static const BUNDLE:String = "Tibia";

        public function ConnectionLostWidget()
        {
            message = resourceManager.getString(BUNDLE, "DLG_CONNECTION_LOST_MESSAGE");
            title = resourceManager.getString(BUNDLE, "DLG_CONNECTION_LOST_TITLE");
            return;
        }// end function

        override protected function updateMessage() : void
        {
            var _loc_1:* = remainingTime;
            m_UIMessage.htmlText = resourceManager.getString(BUNDLE, "DLG_CONNECTION_LOST_TEXT", [message, getTimeString(_loc_1)]);
            return;
        }// end function

    }
}

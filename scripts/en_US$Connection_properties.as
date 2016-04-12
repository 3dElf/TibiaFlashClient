package 
{
    import en_US$Connection_properties.*;
    import mx.resources.*;

    public class en_US$Connection_properties extends ResourceBundle
    {

        public function en_US$Connection_properties()
        {
            super("en_US", "Connection");
            return;
        }// end function

        override protected function getContent() : Object
        {
            var _loc_1:* = {MSG_INTERNAL_ERROR:"An internal error has occurred (Code: {0}.{1}).", MSG_CONNECT_FAILED_RECONNECT:"Failed to establish connection to the game server.\nFailed attempts so far: {0}", MSG_COULD_NOT_CONNECT:"Could not connect to the game server. Please try again later.", MSG_LOST_CONNECTION:"Lost connection to the game server. Please close the client and try again."};
            return _loc_1;
        }// end function

    }
}

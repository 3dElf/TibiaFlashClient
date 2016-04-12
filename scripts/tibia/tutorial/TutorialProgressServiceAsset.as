package tibia.tutorial
{
    import flash.events.*;
    import flash.net.*;
    import mx.resources.*;
    import tibia.game.*;

    public class TutorialProgressServiceAsset extends AssetBase
    {
        private var m_CharacterName:String = null;
        private var m_SecureWebsiteService:SecureWebsiteService = null;
        private var m_ProgressIdentifierToUpload:String = null;
        private static const BUNDLE:String = "Communication";

        public function TutorialProgressServiceAsset(param1:String, param2:int = 0, param3:String = "application/json")
        {
            super(param1, param2, param3);
            this.m_SecureWebsiteService = new SecureWebsiteService(param1);
            this.m_SecureWebsiteService.addEventListener(SecureWebsiteServiceEvent.REQUEST_DATA, this.onWebsiteServiceRequestData);
            this.m_SecureWebsiteService.addEventListener(SecureWebsiteServiceEvent.COMPLETE, this.onWebsiteServiceComplete);
            this.m_SecureWebsiteService.addEventListener(ErrorEvent.ERROR, this.onWebsiteServiceError);
            this.m_SecureWebsiteService.addEventListener(IOErrorEvent.IO_ERROR, this.onWebsiteServiceError);
            return;
        }// end function

        override protected function processDownloadedData(param1:URLLoader) : Boolean
        {
            return true;
        }// end function

        override public function get loaded() : Boolean
        {
            return true;
        }// end function

        private function onWebsiteServiceRequestData(event:SecureWebsiteServiceEvent) : void
        {
            var a_Event:* = event;
            try
            {
                a_Event.serviceData["progress"] = this.m_ProgressIdentifierToUpload;
                a_Event.serviceData["charactername"] = this.m_CharacterName;
            }
            catch (Error)
            {
                a_Event.preventDefault();
            }
            return;
        }// end function

        override public function load() : void
        {
            super.load();
            return;
        }// end function

        private function onWebsiteServiceError(event:ErrorEvent) : void
        {
            this.m_ProgressIdentifierToUpload = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.errorID == -4)
            {
                _loc_2 = ResourceManager.getInstance().getString(BUNDLE, "MSG_USER_HAS_LOGGED_OUT_WHILE_PLAYING");
                _loc_3 = new ErrorEvent(ErrorEvent.ERROR, false, false, _loc_2);
                dispatchEvent(_loc_3);
            }
            else if (event.errorID == -5)
            {
            }
            else
            {
                _loc_2 = ResourceManager.getInstance().getString(BUNDLE, "MSG_LOST_CONNECTION");
                _loc_3 = new ErrorEvent(ErrorEvent.ERROR, false, false, _loc_2, event.errorID);
                dispatchEvent(_loc_3);
                event.preventDefault();
            }
            return;
        }// end function

        private function onWebsiteServiceComplete(event:SecureWebsiteServiceEvent) : void
        {
            this.m_ProgressIdentifierToUpload = null;
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public function sendProgress(param1:String, param2:String, param3:String) : void
        {
            this.m_ProgressIdentifierToUpload = param1;
            this.m_CharacterName = param2;
            this.m_SecureWebsiteService.startServiceCall(param3);
            return;
        }// end function

    }
}

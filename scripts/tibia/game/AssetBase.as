package tibia.game
{
    import flash.events.*;
    import flash.net.*;
    import shared.utility.*;

    public class AssetBase extends EventDispatcher
    {
        private var m_URL:String = null;
        private var m_Loader:URLLoader = null;
        private var m_Optional:Boolean = false;
        private var m_Priority:int = 0;
        private var m_ContentType:String = null;
        protected var m_NoCacheEnabled:Boolean = false;
        private var m_Size:int = 0;
        private var m_Name:String = null;

        public function AssetBase(param1:String, param2:int = 0, param3:String = "application/octet-stream")
        {
            this.m_URL = param1;
            if (this.m_URL == null || this.m_URL.length < 1)
            {
                throw new ArgumentError("AssetBase.AssetBase: Invalid URL.");
            }
            this.m_Size = param2;
            this.m_ContentType = param3;
            if (this.m_ContentType == null || this.m_ContentType.length < 1)
            {
                throw new ArgumentError("AssetBase.AssetBase: Invalid content type.");
            }
            this.m_Name = URLHelper.s_GetBasename(this.m_URL);
            if (this.m_Name == null || this.m_Name.length < 1)
            {
                throw new ArgumentError("AssetBase.AssetBase: Invalid name.");
            }
            return;
        }// end function

        public function set optional(param1:Boolean) : void
        {
            this.m_Optional = param1;
            return;
        }// end function

        public function get size() : int
        {
            return this.m_Size;
        }// end function

        protected function get dataFormatForContentType() : String
        {
            if (this.contentType.indexOf("text/") == 0)
            {
                return URLLoaderDataFormat.TEXT;
            }
            return URLLoaderDataFormat.BINARY;
        }// end function

        protected function processDownloadedData(param1:URLLoader) : Boolean
        {
            return false;
        }// end function

        public function set priority(param1:int) : void
        {
            this.m_Priority = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function get loaded() : Boolean
        {
            return false;
        }// end function

        private function onLoaderComplete(event:Event) : void
        {
            if (this.processDownloadedData(this.m_Loader))
            {
                this.unloadLoader();
                dispatchEvent(event);
            }
            else
            {
                this.unload();
                this.unloadLoader();
                dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false));
            }
            return;
        }// end function

        public function get uniqueKey() : Object
        {
            return this.url;
        }// end function

        public function get contentType() : String
        {
            return this.m_ContentType;
        }// end function

        protected function makeDownloadRequest() : URLRequest
        {
            var _loc_1:* = new URLRequest(this.m_NoCacheEnabled ? (URLHelper.s_NoCache(this.url)) : (this.url));
            return _loc_1;
        }// end function

        private function onLoaderError(event:ErrorEvent) : void
        {
            this.unload();
            this.unloadLoader();
            dispatchEvent(event);
            return;
        }// end function

        private function onLoaderProgress(event:ProgressEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function get optional() : Boolean
        {
            return this.m_Optional;
        }// end function

        protected function resetDownloadedData() : void
        {
            return;
        }// end function

        public function get priority() : int
        {
            return this.m_Priority;
        }// end function

        public function load() : void
        {
            this.resetDownloadedData();
            this.unloadLoader();
            var _loc_1:* = this.makeDownloadRequest();
            this.m_Loader = new URLLoader();
            this.m_Loader.dataFormat = this.dataFormatForContentType;
            this.m_Loader.addEventListener(Event.COMPLETE, this.onLoaderComplete);
            this.m_Loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderError);
            this.m_Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoaderError);
            this.m_Loader.addEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
            this.m_Loader.load(_loc_1);
            return;
        }// end function

        public function get url() : String
        {
            return this.m_URL;
        }// end function

        private function unloadLoader() : void
        {
            if (this.m_Loader != null)
            {
                try
                {
                    this.m_Loader.close();
                }
                catch (e:Error)
                {
                }
                this.m_Loader.removeEventListener(Event.COMPLETE, this.onLoaderComplete);
                this.m_Loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderError);
                this.m_Loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoaderError);
                this.m_Loader.removeEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
                this.m_Loader = null;
            }
            return;
        }// end function

        public function unload() : void
        {
            this.resetDownloadedData();
            this.unloadLoader();
            return;
        }// end function

    }
}

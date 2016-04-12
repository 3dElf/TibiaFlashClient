package tibia.sessiondump
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import shared.utility.*;

    public class SessiondumpLoader extends EventDispatcher
    {
        private var m_State:uint = 0;
        private var m_InputStream:ByteArray = null;
        private var m_URLStream:URLStream = null;
        private static const STATE_DEFAULT:int = 0;
        private static const STATE_ERROR:int = -1;
        private static const STATE_LOADED:int = 2;
        private static const STATE_LOADING:int = 1;

        public function SessiondumpLoader()
        {
            return;
        }// end function

        public function get isLoadingFinished() : Boolean
        {
            return this.m_State == STATE_LOADED;
        }// end function

        public function get inputStream() : ByteArray
        {
            return this.m_InputStream;
        }// end function

        private function onLoaderComplete(event:Event) : void
        {
            if (this.m_URLStream != null)
            {
                if (this.m_URLStream.bytesAvailable > 0)
                {
                    this.m_URLStream.readBytes(this.m_InputStream, this.m_InputStream.length);
                }
            }
            this.m_State = STATE_LOADED;
            dispatchEvent(event);
            return;
        }// end function

        public function load(param1:String) : void
        {
            if (this.m_State == STATE_DEFAULT)
            {
                this.unloadLoader();
                this.m_InputStream = new ByteArray();
                this.m_InputStream.endian = Endian.LITTLE_ENDIAN;
                this.m_URLStream = new URLStream();
                this.m_URLStream.addEventListener(Event.COMPLETE, this.onLoaderComplete);
                this.m_URLStream.addEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
                this.m_URLStream.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderError);
                this.m_URLStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoaderError);
                this.m_URLStream.load(new URLRequest(URLHelper.s_NoCache(param1)));
                this.m_State = STATE_LOADING;
            }
            return;
        }// end function

        public function get isLoading() : Boolean
        {
            return this.m_State == STATE_LOADING;
        }// end function

        private function onLoaderError(event:ErrorEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function unloadLoader() : void
        {
            if (this.m_URLStream != null)
            {
                if (this.m_State == STATE_LOADING)
                {
                    try
                    {
                        this.m_URLStream.close();
                    }
                    catch (_Error)
                    {
                    }
                }
                this.m_URLStream.removeEventListener(Event.COMPLETE, this.onLoaderComplete);
                this.m_URLStream.removeEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
                this.m_URLStream.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderError);
                this.m_URLStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoaderError);
                this.m_URLStream = null;
                this.m_InputStream = null;
            }
            return;
        }// end function

        private function onLoaderProgress(event:ProgressEvent) : void
        {
            if (this.m_URLStream != null && this.m_URLStream.bytesAvailable > 0)
            {
                this.m_URLStream.readBytes(this.m_InputStream, this.m_InputStream.length);
            }
            return;
        }// end function

    }
}

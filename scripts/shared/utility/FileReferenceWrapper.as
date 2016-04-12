package shared.utility
{
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;

    public class FileReferenceWrapper extends FileReference
    {
        private static var s_Instance:FileReferenceWrapper = null;

        public function FileReferenceWrapper()
        {
            return;
        }// end function

        override public function upload(param1:URLRequest, param2:String = "Filedata", param3:Boolean = false) : void
        {
            var a_Rquest:* = param1;
            var a_UploadDataFieldName:* = param2;
            var a_TestUpload:* = param3;
            this.checkInstance();
            this.setInstance();
            try
            {
                super.upload(a_Rquest, a_UploadDataFieldName, a_TestUpload);
            }
            catch (_Error)
            {
                clearInstance();
                throw _Error;
            }
            return;
        }// end function

        private function clearInstance(... args) : void
        {
            s_Instance = null;
            removeEventListener(Event.CANCEL, this.clearInstance);
            removeEventListener(Event.SELECT, this.clearInstance);
            removeEventListener(Event.COMPLETE, this.clearInstance);
            removeEventListener(IOErrorEvent.IO_ERROR, this.clearInstance);
            removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.clearInstance);
            removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, this.clearInstance);
            removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.clearInstance);
            return;
        }// end function

        private function checkInstance() : void
        {
            if (s_Instance != null)
            {
                throw new IllegalOperationError();
            }
            return;
        }// end function

        override public function load() : void
        {
            this.checkInstance();
            this.setInstance();
            try
            {
                super.load();
            }
            catch (_Error)
            {
                clearInstance();
                throw _Error;
            }
            return;
        }// end function

        private function setInstance() : void
        {
            s_Instance = this;
            addEventListener(Event.CANCEL, this.clearInstance);
            addEventListener(Event.SELECT, this.clearInstance);
            addEventListener(Event.COMPLETE, this.clearInstance);
            addEventListener(IOErrorEvent.IO_ERROR, this.clearInstance);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.clearInstance);
            addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, this.clearInstance);
            addEventListener(HTTPStatusEvent.HTTP_STATUS, this.clearInstance);
            return;
        }// end function

        override public function download(param1:URLRequest, param2:String = null) : void
        {
            var a_Request:* = param1;
            var a_DefaultFileName:* = param2;
            this.checkInstance();
            this.setInstance();
            try
            {
                return super.download(a_Request, a_DefaultFileName);
            }
            catch (_Error)
            {
                clearInstance();
                throw _Error;
            }
            return;
        }// end function

        override public function cancel() : void
        {
            try
            {
                super.cancel();
                this.clearInstance();
            }
            catch (_Error)
            {
                throw _Error;
            }
            return;
        }// end function

        override public function browse(param1:Array = null) : Boolean
        {
            var a_TypeFilter:* = param1;
            this.checkInstance();
            this.setInstance();
            try
            {
                return super.browse(a_TypeFilter);
            }
            catch (_Error)
            {
                clearInstance();
                throw _Error;
            }
            return false;
        }// end function

        override public function save(param1, param2:String = null) : void
        {
            var a_Data:* = param1;
            var a_DefaultFileName:* = param2;
            this.checkInstance();
            this.setInstance();
            try
            {
                super.save(a_Data, a_DefaultFileName);
            }
            catch (_Error)
            {
                clearInstance();
                throw _Error;
            }
            return;
        }// end function

    }
}

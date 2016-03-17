package tibia.game
{
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import mx.utils.Base64Decoder;
   import flash.utils.ByteArray;
   import flash.errors.IOError;
   import flash.events.ErrorEvent;
   import mx.utils.Base64Encoder;
   
   public class OptionsAsset extends AssetBase
   {
       
      private var m_UploadXML:XML = null;
      
      private var m_Loader:URLLoader = null;
      
      private var m_UploadToken:String = null;
      
      private var m_XML:XML = null;
      
      private var m_IsDefaultOptions:Boolean = false;
      
      public function OptionsAsset(param1:String, param2:int = 0, param3:String = "application/json", param4:Boolean = false)
      {
         super(param1,param2,param3);
         this.m_IsDefaultOptions = param4;
      }
      
      override protected function resetDownloadedData() : void
      {
         this.m_XML = null;
      }
      
      public function upload(param1:XML) : void
      {
         if(param1 == null)
         {
            throw new Error("OptionsAsset.upload: Invalid data.");
         }
         this.unloadLoader();
         this.m_UploadToken = null;
         this.m_UploadXML = param1;
         this.m_Loader = new URLLoader();
         this.m_Loader.addEventListener(Event.COMPLETE,this.onUploadComplete);
         this.m_Loader.addEventListener(IOErrorEvent.IO_ERROR,this.onUploadError);
         this.m_Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadError);
         var _loc2_:URLRequest = new URLRequest(url);
         _loc2_.contentType = "application/json";
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = JSON.stringify({});
         this.m_Loader.load(_loc2_);
      }
      
      public function get isDefaultOptions() : Boolean
      {
         return this.m_IsDefaultOptions;
      }
      
      override protected function processDownloadedData(param1:URLLoader) : Boolean
      {
         var Result:Object = null;
         var Decoder:Base64Decoder = null;
         var _ByteArray:ByteArray = null;
         var a_Loader:URLLoader = param1;
         var XMLString:String = null;
         if(contentType == "application/json")
         {
            try
            {
               Result = JSON.parse(String(a_Loader.data));
               if("options" in Result)
               {
                  Decoder = new Base64Decoder();
                  Decoder.decode(Result["options"]);
                  _ByteArray = Decoder.toByteArray();
                  _ByteArray.uncompress();
                  XMLString = _ByteArray.readUTFBytes(_ByteArray.bytesAvailable);
               }
            }
            catch(e:TypeError)
            {
            }
            catch(e:IOError)
            {
            }
         }
         else if(contentType == "text/xml")
         {
            XMLString = String(a_Loader.data);
         }
         else
         {
            return false;
         }
         try
         {
            this.m_XML = new XML(XMLString);
         }
         catch(e:*)
         {
         }
         finally
         {
            return this.m_XML != null;
         }
      }
      
      private function onUploadError(param1:ErrorEvent) : void
      {
         this.unloadLoader();
         dispatchEvent(param1);
      }
      
      public function get xml() : XML
      {
         return this.m_XML;
      }
      
      private function onUploadComplete(param1:Event) : void
      {
         var _ByteArray:ByteArray = null;
         var Encoder:Base64Encoder = null;
         var Request:Object = null;
         var _URLRequest:URLRequest = null;
         var a_Event:Event = param1;
         var Result:Object = null;
         var _Event:Event = null;
         try
         {
            Result = JSON.parse(this.m_Loader.data);
         }
         catch(e:TypeError)
         {
         }
         if(Result == null || "errorcode" in Result && Result["errorcode"] !== 0)
         {
            this.m_UploadToken = null;
            this.m_UploadXML = null;
            this.unloadLoader();
            _Event = new ErrorEvent(ErrorEvent.ERROR,false,false,"Request failed.");
            dispatchEvent(_Event);
            return;
         }
         if(this.m_UploadToken == null)
         {
            if("token" in Result)
            {
               this.m_UploadToken = Result["token"];
            }
            if(this.m_UploadToken != null)
            {
               _ByteArray = new ByteArray();
               _ByteArray.writeUTFBytes(this.m_UploadXML.toXMLString());
               _ByteArray.compress();
               Encoder = new Base64Encoder();
               Encoder.encodeBytes(_ByteArray);
               Request = {
                  "options":Encoder.toString(),
                  "token":this.m_UploadToken
               };
               _URLRequest = new URLRequest(url);
               _URLRequest.contentType = "application/json";
               _URLRequest.method = URLRequestMethod.POST;
               _URLRequest.data = JSON.stringify(Request);
               this.m_Loader.load(_URLRequest);
            }
            else
            {
               this.m_UploadToken = null;
               this.m_UploadXML = null;
               this.unloadLoader();
               _Event = new ErrorEvent(ErrorEvent.ERROR,false,false,"Invalid token.");
               dispatchEvent(_Event);
            }
         }
         else
         {
            this.m_UploadToken = null;
            this.m_UploadXML = null;
            this.unloadLoader();
            dispatchEvent(a_Event);
         }
      }
      
      private function unloadLoader() : void
      {
         if(this.m_Loader != null)
         {
            try
            {
               this.m_Loader.close();
            }
            catch(e:Error)
            {
            }
            this.m_Loader.removeEventListener(Event.COMPLETE,this.onUploadComplete);
            this.m_Loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onUploadError);
            this.m_Loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadError);
            this.m_Loader = null;
         }
      }
   }
}

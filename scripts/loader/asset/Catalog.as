package loader.asset
{
   import flash.events.EventDispatcher;
   import flash.events.ErrorEvent;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import tibia.game.Asset;
   import flash.net.URLLoaderDataFormat;
   
   public class Catalog extends EventDispatcher
   {
      
      private static const STATE_DONE:int = 2;
      
      private static const STATE_DEFAULT:int = 0;
      
      private static const STATE_ERROR:int = -1;
      
      private static const ERROR_INTERNAL:String = "Invalid catalog file.";
      
      private static const STATE_LOADING:int = 1;
       
      protected var m_Loader:URLLoader = null;
      
      protected var m_State:int = 0;
      
      protected var m_Cache:loader.asset.Cache = null;
      
      protected var m_URL:String = null;
      
      public function Catalog(param1:String, param2:loader.asset.Cache)
      {
         super();
         this.m_Cache = param2;
         this.m_URL = param1;
      }
      
      private function loadError(param1:ErrorEvent = null) : void
      {
         var _loc2_:ErrorEvent = null;
         this.unloadLoader();
         this.m_State = STATE_ERROR;
         if(param1 != null)
         {
            dispatchEvent(param1.clone());
         }
         else
         {
            _loc2_ = new ErrorEvent(ErrorEvent.ERROR);
            _loc2_.text = ERROR_INTERNAL;
            dispatchEvent(_loc2_);
         }
      }
      
      public function load() : void
      {
         if(this.m_State == STATE_DEFAULT)
         {
            this.m_State = STATE_LOADING;
            this.unloadLoader();
            this.m_Loader = new URLLoader();
            this.m_Loader.addEventListener(Event.COMPLETE,this.onLoaderComplete);
            this.m_Loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
            this.m_Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoaderError);
            this.m_Loader.load(new URLRequest(this.m_URL));
         }
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _XML:XML = null;
         var AssetXML:XML = null;
         var _Asset:Asset = null;
         var _Event:Event = null;
         var a_Event:Event = param1;
         var IsValid:Boolean = false;
         if(this.m_Loader != null && this.m_Loader.data != null && this.m_Loader.dataFormat == URLLoaderDataFormat.TEXT)
         {
            _XML = null;
            try
            {
               _XML = new XML(this.m_Loader.data as String);
               IsValid = true;
            }
            catch(_Error:*)
            {
            }
            if(_XML != null && _XML.localName() == "catalog")
            {
               for each(AssetXML in _XML.children())
               {
                  _Asset = Asset.s_FromXML(AssetXML,this.m_Cache);
                  if(_Asset == null)
                  {
                     IsValid = false;
                     break;
                  }
                  this.m_Cache.addAsset(_Asset);
               }
            }
            this.unloadLoader();
         }
         if(IsValid)
         {
            this.m_State = STATE_DONE;
            _Event = new Event(Event.COMPLETE);
            dispatchEvent(_Event);
         }
         else
         {
            this.loadError();
         }
      }
      
      public function get URL() : String
      {
         return this.m_URL;
      }
      
      private function unloadLoader() : void
      {
         if(this.m_Loader != null)
         {
            if(this.m_State == STATE_LOADING)
            {
               try
               {
                  this.m_Loader.close();
               }
               catch(_Error:*)
               {
               }
            }
            this.m_Loader.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
            this.m_Loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
            this.m_Loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoaderError);
            this.m_Loader = null;
         }
      }
      
      private function onLoaderError(param1:ErrorEvent) : void
      {
         this.loadError(param1);
      }
      
      public function unload() : void
      {
         this.unloadLoader();
         this.m_State = STATE_ERROR;
         this.m_URL = null;
         this.m_Cache = null;
      }
   }
}

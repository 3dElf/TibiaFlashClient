package tibia.game
{
   import flash.events.EventDispatcher;
   import loader.asset.Cache;
   import flash.utils.ByteArray;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import shared.utility.SharedObjectManager;
   import flash.net.SharedObject;
   import flash.system.System;
   import flash.events.ErrorEvent;
   import shared.utility.URLHelper;
   
   public class Asset extends EventDispatcher
   {
       
      private var m_URL:String = null;
      
      protected var m_Loader:URLLoader = null;
      
      private var m_Cache:Cache = null;
      
      private var m_Size:int = 0;
      
      protected var m_RawBytes:ByteArray = null;
      
      private var m_Name:String = null;
      
      public function Asset(param1:Cache, param2:String, param3:int)
      {
         super();
         this.m_Cache = param1;
         this.m_URL = param2;
         if(this.m_URL == null || this.m_URL.length < 1)
         {
            throw new ArgumentError("Asset.Asset: Invalid URL.");
         }
         this.m_Size = param3;
         this.m_Name = URLHelper.s_GetBasename(this.m_URL);
         if(this.m_Name == null || this.m_Name.length < 1)
         {
            throw new ArgumentError("Asset.Asset: Invalid name.");
         }
      }
      
      public static function s_FromXML(param1:XML, param2:Cache) : Asset
      {
         if(param1 == null || param1.attributes().length() > 0 || param1.children().length() < 2 || param1.localName() != "binary" && param1.localName() != "appearances" && param1.localName() != "sprites" || param2 == null)
         {
            return null;
         }
         var _loc3_:String = null;
         if(!param1.hasOwnProperty("url"))
         {
            return null;
         }
         var _loc4_:String = param1.url.toString();
         if(!param1.hasOwnProperty("size"))
         {
            return null;
         }
         _loc3_ = param1.size.toString();
         if(_loc3_.match(/^[1-9][0-9]*$/) == null)
         {
            return null;
         }
         var _loc5_:int = int(_loc3_);
         var _loc6_:int = -1;
         if(param1.localName() == "sprites")
         {
            if(!param1.hasOwnProperty("startid"))
            {
               return null;
            }
            _loc3_ = param1.startid.toString();
            if(_loc3_.match(/^[0-9]+$/) == null)
            {
               return null;
            }
            _loc6_ = int(_loc3_);
         }
         switch(param1.localName())
         {
            case "binary":
               return new GameBinaryAsset(param2,_loc4_,_loc5_);
            case "appearances":
               return new AppearancesAsset(param2,_loc4_,_loc5_);
            case "sprites":
               return new SpritesAsset(param2,_loc4_,_loc5_,_loc6_);
            default:
               return null;
         }
      }
      
      public function get rawBytes() : ByteArray
      {
         return this.m_RawBytes;
      }
      
      public function get size() : int
      {
         return this.m_Size;
      }
      
      protected function loadURL() : void
      {
         this.unloadLoader();
         this.m_Loader = new URLLoader();
         this.m_Loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.m_Loader.addEventListener(Event.COMPLETE,this.onLoaderComplete);
         this.m_Loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
         this.m_Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoaderError);
         this.m_Loader.addEventListener(ProgressEvent.PROGRESS,this.onLoaderProgress);
         this.m_Loader.load(new URLRequest(this.m_URL));
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function load() : void
      {
         var _SharedObject:SharedObject = null;
         this.m_RawBytes = null;
         System.pauseForGCIfCollectionImminent(0.95);
         var _SharedObjectManager:SharedObjectManager = SharedObjectManager.s_GetInstance();
         if(Boolean(SharedObjectManager.s_SharedObjectsAvailable()) && _SharedObjectManager != null)
         {
            try
            {
               _SharedObject = _SharedObjectManager.getLocal(this.m_Name);
               this.m_RawBytes = _SharedObject.data.RAW_BYTES;
            }
            catch(_Error:*)
            {
            }
         }
         if(this.m_RawBytes != null && this.m_RawBytes.length == this.m_Size)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.loadURL();
         }
      }
      
      protected function onLoaderError(param1:ErrorEvent) : void
      {
         if(param1 != null && this.m_Loader != null)
         {
            this.unloadLoader();
            this.m_RawBytes = null;
            System.pauseForGCIfCollectionImminent(0.25);
            dispatchEvent(param1.clone());
         }
      }
      
      public function get URL() : String
      {
         return this.m_URL;
      }
      
      protected function onLoaderComplete(param1:Event) : void
      {
         var _SharedObjectManager:SharedObjectManager = null;
         var _SharedObject:SharedObject = null;
         var a_Event:Event = param1;
         if(a_Event != null && this.m_Loader != null)
         {
            this.m_RawBytes = this.m_Loader.data;
            this.unloadLoader();
            _SharedObjectManager = SharedObjectManager.s_GetInstance();
            if(Boolean(SharedObjectManager.s_SharedObjectsAvailable()) && _SharedObjectManager != null)
            {
               try
               {
                  _SharedObject = _SharedObjectManager.getLocal(this.m_Name);
                  _SharedObject.data.RAW_BYTES = this.m_RawBytes;
                  _SharedObject.flush();
                  _SharedObjectManager.syncListing();
               }
               catch(_Error:*)
               {
               }
            }
            dispatchEvent(a_Event.clone());
         }
      }
      
      public function get isLoaded() : Boolean
      {
         return this.m_RawBytes != null;
      }
      
      protected function onLoaderProgress(param1:ProgressEvent) : void
      {
         if(param1 != null)
         {
            dispatchEvent(param1.clone());
         }
      }
      
      protected function unloadLoader() : void
      {
         if(this.m_Loader != null)
         {
            this.m_Loader.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
            this.m_Loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
            this.m_Loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoaderError);
            this.m_Loader.removeEventListener(ProgressEvent.PROGRESS,this.onLoaderProgress);
            this.m_Loader = null;
         }
      }
      
      public function unload() : void
      {
         this.unloadLoader();
         this.m_RawBytes = null;
         System.pauseForGCIfCollectionImminent(0.95);
      }
   }
}

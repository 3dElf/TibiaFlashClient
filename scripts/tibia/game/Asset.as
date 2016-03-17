package tibia.game
{
   import flash.system.System;
   import flash.utils.ByteArray;
   import shared.utility.SharedObjectManager;
   import flash.net.SharedObject;
   import flash.events.Event;
   import flash.net.URLLoader;
   
   public class Asset extends AssetBase
   {
       
      private var m_RawBytes:ByteArray = null;
      
      public function Asset(param1:String, param2:int)
      {
         super(param1,param2);
      }
      
      public static function s_FromXML(param1:XML) : AssetBase
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:String = param1 != null?param1.localName():null;
         var _loc3_:XMLList = null;
         if(_loc2_ == "appearances" || _loc2_ == "binary" || _loc2_ == "currentOptions" || _loc2_ == "defaultOptions" || _loc2_ == "sprites")
         {
            if((_loc3_ = param1.url) == null || _loc3_.length() != 1)
            {
               return null;
            }
            _loc4_ = _loc3_[0].toString();
            _loc5_ = 0;
            if((_loc3_ = param1.size) != null && _loc3_.length() == 1 && _loc3_[0].toString().match(/^[1-9[0-9]*$/) != null)
            {
               _loc5_ = int(_loc3_[0].toString());
            }
            if(_loc2_ != "currentOptions" && _loc2_ != "defaultOptions" && _loc5_ < 1)
            {
               return null;
            }
            if(_loc2_ == "appearances")
            {
               return new AppearancesAsset(_loc4_,_loc5_);
            }
            if(_loc2_ == "binary")
            {
               return new GameBinaryAsset(_loc4_,_loc5_);
            }
            if(_loc2_ == "currentOptions")
            {
               return new OptionsAsset(_loc4_,_loc5_,"application/json",false);
            }
            if(_loc2_ == "defaultOptions")
            {
               return new OptionsAsset(_loc4_,_loc5_,"text/xml",true);
            }
            _loc6_ = -1;
            if((_loc3_ = param1.startid) != null && _loc3_.length() == 1 && _loc3_[0].toString().match(/^[0-9]+$/) != null)
            {
               _loc6_ = int(_loc3_[0].toString());
            }
            return new SpritesAsset(_loc4_,_loc5_,_loc6_);
         }
         return null;
      }
      
      override protected function resetDownloadedData() : void
      {
         this.m_RawBytes = null;
         System.pauseForGCIfCollectionImminent(0.95);
      }
      
      public function get rawBytes() : ByteArray
      {
         return this.m_RawBytes;
      }
      
      override public function load() : void
      {
         var _SharedObject:SharedObject = null;
         this.resetDownloadedData();
         var _SharedObjectManager:SharedObjectManager = SharedObjectManager.s_GetInstance();
         if(Boolean(SharedObjectManager.s_SharedObjectsAvailable()) && _SharedObjectManager != null)
         {
            try
            {
               _SharedObject = _SharedObjectManager.getLocal(name);
               this.m_RawBytes = _SharedObject.data.RAW_BYTES;
            }
            catch(e:*)
            {
            }
         }
         if(this.m_RawBytes != null && (size == 0 || this.m_RawBytes.length == size))
         {
            dispatchEvent(new Event(Event.COMPLETE,false,false));
         }
         else
         {
            super.load();
         }
      }
      
      override protected function processDownloadedData(param1:URLLoader) : Boolean
      {
         var _SharedObject:SharedObject = null;
         var a_Loader:URLLoader = param1;
         this.m_RawBytes = a_Loader.data;
         var _SharedObjectManager:SharedObjectManager = SharedObjectManager.s_GetInstance();
         if(Boolean(SharedObjectManager.s_SharedObjectsAvailable()) && _SharedObjectManager != null)
         {
            try
            {
               _SharedObject = _SharedObjectManager.getLocal(name);
               _SharedObject.data.RAW_BYTES = this.m_RawBytes;
               _SharedObject.flush();
               _SharedObjectManager.syncListing();
            }
            catch(e:*)
            {
            }
         }
         return true;
      }
   }
}

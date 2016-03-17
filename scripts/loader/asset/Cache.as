package loader.asset
{
   import flash.events.EventDispatcher;
   import flash.events.ErrorEvent;
   import tibia.game.Asset;
   import tibia.game.AppearancesAsset;
   import tibia.game.SpritesAsset;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import shared.utility.SharedObjectManager;
   import tibia.game.GameBinaryAsset;
   import flash.events.ProgressEvent;
   
   public class Cache extends EventDispatcher
   {
      
      private static const STATE_CATALOGS_LOADING:int = 1;
      
      private static const NUM_PARALLEL:int = 3;
      
      private static const STATE_ASSETS_LOADING:int = 2;
      
      private static const STATE_DONE:int = 3;
      
      private static const STATE_DEFAULT:int = 0;
      
      private static const ERROR_INTERNAL:String = "Internal error while loading the assets.";
      
      private static const STATE_ERROR:int = -1;
       
      protected var m_BytesTotal:int = 0;
      
      protected var m_Timer:Timer = null;
      
      protected var m_BytesLoaded:int = 0;
      
      protected var m_State:int = 0;
      
      protected var m_LoadNext:int = 0;
      
      protected var m_Catalogs:Vector.<loader.asset.Catalog>;
      
      protected var m_LoadConcurrent:int = 0;
      
      protected var m_Assets:Vector.<Asset>;
      
      public function Cache()
      {
         this.m_Assets = new Vector.<Asset>();
         this.m_Catalogs = new Vector.<loader.asset.Catalog>();
         super();
      }
      
      private function loadError(param1:ErrorEvent = null) : void
      {
         var _loc2_:ErrorEvent = null;
         this.unloadTimer();
         this.unloadCatalogs();
         this.unloadAssets();
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
      
      public function getContent() : Vector.<Asset>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<Asset> = new Vector.<Asset>();
         if(this.m_State == STATE_DONE)
         {
            _loc2_ = this.m_Assets.length - 1;
            while(_loc2_ >= 0)
            {
               if(this.m_Assets[_loc2_] is AppearancesAsset || this.m_Assets[_loc2_] is SpritesAsset)
               {
                  _loc1_.push(this.m_Assets[_loc2_]);
               }
               _loc2_--;
            }
         }
         return _loc1_;
      }
      
      protected function onAssetError(param1:ErrorEvent) : void
      {
         var _loc2_:Asset = null;
         if(param1 != null && (_loc2_ = param1.target as Asset) != null)
         {
            _loc2_.removeEventListener(ErrorEvent.ERROR,this.onAssetError);
            _loc2_.removeEventListener(Event.COMPLETE,this.onAssetComplete);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onAssetError);
            _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onAssetError);
         }
         this.loadError(param1);
      }
      
      protected function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Event = null;
         switch(this.m_State)
         {
            case STATE_CATALOGS_LOADING:
               if(!this.loadCatalog() && this.m_LoadConcurrent == 0)
               {
                  if(this.checkAssets())
                  {
                     this.m_LoadNext = 0;
                     this.m_State = STATE_ASSETS_LOADING;
                  }
                  else
                  {
                     this.loadError();
                  }
               }
               break;
            case STATE_ASSETS_LOADING:
               if(!this.loadAsset() && this.m_LoadConcurrent == 0)
               {
                  this.unloadCatalogs();
                  this.unloadTimer();
                  this.removeObsoleteAssets();
                  this.m_State = STATE_DONE;
                  _loc2_ = new Event(Event.COMPLETE);
                  dispatchEvent(_loc2_);
               }
               break;
            default:
               this.loadError();
         }
      }
      
      protected function unloadTimer() : void
      {
         if(this.m_Timer != null)
         {
            this.m_Timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this.m_Timer.stop();
         }
      }
      
      public function addAsset(param1:Asset) : void
      {
         if(this.m_State >= STATE_ASSETS_LOADING)
         {
            throw new Error("Cache.addAsset: Cannot add asset while download is in progress.");
         }
         if(param1 != null)
         {
            this.m_Assets.push(param1);
            this.m_BytesTotal = this.m_BytesTotal + param1.size;
         }
      }
      
      public function get bytesLoaded() : int
      {
         return this.m_BytesLoaded;
      }
      
      public function get bytesTotal() : int
      {
         return this.m_BytesTotal;
      }
      
      protected function loadCatalog() : Boolean
      {
         var _loc1_:loader.asset.Catalog = null;
         if(this.m_Catalogs.length > this.m_LoadNext)
         {
            while(this.m_Catalogs.length > this.m_LoadNext && this.m_LoadConcurrent < NUM_PARALLEL)
            {
               _loc1_ = this.m_Catalogs[this.m_LoadNext++];
               _loc1_.addEventListener(ErrorEvent.ERROR,this.onCatalogError);
               _loc1_.addEventListener(Event.COMPLETE,this.onCatalogComplete);
               _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onCatalogError);
               _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCatalogError);
               _loc1_.load();
               this.m_LoadConcurrent++;
            }
            return true;
         }
         return false;
      }
      
      protected function unloadCatalogs() : void
      {
         var _loc1_:int = this.m_Catalogs.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.m_Catalogs[_loc1_] != null)
            {
               this.m_Catalogs[_loc1_].removeEventListener(ErrorEvent.ERROR,this.onCatalogError);
               this.m_Catalogs[_loc1_].removeEventListener(Event.COMPLETE,this.onCatalogComplete);
               this.m_Catalogs[_loc1_].removeEventListener(IOErrorEvent.IO_ERROR,this.onCatalogError);
               this.m_Catalogs[_loc1_].removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCatalogError);
               this.m_Catalogs[_loc1_].unload();
               this.m_Catalogs[_loc1_] = null;
            }
            _loc1_--;
         }
         this.m_Catalogs.length = 0;
      }
      
      protected function onCatalogComplete(param1:Event) : void
      {
         var _loc2_:loader.asset.Catalog = null;
         if(param1 != null && (_loc2_ = param1.target as loader.asset.Catalog) != null)
         {
            _loc2_.removeEventListener(ErrorEvent.ERROR,this.onCatalogError);
            _loc2_.removeEventListener(Event.COMPLETE,this.onCatalogComplete);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onCatalogError);
            _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCatalogError);
            this.m_LoadConcurrent--;
         }
      }
      
      private function removeObsoleteAssets() : void
      {
         var Listing:Array = null;
         var i:int = 0;
         var Name:String = null;
         var IsObsolete:Boolean = false;
         var j:int = 0;
         var _SharedObjectManager:SharedObjectManager = SharedObjectManager.s_GetInstance();
         if(Boolean(SharedObjectManager.s_SharedObjectsAvailable()) && _SharedObjectManager != null)
         {
            try
            {
               Listing = _SharedObjectManager.getListing();
               i = 0;
               while(i < Listing.length)
               {
                  Name = Listing[i] as String;
                  if(Name != null)
                  {
                     IsObsolete = true;
                     j = 0;
                     while(j < this.m_Assets.length)
                     {
                        if(this.m_Assets[j] != null && this.m_Assets[j].name == Name)
                        {
                           IsObsolete = false;
                           break;
                        }
                        j++;
                     }
                     if(IsObsolete)
                     {
                        _SharedObjectManager.clear(Name);
                     }
                  }
                  i++;
               }
               _SharedObjectManager.syncListing();
               return;
            }
            catch(_Error:*)
            {
               return;
            }
         }
      }
      
      protected function unloadAssets() : void
      {
         var _loc1_:int = this.m_Assets.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.m_Assets[_loc1_] != null)
            {
               this.m_Assets[_loc1_].removeEventListener(ErrorEvent.ERROR,this.onAssetError);
               this.m_Assets[_loc1_].removeEventListener(IOErrorEvent.IO_ERROR,this.onAssetError);
               this.m_Assets[_loc1_].removeEventListener(Event.COMPLETE,this.onAssetComplete);
               this.m_Assets[_loc1_].removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onAssetError);
               this.m_Assets[_loc1_].unload();
               this.m_Assets[_loc1_] = null;
            }
            _loc1_--;
         }
         this.m_Assets.length = 0;
         this.m_BytesLoaded = 0;
         this.m_BytesTotal = 0;
         this.m_LoadConcurrent = 0;
         this.m_LoadNext = 0;
      }
      
      public function load() : void
      {
         if(this.m_State == STATE_DEFAULT)
         {
            this.m_State = STATE_CATALOGS_LOADING;
            this.unloadTimer();
            this.m_Timer = new Timer(50,0);
            this.m_Timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this.m_Timer.start();
         }
      }
      
      protected function onCatalogError(param1:ErrorEvent) : void
      {
         var _loc2_:loader.asset.Catalog = null;
         if(param1 != null && (_loc2_ = param1.target as loader.asset.Catalog) != null)
         {
            _loc2_.removeEventListener(ErrorEvent.ERROR,this.onCatalogError);
            _loc2_.removeEventListener(Event.COMPLETE,this.onCatalogComplete);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onCatalogError);
            _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCatalogError);
         }
         this.loadError(param1);
      }
      
      protected function loadAsset() : Boolean
      {
         var _loc1_:Asset = null;
         if(this.m_Assets.length > this.m_LoadNext)
         {
            while(this.m_Assets.length > this.m_LoadNext && this.m_LoadConcurrent < NUM_PARALLEL)
            {
               _loc1_ = this.m_Assets[this.m_LoadNext++];
               _loc1_.addEventListener(ErrorEvent.ERROR,this.onAssetError);
               _loc1_.addEventListener(Event.COMPLETE,this.onAssetComplete);
               _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onAssetError);
               _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onAssetError);
               _loc1_.load();
               this.m_LoadConcurrent++;
            }
            return true;
         }
         return false;
      }
      
      private function checkAssets() : Boolean
      {
         var _loc6_:int = 0;
         if(this.m_State >= STATE_ASSETS_LOADING)
         {
            throw new Error("Cache.checkAssets: Cannot check assets while a download is in progress.");
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = this.m_Assets.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc5_ + 1;
            while(_loc6_ < _loc4_)
            {
               if(this.m_Assets[_loc6_].name == this.m_Assets[_loc5_].name)
               {
                  return false;
               }
               _loc6_++;
            }
            if(this.m_Assets[_loc5_] is GameBinaryAsset)
            {
               _loc1_++;
            }
            else if(this.m_Assets[_loc5_] is AppearancesAsset)
            {
               _loc2_++;
            }
            else if(this.m_Assets[_loc5_] is SpritesAsset)
            {
               _loc3_++;
            }
            else
            {
               return false;
            }
            _loc5_++;
         }
         return _loc1_ == 1 && _loc2_ == 1 && _loc3_ > 0;
      }
      
      public function getBinary() : GameBinaryAsset
      {
         var _loc1_:int = 0;
         if(this.m_State == STATE_DONE)
         {
            _loc1_ = this.m_Assets.length - 1;
            while(_loc1_ >= 0)
            {
               if(this.m_Assets[_loc1_] is GameBinaryAsset)
               {
                  return GameBinaryAsset(this.m_Assets[_loc1_]);
               }
               _loc1_--;
            }
         }
         return null;
      }
      
      public function addCatalog(param1:loader.asset.Catalog) : void
      {
         if(this.m_State >= STATE_CATALOGS_LOADING)
         {
            throw new Error("Cache.addCatalog: Cannot add catalog while download is in progress.");
         }
         if(param1 != null)
         {
            this.m_Catalogs.push(param1);
         }
      }
      
      protected function onAssetComplete(param1:Event) : void
      {
         var _loc3_:ProgressEvent = null;
         var _loc2_:Asset = null;
         if(param1 != null && (_loc2_ = param1.target as Asset) != null)
         {
            _loc2_.removeEventListener(ErrorEvent.ERROR,this.onAssetError);
            _loc2_.removeEventListener(Event.COMPLETE,this.onAssetComplete);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onAssetError);
            _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onAssetError);
            this.m_LoadConcurrent--;
            this.m_BytesLoaded = this.m_BytesLoaded + _loc2_.size;
            _loc3_ = new ProgressEvent(ProgressEvent.PROGRESS);
            _loc3_.bytesLoaded = this.m_BytesLoaded;
            _loc3_.bytesTotal = this.m_BytesTotal;
            dispatchEvent(_loc3_);
         }
      }
      
      public function unload() : void
      {
         this.unloadAssets();
         this.unloadCatalogs();
         this.unloadTimer();
      }
   }
}

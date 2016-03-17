package tibia.appearances
{
   import flash.events.EventDispatcher;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import tibia.game.Asset;
   import flash.events.Event;
   import tibia.game.SpritesAsset;
   import flash.display.Bitmap;
   import flash.events.IOErrorEvent;
   import flash.system.System;
   import tibia.game.AppearancesAsset;
   import flash.geom.Rectangle;
   import shared.utility.Vector3D;
   import tibia.market.MarketWidget;
   import flash.events.ErrorEvent;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import shared.utility.StringHelper;
   
   public class AppearanceStorage extends EventDispatcher
   {
      
      private static const ENVIRONMENTAL_EFFECTS:Array = [];
      
      protected static const RENDERER_DEFAULT_HEIGHT:Number = MAP_WIDTH * FIELD_SIZE;
      
      protected static const NUM_EFFECTS:int = 200;
      
      public static const FLAG_LIQUIDPOOL:int = 11;
      
      public static const FLAG_HOOKEAST:int = 19;
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      public static const FLAG_UNMOVE:int = 13;
      
      public static const FLAG_MULTIUSE:int = 7;
      
      public static const FLAG_IGNORELOOK:int = 31;
      
      public static const FLAG_WRITE:int = 8;
      
      public static const FLAG_BANK:int = 0;
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      public static const FLAG_FORCEUSE:int = 6;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE;
      
      public static const FLAG_LYINGOBJECT:int = 26;
      
      public static const FLAG_CLIP:int = 1;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      public static const FLAG_CONTAINER:int = 4;
      
      public static const FLAG_ANIMATION:int = 33;
      
      public static const FLAG_CLOTHES:int = 32;
      
      public static const FLAG_HOOKSOUTH:int = 18;
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      protected static const MAP_MAX_Z:int = 15;
      
      public static const FLAG_UNPASS:int = 12;
      
      public static const FLAG_BOTTOM:int = 2;
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      public static const FLAG_LIGHT:int = 21;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      public static const FLAG_HEIGHT:int = 25;
      
      public static const FLAG_HANG:int = 17;
      
      public static const FLAG_MARKET:int = 33;
      
      public static const FLAG_AUTOMAP:int = 28;
      
      protected static const GROUND_LAYER:int = 7;
      
      public static const FLAG_TAKE:int = 16;
      
      public static const FLAG_ANIMATEALWAYS:int = 27;
      
      protected static const MAP_HEIGHT:int = 11;
      
      public static const FLAG_ROTATE:int = 20;
      
      public static const FLAG_CUMULATIVE:int = 5;
      
      public static const FLAG_WRITEONCE:int = 9;
      
      public static const FLAG_UNSIGHT:int = 14;
      
      public static const FLAG_LENSHELP:int = 29;
      
      public static const FLAG_FULLBANK:int = 30;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      public static const FLAG_AVOID:int = 15;
      
      protected static const RENDERER_DEFAULT_WIDTH:Number = MAP_WIDTH * FIELD_SIZE;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      public static const FLAG_DONTHIDE:int = 22;
      
      public static const FLAG_SHIFT:int = 24;
      
      protected static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
      
      protected static const MAP_MIN_Z:int = 0;
      
      public static const FLAG_LIQUIDCONTAINER:int = 10;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
      
      public static const FLAG_TOP:int = 3;
      
      protected static const MAP_WIDTH:int = 15;
      
      public static const FLAG_TRANSLUCENT:int = 23;
       
      private var m_QueueLoaded:Boolean = false;
      
      private var m_SpriteBitmap:BitmapData = null;
      
      private var m_ObjectTypes:Vector.<tibia.appearances.AppearanceType>;
      
      private var m_SpriteBlockOffset:Array = null;
      
      private var m_QueueLoader:Loader = null;
      
      private var m_Queue:Vector.<Asset> = null;
      
      private var m_MissileTypes:Vector.<tibia.appearances.AppearanceType>;
      
      private var m_SpriteBlockColumns:uint = 0;
      
      private var m_MarketObjectTypes:Array;
      
      private var m_OutfitTypes:Vector.<tibia.appearances.AppearanceType>;
      
      private var m_SpriteBlockLength:Array = null;
      
      private var m_ObjectTypeInfoCache:Vector.<tibia.appearances.AppearanceTypeInfo>;
      
      private var m_EffectTypes:Vector.<tibia.appearances.AppearanceType>;
      
      public function AppearanceStorage()
      {
         this.m_ObjectTypes = new Vector.<tibia.appearances.AppearanceType>();
         this.m_OutfitTypes = new Vector.<tibia.appearances.AppearanceType>();
         this.m_MissileTypes = new Vector.<tibia.appearances.AppearanceType>();
         this.m_EffectTypes = new Vector.<tibia.appearances.AppearanceType>();
         this.m_MarketObjectTypes = [];
         this.m_ObjectTypeInfoCache = new Vector.<tibia.appearances.AppearanceTypeInfo>();
         super();
      }
      
      private function setTypeInfo(param1:Vector.<tibia.appearances.AppearanceTypeInfo>, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = param1.length - 1;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = -1;
         while(_loc5_ <= _loc6_)
         {
            _loc7_ = (_loc5_ + _loc6_) / 2;
            _loc8_ = AppearanceTypeRef.s_CompareExternal(param1[_loc7_],param2,param3);
            if(_loc8_ < 0)
            {
               _loc5_ = _loc7_ + 1;
               continue;
            }
            if(_loc8_ > 0)
            {
               _loc6_ = _loc7_ - 1;
               continue;
            }
            _loc9_ = _loc7_;
            break;
         }
         if(_loc9_ < 0)
         {
            param1.splice(_loc5_,0,new tibia.appearances.AppearanceTypeInfo(param2,param3,param4));
         }
         else
         {
            param1[_loc9_].name = param4;
         }
      }
      
      public function createEnvironmentalEffect(param1:int) : ObjectInstance
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = ENVIRONMENTAL_EFFECTS.length - 1;
         var _loc4_:int = 0;
         while(_loc2_ <= _loc3_)
         {
            _loc4_ = (_loc2_ + _loc3_) / 2;
            _loc5_ = ENVIRONMENTAL_EFFECTS[_loc4_];
            if(_loc5_.ID < param1)
            {
               _loc2_ = _loc4_ + 1;
               continue;
            }
            if(_loc5_.ID > param1)
            {
               _loc3_ = _loc4_ - _loc4_;
               continue;
            }
            _loc6_ = _loc5_.appearanceType;
            _loc7_ = !!_loc5_.atmospheric?1:0;
            return new ObjectInstance(_loc6_,this.m_ObjectTypes[_loc6_],_loc7_);
         }
         return null;
      }
      
      public function getObjectType(param1:int) : tibia.appearances.AppearanceType
      {
         if(param1 >= AppearanceInstance.CREATURE && param1 < this.m_ObjectTypes.length)
         {
            return this.m_ObjectTypes[param1];
         }
         return null;
      }
      
      public function createTextualEffectInstance(param1:int, param2:int, param3:Number) : TextualEffectInstance
      {
         return new TextualEffectInstance(param1,null,param2,param3);
      }
      
      public function hasOutfitType(param1:int) : Boolean
      {
         return Boolean(this.m_QueueLoaded) && param1 >= 1 && param1 < this.m_OutfitTypes.length;
      }
      
      public function setCachedObjectTypeName(param1:int, param2:int, param3:String) : void
      {
         if(param3 == null || param3.length < 1)
         {
            throw new ArgumentError("AppearanceStorage.setCachedObjectTypeName: Invalid name.");
         }
         this.setTypeInfo(this.m_ObjectTypeInfoCache,param1,param2,param3);
      }
      
      public function createObjectInstance(param1:int, param2:int) : ObjectInstance
      {
         if(param1 >= AppearanceInstance.CREATURE && param1 < this.m_ObjectTypes.length)
         {
            return new ObjectInstance(param1,this.m_ObjectTypes[param1],param2);
         }
         return null;
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var a_Event:Event = param1;
         var _Asset:SpritesAsset = null;
         if(this.m_Queue != null && this.m_Queue.length > 0)
         {
            _Asset = this.m_Queue.shift() as SpritesAsset;
         }
         var _Bitmap:BitmapData = null;
         if(this.m_QueueLoader != null && this.m_QueueLoader.contentLoaderInfo != null)
         {
            try
            {
               _Bitmap = Bitmap(this.m_QueueLoader.contentLoaderInfo.content).bitmapData;
            }
            catch(e:*)
            {
            }
            this.m_QueueLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
            this.m_QueueLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
            this.m_QueueLoader = null;
         }
         if(_Asset != null && _Bitmap != null)
         {
            this.mergeSpritesBitmap(_Asset.firstSpriteID,_Bitmap);
            _Asset.unload();
            _Bitmap.dispose();
            System.pauseForGCIfCollectionImminent(0.5);
            this.loadNext();
         }
         else
         {
            this.loadError();
         }
      }
      
      public function get marketObjectTypes() : Array
      {
         return this.m_MarketObjectTypes;
      }
      
      public function setContent(param1:Vector.<Asset>) : void
      {
         var _loc3_:AppearancesAsset = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = Boolean(this.m_QueueLoaded) || this.m_Queue != null;
         if(!_loc2_ && param1 != null && param1.length > 1)
         {
            _loc3_ = null;
            _loc4_ = param1.length - 1;
            while(_loc4_ >= 0)
            {
               if(param1[_loc4_] is AppearancesAsset)
               {
                  _loc3_ = AppearancesAsset(param1[_loc4_]);
               }
               else if(!(param1[_loc4_] is SpritesAsset))
               {
                  _loc3_ = null;
                  break;
               }
               _loc4_--;
            }
            _loc2_ = _loc3_ == null || !this.loadAppearances(_loc3_.rawBytes) || !this.allocateSpritesBitmap();
         }
         if(!_loc2_)
         {
            this.m_Queue = param1;
            this.loadNext();
         }
         else
         {
            this.loadError();
         }
      }
      
      private function getSprite(param1:uint, param2:Rectangle = null) : Rectangle
      {
         var _loc3_:* = param1 >> 29;
         var _loc4_:uint = param1 & 268435455;
         if(this.m_SpriteBlockOffset == null || this.m_SpriteBlockLength == null || _loc3_ < 0 || _loc4_ >= this.m_SpriteBlockLength[_loc3_])
         {
            return null;
         }
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         var _loc5_:uint = this.m_SpriteBlockOffset[_loc3_];
         switch(_loc3_)
         {
            case 0:
               _loc5_ = _loc5_ + (_loc4_ >>> 2);
               param2.x = (_loc4_ & 1) * FIELD_SIZE;
               param2.y = (_loc4_ & 2) * (FIELD_SIZE >>> 1);
               param2.width = FIELD_SIZE;
               param2.height = FIELD_SIZE;
               break;
            case 1:
               _loc5_ = _loc5_ + (_loc4_ >>> 1);
               param2.x = (_loc4_ & 1) * FIELD_SIZE;
               param2.y = 0;
               param2.width = FIELD_SIZE;
               param2.height = FIELD_SIZE << 1;
               break;
            case 2:
               _loc5_ = _loc5_ + (_loc4_ >>> 1);
               param2.x = 0;
               param2.y = (_loc4_ & 1) * FIELD_SIZE;
               param2.width = FIELD_SIZE << 1;
               param2.height = FIELD_SIZE;
               break;
            case 3:
               _loc5_ = _loc5_ + _loc4_;
               param2.x = 0;
               param2.y = 0;
               param2.width = FIELD_SIZE << 1;
               param2.height = FIELD_SIZE << 1;
         }
         param2.x = param2.x + _loc5_ % this.m_SpriteBlockColumns * (FIELD_SIZE << 1);
         param2.y = param2.y + int(_loc5_ / this.m_SpriteBlockColumns) * (FIELD_SIZE << 1);
         return param2;
      }
      
      public function createMissileInstance(param1:uint, param2:Vector3D, param3:Vector3D) : MissileInstance
      {
         if(param1 >= 1 && param1 < this.m_MissileTypes.length)
         {
            return new MissileInstance(param1,this.m_MissileTypes[param1],param2,param3);
         }
         return null;
      }
      
      private function postprocessAppearances() : Boolean
      {
         var _Type:tibia.appearances.AppearanceType = null;
         var i:int = 0;
         var j:int = 0;
         _Type = new tibia.appearances.AppearanceType(AppearanceInstance.CREATURE);
         _Type.isAvoid = true;
         _Type.isCachable = false;
         this.m_ObjectTypes[AppearanceInstance.CREATURE] = _Type;
         _Type = new tibia.appearances.AppearanceType(OutfitInstance.INVISIBLE_OUTFIT_ID);
         _Type.width = 1;
         _Type.height = 1;
         _Type.displacementX = 8;
         _Type.displacementY = 8;
         _Type.exactSize = FIELD_SIZE;
         _Type.layers = 1;
         _Type.patternWidth = 4;
         _Type.patternHeight = 1;
         _Type.patternDepth = 1;
         _Type.phases = 3;
         _Type.numSprites = _Type.phases * _Type.patternWidth;
         _Type.phaseDuration[0] = 300;
         _Type.phaseDuration[1] = 300;
         _Type.phaseDuration[2] = 300;
         _Type.totalDuration = 900;
         _Type.isDisplaced = true;
         _Type.isAnimateAlways = true;
         _Type.isAnimation = true;
         _Type.isCachable = false;
         i = 0;
         while(i < 3)
         {
            j = 0;
            while(j < 4)
            {
               _Type.sprite[i * 4 + j] = this.m_EffectTypes[13].sprite[i + 1].clone();
               j++;
            }
            i++;
         }
         this.m_OutfitTypes[OutfitInstance.INVISIBLE_OUTFIT_ID] = _Type;
         _Type = this.m_EffectTypes[34];
         i = 0;
         while(i < _Type.phases)
         {
            _Type.phaseDuration[i] = 300;
            i++;
         }
         _Type.totalDuration = _Type.phases * 300;
         _Type = this.m_EffectTypes[56];
         this.buildAnimationLoop(_Type,-1,_Type.phases * 2);
         i = 0;
         while(i < _Type.phases)
         {
            _Type.phaseDuration[i] = 500;
            i++;
         }
         _Type.totalDuration = _Type.phases * 500;
         _Type = this.m_EffectTypes[57];
         this.buildAnimationLoop(_Type,-1,_Type.phases * 2);
         i = 0;
         while(i < _Type.phases)
         {
            _Type.phaseDuration[i] = 500;
            i++;
         }
         _Type.totalDuration = _Type.phases * 500;
         _Type = new tibia.appearances.AppearanceType(MarketWidget.REQUEST_OWN_OFFERS);
         _Type.marketCategory = -1;
         _Type.marketShowAs = -1;
         _Type.marketTradeAs = MarketWidget.REQUEST_OWN_OFFERS;
         this.m_MarketObjectTypes.push(_Type);
         _Type = new tibia.appearances.AppearanceType(MarketWidget.REQUEST_OWN_HISTORY);
         _Type.marketCategory = -1;
         _Type.marketShowAs = -1;
         _Type.marketTradeAs = MarketWidget.REQUEST_OWN_HISTORY;
         this.m_MarketObjectTypes.push(_Type);
         this.m_MarketObjectTypes.sortOn("marketTradeAs",Array.NUMERIC);
         var UpdateSprite:Function = function(param1:AppearanceType, param2:int, param3:Vector.<AppearanceType>):void
         {
            var _loc4_:Rectangle = null;
            if(param1 != null)
            {
               param1.bitmap = m_SpriteBitmap;
               for each(_loc4_ in param1.sprite)
               {
                  if(_loc4_.x == -1)
                  {
                     getSprite(_loc4_.y,_loc4_);
                  }
               }
            }
         };
         this.m_ObjectTypes.forEach(UpdateSprite);
         this.m_OutfitTypes.forEach(UpdateSprite);
         this.m_EffectTypes.forEach(UpdateSprite);
         this.m_MissileTypes.forEach(UpdateSprite);
         return true;
      }
      
      private function loadError() : void
      {
         this.reset();
         var _loc1_:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
         dispatchEvent(_loc1_);
      }
      
      private function mergeSpritesBitmap(param1:uint, param2:BitmapData) : Boolean
      {
         if(param2 == null)
         {
            return false;
         }
         var _loc3_:Rectangle = this.getSprite(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         _loc3_.x = 0;
         _loc3_.y = 0;
         var _loc4_:Rectangle = null;
         this.m_SpriteBitmap.lock();
         while((_loc4_ = this.getSprite(param1,_loc4_)) != null)
         {
            this.m_SpriteBitmap.copyPixels(param2,_loc3_,_loc4_.topLeft);
            _loc3_.x = _loc3_.x + _loc3_.width;
            if(_loc3_.x >= param2.width)
            {
               _loc3_.x = 0;
               _loc3_.y = _loc3_.y + _loc3_.height;
               if(_loc3_.y >= param2.height)
               {
                  break;
               }
            }
            param1++;
         }
         this.m_SpriteBitmap.unlock();
         return true;
      }
      
      private function loadAppearances(param1:ByteArray) : Boolean
      {
         if(param1 == null || param1.bytesAvailable < 12)
         {
            return false;
         }
         var _loc2_:String = param1.endian;
         param1.endian = Endian.LITTLE_ENDIAN;
         this.m_ObjectTypes.length = param1.readUnsignedShort() + 1;
         this.m_OutfitTypes.length = param1.readUnsignedShort() + 1;
         this.m_EffectTypes.length = param1.readUnsignedShort() + 1;
         this.m_MissileTypes.length = param1.readUnsignedShort() + 1;
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = AppearanceInstance.CREATURE + 1;
         _loc5_ = this.m_ObjectTypes.length;
         while(Boolean(_loc3_) && _loc4_ < _loc5_)
         {
            _loc3_ = this.readAppearanceType(param1,this.m_ObjectTypes,_loc4_);
            _loc4_++;
         }
         _loc4_ = 1;
         _loc5_ = this.m_OutfitTypes.length;
         while(Boolean(_loc3_) && _loc4_ < _loc5_)
         {
            _loc3_ = this.readAppearanceType(param1,this.m_OutfitTypes,_loc4_);
            _loc4_++;
         }
         _loc4_ = 1;
         _loc5_ = this.m_EffectTypes.length;
         while(Boolean(_loc3_) && _loc4_ < _loc5_)
         {
            _loc3_ = this.readAppearanceType(param1,this.m_EffectTypes,_loc4_);
            _loc4_++;
         }
         _loc4_ = 1;
         _loc5_ = this.m_MissileTypes.length;
         while(Boolean(_loc3_) && _loc4_ < _loc5_)
         {
            _loc3_ = this.readAppearanceType(param1,this.m_MissileTypes,_loc4_);
            _loc4_++;
         }
         _loc3_ = Boolean(_loc3_) && param1.bytesAvailable == 0;
         param1.endian = _loc2_;
         return _loc3_;
      }
      
      public function reset() : void
      {
         this.m_ObjectTypes.length = 0;
         this.m_OutfitTypes.length = 0;
         this.m_MissileTypes.length = 0;
         this.m_EffectTypes.length = 0;
         this.m_MarketObjectTypes.length = 0;
         this.m_Queue = null;
         this.m_QueueLoaded = false;
         if(this.m_QueueLoader != null)
         {
            this.m_QueueLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
            this.m_QueueLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
            try
            {
               this.m_QueueLoader.close();
            }
            catch(_Error:*)
            {
            }
            this.m_QueueLoader = null;
         }
         this.m_ObjectTypeInfoCache.length = 0;
         if(this.m_SpriteBitmap != null)
         {
            this.m_SpriteBitmap.dispose();
         }
         this.m_SpriteBitmap = null;
         this.m_SpriteBlockOffset = null;
         this.m_SpriteBlockLength = null;
      }
      
      public function getOutfitType(param1:int) : tibia.appearances.AppearanceType
      {
         if(param1 >= 1 && param1 < this.m_OutfitTypes.length)
         {
            return this.m_OutfitTypes[param1];
         }
         return null;
      }
      
      public function createOutfitInstance(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : OutfitInstance
      {
         if(param1 >= 1 && param1 < this.m_OutfitTypes.length || param1 == OutfitInstance.INVISIBLE_OUTFIT_ID)
         {
            return new OutfitInstance(param1,this.m_OutfitTypes[param1],param2,param3,param4,param5,param6);
         }
         return null;
      }
      
      public function get isLoaded() : Boolean
      {
         return this.m_QueueLoaded;
      }
      
      private function onLoaderError(param1:Event) : void
      {
         if(this.m_QueueLoader != null)
         {
            this.m_QueueLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
            this.m_QueueLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
         }
         this.loadError();
      }
      
      private function allocateSpritesBitmap() : Boolean
      {
         var SpriteLength:Array = null;
         var BlockLength:Array = null;
         var BlockTotal:uint = 0;
         var BlockColumns:uint = 0;
         var GetSpriteLength:Function = function(param1:AppearanceType, param2:int, param3:Vector.<AppearanceType>):void
         {
            var _loc4_:Rectangle = null;
            var _loc5_:* = 0;
            var _loc6_:uint = 0;
            if(param1 != null)
            {
               for each(_loc4_ in param1.sprite)
               {
                  if(_loc4_.x == -1)
                  {
                     _loc5_ = uint(_loc4_.y) >> 29;
                     _loc6_ = uint(_loc4_.y) & 268435455;
                     if(_loc5_ >= 0)
                     {
                        this[_loc5_] = Math.max(this[_loc5_],_loc6_ + 1);
                     }
                  }
               }
            }
         };
         SpriteLength = [0,0,0,0];
         this.m_ObjectTypes.forEach(GetSpriteLength,SpriteLength);
         this.m_OutfitTypes.forEach(GetSpriteLength,SpriteLength);
         this.m_EffectTypes.forEach(GetSpriteLength,SpriteLength);
         this.m_MissileTypes.forEach(GetSpriteLength,SpriteLength);
         BlockLength = [Math.ceil(SpriteLength[0] / 4),Math.ceil(SpriteLength[1] / 2),Math.ceil(SpriteLength[2] / 2),SpriteLength[3]];
         BlockTotal = BlockLength[0] + BlockLength[1] + BlockLength[2] + BlockLength[3];
         BlockColumns = Math.ceil(Math.sqrt(BlockTotal));
         var BlockRows:uint = Math.ceil(BlockTotal / BlockColumns);
         var AllocationSuccessfull:Boolean = false;
         try
         {
            this.m_SpriteBitmap = new BitmapData(BlockColumns * (FIELD_SIZE << 1),BlockRows * (FIELD_SIZE << 1),true,4278255360);
            this.m_SpriteBlockColumns = BlockColumns;
            this.m_SpriteBlockOffset = [0,BlockLength[0],BlockLength[0] + BlockLength[1],BlockLength[0] + BlockLength[1] + BlockLength[2]];
            this.m_SpriteBlockLength = SpriteLength;
            AllocationSuccessfull = true;
         }
         catch(_Error:Error)
         {
         }
         return AllocationSuccessfull;
      }
      
      public function createEffectInstance(param1:int) : EffectInstance
      {
         if(param1 >= 1 && param1 < this.m_EffectTypes.length)
         {
            return new EffectInstance(param1,this.m_EffectTypes[param1]);
         }
         return null;
      }
      
      public function getMarketObjectType(param1:*) : tibia.appearances.AppearanceType
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:tibia.appearances.AppearanceType = null;
         if(this.m_QueueLoaded)
         {
            _loc2_ = -1;
            if(param1 is tibia.appearances.AppearanceType && Boolean(AppearanceType(param1).isMarket))
            {
               _loc2_ = AppearanceType(param1).marketTradeAs;
            }
            else
            {
               _loc2_ = int(param1);
            }
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = this.m_MarketObjectTypes.length - 1;
            while(_loc4_ <= _loc5_)
            {
               _loc3_ = _loc4_ + _loc5_ >>> 1;
               _loc6_ = AppearanceType(this.m_MarketObjectTypes[_loc3_]);
               if(_loc6_.marketTradeAs == _loc2_)
               {
                  return _loc6_;
               }
               if(_loc6_.marketTradeAs < _loc2_)
               {
                  _loc4_ = _loc3_ + 1;
               }
               else
               {
                  _loc5_ = _loc3_ - 1;
               }
            }
         }
         return null;
      }
      
      private function readAppearanceType(param1:ByteArray, param2:Vector.<tibia.appearances.AppearanceType>, param3:int, param4:int = 0) : Boolean
      {
         var _loc8_:int = 0;
         if(param1 == null || param1.bytesAvailable < 11)
         {
            return false;
         }
         var _loc5_:tibia.appearances.AppearanceType = new tibia.appearances.AppearanceType(param3);
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         loop0:
         while(true)
         {
            if(_loc6_ >= 255)
            {
               _loc5_.width = param1.readUnsignedByte();
               _loc5_.height = param1.readUnsignedByte();
               if(_loc5_.width > 1 || _loc5_.height > 1)
               {
                  _loc5_.exactSize = param1.readUnsignedByte();
               }
               else
               {
                  _loc5_.exactSize = FIELD_SIZE;
               }
               _loc5_.layers = param1.readUnsignedByte();
               _loc5_.patternWidth = param1.readUnsignedByte();
               _loc5_.patternHeight = param1.readUnsignedByte();
               _loc5_.patternDepth = param1.readUnsignedByte();
               _loc5_.phases = param1.readUnsignedByte();
               _loc5_.totalDuration = 0;
               if(_loc5_.phases > 1)
               {
                  _loc5_.isAnimation = true;
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_.phases)
                  {
                     _loc5_.phaseDuration[_loc7_] = param1.readUnsignedInt();
                     _loc5_.totalDuration = _loc5_.totalDuration + _loc5_.phaseDuration[_loc7_];
                     _loc7_++;
                  }
               }
               _loc5_.numSprites = _loc5_.layers * _loc5_.patternWidth * _loc5_.patternHeight * _loc5_.patternDepth * _loc5_.phases;
               _loc7_ = 0;
               while(_loc7_ < _loc5_.numSprites)
               {
                  _loc5_.sprite[_loc7_] = new Rectangle(-1,param1.readUnsignedInt(),0,0);
                  _loc7_++;
               }
               _loc5_.isCachable = !_loc5_.isAnimation && !_loc5_.isHangable && !_loc5_.isLight && _loc5_.exactSize + Math.max(_loc5_.displacementX,_loc5_.displacementY) <= FIELD_CACHESIZE;
               param2[param3] = _loc5_;
               if(_loc5_.isMarket)
               {
                  _loc8_ = -1;
                  _loc8_ = this.m_MarketObjectTypes.length - 1;
                  while(_loc8_ >= 0)
                  {
                     if(_loc5_.marketTradeAs == AppearanceType(this.m_MarketObjectTypes[_loc8_]).marketTradeAs)
                     {
                        break;
                     }
                     _loc8_--;
                  }
                  if(_loc8_ < 0)
                  {
                     this.m_MarketObjectTypes.push(_loc5_);
                  }
               }
               return true;
            }
            _loc6_ = param1.readUnsignedByte();
            switch(_loc6_)
            {
               case FLAG_BANK:
                  _loc5_.isBank = true;
                  _loc5_.waypoints = param1.readUnsignedShort();
                  continue;
               case FLAG_CLIP:
                  _loc5_.isClip = true;
                  continue;
               case FLAG_BOTTOM:
                  _loc5_.isBottom = true;
                  continue;
               case FLAG_TOP:
                  _loc5_.isTop = true;
                  continue;
               case FLAG_CONTAINER:
                  _loc5_.isContainer = true;
                  continue;
               case FLAG_CUMULATIVE:
                  _loc5_.isCumulative = true;
                  continue;
               case FLAG_FORCEUSE:
                  _loc5_.isForceUse = true;
                  continue;
               case FLAG_MULTIUSE:
                  _loc5_.isMultiUse = true;
                  continue;
               case FLAG_WRITE:
                  _loc5_.isWriteable = true;
                  _loc5_.maxTextLength = param1.readUnsignedShort();
                  continue;
               case FLAG_WRITEONCE:
                  _loc5_.isWriteableOnce = true;
                  _loc5_.maxTextLength = param1.readUnsignedShort();
                  continue;
               case FLAG_LIQUIDCONTAINER:
                  _loc5_.isLiquidContainer = true;
                  continue;
               case FLAG_LIQUIDPOOL:
                  _loc5_.isLiquidPool = true;
                  continue;
               case FLAG_UNPASS:
                  _loc5_.isUnpassable = true;
                  continue;
               case FLAG_UNMOVE:
                  _loc5_.isUnmoveable = true;
                  continue;
               case FLAG_UNSIGHT:
                  _loc5_.isUnsight = true;
                  continue;
               case FLAG_AVOID:
                  _loc5_.isAvoid = true;
                  continue;
               case FLAG_TAKE:
                  _loc5_.isTakeable = true;
                  continue;
               case FLAG_HANG:
                  _loc5_.isHangable = true;
                  continue;
               case FLAG_HOOKSOUTH:
                  _loc5_.isHookSouth = true;
                  continue;
               case FLAG_HOOKEAST:
                  _loc5_.isHookEast = true;
                  continue;
               case FLAG_ROTATE:
                  _loc5_.isRotateable = true;
                  continue;
               case FLAG_LIGHT:
                  _loc5_.isLight = true;
                  _loc5_.brightness = param1.readUnsignedShort();
                  _loc5_.lightColour = param1.readUnsignedShort();
                  continue;
               case FLAG_DONTHIDE:
                  _loc5_.isDonthide = true;
                  continue;
               case FLAG_TRANSLUCENT:
                  _loc5_.isTranslucent = true;
                  continue;
               case FLAG_SHIFT:
                  _loc5_.isDisplaced = true;
                  _loc5_.displacementX = param1.readUnsignedShort();
                  _loc5_.displacementY = param1.readUnsignedShort();
                  continue;
               case FLAG_HEIGHT:
                  _loc5_.isHeight = true;
                  _loc5_.elevation = param1.readUnsignedShort();
                  continue;
               case FLAG_LYINGOBJECT:
                  _loc5_.isLyingObject = true;
                  continue;
               case FLAG_ANIMATEALWAYS:
                  _loc5_.isAnimateAlways = true;
                  continue;
               case FLAG_AUTOMAP:
                  _loc5_.isAutomap = true;
                  _loc5_.automapColour = param1.readUnsignedShort();
                  continue;
               case FLAG_LENSHELP:
                  _loc5_.isLensHelp = true;
                  _loc5_.lensHelp = param1.readUnsignedShort();
                  continue;
               case FLAG_FULLBANK:
                  _loc5_.isFullBank = true;
                  continue;
               case FLAG_IGNORELOOK:
                  _loc5_.isIgnoreLook = true;
                  continue;
               case FLAG_CLOTHES:
                  _loc5_.isCloth = true;
                  _loc5_.clothSlot = param1.readUnsignedShort();
                  continue;
               case FLAG_MARKET:
                  _loc5_.isMarket = true;
                  _loc5_.marketCategory = param1.readUnsignedShort();
                  if(!MarketWidget.isValidCategoryID(_loc5_.marketCategory))
                  {
                     throw new Error("AppearanceStorage.readAppearanceType: Invalid market category  " + _loc5_.marketCategory + ".");
                  }
                  _loc5_.marketTradeAs = param1.readUnsignedShort();
                  _loc5_.marketShowAs = param1.readUnsignedShort();
                  _loc5_.marketName = StringHelper.s_ReadFromByteArray(param1,MarketWidget.DETAIL_NAME_LENGTH);
                  _loc5_.marketNameLowerCase = _loc5_.marketName.toLowerCase();
                  _loc5_.marketRestrictProfession = param1.readUnsignedShort();
                  _loc5_.marketRestrictLevel = param1.readUnsignedShort();
                  continue;
               case 255:
                  continue;
               default:
                  break loop0;
            }
         }
         throw new Error("AppearanceStorage.readAppearanceType: Invalid flag: " + _loc6_ + ".");
      }
      
      private function loadNext() : void
      {
         var _loc1_:Asset = null;
         var _loc2_:Event = null;
         if(Boolean(this.m_QueueLoaded) || this.m_Queue == null || this.m_QueueLoader != null)
         {
            this.loadError();
         }
         else if(this.m_Queue.length > 0)
         {
            _loc1_ = this.m_Queue[0];
            if(_loc1_ is SpritesAsset)
            {
               this.m_QueueLoader = new Loader();
               this.m_QueueLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderComplete);
               this.m_QueueLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
               this.m_QueueLoader.loadBytes(_loc1_.rawBytes);
            }
            else if(_loc1_ is AppearancesAsset)
            {
               this.m_Queue.shift();
               this.loadNext();
            }
            else
            {
               this.loadError();
            }
         }
         else if(this.postprocessAppearances())
         {
            this.m_QueueLoaded = true;
            this.m_Queue = null;
            this.m_QueueLoader = null;
            System.pauseForGCIfCollectionImminent(0.25);
            _loc2_ = new Event(Event.COMPLETE);
            dispatchEvent(_loc2_);
         }
         else
         {
            this.loadError();
         }
      }
      
      private function buildAnimationLoop(param1:tibia.appearances.AppearanceType, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(!param1.isAnimation)
         {
            return;
         }
         if(param3 < 1)
         {
            return;
         }
         if(param2 < 0)
         {
            param2 = 1;
            while(param2 < param1.phases)
            {
               _loc6_ = param2 * param1.patternDepth * param1.patternHeight * param1.patternWidth;
               if(param1.sprite[_loc6_].equals(param1.sprite[0]))
               {
                  break;
               }
               param2++;
            }
         }
         else
         {
            param2 = Math.max(0,Math.min(param2,param1.phases));
         }
         if(param2 == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         _loc4_ = param2;
         while(_loc4_ < param3)
         {
            _loc7_ = 0;
            while(_loc7_ < param1.patternWidth)
            {
               _loc8_ = 0;
               while(_loc8_ < param1.patternHeight)
               {
                  _loc9_ = 0;
                  while(_loc9_ < param1.patternDepth)
                  {
                     _loc10_ = ((_loc4_ % param2 * param1.patternDepth + _loc9_) * param1.patternHeight + _loc8_) * param1.patternWidth + _loc7_;
                     _loc11_ = ((_loc4_ * param1.patternDepth + _loc9_) * param1.patternHeight + _loc8_) * param1.patternWidth + _loc7_;
                     param1.sprite[_loc11_] = param1.sprite[_loc10_].clone();
                     param1.phaseDuration[_loc4_] = param1.phaseDuration[_loc4_ % param2];
                     _loc9_++;
                  }
                  _loc8_++;
               }
               _loc7_++;
            }
            _loc4_++;
         }
         var _loc5_:int = param3 * param1.patternDepth * param1.patternHeight * param1.patternWidth;
         param1.numSprites = _loc5_;
         param1.sprite.length = _loc5_;
         param1.phases = param3;
         param1.phaseDuration.length = param3;
         param1.totalDuration = 0;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            param1.totalDuration = param1.totalDuration + param1.phaseDuration[_loc4_];
            _loc4_++;
         }
      }
      
      public function getCachedObjectTypeName(param1:int, param2:int) : String
      {
         var _loc3_:tibia.appearances.AppearanceTypeInfo = this.getTypeInfo(this.m_ObjectTypeInfoCache,param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_.name;
         }
         return null;
      }
      
      private function getTypeInfo(param1:Vector.<tibia.appearances.AppearanceTypeInfo>, param2:int, param3:int) : tibia.appearances.AppearanceTypeInfo
      {
         var _loc4_:int = 0;
         var _loc5_:int = param1.length - 1;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc4_ <= _loc5_)
         {
            _loc6_ = (_loc4_ + _loc5_) / 2;
            _loc7_ = AppearanceTypeRef.s_CompareExternal(param1[_loc6_],param2,param3);
            if(_loc7_ < 0)
            {
               _loc4_ = _loc6_ + 1;
               continue;
            }
            if(_loc7_ > 0)
            {
               _loc5_ = _loc6_ - 1;
               continue;
            }
            return param1[_loc6_];
         }
         return null;
      }
   }
}

package tibia.appearances
{
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import tibia.appearances.widgetClasses.CachedSpriteInformation;
   import flash.display.BitmapData;
   
   public class AppearanceInstance
   {
      
      protected static const s_TempRect:Rectangle = new Rectangle(0,0,0,0);
      
      public static const CREATURE:int = 99;
      
      public static const OUTDATEDCREATURE:int = 98;
      
      public static const UNKNOWNCREATURE:int = 97;
      
      public static const PHASE_ASYNCHRONOUS:int = 255;
      
      protected static const s_TempPoint:Point = new Point(0,0);
      
      public static const PHASE_RANDOM:int = 254;
      
      public static const PURSE:int = 16087;
       
      var mapField:int = -1;
      
      var m_Phase:int = 0;
      
      protected var m_LastPhase:int = -2.147483648E9;
      
      protected var m_LastInternalPhase:int = -2.147483648E9;
      
      protected var m_CacheDirty:Boolean = false;
      
      protected var m_LastPhaseChange:Number = 0;
      
      var mapData:int = -1;
      
      protected var m_LastCachedSpriteIndex:uint = 4.294967295E9;
      
      var m_Type:tibia.appearances.AppearanceType = null;
      
      protected var m_LastPatternX:int = -2.147483648E9;
      
      protected var m_LastPatternY:int = -2.147483648E9;
      
      protected var m_LastPatternZ:int = -2.147483648E9;
      
      var m_ID:int = 0;
      
      protected var m_TempAlternativePhases:Vector.<uint> = null;
      
      public function AppearanceInstance(param1:int, param2:tibia.appearances.AppearanceType)
      {
         super();
         this.m_ID = param1;
         this.m_Type = param2;
         if(this.m_Type != null && Boolean(this.m_Type.isAnimation))
         {
            this.m_TempAlternativePhases = new Vector.<uint>(this.m_Type.phases,true);
         }
      }
      
      public function get type() : tibia.appearances.AppearanceType
      {
         return this.m_Type;
      }
      
      public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : CachedSpriteInformation
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = this.getSpriteIndex(param1,param2,param3,param4);
         var _loc7_:CachedSpriteInformation = this.m_Type.cachedSpriteInformations[_loc6_];
         _loc7_ = this.m_Type.spriteProvider.getSprite(_loc7_.spriteID,_loc7_,this.m_Type);
         if(_loc7_.cacheMiss == false || param5 == false)
         {
            return _loc7_;
         }
         _loc8_ = 0;
         while(_loc8_ < this.m_Type.phases)
         {
            _loc9_ = this.getSpriteIndex(_loc8_,param2,param3,param4);
            _loc7_ = this.m_Type.cachedSpriteInformations[_loc9_];
            _loc7_ = this.m_Type.spriteProvider.getSprite(_loc7_.spriteID,_loc7_,this.m_Type);
            if(_loc7_.cacheMiss == false)
            {
               break;
            }
            _loc8_++;
         }
         return _loc7_;
      }
      
      public function getSpriteIndex(param1:int, param2:int, param3:int, param4:int) : uint
      {
         if(param1 == this.m_LastPhase && this.m_Phase == this.m_LastInternalPhase && param2 == this.m_LastPatternX && param4 >= 0 && param3 == this.m_LastPatternY && param3 >= 0 && param4 == this.m_LastPatternZ && param2 >= 0)
         {
            return this.m_LastCachedSpriteIndex;
         }
         var _loc5_:int = (param1 >= 0?param1:this.m_Phase) % this.m_Type.phases;
         var _loc6_:int = param4 >= 0?int(param4 % this.m_Type.patternDepth):0;
         var _loc7_:int = param3 >= 0?int(param3 % this.m_Type.patternHeight):0;
         var _loc8_:int = param2 >= 0?int(param2 % this.m_Type.patternWidth):0;
         var _loc9_:int = ((_loc5_ * this.m_Type.patternDepth + _loc6_) * this.m_Type.patternHeight + _loc7_) * this.m_Type.patternWidth + _loc8_;
         this.m_LastPhase = param1;
         this.m_LastInternalPhase = this.m_Phase;
         this.m_LastPatternX = param2;
         this.m_LastPatternY = param3;
         this.m_LastPatternZ = param4;
         this.m_LastCachedSpriteIndex = _loc9_;
         return _loc9_;
      }
      
      public function get ID() : int
      {
         return this.m_ID;
      }
      
      public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:CachedSpriteInformation = null;
         _loc7_ = this.getSprite(-1,param4,param5,param6,this.m_Type.isAnimation);
         this.m_CacheDirty = _loc7_.cacheMiss;
         var _loc8_:Rectangle = _loc7_.rectangle;
         s_TempPoint.setTo(param2 - _loc8_.width - this.m_Type.displacementX,param3 - _loc8_.height - this.m_Type.displacementY);
         param1.copyPixels(_loc7_.bitmapData,_loc8_,s_TempPoint,null,null,true);
      }
      
      public function animate(param1:Number) : Boolean
      {
         if(!this.m_Type.isAnimation)
         {
            return false;
         }
         var _loc2_:Number = (param1 - this.m_LastPhaseChange) % this.m_Type.totalDuration;
         var _loc3_:int = (this.m_Phase + 1) % this.m_Type.phases;
         while(_loc2_ >= this.m_Type.phaseDuration[_loc3_])
         {
            _loc2_ = _loc2_ - this.m_Type.phaseDuration[_loc3_];
            this.m_LastPhaseChange = this.m_LastPhaseChange + this.m_Type.phaseDuration[_loc3_];
            this.m_Phase++;
            _loc3_ = (_loc3_ + 1) % this.m_Type.phases;
         }
         return true;
      }
      
      public function set phase(param1:int) : void
      {
         if(param1 == PHASE_ASYNCHRONOUS)
         {
            this.m_Phase = 0;
            this.m_LastPhaseChange = Tibia.s_FrameTibiaTimestamp;
         }
         else if(param1 == PHASE_RANDOM)
         {
            this.m_Phase = int(Math.random() * this.m_Type.phases);
            this.m_LastPhaseChange = 0;
         }
         else if(0 <= param1 && param1 < this.m_Type.phases)
         {
            this.m_Phase = param1;
            this.m_LastPhaseChange = 0;
         }
         else
         {
            this.m_Phase = 0;
            this.m_LastPhaseChange = 0;
         }
      }
      
      public function get cacheDirty() : Boolean
      {
         return this.m_CacheDirty;
      }
      
      public function get phase() : int
      {
         return this.m_Phase % this.m_Type.phases;
      }
   }
}

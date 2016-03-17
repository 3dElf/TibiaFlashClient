package tibia.appearances
{
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.display.BitmapData;
   
   public class AppearanceInstance
   {
      
      protected static const s_TempRect:Rectangle = new Rectangle(0,0,0,0);
      
      public static const OUTDATEDCREATURE:int = 98;
      
      public static const UNKNOWNCREATURE:int = 97;
      
      public static const PHASE_ASYNCHRONOUS:int = 255;
      
      protected static const s_TempPoint:Point = new Point(0,0);
      
      public static const PHASE_RANDOM:int = 254;
      
      public static const CREATURE:int = 99;
       
      protected var m_LastPhaseChange:Number = 0;
      
      var mapData:int = -1;
      
      var m_Phase:int = 0;
      
      var m_ID:int = 0;
      
      var m_Type:tibia.appearances.AppearanceType = null;
      
      var mapField:int = -1;
      
      public function AppearanceInstance(param1:int, param2:tibia.appearances.AppearanceType)
      {
         super();
         this.m_ID = param1;
         this.m_Type = param2;
      }
      
      public function get type() : tibia.appearances.AppearanceType
      {
         return this.m_Type;
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
      
      public function get phase() : int
      {
         return this.m_Phase % this.m_Type.phases;
      }
      
      public function set phase(param1:int) : void
      {
         if(param1 == PHASE_ASYNCHRONOUS)
         {
            this.m_Phase = 0;
            this.m_LastPhaseChange = Tibia.s_FrameTimestamp;
         }
         else if(0 <= param1 && param1 < this.m_Type.phases || param1 == PHASE_RANDOM)
         {
            this.m_Phase = param1 == PHASE_RANDOM?int(int(Math.random() * this.m_Type.phases)):int(param1);
            this.m_LastPhaseChange = 0;
         }
         else
         {
            this.m_Phase = 0;
            this.m_LastPhaseChange = 0;
         }
      }
      
      public function get ID() : int
      {
         return this.m_ID;
      }
      
      public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Rectangle = null) : BitmapData
      {
         var _loc6_:int = (param1 >= 0?param1:this.m_Phase) % this.m_Type.phases;
         var _loc7_:int = param4 >= 0?int(param4 % this.m_Type.patternDepth):0;
         var _loc8_:int = param3 >= 0?int(param3 % this.m_Type.patternHeight):0;
         var _loc9_:int = param2 >= 0?int(param2 % this.m_Type.patternWidth):0;
         var _loc10_:int = ((_loc6_ * this.m_Type.patternDepth + _loc7_) * this.m_Type.patternHeight + _loc8_) * this.m_Type.patternWidth + _loc9_;
         if(param5 != null)
         {
            param5.copyFrom(this.m_Type.sprite[_loc10_]);
         }
         return this.m_Type.bitmap;
      }
      
      public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:int = 0;
         _loc7_ = ((this.m_Phase % this.m_Type.phases * this.m_Type.patternDepth + param6 % this.m_Type.patternDepth) * this.m_Type.patternHeight + param5 % this.m_Type.patternHeight) * this.m_Type.patternWidth + param4 % this.m_Type.patternWidth;
         var _loc8_:Rectangle = this.m_Type.sprite[_loc7_];
         s_TempPoint.setTo(param2 - _loc8_.width - this.m_Type.displacementX,param3 - _loc8_.height - this.m_Type.displacementY);
         param1.copyPixels(this.m_Type.bitmap,_loc8_,s_TempPoint,null,null,true);
      }
   }
}

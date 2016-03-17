package tibia.appearances
{
   import flash.display.BitmapData;
   import tibia.§appearances:ns_appearance_internal§.m_Phase;
   import tibia.§appearances:ns_appearance_internal§.m_Type;
   import flash.geom.Rectangle;
   import tibia.§appearances:ns_appearance_internal§.m_ID;
   
   public class ObjectInstance extends AppearanceInstance
   {
       
      protected var m_Hang:int = 0;
      
      protected var m_SpecialPatternX:int = 0;
      
      protected var m_SpecialPatternY:int = 0;
      
      protected var m_Data:int = 0;
      
      protected var m_HasSpecialPattern:Boolean = false;
      
      public function ObjectInstance(param1:int, param2:AppearanceType, param3:int)
      {
         super(param1,param2);
         this.m_Data = param3;
         this.updateSpecialPattern();
      }
      
      override public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc9_:int = 0;
         var _loc7_:int = param4;
         var _loc8_:int = param5;
         if(this.m_HasSpecialPattern)
         {
            _loc7_ = this.m_SpecialPatternX;
            _loc8_ = this.m_SpecialPatternY;
         }
         _loc9_ = ((m_Phase % m_Type.phases * m_Type.patternDepth + param6 % m_Type.patternDepth) * m_Type.patternHeight + _loc8_ % m_Type.patternHeight) * m_Type.patternWidth + _loc7_ % m_Type.patternWidth;
         var _loc10_:Rectangle = m_Type.sprite[_loc9_];
         s_TempPoint.setTo(param2 - _loc10_.width - m_Type.displacementX,param3 - _loc10_.height - m_Type.displacementY);
         param1.copyPixels(m_Type.bitmap,_loc10_,s_TempPoint,null,null,true);
      }
      
      protected function updateSpecialPattern() : void
      {
         var _loc1_:int = 0;
         this.m_HasSpecialPattern = false;
         if(m_Type == null || m_ID == AppearanceInstance.CREATURE)
         {
            return;
         }
         if(m_Type.isCumulative)
         {
            this.m_HasSpecialPattern = true;
            if(this.m_Data < 2)
            {
               this.m_SpecialPatternX = 0;
               this.m_SpecialPatternY = 0;
            }
            else if(this.m_Data == 2)
            {
               this.m_SpecialPatternX = 1;
               this.m_SpecialPatternY = 0;
            }
            else if(this.m_Data == 3)
            {
               this.m_SpecialPatternX = 2;
               this.m_SpecialPatternY = 0;
            }
            else if(this.m_Data == 4)
            {
               this.m_SpecialPatternX = 3;
               this.m_SpecialPatternY = 0;
            }
            else if(this.m_Data < 10)
            {
               this.m_SpecialPatternX = 0;
               this.m_SpecialPatternY = 1;
            }
            else if(this.m_Data < 25)
            {
               this.m_SpecialPatternX = 1;
               this.m_SpecialPatternY = 1;
            }
            else if(this.m_Data < 50)
            {
               this.m_SpecialPatternX = 2;
               this.m_SpecialPatternY = 1;
            }
            else
            {
               this.m_SpecialPatternX = 3;
               this.m_SpecialPatternY = 1;
            }
            this.m_SpecialPatternX = this.m_SpecialPatternX % m_Type.patternWidth;
            this.m_SpecialPatternY = this.m_SpecialPatternY % m_Type.patternHeight;
         }
         else if(Boolean(m_Type.isLiquidPool) || Boolean(m_Type.isLiquidContainer))
         {
            this.m_HasSpecialPattern = true;
            _loc1_ = 0;
            switch(this.m_Data)
            {
               case 0:
                  _loc1_ = 0;
                  break;
               case 1:
                  _loc1_ = 1;
                  break;
               case 2:
                  _loc1_ = 7;
                  break;
               case 3:
                  _loc1_ = 3;
                  break;
               case 4:
                  _loc1_ = 3;
                  break;
               case 5:
                  _loc1_ = 2;
                  break;
               case 6:
                  _loc1_ = 4;
                  break;
               case 7:
                  _loc1_ = 3;
                  break;
               case 8:
                  _loc1_ = 5;
                  break;
               case 9:
                  _loc1_ = 6;
                  break;
               case 10:
                  _loc1_ = 7;
                  break;
               case 11:
                  _loc1_ = 2;
                  break;
               case 12:
                  _loc1_ = 5;
                  break;
               case 13:
                  _loc1_ = 3;
                  break;
               case 14:
                  _loc1_ = 5;
                  break;
               case 15:
                  _loc1_ = 6;
                  break;
               case 16:
                  _loc1_ = 3;
                  break;
               case 17:
                  _loc1_ = 3;
                  break;
               default:
                  _loc1_ = 1;
            }
            this.m_SpecialPatternX = (_loc1_ & 3) % m_Type.patternWidth;
            this.m_SpecialPatternY = (_loc1_ >> 2) % m_Type.patternHeight;
         }
         else if(m_Type.isHangable)
         {
            this.m_HasSpecialPattern = true;
            if(this.m_Hang == AppearanceStorage.FLAG_HOOKSOUTH)
            {
               this.m_SpecialPatternX = m_Type.patternWidth >= 2?1:0;
               this.m_SpecialPatternY = 0;
            }
            else if(this.m_Hang == AppearanceStorage.FLAG_HOOKEAST)
            {
               this.m_SpecialPatternX = m_Type.patternWidth >= 3?2:0;
               this.m_SpecialPatternY = 0;
            }
            else
            {
               this.m_SpecialPatternX = 0;
               this.m_SpecialPatternY = 0;
            }
         }
      }
      
      public function get data() : int
      {
         return this.m_Data;
      }
      
      public function set hang(param1:int) : void
      {
         if(this.m_Hang != param1)
         {
            this.m_Hang = param1;
            this.updateSpecialPattern();
         }
      }
      
      public function get hang() : int
      {
         return this.m_Hang;
      }
      
      public function set data(param1:int) : void
      {
         if(this.m_Data != param1)
         {
            this.m_Data = param1;
            this.updateSpecialPattern();
         }
      }
      
      override public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Rectangle = null) : BitmapData
      {
         var _loc6_:int = (param1 >= 0?param1:m_Phase) % m_Type.phases;
         var _loc7_:int = param4 >= 0?int(param4 % m_Type.patternDepth):0;
         var _loc8_:int = param3 >= 0?int(param3 % m_Type.patternHeight):int(this.m_SpecialPatternY);
         var _loc9_:int = param2 >= 0?int(param2 % m_Type.patternWidth):int(this.m_SpecialPatternX);
         var _loc10_:int = ((_loc6_ * m_Type.patternDepth + _loc7_) * m_Type.patternHeight + _loc8_) * m_Type.patternWidth + _loc9_;
         if(param5 != null)
         {
            param5.copyFrom(m_Type.sprite[_loc10_]);
         }
         return m_Type.bitmap;
      }
   }
}

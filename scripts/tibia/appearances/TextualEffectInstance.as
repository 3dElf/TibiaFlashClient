package tibia.appearances
{
   import tibia.§appearances:ns_appearance_internal§.m_Phase;
   import shared.utility.Colour;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   
   public class TextualEffectInstance extends AppearanceInstance
   {
      
      protected static const PHASE_DURATION:Number = 100;
      
      protected static const PHASE_COUNT:int = 10;
       
      protected var m_Colour:Colour = null;
      
      protected var m_Value:Number = NaN;
      
      var m_InstanceRectangle:Rectangle = null;
      
      var m_InstanceBitmap:BitmapData = null;
      
      var m_InstanceCache:Boolean = false;
      
      protected var m_Text:String = null;
      
      public function TextualEffectInstance(param1:int, param2:AppearanceType, param3:int, param4:Number)
      {
         super(-1,null);
         this.m_Colour = Colour.s_FromEightBit(param3);
         this.m_Value = param4;
         this.m_Text = null;
         m_Phase = 0;
         m_LastPhaseChange = Tibia.s_FrameTimestamp;
         this.rebuildCache();
      }
      
      override public function animate(param1:Number) : Boolean
      {
         var _loc2_:Number = NaN;
         _loc2_ = Math.abs(param1 - m_LastPhaseChange);
         var _loc3_:int = int(_loc2_ / PHASE_DURATION);
         m_Phase = m_Phase + _loc3_;
         m_LastPhaseChange = m_LastPhaseChange + _loc3_ * PHASE_DURATION;
         return m_Phase < PHASE_COUNT;
      }
      
      override public function get phase() : int
      {
         return m_Phase;
      }
      
      public function get colour() : Colour
      {
         return this.m_Colour;
      }
      
      public function get height() : Number
      {
         return this.m_InstanceRectangle.height;
      }
      
      override public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Rectangle = null) : BitmapData
      {
         if(this.m_InstanceCache)
         {
            param5.copyFrom(this.m_InstanceRectangle);
         }
         return null;
      }
      
      public function rebuildCache() : void
      {
         this.m_Text = this.m_Value.toFixed(0);
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.defaultTextFormat = new TextFormat("Verdana",11,this.m_Colour.ARGB,true);
         _loc1_.text = this.m_Text;
         _loc1_.filters = [new GlowFilter(0,1,2,2,4,BitmapFilterQuality.MEDIUM,false,false)];
         if(this.m_InstanceBitmap != null)
         {
            this.m_InstanceBitmap.dispose();
            this.m_InstanceBitmap = null;
         }
         this.m_InstanceRectangle = new Rectangle(0,0,_loc1_.width,_loc1_.height);
         this.m_InstanceBitmap = new BitmapData(this.m_InstanceRectangle.width,this.m_InstanceRectangle.height,true,65280);
         this.m_InstanceBitmap.draw(_loc1_);
         this.m_InstanceCache = true;
      }
      
      public function get value() : Number
      {
         return this.m_Value;
      }
      
      public function get text() : String
      {
         return this.m_Text;
      }
      
      public function get width() : Number
      {
         return this.m_InstanceRectangle.width;
      }
      
      override public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         if(this.m_InstanceCache)
         {
            s_TempPoint.setTo(param2 - this.m_InstanceRectangle.width,param3 - this.m_InstanceRectangle.height);
            param1.copyPixels(this.m_InstanceBitmap,this.m_InstanceRectangle,s_TempPoint,null,null,true);
         }
      }
      
      public function merge(param1:AppearanceInstance) : Boolean
      {
         var _loc2_:TextualEffectInstance = param1 as TextualEffectInstance;
         if(_loc2_ != null && _loc2_.m_Phase <= 0 && m_Phase <= 0 && _loc2_.m_Colour == this.m_Colour)
         {
            this.m_Value = this.m_Value + _loc2_.m_Value;
            this.rebuildCache();
            return true;
         }
         return false;
      }
   }
}

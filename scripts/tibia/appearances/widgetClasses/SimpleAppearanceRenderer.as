package tibia.appearances.widgetClasses
{
   import mx.core.FlexShape;
   import mx.core.IFlexDisplayObject;
   import flash.geom.Rectangle;
   import shared.utility.TextFieldCache;
   import flash.geom.Matrix;
   import tibia.appearances.AppearanceInstance;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import tibia.appearances.AppearanceType;
   import flash.display.BitmapData;
   import tibia.appearances.ObjectInstance;
   
   public class SimpleAppearanceRenderer extends FlexShape implements IFlexDisplayObject
   {
      
      private static var s_Rect:Rectangle = new Rectangle();
      
      public static const ICON_SIZE:int = 32;
      
      private static var s_TextCache:TextFieldCache = new TextFieldCache(ICON_SIZE,TextFieldCache.DEFAULT_HEIGHT,100,true);
      
      private static var s_Trans:Matrix = new Matrix();
       
      private var m_PatternY:int = -1;
      
      private var m_PatternZ:int = -1;
      
      private var m_Phase:int = -1;
      
      private var m_Appearance:AppearanceInstance = null;
      
      private var m_Size:int = 32;
      
      private var m_HaveTimer:Boolean = false;
      
      private var m_Smooth:Boolean = false;
      
      private var m_Scale:Number = NaN;
      
      private var m_Overlay:Boolean = true;
      
      private var m_PatternX:int = -1;
      
      public function SimpleAppearanceRenderer()
      {
         super();
      }
      
      public function get appearance() : AppearanceInstance
      {
         return this.m_Appearance;
      }
      
      public function get size() : int
      {
         return this.m_Size;
      }
      
      public function get phase() : int
      {
         return this.m_Phase;
      }
      
      public function set phase(param1:int) : void
      {
         if(this.m_Phase != param1)
         {
            this.m_Phase = param1;
            this.draw();
         }
      }
      
      public function set size(param1:int) : void
      {
         if(this.m_Size != param1)
         {
            this.m_Size = param1;
            this.draw();
         }
      }
      
      public function set patternX(param1:int) : void
      {
         if(this.m_PatternX != param1)
         {
            this.m_PatternX = param1;
            this.draw();
         }
      }
      
      public function set patternY(param1:int) : void
      {
         if(this.m_PatternY != param1)
         {
            this.m_PatternY = param1;
            this.draw();
         }
      }
      
      public function set patternZ(param1:int) : void
      {
         if(this.m_PatternZ != param1)
         {
            this.m_PatternZ = param1;
            this.draw();
         }
      }
      
      public function set overlay(param1:Boolean) : void
      {
         if(this.m_Overlay != param1)
         {
            this.m_Overlay = param1;
            this.draw();
         }
      }
      
      protected function onTimer(param1:TimerEvent) : void
      {
         var _loc3_:Timer = null;
         var _loc2_:AppearanceType = null;
         if(this.m_Appearance != null && (_loc2_ = this.m_Appearance.type) != null && Boolean(_loc2_.isAnimation))
         {
            this.m_Appearance.animate(Tibia.s_FrameTibiaTimestamp);
         }
         else
         {
            _loc3_ = Tibia.s_GetSecondaryTimer();
            _loc3_.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this.m_HaveTimer = false;
         }
         this.draw();
      }
      
      public function get smooth() : Boolean
      {
         return this.m_Smooth;
      }
      
      public function set scale(param1:Number) : void
      {
         if(this.m_Scale != param1)
         {
            this.m_Scale = param1;
            this.draw();
         }
      }
      
      public function get measuredWidth() : Number
      {
         return this.m_Size;
      }
      
      public function get measuredHeight() : Number
      {
         return this.m_Size;
      }
      
      public function draw() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:BitmapData = null;
         var _loc5_:Rectangle = null;
         var _loc6_:int = 0;
         graphics.clear();
         var _loc1_:AppearanceType = null;
         if(this.m_Appearance != null && (_loc1_ = this.m_Appearance.type) != null)
         {
            _loc2_ = NaN;
            _loc3_ = NaN;
            if(isNaN(this.m_Scale))
            {
               _loc2_ = this.m_Size / _loc1_.exactSize;
               _loc3_ = this.m_Size;
            }
            else
            {
               _loc2_ = this.m_Scale;
               _loc3_ = _loc1_.exactSize * this.m_Scale;
            }
            _loc4_ = this.m_Appearance.getSprite(this.m_Phase,this.m_PatternX,this.m_PatternY,this.m_PatternZ,s_Rect);
            if(_loc4_ != null)
            {
               s_Trans.a = _loc2_;
               s_Trans.d = _loc2_;
               s_Trans.tx = (-s_Rect.right + _loc1_.exactSize) * _loc2_;
               s_Trans.ty = (-s_Rect.bottom + _loc1_.exactSize) * _loc2_;
               s_Rect.width = Math.min(_loc3_,s_Rect.width * _loc2_);
               s_Rect.height = Math.min(_loc3_,s_Rect.height * _loc2_);
               s_Rect.x = _loc3_ - s_Rect.width;
               s_Rect.y = _loc3_ - s_Rect.height;
               graphics.beginBitmapFill(_loc4_,s_Trans,false,this.m_Smooth);
               graphics.drawRect(s_Rect.x,s_Rect.y,s_Rect.width,s_Rect.height);
            }
            if(Boolean(this.m_Overlay) && this.m_Appearance is ObjectInstance && Boolean(_loc1_.isCumulative))
            {
               _loc5_ = null;
               _loc6_ = ObjectInstance(this.m_Appearance).data;
               if((_loc5_ = s_TextCache.getItem(_loc6_,String(_loc6_),4294967295)) != null)
               {
                  s_Rect.x = _loc3_ - _loc5_.width;
                  s_Rect.y = _loc3_ - _loc5_.height;
                  s_Trans.a = 1;
                  s_Trans.d = 1;
                  s_Trans.tx = -_loc5_.x + s_Rect.x;
                  s_Trans.ty = -_loc5_.y + s_Rect.y;
                  graphics.beginBitmapFill(s_TextCache,s_Trans,false,false);
                  graphics.drawRect(s_Rect.x,s_Rect.y,_loc5_.width,_loc5_.height);
               }
            }
            graphics.endFill();
         }
      }
      
      public function set appearance(param1:AppearanceInstance) : void
      {
         var _loc2_:AppearanceType = null;
         var _loc3_:Boolean = false;
         var _loc4_:Timer = null;
         if(this.m_Appearance != param1)
         {
            this.m_Appearance = param1;
            this.m_Phase = -1;
            this.m_PatternX = -1;
            this.m_PatternY = -1;
            this.m_PatternZ = -1;
            _loc2_ = null;
            _loc3_ = this.m_Appearance != null && (_loc2_ = this.m_Appearance.type) != null && Boolean(_loc2_.isAnimation);
            _loc4_ = Tibia.s_GetSecondaryTimer();
            if(Boolean(_loc3_) && !this.m_HaveTimer)
            {
               _loc4_.addEventListener(TimerEvent.TIMER,this.onTimer);
               this.m_HaveTimer = true;
            }
            if(!_loc3_ && Boolean(this.m_HaveTimer))
            {
               _loc4_.removeEventListener(TimerEvent.TIMER,this.onTimer);
               this.m_HaveTimer = false;
            }
            this.draw();
         }
      }
      
      public function get patternY() : int
      {
         return this.m_PatternY;
      }
      
      public function get patternZ() : int
      {
         return this.m_PatternZ;
      }
      
      public function get overlay() : Boolean
      {
         return this.m_Overlay;
      }
      
      public function get patternX() : int
      {
         return this.m_PatternX;
      }
      
      public function get scale() : Number
      {
         return this.m_Scale;
      }
      
      public function set smooth(param1:Boolean) : void
      {
         if(this.m_Smooth != param1)
         {
            this.m_Smooth = param1;
            this.draw();
         }
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
      
      public function setActualSize(param1:Number, param2:Number) : void
      {
      }
   }
}

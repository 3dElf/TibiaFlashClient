package tibia.container.containerWidgetClasses
{
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import flash.display.Graphics;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   import flash.events.MouseEvent;
   
   public class BodySlot extends ContainerSlot
   {
      
      {
         s_InitializeStyle();
      }
      
      protected var m_StyleEmptyBackgroundValue:Object = null;
      
      protected var m_UIMouseOver:Boolean = false;
      
      protected var m_StyleEmptyBackgroundImage:Bitmap = null;
      
      public function BodySlot()
      {
         super();
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseEvent);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseEvent);
         invalidateStyle();
      }
      
      private static function s_InitializeStyle() : void
      {
         var Selector:String = "BodySlot";
         var Style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(Selector);
         if(Style == null)
         {
            Style = new CSSStyleDeclaration(Selector);
         }
         Style.defaultFactory = function():void
         {
            BodySlot.backgroundImage = undefined;
            BodySlot.backgroundColor = 65280;
            BodySlot.backgroundAlpha = 1;
            BodySlot.backgroundOutAlpha = 0.5;
            BodySlot.backgroundOverAlpha = 1;
            BodySlot.emptyBackgroundImage = undefined;
            BodySlot.emptyBackgroundColor = 16711680;
            BodySlot.emptyBackgroundAlpha = 1;
            BodySlot.emptyBackgroundOutAlpha = 0.5;
            BodySlot.emptyBackgroundOverAlpha = 1;
            BodySlot.paddingBottom = 0;
            BodySlot.paddingLeft = 0;
            BodySlot.paddingRight = 0;
            BodySlot.paddingTop = 0;
         };
         StyleManager.setStyleDeclaration(Selector,Style,true);
      }
      
      override protected function layoutChrome(param1:Graphics, param2:Number, param3:Number) : void
      {
         var _loc8_:BitmapData = null;
         var _loc4_:Bitmap = null;
         var _loc5_:* = false;
         var _loc6_:uint = 0;
         var _loc7_:Number = 1;
         if(appearance != null)
         {
            _loc4_ = m_StyleBackgroundImage;
            _loc5_ = getStyle("backgroundColor") !== undefined;
            _loc6_ = getStyle("backgroundColor");
            _loc7_ = this.getSafeNumbericStyle(!!this.m_UIMouseOver?"backgroundOverAlpha":"backgroundOutAlpha","backgroundAlpha");
         }
         else
         {
            _loc4_ = this.m_StyleEmptyBackgroundImage;
            _loc5_ = getStyle("emptyBackgroundColor") !== undefined;
            _loc6_ = getStyle("emptyBackgroundColor");
            _loc7_ = this.getSafeNumbericStyle(!!this.m_UIMouseOver?"emptyBackgroundOverAlpha":"emptyBackgroundOutAlpha","emptyBackgroundAlpha");
         }
         if(_loc4_ != null)
         {
            _loc8_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc8_.draw(_loc4_,null,new ColorTransform(1,1,1,_loc7_,0,0,0,0),null,null,false);
            param1.clear();
            param1.beginBitmapFill(_loc8_,null,false,false);
            param1.drawRect(0,0,param2,param3);
            param1.endFill();
         }
         else if(_loc5_)
         {
            param1.clear();
            param1.beginFill(_loc6_,_loc7_);
            param1.drawRect(0,0,param2,param3);
            param1.endFill();
         }
      }
      
      private function getSafeNumbericStyle(... rest) : Number
      {
         var _loc4_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = rest.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = getStyle(String(rest[_loc2_]));
            if(!isNaN(_loc4_))
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return NaN;
      }
      
      override public function styleChanged(param1:String) : void
      {
         switch(param1)
         {
            case "emptyBackgroundImage":
               invalidateStyle();
               break;
            default:
               super.styleChanged(param1);
         }
      }
      
      protected function onMouseEvent(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            this.m_UIMouseOver = param1.type == MouseEvent.ROLL_OVER;
            invalidateDisplayList();
         }
      }
      
      override protected function validateStyle() : void
      {
         super.validateStyle();
         var _loc1_:Class = getStyle("emptyBackgroundImage") as Class;
         if(this.m_StyleEmptyBackgroundValue != _loc1_)
         {
            this.m_StyleEmptyBackgroundValue = _loc1_;
            this.m_StyleEmptyBackgroundImage = _loc1_ != null?Bitmap(new _loc1_()):null;
            invalidateDisplayList();
            invalidateSize();
         }
      }
   }
}

package tibia.game
{
   import mx.core.UIComponent;
   import mx.managers.ISystemManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.controls.Label;
   
   public class FocusNotifier extends UIComponent
   {
      
      private static var s_Instance:tibia.game.FocusNotifier = null;
      
      private static const BUNDLE:String = "Global";
      
      private static var s_Visible:Boolean = false;
       
      private var m_UIConstructed:Boolean = false;
      
      private var m_UILabel:Label = null;
      
      public function FocusNotifier()
      {
         super();
         mouseEnabled = false;
      }
      
      public static function s_Show() : void
      {
         var _loc1_:ISystemManager = null;
         if(s_Instance == null)
         {
            s_Instance = new tibia.game.FocusNotifier();
         }
         if(!s_Visible)
         {
            if(Tibia.s_GetInputHandler() != null)
            {
               Tibia.s_GetInputHandler().captureKeyboard = false;
            }
            _loc1_ = Tibia.s_GetInstance().systemManager;
            _loc1_.addChildToSandboxRoot("popUpChildren",s_Instance);
            _loc1_.addEventListener(Event.RESIZE,s_Instance.onResize);
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,s_Instance.onHide);
            _loc1_.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,s_Instance.onHide);
            s_Visible = true;
         }
      }
      
      public static function s_Hide() : void
      {
         var _loc1_:ISystemManager = null;
         if(s_Visible)
         {
            s_Visible = false;
            _loc1_ = Tibia.s_GetInstance().systemManager;
            _loc1_.removeChildFromSandboxRoot("popUpChildren",s_Instance);
            _loc1_.removeEventListener(Event.RESIZE,s_Instance.onResize);
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,s_Instance.onHide);
            _loc1_.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN,s_Instance.onHide);
            if(Tibia.s_GetInputHandler() != null)
            {
               Tibia.s_GetInputHandler().captureKeyboard = true;
            }
            if(PopUpBase.s_GetInstance() != null)
            {
               PopUpBase.s_GetInstance().setFocus();
               PopUpBase.s_GetInstance().drawFocus(false);
            }
         }
      }
      
      protected function onHide(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            s_Hide();
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         if(stage != null)
         {
            measuredMinHeight = measuredHeight = stage.stageHeight;
            measuredMinWidth = measuredWidth = stage.stageWidth;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         super.updateDisplayList(param1,param2);
         graphics.clear();
         if(getStyle("modalTransparencyColor") !== undefined)
         {
            _loc3_ = getStyle("modalTransparencyColor");
            _loc4_ = getStyle("modalTransparency");
            graphics.beginFill(_loc3_,_loc4_);
            graphics.drawRect(0,0,param1,param2);
            graphics.endFill();
         }
         if(this.m_UILabel != null)
         {
            _loc5_ = this.m_UILabel.getExplicitOrMeasuredHeight();
            _loc6_ = this.m_UILabel.getExplicitOrMeasuredWidth();
            this.m_UILabel.move((param1 - _loc6_) / 2,(param2 - _loc5_) / 4);
            this.m_UILabel.setActualSize(_loc6_,_loc5_);
         }
      }
      
      protected function onResize(param1:Event) : void
      {
         if(param1 != null)
         {
            invalidateSize();
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UILabel = new Label();
            this.m_UILabel.styleName = this;
            this.m_UILabel.text = resourceManager.getString(BUNDLE,"MSG_CLICK_TO_ACTIVATE");
            addChild(this.m_UILabel);
            this.m_UIConstructed = true;
         }
      }
   }
}

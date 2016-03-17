package tibia.game
{
   import mx.containers.VBox;
   import mx.managers.ISystemManager;
   import mx.core.IUIComponent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import tibia.input.InputHandler;
   import mx.managers.ToolTipManager;
   import flash.ui.Keyboard;
   import flash.display.DisplayObjectContainer;
   import mx.core.IToolTip;
   import tibia.game.contextMenuClasses.TextItem;
   import flash.events.ContextMenuEvent;
   import tibia.game.contextMenuClasses.SeparatorItem;
   import flash.display.DisplayObject;
   import mx.events.ChildExistenceChangedEvent;
   import tibia.game.contextMenuClasses.IContextMenuItem;
   import mx.core.ScrollPolicy;
   
   public class ContextMenuBase extends VBox
   {
      
      protected static var s_CurrentContextMenu:tibia.game.ContextMenuBase = null;
       
      public function ContextMenuBase()
      {
         super();
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
         maxWidth = 350;
         minWidth = 200;
         addEventListener(ChildExistenceChangedEvent.CHILD_ADD,this.onChildExistenceChanged);
         addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE,this.onChildExistenceChanged);
      }
      
      public static function s_HideInstance() : void
      {
         if(s_CurrentContextMenu != null)
         {
            s_CurrentContextMenu.hide();
            s_CurrentContextMenu = null;
         }
      }
      
      public static function s_GetInstance() : tibia.game.ContextMenuBase
      {
         return s_CurrentContextMenu;
      }
      
      public function hide() : void
      {
         var _loc1_:ISystemManager = null;
         if(owner is IUIComponent && (_loc1_ = (owner as IUIComponent).systemManager) != null)
         {
            _loc1_.popUpChildren.removeChild(this);
            _loc1_.deployMouseShields(false);
            _loc1_.removeEventListener(Event.ACTIVATE,this.onEventHide);
            _loc1_.removeEventListener(Event.DEACTIVATE,this.onEventHide);
            _loc1_.removeEventListener(Event.RESIZE,this.onEventHide);
            _loc1_.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyboardHide);
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseHide);
            _loc1_.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseHide);
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onMouseHide);
            _loc1_.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onMouseHide);
            _loc1_.removeEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onMouseHide);
            _loc1_.removeEventListener(MouseEvent.RIGHT_CLICK,this.onMouseHide);
            owner = null;
         }
         var _loc2_:InputHandler = Tibia.s_GetInputHandler();
         if(_loc2_ != null)
         {
            _loc2_.captureKeyboard = true;
         }
         ToolTipManager.currentTarget = null;
         ToolTipManager.enabled = true;
         s_CurrentContextMenu = null;
      }
      
      private function onMouseHide(param1:MouseEvent) : void
      {
         if(!hitTestPoint(param1.stageX,param1.stageY))
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            if(param1.type == MouseEvent.CLICK || param1.type == MouseEvent.MOUSE_UP || param1.type == MouseEvent.RIGHT_CLICK || param1.type == MouseEvent.RIGHT_MOUSE_UP)
            {
               this.hide();
            }
         }
      }
      
      private function onKeyboardHide(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.hide();
         }
      }
      
      public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var _loc4_:ISystemManager = null;
         if(param1 != null && (_loc4_ = param1.systemManager) != null && _loc4_.stage != null)
         {
            _loc4_.popUpChildren.addChild(this);
            _loc4_.deployMouseShields(true);
            _loc4_.addEventListener(Event.ACTIVATE,this.onEventHide);
            _loc4_.addEventListener(Event.DEACTIVATE,this.onEventHide);
            _loc4_.addEventListener(Event.RESIZE,this.onEventHide);
            _loc4_.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyboardHide);
            _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseHide);
            _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.onMouseHide);
            _loc4_.addEventListener(MouseEvent.CLICK,this.onMouseHide);
            _loc4_.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onMouseHide);
            _loc4_.addEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onMouseHide);
            _loc4_.addEventListener(MouseEvent.RIGHT_CLICK,this.onMouseHide);
            validateNow();
            move(Math.max(0,Math.min(param2,_loc4_.stage.stageWidth - measuredWidth)),Math.max(0,Math.min(param3,_loc4_.stage.stageHeight - measuredHeight)));
            owner = param1 as DisplayObjectContainer;
         }
         var _loc5_:InputHandler = Tibia.s_GetInputHandler();
         if(_loc5_ != null)
         {
            _loc5_.captureKeyboard = false;
         }
         var _loc6_:IToolTip = ToolTipManager.currentToolTip;
         if(_loc6_ != null)
         {
            ToolTipManager.destroyToolTip(_loc6_);
            ToolTipManager.currentToolTip = null;
         }
         ToolTipManager.currentTarget = null;
         ToolTipManager.enabled = false;
         if(s_CurrentContextMenu != null)
         {
            s_CurrentContextMenu.hide();
         }
         s_CurrentContextMenu = this;
      }
      
      protected function createTextItem(param1:String, param2:Function) : TextItem
      {
         var _loc3_:TextItem = new TextItem();
         _loc3_.caption = param1;
         _loc3_.owner = owner;
         _loc3_.percentWidth = 100;
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,param2);
         addChild(_loc3_);
         return _loc3_;
      }
      
      protected function createSeparatorItem() : SeparatorItem
      {
         var _loc1_:SeparatorItem = new SeparatorItem();
         _loc1_.owner = owner;
         _loc1_.percentWidth = 100;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function onEventHide(param1:Event) : void
      {
         this.hide();
      }
      
      override protected function measure() : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < numChildren)
         {
            _loc2_ = getChildAt(_loc3_);
            if(_loc2_ is SeparatorItem)
            {
               _loc5_ = _loc3_ > 0 && _loc3_ < numChildren - 1 && !(getChildAt(_loc3_ + 1) is SeparatorItem);
               SeparatorItem(_loc2_).includeInLayout = _loc5_;
               SeparatorItem(_loc2_).visible = _loc5_;
            }
            else if(_loc2_ is TextItem)
            {
               _loc6_ = !isNaN(TextItem(_loc2_).explicitIconWidth)?Number(TextItem(_loc2_).explicitIconWidth):Number(TextItem(_loc2_).measuredIconWidth);
               _loc1_ = Math.max(_loc1_,_loc6_);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < numChildren)
         {
            _loc2_ = getChildAt(_loc4_);
            if(_loc2_ is TextItem)
            {
               TextItem(_loc2_).iconWidth = _loc1_;
            }
            _loc4_++;
         }
         super.measure();
      }
      
      private function onChildExistenceChanged(param1:ChildExistenceChangedEvent) : void
      {
         var _loc2_:IContextMenuItem = param1.relatedObject as IContextMenuItem;
         if(_loc2_ != null)
         {
            if(param1.type == ChildExistenceChangedEvent.CHILD_ADD)
            {
               _loc2_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onEventHide,false,int.MAX_VALUE,false);
            }
            else
            {
               _loc2_.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onEventHide);
            }
         }
      }
   }
}

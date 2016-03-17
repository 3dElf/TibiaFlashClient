package tibia.game
{
   import mx.core.UIComponent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import shared.skins.VectorBorderSkin;
   import mx.core.FlexShape;
   import flash.events.MouseEvent;
   import flash.ui.ContextMenuItem;
   import mx.core.IUITextField;
   import flash.events.ContextMenuEvent;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import mx.core.EdgeMetrics;
   import mx.core.IUIComponent;
   import mx.managers.ISystemManager;
   import mx.events.SandboxMouseEvent;
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   import tibia.input.InputHandler;
   import mx.managers.ToolTipManager;
   import mx.core.IToolTip;
   import flash.display.DisplayObject;
   import mx.core.IFlexDisplayObject;
   import mx.styles.ISimpleStyleClient;
   import mx.core.IInvalidating;
   import mx.core.UITextField;
   import flash.text.TextFieldAutoSize;
   import mx.core.IBorder;
   import flash.display.Graphics;
   
   public class ContextMenuBase extends UIComponent
   {
      
      protected static var s_CurrentContextMenu:tibia.game.ContextMenuBase = null;
      
      private static const DEFAULT_MIN_WIDTH:Number = 200;
      
      private static const DEFAULT_MAX_WIDTH:Number = 350;
      
      private static const DEFAULT_SEPARATOR_HEIGHT:Number = 4;
      
      {
         s_InitialiseStyle();
      }
      
      private var m_UIHide:Boolean = false;
      
      private var m_UncommittedHighlight:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIHighlight:FlexShape = null;
      
      protected var m_UIItems:Vector.<IUITextField>;
      
      protected var m_Highlight:int = -1;
      
      private var m_StyleBorder = null;
      
      protected var m_Items:Vector.<ContextMenuItem>;
      
      private var m_UIDisplayed:Boolean = false;
      
      protected var m_UIBorder:IFlexDisplayObject = null;
      
      public function ContextMenuBase()
      {
         this.m_Items = new Vector.<ContextMenuItem>();
         this.m_UIItems = new Vector.<IUITextField>();
         super();
         addEventListener(MouseEvent.CLICK,this.onItemMouseEvent);
         addEventListener(MouseEvent.RIGHT_CLICK,this.onItemMouseEvent);
      }
      
      public static function s_HideInstance() : void
      {
         if(s_CurrentContextMenu != null)
         {
            s_CurrentContextMenu.hide();
            s_CurrentContextMenu = null;
         }
      }
      
      private static function s_InitialiseStyle() : void
      {
         var Selector:String = "ContextMenuBase";
         var Decl:CSSStyleDeclaration = StyleManager.getStyleDeclaration(Selector);
         if(Decl == null)
         {
            Decl = new CSSStyleDeclaration(Selector);
         }
         Decl.defaultFactory = function():void
         {
            ContextMenuBase.borderSkin = VectorBorderSkin;
            ContextMenuBase.borderAlpha = 1;
            ContextMenuBase.borderColor = 16711680;
            ContextMenuBase.borderThickness = 1;
            ContextMenuBase.backgroundAlpha = 1;
            ContextMenuBase.backgroundColor = 65280;
            ContextMenuBase.rollOverAlpha = 1;
            ContextMenuBase.rollOverColor = 255;
            ContextMenuBase.separatorAlpha = 1;
            ContextMenuBase.separatorColor = 16776960;
            ContextMenuBase.textColor = 65535;
            ContextMenuBase.textRollOverColor = 16711935;
            ContextMenuBase.paddingBottom = 0;
            ContextMenuBase.paddingLeft = 0;
            ContextMenuBase.paddingRight = 0;
            ContextMenuBase.paddingTop = 0;
         };
         StyleManager.setStyleDeclaration(Selector,Decl,true);
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.updateBorder();
            this.m_UIHighlight = new FlexShape();
            addChild(this.m_UIHighlight);
            this.m_UIConstructed = true;
         }
      }
      
      protected function onHideMouseEvent(param1:MouseEvent) : void
      {
         if(Boolean(this.m_UIDisplayed) && param1 != null && !hitTestPoint(param1.stageX,param1.stageY))
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            switch(param1.type)
            {
               case MouseEvent.MOUSE_DOWN:
               case MouseEvent.RIGHT_MOUSE_DOWN:
                  break;
               case MouseEvent.MOUSE_UP:
               case MouseEvent.CLICK:
               case MouseEvent.RIGHT_MOUSE_UP:
               case MouseEvent.RIGHT_CLICK:
                  this.hide();
                  break;
               default:
                  log("ContextMenuBase.onHideMouseEvent: Unknown mouse event type: " + param1.type);
            }
         }
      }
      
      public function addItemAt(param1:ContextMenuItem, param2:int) : ContextMenuItem
      {
         if(param1 == null)
         {
            throw new ArgumentError("ContextMenuBase.addItemAt: The menu item may not be null.");
         }
         if(param2 < 0 || param2 > this.m_Items.length)
         {
            throw new ArgumentError("ContextMenuBase.addItemAt: Invalid item index.");
         }
         this.m_Items.splice(param2,0,param1);
         invalidateDisplayList();
         invalidateSize();
         return param1;
      }
      
      private function layoutHighlight(param1:Number, param2:Number) : void
      {
         if(this.m_UIHighlight != null)
         {
            this.m_UIHighlight.x = 0;
            this.m_UIHighlight.y = 0;
         }
      }
      
      public function getItemAt(param1:int) : ContextMenuItem
      {
         if(param1 < 0 || param1 >= this.m_Items.length)
         {
            throw new ArgumentError("ContextMenuBase.getItemAt: Invalid item index.");
         }
         return this.m_Items[param1];
      }
      
      protected function onItemMouseEvent(param1:MouseEvent) : void
      {
         var _loc2_:IUITextField = null;
         var _loc3_:int = 0;
         var _loc4_:ContextMenuEvent = null;
         if(!this.m_UIHide && param1 != null)
         {
            _loc2_ = param1.target as IUITextField;
            _loc3_ = this.rendererToIndex(_loc2_);
            switch(param1.type)
            {
               case MouseEvent.CLICK:
                  param1.preventDefault();
                  param1.stopImmediatePropagation();
                  this.hide();
                  if(_loc3_ > -1)
                  {
                     _loc4_ = new ContextMenuEvent(ContextMenuEvent.MENU_ITEM_SELECT);
                     _loc4_.mouseTarget = owner;
                     _loc4_.contextMenuOwner = owner;
                     this.getItemAt(_loc3_).dispatchEvent(_loc4_);
                  }
                  break;
               case MouseEvent.RIGHT_CLICK:
                  break;
               case MouseEvent.MOUSE_OVER:
               case MouseEvent.ROLL_OVER:
                  this.highlight = _loc3_;
                  break;
               case MouseEvent.MOUSE_OUT:
               case MouseEvent.ROLL_OUT:
                  this.highlight = -1;
                  break;
               default:
                  log("ContextMenuBase.onMouseEvent: Unknown mouse event type: " + param1.type);
            }
         }
      }
      
      protected function createItem(param1:String, param2:Function, param3:Boolean = false) : ContextMenuItem
      {
         var _loc4_:ContextMenuItem = new ContextMenuItem(param1,param3);
         _loc4_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,param2);
         return this.addItem(_loc4_);
      }
      
      protected function onHideKeyboardEvent(param1:KeyboardEvent) : void
      {
         if(param1 != null && param1.keyCode == Keyboard.ESCAPE)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.hide();
         }
      }
      
      public function get highlight() : int
      {
         return this.m_Highlight;
      }
      
      public function removeItem(param1:ContextMenuItem) : ContextMenuItem
      {
         if(param1 == null)
         {
            throw new ArgumentError("ContextMenuBase.removeItem: The menu item may not be null.");
         }
         var _loc2_:ContextMenuItem = null;
         var _loc3_:int = this.m_Items.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.m_Items[_loc4_] == param1)
            {
               _loc2_ = this.m_Items[_loc4_];
               this.m_Items.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
         if(_loc2_ == null)
         {
            throw new ArgumentError("ContextMenuBase.removeItem: Not a child.");
         }
         invalidateDisplayList();
         invalidateSize();
         return _loc2_;
      }
      
      public function get viewMetricsAndPadding() : EdgeMetrics
      {
         var _loc1_:EdgeMetrics = this.borderMetrics.clone();
         _loc1_.bottom = _loc1_.bottom + getStyle("paddingBottom");
         _loc1_.left = _loc1_.left + getStyle("paddingLeft");
         _loc1_.right = _loc1_.right + getStyle("paddingRight");
         _loc1_.top = _loc1_.top + getStyle("paddingTop");
         return _loc1_;
      }
      
      public function setItemIndex(param1:ContextMenuItem, param2:int) : void
      {
         if(param2 < 0 || param2 >= this.m_Items.length)
         {
            throw new ArgumentError("ContextMenuBase.setItemIndex: Invalid item index.");
         }
         var _loc3_:int = this.getItemIndex(param1);
         if(_loc3_ < 0)
         {
            throw new ArgumentError("ContextMenuBase.setItemIndex: The item is not assigned to the menu.");
         }
         if(_loc3_ != param2)
         {
            this.m_Items.splice(_loc3_,1);
            this.m_Items.splice(param2,0,param1);
         }
      }
      
      public function get items() : Vector.<ContextMenuItem>
      {
         return this.m_Items;
      }
      
      public function removeAllItems() : void
      {
         this.m_Items.length = 0;
         invalidateDisplayList();
         invalidateSize();
      }
      
      public function getItemIndex(param1:ContextMenuItem) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         var _loc2_:int = this.m_Items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.m_Items[_loc3_] == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function removeItemAt(param1:int) : ContextMenuItem
      {
         if(param1 < 0 || param1 >= this.m_Items.length)
         {
            throw new ArgumentError("ContextMenuBase.removeItem: Invalid item index.");
         }
         var _loc2_:ContextMenuItem = this.m_Items[param1];
         this.m_Items.splice(param1,1);
         invalidateDisplayList();
         invalidateSize();
         return _loc2_;
      }
      
      public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:ISystemManager = null;
         if(param1 != null && (_loc4_ = param1.systemManager) != null)
         {
            _loc4_.popUpChildren.addChild(this);
            _loc4_.deployMouseShields(true);
            _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,this.onHideMouseEvent);
            _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.onHideMouseEvent);
            _loc4_.addEventListener(MouseEvent.CLICK,this.onHideMouseEvent);
            _loc4_.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onHideMouseEvent);
            _loc4_.addEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onHideMouseEvent);
            _loc4_.addEventListener(MouseEvent.RIGHT_CLICK,this.onHideMouseEvent);
            _loc4_.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.onHideSandboxMouseEvent);
            _loc4_.addEventListener(Event.RESIZE,this.onHideEvent);
            _loc4_.addEventListener(Event.DEACTIVATE,this.onHideEvent);
            _loc4_.addEventListener(KeyboardEvent.KEY_DOWN,this.onHideKeyboardEvent);
            validateSize();
            _loc7_ = Math.max(0,Math.min(param2,stage.stageWidth - measuredWidth));
            _loc8_ = Math.max(0,Math.min(param3,stage.stageHeight - measuredHeight));
            move(_loc7_,_loc8_);
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
         this.m_UIDisplayed = false;
         this.m_UIHide = false;
      }
      
      override public function styleChanged(param1:String) : void
      {
         switch(param1)
         {
            case "borderSkin":
               this.updateBorder();
               break;
            default:
               super.styleChanged(param1);
         }
      }
      
      public function addItem(param1:ContextMenuItem) : ContextMenuItem
      {
         if(param1 == null)
         {
            throw new ArgumentError("ContextMenuBase.addItem: The menu item may not be null.");
         }
         this.m_Items.push(param1);
         invalidateDisplayList();
         invalidateSize();
         return param1;
      }
      
      private function updateBorder() : void
      {
         var _loc1_:Class = getStyle("borderSkin") as Class;
         if(_loc1_ != this.m_StyleBorder)
         {
            this.m_StyleBorder = _loc1_;
            if(this.m_UIBorder != null)
            {
               removeChild(DisplayObject(this.m_UIBorder));
               this.m_UIBorder = null;
            }
            if(_loc1_ != null)
            {
               this.m_UIBorder = IFlexDisplayObject(new _loc1_());
               if(this.m_UIBorder is ISimpleStyleClient)
               {
                  ISimpleStyleClient(this.m_UIBorder).styleName = this;
               }
               if(this.m_UIBorder is IInvalidating)
               {
                  IInvalidating(this.m_UIBorder).invalidateDisplayList();
                  IInvalidating(this.m_UIBorder).invalidateProperties();
                  IInvalidating(this.m_UIBorder).invalidateSize();
               }
               addChild(DisplayObject(this.m_UIBorder));
               setChildIndex(DisplayObject(this.m_UIBorder),0);
            }
         }
      }
      
      protected function onHideEvent(param1:Event) : void
      {
         if(param1 != null)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.hide();
         }
      }
      
      public function hide() : void
      {
         var _loc1_:ISystemManager = null;
         if(owner is IUIComponent && (_loc1_ = (owner as IUIComponent).systemManager) != null)
         {
            _loc1_.popUpChildren.removeChild(this);
            _loc1_.deployMouseShields(false);
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHideMouseEvent);
            _loc1_.removeEventListener(MouseEvent.MOUSE_UP,this.onHideMouseEvent);
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onHideMouseEvent);
            _loc1_.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onHideMouseEvent);
            _loc1_.removeEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onHideMouseEvent);
            _loc1_.removeEventListener(MouseEvent.RIGHT_CLICK,this.onHideMouseEvent);
            _loc1_.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.onHideSandboxMouseEvent);
            _loc1_.removeEventListener(Event.RESIZE,this.onHideEvent);
            _loc1_.removeEventListener(Event.DEACTIVATE,this.onHideEvent);
            _loc1_.removeEventListener(KeyboardEvent.KEY_DOWN,this.onHideKeyboardEvent);
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
         this.m_UIDisplayed = false;
         this.m_UIHide = true;
      }
      
      override protected function measure() : void
      {
         var _loc1_:EdgeMetrics = null;
         super.measure();
         _loc1_ = this.viewMetricsAndPadding;
         var _loc2_:int = 0;
         var _loc3_:int = this.m_Items.length;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:IUITextField = null;
         _loc6_ = this.m_UIItems.length < 1?this.createRenderer():this.m_UIItems[0];
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.m_Items[_loc2_].separatorBefore)
            {
               _loc5_ = _loc5_ + DEFAULT_SEPARATOR_HEIGHT;
            }
            _loc6_.text = this.m_Items[_loc2_].caption;
            _loc5_ = _loc5_ + _loc6_.getExplicitOrMeasuredHeight();
            _loc4_ = Math.max(_loc4_,_loc6_.getExplicitOrMeasuredWidth());
            _loc2_++;
         }
         _loc4_ = Math.min(DEFAULT_MAX_WIDTH,Math.max(_loc1_.left + _loc4_ + _loc1_.right,DEFAULT_MIN_WIDTH));
         measuredWidth = measuredMinWidth = _loc4_;
         measuredHeight = measuredMinHeight = _loc1_.top + _loc5_ + _loc1_.bottom;
      }
      
      protected function createRenderer() : IUITextField
      {
         var _loc1_:IUITextField = new UITextField();
         _loc1_.autoSize = TextFieldAutoSize.NONE;
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseEvent);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseEvent);
         addChild(_loc1_ as DisplayObject);
         this.m_UIItems.push(_loc1_);
         return _loc1_;
      }
      
      protected function onHideSandboxMouseEvent(param1:SandboxMouseEvent) : void
      {
         if(param1 != null)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            this.hide();
         }
      }
      
      private function rendererToIndex(param1:IUITextField) : int
      {
         var _loc2_:int = this.m_UIItems.length - 1;
         while(_loc2_ >= 0)
         {
            if(this.m_UIItems[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_--;
         }
         return -1;
      }
      
      public function get length() : int
      {
         return this.m_Items.length;
      }
      
      protected function removeRenderer(param1:int) : IUITextField
      {
         if(param1 < 0 || param1 >= this.m_UIItems.length)
         {
            return null;
         }
         var _loc2_:IUITextField = this.m_UIItems[param1];
         _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseEvent);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseEvent);
         removeChild(DisplayObject(_loc2_));
         this.m_UIItems.splice(param1,1);
         return _loc2_;
      }
      
      public function set highlight(param1:int) : void
      {
         if(param1 > -1)
         {
            param1 = Math.max(0,Math.min(param1,this.m_Items.length - 1));
         }
         if(this.m_Highlight != param1)
         {
            this.m_Highlight = param1;
            this.m_UncommittedHighlight = true;
            invalidateDisplayList();
            invalidateProperties();
         }
      }
      
      public function getItemByName(param1:String) : ContextMenuItem
      {
         if(param1 == null || param1.length < 1)
         {
            throw new ArgumentError("ContextMenuBase.getItemByName: Invalid item name.");
         }
         var _loc2_:int = this.m_Items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.m_Items[_loc3_].caption == param1)
            {
               return this.m_Items[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedHighlight)
         {
            this.m_UncommittedHighlight = false;
         }
      }
      
      private function layoutBorder(param1:Number, param2:Number) : void
      {
         if(this.m_UIBorder != null)
         {
            this.m_UIBorder.move(0,0);
            this.m_UIBorder.setActualSize(param1,param2);
            if(this.m_UIBorder is IInvalidating)
            {
               IInvalidating(this.m_UIBorder).validateNow();
            }
         }
      }
      
      public function get borderMetrics() : EdgeMetrics
      {
         if(this.m_UIBorder is IBorder)
         {
            return IBorder(this.m_UIBorder).borderMetrics;
         }
         return EdgeMetrics.EMPTY;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:EdgeMetrics = this.viewMetricsAndPadding;
         var _loc4_:int = 0;
         var _loc5_:int = this.m_Items.length;
         var _loc6_:IUITextField = null;
         var _loc7_:Number = _loc3_.top;
         var _loc8_:Number = _loc3_.left;
         var _loc9_:Number = param1 - _loc8_ - _loc3_.right;
         var _loc10_:Number = 0;
         this.layoutBorder(param1,param2);
         this.layoutHighlight(param1,param2);
         var _loc11_:Graphics = this.m_UIHighlight.graphics;
         _loc11_.clear();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(this.m_Items[_loc4_].separatorBefore)
            {
               _loc11_.lineStyle(1,getStyle("separatorColor"),getStyle("separatorAlpha"),true);
               _loc11_.moveTo(_loc8_ + _loc9_ * 0.05,_loc7_ + DEFAULT_SEPARATOR_HEIGHT / 2);
               _loc11_.lineTo(_loc8_ + _loc9_ * 0.95,_loc7_ + DEFAULT_SEPARATOR_HEIGHT / 2);
               _loc11_.lineStyle(NaN,0,NaN);
               _loc7_ = _loc7_ + DEFAULT_SEPARATOR_HEIGHT;
            }
            _loc6_ = _loc4_ >= this.m_UIItems.length?this.createRenderer():this.m_UIItems[_loc4_];
            _loc6_.text = this.m_Items[_loc4_].caption;
            _loc6_.move(_loc8_,_loc7_);
            _loc6_.setActualSize(_loc9_,_loc10_ = Number(_loc6_.getExplicitOrMeasuredHeight()));
            if(this.m_Highlight == _loc4_)
            {
               _loc6_.setColor(getStyle("textRollOverColor"));
               _loc11_.beginFill(getStyle("rollOverColor"),getStyle("rollOverAlpha"));
               _loc11_.drawRect(_loc8_,_loc7_,_loc9_,_loc10_);
               _loc11_.endFill();
            }
            else
            {
               _loc6_.setColor(getStyle("textColor"));
            }
            _loc6_.truncateToFit();
            _loc7_ = _loc7_ + _loc10_;
            _loc4_++;
         }
         while(this.m_UIItems.length > _loc5_)
         {
            this.removeRenderer(_loc5_);
         }
         this.m_UIDisplayed = true;
      }
   }
}

package tibia.game
{
   import mx.containers.Box;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import mx.controls.Label;
   import mx.controls.Button;
   import flash.events.MouseEvent;
   import shared.controls.CustomButton;
   import shared.utility.loopDisplayList;
   import mx.managers.IFocusManagerComponent;
   import mx.core.EdgeMetrics;
   import flash.events.KeyboardEvent;
   import mx.managers.PopUpManager;
   import tibia.input.InputHandler;
   import mx.core.Container;
   import mx.core.EventPriority;
   import mx.events.CloseEvent;
   import mx.containers.HBox;
   import flash.events.Event;
   import mx.core.IDataRenderer;
   import flash.ui.Keyboard;
   import flash.display.DisplayObjectContainer;
   import shared.controls.EmbeddedDialog;
   import mx.events.SandboxMouseEvent;
   import flash.display.Sprite;
   import mx.containers.BoxDirection;
   import mx.core.ScrollPolicy;
   
   public class PopUpBase extends Box
   {
      
      public static const BUTTON_OKAY:uint = 4;
      
      public static const BUTTON_ABORT:uint = 32;
      
      public static const KEY_ESCAPE:uint = 2;
      
      public static const BUTTON_CLOSE:uint = 16;
      
      private static var s_Instance:tibia.game.PopUpBase = null;
      
      private static const BUTTON_MASK:uint = DISABLE_BUTTONS | ENABLE_BUTTONS | BUTTON_YES | BUTTON_NO | BUTTON_OKAY | BUTTON_CANCEL | BUTTON_CLOSE | BUTTON_ABORT;
      
      private static const BUTTON_FLAGS:Array = [{
         "data":BUTTON_OKAY,
         "label":"BTN_OKAY"
      },{
         "data":BUTTON_YES,
         "label":"BTN_YES"
      },{
         "data":BUTTON_CLOSE,
         "label":"BTN_CLOSE"
      },{
         "data":BUTTON_ABORT,
         "label":"BTN_ABORT"
      },{
         "data":BUTTON_NO,
         "label":"BTN_NO"
      },{
         "data":BUTTON_CANCEL,
         "label":"BTN_CANCEL"
      }];
      
      private static const BUNDLE:String = "Global";
      
      public static const BUTTON_NONE:uint = 0;
      
      public static const BUTTON_CANCEL:uint = 8;
      
      public static const DISABLE_BUTTONS:uint = 2147483648;
      
      public static const ENABLE_BUTTONS:uint = 0;
      
      public static const BUTTON_NO:uint = 2;
      
      private static const KEY_MASK:uint = KEY_ENTER | KEY_ESCAPE;
      
      public static const KEY_NONE:uint = 0;
      
      public static const BUTTON_YES:uint = 1;
      
      public static const KEY_ENTER:uint = 1;
       
      private var m_UITitleLabel:Label = null;
      
      private var m_ButtonFlags:uint = 0;
      
      private var m_UncommittedTitle:Boolean = false;
      
      private var m_DragStartX:Number = NaN;
      
      private var m_UIHeader:Container = null;
      
      private var m_InvalidFocus:Boolean = false;
      
      private var m_UIFooter:Container = null;
      
      private var m_UncommittedButtonFlags:Boolean = true;
      
      private var m_Title:String = null;
      
      private var m_KeyboardFlags:uint = 0;
      
      private var m_UIConstructed:Boolean = false;
      
      private var m_DragStartY:Number = NaN;
      
      private var m_UIEmbeddedMouseShield:Sprite;
      
      private var m_UIEmbeddedDialog:EmbeddedDialog = null;
      
      public function PopUpBase()
      {
         this.m_UIEmbeddedMouseShield = new Sprite();
         super();
         direction = BoxDirection.VERTICAL;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
         this.buttonFlags = BUTTON_CANCEL | BUTTON_OKAY;
         this.keyboardFlags = KEY_ENTER | KEY_ESCAPE;
      }
      
      public static function s_GetParentPopUp(param1:DisplayObject) : tibia.game.PopUpBase
      {
         while(param1 != null && !(param1 is Stage) && !(param1 is tibia.game.PopUpBase))
         {
            param1 = param1.parent as DisplayObject;
         }
         return param1 as tibia.game.PopUpBase;
      }
      
      public static function s_GetInstance() : tibia.game.PopUpBase
      {
         return s_Instance;
      }
      
      public static function s_HideInstance() : void
      {
         if(s_Instance != null)
         {
            s_Instance.close(false);
            s_Instance = null;
         }
      }
      
      public function set keyboardFlags(param1:uint) : void
      {
         param1 = param1 & KEY_MASK;
         if(this.m_KeyboardFlags != param1)
         {
            this.m_KeyboardFlags = param1;
         }
      }
      
      override protected function commitProperties() : void
      {
         var _Button:Button = null;
         var i:int = 0;
         var Candidates:Array = null;
         super.commitProperties();
         if(this.m_UncommittedTitle)
         {
            this.m_UITitleLabel.text = this.m_Title;
            this.m_UncommittedTitle = false;
         }
         if(this.m_UncommittedButtonFlags)
         {
            _Button = null;
            i = 0;
            i = this.m_UIFooter.numChildren - 1;
            while(i >= 0)
            {
               _Button = Button(this.m_UIFooter.removeChildAt(i));
               _Button.removeEventListener(MouseEvent.CLICK,this.onClose);
               i--;
            }
            i = 0;
            while(i < BUTTON_FLAGS.length)
            {
               if((this.buttonFlags & BUTTON_FLAGS[i].data) != 0)
               {
                  _Button = new CustomButton();
                  _Button.data = BUTTON_FLAGS[i].data;
                  _Button.enabled = (this.buttonFlags & DISABLE_BUTTONS) == 0;
                  _Button.label = resourceManager.getString(BUNDLE,BUTTON_FLAGS[i].label);
                  _Button.addEventListener(MouseEvent.CLICK,this.onClose);
                  this.m_UIFooter.addChild(_Button);
               }
               i++;
            }
            this.m_UncommittedButtonFlags = false;
         }
         if(this.m_InvalidFocus)
         {
            Candidates = [];
            loopDisplayList(this.focusRoot,null,function(param1:*):void
            {
               if(Boolean(param1 is IFocusManagerComponent) && (Boolean(!param1.hasOwnProperty("editable") || param1.editable)) && (Boolean(!param1.hasOwnProperty("enabled")) || Boolean(param1.enabled)))
               {
                  Candidates.push(param1);
               }
            });
            if(Candidates.length > 0)
            {
               Candidates = Candidates.sortOn("tabIndex",Array.NUMERIC);
               Candidates[0].setFocus();
            }
            else
            {
               setFocus();
            }
            this.m_InvalidFocus = false;
         }
      }
      
      public function get buttonFlags() : uint
      {
         return this.m_ButtonFlags;
      }
      
      override public function get borderMetrics() : EdgeMetrics
      {
         var _loc1_:EdgeMetrics = super.borderMetrics.clone();
         if(getStyle("borderBottom") !== undefined)
         {
            _loc1_.bottom = _loc1_.bottom + getStyle("borderBottom");
         }
         else
         {
            _loc1_.bottom = _loc1_.bottom + this.m_UIFooter.getExplicitOrMeasuredHeight();
         }
         if(getStyle("borderLeft") !== undefined)
         {
            _loc1_.left = _loc1_.left + getStyle("borderLeft");
         }
         if(getStyle("borderRight") !== undefined)
         {
            _loc1_.right = _loc1_.right + getStyle("borderRight");
         }
         if(getStyle("borderTop") !== undefined)
         {
            _loc1_.top = _loc1_.top + getStyle("borderTop");
         }
         else
         {
            _loc1_.top = _loc1_.top + this.m_UIHeader.getExplicitOrMeasuredHeight();
         }
         return _loc1_;
      }
      
      public function close(param1:Boolean) : void
      {
         if(s_Instance == this)
         {
            s_Instance = null;
         }
         removeEventListener(KeyboardEvent.KEY_DOWN,this.onClose);
         var _loc2_:int = this.m_UIFooter.numChildren - 1;
         while(_loc2_ >= 0)
         {
            this.m_UIFooter.getChildAt(_loc2_).removeEventListener(MouseEvent.CLICK,this.onClose);
            _loc2_--;
         }
         PopUpManager.removePopUp(this);
         var _loc3_:InputHandler = Tibia.s_GetInputHandler();
         if(_loc3_ != null)
         {
            _loc3_.captureKeyboard = true;
         }
      }
      
      public function set title(param1:String) : void
      {
         if(this.m_Title != param1)
         {
            this.m_Title = param1;
            this.m_UncommittedTitle = true;
            invalidateProperties();
         }
      }
      
      protected function get header() : Container
      {
         return this.m_UIHeader;
      }
      
      public function show() : void
      {
         tibia.game.PopUpBase.s_HideInstance();
         ContextMenuBase.s_HideInstance();
         var _loc1_:InputHandler = Tibia.s_GetInputHandler();
         if(_loc1_ != null)
         {
            _loc1_.captureKeyboard = false;
            _loc1_.validateNow();
         }
         PopUpManager.addPopUp(this,Tibia.s_GetInstance(),true);
         PopUpManager.centerPopUp(this);
         addEventListener(KeyboardEvent.KEY_DOWN,this.onClose,false,EventPriority.DEFAULT_HANDLER,false);
         this.invalidateFocus();
         s_Instance = this;
      }
      
      private function onEmbeddedDialogClose(param1:CloseEvent) : void
      {
         if(!param1.cancelable || !param1.isDefaultPrevented())
         {
            this.embeddedDialog = null;
         }
      }
      
      public function get title() : String
      {
         return this.m_Title;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var a_UnscaledWidth:Number = param1;
         var a_UnscaledHeight:Number = param2;
         super.updateDisplayList(a_UnscaledWidth,a_UnscaledHeight);
         var v:EdgeMetrics = this.borderMetrics;
         var h:Number = 0;
         var w:Number = a_UnscaledWidth - v.left - v.right;
         h = this.m_UIHeader.getExplicitOrMeasuredHeight();
         this.m_UIHeader.move(v.left,(v.top - h) / 2);
         this.m_UIHeader.setActualSize(w,h);
         h = this.m_UIFooter.getExplicitOrMeasuredHeight();
         this.m_UIFooter.move(v.left,a_UnscaledHeight - (v.bottom + h) / 2);
         this.m_UIFooter.setActualSize(w,h);
         if(this.m_UIEmbeddedDialog != null)
         {
            if(this.m_UIEmbeddedMouseShield != null)
            {
               this.m_UIEmbeddedMouseShield.x = 0;
               this.m_UIEmbeddedMouseShield.y = 0;
               with(this.m_UIEmbeddedMouseShield.graphics)
               {
                  
                  clear();
                  beginFill(65280,0);
                  drawRect(0,0,a_UnscaledWidth,a_UnscaledHeight);
                  endFill();
               }
            }
            h = this.m_UIEmbeddedDialog.getExplicitOrMeasuredHeight();
            this.m_UIEmbeddedDialog.move(v.left,v.top + (a_UnscaledHeight - v.top - v.bottom - h) / 2);
            this.m_UIEmbeddedDialog.setActualSize(w,h);
            rawChildren.setChildIndex(this.m_UIEmbeddedDialog,rawChildren.numChildren - 1);
         }
      }
      
      protected function get footer() : Container
      {
         return this.m_UIFooter;
      }
      
      protected function invalidateFocus() : void
      {
         this.m_InvalidFocus = true;
         invalidateProperties();
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIFooter = new HBox();
            this.m_UIFooter.percentHeight = NaN;
            this.m_UIFooter.percentWidth = 100;
            this.m_UIFooter.styleName = getStyle("footerStyle");
            rawChildren.addChild(this.m_UIFooter);
            this.m_UIHeader = new HBox();
            this.m_UIHeader.percentHeight = NaN;
            this.m_UIHeader.percentWidth = 100;
            this.m_UIHeader.styleName = getStyle("headerStyle");
            this.m_UIHeader.addEventListener(MouseEvent.MOUSE_DOWN,this.onDrag);
            rawChildren.addChild(this.m_UIHeader);
            this.m_UITitleLabel = new Label();
            this.m_UITitleLabel.styleName = getStyle("titleStyle");
            this.m_UIHeader.addChild(this.m_UITitleLabel);
            this.m_UIConstructed = true;
         }
      }
      
      public function get keyboardFlags() : uint
      {
         return this.m_KeyboardFlags;
      }
      
      private function onClose(param1:Event) : void
      {
         var _loc3_:IDataRenderer = null;
         var _loc2_:CloseEvent = null;
         if(param1 is KeyboardEvent && (param1 as KeyboardEvent).keyCode == Keyboard.ENTER && (this.m_KeyboardFlags & tibia.game.PopUpBase.KEY_ENTER) != 0)
         {
            _loc2_ = new CloseEvent(CloseEvent.CLOSE,false,true);
            _loc2_.detail = tibia.game.PopUpBase.BUTTON_OKAY;
            dispatchEvent(_loc2_);
         }
         else if(param1 is KeyboardEvent && (param1 as KeyboardEvent).keyCode == Keyboard.ESCAPE && (this.m_KeyboardFlags & tibia.game.PopUpBase.KEY_ESCAPE) != 0)
         {
            _loc2_ = new CloseEvent(CloseEvent.CLOSE,false,true);
            _loc2_.detail = tibia.game.PopUpBase.BUTTON_CANCEL;
            dispatchEvent(_loc2_);
         }
         else if(param1 is MouseEvent && param1.type == MouseEvent.CLICK)
         {
            _loc3_ = param1.currentTarget as IDataRenderer;
            if(_loc3_ != null)
            {
               _loc2_ = new CloseEvent(CloseEvent.CLOSE,false,true);
               _loc2_.detail = uint(_loc3_.data);
               dispatchEvent(_loc2_);
            }
         }
         if(_loc2_ != null && (!_loc2_.cancelable || !_loc2_.isDefaultPrevented()))
         {
            this.close(_loc2_.detail == tibia.game.PopUpBase.BUTTON_OKAY || _loc2_.detail == tibia.game.PopUpBase.BUTTON_YES);
         }
      }
      
      protected function get focusRoot() : DisplayObjectContainer
      {
         return this;
      }
      
      public function set buttonFlags(param1:uint) : void
      {
         param1 = param1 & BUTTON_MASK;
         if(this.m_ButtonFlags != param1)
         {
            this.m_ButtonFlags = param1;
            this.m_UncommittedButtonFlags = true;
            invalidateProperties();
         }
      }
      
      public function set embeddedDialog(param1:EmbeddedDialog) : void
      {
         if(this.m_UIEmbeddedDialog != param1)
         {
            if(this.m_UIEmbeddedDialog != null)
            {
               this.m_UIEmbeddedDialog.removeEventListener(CloseEvent.CLOSE,this.onEmbeddedDialogClose);
               if(rawChildren.contains(this.m_UIEmbeddedMouseShield))
               {
                  rawChildren.removeChild(this.m_UIEmbeddedMouseShield);
               }
               if(rawChildren.contains(this.m_UIEmbeddedDialog))
               {
                  rawChildren.removeChild(this.m_UIEmbeddedDialog);
               }
               setFocus();
            }
            this.m_UIEmbeddedDialog = param1;
            if(this.m_UIEmbeddedDialog != null)
            {
               this.m_UIEmbeddedDialog.addEventListener(CloseEvent.CLOSE,this.onEmbeddedDialogClose,false,EventPriority.DEFAULT_HANDLER,false);
               rawChildren.addChild(this.m_UIEmbeddedMouseShield);
               rawChildren.addChild(this.m_UIEmbeddedDialog);
               this.m_UIEmbeddedDialog.setFocus();
            }
         }
      }
      
      private function onDrag(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 != null)
         {
            _loc2_ = systemManager.getSandboxRoot();
            switch(param1.type)
            {
               case MouseEvent.MOUSE_DOWN:
                  if(Boolean(isPopUp) && Boolean(isNaN(this.m_DragStartX)) && Boolean(isNaN(this.m_DragStartY)))
                  {
                     _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.onDrag);
                     _loc2_.addEventListener(MouseEvent.MOUSE_UP,this.onDrag);
                     _loc2_.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.onDrag);
                     systemManager.deployMouseShields(true);
                     this.m_DragStartX = MouseEvent(param1).stageX - x;
                     this.m_DragStartY = MouseEvent(param1).stageY - y;
                  }
                  break;
               case MouseEvent.MOUSE_MOVE:
                  param1.preventDefault();
                  param1.stopImmediatePropagation();
                  if(!isNaN(this.m_DragStartX) && !isNaN(this.m_DragStartY))
                  {
                     move(MouseEvent(param1).stageX - this.m_DragStartX,MouseEvent(param1).stageY - this.m_DragStartY);
                  }
                  break;
               case MouseEvent.MOUSE_UP:
               case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                  _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDrag);
                  _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.onDrag);
                  _loc2_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.onDrag);
                  systemManager.deployMouseShields(false);
                  this.m_DragStartX = NaN;
                  this.m_DragStartY = NaN;
            }
         }
      }
      
      public function get embeddedDialog() : EmbeddedDialog
      {
         return this.m_UIEmbeddedDialog;
      }
   }
}

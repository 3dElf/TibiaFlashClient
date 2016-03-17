package tibia.game
{
   import mx.controls.Text;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import shared.controls.CustomButton;
   import mx.controls.Button;
   import flash.events.Event;
   import mx.events.CloseEvent;
   import mx.core.IDataRenderer;
   import flash.errors.IllegalOperationError;
   import tibia.network.Connection;
   
   public class ServerModalDialog extends PopUpBase
   {
       
      private var m_UIMessage:Text = null;
      
      private var m_DefaultEscapeButton:uint = 255;
      
      private var m_Buttons:Array;
      
      private var m_Message:String = null;
      
      private var m_DefaultEnterButton:uint = 255;
      
      private var m_ID:uint = 0;
      
      private var m_UncommittedButtons:Boolean = false;
      
      private var m_UncommittedMessage:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      public function ServerModalDialog(param1:uint)
      {
         this.m_Buttons = [];
         super();
         this.buttonFlags = BUTTON_NONE;
         keyboardFlags = KEY_NONE;
         this.m_ID = param1;
         addEventListener(CloseEvent.CLOSE,this.onClose);
      }
      
      public function get message() : String
      {
         return this.m_Message;
      }
      
      public function get buttons() : Array
      {
         return this.m_Buttons;
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         super.commitProperties();
         if(this.m_UncommittedMessage)
         {
            this.m_UIMessage.htmlText = this.message;
            this.m_UncommittedMessage = false;
         }
         if(this.m_UncommittedButtons)
         {
            _loc1_ = null;
            _loc2_ = 0;
            _loc2_ = footer.numChildren - 1;
            while(_loc2_ >= 0)
            {
               _loc1_ = footer.removeChildAt(_loc2_);
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onClose);
               _loc2_--;
            }
            _loc2_ = 0;
            while(_loc2_ < this.buttons.length)
            {
               _loc1_ = new CustomButton();
               Button(_loc1_).label = this.buttons[_loc2_].label;
               Button(_loc1_).data = this.buttons[_loc2_].value;
               _loc1_.addEventListener(MouseEvent.CLICK,this.onClose);
               footer.addChild(_loc1_);
               _loc2_++;
            }
            this.m_UncommittedButtons = false;
         }
      }
      
      public function set message(param1:String) : void
      {
         if(this.m_Message != param1)
         {
            this.m_Message = param1;
            this.m_UncommittedMessage = true;
            invalidateProperties();
         }
      }
      
      public function set buttons(param1:Array) : void
      {
         if(this.m_Buttons != param1)
         {
            if(param1 != null)
            {
               this.m_Buttons = param1;
            }
            else
            {
               this.m_Buttons = [];
            }
            this.m_UncommittedButtons = true;
            invalidateProperties();
         }
      }
      
      public function set defaultEnterButton(param1:uint) : void
      {
         if(this.m_DefaultEnterButton != param1)
         {
            this.m_DefaultEnterButton = param1;
            if(this.m_DefaultEnterButton != 255)
            {
               keyboardFlags = keyboardFlags | KEY_ENTER;
            }
            else
            {
               keyboardFlags = keyboardFlags & ~KEY_ENTER;
            }
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIMessage = new Text();
            this.m_UIMessage.htmlText = this.message;
            this.m_UIMessage.maxHeight = NaN;
            this.m_UIMessage.maxWidth = 300;
            this.m_UIMessage.percentHeight = 100;
            this.m_UIMessage.percentWidth = 100;
            addChild(this.m_UIMessage);
            this.m_UIConstructed = true;
         }
      }
      
      private function onClose(param1:Event) : void
      {
         var _loc2_:uint = 255;
         if(param1 is CloseEvent && this.defaultEscapeButton != 255 && CloseEvent(param1).detail === BUTTON_CANCEL)
         {
            _loc2_ = this.defaultEscapeButton;
         }
         else if(param1 is CloseEvent && this.defaultEnterButton != 255 && CloseEvent(param1).detail === BUTTON_OKAY)
         {
            _loc2_ = this.defaultEnterButton;
         }
         else if(param1 is MouseEvent && param1.target is IDataRenderer)
         {
            _loc2_ = uint(IDataRenderer(param1.target).data);
         }
         else
         {
            throw IllegalOperationError("ServerModalDialog.onClose: Event " + param1.type + " is not supported.");
         }
         var _loc3_:Connection = Tibia.s_GetConnection();
         if(_loc3_ != null && Boolean(_loc3_.isGameRunning))
         {
            _loc3_.sendCANSWERMODALDIALOG(this.ID,_loc2_);
         }
         if(!(param1 is CloseEvent))
         {
            this.close(false);
         }
      }
      
      public function get ID() : uint
      {
         return this.m_ID;
      }
      
      public function set defaultEscapeButton(param1:uint) : void
      {
         if(this.m_DefaultEscapeButton != param1)
         {
            this.m_DefaultEscapeButton = param1;
            if(this.m_DefaultEscapeButton != 255)
            {
               keyboardFlags = keyboardFlags | KEY_ESCAPE;
            }
            else
            {
               keyboardFlags = keyboardFlags & ~KEY_ESCAPE;
            }
         }
      }
      
      public function get defaultEnterButton() : uint
      {
         return this.m_DefaultEnterButton;
      }
      
      override public function set buttonFlags(param1:uint) : void
      {
      }
      
      public function get defaultEscapeButton() : uint
      {
         return this.m_DefaultEscapeButton;
      }
      
      override public function get buttonFlags() : uint
      {
         return BUTTON_NONE;
      }
      
      override public function close(param1:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = footer.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = footer.removeChildAt(_loc2_);
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onClose);
            _loc2_--;
         }
         super.close(param1);
      }
   }
}

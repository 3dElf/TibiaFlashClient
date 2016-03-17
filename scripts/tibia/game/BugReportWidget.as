package tibia.game
{
   import flash.events.Event;
   import shared.utility.StringHelper;
   import tibia.network.Connection;
   import mx.controls.TextArea;
   import mx.controls.Text;
   import flash.events.KeyboardEvent;
   import tibia.input.PreventWhitespaceInput;
   import flash.events.TextEvent;
   
   public class BugReportWidget extends PopUpBase
   {
      
      private static const BUNDLE:String = "BugReportWidget";
      
      public static const MAX_TOTAL_MESSAGE_LENGTH:int = MAX_USER_MESSAGE_LENGTH + 512;
      
      public static const MAX_USER_MESSAGE_LENGTH:int = 1024;
       
      protected var m_SystemMessage = null;
      
      private var m_UncommittedSystemMessage:Boolean = false;
      
      protected var m_UserMessage:String = null;
      
      private var m_UncommittedUserMessage:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIUserMessage:TextArea = null;
      
      public function BugReportWidget()
      {
         super();
         title = resourceManager.getString(BUNDLE,"TITLE");
         keyboardFlags = PopUpBase.KEY_ESCAPE;
      }
      
      protected function onTextChange(param1:Event) : void
      {
         if(param1 != null)
         {
            this.m_UserMessage = StringHelper.s_Trim(this.m_UIUserMessage.text);
         }
      }
      
      override public function close(param1:Boolean) : void
      {
         var _loc2_:Connection = null;
         if(param1)
         {
            _loc2_ = Tibia.s_GetConnection();
            if(_loc2_ != null && Boolean(_loc2_.allowBugreports) && Boolean(_loc2_.isGameRunning))
            {
               _loc2_.sendCBUGREPORT(this.m_UserMessage,this.m_SystemMessage);
            }
         }
         super.close(param1);
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedUserMessage)
         {
            this.m_UIUserMessage.text = this.m_UserMessage;
            this.m_UncommittedUserMessage = false;
         }
         if(this.m_UncommittedSystemMessage)
         {
            this.m_UncommittedSystemMessage = false;
         }
      }
      
      public function set systemMessage(param1:*) : void
      {
         if(this.m_SystemMessage != param1)
         {
            this.m_SystemMessage = param1;
            this.m_UncommittedSystemMessage = true;
            invalidateProperties();
         }
      }
      
      public function set userMessage(param1:String) : void
      {
         if(this.m_UserMessage != param1)
         {
            this.m_UserMessage = param1;
            this.m_UncommittedUserMessage = true;
            invalidateProperties();
         }
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:Text = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            _loc1_ = new Text();
            _loc1_.text = resourceManager.getString(BUNDLE,"PROMPT");
            _loc1_.percentHeight = NaN;
            _loc1_.percentWidth = 100;
            addChild(_loc1_);
            this.m_UIUserMessage = new TextArea();
            this.m_UIUserMessage.maxChars = BugReportWidget.MAX_USER_MESSAGE_LENGTH;
            this.m_UIUserMessage.minHeight = 200;
            this.m_UIUserMessage.minWidth = 300;
            this.m_UIUserMessage.percentHeight = NaN;
            this.m_UIUserMessage.percentWidth = 100;
            this.m_UIUserMessage.text = this.m_UserMessage;
            this.m_UIUserMessage.addEventListener(Event.CHANGE,this.onTextChange);
            this.m_UIUserMessage.addEventListener(KeyboardEvent.KEY_DOWN,PreventWhitespaceInput);
            this.m_UIUserMessage.addEventListener(TextEvent.TEXT_INPUT,PreventWhitespaceInput);
            addChild(this.m_UIUserMessage);
            this.m_UIConstructed = true;
         }
      }
      
      public function get userMessage() : String
      {
         return this.m_UserMessage;
      }
      
      public function get systemMessage() : *
      {
         return this.m_SystemMessage;
      }
   }
}

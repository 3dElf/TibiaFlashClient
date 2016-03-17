package tibia.game
{
   import mx.controls.Text;
   
   public class MessageWidget extends PopUpBase
   {
       
      protected var m_UIMessage:Text = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_Message:String = null;
      
      private var m_UncommittedMessage:Boolean = false;
      
      public function MessageWidget()
      {
         super();
      }
      
      public function get message() : String
      {
         return this.m_Message;
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedMessage)
         {
            this.m_UIMessage.htmlText = this.m_Message;
            this.m_UncommittedMessage = false;
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
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIMessage = new Text();
            this.m_UIMessage.htmlText = this.m_Message;
            this.m_UIMessage.maxHeight = NaN;
            this.m_UIMessage.maxWidth = 300;
            this.m_UIMessage.percentHeight = 100;
            this.m_UIMessage.percentWidth = 100;
            addChild(this.m_UIMessage);
            this.m_UIConstructed = true;
         }
      }
   }
}

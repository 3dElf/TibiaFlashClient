package tibia.game
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;

    public class MessageWidget extends PopUpBase
    {
        protected var m_UIMessage:Text = null;
        protected var m_UIMessageArea:TextArea = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_Message:String = null;
        private var m_UncommittedMessage:Boolean = false;
        protected var m_UIMessageScrollBox:VBox = null;

        public function MessageWidget()
        {
            return;
        }// end function

        public function set message(param1:String) : void
        {
            if (this.m_Message != param1)
            {
                this.m_Message = param1;
                this.m_UncommittedMessage = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get message() : String
        {
            return this.m_Message;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedMessage)
            {
                this.m_UIMessage.htmlText = this.m_Message;
                this.m_UncommittedMessage = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIMessage = new Text();
                this.m_UIMessage.htmlText = this.m_Message;
                this.m_UIMessage.maxHeight = NaN;
                this.m_UIMessageScrollBox = new VBox();
                this.m_UIMessageScrollBox.horizontalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIMessageScrollBox.verticalScrollPolicy = ScrollPolicy.AUTO;
                this.m_UIMessageScrollBox.addChild(this.m_UIMessage);
                _loc_1 = borderMetrics;
                this.m_UIMessageScrollBox.maxHeight = this.parent.height - _loc_1.top - _loc_1.bottom;
                this.m_UIMessageScrollBox.setStyle("paddingRight", "20");
                this.m_UIMessage.maxWidth = this.parent.width - _loc_1.left - _loc_1.right - 20;
                addChild(this.m_UIMessageScrollBox);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}

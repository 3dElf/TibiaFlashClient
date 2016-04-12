package tibia.chat.chatWidgetClasses
{
    import mx.controls.*;

    public class NicklistItemRenderer extends Label
    {
        private var m_UncommittedData:Boolean = false;
        public static const HEIGHT_HINT:Number = 18;

        public function NicklistItemRenderer()
        {
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.m_UncommittedData = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedData)
            {
                if (data != null && data is NicklistItem)
                {
                    _loc_1 = data as NicklistItem;
                    text = _loc_1.name;
                    if (_loc_1.state == NicklistItem.STATE_SUBSCRIBER)
                    {
                        setStyle("color", getStyle("subscriberTextColor"));
                    }
                    else if (_loc_1.state == NicklistItem.STATE_INVITED)
                    {
                        setStyle("color", getStyle("inviteeTextColor"));
                    }
                    else if (_loc_1.state == NicklistItem.STATE_PENDING)
                    {
                        setStyle("color", getStyle("pendingTextColor"));
                    }
                }
                else
                {
                    text = null;
                    setStyle("color", 0);
                }
                this.m_UncommittedData = false;
            }
            return;
        }// end function

    }
}

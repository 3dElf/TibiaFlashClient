package tibia.chat.chatWidgetClasses
{
    import flash.events.*;
    import mx.events.*;
    import tibia.chat.*;
    import tibia.controls.*;
    import tibia.controls.dynamicTabBarClasses.*;

    public class ChannelTab extends DynamicTab
    {
        protected var m_Highlight:Boolean = true;
        protected var m_Channel:Channel = null;
        private var m_UncommittedChannel:Boolean = false;
        private var m_UncomittedHighlight:Boolean = false;

        public function ChannelTab()
        {
            addEventListener(MouseEvent.RIGHT_CLICK, this.onTabClick);
            return;
        }// end function

        protected function onChannelProperty(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "closable":
                    {
                        closePolicy = this.m_Channel != null && this.m_Channel.closable ? (DynamicTabBar.CLOSE_SELECTED) : (DynamicTabBar.CLOSE_NEVER);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get channel() : Channel
        {
            return this.m_Channel;
        }// end function

        protected function onChannelMessage(event:CollectionEvent) : void
        {
            if (event != null && event.kind == CollectionEventKind.ADD)
            {
                this.highlight = true;
            }
            return;
        }// end function

        public function set channel(param1:Channel) : void
        {
            if (this.m_Channel != param1)
            {
                if (this.m_Channel != null)
                {
                    this.m_Channel.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onChannelMessage);
                    this.m_Channel.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onChannelProperty);
                }
                this.m_Channel = param1;
                this.m_UncommittedChannel = true;
                invalidateProperties();
                if (this.m_Channel != null)
                {
                    this.m_Channel.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onChannelMessage, false, int.MIN_VALUE, false);
                    this.m_Channel.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onChannelProperty, false, int.MIN_VALUE, false);
                }
            }
            return;
        }// end function

        public function set highlight(param1:Boolean) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (this.m_Highlight != param1)
            {
                _loc_2 = this.m_Highlight;
                this.m_Highlight = param1;
                this.m_UncomittedHighlight = true;
                invalidateProperties();
                _loc_3 = new ChannelEvent(param1 ? (ChannelEvent.HIGHLIGHT) : (ChannelEvent.DEHIGHLIGHT));
                _loc_3.channel = this.m_Channel;
                dispatchEvent(_loc_3);
                if (!_loc_3.cancelable || !_loc_3.isDefaultPrevented())
                {
                    this.m_Highlight = param1;
                }
                else
                {
                    this.m_Highlight = _loc_2;
                }
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "highlightTextColor":
                {
                    this.updateTextColor();
                    break;
                }
                default:
                {
                    super.styleChanged(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedChannel)
            {
                closePolicy = this.m_Channel != null && this.m_Channel.closable ? (DynamicTabBar.CLOSE_SELECTED) : (DynamicTabBar.CLOSE_NEVER);
                this.highlight = false;
                this.m_UncommittedChannel = false;
            }
            if (this.m_UncomittedHighlight)
            {
                this.updateTextColor();
                this.m_UncomittedHighlight = false;
            }
            return;
        }// end function

        override protected function updateTextColor() : void
        {
            var _loc_1:* = undefined;
            if (this.m_Highlight)
            {
                _loc_1 = getStyle("highlightTextColor");
                setStyle("color", _loc_1);
                setStyle("errorColor", _loc_1);
                setStyle("textRollOverColor", _loc_1);
                setStyle("textSelectedColor", _loc_1);
            }
            else
            {
                super.updateTextColor();
            }
            return;
        }// end function

        public function forceHighlight() : void
        {
            this.m_Highlight = true;
            this.m_UncomittedHighlight = true;
            invalidateProperties();
            return;
        }// end function

        public function get highlight() : Boolean
        {
            return this.m_Highlight;
        }// end function

        protected function onTabClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = new ChannelEvent(ChannelEvent.TAB_CONTEXT_MENU);
                _loc_2.channel = this.m_Channel;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

    }
}

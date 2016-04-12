package tibia.chat
{
    import flash.events.*;
    import mx.collections.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.game.*;
    import tibia.input.*;

    public class ChannelSelectionWidget extends PopUpBase
    {
        protected var m_UncommittedChannels:Boolean = false;
        protected var m_Channels:IList = null;
        protected var m_UIInput:TextInput = null;
        protected var m_UIList:List = null;
        private var m_UIConstructed:Boolean = false;
        private static const BUNDLE:String = "ChannelSelectionWidget";

        public function ChannelSelectionWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            return;
        }// end function

        public function set channels(param1:IList) : void
        {
            if (this.m_Channels != param1)
            {
                this.m_Channels = param1;
                this.m_UncommittedChannels = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedChannels)
            {
                this.m_UIList.dataProvider = this.m_Channels;
                this.m_UncommittedChannels = false;
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetChatStorage();
            if (param1 && _loc_2 != null)
            {
                if (this.m_UIInput.text.length > 0)
                {
                    _loc_2.joinChannel(this.m_UIInput.text);
                }
                else if (this.m_UIList.selectedItem != null)
                {
                    _loc_2.joinChannel(this.m_UIList.selectedItem.ID);
                }
            }
            super.hide(param1);
            return;
        }// end function

        protected function onChannelEnter(event:FlexEvent) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = this.m_UIInput.text.length > 0;
                _loc_3 = new CloseEvent(CloseEvent.CLOSE, false, true);
                _loc_3.detail = _loc_2 ? (PopUpBase.BUTTON_OKAY) : (PopUpBase.BUTTON_CANCEL);
                dispatchEvent(_loc_3);
                if (!_loc_3.cancelable || !_loc_3.isDefaultPrevented())
                {
                    this.m_UIInput.removeEventListener(FlexEvent.ENTER, this.onChannelEnter);
                    this.hide(_loc_2);
                }
            }
            return;
        }// end function

        public function get channels() : IList
        {
            return this.m_Channels;
        }// end function

        protected function onChannelDoubleClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                var _loc_4:* = this.m_UIList;
                _loc_2 = _loc_4.mx_internal::mouseEventToItemRendererOrEditor(event);
                if (_loc_2 != null)
                {
                    _loc_3 = new CloseEvent(CloseEvent.CLOSE, false, true);
                    _loc_3.detail = PopUpBase.BUTTON_OKAY;
                    dispatchEvent(_loc_3);
                    if (!_loc_3.cancelable || !_loc_3.isDefaultPrevented())
                    {
                        _loc_4.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onChannelDoubleClick);
                        this.hide(true);
                    }
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new Label();
                _loc_1.text = resourceManager.getString(BUNDLE, "LBL_SELECT_CHANNEL");
                addChild(_loc_1);
                this.m_UIList = new CustomList();
                this.m_UIList.dataProvider = this.m_Channels;
                this.m_UIList.doubleClickEnabled = true;
                this.m_UIList.labelField = "name";
                this.m_UIList.percentWidth = 100;
                this.m_UIList.percentHeight = 100;
                this.m_UIList.addEventListener(MouseEvent.DOUBLE_CLICK, this.onChannelDoubleClick);
                addChild(this.m_UIList);
                _loc_1 = new Label();
                _loc_1.text = resourceManager.getString(BUNDLE, "LBL_ENTER_NAME");
                addChild(_loc_1);
                this.m_UIInput = new TextInput();
                this.m_UIInput.percentHeight = NaN;
                this.m_UIInput.percentWidth = 100;
                this.m_UIInput.addEventListener(FlexEvent.ENTER, this.onChannelEnter);
                this.m_UIInput.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIInput.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                addChild(this.m_UIInput);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}

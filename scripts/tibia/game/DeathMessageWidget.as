package tibia.game
{
    import flash.events.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;

    public class DeathMessageWidget extends MessageWidget
    {
        private var m_UncommittedExtraButtonFlags:Boolean = false;
        protected var m_ExtraButtonFlags:uint = 0;
        private static const EXTRA_BUTTON_FLAGS:Array = [{data:EXTRA_BUTTON_STORE, label:"BTN_STORE"}];
        private static const BUNDLE:String = "DeathMessageWidget";
        public static const EXTRA_BUTTON_STORE:uint = 4194304;
        private static const EXTRA_BUTTON_MASK:uint = 4194304;

        public function DeathMessageWidget()
        {
            this.buttonFlags = BUTTON_CANCEL | BUTTON_OKAY | EXTRA_BUTTON_STORE;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedExtraButtonFlags)
            {
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = null;
                _loc_1 = footer.numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_3 = Button(footer.getChildAt(_loc_1));
                    if ((uint(_loc_3.data) & EXTRA_BUTTON_MASK) != 0)
                    {
                        _loc_3.removeEventListener(MouseEvent.CLICK, this.onExtraButton);
                        footer.removeChildAt(_loc_1);
                    }
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1 = 0;
                while (_loc_1 < EXTRA_BUTTON_FLAGS.length)
                {
                    
                    if ((this.m_ExtraButtonFlags & EXTRA_BUTTON_FLAGS[_loc_1].data) != 0)
                    {
                        _loc_3 = new CustomButton();
                        _loc_3.enabled = (this.m_ExtraButtonFlags & PopUpBase.DISABLE_BUTTONS) == 0;
                        _loc_3.label = resourceManager.getString(BUNDLE, EXTRA_BUTTON_FLAGS[_loc_1].label);
                        _loc_3.data = EXTRA_BUTTON_FLAGS[_loc_1].data;
                        _loc_3.addEventListener(MouseEvent.CLICK, this.onExtraButton);
                        footer.addChildAt(_loc_3, _loc_2);
                        _loc_2++;
                    }
                    _loc_1++;
                }
                this.m_UncommittedExtraButtonFlags = true;
            }
            return;
        }// end function

        protected function onExtraButton(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = event.currentTarget as Button;
                if (_loc_2 == null)
                {
                    return;
                }
                switch(uint(_loc_2.data))
                {
                    case EXTRA_BUTTON_STORE:
                    {
                        _loc_3 = new CloseEvent(CloseEvent.CLOSE, true, false);
                        _loc_3.detail = DeathMessageWidget.EXTRA_BUTTON_STORE;
                        dispatchEvent(_loc_3);
                        if (!_loc_3.cancelable || !_loc_3.isDefaultPrevented())
                        {
                            hide(false);
                        }
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

        override public function get buttonFlags() : uint
        {
            return super.buttonFlags | this.m_ExtraButtonFlags;
        }// end function

        override public function set buttonFlags(param1:uint) : void
        {
            super.buttonFlags = param1;
            var _loc_2:* = param1 & EXTRA_BUTTON_MASK;
            if (this.m_ExtraButtonFlags != _loc_2)
            {
                this.m_ExtraButtonFlags = _loc_2;
                this.m_UncommittedExtraButtonFlags = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}

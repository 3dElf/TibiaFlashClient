package tibia.game
{
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;

    public class TimeoutWaitWidget extends MessageWidget
    {
        protected var m_ShowTimestamp:Number = -1;
        protected var m_Timeout:Number = 0;
        private var m_UncommittedTimeout:Boolean = false;
        private var m_UncommittedMessage:Boolean = false;
        private static const BUNDLE:String = "Tibia";
        public static const TIMOUT_EXPIRED:int = 2147483647;

        public function TimeoutWaitWidget()
        {
            buttonFlags = PopUpBase.BUTTON_ABORT;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            return;
        }// end function

        public function get timeout() : Number
        {
            return this.m_Timeout;
        }// end function

        public function set timeout(param1:Number) : void
        {
            if (this.m_Timeout != param1)
            {
                this.m_Timeout = param1;
                this.m_UncommittedTimeout = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get remainingTime() : Number
        {
            if (this.m_ShowTimestamp > -1)
            {
                return this.m_ShowTimestamp + this.m_Timeout - getTimer();
            }
            return this.m_Timeout;
        }// end function

        protected function updateMessage() : void
        {
            return;
        }// end function

        protected function onTimer(event:TimerEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null)
            {
                _loc_2 = this.remainingTime;
                if (_loc_2 <= 0)
                {
                    Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onTimer);
                    this.onTimeoutOccurred();
                }
                else
                {
                    this.updateMessage();
                }
            }
            return;
        }// end function

        public function get elapsedTime() : Number
        {
            if (this.m_ShowTimestamp > -1)
            {
                return getTimer() - this.m_ShowTimestamp;
            }
            return getTimer();
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = false;
            if (this.m_UncommittedMessage)
            {
                _loc_1 = true;
                this.m_UncommittedMessage = false;
            }
            if (this.m_UncommittedTimeout)
            {
                _loc_1 = true;
                this.m_UncommittedTimeout = false;
            }
            if (_loc_1)
            {
                this.updateMessage();
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            if (this.m_ShowTimestamp > -1)
            {
                this.m_ShowTimestamp = -1;
                Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onTimer);
            }
            return;
        }// end function

        protected function getTimeString(param1:uint) : String
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 > 60000)
            {
                _loc_2 = Math.ceil(param1 / 60000);
                _loc_3 = _loc_2 == 1 ? (resourceManager.getString(BUNDLE, "TEXT_MINUTE", [_loc_2])) : (resourceManager.getString(BUNDLE, "TEXT_MINUTES", [_loc_2]));
            }
            else
            {
                _loc_2 = Math.ceil(param1 / 1000);
                _loc_3 = _loc_2 == 1 ? (resourceManager.getString(BUNDLE, "TEXT_SECOND", [_loc_2])) : (resourceManager.getString(BUNDLE, "TEXT_SECONDS", [_loc_2]));
            }
            return _loc_3;
        }// end function

        override public function set message(param1:String) : void
        {
            if (message != param1)
            {
                super.message = param1;
                this.m_UncommittedMessage = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function show() : void
        {
            super.show();
            if (this.m_ShowTimestamp < 0)
            {
                this.m_ShowTimestamp = getTimer();
                Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onTimer);
            }
            return;
        }// end function

        protected function onTimeoutOccurred() : void
        {
            var _loc_1:* = new CloseEvent(CloseEvent.CLOSE);
            _loc_1.detail = TIMOUT_EXPIRED;
            dispatchEvent(_loc_1);
            return;
        }// end function

    }
}

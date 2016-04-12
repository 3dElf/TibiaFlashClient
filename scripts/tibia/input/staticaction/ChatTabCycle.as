package tibia.input.staticaction
{
    import mx.collections.*;
    import tibia.chat.*;

    public class ChatTabCycle extends StaticAction
    {
        protected var m_Direction:int = 1;
        public static const NEXT:int = 1;
        public static const PREV:int = -1;

        public function ChatTabCycle(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != NEXT && param4 != PREV)
            {
                throw new ArgumentError("ChatTabCycle.ChatTabCycle: Invalid direction: " + param4);
            }
            this.m_Direction = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = Tibia.s_GetChatStorage();
            var _loc_3:* = Tibia.s_GetChatWidget();
            var _loc_4:* = null;
            var _loc_6:* = _loc_2.channels;
            _loc_4 = _loc_2.channels;
            if (_loc_2 != null && _loc_6 != null && _loc_3 != null && _loc_3.leftChannel != null)
            {
                _loc_5 = _loc_4.getItemIndex(_loc_3.leftChannel) + this.m_Direction;
                if (_loc_5 >= _loc_4.length)
                {
                    _loc_5 = _loc_5 - _loc_4.length;
                }
                if (_loc_5 < 0)
                {
                    _loc_5 = _loc_5 + _loc_4.length;
                }
                _loc_3.leftChannel = _loc_4.getItemAt(_loc_5) as Channel;
            }
            return;
        }// end function

    }
}

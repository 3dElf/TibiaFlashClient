package tibia.input.gameaction
{
    import mx.resources.*;
    import tibia.input.*;

    public class TalkAction extends TalkActionImpl implements IAction
    {
        private var m_PerformTimestamp:Number = 0;
        private static const BUNDLE:String = "StaticAction";
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        private static const MIN_TALK_DELAY:int = 2500;

        public function TalkAction(param1:String, param2:Boolean)
        {
            super(param1, param2, TalkActionImpl.CURRENT_CHANNEL_ID);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            if (param1 && m_AutoSend && this.m_PerformTimestamp + MIN_TALK_DELAY > Tibia.s_FrameTibiaTimestamp)
            {
                return;
            }
            super.perform(param1);
            this.m_PerformTimestamp = Tibia.s_FrameTibiaTimestamp;
            return;
        }// end function

        public function get text() : String
        {
            return m_Text;
        }// end function

        public function marshall() : XML
        {
            return new XML("<action type=\"talk\" autoSend=\"" + m_AutoSend + "\" text=\"" + m_Text + "\"/>");
        }// end function

        public function get hidden() : Boolean
        {
            return true;
        }// end function

        public function get autoSend() : Boolean
        {
            return m_AutoSend;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            return _loc_1.getString(BUNDLE, "GAME_TALK", [m_Text]);
        }// end function

        public function clone() : IAction
        {
            return new TalkAction(m_Text, m_AutoSend);
        }// end function

        public function equals(param1:IAction) : Boolean
        {
            return param1 is TalkAction && TalkAction(param1).m_AutoSend == m_AutoSend && TalkAction(param1).m_Text == m_Text;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : TalkAction
        {
            if (param1 == null || param1.localName() != "action" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("TalkAction.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_6:* = param1.@type;
            _loc_3 = param1.@type;
            if (_loc_6 == null || _loc_3.length() != 1 || _loc_3[0].toString() != "talk")
            {
                return null;
            }
            var _loc_4:* = false;
            var _loc_6:* = param1.@autoSend;
            _loc_3 = param1.@autoSend;
            if (_loc_6 != null && _loc_3.length() == 1)
            {
                _loc_4 = _loc_3[0].toString() == "true";
            }
            var _loc_5:* = null;
            var _loc_6:* = param1.@text;
            _loc_3 = param1.@text;
            if (_loc_6 != null && _loc_3.length() == 1)
            {
                _loc_5 = _loc_3[0].toString();
            }
            else
            {
                var _loc_6:* = param1.text();
                _loc_3 = param1.text();
                if (_loc_6 != null && _loc_3.length() == 1)
                {
                    _loc_5 = _loc_3[0].toString();
                }
            }
            if (_loc_5 != null && _loc_5.length > 0)
            {
                return new TalkAction(_loc_5, _loc_4);
            }
            return null;
        }// end function

    }
}

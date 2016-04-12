package tibia.input.gameaction
{
    import mx.resources.*;
    import tibia.chat.*;
    import tibia.input.*;
    import tibia.options.*;

    public class NameFilterActionImpl extends Object implements IActionImpl
    {
        private var m_Type:int = -1;
        private var m_Name:String = null;
        public static const IGNORE:int = 0;
        private static const BUNDLE:String = "ChatStorage";
        public static const UNIGNORE:int = 1;

        public function NameFilterActionImpl(param1:int, param2:String)
        {
            if (param1 != IGNORE && param1 != UNIGNORE)
            {
                throw new ArgumentError("NameFilterActionImpl.NameFilterActionImpl: Invalid type: " + param1 + ".");
            }
            if (param2 == null)
            {
                throw new ArgumentError("NameFilterActionImpl.NameFilterActionImpl: Invalid player name.");
            }
            this.m_Type = param1;
            this.m_Name = param2;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetChatStorage();
            var _loc_3:* = Tibia.s_GetOptions();
            var _loc_4:* = null;
            var _loc_5:* = _loc_3.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            _loc_4 = _loc_3.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            if (_loc_2 != null && _loc_3 != null && _loc_5 != null)
            {
                switch(this.m_Type)
                {
                    case IGNORE:
                    {
                        _loc_4.addBlacklist(this.m_Name, false);
                        _loc_2.addChannelMessage(ChatStorage.SERVER_CHANNEL_ID, -1, null, 0, MessageMode.MESSAGE_STATUS, ResourceManager.getInstance().getString(BUNDLE, "MSG_IGNORE", [this.m_Name]));
                        break;
                    }
                    case UNIGNORE:
                    {
                        _loc_4.removeBlacklist(this.m_Name);
                        _loc_2.addChannelMessage(ChatStorage.SERVER_CHANNEL_ID, -1, null, 0, MessageMode.MESSAGE_STATUS, ResourceManager.getInstance().getString(BUNDLE, "MSG_UNIGNORE", [this.m_Name]));
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

        public static function s_IsBlacklisted(param1:String) : Boolean
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = _loc_2.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            _loc_3 = _loc_2.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            return _loc_2 != null && _loc_4 != null && _loc_3.isBlacklisted(param1);
        }// end function

    }
}

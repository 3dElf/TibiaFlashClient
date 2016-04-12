package tibia.input.gameaction
{
    import mx.events.*;
    import mx.resources.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.widgetClasses.*;
    import tibia.options.*;

    public class BuddylistActionImpl extends Object implements IActionImpl
    {
        private var m_TargetID:int = -1;
        private var m_Type:int = -1;
        private var m_TargetName:String = null;
        private static const BUNDLE:String = "BuddylistWidget";
        public static const ADD_BY_NAME:int = 0;
        public static const REMOVE:int = 2;
        public static const ADD_ASK_NAME:int = 1;

        public function BuddylistActionImpl(param1:int, param2)
        {
            if (param1 == ADD_BY_NAME && param2 is String)
            {
                this.m_Type = ADD_BY_NAME;
                this.m_TargetID = -1;
                this.m_TargetName = String(param2);
            }
            else if (param1 == ADD_ASK_NAME)
            {
                this.m_Type = ADD_ASK_NAME;
                this.m_TargetID = -1;
                this.m_TargetName = null;
            }
            else if (param1 == REMOVE && param2 is int)
            {
                this.m_Type = REMOVE;
                this.m_TargetID = int(param2);
                this.m_TargetName = null;
            }
            else
            {
                throw new ArgumentError("BuddylistActionImpl.BuddylistActionImpl: Invalid parameters: " + param1 + ", " + param2 + ".");
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_5:* = _loc_2.getBuddySet(BuddySet.DEFAULT_SET);
            _loc_3 = _loc_2.getBuddySet(BuddySet.DEFAULT_SET);
            if (_loc_2 != null && _loc_5 != null)
            {
                switch(this.m_Type)
                {
                    case ADD_ASK_NAME:
                    {
                        _loc_4 = new AskPlayerNameWidget();
                        _loc_4.prompt = ResourceManager.getInstance().getString(BUNDLE, "ASK_NAME_PROMPT");
                        _loc_4.title = ResourceManager.getInstance().getString(BUNDLE, "ASK_NAME_TITLE");
                        _loc_4.addEventListener(CloseEvent.CLOSE, this.onWidgetClose);
                        _loc_4.show();
                        break;
                    }
                    case ADD_BY_NAME:
                    {
                        _loc_3.addBuddy(this.m_TargetName, true);
                        break;
                    }
                    case REMOVE:
                    {
                        _loc_3.removeBuddy(this.m_TargetID, true);
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

        protected function onWidgetClose(event:CloseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as AskPlayerNameWidget;
            _loc_2 = event.currentTarget as AskPlayerNameWidget;
            if (event != null && event.detail == PopUpBase.BUTTON_OKAY && _loc_3 != null && _loc_2.playerName != null && _loc_2.playerName.length > 0)
            {
                new BuddylistActionImpl(BuddylistActionImpl.ADD_BY_NAME, _loc_2.playerName).perform();
            }
            return;
        }// end function

        public static function s_IsBuddy(param1) : Boolean
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = _loc_2.getBuddySet(BuddySet.DEFAULT_SET);
            _loc_3 = _loc_2.getBuddySet(BuddySet.DEFAULT_SET);
            return _loc_2 != null && _loc_4 != null && _loc_3.getBuddy(param1) != null;
        }// end function

    }
}

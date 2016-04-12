package tibia.sessiondump.hints
{
    import tibia.sessiondump.*;
    import tibia.sessiondump.controller.*;
    import tibia.tutorial.*;

    public class SessiondumpHintTutorialProgress extends SessiondumpHintBase
    {
        private var m_TutorialProgressIdentifier:String = null;
        private static var FIELD_TEXTHINT:String = "texthint";
        private static var FIELD_COORDINATE:String = "coordinate";
        private static var FIELD_SESSIONDUMP:String = "sessiondump";
        private static var FIELD_DESTINATION_COORDINATE:String = "destination";
        private static var FIELD_CONDITIONDATA:String = "conditiondata";
        private static var FIELD_CHANNEL:String = "channel";
        private static var FIELD_TYPE:String = "type";
        private static var FIELD_CONDITIONTYPE:String = "conditiontype";
        private static var FIELD_USE_TYPE_ID:String = "usetypeid";
        private static var FIELD_PLAYER_OUTFIT_COLOR_TORSO:String = "color-torso";
        private static var FIELD_OBJECTTYPE:String = "objecttype";
        private static var CONDITION_TYPE_CLICK_CREATURE:String = "CLICK_CREATURE";
        private static var FIELD_OFFSET:String = "offset";
        private static var FIELD_OBJECTTYPEID:String = "objecttypeid";
        private static var FIELD_POSITION:String = "position";
        private static var FIELD_TARGET:String = "target";
        private static var FIELD_PLAYER_OUTFIT:String = "player-outfit";
        private static var FIELD_UIELEMENT:String = "uielement";
        private static var FIELD_PLAYER_OUTFIT_COLOR_DETAIL:String = "color-detail";
        private static var FIELD_MULTIUSE_TARGET:String = "multiusetarget";
        private static var FIELD_CHANNEL_ID:String = "channelid";
        private static var FIELD_CREATURE_ID:String = "creatureid";
        private static var CONDITION_TYPE_DRAG_DROP:String = "DRAG_DROP";
        private static var FIELD_MULTIUSE_OBJECT_POSITION:String = "multiuseobjectposition";
        private static var FIELD_PLAYER_NAME:String = "player-name";
        private static var FIELD_PLAYER_OUTFIT_ID:String = "id";
        private static var FIELD_PLAYER_OUTFIT_COLOR_LEGS:String = "color-legs";
        private static var FIELD_SKIP_TO_TIMESTAMP:String = "skiptotimestamp";
        private static var FIELD_MULTIUSE_OBJECT_ID:String = "multiuseobjectid";
        private static var FIELD_TUTORIAL_PROGRESS:String = "tutorialprogress";
        private static var FIELD_TIMESTAMP:String = "timestamp";
        public static const TYPE:String = "TUTORIAL_PROGRESS";
        private static var FIELD_USEDESTINATIONPOSITION:String = "usedestinationposition";
        private static var FIELD_PLAYER_OUTFIT_ADDONS:String = "add-ons";
        private static var FIELD_AMOUNT:String = "amount";
        private static var FIELD_OBJECTID:String = "objectid";
        private static var FIELD_CREATURE_NAME:String = "creaturename";
        private static var CONDITION_TYPE_CLICK:String = "CLICK";
        private static var FIELD_OBJECTDATA:String = "objectdata";
        private static var FIELD_TEXT:String = "text";
        private static var FIELD_OBJECTINDEX:String = "objectindex";
        private static var FIELD_SOURCE_COORDINATE:String = "source";
        private static var FIELD_PLAYER_OUTFIT_COLOR_HEAD:String = "color-head";

        public function SessiondumpHintTutorialProgress()
        {
            m_Type = TYPE;
            return;
        }// end function

        override public function perform() : void
        {
            super.perform();
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = Tibia.s_GetConnection() as Sessiondump;
            _loc_2 = Tibia.s_GetConnection() as Sessiondump;
            var _loc_4:* = _loc_2.sessiondumpController as SessiondumpControllerHints;
            _loc_3 = _loc_2.sessiondumpController as SessiondumpControllerHints;
            if (_loc_4 != null && _loc_4 != null)
            {
                _loc_1 = _loc_3.tutorialProgressServiceAsset;
            }
            _loc_1.sendProgress(this.m_TutorialProgressIdentifier, Tibia.s_GetPlayer().name, Tibia.s_GetSessionKey());
            return;
        }// end function

        public static function s_Unmarshall(param1:Object) : SessiondumpHintBase
        {
            var _loc_2:* = new SessiondumpHintTutorialProgress;
            if (FIELD_TUTORIAL_PROGRESS in param1)
            {
                _loc_2.m_TutorialProgressIdentifier = String(param1[FIELD_TUTORIAL_PROGRESS]);
            }
            return _loc_2;
        }// end function

    }
}

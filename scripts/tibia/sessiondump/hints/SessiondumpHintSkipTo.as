﻿package tibia.sessiondump.hints
{
    import tibia.chat.*;
    import tibia.sessiondump.*;
    import tibia.sessiondump.controller.*;
    import tibia.worldmap.*;

    public class SessiondumpHintSkipTo extends SessiondumpHintBase
    {
        private var m_SkipToTimestamp:uint = 0;
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
        public static const TYPE:String = "SKIP_TO";
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

        public function SessiondumpHintSkipTo()
        {
            m_Type = TYPE;
            return;
        }// end function

        override public function perform() : void
        {
            var _SessiondumpController:SessiondumpControllerHints;
            super.perform();
            var _WorldMapStorage:* = Tibia.s_GetWorldMapStorage();
            var _ChatStorage:* = Tibia.s_GetChatStorage();
            try
            {
                _SessiondumpController = (Tibia.s_GetConnection() as Sessiondump).sessiondumpController as SessiondumpControllerHints;
                _SessiondumpController.setTargetTimestamp(this.m_SkipToTimestamp, 0);
                logSessiondump("Skip from: " + _SessiondumpController.currentSessiondumpEstimatedTimestamp + " to: " + this.m_SkipToTimestamp);
                m_Processed = true;
            }
            catch (e:Error)
            {
                throw new Error("SessiondumpHintSkipTo.perform: Failed to skip to target timestamp");
            }
            return;
        }// end function

        public static function s_Unmarshall(param1:Object) : SessiondumpHintBase
        {
            var _loc_2:* = new SessiondumpHintSkipTo;
            if (FIELD_SKIP_TO_TIMESTAMP in param1)
            {
                _loc_2.m_SkipToTimestamp = uint(param1[FIELD_SKIP_TO_TIMESTAMP]);
            }
            return _loc_2;
        }// end function

    }
}

package tibia.sessiondump.hints
{
    import __AS3__.vec.*;
    import tibia.appearances.*;

    public class SessiondumpHints extends Object
    {
        private var m_PlayerOutfit:OutfitInstance = null;
        private var m_Hints:Vector.<SessiondumpHintBase>;
        private var m_SessiondumpDuration:uint = 0;
        private var m_PlayerName:String = null;
        private var m_SessiondumpFilename:String = null;
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

        public function SessiondumpHints()
        {
            this.m_Hints = new Vector.<SessiondumpHintBase>;
            return;
        }// end function

        public function get playerOutfit() : OutfitInstance
        {
            return this.m_PlayerOutfit;
        }// end function

        public function get sessiondumpDuration() : uint
        {
            return this.m_SessiondumpDuration;
        }// end function

        public function get playerName() : String
        {
            return this.m_PlayerName;
        }// end function

        public function getNextSessiondumpHintToProcess(param1:uint) : SessiondumpHintBase
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.m_Hints)
            {
                
                if (_loc_2.processed == false && _loc_2.timestamp <= param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.m_Hints)
            {
                
                _loc_1.reset();
            }
            return;
        }// end function

        public function get hints() : Vector.<SessiondumpHintBase>
        {
            return this.m_Hints;
        }// end function

        public static function s_Unmarshall(param1:Object) : SessiondumpHints
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (param1 == null)
            {
                throw new Error("SessiondumpHints.s_Unmarshall: Invalid input.");
            }
            var _loc_2:* = new SessiondumpHints;
            _loc_2.m_SessiondumpDuration = param1["sessiondump-duration"] as uint;
            var _loc_3:* = Tibia.s_TutorialData;
            if (_loc_3 != null)
            {
                if (FIELD_PLAYER_NAME in _loc_3)
                {
                    _loc_2.m_PlayerName = _loc_3[FIELD_PLAYER_NAME] as String;
                }
                if (FIELD_PLAYER_OUTFIT in _loc_3)
                {
                    _loc_7 = _loc_3[FIELD_PLAYER_OUTFIT] as Object;
                    if (FIELD_PLAYER_OUTFIT_ID in _loc_7 && FIELD_PLAYER_OUTFIT_COLOR_HEAD in _loc_7 && FIELD_PLAYER_OUTFIT_COLOR_LEGS in _loc_7 && FIELD_PLAYER_OUTFIT_COLOR_TORSO in _loc_7 && FIELD_PLAYER_OUTFIT_COLOR_DETAIL in _loc_7 && FIELD_PLAYER_OUTFIT_ADDONS in _loc_7)
                    {
                        _loc_2.m_PlayerOutfit = Tibia.s_GetAppearanceStorage().createOutfitInstance(_loc_7[FIELD_PLAYER_OUTFIT_ID], _loc_7[FIELD_PLAYER_OUTFIT_COLOR_HEAD], _loc_7[FIELD_PLAYER_OUTFIT_COLOR_TORSO], _loc_7[FIELD_PLAYER_OUTFIT_COLOR_LEGS], _loc_7[FIELD_PLAYER_OUTFIT_COLOR_DETAIL], _loc_7[FIELD_PLAYER_OUTFIT_ADDONS]);
                    }
                    else
                    {
                        throw new ArgumentError("SessiondumpHints.s_Unmarshall: Invalid outfit data for player");
                    }
                }
            }
            var _loc_4:* = param1["actions"] as Object;
            var _loc_5:* = null;
            var _loc_6:* = new Array();
            for (_loc_5 in _loc_4)
            {
                
                _loc_6.push(Object({timestamp:_loc_5 as uint, actions:_loc_4[_loc_5] as Array}));
            }
            _loc_6.sortOn("timestamp", Array.NUMERIC);
            for each (_loc_5 in _loc_6)
            {
                
                _loc_8 = _loc_5["timestamp"] as uint;
                _loc_9 = _loc_5["actions"] as Array;
                for each (_loc_10 in _loc_9)
                {
                    
                    _loc_11 = SessiondumpHintBase.s_Unmarshall(uint(_loc_8), _loc_10);
                    if (_loc_11 != null)
                    {
                        _loc_2.m_Hints.push(_loc_11);
                    }
                }
            }
            if (FIELD_SESSIONDUMP in param1)
            {
                _loc_2.m_SessiondumpFilename = param1[FIELD_SESSIONDUMP];
            }
            return _loc_2;
        }// end function

    }
}

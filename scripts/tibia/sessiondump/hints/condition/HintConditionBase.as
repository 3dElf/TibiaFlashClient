package tibia.sessiondump.hints.condition
{
    import avmplus.*;
    import shared.utility.*;

    public class HintConditionBase extends Object
    {
        protected var m_HintText:String = null;
        protected var m_HintTextUseDestinationPosition:Boolean = false;
        protected var m_HintTextOffset:Vector3D = null;
        protected var m_Type:String = null;
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

        public function HintConditionBase()
        {
            return;
        }// end function

        public function get hintTextUseDestinationPosition() : Boolean
        {
            return this.m_HintTextUseDestinationPosition;
        }// end function

        public function get hintTextOffset() : Vector3D
        {
            return this.m_HintTextOffset;
        }// end function

        public function toString() : String
        {
            return getQualifiedClassName(this);
        }// end function

        public function get hintText() : String
        {
            return this.m_HintText;
        }// end function

        public static function s_Unmarshall(param1:Object) : HintConditionBase
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = null;
            switch(_loc_3)
            {
                case HintConditionAutowalk.TYPE:
                {
                    break;
                }
                case HintConditionMove.TYPE:
                {
                    break;
                }
                case HintConditionAttack.TYPE:
                {
                    break;
                }
                case HintConditionGreet.TYPE:
                {
                    break;
                }
                case HintConditionTalk.TYPE:
                {
                    break;
                }
                case HintConditionUse.TYPE:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (FIELD_TEXTHINT in _loc_4)
            {
                _loc_5 = _loc_4[FIELD_TEXTHINT] as Object;
                if (_loc_5 != null && FIELD_TEXT in _loc_5 && FIELD_OFFSET in _loc_5)
                {
                    if (FIELD_USEDESTINATIONPOSITION in _loc_5)
                    {
                        _loc_2.m_HintTextUseDestinationPosition = _loc_5[FIELD_USEDESTINATIONPOSITION] as Boolean;
                    }
                    _loc_2.m_HintTextOffset = HintConditionBase.s_UnmarshallCoordinate(_loc_5[FIELD_OFFSET]);
                    _loc_2.m_HintText = _loc_5[FIELD_TEXT] as String;
                }
                else
                {
                    throw new ArgumentError("HintConditionBase.s_Unmarshall: Invalid text hint data");
                }
            }
            return _loc_2;
        }// end function

        public static function s_UnmarshallCoordinate(param1:Object) : Vector3D
        {
            var _loc_2:* = 0;
            if (param1 == null || "x" in param1 == false || "y" in param1 == false)
            {
                throw new ArgumentError("SessiondumpHintBase.s_UnmarshallCoordinate: Invalid coordinate object");
            }
            _loc_2 = 0;
            if ("z" in param1)
            {
                _loc_2 = param1["z"];
            }
            return new Vector3D(param1["x"], param1["y"], _loc_2);
        }// end function

    }
}

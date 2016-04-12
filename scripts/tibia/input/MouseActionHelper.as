package tibia.input
{
    import __AS3__.vec.*;
    import tibia.appearances.*;
    import tibia.creatures.*;
    import tibia.cursors.*;

    public class MouseActionHelper extends Object
    {
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        private static const ACTION_SMARTCLICK:int = 100;
        static const NUM_EFFECTS:int = 200;
        private static const ACTION_LOOK:int = 6;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        private static const ACTION_TALK:int = 9;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_NONE:int = 0;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        private static const ACTION_OPEN:int = 8;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        static const FIELD_CACHESIZE:int = 32;
        private static const ACTION_UNSET:int = -1;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        static const FIELD_HEIGHT:int = 24;
        private static const ACTION_USE_OR_OPEN:int = 101;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const MAP_MIN_Y:int = 24576;
        static const PLAYER_OFFSET_X:int = 8;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        private static const ACTION_USE:int = 7;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static const ACTION_AUTOWALK:int = 3;
        static const MAP_WIDTH:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_CONTEXT_MENU:int = 5;
        static const GROUND_LAYER:int = 7;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);

        public function MouseActionHelper()
        {
            return;
        }// end function

        public static function resolveActionForAppearanceOrCreature(param1:uint, param2, param3:Vector.<uint>) : uint
        {
            var _loc_4:* = param1;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param2 == null)
            {
                return param1;
            }
            if (param2 is AppearanceInstance)
            {
                _loc_6 = param2 as AppearanceInstance;
                if (_loc_6.type.isCreature && _loc_6 is ObjectInstance)
                {
                    _loc_5 = Tibia.s_GetCreatureStorage().getCreature((_loc_6 as ObjectInstance).data);
                }
            }
            else if (param2 is Creature)
            {
                _loc_5 = param2 as Creature;
            }
            else
            {
                throw new ArgumentError("MouseActionHelper.resolveActionForAppearanceOrCreature: a_ApperanceOrCreature must be AppearanceInstance or Creature");
            }
            if (_loc_4 == ACTION_SMARTCLICK)
            {
                if (_loc_5 == Tibia.s_GetPlayer())
                {
                    _loc_4 = ACTION_LOOK;
                }
                else if (_loc_6 != null && _loc_6.type.isDefaultAction)
                {
                    if (_loc_6.type.defaultAction != ACTION_NONE)
                    {
                        _loc_4 = _loc_6.type.defaultAction;
                    }
                    else
                    {
                        _loc_4 = ACTION_LOOK;
                    }
                }
                else if (_loc_6 != null && _loc_6.type.isCreature || _loc_5 != null)
                {
                    _loc_4 = ACTION_ATTACK_OR_TALK;
                }
                else if (_loc_6 != null && _loc_6.type.isUsable)
                {
                    _loc_4 = ACTION_USE_OR_OPEN;
                }
                else
                {
                    _loc_4 = ACTION_LOOK;
                }
            }
            if (_loc_4 == ACTION_USE_OR_OPEN)
            {
                _loc_4 = ACTION_USE;
                if (_loc_6 != null && _loc_6.type.isContainer)
                {
                    _loc_4 = ACTION_OPEN;
                }
            }
            if (_loc_4 == ACTION_ATTACK_OR_TALK)
            {
                _loc_4 = ACTION_ATTACK;
                if (_loc_5 != null && _loc_5.isNPC)
                {
                    _loc_4 = ACTION_TALK;
                }
            }
            if (_loc_4 == ACTION_AUTOWALK && _loc_6 != null && _loc_6.type.defaultAction == ACTION_AUTOWALK_HIGHLIGHT)
            {
                _loc_4 = ACTION_AUTOWALK_HIGHLIGHT;
            }
            if (param3 != null && param3.indexOf(_loc_4) == -1)
            {
                _loc_4 = ACTION_NONE;
            }
            return _loc_4;
        }// end function

        public static function actionToMouseCursor(param1:int) : Class
        {
            var _loc_2:* = DefaultCursor;
            switch(param1)
            {
                case ACTION_LOOK:
                {
                    _loc_2 = LookCursor;
                    break;
                }
                case ACTION_USE:
                {
                    _loc_2 = UseCursor;
                    break;
                }
                case ACTION_ATTACK:
                {
                    _loc_2 = AttackCursor;
                    break;
                }
                case ACTION_AUTOWALK:
                case ACTION_AUTOWALK_HIGHLIGHT:
                {
                    _loc_2 = WalkCursor;
                    break;
                }
                case ACTION_OPEN:
                {
                    _loc_2 = OpenCursor;
                    break;
                }
                case ACTION_TALK:
                {
                    _loc_2 = TalkCursor;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}

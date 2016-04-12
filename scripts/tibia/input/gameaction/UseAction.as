package tibia.input.gameaction
{
    import mx.resources.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.magic.*;
    import tibia.network.*;

    public class UseAction extends Object implements IAction
    {
        private var m_LastPerform:Number = 0;
        private var m_Target:int = -1;
        private var m_Type:AppearanceType = null;
        private var m_Data:int = -1;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        private static const BUNDLE:String = "StaticAction";
        public static const TARGET_SELF:int = 2;
        public static const TARGET_CROSSHAIR:int = 4;
        public static const TARGET_ATTACK:int = 3;

        public function UseAction(param1, param2:int, param3:int)
        {
            var _loc_4:* = null;
            this.m_Type = null;
            if (param1 is ObjectInstance)
            {
                this.m_Type = ObjectInstance(param1).type;
            }
            else if (param1 is AppearanceType)
            {
                this.m_Type = AppearanceType(param1);
            }
            else if (param1 is int)
            {
                _loc_4 = Tibia.s_GetAppearanceStorage();
                if (_loc_4 != null)
                {
                    this.m_Type = _loc_4.getObjectType(int(param1));
                }
            }
            if (this.m_Type == null)
            {
                throw new ArgumentError("UseAction.UseAction: Invalid type: " + param1);
            }
            this.m_Data = param2;
            if (param3 != TARGET_ATTACK && param3 != TARGET_CROSSHAIR && param3 != TARGET_SELF)
            {
                throw new ArgumentError("UseAction.UseAction: Invalid target: " + param3);
            }
            this.m_Target = param3;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = Tibia.s_GetConnection();
            var _loc_3:* = Tibia.s_GetContainerStorage();
            var _loc_4:* = Tibia.s_GetSpellStorage();
            if (param1 && _loc_2 != null && _loc_3 != null && _loc_4 != null)
            {
                if (this.m_Type.isMultiUse)
                {
                    if (this.m_LastPerform + ContainerStorage.MIN_MULTI_USE_DELAY / 2 > Tibia.s_FrameTibiaTimestamp)
                    {
                        return;
                    }
                    _loc_5 = Delay.merge(_loc_3.getMultiUseDelay(), _loc_4.getRuneDelay(this.m_Type.ID));
                    if (_loc_5 != null && _loc_5.end - _loc_2.latency > Tibia.s_FrameTibiaTimestamp)
                    {
                        return;
                    }
                }
                else if (this.m_LastPerform + ContainerStorage.MIN_USE_DELAY > Tibia.s_FrameTibiaTimestamp)
                {
                    return;
                }
            }
            Tibia.s_GameActionFactory.createUseAction(ContainerStorage.INVENTORY_ANY, this.m_Type, this.m_Data, this.m_Target).perform(param1);
            this.m_LastPerform = Tibia.s_FrameTibiaTimestamp;
            return;
        }// end function

        public function get target() : int
        {
            return this.m_Target;
        }// end function

        public function marshall() : XML
        {
            return new XML("<action type=\"use\" object=\"" + this.m_Type.ID + "\" data=\"" + this.m_Data + "\" target=\"" + this.m_Target + "\"/>");
        }// end function

        public function get data() : int
        {
            return this.m_Data;
        }// end function

        public function equals(param1:IAction) : Boolean
        {
            return param1 is UseAction && UseAction(param1).m_Data == this.m_Data && UseAction(param1).m_Target == this.m_Target && UseAction(param1).m_Type == this.m_Type;
        }// end function

        public function get hidden() : Boolean
        {
            return true;
        }// end function

        public function get type() : AppearanceType
        {
            return this.m_Type;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = Tibia.s_GetAppearanceStorage();
            var _loc_2:* = ResourceManager.getInstance();
            var _loc_3:* = null;
            switch(this.m_Target)
            {
                case TARGET_SELF:
                {
                    _loc_3 = "GAME_USE_TARGET_SELF";
                    break;
                }
                case TARGET_ATTACK:
                {
                    _loc_3 = "GAME_USE_TARGET_ATTACK";
                    break;
                }
                case TARGET_CROSSHAIR:
                {
                    _loc_3 = "GAME_USE_TARGET_CROSSHAIR";
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_4:* = null;
            var _loc_5:* = _loc_1.getCachedObjectTypeName(this.m_Type.ID, this.m_Data);
            _loc_4 = _loc_1.getCachedObjectTypeName(this.m_Type.ID, this.m_Data);
            if (_loc_1 == null || _loc_5 == null)
            {
                _loc_4 = _loc_2.getString(BUNDLE, "GAME_USE_GENERIC_OBJECT");
            }
            return _loc_2.getString(BUNDLE, _loc_3, [_loc_4]);
        }// end function

        public function clone() : IAction
        {
            return new UseAction(this.m_Type, this.m_Data, this.m_Target);
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : UseAction
        {
            if (param1 == null || param1.localName() != "action" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("UseAction.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_8:* = param1.@type;
            _loc_3 = param1.@type;
            if (_loc_8 == null || _loc_3.length() != 1 || _loc_3[0].toString() != "use")
            {
                return null;
            }
            var _loc_4:* = -1;
            var _loc_8:* = param1.@object;
            _loc_3 = param1.@object;
            if (_loc_8 != null && _loc_3.length() == 1)
            {
                _loc_4 = parseInt(_loc_3[0].toString());
            }
            var _loc_5:* = -1;
            var _loc_8:* = param1.@data;
            _loc_3 = param1.@data;
            if (_loc_8 != null && _loc_3.length() == 1)
            {
                _loc_5 = parseInt(_loc_3[0].toString());
            }
            var _loc_6:* = -1;
            var _loc_8:* = param1.@target;
            _loc_3 = param1.@target;
            if (_loc_8 != null && _loc_3.length() == 1)
            {
                _loc_6 = parseInt(_loc_3[0].toString());
            }
            var _loc_7:* = Tibia.s_GetAppearanceStorage();
            if (_loc_7.getObjectType(_loc_4) != null && (_loc_6 == UseAction.TARGET_SELF || _loc_6 == UseAction.TARGET_ATTACK || _loc_6 == UseAction.TARGET_CROSSHAIR))
            {
                return new UseAction(_loc_4, _loc_5, _loc_6);
            }
            return null;
        }// end function

    }
}

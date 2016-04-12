package tibia.input.gameaction
{
    import mx.resources.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.input.*;
    import tibia.network.*;

    public class EquipAction extends Object implements IAction
    {
        private var m_Target:int = -1;
        private var m_Type:AppearanceType = null;
        private var m_Data:int = -1;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        private static const BUNDLE:String = "StaticAction";
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        public static const TARGET_AUTO:int = 5;

        public function EquipAction(param1, param2:int, param3:int)
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
            if (this.m_Type == null || !this.m_Type.isCloth)
            {
                throw new ArgumentError("EquipAction.EquipAction: Invalid type: " + param1);
            }
            this.m_Data = param2;
            if (param3 != TARGET_AUTO)
            {
                throw new ArgumentError("EquipAction.EquipAction: Invalid target: " + param3);
            }
            if (this.m_Type.clothSlot == 0)
            {
                this.m_Target = BodyContainerView.LEFT_HAND;
            }
            else
            {
                this.m_Target = this.m_Type.clothSlot;
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetContainerStorage();
            if (_loc_2 != null && _loc_2.isGameRunning && _loc_3 != null && _loc_3.getAvailableInventory(this.m_Type.ID, this.m_Data) > 0 && !param1)
            {
                _loc_2.sendCEQUIPOBJECT(this.m_Type.ID, this.m_Data);
            }
            return;
        }// end function

        public function get data() : int
        {
            return this.m_Data;
        }// end function

        public function marshall() : XML
        {
            return new XML("<action type=\"equip\" object=\"" + this.m_Type.ID + "\" data=\"" + this.m_Data + "\"/>");
        }// end function

        public function equals(param1:IAction) : Boolean
        {
            return param1 is EquipAction && EquipAction(param1).m_Data == this.m_Data && EquipAction(param1).m_Target == this.m_Target && EquipAction(param1).m_Type == this.m_Type;
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
            var _loc_1:* = ResourceManager.getInstance();
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_7:* = Tibia.s_GetContainerStorage();
            _loc_2 = Tibia.s_GetContainerStorage();
            var _loc_7:* = _loc_2.getBodyContainerView();
            _loc_3 = _loc_2.getBodyContainerView();
            if (_loc_7 != null && _loc_7 != null && _loc_3.isEquipped(this.m_Type.ID))
            {
                _loc_4 = "GAME_EQUIP_UNEQUIP";
            }
            else
            {
                _loc_4 = "GAME_EQUIP_EQUIP";
            }
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = Tibia.s_GetAppearanceStorage();
            _loc_5 = Tibia.s_GetAppearanceStorage();
            var _loc_7:* = _loc_5.getCachedObjectTypeName(this.m_Type.ID, this.m_Data);
            _loc_6 = _loc_5.getCachedObjectTypeName(this.m_Type.ID, this.m_Data);
            if (_loc_7 == null || _loc_7 == null)
            {
                _loc_6 = _loc_1.getString(BUNDLE, "GAME_EQUIP_GENERIC_OBJECT");
            }
            return _loc_1.getString(BUNDLE, _loc_4, [_loc_6]);
        }// end function

        public function clone() : IAction
        {
            return new EquipAction(this.m_Type, this.m_Data, this.m_Target);
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : EquipAction
        {
            if (param1 == null || param1.localName() != "action" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("EquipAction.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_7:* = param1.@type;
            _loc_3 = param1.@type;
            if (_loc_7 == null || _loc_3.length() != 1 || _loc_3[0].toString() != "equip")
            {
                return null;
            }
            var _loc_4:* = -1;
            var _loc_7:* = param1.@object;
            _loc_3 = param1.@object;
            if (_loc_7 != null && _loc_3.length() == 1)
            {
                _loc_4 = parseInt(_loc_3[0].toString());
            }
            var _loc_5:* = 0;
            var _loc_7:* = param1.@data;
            _loc_3 = param1.@data;
            if (_loc_7 != null && _loc_3.length() == 1)
            {
                _loc_5 = parseInt(_loc_3[0].toString());
            }
            var _loc_6:* = Tibia.s_GetAppearanceStorage();
            if (_loc_6.getObjectType(_loc_4) != null)
            {
                return new EquipAction(_loc_4, _loc_5, TARGET_AUTO);
            }
            return null;
        }// end function

    }
}

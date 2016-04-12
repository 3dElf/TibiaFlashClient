package tibia.input.staticaction
{
    import tibia.network.*;
    import tibia.options.*;

    public class CombatPVPMode extends StaticAction
    {
        private var m_PVPMode:uint = 0;

        public function CombatPVPMode(param1:int, param2:String, param3:uint, param4:uint)
        {
            super(param1, param2, param3, false);
            if (param4 != OptionsStorage.COMBAT_PVP_MODE_DOVE && param4 != OptionsStorage.COMBAT_PVP_MODE_WHITE_HAND && param4 != OptionsStorage.COMBAT_PVP_MODE_YELLOW_HAND && param4 != OptionsStorage.COMBAT_PVP_MODE_RED_FIST)
            {
                throw new ArgumentError("CombatPVPMode.CombatPVPMode: Invalid pvp mode: " + param4 + ".");
            }
            this.m_PVPMode = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                _loc_2.combatPVPMode = this.m_PVPMode;
            }
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCSETTACTICS(_loc_2.combatAttackMode, _loc_2.combatChaseMode, _loc_2.combatSecureMode, _loc_2.combatPVPMode);
            }
            return;
        }// end function

    }
}

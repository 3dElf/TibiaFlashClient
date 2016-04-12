package tibia.input.staticaction
{
    import tibia.network.*;
    import tibia.options.*;

    public class CombatSecureMode extends StaticAction
    {

        public function CombatSecureMode(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                if (_loc_2.combatSecureMode == OptionsStorage.COMBAT_SECURE_OFF)
                {
                    _loc_2.combatSecureMode = OptionsStorage.COMBAT_SECURE_ON;
                }
                else
                {
                    _loc_2.combatSecureMode = OptionsStorage.COMBAT_SECURE_OFF;
                }
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

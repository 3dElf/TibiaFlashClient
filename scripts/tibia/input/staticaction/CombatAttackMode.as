package tibia.input.staticaction
{
    import tibia.network.*;
    import tibia.options.*;

    public class CombatAttackMode extends StaticAction
    {
        private var m_AttackMode:int;

        public function CombatAttackMode(param1:int, param2:String, param3:uint, param4:int)
        {
            this.m_AttackMode = OptionsStorage.COMBAT_ATTACK_BALANCED;
            super(param1, param2, param3, false);
            if (param4 != OptionsStorage.COMBAT_ATTACK_BALANCED && param4 != OptionsStorage.COMBAT_ATTACK_DEFENSIVE && param4 != OptionsStorage.COMBAT_ATTACK_OFFENSIVE)
            {
                throw new ArgumentError("CombatAttackMode.CombatAttackMode: Invalid attack mode: " + param4 + ".");
            }
            this.m_AttackMode = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                _loc_2.combatAttackMode = this.m_AttackMode;
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

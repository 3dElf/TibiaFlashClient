package tibia.sessiondump.hints.gameaction
{
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.input.gameaction.*;
    import tibia.sessiondump.controller.*;
    import tibia.sessiondump.hints.condition.*;

    public class SessiondumpHintsToggleAttackTargetActionImpl extends ToggleAttackTargetActionImpl
    {

        public function SessiondumpHintsToggleAttackTargetActionImpl(param1:Creature, param2:Boolean)
        {
            super(param1, param2);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            Tibia.s_GetCreatureStorage().toggleAttackTarget(m_Creature, false);
            SessiondumpHintActionsController.getInstance().actionPerformed(this);
            return;
        }// end function

        public function get creature() : Creature
        {
            return m_Creature;
        }// end function

        public function meetsCondition(param1:HintConditionAttack) : Boolean
        {
            return StringHelper.s_EqualsIgnoreCase(param1.creatureName, m_Creature.name);
        }// end function

    }
}

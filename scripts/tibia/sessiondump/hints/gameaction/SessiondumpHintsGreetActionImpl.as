package tibia.sessiondump.hints.gameaction
{
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.input.gameaction.*;
    import tibia.sessiondump.controller.*;
    import tibia.sessiondump.hints.condition.*;

    public class SessiondumpHintsGreetActionImpl extends GreetAction
    {

        public function SessiondumpHintsGreetActionImpl(param1:Creature)
        {
            super(param1);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            SessiondumpHintActionsController.getInstance().actionPerformed(this);
            return;
        }// end function

        public function meetsCondition(param1:HintConditionGreet) : Boolean
        {
            return StringHelper.s_EqualsIgnoreCase(param1.creatureName, m_NPC.name);
        }// end function

    }
}

package tibia.sessiondump.hints.gameaction
{
    import tibia.input.gameaction.*;
    import tibia.sessiondump.controller.*;
    import tibia.sessiondump.hints.condition.*;

    public class SessiondumpHintsAutowalkActionImpl extends AutowalkActionImpl
    {

        public function SessiondumpHintsAutowalkActionImpl(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean)
        {
            super(param1, param2, param3, param4, param5);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            SessiondumpHintActionsController.getInstance().actionPerformed(this);
            return;
        }// end function

        public function meetsCondition(param1:HintConditionAutowalk) : Boolean
        {
            return param1.mapCoordinate.equals(m_Destination);
        }// end function

    }
}

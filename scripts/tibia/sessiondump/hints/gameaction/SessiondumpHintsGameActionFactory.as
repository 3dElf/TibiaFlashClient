package tibia.sessiondump.hints.gameaction
{
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.creatures.*;
    import tibia.input.gameaction.*;

    public class SessiondumpHintsGameActionFactory extends GameActionFactory
    {

        public function SessiondumpHintsGameActionFactory()
        {
            return;
        }// end function

        override public function createUseAction(param1:Vector3D, param2, param3:int, param4:int = 0) : UseActionImpl
        {
            return new SessiondumpHintsUseActionImpl(param1, param2, param3, param4);
        }// end function

        override public function createGreetAction(param1:Creature) : GreetAction
        {
            return new SessiondumpHintsGreetActionImpl(param1);
        }// end function

        override public function createMoveAction(param1:Vector3D, param2:ObjectInstance, param3:int, param4:Vector3D, param5:int) : MoveActionImpl
        {
            return new SessiondumpHintsMoveActionImpl(param1, param2, param3, param4, param5);
        }// end function

        override public function createAutowalkAction(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : AutowalkActionImpl
        {
            return new SessiondumpHintsAutowalkActionImpl(param1, param2, param3, param4, param5);
        }// end function

        override public function createTalkAction(param1:String, param2:Boolean) : TalkActionImpl
        {
            return new SessiondumpHintsTalkActionImpl(param1, param2);
        }// end function

        override public function createToggleAttackTargetAction(param1:Creature, param2:Boolean) : ToggleAttackTargetActionImpl
        {
            return new SessiondumpHintsToggleAttackTargetActionImpl(param1, param2);
        }// end function

    }
}

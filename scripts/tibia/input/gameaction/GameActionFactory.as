package tibia.input.gameaction
{
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.creatures.*;

    public class GameActionFactory extends Object
    {

        public function GameActionFactory()
        {
            return;
        }// end function

        public function createUseAction(param1:Vector3D, param2, param3:int, param4:int = 0) : UseActionImpl
        {
            return new UseActionImpl(param1, param2, param3, param4);
        }// end function

        public function createGreetAction(param1:Creature) : GreetAction
        {
            return new GreetAction(param1);
        }// end function

        public function createMoveAction(param1:Vector3D, param2:ObjectInstance, param3:int, param4:Vector3D, param5:int) : MoveActionImpl
        {
            return new MoveActionImpl(param1, param2, param3, param4, param5);
        }// end function

        public function createAutowalkAction(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : AutowalkActionImpl
        {
            return new AutowalkActionImpl(param1, param2, param3, param4, param5);
        }// end function

        public function createTalkAction(param1:String, param2:Boolean) : TalkActionImpl
        {
            return new TalkActionImpl(param1, param2);
        }// end function

        public function createToggleAttackTargetAction(param1:Creature, param2:Boolean) : ToggleAttackTargetActionImpl
        {
            return new ToggleAttackTargetActionImpl(param1, param2);
        }// end function

    }
}

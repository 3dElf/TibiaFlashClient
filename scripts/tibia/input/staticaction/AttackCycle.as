package tibia.input.staticaction
{
    import tibia.creatures.*;

    public class AttackCycle extends StaticAction
    {
        protected var m_Direction:int = 1;
        public static const NEXT:int = 1;
        public static const PREV:int = -1;

        public function AttackCycle(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != NEXT && param4 != PREV)
            {
                throw new ArgumentError("AttackCycle.AttackCycle: Invalid direction: " + param4);
            }
            this.m_Direction = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCreatureStorage();
            if (_loc_2 != null)
            {
                _loc_2.setAttackTarget(_loc_2.getNextAttackTarget(this.m_Direction), true);
            }
            return;
        }// end function

    }
}

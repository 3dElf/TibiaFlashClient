package tibia.input.staticaction
{
    import tibia.network.*;

    public class PlayerTurn extends StaticAction
    {
        protected var m_Direction:int = -1;
        public static const SOUTH:int = 3;
        public static const NORTH:int = 1;
        public static const EAST:int = 0;
        public static const WEST:int = 2;

        public function PlayerTurn(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 < EAST || param4 > SOUTH)
            {
                throw new ArgumentError("PlayerTurn.PlayerTurn: Invalid direction: " + param4);
            }
            this.m_Direction = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                switch(this.m_Direction)
                {
                    case EAST:
                    {
                        _loc_2.sendCROTATEEAST();
                        break;
                    }
                    case NORTH:
                    {
                        _loc_2.sendCROTATENORTH();
                        break;
                    }
                    case WEST:
                    {
                        _loc_2.sendCROTATEWEST();
                        break;
                    }
                    case SOUTH:
                    {
                        _loc_2.sendCROTATESOUTH();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}

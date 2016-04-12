package tibia.input.staticaction
{
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.input.gameaction.*;
    import tibia.network.*;

    public class PlayerMove extends StaticAction
    {
        protected var m_DeltaX:int = 0;
        protected var m_DeltaY:int = 0;
        public static const SOUTH_WEST:int = 5;
        public static const STOP:int = 8;
        public static const NORTH:int = 2;
        public static const NORTH_WEST:int = 3;
        public static const SOUTH:int = 6;
        public static const WEST:int = 4;
        public static const SOUTH_EAST:int = 7;
        public static const NORTH_EAST:int = 1;
        public static const EAST:int = 0;

        public function PlayerMove(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            switch(param4)
            {
                case EAST:
                {
                    this.m_DeltaX = 1;
                    this.m_DeltaY = 0;
                    break;
                }
                case NORTH_EAST:
                {
                    this.m_DeltaX = 1;
                    this.m_DeltaY = -1;
                    break;
                }
                case NORTH:
                {
                    this.m_DeltaX = 0;
                    this.m_DeltaY = -1;
                    break;
                }
                case NORTH_WEST:
                {
                    this.m_DeltaX = -1;
                    this.m_DeltaY = -1;
                    break;
                }
                case WEST:
                {
                    this.m_DeltaX = -1;
                    this.m_DeltaY = 0;
                    break;
                }
                case SOUTH_WEST:
                {
                    this.m_DeltaX = -1;
                    this.m_DeltaY = 1;
                    break;
                }
                case SOUTH:
                {
                    this.m_DeltaX = 0;
                    this.m_DeltaY = 1;
                    break;
                }
                case SOUTH_EAST:
                {
                    this.m_DeltaX = 1;
                    this.m_DeltaY = 1;
                    break;
                }
                case STOP:
                {
                    this.m_DeltaX = 0;
                    this.m_DeltaY = 0;
                    break;
                }
                default:
                {
                    throw new ArgumentError("PlayerMove.PlayerMove: Invalid movement direction: " + param4 + ".");
                    break;
                }
            }
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetPlayer();
            if (_loc_2 != null && _loc_2.isGameRunning && _loc_3 != null)
            {
                if (this.m_DeltaX == 0 && this.m_DeltaY == 0)
                {
                    _loc_2.sendCSTOP();
                }
                else
                {
                    _loc_4 = _loc_3.anticipatedPosition;
                    _loc_5 = Math.abs(this.m_DeltaX) + Math.abs(this.m_DeltaY) > 1;
                    _loc_6 = Tibia.s_GameActionFactory.createAutowalkAction(_loc_4.x + this.m_DeltaX, _loc_4.y + this.m_DeltaY, _loc_4.z, _loc_5, true);
                    _loc_6.perform();
                }
            }
            return;
        }// end function

    }
}

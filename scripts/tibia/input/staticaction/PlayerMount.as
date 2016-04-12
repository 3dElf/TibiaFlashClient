package tibia.input.staticaction
{
    import tibia.creatures.*;
    import tibia.network.*;

    public class PlayerMount extends StaticAction
    {

        public function PlayerMount(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetPlayer();
            if (_loc_2 != null && _loc_2.isGameRunning && _loc_3 != null)
            {
                _loc_2.sendCMOUNT(_loc_3.mountOutfit == null);
            }
            return;
        }// end function

    }
}

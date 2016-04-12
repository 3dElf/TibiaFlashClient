package tibia.input.staticaction
{
    import tibia.creatures.*;
    import tibia.network.*;

    public class PlayerCancel extends StaticAction
    {

        public function PlayerCancel(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetCreatureStorage();
            var _loc_4:* = Tibia.s_GetPlayer();
            if (_loc_2 != null && _loc_2.isGameRunning && _loc_3 != null && _loc_4 != null)
            {
                _loc_4.stopAutowalk(false);
                _loc_3.setAttackTarget(null, false);
                _loc_2.sendCCANCEL();
            }
            return;
        }// end function

    }
}

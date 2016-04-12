package tibia.input.staticaction
{
    import tibia.worldmap.*;

    public class ExpireOnScreenMessage extends StaticAction
    {

        public function ExpireOnScreenMessage(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetWorldMapStorage();
            if (_loc_2 != null)
            {
                _loc_2.expireOldestMessage();
            }
            return;
        }// end function

    }
}

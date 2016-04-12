package tibia.input.staticaction
{

    public class AutofitGameWindow extends StaticAction
    {

        public function AutofitGameWindow(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetInstance();
            if (_loc_2 != null)
            {
                _loc_2.autofitGameWindow();
            }
            return;
        }// end function

    }
}

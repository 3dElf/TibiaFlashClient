package tibia.input.staticaction
{
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.input.gameaction.*;

    public class OpenRootContainer extends StaticAction
    {

        public function OpenRootContainer(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetContainerStorage();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.getBodyContainerView();
            _loc_3 = _loc_2.getBodyContainerView();
            var _loc_5:* = _loc_3.getObject(BodyContainerView.BACK);
            _loc_4 = _loc_3.getObject(BodyContainerView.BACK);
            if (_loc_2 != null && _loc_5 != null && _loc_5 != null && _loc_4.type != null && _loc_4.type.isContainer)
            {
                Tibia.s_GameActionFactory.createUseAction(new Vector3D(65535, BodyContainerView.BACK, 0), _loc_4, BodyContainerView.BACK, UseActionImpl.TARGET_NEW_WINDOW).perform();
            }
            return;
        }// end function

    }
}

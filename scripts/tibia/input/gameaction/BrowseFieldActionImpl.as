package tibia.input.gameaction
{
    import shared.utility.*;
    import tibia.input.*;
    import tibia.network.*;

    public class BrowseFieldActionImpl extends Object implements IActionImpl
    {
        private var m_Absolute:Vector3D = null;

        public function BrowseFieldActionImpl(param1:Vector3D)
        {
            if (param1 == null)
            {
                throw new ArgumentError("BrowseFieldActionImpl.BrowseFieldActionImpl: Invalid coordinate.");
            }
            this.m_Absolute = param1;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCBROWSEFIELD(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z);
            }
            return;
        }// end function

    }
}

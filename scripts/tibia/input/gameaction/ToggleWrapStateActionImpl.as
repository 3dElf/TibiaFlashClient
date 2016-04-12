package tibia.input.gameaction
{
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.input.*;
    import tibia.network.*;

    public class ToggleWrapStateActionImpl extends Object implements IActionImpl
    {
        protected var m_Absolute:Vector3D = null;
        protected var m_Position:int = -1;
        protected var m_Type:AppearanceType = null;

        public function ToggleWrapStateActionImpl(param1:Vector3D, param2:ObjectInstance, param3:int)
        {
            if (param1 == null)
            {
                throw new ArgumentError("ToggleWrapStateActionImpl.ToggleWrapStateActionImpl: Invalid co-ordinate.");
            }
            this.m_Absolute = param1;
            if (param2 == null || param2.type == null)
            {
                throw new ArgumentError("ToggleWrapStateActionImpl.ToggleWrapStateActionImpl: Invalid object.");
            }
            this.m_Type = param2.type;
            this.m_Position = param3;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCTOGGLEWRAPSTATE(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_Position);
            }
            return;
        }// end function

    }
}

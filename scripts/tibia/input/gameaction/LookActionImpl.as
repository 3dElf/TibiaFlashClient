package tibia.input.gameaction
{
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.input.*;
    import tibia.network.*;

    public class LookActionImpl extends Object implements IActionImpl
    {
        protected var m_Absolute:Vector3D = null;
        protected var m_Position:int = -1;
        protected var m_Type:AppearanceType = null;

        public function LookActionImpl(param1:Vector3D, param2, param3:int)
        {
            var _loc_4:* = null;
            if (param1 == null)
            {
                throw new ArgumentError("LookActionImpl.LookActionImpl: Invalid co-ordinate.");
            }
            this.m_Absolute = param1.clone();
            if (param2 is AppearanceInstance)
            {
                this.m_Type = AppearanceInstance(param2).type;
            }
            else if (param2 is AppearanceType)
            {
                this.m_Type = AppearanceType(param2);
            }
            else if (param2 is int)
            {
                _loc_4 = Tibia.s_GetAppearanceStorage();
                this.m_Type = _loc_4 != null ? (_loc_4.getObjectType(int(param2))) : (null);
            }
            if (this.m_Type == null)
            {
                throw new ArgumentError("LookActionImpl.LookActionImpl: Invalid object: " + param2 + ".");
            }
            this.m_Position = param3;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCLOOK(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_Position);
            }
            return;
        }// end function

    }
}

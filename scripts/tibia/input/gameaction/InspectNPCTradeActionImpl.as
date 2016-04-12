package tibia.input.gameaction
{
    import tibia.appearances.*;
    import tibia.input.*;
    import tibia.network.*;

    public class InspectNPCTradeActionImpl extends Object implements IActionImpl
    {
        protected var m_Object:AppearanceTypeRef = null;

        public function InspectNPCTradeActionImpl(param1:AppearanceTypeRef)
        {
            if (param1 == null)
            {
                throw new ArgumentError("InspectNPCTradeActionImpl.InspectNPCTradeActionImpl: Invalid obejct.");
            }
            this.m_Object = param1;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCINSPECTNPCTRADE(this.m_Object.ID, this.m_Object.data);
            }
            return;
        }// end function

    }
}

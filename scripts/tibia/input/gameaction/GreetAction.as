package tibia.input.gameaction
{
    import shared.utility.*;
    import tibia.chat.*;
    import tibia.creatures.*;
    import tibia.worldmap.*;

    public class GreetAction extends TalkActionImpl
    {
        protected var m_NPC:Creature = null;
        private static const GREET_TEXT:String = "Hi";

        public function GreetAction(param1:Creature)
        {
            super(GREET_TEXT, true, ChatStorage.LOCAL_CHANNEL_ID);
            if (param1 == null)
            {
                throw new ArgumentError("GreetAction.GreetAction: NPC must not be null.");
            }
            if (!param1.isNPC)
            {
                throw new ArgumentError("GreetAction.GreetAction: Creature is not an NPC.");
            }
            this.m_NPC = param1;
            return;
        }// end function

        private function get isNpcInReach() : Boolean
        {
            var _loc_1:* = Tibia.s_GetPlayer().position;
            var _loc_2:* = this.m_NPC.position;
            if (_loc_1.z == _loc_2.z && Math.abs(_loc_1.x - _loc_2.x) <= MessageStorage.MAX_NPC_DISTANCE && Math.abs(_loc_1.y - _loc_2.y) <= MessageStorage.MAX_NPC_DISTANCE)
            {
                return true;
            }
            return false;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            if (!this.isNpcInReach)
            {
                Tibia.s_GetWorldMapStorage().addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_NPC_TOO_FAR);
            }
            else
            {
                super.perform(param1);
            }
            return;
        }// end function

    }
}

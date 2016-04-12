package tibia.input.gameaction
{
    import tibia.creatures.*;
    import tibia.input.*;
    import tibia.network.*;

    public class PartyActionImpl extends Object implements IActionImpl
    {
        protected var m_Creature:Creature = null;
        protected var m_Type:int = -1;
        public static const ENABLE_SHARED_EXPERIENCE:int = 5;
        public static const INVITE:int = 2;
        public static const JOIN:int = 0;
        public static const DISABLE_SHARED_EXPERIENCE:int = 6;
        public static const PASS_LEADERSHIP:int = 4;
        public static const LEAVE:int = 1;
        public static const JOIN_AGGRESSION:int = 7;
        public static const EXCLUDE:int = 3;

        public function PartyActionImpl(param1:int, param2:Creature)
        {
            if (param1 != JOIN && param1 != LEAVE && param1 != INVITE && param1 != EXCLUDE && param1 != PASS_LEADERSHIP && param1 != ENABLE_SHARED_EXPERIENCE && param1 != DISABLE_SHARED_EXPERIENCE && param1 != JOIN_AGGRESSION)
            {
                throw new ArgumentError("PartyActionImpl.PartyActionImpl: Invalid type: " + param1 + ".");
            }
            if ((param1 == JOIN || param1 == INVITE || param1 == EXCLUDE || param1 == PASS_LEADERSHIP || param1 == JOIN_AGGRESSION) && param2 == null)
            {
                throw new ArgumentError("PartyActionImpl.PartyActionImpl: Invalid creature for type: " + param1 + ".");
            }
            this.m_Type = param1;
            this.m_Creature = param2;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                switch(this.m_Type)
                {
                    case JOIN:
                    {
                        _loc_2.sendCJOINPARTY(this.m_Creature.ID);
                        break;
                    }
                    case LEAVE:
                    {
                        _loc_2.sendCLEAVEPARTY();
                        break;
                    }
                    case INVITE:
                    {
                        _loc_2.sendCINVITETOPARTY(this.m_Creature.ID);
                        break;
                    }
                    case EXCLUDE:
                    {
                        _loc_2.sendCREVOKEINVITATION(this.m_Creature.ID);
                        break;
                    }
                    case PASS_LEADERSHIP:
                    {
                        _loc_2.sendCPASSLEADERSHIP(this.m_Creature.ID);
                        break;
                    }
                    case ENABLE_SHARED_EXPERIENCE:
                    {
                        _loc_2.sendCSHAREEXPERIENCE(true);
                        break;
                    }
                    case DISABLE_SHARED_EXPERIENCE:
                    {
                        _loc_2.sendCSHAREEXPERIENCE(false);
                        break;
                    }
                    case JOIN_AGGRESSION:
                    {
                        _loc_2.sendCJOINAGGRESSION(this.m_Creature.ID);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}

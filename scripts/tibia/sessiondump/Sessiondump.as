package tibia.sessiondump
{
    import flash.events.*;
    import flash.utils.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.creatures.*;
    import tibia.network.*;
    import tibia.sessiondump.controller.*;

    public class Sessiondump extends EventDispatcher implements IServerConnection
    {
        private var m_ProcessNextKeyframe:Boolean = false;
        private var m_State:uint = 0;
        private var m_SessiondumpLoader:SessiondumpLoader = null;
        private var m_KeyframeState:uint = 0;
        private var m_SessiondumpController:SessiondumpControllerBase = null;
        private var m_ConnectionData:SessiondumpConnectionData = null;
        private var m_ConnectionState:int = 0;
        private var m_Communication:IServerCommunication = null;
        private var m_MessageWriter:DummyMessageWriter = null;
        private var m_InputStream:ByteArray = null;
        private var m_SessiondumpReader:SessiondumpReader = null;
        static const CUPCONTAINER:int = 136;
        static const CQUITGAME:int = 20;
        static const CMARKETACCEPT:int = 248;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const CGONORTHWEST:int = 109;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const PK_REVENGE:int = 6;
        static const SOUTFIT:int = 200;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_NONE:uint = 0;
        static const CSETTACTICS:int = 160;
        static const CPERFORMANCEMETRICS:int = 31;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const CADDBUDDY:int = 220;
        static const RISKINESS_DANGEROUS:int = 1;
        static const GUILD_NONE:int = 0;
        static const PK_PARTYMODE:int = 2;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const SSETTACTICS:int = 167;
        static const SPLAYERDATABASIC:int = 159;
        static const CGOSOUTH:int = 103;
        static const PACKETLENGTH_SIZE:int = 2;
        static const SMESSAGE:int = 180;
        static const CPING:int = 29;
        static const STATE_DRUNK:int = 3;
        static const SCREDITBALANCE:int = 223;
        static const CHECKSUM_POS:int = 2;
        static const CGETQUESTLOG:int = 240;
        static const CENTERWORLD:int = 15;
        static const CCLOSENPCCHANNEL:int = 158;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const CBUYOBJECT:int = 122;
        static const SPING:int = 29;
        static const CROTATENORTH:int = 111;
        static const SWAIT:int = 182;
        static const CATTACK:int = 161;
        static const SLOGINSUCCESS:int = 23;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const CLOOKATCREATURE:int = 141;
        static const CJOINCHANNEL:int = 152;
        static const SKILL_FED:int = 15;
        static const CROTATEEAST:int = 112;
        static const NUM_TRAPPERS:int = 8;
        static const SBUDDYDATA:int = 210;
        static const SKILL_MAGLEVEL:int = 2;
        static const CUSEONCREATURE:int = 132;
        static const TYPE_NPC:int = 2;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const CBROWSEFIELD:int = 203;
        static const SCREATUREPARTY:int = 145;
        static const SQUESTLOG:int = 240;
        static const ERR_INTERNAL:int = 0;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const CCANCEL:int = 190;
        static const CGUILDMESSAGE:int = 155;
        static const CREMOVEBUDDY:int = 221;
        public static const STATE_DEFAULT:int = 0;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const SKILL_NONE:int = -1;
        static const CCLOSECONTAINER:int = 135;
        static const GUILD_MEMBER:int = 4;
        static const SFIELDDATA:int = 105;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const SCLOSECONTAINER:int = 111;
        static const MAX_NAME_LENGTH:int = 29;
        static const SLEFTROW:int = 104;
        static const SFULLMAP:int = 100;
        static const PARTY_LEADER:int = 1;
        static const SUMMON_OTHERS:int = 2;
        static const SMISSILEEFFECT:int = 133;
        static const CGOWEST:int = 104;
        static const PROFESSION_NONE:int = 0;
        static const STATE_PZ_ENTERED:int = 14;
        static const CPASSLEADERSHIP:int = 166;
        public static const STATE_ERROR:int = -1;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const SSPELLGROUPDELAY:int = 165;
        private static const BUNDLE:String = "Connection";
        static const SBOTTOMROW:int = 103;
        static const CGETOBJECTINFO:int = 243;
        static const CSEEKINCONTAINER:int = 204;
        static const STATE_DROWNING:int = 8;
        static const SQUESTLINE:int = 241;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const SUPDATINGSHOPBALANCE:int = 242;
        private static const KEYFRAME_STATE_NONE:uint = 0;
        static const CGOSOUTHWEST:int = 108;
        static const SLOGINERROR:int = 20;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const SCREATUREMARKS:int = 147;
        private static const HEADER_MAGIC_BYTES_SIZE:uint = 3;
        static const CREJECTTRADE:int = 128;
        public static const SCREATUREDATA:int = 3;
        static const SREQUESTPURCHASEDATA:int = 225;
        static const CREVOKEINVITATION:int = 165;
        static const SCREATURESKULL:int = 144;
        static const CLOGIN:int = 10;
        static const ERR_CONNECTION_LOST:int = 6;
        static const SUNJUSTIFIEDPOINTS:int = 183;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const SPLAYERDATACURRENT:int = 160;
        static const STRAPPERS:int = 135;
        static const SOBJECTINFO:int = 244;
        static const GUILD_WAR_ALLY:int = 1;
        static const CGETQUESTLINE:int = 241;
        static const SSNAPBACK:int = 181;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const CROTATESOUTH:int = 113;
        static const CGETCHANNELS:int = 151;
        static const PARTY_NONE:int = 0;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const STATE_SLOW:int = 5;
        static const CACCEPTTRADE:int = 127;
        static const SCHANNELS:int = 171;
        static const SOPENCHANNEL:int = 172;
        static const STOPFLOOR:int = 190;
        static const PROFESSION_SORCERER:int = 3;
        static const TYPE_SUMMON_OWN:int = 3;
        static const CBUYPREMIUMOFFER:int = 252;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const SPRIVATECHANNEL:int = 173;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const SBLESSINGS:int = 156;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        private static const KEYFRAME_STATE_PROCESS:uint = 1;
        static const SINGAMESHOPSUCCESS:int = 254;
        static const SSTOREBUTTONINDICATORS:int = 25;
        static const CPRIVATECHANNEL:int = 154;
        static const PAYLOADLENGTH_POS:int = 6;
        static const SLOGINWAIT:int = 22;
        static const SCREATEONMAP:int = 106;
        static const CGETTRANSACTIONHISTORY:int = 254;
        public static const SKEYFRAMEEND:int = 2;
        static const CTRADEOBJECT:int = 125;
        static const CLOOK:int = 140;
        static const ERR_INVALID_CHECKSUM:int = 2;
        public static const SKEYFRAMEBEGIN:int = 1;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const SCONTAINER:int = 110;
        static const SNPCOFFER:int = 122;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const CMARKETCANCEL:int = 247;
        static const SWORLDENTERED:int = 15;
        static const HEADER_POS:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const STRANSACTIONHISTORY:int = 253;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const SPREMIUMSHOPOFFERS:int = 252;
        static const STATE_MANA_SHIELD:int = 4;
        static const CSELLOBJECT:int = 123;
        static const CMOUNT:int = 212;
        static const CCLOSENPCTRADE:int = 124;
        static const SMARKETBROWSE:int = 249;
        static const STATE_CURSED:int = 11;
        static const CMARKETBROWSE:int = 245;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const SMARKETLEAVE:int = 247;
        static const BLESSING_ADVENTURER:int = 1;
        static const SCOUNTEROFFER:int = 126;
        static const CFOLLOW:int = 162;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const CANSWERMODALDIALOG:int = 249;
        static const STATE_BURNING:int = 1;
        static const CEXCLUDEFROMCHANNEL:int = 172;
        static const SMARKETENTER:int = 246;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SCREATURESPEED:int = 143;
        static const CREQUESTSHOPOFFERS:int = 251;
        static const SKILL_FIGHTFIST:int = 13;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const STATE_FIGHTING:int = 7;
        static const SSPELLDELAY:int = 164;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const CEDITBUDDY:int = 222;
        private static const HEADER_HEADER_LENGTH_SIZE:uint = 2;
        static const SDELETEONMAP:int = 108;
        static const CEDITGUILDMESSAGE:int = 156;
        static const CROTATEWEST:int = 114;
        public static const PROTOCOL_VERSION:int = 1099;
        static const SCREATUREOUTFIT:int = 142;
        static const SEDITGUILDMESSAGE:int = 174;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const SAMBIENTE:int = 130;
        static const ERR_INVALID_SIZE:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const STATE_PZ_BLOCK:int = 13;
        static const SLOGINCHALLENGE:int = 31;
        static const CLEAVECHANNEL:int = 153;
        static const PARTY_MEMBER:int = 2;
        static const SPLAYERSKILLS:int = 161;
        static const CTHANKYOU:int = 231;
        private static const ERROR_INVALID_SESSIONDUMP:uint = 2;
        static const SCREATUREUNPASS:int = 146;
        static const RISKINESS_NONE:int = 0;
        static const SKILL_STAMINA:int = 17;
        static const SSHOWMODALDIALOG:int = 250;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const STATE_NONE:int = -1;
        static const CGONORTHEAST:int = 106;
        static const NUM_CREATURES:int = 1300;
        static const SKILL_FISHING:int = 14;
        static const SDELETEINCONTAINER:int = 114;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const SCREATEINCONTAINER:int = 112;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_PLAYERKILLER:int = 4;
        static const CERRORFILEENTRY:int = 232;
        static const HEADER_SIZE:int = 6;
        static const CINSPECTNPCTRADE:int = 121;
        static const SCREATUREHEALTH:int = 140;
        static const STATE_BLEEDING:int = 15;
        static const STOPROW:int = 101;
        static const CHECKSUM_SIZE:int = 4;
        static const CTURNOBJECT:int = 133;
        static const COPENPREMIUMSHOP:int = 250;
        private static const ERROR_SESSIONDUMP_CONNECTION_ERROR:uint = 1;
        static const CUSEOBJECT:int = 130;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const SBOTTOMFLOOR:int = 191;
        static const STATE_DAZZLED:int = 10;
        static const CINVITETOCHANNEL:int = 171;
        static const CUSETWOOBJECTS:int = 131;
        static const ERR_INVALID_STATE:int = 4;
        static const SPREMIUMTRIGGER:int = 158;
        public static const STATE_DONE:int = 3;
        static const CINVITETOPARTY:int = 163;
        static const SCREATURELIGHT:int = 141;
        static const CPINGBACK:int = 30;
        static const SPINGBACK:int = 30;
        static const STUTORIALHINT:int = 220;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const SPLAYERGOODS:int = 123;
        static const CSTOP:int = 105;
        static const SPLAYERINVENTORY:int = 245;
        static const CMOVEOBJECT:int = 120;
        static const CRULEVIOLATIONREPORT:int = 242;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const CJOINAGGRESSION:int = 142;
        static const SMOVECREATURE:int = 109;
        static const SSWITCHPRESET:int = 157;
        static const CGOEAST:int = 102;
        static const CEDITLIST:int = 138;
        static const CTOGGLEWRAPSTATE:int = 139;
        static const CJOINPARTY:int = 164;
        static const PK_NONE:int = 0;
        static const SCLOSETRADE:int = 127;
        static const CONNECTION_STATE_GAME:int = 4;
        static const SMULTIUSEDELAY:int = 166;
        private static const KEYFRAME_STATE_SKIP:uint = 2;
        static const CSTOREEVENT:int = 233;
        static const SEDITLIST:int = 151;
        static const SSETINVENTORY:int = 120;
        static const SUMMON_OWN:int = 1;
        static const CGOPATH:int = 100;
        static const CLEAVEPARTY:int = 167;
        static const SCHANGEONMAP:int = 107;
        static const CGOSOUTHEAST:int = 107;
        static const CEQUIPOBJECT:int = 119;
        static const SCREATUREPVPHELPERS:int = 148;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const COPENCHANNEL:int = 170;
        static const SDEAD:int = 40;
        static const SCHANGEINCONTAINER:int = 113;
        static const SDELETEINVENTORY:int = 121;
        static const CTRANSFERCURRENCY:int = 239;
        static const PROFESSION_PALADIN:int = 2;
        static const SINGAMESHOPERROR:int = 224;
        static const SCHANNELEVENT:int = 243;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SPVPSITUATIONS:int = 184;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const SLOGINADVICE:int = 21;
        static const PROFESSION_KNIGHT:int = 1;
        static const SKILL_FIGHTAXE:int = 12;
        public static const STATE_LOADING:int = 1;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const CGONORTH:int = 101;
        static const SMARKETDETAIL:int = 248;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const CTALK:int = 150;
        static const PAYLOADDATA_POSITION:int = 8;
        static const STATE_FAST:int = 6;
        static const SPREMIUMSHOP:int = 251;
        static const STALK:int = 170;
        static const CEDITTEXT:int = 137;
        static const GUILD_OTHER:int = 5;
        static const SCLOSENPCTRADE:int = 124;
        static const SPENDINGSTATEENTERED:int = 10;
        static const PAYLOADLENGTH_SIZE:int = 2;
        static const TYPE_PLAYER:int = 0;
        static const SRIGHTROW:int = 102;
        static const CINSPECTTRADE:int = 126;
        static const SKILL_MANA:int = 5;
        static const SEDITTEXT:int = 150;
        static const SOPENOWNCHANNEL:int = 178;
        static const SGRAPHICALEFFECT:int = 131;
        static const CBUGREPORT:int = 230;
        static const BLESSING_NONE:int = 0;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const TYPE_MONSTER:int = 1;
        static const CMARKETLEAVE:int = 244;
        static const COPENTRANSACTIONHISTORY:int = 253;
        static const CSHAREEXPERIENCE:int = 168;
        static const SCLEARTARGET:int = 163;
        static const SCREATURETYPE:int = 149;
        static const CGETOUTFIT:int = 210;
        static const STATE_STRENGTHENED:int = 12;
        public static const STATE_LOADED:int = 2;
        static const PK_AGGRESSOR:int = 3;
        static const STATE_HUNGRY:int = 31;
        static const SKILL_LEVEL:int = 1;
        static const SCLOSECHANNEL:int = 179;
        static const PROFESSION_DRUID:int = 4;
        static const CSETOUTFIT:int = 211;
        static const PACKETLENGTH_POS:int = 0;
        static const SBUDDYSTATUSCHANGE:int = 211;
        static const SUMMON_NONE:int = 0;
        static const SAUTOMAPFLAG:int = 221;
        static const SOWNOFFER:int = 125;
        static const PAYLOAD_POS:int = 6;
        static const SKILL_GOSTRENGTH:int = 6;
        static const SSETSTOREDEEPLINK:int = 168;
        static const CMARKETCREATE:int = 246;
        static const SPLAYERSTATE:int = 162;

        public function Sessiondump(param1:SessiondumpControllerBase)
        {
            this.m_MessageWriter = new DummyMessageWriter();
            this.m_SessiondumpController = param1;
            return;
        }// end function

        protected function readSLOGINWAIT(param1:ByteArray) : void
        {
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            var _loc_3:* = param1.readUnsignedByte() * 1000;
            this.disconnect();
            var _loc_4:* = new ConnectionEvent(ConnectionEvent.LOGINWAIT);
            _loc_4.message = _loc_2;
            _loc_4.data = _loc_3;
            dispatchEvent(_loc_4);
            return;
        }// end function

        public function get latency() : uint
        {
            return 0;
        }// end function

        public function get isConnected() : Boolean
        {
            return this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE1 || this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE2 || this.m_ConnectionState == CONNECTION_STATE_PENDING || this.m_ConnectionState == CONNECTION_STATE_GAME;
        }// end function

        private function handleConnectionError(param1:int, param2:int = 0, param3:Object = null) : void
        {
            this.disconnect();
            var _loc_4:* = null;
            switch(param1)
            {
                case ERROR_INVALID_SESSIONDUMP:
                {
                    _loc_4 = "Invalid sessiondump (Code: " + param1 + ")";
                    break;
                }
                case ERROR_SESSIONDUMP_CONNECTION_ERROR:
                {
                    _loc_4 = "Error while loading sessiondump (Code: " + param1 + "." + param2 + ")";
                    break;
                }
                case ERR_INTERNAL:
                {
                }
                default:
                {
                    _loc_4 = ResourceManager.getInstance().getString(BUNDLE, "MSG_INTERNAL_ERROR", [param1, param2]);
                    break;
                    break;
                }
            }
            var _loc_5:* = new ConnectionEvent(ConnectionEvent.ERROR);
            _loc_5.message = _loc_4;
            _loc_5.data = null;
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function processNextKeyframe() : void
        {
            this.m_KeyframeState = KEYFRAME_STATE_PROCESS;
            return;
        }// end function

        public function get state() : uint
        {
            return this.m_State;
        }// end function

        public function get isPending() : Boolean
        {
            return this.m_ConnectionState == CONNECTION_STATE_PENDING;
        }// end function

        protected function readMountOutfit(param1:ByteArray, param2:AppearanceInstance) : AppearanceInstance
        {
            var _loc_3:* = Tibia.s_GetAppearanceStorage();
            if (param1 == null || param1.bytesAvailable < 2)
            {
                throw new Error("Sessiondump.readMountOutfit: Not enough data.", 2147483619);
            }
            var _loc_4:* = param1.readUnsignedShort();
            if (param2 is OutfitInstance && param2.ID == _loc_4)
            {
                return param2;
            }
            if (_loc_4 != 0)
            {
                return _loc_3.createOutfitInstance(_loc_4, 0, 0, 0, 0, 0);
            }
            return null;
        }// end function

        public function setConnectionState(param1:uint, param2:Boolean = true) : void
        {
            this.m_ConnectionState = param1;
            var _loc_3:* = null;
            if (this.m_ConnectionState == CONNECTION_STATE_GAME)
            {
                if (param2)
                {
                    _loc_3 = new ConnectionEvent(ConnectionEvent.GAME);
                    dispatchEvent(_loc_3);
                }
            }
            else if (this.m_ConnectionState == CONNECTION_STATE_PENDING)
            {
                if (param2)
                {
                    _loc_3 = new ConnectionEvent(ConnectionEvent.PENDING);
                    dispatchEvent(_loc_3);
                }
            }
            else if (this.m_ConnectionState == CONNECTION_STATE_DISCONNECTED)
            {
                if (param2)
                {
                    _loc_3 = new ConnectionEvent(ConnectionEvent.DISCONNECTED);
                    dispatchEvent(_loc_3);
                }
            }
            else if (this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE1)
            {
                if (param2)
                {
                    _loc_3 = new ConnectionEvent(ConnectionEvent.CONNECTING);
                    dispatchEvent(_loc_3);
                }
            }
            else if (this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE2)
            {
            }
            return;
        }// end function

        public function disconnect(param1:Boolean = true) : void
        {
            this.m_State = STATE_DEFAULT;
            if (this.m_SessiondumpReader.packetReader != null)
            {
                this.m_SessiondumpReader.packetReader.finishPacket();
                this.m_InputStream.position = this.m_InputStream.length;
            }
            this.setConnectionState(CONNECTION_STATE_DISCONNECTED, param1);
            this.m_SessiondumpController.disconnect();
            return;
        }// end function

        public function get messageReader() : IMessageReader
        {
            return this.m_SessiondumpReader != null ? (this.m_SessiondumpReader.messageReader) : (null);
        }// end function

        protected function readSKEYFRAMEBEGIN(param1:ByteArray) : void
        {
            if (this.m_KeyframeState == KEYFRAME_STATE_NONE)
            {
                this.m_KeyframeState = KEYFRAME_STATE_SKIP;
            }
            (Tibia.s_GetCreatureStorage() as SessiondumpCreatureStorage).resetKeyframeCreatures();
            return;
        }// end function

        public function readCommunicationData() : void
        {
            var Type:uint;
            var PacketAvailableEvent:SessiondumpEvent;
            var MessageProcessedEvent:SessiondumpEvent;
            do
            {
                
                Type = this.messageReader.messageType;
                if (hasEventListener(SessiondumpEvent.MESSAGE_AVAILABLE))
                {
                    PacketAvailableEvent = new SessiondumpEvent(SessiondumpEvent.MESSAGE_AVAILABLE, false, true, Type, this.m_SessiondumpReader.packetReader.isClientPacket, this.m_SessiondumpReader.packetReader.packetTimestamp);
                    dispatchEvent(PacketAvailableEvent);
                    if (PacketAvailableEvent.isDefaultPrevented())
                    {
                        return;
                    }
                }
                if (!this.isConnected)
                {
                    return;
                }
                if (this.m_KeyframeState == KEYFRAME_STATE_SKIP && Type != SKEYFRAMEEND && Type != SCREATUREDATA || this.m_SessiondumpReader.packetReader.isClientPacket)
                {
                    this.messageReader.finishMessage();
                }
                else
                {
                    try
                    {
                        switch(Type)
                        {
                            case SKEYFRAMEBEGIN:
                            {
                                this.readSKEYFRAMEBEGIN(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SKEYFRAMEEND:
                            {
                                this.readSKEYFRAMEEND(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SCREATUREDATA:
                            {
                                this.readSCREATUREDATA(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SPING:
                            {
                                this.readSPING(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SPINGBACK:
                            {
                                this.readSPINGBACK(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SLOGINCHALLENGE:
                            {
                                this.readSLOGINCHALLENGE(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SLOGINERROR:
                            {
                                this.readSLOGINERROR(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SLOGINADVICE:
                            {
                                this.readSLOGINADVICE(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SLOGINWAIT:
                            {
                                this.readSLOGINWAIT(this.m_InputStream);
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SSHOWMODALDIALOG:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SOUTFIT:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SQUESTLOG:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SCHANNELS:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SEDITTEXT:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SEDITLIST:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case STUTORIALHINT:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SPREMIUMSHOP:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            case SPREMIUMSHOPOFFERS:
                            {
                                this.messageReader.finishMessage();
                                break;
                            }
                            default:
                            {
                                if (this.communication != null)
                                {
                                    this.communication.readMessage(this.messageReader);
                                }
                                break;
                            }
                        }
                        if (this.messageReader.messageWasRead && hasEventListener(SessiondumpEvent.MESSAGE_PROCESSED))
                        {
                            MessageProcessedEvent = new SessiondumpEvent(SessiondumpEvent.MESSAGE_PROCESSED, false, false, Type, this.m_SessiondumpReader.packetReader.isClientPacket, this.m_SessiondumpReader.packetReader.packetTimestamp);
                            dispatchEvent(MessageProcessedEvent);
                        }
                        if (this.isConnected && this.messageReader.messageWasRead == false)
                        {
                            this.handleConnectionError(ERR_INVALID_MESSAGE, 0, "Sessiondump.readSocketData: Invalid message type " + Type + ".");
                        }
                    }
                    catch (_Error:Error)
                    {
                        handleReadError(Type, _Error);
                        return;
                    }
                }
            }while (this.m_SessiondumpReader.packetReader.containsUnreadMessage)
            this.m_SessiondumpReader.packetReader.finishPacket();
            return;
        }// end function

        public function set communication(param1:IServerCommunication) : void
        {
            this.m_Communication = param1;
            return;
        }// end function

        public function get connectionData() : IConnectionData
        {
            return this.m_ConnectionData;
        }// end function

        public function get sessiondumpDone() : Boolean
        {
            return this.m_SessiondumpLoader.isLoadingFinished && this.m_InputStream.position == this.m_InputStream.length;
        }// end function

        public function get sessiondumpLoader() : SessiondumpLoader
        {
            return this.m_SessiondumpLoader;
        }// end function

        public function get sessiondumpDuration() : uint
        {
            return this.m_ConnectionData != null ? (this.m_ConnectionData.durationMilliseconds) : (0);
        }// end function

        public function get sessiondumpController() : SessiondumpControllerBase
        {
            return this.m_SessiondumpController;
        }// end function

        private function handleReadError(param1:int, param2:Error) : void
        {
            var _loc_3:* = param2 != null ? (param2.errorID) : (-1);
            this.handleConnectionError(256 + param1, _loc_3, param2);
            return;
        }// end function

        public function get connectionState() : uint
        {
            return this.m_ConnectionState;
        }// end function

        public function get communication() : IServerCommunication
        {
            return this.m_Communication;
        }// end function

        public function reconnect() : void
        {
            this.disconnect(false);
            this.connect(this.m_ConnectionData);
            return;
        }// end function

        protected function readCreatureOutfit(param1:ByteArray, param2:AppearanceInstance) : AppearanceInstance
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_3:* = Tibia.s_GetAppearanceStorage();
            if (param1 == null || param1.bytesAvailable < 4)
            {
                throw new Error("Sessiondump.readCreatureOutfit: Not enough data.", 2147483620);
            }
            var _loc_4:* = param1.readUnsignedShort();
            if (param1.readUnsignedShort() != 0)
            {
                _loc_5 = param1.readUnsignedByte();
                _loc_6 = param1.readUnsignedByte();
                _loc_7 = param1.readUnsignedByte();
                _loc_8 = param1.readUnsignedByte();
                _loc_9 = param1.readUnsignedByte();
                if (param2 is OutfitInstance && param2.ID == _loc_4)
                {
                    OutfitInstance(param2).updateProperties(_loc_5, _loc_6, _loc_7, _loc_8, _loc_9);
                    return param2;
                }
                return _loc_3.createOutfitInstance(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9);
            }
            else
            {
                _loc_10 = param1.readUnsignedShort();
                if (param2 is ObjectInstance && param2.ID == _loc_10)
                {
                    return param2;
                }
                if (_loc_10 == 0)
                {
                    return _loc_3.createOutfitInstance(OutfitInstance.INVISIBLE_OUTFIT_ID, 0, 0, 0, 0, 0);
                }
                return _loc_3.createObjectInstance(_loc_10, 0);
            }
        }// end function

        protected function readSLOGINCHALLENGE(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            this.setConnectionState(CONNECTION_STATE_CONNECTING_STAGE2, false);
            return;
        }// end function

        public function get isGameRunning() : Boolean
        {
            return this.m_ConnectionState == CONNECTION_STATE_GAME;
        }// end function

        private function onLoaderError(event:ErrorEvent) : void
        {
            this.handleConnectionError(ERROR_SESSIONDUMP_CONNECTION_ERROR, event.errorID, event.text);
            return;
        }// end function

        public function load() : void
        {
            if (this.m_State == STATE_DEFAULT || this.sessiondumpDone)
            {
                if (this.m_SessiondumpLoader != null)
                {
                    this.m_SessiondumpLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderError);
                    this.m_SessiondumpLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoaderError);
                }
                this.m_SessiondumpLoader = new SessiondumpLoader();
                this.m_SessiondumpLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderError);
                this.m_SessiondumpLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoaderError);
                this.m_SessiondumpLoader.load(this.m_ConnectionData.url);
                this.m_InputStream = this.m_SessiondumpLoader.inputStream;
                this.m_SessiondumpReader = new SessiondumpReader(this.m_InputStream);
            }
            return;
        }// end function

        public function get messageWriter() : IMessageWriter
        {
            return this.m_MessageWriter;
        }// end function

        protected function readSLOGINADVICE(param1:ByteArray) : void
        {
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            var _loc_3:* = new ConnectionEvent(ConnectionEvent.LOGINADVICE);
            _loc_3.message = _loc_2;
            dispatchEvent(_loc_3);
            return;
        }// end function

        protected function readSCREATUREDATA(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = -1;
            var _loc_5:* = null;
            var _loc_6:* = Tibia.s_GetPlayer();
            var _loc_7:* = Tibia.s_GetCreatureStorage() as SessiondumpCreatureStorage;
            _loc_3 = param1.readUnsignedInt();
            _loc_2 = param1.readUnsignedInt();
            _loc_4 = param1.readUnsignedByte();
            if (_loc_2 == _loc_6.ID)
            {
                _loc_5 = _loc_6;
            }
            else
            {
                _loc_5 = new Creature(_loc_2);
                _loc_7.addKeyframeCreature(_loc_5);
            }
            if (_loc_5 != null)
            {
                _loc_5.type = _loc_4;
                _loc_5.name = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
                _loc_5.setSkillValue(SKILL_HITPOINTS_PERCENT, param1.readUnsignedByte());
                _loc_5.direction = param1.readUnsignedByte();
                _loc_5.outfit = this.readCreatureOutfit(param1, _loc_5.outfit);
                _loc_5.mountOutfit = this.readMountOutfit(param1, _loc_5.mountOutfit);
                _loc_5.brightness = param1.readUnsignedByte();
                _loc_5.lightColour = Colour.s_FromEightBit(param1.readUnsignedByte());
                _loc_5.setSkillValue(SKILL_GOSTRENGTH, param1.readUnsignedShort());
                _loc_5.setPKFlag(param1.readUnsignedByte());
                _loc_5.setPartyFlag(param1.readUnsignedByte());
                _loc_5.guildFlag = param1.readUnsignedByte();
                _loc_5.type = param1.readUnsignedByte();
                _loc_5.speechCategory = param1.readUnsignedByte();
                _loc_5.marks.setMark(Marks.MARK_TYPE_PERMANENT, param1.readUnsignedByte());
                _loc_5.numberOfPVPHelpers = param1.readUnsignedShort();
                _loc_5.isUnpassable = param1.readUnsignedByte() != 0;
            }
            else
            {
                throw new Error("Sessiondump.readSCREATUREDATA: Failed to append creature.", 2147483623);
            }
            return;
        }// end function

        protected function readSPINGBACK(param1:ByteArray) : void
        {
            return;
        }// end function

        protected function readSPING(param1:ByteArray) : void
        {
            return;
        }// end function

        public function get inputStream() : ByteArray
        {
            return this.m_InputStream;
        }// end function

        public function get stillLoading() : Boolean
        {
            return !this.m_SessiondumpLoader.isLoadingFinished;
        }// end function

        protected function readSKEYFRAMEEND(param1:ByteArray) : void
        {
            this.m_KeyframeState = KEYFRAME_STATE_NONE;
            return;
        }// end function

        public function connect(param1:IConnectionData) : void
        {
            if (!(param1 is SessiondumpConnectionData))
            {
                throw new Error("Sessiondump.connect: Invalid connection data.", 2147483639);
            }
            this.m_ConnectionData = param1 as SessiondumpConnectionData;
            if (this.m_ConnectionData.url == null || this.m_ConnectionData.url.length < 1)
            {
                throw new Error("Connection.connect: Invalid url.", 2147483638);
            }
            this.m_State = STATE_DEFAULT;
            this.m_SessiondumpReader = null;
            this.load();
            this.m_SessiondumpController.connect(this, this.m_SessiondumpReader);
            this.setConnectionState(CONNECTION_STATE_CONNECTING_STAGE1, true);
            return;
        }// end function

        protected function readSLOGINERROR(param1:ByteArray) : void
        {
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            this.disconnect();
            var _loc_3:* = new ConnectionEvent(ConnectionEvent.LOGINERROR);
            _loc_3.message = _loc_2;
            dispatchEvent(_loc_3);
            return;
        }// end function

    }
}

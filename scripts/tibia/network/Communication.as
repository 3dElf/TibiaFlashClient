package tibia.network
{
    import __AS3__.vec.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.game.serverModalDialogClasses.*;
    import tibia.help.*;
    import tibia.ingameshop.*;
    import tibia.magic.*;
    import tibia.market.*;
    import tibia.minimap.*;
    import tibia.network.*;
    import tibia.options.*;
    import tibia.questlog.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;
    import tibia.sidebar.*;
    import tibia.trade.*;
    import tibia.worldmap.*;

    public class Communication extends Object implements IServerCommunication
    {
        private var m_AppearanceStorage:AppearanceStorage = null;
        private var m_BeatDuration:int = 0;
        private var m_ServerConnection:IServerConnection = null;
        private var m_ContainerStorage:ContainerStorage = null;
        private var m_MessageStorage:MessageStorage = null;
        private var m_WorldMapStorage:WorldMapStorage = null;
        private var m_SpellStorage:SpellStorage = null;
        private var m_BugreportsAllowed:Boolean = false;
        private var m_ChatStorage:ChatStorage = null;
        private var m_Player:Player = null;
        private var m_LastSnapback:Vector3D;
        private var m_CreatureStorage:CreatureStorage = null;
        private var m_MiniMapStorage:MiniMapStorage = null;
        private var m_SnapbackCount:int = 0;
        private var m_PendingQuestLog:Boolean = false;
        private var m_PendingQuestLine:int = -1;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const CUPCONTAINER:int = 136;
        static const CQUITGAME:int = 20;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const CMARKETACCEPT:int = 248;
        static const SAUTOMAPFLAG:int = 221;
        static const PK_REVENGE:int = 6;
        static const SBUDDYSTATUSCHANGE:int = 211;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const CGONORTHWEST:int = 109;
        static const SCREATURETYPE:int = 149;
        static const SOUTFIT:int = 200;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const CPERFORMANCEMETRICS:int = 31;
        static const CSETTACTICS:int = 160;
        static const GUILD_NONE:int = 0;
        static const PK_PARTYMODE:int = 2;
        static const PATH_COST_OBSTACLE:int = 255;
        static const CMARKETCREATE:int = 246;
        static const CGOSOUTH:int = 103;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const FIELD_HEIGHT:int = 24;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const SMESSAGE:int = 180;
        static const CPING:int = 29;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const CGETOUTFIT:int = 210;
        static const SSETTACTICS:int = 167;
        static const SKILL_GOSTRENGTH:int = 6;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const CBUYOBJECT:int = 122;
        static const TYPE_NPC:int = 2;
        static const SPING:int = 29;
        static const FIELD_SIZE:int = 32;
        static const CROTATENORTH:int = 111;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const SLOGINSUCCESS:int = 23;
        static const SWAIT:int = 182;
        static const PATH_NORTH:int = 3;
        static const CLOOKATCREATURE:int = 141;
        static const CENTERWORLD:int = 15;
        static const CJOINCHANNEL:int = 152;
        static const SKILL_FED:int = 15;
        static const CROTATEEAST:int = 112;
        static const NUM_TRAPPERS:int = 8;
        static const SPLAYERDATABASIC:int = 159;
        static const SKILL_MAGLEVEL:int = 2;
        static const CUSEONCREATURE:int = 132;
        static const CATTACK:int = 161;
        static const SBUDDYDATA:int = 210;
        static const CHECKSUM_POS:int = 2;
        static const SCREDITBALANCE:int = 223;
        static const CADDBUDDY:int = 220;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const SCREATUREPARTY:int = 145;
        static const CGUILDMESSAGE:int = 155;
        static const GROUND_LAYER:int = 7;
        static const CGETQUESTLOG:int = 240;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const ERR_INTERNAL:int = 0;
        public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
        static const SUMMON_OTHERS:int = 2;
        static const SQUESTLOG:int = 240;
        static const CBROWSEFIELD:int = 203;
        static const SKILL_NONE:int = -1;
        static const GUILD_MEMBER:int = 4;
        static const SFIELDDATA:int = 105;
        static const PATH_EMPTY:int = 0;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const CCANCEL:int = 190;
        static const SCLOSECONTAINER:int = 111;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const MAX_NAME_LENGTH:int = 29;
        static const SLEFTROW:int = 104;
        static const SFULLMAP:int = 100;
        static const PARTY_LEADER:int = 1;
        static const SMISSILEEFFECT:int = 133;
        static const PATH_MATRIX_SIZE:int = 221;
        static const CGOWEST:int = 104;
        static const PROFESSION_NONE:int = 0;
        static const PATH_ERROR_GO_UPSTAIRS:int = -2;
        static const PATH_COST_MAX:int = 250;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        static const STATE_PZ_ENTERED:int = 14;
        static const CPASSLEADERSHIP:int = 166;
        static const PATH_MAX_STEPS:int = 128;
        static const SSPELLGROUPDELAY:int = 165;
        static const CCLOSENPCCHANNEL:int = 158;
        static const SBOTTOMROW:int = 103;
        static const CGETOBJECTINFO:int = 243;
        static const CSEEKINCONTAINER:int = 204;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const SUPDATINGSHOPBALANCE:int = 242;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const CGOSOUTHWEST:int = 108;
        static const SLOGINERROR:int = 20;
        static const CREMOVEBUDDY:int = 221;
        private static const BUNDLE:String = "Communication";
        static const SCREATUREMARKS:int = 147;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const CREJECTTRADE:int = 128;
        static const MAP_WIDTH:int = 15;
        static const SQUESTLINE:int = 241;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const SREQUESTPURCHASEDATA:int = 225;
        static const CREVOKEINVITATION:int = 165;
        static const CLOGIN:int = 10;
        static const STRAPPERS:int = 135;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const SUNJUSTIFIEDPOINTS:int = 183;
        static const CCLOSECONTAINER:int = 135;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const SCREATURESKULL:int = 144;
        static const SSNAPBACK:int = 181;
        static const CGETCHANNELS:int = 151;
        static const SOBJECTINFO:int = 244;
        static const NUM_EFFECTS:int = 200;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const PATH_SOUTH:int = 7;
        static const CROTATESOUTH:int = 113;
        static const CACCEPTTRADE:int = 127;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const PATH_NORTH_WEST:int = 4;
        static const ERR_CONNECTION_LOST:int = 6;
        static const CGETQUESTLINE:int = 241;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const SCHANNELS:int = 171;
        public static const CLIENT_VERSION:uint = 2309;
        static const TYPE_SUMMON_OWN:int = 3;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const SPRIVATECHANNEL:int = 173;
        static const SOPENCHANNEL:int = 172;
        static const CBUYPREMIUMOFFER:int = 252;
        static const SBLESSINGS:int = 156;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const FIELD_CACHESIZE:int = 32;
        static const SPLAYERDATACURRENT:int = 160;
        static const STOPFLOOR:int = 190;
        static const PATH_ERROR_UNREACHABLE:int = -4;
        static const CGETTRANSACTIONHISTORY:int = 254;
        static const SSTOREBUTTONINDICATORS:int = 25;
        static const SCREATEONMAP:int = 106;
        static const CPRIVATECHANNEL:int = 154;
        static const SLOGINWAIT:int = 22;
        public static const PREVIEW_STATE_REGULAR:uint = 0;
        static const PATH_SOUTH_WEST:int = 6;
        static const PAYLOADLENGTH_POS:int = 6;
        static const CLOOK:int = 140;
        static const SINGAMESHOPSUCCESS:int = 254;
        static const CTRADEOBJECT:int = 125;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const ERR_INVALID_CHECKSUM:int = 2;
        static const SCONTAINER:int = 110;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const SNPCOFFER:int = 122;
        static const SWORLDENTERED:int = 15;
        static const PACKETLENGTH_SIZE:int = 2;
        static const PAYLOAD_POS:int = 6;
        static const CEXCLUDEFROMCHANNEL:int = 172;
        static const SKILL_HITPOINTS:int = 4;
        static const PATH_WEST:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const SPREMIUMSHOPOFFERS:int = 252;
        static const STATE_MANA_SHIELD:int = 4;
        static const CMOUNT:int = 212;
        static const STRANSACTIONHISTORY:int = 253;
        static const SMARKETBROWSE:int = 249;
        static const BLESSING_ADVENTURER:int = 1;
        static const CSELLOBJECT:int = 123;
        static const STATE_FREEZING:int = 9;
        static const STATE_CURSED:int = 11;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const CMARKETBROWSE:int = 245;
        static const SMARKETLEAVE:int = 247;
        static const CCLOSENPCTRADE:int = 124;
        static const NUM_FIELDS:int = 2016;
        static const SCOUNTEROFFER:int = 126;
        static const CFOLLOW:int = 162;
        static const STATE_POISONED:int = 0;
        static const PATH_EXISTS:int = 1;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const CMARKETCANCEL:int = 247;
        static const STATE_BURNING:int = 1;
        static const HEADER_POS:int = 0;
        static const SMARKETENTER:int = 246;
        static const SKILL_FIGHTFIST:int = 13;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const GUILD_WAR_ENEMY:int = 2;
        static const CREQUESTSHOPOFFERS:int = 251;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const STATE_FIGHTING:int = 7;
        static const CANSWERMODALDIALOG:int = 249;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const SCREATURESPEED:int = 143;
        static const SSPELLDELAY:int = 164;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const SDELETEONMAP:int = 108;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const STATE_PZ_BLOCK:int = 13;
        static const RISKINESS_NONE:int = 0;
        static const SEDITGUILDMESSAGE:int = 174;
        static const SCREATUREOUTFIT:int = 142;
        public static const PROTOCOL_VERSION:int = 1097;
        static const CEDITGUILDMESSAGE:int = 156;
        static const CEDITBUDDY:int = 222;
        static const CROTATEWEST:int = 114;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const SAMBIENTE:int = 130;
        static const ERR_INVALID_SIZE:int = 1;
        static const SLOGINCHALLENGE:int = 31;
        static const CLEAVECHANNEL:int = 153;
        static const PARTY_MEMBER:int = 2;
        static const SPLAYERSKILLS:int = 161;
        static const CTHANKYOU:int = 231;
        static const SCREATUREUNPASS:int = 146;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const SKILL_STAMINA:int = 17;
        static const SSHOWMODALDIALOG:int = 250;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const STATE_NONE:int = -1;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const SKILL_FISHING:int = 14;
        static const SDELETEINCONTAINER:int = 114;
        static const PATH_MAX_DISTANCE:int = 110;
        static const SCREATEINCONTAINER:int = 112;
        static const CGONORTHEAST:int = 106;
        static const PK_PLAYERKILLER:int = 4;
        static const CERRORFILEENTRY:int = 232;
        static const HEADER_SIZE:int = 6;
        static const CINSPECTNPCTRADE:int = 121;
        static const SCREATUREHEALTH:int = 140;
        static const STATE_BLEEDING:int = 15;
        static const STOPROW:int = 101;
        static const SBOTTOMFLOOR:int = 191;
        static const CTURNOBJECT:int = 133;
        static const STATE_DAZZLED:int = 10;
        static const CHECKSUM_SIZE:int = 4;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const CUSEOBJECT:int = 130;
        static const CINVITETOCHANNEL:int = 171;
        static const CUSETWOOBJECTS:int = 131;
        static const PATH_ERROR_INTERNAL:int = -5;
        static const COPENPREMIUMSHOP:int = 250;
        static const PATH_COST_UNDEFINED:int = 254;
        static const SPREMIUMTRIGGER:int = 158;
        static const ERR_INVALID_STATE:int = 4;
        static const SCREATURELIGHT:int = 141;
        static const CINVITETOPARTY:int = 163;
        static const CPINGBACK:int = 30;
        static const SPINGBACK:int = 30;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const STUTORIALHINT:int = 220;
        static const SPLAYERGOODS:int = 123;
        static const CSTOP:int = 105;
        static const CMOVEOBJECT:int = 120;
        static const SPLAYERINVENTORY:int = 245;
        static const CRULEVIOLATIONREPORT:int = 242;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const CJOINAGGRESSION:int = 142;
        static const SSWITCHPRESET:int = 157;
        static const CGOEAST:int = 102;
        static const SMOVECREATURE:int = 109;
        static const CEDITLIST:int = 138;
        static const CTOGGLEWRAPSTATE:int = 139;
        static const CJOINPARTY:int = 164;
        static const SEDITLIST:int = 151;
        static const PK_NONE:int = 0;
        static const SCLOSETRADE:int = 127;
        static const CONNECTION_STATE_GAME:int = 4;
        static const SMULTIUSEDELAY:int = 166;
        static const CSTOREEVENT:int = 233;
        static const SSETINVENTORY:int = 120;
        static const SUMMON_OWN:int = 1;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SCHANGEONMAP:int = 107;
        static const CGOPATH:int = 100;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const CEQUIPOBJECT:int = 119;
        static const CGOSOUTHEAST:int = 107;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const UNDERGROUND_LAYER:int = 2;
        static const COPENCHANNEL:int = 170;
        static const SDEAD:int = 40;
        static const SCHANGEINCONTAINER:int = 113;
        static const SCREATUREPVPHELPERS:int = 148;
        public static const CLIENT_TYPE:uint = 3;
        static const SDELETEINVENTORY:int = 121;
        static const CTRANSFERCURRENCY:int = 239;
        static const PROFESSION_PALADIN:int = 2;
        static const SINGAMESHOPERROR:int = 224;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const SLOGINADVICE:int = 21;
        static const SCHANNELEVENT:int = 243;
        static const SPVPSITUATIONS:int = 184;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const CLEAVEPARTY:int = 167;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const SMARKETDETAIL:int = 248;
        static const CGONORTH:int = 101;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const STATE_FAST:int = 6;
        static const SKILL_SOULPOINTS:int = 16;
        static const CTALK:int = 150;
        static const BLESSING_NONE:int = 0;
        static const PATH_NORTH_EAST:int = 2;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SPREMIUMSHOP:int = 251;
        static const PATH_ERROR_TOO_FAR:int = -3;
        static const STALK:int = 170;
        static const CEDITTEXT:int = 137;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SCLOSENPCTRADE:int = 124;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const SRIGHTROW:int = 102;
        static const SKILL_MANA:int = 5;
        static const SGRAPHICALEFFECT:int = 131;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const SOPENOWNCHANNEL:int = 178;
        static const SPENDINGSTATEENTERED:int = 10;
        public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
        static const CBUGREPORT:int = 230;
        static const PATH_SOUTH_EAST:int = 8;
        static const CINSPECTTRADE:int = 126;
        public static const CLIENT_PREVIEW_STATE:uint = 0;
        static const SEDITTEXT:int = 150;
        static const TYPE_MONSTER:int = 1;
        static const CMARKETLEAVE:int = 244;
        static const PAYLOADLENGTH_SIZE:int = 2;
        static const COPENTRANSACTIONHISTORY:int = 253;
        static const SCLEARTARGET:int = 163;
        static const CSHAREEXPERIENCE:int = 168;
        static const PK_AGGRESSOR:int = 3;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const STATE_HUNGRY:int = 31;
        static const SKILL_LEVEL:int = 1;
        static const PATH_EAST:int = 1;
        static const PROFESSION_DRUID:int = 4;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const SUMMON_NONE:int = 0;
        static const STATE_STRENGTHENED:int = 12;
        static const SOWNOFFER:int = 125;
        static const PACKETLENGTH_POS:int = 0;
        static const SCLOSECHANNEL:int = 179;
        static const CSETOUTFIT:int = 211;
        static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
        static const PAYLOADDATA_POSITION:int = 8;
        static const NPC_SPEECH_NONE:uint = 0;
        static const SSETSTOREDEEPLINK:int = 168;
        static const PATH_MATRIX_CENTER:int = 110;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SPLAYERSTATE:int = 162;

        public function Communication(param1:IServerConnection, param2:AppearanceStorage, param3:ChatStorage, param4:ContainerStorage, param5:CreatureStorage, param6:MiniMapStorage, param7:Player, param8:SpellStorage, param9:WorldMapStorage)
        {
            this.m_LastSnapback = new Vector3D();
            if (param1 == null)
            {
                throw new Error("Connection.Connection: Invalid connection data.", 2147483646);
            }
            this.m_ServerConnection = param1;
            param1.communication = this;
            if (param2 == null)
            {
                throw new Error("Connection.Connection: Invalid appearance data.", 2147483645);
            }
            this.m_AppearanceStorage = param2;
            if (param3 == null)
            {
                throw new Error("Connection.Connection: Invalid chat data.", 2147483644);
            }
            this.m_ChatStorage = param3;
            if (param4 == null)
            {
                throw new Error("Connection.Connection: Invalid container data.", 2147483643);
            }
            this.m_ContainerStorage = param4;
            if (param5 == null)
            {
                throw new Error("Connection.Connection: Invalid creature list.", 2147483642);
            }
            this.m_CreatureStorage = param5;
            if (param6 == null)
            {
                throw new Error("Connection.Connection: Invalid mini-map.", 2147483641);
            }
            this.m_MiniMapStorage = param6;
            if (param7 == null)
            {
                throw new Error("Connection.Connection: Invalid player.", 2147483640);
            }
            this.m_Player = param7;
            if (param8 == null)
            {
                throw new Error("Connection.Connection: Invalid spell data", 2147483639);
            }
            this.m_SpellStorage = param8;
            if (param9 == null)
            {
                throw new Error("Connection.Connection: Invalid world map.", 2147483638);
            }
            this.m_WorldMapStorage = param9;
            this.m_MessageStorage = new MessageStorage();
            this.m_LastSnapback.setComponents(0, 0, 0);
            this.m_SnapbackCount = 0;
            this.m_PendingQuestLog = false;
            this.m_PendingQuestLine = -1;
            return;
        }// end function

        protected function readSCREATURESKULL(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_4.setPKFlag(_loc_3);
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCCLOSECONTAINER(param1:int) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CCLOSECONTAINER);
                b.writeByte(a_ID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CCLOSECONTAINER, e);
            }
            return;
        }// end function

        protected function readMountOutfit(param1:ByteArray, param2:AppearanceInstance) : AppearanceInstance
        {
            if (param1 == null || param1.bytesAvailable < 2)
            {
                throw new Error("Connection.readMountOutfit: Not enough data.", 2147483619);
            }
            var _loc_3:* = param1.readUnsignedShort();
            if (param2 is OutfitInstance && param2.ID == _loc_3)
            {
                return param2;
            }
            if (_loc_3 != 0)
            {
                return this.m_AppearanceStorage.createOutfitInstance(_loc_3, 0, 0, 0, 0, 0);
            }
            return null;
        }// end function

        public function sendCREMOVEBUDDY(param1:int) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CREMOVEBUDDY);
                b.writeUnsignedInt(a_ID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CREMOVEBUDDY, e);
            }
            return;
        }// end function

        public function sendCOPENPREMIUMSHOP(param1:int, param2:String) : void
        {
            var b:ByteArray;
            var a_InitialStoreServiceType:* = param1;
            var a_InitialCategory:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(COPENPREMIUMSHOP);
                b.writeByte(a_InitialStoreServiceType);
                StringHelper.s_WriteToByteArray(b, a_InitialCategory);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(COPENPREMIUMSHOP, e);
            }
            return;
        }// end function

        public function sendCUSEOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            var a_TypeID:* = param4;
            var a_PositionOrData:* = param5;
            var a_Window:* = param6;
            try
            {
                if (a_X != 65535)
                {
                    this.m_Player.stopAutowalk(false);
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CUSEOBJECT);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                b.writeShort(a_TypeID);
                b.writeByte(a_PositionOrData);
                b.writeByte(a_Window);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CUSEOBJECT, e);
            }
            return;
        }// end function

        public function sendCCANCEL() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CCANCEL);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CCANCEL, e);
            }
            return;
        }// end function

        protected function readSCLOSECHANNEL(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedShort();
            this.m_ChatStorage.closeChannel(_loc_2);
            return;
        }// end function

        protected function readSPREMIUMSHOP(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            _loc_2 = IngameShopManager.getInstance();
            _loc_3 = param1.readUnsignedByte() == 1;
            _loc_4 = Number.NaN;
            _loc_5 = Number.NaN;
            if (_loc_3)
            {
                _loc_4 = param1.readInt();
                _loc_5 = param1.readInt();
            }
            _loc_2.setCreditBalance(_loc_4, _loc_5);
            _loc_6 = param1.readUnsignedShort();
            _loc_7 = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_8 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_9 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_10 = param1.readUnsignedByte();
                _loc_11 = new IngameShopCategory(_loc_8, _loc_9, _loc_10);
                _loc_12 = new Vector.<String>;
                _loc_13 = param1.readUnsignedByte();
                _loc_14 = 0;
                while (_loc_14 < _loc_13)
                {
                    
                    _loc_12.push(StringHelper.s_ReadLongStringFromByteArray(param1));
                    _loc_14 = _loc_14 + 1;
                }
                _loc_11.iconIdentifiers = _loc_12;
                _loc_15 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_2.addCategory(_loc_11, _loc_15);
                _loc_7 = _loc_7 + 1;
            }
            _loc_2.openShopWindow(false, IngameShopProduct.SERVICE_TYPE_UNKNOWN);
            return;
        }// end function

        public function sendCPASSLEADERSHIP(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CPASSLEADERSHIP);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPASSLEADERSHIP, e);
            }
            return;
        }// end function

        public function sendCINVITETOCHANNEL(param1:String, param2:int) : void
        {
            var b:ByteArray;
            var a_Name:* = param1;
            var a_ChannelID:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CINVITETOCHANNEL);
                StringHelper.s_WriteToByteArray(b, a_Name, Creature.MAX_NAME_LENGHT);
                b.writeShort(a_ChannelID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CINVITETOCHANNEL, e);
            }
            return;
        }// end function

        public function sendCUSETWOOBJECTS(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int) : void
        {
            var b:ByteArray;
            var a_FirstX:* = param1;
            var a_FirstY:* = param2;
            var a_FirstZ:* = param3;
            var a_FirstTypeID:* = param4;
            var a_FirstPositionOrData:* = param5;
            var a_SndX:* = param6;
            var a_SndY:* = param7;
            var a_SndZ:* = param8;
            var a_SndTypeID:* = param9;
            var a_SndPosition:* = param10;
            try
            {
                if (a_FirstX != 65535 || a_SndX != 65535)
                {
                    this.m_Player.stopAutowalk(false);
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CUSETWOOBJECTS);
                b.writeShort(a_FirstX);
                b.writeShort(a_FirstY);
                b.writeByte(a_FirstZ);
                b.writeShort(a_FirstTypeID);
                b.writeByte(a_FirstPositionOrData);
                b.writeShort(a_SndX);
                b.writeShort(a_SndY);
                b.writeByte(a_SndZ);
                b.writeShort(a_SndTypeID);
                b.writeByte(a_SndPosition);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CUSETWOOBJECTS, e);
            }
            return;
        }// end function

        protected function readFloor(param1:ByteArray, param2:int, param3:int = 0) : int
        {
            var _loc_10:* = 0;
            if (param1 == null)
            {
                throw new Error("Connection.readFloor: Not enough data.", 2147483617);
            }
            if (param2 < 0 || param2 >= MAPSIZE_Z)
            {
                throw new Error("Connection.readFloor: Floor number out of range.", 2147483616);
            }
            var _loc_4:* = param3;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = new Vector3D();
            var _loc_8:* = new Vector3D();
            var _loc_9:* = 0;
            while (_loc_9 <= (MAPSIZE_X - 1))
            {
                
                _loc_10 = 0;
                while (_loc_10 <= (MAPSIZE_Y - 1))
                {
                    
                    if (_loc_4 > 0)
                    {
                        _loc_4 = _loc_4 - 1;
                    }
                    else
                    {
                        _loc_4 = this.readField(param1, _loc_9, _loc_10, param2);
                    }
                    _loc_7.setComponents(_loc_9, _loc_10, param2);
                    this.m_WorldMapStorage.toAbsolute(_loc_7, _loc_8);
                    if (_loc_8.z == this.m_MiniMapStorage.getPositionZ())
                    {
                        this.m_WorldMapStorage.updateMiniMap(_loc_9, _loc_10, param2);
                        _loc_5 = this.m_WorldMapStorage.getMiniMapColour(_loc_9, _loc_10, param2);
                        _loc_6 = this.m_WorldMapStorage.getMiniMapCost(_loc_9, _loc_10, param2);
                        this.m_MiniMapStorage.updateField(_loc_8.x, _loc_8.y, _loc_8.z, _loc_5, _loc_6, false);
                    }
                    _loc_10++;
                }
                _loc_9++;
            }
            return _loc_4;
        }// end function

        private function handleSendError(param1:int, param2:Error) : void
        {
            var _loc_3:* = param2 != null ? (param2.errorID) : (-1);
            this.handleConnectionError(512 + param1, _loc_3, param2);
            return;
        }// end function

        protected function readMarketOffer(param1:ByteArray, param2:int, param3:int) : Offer
        {
            var _loc_4:* = param1.readUnsignedInt();
            var _loc_5:* = param1.readUnsignedShort();
            var _loc_6:* = 0;
            switch(param3)
            {
                case MarketWidget.REQUEST_OWN_OFFERS:
                case MarketWidget.REQUEST_OWN_HISTORY:
                {
                    _loc_6 = param1.readUnsignedShort();
                    break;
                }
                default:
                {
                    _loc_6 = param3;
                    break;
                    break;
                }
            }
            var _loc_7:* = param1.readUnsignedShort();
            var _loc_8:* = param1.readUnsignedInt();
            var _loc_9:* = null;
            var _loc_10:* = Offer.ACTIVE;
            switch(param3)
            {
                case MarketWidget.REQUEST_OWN_OFFERS:
                {
                    break;
                }
                case MarketWidget.REQUEST_OWN_HISTORY:
                {
                    _loc_10 = param1.readUnsignedByte();
                    break;
                }
                default:
                {
                    _loc_9 = StringHelper.s_ReadLongStringFromByteArray(param1);
                    break;
                    break;
                }
            }
            return new Offer(new OfferID(_loc_4, _loc_5), param2, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10);
        }// end function

        public function dispose() : void
        {
            this.m_ServerConnection = null;
            return;
        }// end function

        protected function readSPENDINGSTATEENTERED(param1:ByteArray) : void
        {
            this.m_ServerConnection.setConnectionState(CONNECTION_STATE_PENDING);
            return;
        }// end function

        public function sendStatementCRULEVIOLATIONREPORT(param1:int, param2:String, param3:String, param4:String, param5:int) : void
        {
            var b:ByteArray;
            var a_Reason:* = param1;
            var a_CharacterName:* = param2;
            var a_Comment:* = param3;
            var a_Translation:* = param4;
            var a_StatementID:* = param5;
            try
            {
                if (a_Translation == null)
                {
                    a_Translation;
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CRULEVIOLATIONREPORT);
                b.writeByte(Type.REPORT_STATEMENT);
                b.writeByte(a_Reason);
                StringHelper.s_WriteToByteArray(b, a_CharacterName, Creature.MAX_NAME_LENGHT);
                StringHelper.s_WriteToByteArray(b, a_Comment, ReportWidget.MAX_COMMENT_LENGTH);
                StringHelper.s_WriteToByteArray(b, a_Translation, ReportWidget.MAX_TRANSLATION_LENGTH);
                b.writeUnsignedInt(a_StatementID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CRULEVIOLATIONREPORT, e);
            }
            return;
        }// end function

        protected function readSEDITLIST(param1:ByteArray) : void
        {
            var _loc_2:* = new EditListWidget();
            _loc_2.type = param1.readUnsignedByte();
            _loc_2.ID = param1.readUnsignedInt();
            _loc_2.text = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_2.show();
            return;
        }// end function

        public function sendCINVITETOPARTY(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CINVITETOPARTY);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CINVITETOPARTY, e);
            }
            return;
        }// end function

        protected function readSTOPROW(param1:ByteArray) : void
        {
            var _loc_2:* = this.m_WorldMapStorage.getPosition();
            var _loc_3:* = _loc_2;
            var _loc_4:* = _loc_2.y - 1;
            _loc_3.y = _loc_4;
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_WorldMapStorage.scrollMap(0, 1);
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            this.readArea(param1, 0, 0, (MAPSIZE_X - 1), 0);
            return;
        }// end function

        protected function readObjectInstance(param1:ByteArray, param2:int = -1) : ObjectInstance
        {
            var _loc_5:* = 0;
            if (param1 == null || param2 == -1 && param1.bytesAvailable < 2)
            {
                throw new Error("Connection.readObjectInstance: Not enough data.", 2147483628);
            }
            if (param2 == -1)
            {
                param2 = param1.readUnsignedShort();
            }
            if (param2 == 0)
            {
                return null;
            }
            if (param2 <= AppearanceInstance.CREATURE)
            {
                throw new Error("Connection.readObjectInstance: Invalid type.", 2147483627);
            }
            var _loc_3:* = this.m_AppearanceStorage.createObjectInstance(param2, 0);
            var _loc_4:* = param1.readUnsignedByte();
            _loc_3.marks.setMark(Marks.MARK_TYPE_PERMANENT, _loc_4);
            if (_loc_3 == null || _loc_3.m_Type == null)
            {
                throw new Error("Connection.readObjectInstance: Invalid instance.", 2147483626);
            }
            if (_loc_3.m_Type.isLiquidContainer || _loc_3.m_Type.isLiquidPool || _loc_3.m_Type.isCumulative)
            {
                _loc_3.data = param1.readUnsignedByte();
            }
            if (_loc_3.m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].isAnimation)
            {
                _loc_5 = param1.readUnsignedByte();
                if (_loc_5 == 0)
                {
                    _loc_3.phase = AppearanceAnimator.PHASE_AUTOMATIC;
                }
                else
                {
                    _loc_3.phase = _loc_5;
                }
            }
            return _loc_3;
        }// end function

        protected function readUnsigned64BitValue(param1:ByteArray) : Number
        {
            var _loc_2:* = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedInt();
            if ((_loc_3 & 4292870144) != 0)
            {
                throw new RangeError("Connection.readUnsigned64BitValue: Value out of range.");
            }
            return Number(_loc_2) + Number(_loc_3 & 2097151) * Math.pow(2, 32);
        }// end function

        protected function readSSNAPBACK(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = param1.readUnsignedByte();
            _loc_3 = this.m_Player.position;
            if (_loc_3.equals(this.m_LastSnapback))
            {
                var _loc_4:* = this;
                var _loc_5:* = this.m_SnapbackCount + 1;
                _loc_4.m_SnapbackCount = _loc_5;
            }
            else
            {
                this.m_SnapbackCount = 0;
            }
            this.m_LastSnapback.setVector(_loc_3);
            if (this.m_SnapbackCount >= 16)
            {
                this.m_Player.stopAutowalk(true);
                this.m_CreatureStorage.setAttackTarget(null, false);
                this.sendCCANCEL();
                this.m_SnapbackCount = 0;
            }
            this.m_Player.abortAutowalk(_loc_2);
            return;
        }// end function

        protected function readSTRAPPERS(param1:ByteArray) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = param1.readUnsignedByte();
            if (_loc_2 > NUM_TRAPPERS)
            {
                throw new Error("Connection.readSTRAPPERS: Too many trappers.", 0);
            }
            var _loc_3:* = new Vector.<Creature>;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1.readUnsignedInt();
                _loc_6 = this.m_CreatureStorage.getCreature(_loc_5);
                if (_loc_6 == null)
                {
                }
                _loc_3.push(_loc_6);
                _loc_4++;
            }
            this.m_CreatureStorage.setTrappers(_loc_3);
            return;
        }// end function

        protected function readSFULLMAP(param1:ByteArray) : void
        {
            var _loc_2:* = this.readCoordinate(param1);
            this.m_Player.stopAutowalk(true);
            this.m_CreatureStorage.markAllOpponentsVisible(false);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_WorldMapStorage.resetMap();
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.readArea(param1, 0, 0, (MAPSIZE_X - 1), (MAPSIZE_Y - 1));
            this.m_WorldMapStorage.valid = true;
            return;
        }// end function

        protected function readSLEFTROW(param1:ByteArray) : void
        {
            var _loc_2:* = this.m_WorldMapStorage.getPosition();
            var _loc_3:* = _loc_2;
            var _loc_4:* = _loc_2.x - 1;
            _loc_3.x = _loc_4;
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_WorldMapStorage.scrollMap(1, 0);
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            this.readArea(param1, 0, 0, 0, (MAPSIZE_Y - 1));
            return;
        }// end function

        public function sendCSTOP() : void
        {
            var b:ByteArray;
            try
            {
                this.m_CreatureStorage.clearTargets();
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSTOP);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSTOP, e);
            }
            return;
        }// end function

        protected function readSPREMIUMTRIGGER(param1:ByteArray) : void
        {
            var _loc_2:* = new Vector.<uint>;
            var _loc_3:* = param1.readUnsignedByte() - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_2.push(param1.readUnsignedByte());
                _loc_3 = _loc_3 - 1;
            }
            Tibia.s_GetPremiumManager().updatePremiumMessages(_loc_2);
            return;
        }// end function

        protected function readSTRANSACTIONHISTORY(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            _loc_2 = param1.readUnsignedInt();
            _loc_3 = param1.readUnsignedInt();
            _loc_4 = param1.readUnsignedByte();
            _loc_5 = new Vector.<IngameShopHistoryEntry>;
            _loc_6 = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = param1.readUnsignedInt();
                _loc_8 = param1.readUnsignedByte();
                _loc_9 = param1.readInt();
                _loc_10 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_5.push(new IngameShopHistoryEntry(_loc_7, _loc_9, _loc_8, _loc_10));
                _loc_6++;
            }
            IngameShopManager.getInstance().setHistory(_loc_2, _loc_3, _loc_5);
            return;
        }// end function

        protected function readSCREATUREHEALTH(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null && _loc_4.ID != this.m_Player.ID)
            {
                _loc_4.setSkillValue(SKILL_HITPOINTS_PERCENT, _loc_3);
            }
            else if (_loc_4 == null)
            {
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        protected function readSCLOSECONTAINER(param1:ByteArray) : void
        {
            this.m_ContainerStorage.closeContainerView(param1.readUnsignedByte());
            return;
        }// end function

        public function sendCGETOBJECTINFO(... args) : void
        {
            args = new activation;
            var b:ByteArray;
            var v:Vector.<AppearanceTypeRef>;
            var i:int;
            var n:int;
            var a_Parameters:* = args;
            try
            {
                b;
                if (this.length == 1 && this[0] is Vector.<AppearanceTypeRef>)
                {
                    v = this[0] as Vector.<AppearanceTypeRef>;
                    i;
                    n = Math.min(this.length, 255);
                    if ( > 0)
                    {
                        b = this.m_ServerConnection.messageWriter.createMessage();
                        this.writeByte(CGETOBJECTINFO);
                        this.writeByte();
                        i;
                        while ( < )
                        {
                            
                            this.writeShort(this[].ID);
                            this.writeByte(this[].data);
                            i = ( + 1);
                        }
                        this.m_ServerConnection.messageWriter.finishMessage();
                    }
                }
                else if (this.length == 2)
                {
                    b = this.m_ServerConnection.messageWriter.createMessage();
                    this.writeByte(CGETOBJECTINFO);
                    this.writeByte(1);
                    this.writeShort(int(this[]));
                    this.writeByte(int(this[]));
                    this.m_ServerConnection.messageWriter.finishMessage();
                }
                else
                {
                    throw new Error("Connection.sendCGETOBJECTINFO: Illegal overload.", 0);
                }
            }
            catch (e:Error)
            {
                handleSendError(CGETOBJECTINFO, e);
            }
            return;
        }// end function

        public function sendCSEEKINCONTAINER(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            var a_Index:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSEEKINCONTAINER);
                b.writeByte(a_ID);
                b.writeShort(a_Index);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSEEKINCONTAINER, e);
            }
            return;
        }// end function

        public function sendCMOVEOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int) : void
        {
            var b:ByteArray;
            var a_StartX:* = param1;
            var a_StartY:* = param2;
            var a_StartZ:* = param3;
            var a_TypeID:* = param4;
            var a_Position:* = param5;
            var a_DestX:* = param6;
            var a_DestY:* = param7;
            var a_DestZ:* = param8;
            var a_Amount:* = param9;
            try
            {
                if (a_StartX != 65535)
                {
                    this.m_Player.stopAutowalk(false);
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMOVEOBJECT);
                b.writeShort(a_StartX);
                b.writeShort(a_StartY);
                b.writeByte(a_StartZ);
                b.writeShort(a_TypeID);
                b.writeByte(a_Position);
                b.writeShort(a_DestX);
                b.writeShort(a_DestY);
                b.writeByte(a_DestZ);
                b.writeByte(a_Amount);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMOVEOBJECT, e);
            }
            return;
        }// end function

        protected function readSCHANNELS(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            _loc_2 = new ArrayCollection();
            _loc_3 = param1.readUnsignedByte();
            while (_loc_3 > 0)
            {
                
                _loc_2.addItem({ID:param1.readUnsignedShort(), name:StringHelper.s_ReadLongStringFromByteArray(param1, Channel.MAX_NAME_LENGTH)});
                _loc_3 = _loc_3 - 1;
            }
            _loc_2.addItem({ID:ChatStorage.NPC_CHANNEL_ID, name:ChatStorage.NPC_CHANNEL_LABEL});
            _loc_4 = new ChannelSelectionWidget();
            _loc_4.channels = _loc_2;
            _loc_4.show();
            return;
        }// end function

        protected function readSSPELLGROUPDELAY(param1:ByteArray) : void
        {
            this.m_SpellStorage.setSpellGroupDelay(param1.readUnsignedByte(), param1.readUnsignedInt());
            return;
        }// end function

        public function sendCSTOREEVENT(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var a_StoreEventType:* = param1;
            var a_OfferID:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSTOREEVENT);
                switch(a_StoreEventType)
                {
                    case IngameShopManager.STORE_EVENT_SELECT_OFFER:
                    {
                        b.writeByte(a_StoreEventType);
                        b.writeUnsignedInt(a_OfferID);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSTOREEVENT, e);
            }
            return;
        }// end function

        protected function readSMARKETLEAVE(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            _loc_2 = PopUpBase.getCurrent() as MarketWidget;
            if (_loc_2 != null)
            {
                _loc_2.hide(true);
            }
            return;
        }// end function

        protected function readCreatureOutfit(param1:ByteArray, param2:AppearanceInstance) : AppearanceInstance
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (param1 == null || param1.bytesAvailable < 4)
            {
                throw new Error("Connection.readCreatureOutfit: Not enough data.", 2147483620);
            }
            var _loc_3:* = param1.readUnsignedShort();
            if (_loc_3 != 0)
            {
                _loc_4 = param1.readUnsignedByte();
                _loc_5 = param1.readUnsignedByte();
                _loc_6 = param1.readUnsignedByte();
                _loc_7 = param1.readUnsignedByte();
                _loc_8 = param1.readUnsignedByte();
                if (param2 is OutfitInstance && param2.ID == _loc_3)
                {
                    OutfitInstance(param2).updateProperties(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8);
                    return param2;
                }
                return this.m_AppearanceStorage.createOutfitInstance(_loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8);
            }
            else
            {
                _loc_9 = param1.readUnsignedShort();
                if (param2 is ObjectInstance && param2.ID == _loc_9)
                {
                    return param2;
                }
                if (_loc_9 == 0)
                {
                    return this.m_AppearanceStorage.createOutfitInstance(OutfitInstance.INVISIBLE_OUTFIT_ID, 0, 0, 0, 0, 0);
                }
                return this.m_AppearanceStorage.createObjectInstance(_loc_9, 0);
            }
        }// end function

        public function sendCJOINAGGRESSION(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CJOINAGGRESSION);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CJOINAGGRESSION, e);
            }
            return;
        }// end function

        public function sendCREVOKEINVITATION(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CREVOKEINVITATION);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CREVOKEINVITATION, e);
            }
            return;
        }// end function

        protected function readSTOPFLOOR(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            _loc_2 = this.m_WorldMapStorage.getPosition();
            var _loc_10:* = _loc_2;
            var _loc_11:* = _loc_2.x + 1;
            _loc_10.x = _loc_11;
            var _loc_10:* = _loc_2;
            var _loc_11:* = _loc_2.y + 1;
            _loc_10.y = _loc_11;
            var _loc_10:* = _loc_2;
            var _loc_11:* = _loc_2.z - 1;
            _loc_10.z = _loc_11;
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            if (_loc_2.z > GROUND_LAYER)
            {
                this.m_WorldMapStorage.scrollMap(0, 0, -1);
                this.readFloor(param1, 2 * UNDERGROUND_LAYER, 0);
            }
            else if (_loc_2.z == GROUND_LAYER)
            {
                this.m_WorldMapStorage.scrollMap(0, 0, -(UNDERGROUND_LAYER + 1));
                _loc_7 = 0;
                _loc_8 = UNDERGROUND_LAYER;
                while (_loc_8 <= GROUND_LAYER)
                {
                    
                    _loc_7 = this.readFloor(param1, _loc_8, _loc_7);
                    _loc_8++;
                }
            }
            this.m_Player.stopAutowalk(true);
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            _loc_3 = this.m_WorldMapStorage.toMap(_loc_2);
            _loc_4 = 0;
            _loc_5 = 0;
            _loc_6 = 0;
            while (_loc_6 < MAPSIZE_X)
            {
                
                _loc_9 = 0;
                while (_loc_9 < MAPSIZE_Y)
                {
                    
                    _loc_3.x = _loc_6;
                    _loc_3.y = _loc_9;
                    _loc_2 = this.m_WorldMapStorage.toAbsolute(_loc_3, _loc_2);
                    this.m_WorldMapStorage.updateMiniMap(_loc_3.x, _loc_3.y, _loc_3.z);
                    _loc_4 = this.m_WorldMapStorage.getMiniMapColour(_loc_3.x, _loc_3.y, _loc_3.z);
                    _loc_5 = this.m_WorldMapStorage.getMiniMapCost(_loc_3.x, _loc_3.y, _loc_3.z);
                    this.m_MiniMapStorage.updateField(_loc_2.x, _loc_2.y, _loc_2.z, _loc_4, _loc_5, false);
                    _loc_9++;
                }
                _loc_6++;
            }
            return;
        }// end function

        protected function readSPLAYERINVENTORY(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_2 = new Vector.<InventoryTypeInfo>;
            _loc_3 = param1.readUnsignedShort() - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = param1.readUnsignedByte();
                _loc_6 = param1.readUnsignedShort();
                _loc_2.push(new InventoryTypeInfo(_loc_4, _loc_5, _loc_6));
                _loc_3 = _loc_3 - 1;
            }
            this.m_ContainerStorage.setPlayerInventory(_loc_2);
            return;
        }// end function

        protected function readSMARKETENTER(param1:ByteArray) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            _loc_2 = this.readSigned64BitValue(param1);
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = [];
            _loc_5 = param1.readUnsignedShort() - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_7 = param1.readUnsignedShort();
                _loc_8 = param1.readUnsignedShort();
                _loc_4.push(new InventoryTypeInfo(_loc_7, 0, _loc_8));
                _loc_5 = _loc_5 - 1;
            }
            _loc_6 = PopUpBase.getCurrent() as MarketWidget;
            if (_loc_6 == null)
            {
                _loc_6 = new MarketWidget();
                _loc_6.show();
            }
            _loc_6.serverResponsePending = false;
            _loc_6.accountBalance = _loc_2;
            _loc_6.activeOffers = _loc_3;
            _loc_6.depotContent = _loc_4;
            return;
        }// end function

        protected function readSPLAYERSKILLS(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_2 = 0;
            _loc_3 = 0;
            _loc_4 = 0;
            _loc_5 = 0;
            _loc_6 = [SKILL_FIGHTFIST, SKILL_FIGHTCLUB, SKILL_FIGHTSWORD, SKILL_FIGHTAXE, SKILL_FIGHTDISTANCE, SKILL_FIGHTSHIELD, SKILL_FISHING];
            _loc_7 = [SKILL_CRITICAL_HIT_CHANCE, SKILL_CRITICAL_HIT_DAMAGE, SKILL_LIFE_LEECH_CHANCE, SKILL_LIFE_LEECH_AMOUNT, SKILL_MANA_LEECH_CHANCE, SKILL_MANA_LEECH_AMOUNT];
            for each (_loc_2 in _loc_6)
            {
                
                _loc_3 = param1.readUnsignedShort();
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = param1.readUnsignedByte();
                this.m_Player.setSkill(_loc_2, _loc_3, _loc_4, _loc_5);
            }
            for each (_loc_2 in _loc_7)
            {
                
                _loc_3 = param1.readUnsignedShort();
                _loc_4 = param1.readUnsignedShort();
                this.m_Player.setSkill(_loc_2, _loc_3, _loc_4, 0);
            }
            return;
        }// end function

        protected function readSSTOREBUTTONINDICATORS(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readBoolean();
            var _loc_3:* = param1.readBoolean();
            return;
        }// end function

        protected function readSPVPSITUATIONS(param1:ByteArray) : void
        {
            this.m_Player.openPvpSituations = param1.readUnsignedByte();
            return;
        }// end function

        public function sendCEDITLIST(param1:int, param2:int, param3:String) : void
        {
            var b:ByteArray;
            var a_Type:* = param1;
            var a_ID:* = param2;
            var a_Text:* = param3;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CEDITLIST);
                b.writeByte(a_Type);
                b.writeUnsignedInt(a_ID);
                StringHelper.s_WriteToByteArray(b, a_Text);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CEDITLIST, e);
            }
            return;
        }// end function

        protected function readSCLEARTARGET(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = param1.readUnsignedInt();
            _loc_3 = null;
            var _loc_4:* = this.m_CreatureStorage.getAttackTarget();
            _loc_3 = this.m_CreatureStorage.getAttackTarget();
            if (_loc_4 != null && _loc_2 == _loc_3.ID)
            {
                this.m_CreatureStorage.setAttackTarget(null, false);
            }
            else
            {
                var _loc_4:* = this.m_CreatureStorage.getFollowTarget();
                _loc_3 = this.m_CreatureStorage.getFollowTarget();
                if (_loc_4 != null && _loc_2 == _loc_3.ID)
                {
                    this.m_CreatureStorage.setFollowTarget(null, false);
                }
            }
            return;
        }// end function

        public function sendCREJECTTRADE() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CREJECTTRADE);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CREJECTTRADE, e);
            }
            return;
        }// end function

        public function sendCGETCHANNELS() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CGETCHANNELS);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CGETCHANNELS, e);
            }
            return;
        }// end function

        protected function readSWAIT(param1:ByteArray) : void
        {
            this.m_Player.earliestMoveTime = this.m_Player.earliestMoveTime + param1.readUnsignedShort();
            return;
        }// end function

        protected function readSBUDDYDATA(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            _loc_2 = param1.readUnsignedInt();
            _loc_3 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
            _loc_4 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_DESCRIPTION_LENGHT);
            _loc_5 = param1.readUnsignedInt();
            _loc_6 = param1.readBoolean();
            _loc_7 = param1.readByte();
            _loc_8 = Tibia.s_GetOptions();
            _loc_9 = null;
            var _loc_10:* = _loc_8.getBuddySet(BuddySet.DEFAULT_SET);
            _loc_9 = _loc_8.getBuddySet(BuddySet.DEFAULT_SET);
            if (_loc_8 != null && _loc_10 != null)
            {
                _loc_9.updateBuddy(_loc_2, _loc_3, _loc_4, _loc_5, _loc_6, _loc_7);
            }
            return;
        }// end function

        protected function readSDELETEINCONTAINER(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedByte();
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = this.readObjectInstance(param1);
            var _loc_5:* = this.m_ContainerStorage.getContainerView(_loc_2);
            if (this.m_ContainerStorage.getContainerView(_loc_2) != null)
            {
                _loc_5.removeObject(_loc_3, _loc_4);
            }
            return;
        }// end function

        protected function readSLOGINSUCCESS(param1:ByteArray) : void
        {
            this.m_Player.ID = param1.readUnsignedInt();
            this.m_BeatDuration = param1.readUnsignedShort();
            Creature.speedA = this.readDouble(param1);
            Creature.speedB = this.readDouble(param1);
            Creature.speedC = this.readDouble(param1);
            this.m_BugreportsAllowed = param1.readUnsignedByte() == 1;
            var _loc_2:* = Tibia.s_GetOptions();
            _loc_2.uiHints.canChangePvPFramingOption = param1.readUnsignedByte() == 1;
            _loc_2.uiHints.expertModeButtonEnabled = param1.readUnsignedByte() == 1;
            var _loc_3:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            var _loc_4:* = param1.readUnsignedShort();
            IngameShopManager.getInstance().setupWithServerSettings(_loc_3, _loc_4);
            return;
        }// end function

        public function sendCTOGGLEWRAPSTATE(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            var a_TypeID:* = param4;
            var a_Position:* = param5;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CTOGGLEWRAPSTATE);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                b.writeShort(a_TypeID);
                b.writeByte(a_Position);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CTURNOBJECT, e);
            }
            return;
        }// end function

        public function sendBotCRULEVIOLATIONREPORT(param1:int, param2:String, param3:String) : void
        {
            var b:ByteArray;
            var a_Reason:* = param1;
            var a_CharacterName:* = param2;
            var a_Comment:* = param3;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CRULEVIOLATIONREPORT);
                b.writeByte(Type.REPORT_BOT);
                b.writeByte(a_Reason);
                StringHelper.s_WriteToByteArray(b, a_CharacterName, Creature.MAX_NAME_LENGHT);
                StringHelper.s_WriteToByteArray(b, a_Comment, ReportWidget.MAX_COMMENT_LENGTH);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CRULEVIOLATIONREPORT, e);
            }
            return;
        }// end function

        public function sendCGETQUESTLINE(param1:int) : void
        {
            var b:ByteArray;
            var a_QuestLine:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CGETQUESTLINE);
                b.writeShort(a_QuestLine);
                this.m_ServerConnection.messageWriter.finishMessage();
                this.m_PendingQuestLine = a_QuestLine;
            }
            catch (e:Error)
            {
                handleSendError(CGETQUESTLINE, e);
            }
            return;
        }// end function

        protected function readSAUTOMAPFLAG(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = param1.readUnsignedShort();
            _loc_4 = param1.readUnsignedByte();
            _loc_5 = param1.readUnsignedByte();
            _loc_6 = StringHelper.s_ReadLongStringFromByteArray(param1);
            this.m_MiniMapStorage.setMark(_loc_2, _loc_3, _loc_4, _loc_5, _loc_6);
            this.m_MiniMapStorage.highlightMarks();
            return;
        }// end function

        public function sendCJOINPARTY(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CJOINPARTY);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CJOINPARTY, e);
            }
            return;
        }// end function

        private function handleConnectionError(param1:int, param2:int = 0, param3:Object = null) : void
        {
            this.m_ServerConnection.disconnect(false);
            var _loc_4:* = null;
            switch(param1)
            {
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
            this.m_ServerConnection.dispatchEvent(_loc_5);
            return;
        }// end function

        protected function readSCREATEINCONTAINER(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedByte();
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = this.readObjectInstance(param1);
            var _loc_5:* = this.m_ContainerStorage.getContainerView(_loc_2);
            if (this.m_ContainerStorage.getContainerView(_loc_2) != null)
            {
                _loc_5.addObject(_loc_3, _loc_4);
            }
            return;
        }// end function

        public function sendCLEAVEPARTY() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CLEAVEPARTY);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CLEAVEPARTY, e);
            }
            return;
        }// end function

        protected function readSPLAYERSTATE(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedShort();
            this.m_Player.stateFlags = _loc_2;
            return;
        }// end function

        protected function readSDELETEONMAP(param1:ByteArray) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (_loc_2 != 65535)
            {
                _loc_5 = this.readCoordinate(param1, _loc_2);
                if (!this.m_WorldMapStorage.isVisible(_loc_5.x, _loc_5.y, _loc_5.z, true))
                {
                    throw new Error("Connection.readSDELETEONMAP: Co-ordinate " + _loc_5 + " is out of range.", 0);
                }
                _loc_6 = this.m_WorldMapStorage.toMap(_loc_5);
                _loc_4 = param1.readUnsignedByte();
                var _loc_11:* = this.m_WorldMapStorage.getObject(_loc_6.x, _loc_6.y, _loc_6.z, _loc_4);
                _loc_7 = this.m_WorldMapStorage.getObject(_loc_6.x, _loc_6.y, _loc_6.z, _loc_4);
                if (_loc_11 == null)
                {
                    throw new Error("Connection.readSDELETEONMAP: Object not found.", 1);
                }
                var _loc_11:* = this.m_CreatureStorage.getCreature(_loc_7.data);
                _loc_8 = this.m_CreatureStorage.getCreature(_loc_7.data);
                if (_loc_7.ID == AppearanceInstance.CREATURE && _loc_11 == null)
                {
                    throw new Error("Connection.readSDELETEONMAP: Creature not found: " + _loc_7.data, 2);
                }
                this.m_WorldMapStorage.deleteObject(_loc_6.x, _loc_6.y, _loc_6.z, _loc_4);
            }
            else
            {
                _loc_3 = param1.readUnsignedInt();
                var _loc_11:* = this.m_CreatureStorage.getCreature(_loc_3);
                _loc_8 = this.m_CreatureStorage.getCreature(_loc_3);
                if (_loc_11 == null)
                {
                    throw new Error("Connection.readSDELETEONMAP: Creature not found: " + _loc_3, 3);
                }
                _loc_5 = _loc_8.position;
                if (!this.m_WorldMapStorage.isVisible(_loc_5.x, _loc_5.y, _loc_5.z, true))
                {
                    throw new Error("Connection.readSDELETEONMAP: Co-ordinate " + _loc_5 + " is out of range.", 4);
                }
                _loc_6 = this.m_WorldMapStorage.toMap(_loc_5);
            }
            if (_loc_8 != null)
            {
                this.m_CreatureStorage.markOpponentVisible(_loc_8, false);
            }
            if (_loc_5.z == this.m_MiniMapStorage.getPositionZ())
            {
                this.m_WorldMapStorage.updateMiniMap(_loc_6.x, _loc_6.y, _loc_6.z);
                _loc_9 = this.m_WorldMapStorage.getMiniMapColour(_loc_6.x, _loc_6.y, _loc_6.z);
                _loc_10 = this.m_WorldMapStorage.getMiniMapCost(_loc_6.x, _loc_6.y, _loc_6.z);
                this.m_MiniMapStorage.updateField(_loc_5.x, _loc_5.y, _loc_5.z, _loc_9, _loc_10, false);
            }
            return;
        }// end function

        public function sendCROTATESOUTH() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CROTATESOUTH);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CROTATESOUTH, e);
            }
            return;
        }// end function

        protected function readSNPCOFFER(param1:ByteArray) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            var _loc_3:* = new ArrayCollection();
            var _loc_4:* = new ArrayCollection();
            var _loc_5:* = param1.readUnsignedShort();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_9 = param1.readUnsignedShort();
                _loc_10 = param1.readUnsignedByte();
                _loc_11 = StringHelper.s_ReadLongStringFromByteArray(param1, NPCTradeWidget.MAX_WARE_NAME_LENGTH);
                _loc_12 = param1.readUnsignedInt();
                _loc_13 = param1.readUnsignedInt();
                _loc_14 = param1.readUnsignedInt();
                if (_loc_13 > 0)
                {
                    _loc_3.addItem(new TradeObjectRef(_loc_9, _loc_10, _loc_11, _loc_13, _loc_12));
                }
                if (_loc_14 > 0)
                {
                    _loc_4.addItem(new TradeObjectRef(_loc_9, _loc_10, _loc_11, _loc_14, _loc_12));
                }
                _loc_6++;
            }
            var _loc_7:* = Tibia.s_GetOptions();
            var _loc_8:* = null;
            var _loc_16:* = _loc_7.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_8 = _loc_7.getSideBarSet(SideBarSet.DEFAULT_SET);
            if (_loc_7 != null && _loc_16 != null)
            {
                _loc_15 = _loc_8.getWidgetByType(Widget.TYPE_NPCTRADE) as NPCTradeWidget;
                if (_loc_15 == null)
                {
                    _loc_15 = _loc_8.showWidgetType(Widget.TYPE_NPCTRADE, -1, -1) as NPCTradeWidget;
                }
                _loc_15.npcName = _loc_2;
                _loc_15.buyObjects = _loc_3;
                _loc_15.sellObjects = _loc_4;
                _loc_15.categories = null;
            }
            return;
        }// end function

        public function sendCPRIVATECHANNEL(param1:String) : void
        {
            var b:ByteArray;
            var a_Name:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CPRIVATECHANNEL);
                StringHelper.s_WriteToByteArray(b, a_Name, Creature.MAX_NAME_LENGHT);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPRIVATECHANNEL, e);
            }
            return;
        }// end function

        public function disconnect(param1:Boolean) : void
        {
            if ((this.m_ServerConnection.isGameRunning || this.m_ServerConnection.isPending) && !param1)
            {
                this.sendCQUITGAME();
            }
            else
            {
                this.m_ServerConnection.disconnect();
            }
            return;
        }// end function

        protected function readSCLOSENPCTRADE(param1:ByteArray) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            var _loc_5:* = _loc_3.getWidgetByType(Widget.TYPE_NPCTRADE) as NPCTradeWidget;
            _loc_4 = _loc_3.getWidgetByType(Widget.TYPE_NPCTRADE) as NPCTradeWidget;
            if (_loc_2 != null && _loc_5 != null && _loc_5 != null)
            {
                _loc_4.buyObjects = null;
                _loc_4.sellObjects = null;
                _loc_4.categories = null;
                _loc_3.hideWidgetType(Widget.TYPE_NPCTRADE, -1);
            }
            return;
        }// end function

        protected function readSSPELLDELAY(param1:ByteArray) : void
        {
            this.m_SpellStorage.setSpellDelay(param1.readUnsignedByte(), param1.readUnsignedInt());
            return;
        }// end function

        public function sendCACCEPTTRADE() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CACCEPTTRADE);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CACCEPTTRADE, e);
            }
            return;
        }// end function

        protected function readSFIELDDATA(param1:ByteArray) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = this.readCoordinate(param1);
            if (!this.m_WorldMapStorage.isVisible(_loc_2.x, _loc_2.y, _loc_2.z, true))
            {
                throw new Error("Connection.readSFIELDDATA: Co-ordinate " + _loc_2 + " is out of range.", 0);
            }
            var _loc_3:* = this.m_WorldMapStorage.toMap(_loc_2);
            this.m_WorldMapStorage.resetField(_loc_3.x, _loc_3.y, _loc_3.z, true, false);
            this.readField(param1, _loc_3.x, _loc_3.y, _loc_3.z);
            if (_loc_2.z == this.m_MiniMapStorage.getPositionZ())
            {
                this.m_WorldMapStorage.updateMiniMap(_loc_3.x, _loc_3.y, _loc_3.z);
                _loc_4 = this.m_WorldMapStorage.getMiniMapColour(_loc_3.x, _loc_3.y, _loc_3.z);
                _loc_5 = this.m_WorldMapStorage.getMiniMapCost(_loc_3.x, _loc_3.y, _loc_3.z);
                this.m_MiniMapStorage.updateField(_loc_2.x, _loc_2.y, _loc_2.z, _loc_4, _loc_5, false);
            }
            return;
        }// end function

        public function sendCBUYPREMIUMOFFER(param1:int, param2:int, ... args) : void
        {
            args = new activation;
            var b:ByteArray;
            var a_OfferID:* = param1;
            var a_ServiceType:* = param2;
            var a_Args:* = args;
            if ( == IngameShopProduct.SERVICE_TYPE_UNKNOWN && this.length > 0 ||  == IngameShopProduct.SERVICE_TYPE_CHARACTER_NAME_CHANGE && this.length != 1)
            {
                throw new ArgumentError("sendCBUYPREMIUMOFFER: Invalid parameter count for specified service " +  + ": " + this.length);
            }
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                this.writeByte(CBUYPREMIUMOFFER);
                this.writeUnsignedInt();
                this.writeByte();
                if ( == IngameShopProduct.SERVICE_TYPE_CHARACTER_NAME_CHANGE)
                {
                    StringHelper.s_WriteToByteArray(, this[0] as String);
                }
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CBUYPREMIUMOFFER, e);
            }
            return;
        }// end function

        public function sendCEQUIPOBJECT(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var a_TypeID:* = param1;
            var a_Data:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CEQUIPOBJECT);
                b.writeShort(a_TypeID);
                b.writeByte(a_Data);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CEQUIPOBJECT, e);
            }
            return;
        }// end function

        public function sendCTRANSFERCURRENCY(param1:String, param2:uint) : void
        {
            var b:ByteArray;
            var a_TargetCharacter:* = param1;
            var a_Amount:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CTRANSFERCURRENCY);
                StringHelper.s_WriteToByteArray(b, a_TargetCharacter);
                b.writeUnsignedInt(a_Amount);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CTRANSFERCURRENCY, e);
            }
            return;
        }// end function

        protected function readSRIGHTROW(param1:ByteArray) : void
        {
            var _loc_2:* = this.m_WorldMapStorage.getPosition();
            var _loc_3:* = _loc_2;
            var _loc_4:* = _loc_2.x + 1;
            _loc_3.x = _loc_4;
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_WorldMapStorage.scrollMap(-1, 0);
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            this.readArea(param1, (MAPSIZE_X - 1), 0, (MAPSIZE_X - 1), (MAPSIZE_Y - 1));
            return;
        }// end function

        public function sendCOPENCHANNEL() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(COPENCHANNEL);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(COPENCHANNEL, e);
            }
            return;
        }// end function

        protected function readSEDITTEXT(param1:ByteArray) : void
        {
            var _loc_2:* = new EditTextWidget();
            _loc_2.ID = param1.readUnsignedInt();
            var _loc_3:* = this.readObjectInstance(param1);
            _loc_2.object = new AppearanceTypeRef(_loc_3.ID, _loc_3.data);
            _loc_2.maxChars = param1.readUnsignedShort();
            _loc_2.text = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_2.author = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_2.date = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_2.show();
            return;
        }// end function

        private function handleReadError(param1:int, param2:Error) : void
        {
            var _loc_3:* = param2 != null ? (param2.errorID) : (-1);
            this.handleConnectionError(256 + param1, _loc_3, param2);
            return;
        }// end function

        public function sendCGETTRANSACTIONHISTORY(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var a_CurrentPage:* = param1;
            var a_EntriesPerPage:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CGETTRANSACTIONHISTORY);
                b.writeUnsignedInt(a_CurrentPage);
                b.writeByte(a_EntriesPerPage);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CGETTRANSACTIONHISTORY, e);
            }
            return;
        }// end function

        protected function readSBOTTOMROW(param1:ByteArray) : void
        {
            var _loc_2:* = this.m_WorldMapStorage.getPosition();
            var _loc_3:* = _loc_2;
            var _loc_4:* = _loc_2.y + 1;
            _loc_3.y = _loc_4;
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_WorldMapStorage.scrollMap(0, -1);
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            this.readArea(param1, 0, (MAPSIZE_Y - 1), (MAPSIZE_X - 1), (MAPSIZE_Y - 1));
            return;
        }// end function

        protected function readSDELETEINVENTORY(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedByte();
            var _loc_3:* = this.m_ContainerStorage.getBodyContainerView();
            if (_loc_3 != null)
            {
                _loc_3.setObject(_loc_2, null);
            }
            return;
        }// end function

        protected function readSSETTACTICS(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            _loc_2 = param1.readUnsignedByte();
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = param1.readUnsignedByte();
            _loc_5 = param1.readUnsignedByte();
            _loc_6 = Tibia.s_GetOptions();
            if (_loc_6 != null)
            {
                _loc_6.combatAttackMode = _loc_2;
                _loc_6.combatChaseMode = _loc_3;
                _loc_6.combatSecureMode = _loc_4;
                _loc_6.combatPVPMode = _loc_5;
            }
            return;
        }// end function

        protected function readSUSEDELAY(param1:ByteArray) : void
        {
            this.m_ContainerStorage.setMultiUseDelay(param1.readUnsignedInt());
            return;
        }// end function

        public function sendCLOOK(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            var a_TypeID:* = param4;
            var a_Position:* = param5;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CLOOK);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                b.writeShort(a_TypeID);
                b.writeByte(a_Position);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CLOOK, e);
            }
            return;
        }// end function

        protected function readSPRIVATECHANNEL(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            _loc_2 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
            this.m_ChatStorage.addChannel(_loc_2, _loc_2, MessageMode.MESSAGE_PRIVATE_TO);
            return;
        }// end function

        protected function readSINGAMESHOPERROR(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = param1.readUnsignedByte();
            _loc_3 = StringHelper.s_ReadLongStringFromByteArray(param1);
            IngameShopManager.getInstance().propagateError(_loc_3, _loc_2);
            return;
        }// end function

        protected function readSQUESTLINE(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = new Array();
            _loc_5 = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = StringHelper.s_ReadLongStringFromByteArray(param1, QuestFlag.MAX_NAME_LENGTH);
                _loc_7 = StringHelper.s_ReadLongStringFromByteArray(param1, QuestFlag.MAX_DESCRIPTION_LENGTH);
                _loc_4.push(new QuestFlag(_loc_6, _loc_7));
                _loc_5++;
            }
            if (this.m_PendingQuestLine == _loc_2)
            {
                _loc_8 = PopUpBase.getCurrent() as QuestLogWidget;
                if (_loc_8 != null)
                {
                    _loc_8.questFlags = _loc_4;
                }
                this.m_PendingQuestLine = -1;
            }
            return;
        }// end function

        protected function readSTUTORIALHINT(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = param1.readUnsignedByte();
            log("Connection.readSTUTORIALHINT: " + _loc_2);
            _loc_3 = new TutorialHint(_loc_2);
            _loc_3.perform();
            return;
        }// end function

        public function sendCTALK(param1:int, ... args) : void
        {
            args = new activation;
            var b:ByteArray;
            var a_Mode:* = param1;
            var a_Parameters:* = args;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                this.writeByte(CTALK);
                this.writeByte();
                if (this.length == 1 && this[0] is String)
                {
                    StringHelper.s_WriteToByteArray(, this[0] as String, ChatStorage.MAX_TALK_LENGTH);
                }
                else if (this.length == 2 && this[0] is String && this[1] is String)
                {
                    StringHelper.s_WriteToByteArray(, this[0] as String, Creature.MAX_NAME_LENGHT);
                    StringHelper.s_WriteToByteArray(, this[1] as String, ChatStorage.MAX_TALK_LENGTH);
                }
                else if (this.length == 2 && this[0] is Number && this[1] is String)
                {
                    this.writeShort(this[0] as Number);
                    StringHelper.s_WriteToByteArray(, this[1] as String, ChatStorage.MAX_TALK_LENGTH);
                }
                else
                {
                    throw new Error("Connection.sendCTALK: Invalid overloaded call.", 0);
                }
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CTALK, e);
            }
            return;
        }// end function

        public function sendCTRADEOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            var a_ObjectType:* = param4;
            var a_Position:* = param5;
            var a_TradePartner:* = param6;
            try
            {
                this.m_Player.stopAutowalk(false);
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CTRADEOBJECT);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                b.writeShort(a_ObjectType);
                b.writeByte(a_Position);
                b.writeUnsignedInt(a_TradePartner);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CTRADEOBJECT, e);
            }
            return;
        }// end function

        protected function readSCREATURESPEED(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_5.setSkill(SKILL_GOSTRENGTH, _loc_4, _loc_3, 0);
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCMARKETCANCEL(param1:Offer) : void
        {
            var b:ByteArray;
            var a_Offer:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMARKETCANCEL);
                b.writeUnsignedInt(a_Offer.offerID.timestamp);
                b.writeShort(a_Offer.offerID.counter);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMARKETCANCEL, e);
            }
            return;
        }// end function

        public function get allowBugreports() : Boolean
        {
            return this.m_BugreportsAllowed;
        }// end function

        public function sendCEDITTEXT(param1:int, param2:String) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            var a_Text:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CEDITTEXT);
                b.writeUnsignedInt(a_ID);
                StringHelper.s_WriteToByteArray(b, a_Text);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CEDITTEXT, e);
            }
            return;
        }// end function

        public function sendCEXCLUDEFROMCHANNEL(param1:String, param2:int) : void
        {
            var b:ByteArray;
            var a_Name:* = param1;
            var a_ChannelID:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CEXCLUDEFROMCHANNEL);
                StringHelper.s_WriteToByteArray(b, a_Name, Creature.MAX_NAME_LENGHT);
                b.writeShort(a_ChannelID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CEXCLUDEFROMCHANNEL, e);
            }
            return;
        }// end function

        public function sendCMARKETBROWSE(param1:int) : void
        {
            var b:ByteArray;
            var a_TypeID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMARKETBROWSE);
                b.writeShort(a_TypeID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMARKETBROWSE, e);
            }
            return;
        }// end function

        protected function readField(param1:ByteArray, param2:int, param3:int, param4:int) : int
        {
            var _loc_12:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = new Vector3D(param2, param3, param4);
            var _loc_7:* = this.m_WorldMapStorage.toAbsolute(_loc_6);
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            while (true)
            {
                
                _loc_12 = param1.readUnsignedShort();
                if (_loc_12 >= 65280)
                {
                    _loc_9 = _loc_12 - 65280;
                    break;
                }
                if (!_loc_5)
                {
                    _loc_10 = this.m_AppearanceStorage.createEnvironmentalEffect(_loc_12);
                    this.m_WorldMapStorage.setEnvironmentalEffect(param2, param3, param4, _loc_10);
                    _loc_5 = true;
                    continue;
                }
                if (_loc_12 == AppearanceInstance.UNKNOWNCREATURE || _loc_12 == AppearanceInstance.OUTDATEDCREATURE || _loc_12 == AppearanceInstance.CREATURE)
                {
                    _loc_11 = this.readCreatureInstance(param1, _loc_12, _loc_7);
                    _loc_10 = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE, _loc_11.ID);
                    if (_loc_8 < MAPSIZE_W)
                    {
                        this.m_WorldMapStorage.appendObject(param2, param3, param4, _loc_10);
                    }
                }
                else
                {
                    _loc_10 = this.readObjectInstance(param1, _loc_12);
                    if (_loc_8 < MAPSIZE_W)
                    {
                        this.m_WorldMapStorage.appendObject(param2, param3, param4, _loc_10);
                    }
                    else
                    {
                        throw new Error("Connection.readField: Expected creatures but received regular object.", 2147483618);
                    }
                }
                _loc_8++;
            }
            return _loc_9;
        }// end function

        protected function readDouble(param1:ByteArray) : Number
        {
            var _loc_2:* = param1.readUnsignedByte();
            var _loc_3:* = param1.readUnsignedInt();
            return (_loc_3 - int.MAX_VALUE) / Math.pow(10, _loc_2);
        }// end function

        public function sendCINSPECTTRADE(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var a_Side:* = param1;
            var a_Position:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CINSPECTTRADE);
                b.writeByte(a_Side);
                b.writeByte(a_Position);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CINSPECTTRADE, e);
            }
            return;
        }// end function

        public function messageProcessingFinished(param1:Boolean = true) : void
        {
            this.m_WorldMapStorage.refreshFields();
            if (param1)
            {
                this.m_MiniMapStorage.refreshSectors();
            }
            this.m_CreatureStorage.refreshOpponents();
            return;
        }// end function

        public function get isPending() : Boolean
        {
            return this.m_ServerConnection.isPending;
        }// end function

        protected function readSSWITCHPRESET(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedInt();
            var _loc_3:* = Tibia.s_GetOptions();
            if (_loc_3 != null)
            {
                switch(_loc_2)
                {
                    case PROFESSION_KNIGHT:
                    {
                        _loc_3.setMappingAndActionBarSets("Knight");
                        break;
                    }
                    case PROFESSION_PALADIN:
                    {
                        _loc_3.setMappingAndActionBarSets("Paladin");
                        break;
                    }
                    case PROFESSION_SORCERER:
                    {
                        _loc_3.setMappingAndActionBarSets("Sorcerer");
                        break;
                    }
                    case PROFESSION_DRUID:
                    {
                        _loc_3.setMappingAndActionBarSets("Druid");
                        break;
                    }
                    default:
                    {
                        throw new ArgumentError("readSSWITCHPRESET: Invalid preset id");
                        break;
                    }
                }
            }
            return;
        }// end function

        protected function readSigned64BitValue(param1:ByteArray) : Number
        {
            var _loc_2:* = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedInt();
            if ((_loc_3 & 2145386496) != 0)
            {
                throw new RangeError("Connection.readSigned64BitValue: Value out of range.");
            }
            var _loc_4:* = Number(_loc_2) + Number(_loc_3 & 2097151) * Math.pow(2, 32);
            if ((_loc_3 & 2147483648) != 0)
            {
                return -_loc_4;
            }
            return _loc_4;
        }// end function

        protected function readSPLAYERDATACURRENT(param1:ByteArray) : void
        {
            var _loc_2:* = Tibia.s_FrameTibiaTimestamp;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_3 = Math.max(0, param1.readShort());
            _loc_4 = Math.max(0, param1.readShort());
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_HITPOINTS, _loc_3, _loc_4, _loc_5);
            _loc_3 = Math.max(0, param1.readInt());
            _loc_4 = Math.max(0, param1.readInt());
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_CARRYSTRENGTH, _loc_3, _loc_4, _loc_5);
            _loc_3 = this.readSigned64BitValue(param1);
            _loc_4 = 1;
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_EXPERIENCE, _loc_3, _loc_4, _loc_5);
            _loc_3 = param1.readUnsignedShort();
            _loc_4 = 1;
            _loc_5 = param1.readUnsignedByte();
            this.m_Player.setSkill(SKILL_LEVEL, _loc_3, _loc_4, _loc_5);
            var _loc_6:* = param1.readUnsignedShort() / 100;
            var _loc_7:* = param1.readUnsignedShort() / 100;
            var _loc_8:* = param1.readUnsignedShort() / 100;
            var _loc_9:* = param1.readUnsignedShort() / 100;
            var _loc_10:* = param1.readUnsignedShort() / 100;
            this.m_Player.experienceGainInfo.updateGainInfo(_loc_6, _loc_7, _loc_8, _loc_9, _loc_10);
            _loc_3 = Math.max(0, param1.readShort());
            _loc_4 = Math.max(0, param1.readShort());
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_MANA, _loc_3, _loc_4, _loc_5);
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = param1.readUnsignedByte();
            _loc_5 = param1.readUnsignedByte();
            this.m_Player.setSkill(SKILL_MAGLEVEL, _loc_3, _loc_4, _loc_5);
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = 1;
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_SOULPOINTS, _loc_3, _loc_4, _loc_5);
            _loc_3 = _loc_2 + 60 * 1000 * param1.readUnsignedShort();
            _loc_4 = _loc_2;
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_STAMINA, _loc_3, _loc_4, _loc_5);
            _loc_3 = this.m_Player.getSkillValue(SKILL_GOSTRENGTH);
            _loc_4 = param1.readUnsignedShort();
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_GOSTRENGTH, _loc_3, _loc_4, _loc_5);
            _loc_3 = _loc_2 + 1000 * param1.readUnsignedShort();
            _loc_4 = _loc_2;
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_FED, _loc_3, _loc_4, _loc_5);
            _loc_3 = _loc_2 + 60 * 1000 * param1.readUnsignedShort();
            _loc_4 = _loc_2;
            _loc_5 = 0;
            this.m_Player.setSkill(SKILL_OFFLINETRAINING, _loc_3, _loc_4, _loc_5);
            var _loc_11:* = param1.readUnsignedShort();
            var _loc_12:* = param1.readBoolean();
            this.m_Player.experienceGainInfo.updateStoreXpBoost(_loc_11, _loc_12);
            return;
        }// end function

        protected function readSOWNOFFER(param1:ByteArray) : void
        {
            var _loc_8:* = null;
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = new ArrayCollection();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4.addItem(this.readObjectInstance(param1));
                _loc_5++;
            }
            var _loc_6:* = Tibia.s_GetOptions();
            var _loc_7:* = null;
            var _loc_9:* = _loc_6.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_7 = _loc_6.getSideBarSet(SideBarSet.DEFAULT_SET);
            if (_loc_6 != null && _loc_9 != null)
            {
                _loc_8 = _loc_7.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget;
                if (_loc_8 == null)
                {
                    _loc_8 = _loc_7.showWidgetType(Widget.TYPE_SAFETRADE, -1, -1) as SafeTradeWidget;
                }
                _loc_8.ownName = _loc_2;
                _loc_8.ownItems = _loc_4;
            }
            return;
        }// end function

        protected function readSMOVECREATURE(param1:ByteArray) : void
        {
            var _loc_10:* = null;
            var _loc_15:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = -1;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (_loc_2 != 65535)
            {
                _loc_3 = this.readCoordinate(param1, _loc_2);
                if (!this.m_WorldMapStorage.isVisible(_loc_3.x, _loc_3.y, _loc_3.z, true))
                {
                    throw new Error("Connection.readSMOVECREATURE: Start co-ordinate " + _loc_3 + " is invalid.", 0);
                }
                _loc_4 = this.m_WorldMapStorage.toMap(_loc_3);
                _loc_5 = param1.readUnsignedByte();
                var _loc_16:* = this.m_WorldMapStorage.getObject(_loc_4.x, _loc_4.y, _loc_4.z, _loc_5);
                _loc_6 = this.m_WorldMapStorage.getObject(_loc_4.x, _loc_4.y, _loc_4.z, _loc_5);
                var _loc_16:* = this.m_CreatureStorage.getCreature(_loc_6.data);
                _loc_7 = this.m_CreatureStorage.getCreature(_loc_6.data);
                if (_loc_16 == null || _loc_6.ID != AppearanceInstance.CREATURE || _loc_16 == null)
                {
                    throw new Error("Connection.readSMOVECREATURE: No creature at position " + _loc_3 + ", index " + _loc_5 + ".", 1);
                }
            }
            else
            {
                _loc_15 = param1.readUnsignedInt();
                _loc_6 = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE, _loc_15);
                var _loc_16:* = this.m_CreatureStorage.getCreature(_loc_15);
                _loc_7 = this.m_CreatureStorage.getCreature(_loc_15);
                if (_loc_16 == null)
                {
                    throw new Error("Connection.readSMOVECREATURE: Creature " + _loc_15 + " not found.", 2);
                }
                _loc_3 = _loc_7.position;
                if (!this.m_WorldMapStorage.isVisible(_loc_3.x, _loc_3.y, _loc_3.z, true))
                {
                    throw new Error("Connection.readSMOVECREATURE: Start co-ordinate " + _loc_3 + " is invalid.", 3);
                }
                _loc_4 = this.m_WorldMapStorage.toMap(_loc_3);
            }
            var _loc_8:* = this.readCoordinate(param1);
            if (!this.m_WorldMapStorage.isVisible(_loc_8.x, _loc_8.y, _loc_8.z, true))
            {
                throw new Error("Connection.readSMOVECREATURE: Target co-ordinate " + _loc_8 + " is invalid.", 4);
            }
            var _loc_9:* = this.m_WorldMapStorage.toMap(_loc_8);
            _loc_10 = _loc_8.sub(_loc_3);
            var _loc_11:* = _loc_10.z != 0 || Math.abs(_loc_10.x) > 1 || Math.abs(_loc_10.y) > 1;
            var _loc_12:* = null;
            var _loc_16:* = this.m_WorldMapStorage.getObject(_loc_9.x, _loc_9.y, _loc_9.z, 0);
            _loc_12 = this.m_WorldMapStorage.getObject(_loc_9.x, _loc_9.y, _loc_9.z, 0);
            if (!_loc_11 && (_loc_16 == null || _loc_12.m_Type == null || !_loc_12.m_Type.isBank))
            {
                throw new Error("Connection.readSMOVECREATURE: Target field " + _loc_8 + " has no BANK.", 5);
            }
            if (_loc_2 != 65535)
            {
                this.m_WorldMapStorage.deleteObject(_loc_4.x, _loc_4.y, _loc_4.z, _loc_5);
            }
            this.m_WorldMapStorage.putObject(_loc_9.x, _loc_9.y, _loc_9.z, _loc_6);
            _loc_7.setPosition(_loc_8.x, _loc_8.y, _loc_8.z);
            if (_loc_11)
            {
                if (_loc_7.ID == this.m_Player.ID)
                {
                    Player(_loc_7).stopAutowalk(true);
                }
                if (_loc_10.x > 0)
                {
                    _loc_7.direction = 1;
                }
                else if (_loc_10.x < 0)
                {
                    _loc_7.direction = 3;
                }
                else if (_loc_10.y < 0)
                {
                    _loc_7.direction = 0;
                }
                else if (_loc_10.y > 0)
                {
                    _loc_7.direction = 2;
                }
                if (_loc_7.ID != this.m_Player.ID)
                {
                    _loc_7.stopMovementAnimation();
                }
            }
            else
            {
                _loc_7.startMovementAnimation(_loc_10.x, _loc_10.y, _loc_12.m_Type.waypoints);
            }
            this.m_CreatureStorage.markOpponentVisible(_loc_7, true);
            this.m_CreatureStorage.invalidateOpponents();
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            if (_loc_3.z == this.m_MiniMapStorage.getPositionZ())
            {
                this.m_WorldMapStorage.updateMiniMap(_loc_4.x, _loc_4.y, _loc_4.z);
                _loc_13 = this.m_WorldMapStorage.getMiniMapColour(_loc_4.x, _loc_4.y, _loc_4.z);
                _loc_14 = this.m_WorldMapStorage.getMiniMapCost(_loc_4.x, _loc_4.y, _loc_4.z);
                this.m_MiniMapStorage.updateField(_loc_3.x, _loc_3.y, _loc_3.z, _loc_13, _loc_14, false);
            }
            if (_loc_8.z == this.m_MiniMapStorage.getPositionZ())
            {
                this.m_WorldMapStorage.updateMiniMap(_loc_9.x, _loc_9.y, _loc_9.z);
                _loc_13 = this.m_WorldMapStorage.getMiniMapColour(_loc_9.x, _loc_9.y, _loc_9.z);
                _loc_14 = this.m_WorldMapStorage.getMiniMapCost(_loc_9.x, _loc_9.y, _loc_9.z);
                this.m_MiniMapStorage.updateField(_loc_8.x, _loc_8.y, _loc_8.z, _loc_13, _loc_14, false);
            }
            return;
        }// end function

        public function sendCMOUNT(param1:Boolean) : void
        {
            var b:ByteArray;
            var a_Mount:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMOUNT);
                b.writeBoolean(a_Mount);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMOUNT, e);
            }
            return;
        }// end function

        public function sendCCLOSENPCTRADE() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CCLOSENPCTRADE);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CCLOSENPCTRADE, e);
            }
            return;
        }// end function

        protected function readSSETSTOREDEEPLINK(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedByte();
            IngameShopManager.getInstance().currentlyFeaturedServiceType = _loc_2;
            return;
        }// end function

        public function sendCSELLOBJECT(param1:int, param2:int, param3:int, param4:Boolean) : void
        {
            var b:ByteArray;
            var a_Type:* = param1;
            var a_Data:* = param2;
            var a_Amount:* = param3;
            var a_KeepEquipped:* = param4;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSELLOBJECT);
                b.writeShort(a_Type);
                b.writeByte(a_Data);
                b.writeByte(a_Amount);
                b.writeBoolean(a_KeepEquipped);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSELLOBJECT, e);
            }
            return;
        }// end function

        protected function readSBOTTOMFLOOR(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            _loc_2 = this.m_WorldMapStorage.getPosition();
            var _loc_10:* = _loc_2;
            var _loc_11:* = _loc_2.x - 1;
            _loc_10.x = _loc_11;
            var _loc_10:* = _loc_2;
            var _loc_11:* = _loc_2.y - 1;
            _loc_10.y = _loc_11;
            var _loc_10:* = _loc_2;
            var _loc_11:* = _loc_2.z + 1;
            _loc_10.z = _loc_11;
            this.m_WorldMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            this.m_MiniMapStorage.setPosition(_loc_2.x, _loc_2.y, _loc_2.z);
            if (_loc_2.z > (GROUND_LAYER + 1))
            {
                this.m_WorldMapStorage.scrollMap(0, 0, 1);
                if (_loc_2.z <= MAP_MAX_Z - UNDERGROUND_LAYER)
                {
                    this.readFloor(param1, 0);
                }
            }
            else if (_loc_2.z == (GROUND_LAYER + 1))
            {
                this.m_WorldMapStorage.scrollMap(0, 0, (UNDERGROUND_LAYER + 1));
                _loc_7 = 0;
                _loc_8 = UNDERGROUND_LAYER;
                while (_loc_8 >= 0)
                {
                    
                    _loc_7 = this.readFloor(param1, _loc_8, _loc_7);
                    _loc_8 = _loc_8 - 1;
                }
            }
            this.m_Player.stopAutowalk(true);
            this.m_WorldMapStorage.invalidateOnscreenMessages();
            _loc_3 = this.m_WorldMapStorage.toMap(_loc_2);
            _loc_4 = 0;
            _loc_5 = 0;
            _loc_6 = 0;
            while (_loc_6 < MAPSIZE_X)
            {
                
                _loc_9 = 0;
                while (_loc_9 < MAPSIZE_Y)
                {
                    
                    _loc_3.x = _loc_6;
                    _loc_3.y = _loc_9;
                    _loc_2 = this.m_WorldMapStorage.toAbsolute(_loc_3, _loc_2);
                    this.m_WorldMapStorage.updateMiniMap(_loc_3.x, _loc_3.y, _loc_3.z);
                    _loc_4 = this.m_WorldMapStorage.getMiniMapColour(_loc_3.x, _loc_3.y, _loc_3.z);
                    _loc_5 = this.m_WorldMapStorage.getMiniMapCost(_loc_3.x, _loc_3.y, _loc_3.z);
                    this.m_MiniMapStorage.updateField(_loc_2.x, _loc_2.y, _loc_2.z, _loc_4, _loc_5, false);
                    _loc_9++;
                }
                _loc_6++;
            }
            return;
        }// end function

        protected function readSGRAPHICALEFFECT(param1:ByteArray) : void
        {
            var _loc_2:* = this.readCoordinate(param1);
            var _loc_3:* = this.m_AppearanceStorage.createEffectInstance(param1.readUnsignedByte());
            this.m_WorldMapStorage.appendEffect(_loc_2.x, _loc_2.y, _loc_2.z, _loc_3);
            return;
        }// end function

        public function sendCFOLLOW(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                if (a_CreatureID != 0)
                {
                    this.m_Player.stopAutowalk(false);
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CFOLLOW);
                b.writeInt(a_CreatureID);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CFOLLOW, e);
            }
            return;
        }// end function

        public function sendCBUGREPORT(param1:int, param2:String, param3 = null) : void
        {
            var Message:String;
            var b:ByteArray;
            var Coordinate:Vector3D;
            var TypoSpeaker:String;
            var TypoText:String;
            var a_BugCategory:* = param1;
            var a_UserMessage:* = param2;
            var a_BugInformation:* = param3;
            try
            {
                Message;
                if (a_UserMessage != null)
                {
                    Message = Message + a_UserMessage.substr(0, BugReportWidget.MAX_USER_MESSAGE_LENGTH);
                }
                Message = Message + ("\nClient-Version=" + CLIENT_VERSION);
                Message = Message + ("\nBrowser=" + BrowserHelper.s_GetBrowserString());
                Message = Message + ("\nFlash=" + Capabilities.serverString);
                if (Message.length > BugReportWidget.MAX_TOTAL_MESSAGE_LENGTH)
                {
                    Message = Message.substr(0, BugReportWidget.MAX_TOTAL_MESSAGE_LENGTH);
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CBUGREPORT);
                b.writeByte(a_BugCategory);
                StringHelper.s_WriteToByteArray(b, Message);
                if (a_BugCategory == BugReportWidget.BUG_CATEGORY_MAP)
                {
                    Coordinate = this.m_Player.getPosition();
                    if (a_BugInformation is Vector3D)
                    {
                        Coordinate = a_BugInformation as Vector3D;
                    }
                    b.writeShort(Coordinate.x);
                    b.writeShort(Coordinate.y);
                    b.writeByte(Coordinate.z);
                }
                else if (a_BugCategory == BugReportWidget.BUG_CATEGORY_TYPO)
                {
                    TypoSpeaker;
                    TypoText;
                    if (a_BugInformation is BugReportTypo)
                    {
                        TypoSpeaker = (a_BugInformation as BugReportTypo).Speaker;
                        TypoText = (a_BugInformation as BugReportTypo).Text;
                    }
                    StringHelper.s_WriteToByteArray(b, TypoSpeaker != null ? (TypoSpeaker) : (""));
                    StringHelper.s_WriteToByteArray(b, TypoText != null ? (TypoText) : (""));
                }
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CBUGREPORT, e);
            }
            return;
        }// end function

        protected function readSUNJUSTIFIEDPOINTS(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            _loc_2 = param1.readUnsignedByte();
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = param1.readUnsignedByte();
            _loc_5 = param1.readUnsignedByte();
            _loc_6 = param1.readUnsignedByte();
            _loc_7 = param1.readUnsignedByte();
            _loc_8 = param1.readUnsignedByte();
            this.m_Player.unjustPoints = new UnjustPointsInfo(_loc_2, _loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8);
            return;
        }// end function

        protected function readSSETINVENTORY(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedByte();
            var _loc_3:* = this.readObjectInstance(param1);
            var _loc_4:* = this.m_ContainerStorage.getBodyContainerView();
            if (this.m_ContainerStorage.getBodyContainerView() != null)
            {
                _loc_4.setObject(_loc_2, _loc_3);
            }
            return;
        }// end function

        public function sendCOPENTRANSACTIONHISTORY(param1:int) : void
        {
            var b:ByteArray;
            var a_EntriesPerPage:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(COPENTRANSACTIONHISTORY);
                b.writeByte(a_EntriesPerPage);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(COPENTRANSACTIONHISTORY, e);
            }
            return;
        }// end function

        public function sendCANSWERMODALDIALOG(param1:uint, param2:int, param3:int) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            var a_Button:* = param2;
            var a_Choice:* = param3;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CANSWERMODALDIALOG);
                b.writeUnsignedInt(a_ID);
                b.writeByte(a_Button);
                b.writeByte(a_Choice);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CANSWERMODALDIALOG, e);
            }
            return;
        }// end function

        public function sendCMARKETLEAVE() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMARKETLEAVE);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMARKETLEAVE, e);
            }
            return;
        }// end function

        protected function readSEDITGUILDMESSAGE(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            _loc_2 = new SimpleEditTextWidget();
            _loc_2.ID = 0;
            _loc_2.maxChars = ChatStorage.MAX_GUILD_MOTD_LENGTH;
            _loc_2.text = StringHelper.s_ReadLongStringFromByteArray(param1, ChatStorage.MAX_GUILD_MOTD_LENGTH);
            _loc_2.show();
            return;
        }// end function

        protected function readArea(param1:ByteArray, param2:int, param3:int, param4:int, param5:int) : int
        {
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_6:* = this.m_WorldMapStorage.getPosition();
            var _loc_7:* = new Vector3D();
            var _loc_8:* = new Vector3D();
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (_loc_6.z <= GROUND_LAYER)
            {
                _loc_9 = 0;
                _loc_10 = GROUND_LAYER + 1;
                _loc_11 = 1;
            }
            else
            {
                _loc_9 = 2 * UNDERGROUND_LAYER;
                _loc_10 = Math.max(-1, _loc_6.z - MAP_MAX_Z + 1);
                _loc_11 = -1;
            }
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            while (_loc_9 != _loc_10)
            {
                
                _loc_15 = param2;
                while (_loc_15 <= param4)
                {
                    
                    _loc_16 = param3;
                    while (_loc_16 <= param5)
                    {
                        
                        if (_loc_12 > 0)
                        {
                            _loc_12 = _loc_12 - 1;
                        }
                        else
                        {
                            _loc_12 = this.readField(param1, _loc_15, _loc_16, _loc_9);
                        }
                        _loc_7.setComponents(_loc_15, _loc_16, _loc_9);
                        this.m_WorldMapStorage.toAbsolute(_loc_7, _loc_8);
                        if (_loc_8.z == this.m_MiniMapStorage.getPositionZ())
                        {
                            this.m_WorldMapStorage.updateMiniMap(_loc_15, _loc_16, _loc_9);
                            _loc_13 = this.m_WorldMapStorage.getMiniMapColour(_loc_15, _loc_16, _loc_9);
                            _loc_14 = this.m_WorldMapStorage.getMiniMapCost(_loc_15, _loc_16, _loc_9);
                            this.m_MiniMapStorage.updateField(_loc_8.x, _loc_8.y, _loc_8.z, _loc_13, _loc_14, false);
                        }
                        _loc_16++;
                    }
                    _loc_15++;
                }
                _loc_9 = _loc_9 + _loc_11;
            }
            return _loc_12;
        }// end function

        protected function readSOPENOWNCHANNEL(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = StringHelper.s_ReadLongStringFromByteArray(param1, Channel.MAX_NAME_LENGTH);
            _loc_4 = this.m_ChatStorage.addChannel(_loc_2, _loc_3, MessageMode.MESSAGE_CHANNEL);
            _loc_4.canModerate = true;
            if (_loc_4.isPrivate)
            {
                this.m_ChatStorage.ownPrivateChannelID = _loc_2;
            }
            _loc_5 = param1.readUnsignedShort();
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_9 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
                _loc_4.playerJoined(_loc_9);
                _loc_6++;
            }
            _loc_7 = param1.readUnsignedShort();
            _loc_8 = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_10 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
                _loc_4.playerInvited(_loc_10);
                _loc_8++;
            }
            return;
        }// end function

        protected function readSCREDITBALANCE(param1:ByteArray) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            _loc_2 = param1.readUnsignedByte() == 1;
            _loc_3 = Number.NaN;
            _loc_4 = Number.NaN;
            if (_loc_2)
            {
                _loc_3 = param1.readInt();
                _loc_4 = param1.readInt();
            }
            IngameShopManager.getInstance().setCreditBalance(_loc_3, _loc_4);
            return;
        }// end function

        public function sendCSHAREEXPERIENCE(param1:Boolean) : void
        {
            var b:ByteArray;
            var a_Enabled:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSHAREEXPERIENCE);
                b.writeBoolean(a_Enabled);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSHAREEXPERIENCE, e);
            }
            return;
        }// end function

        protected function readSCHANGEINCONTAINER(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedByte();
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = this.readObjectInstance(param1);
            var _loc_5:* = this.m_ContainerStorage.getContainerView(_loc_2);
            if (this.m_ContainerStorage.getContainerView(_loc_2) != null)
            {
                _loc_5.changeObject(_loc_3, _loc_4);
            }
            return;
        }// end function

        protected function readSAMBIENTE(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedByte();
            var _loc_3:* = Colour.s_FromEightBit(param1.readUnsignedByte());
            this.m_WorldMapStorage.setAmbientLight(_loc_3, _loc_2);
            return;
        }// end function

        protected function readSBLESSINGS(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            if (this.m_Player != null)
            {
                this.m_Player.blessings = _loc_2;
            }
            return;
        }// end function

        protected function readSPLAYERGOODS(param1:ByteArray) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = this.readSigned64BitValue(param1);
            var _loc_3:* = new Vector.<InventoryTypeInfo>;
            var _loc_4:* = param1.readUnsignedByte() - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_5 = param1.readUnsignedShort();
                _loc_6 = param1.readUnsignedByte();
                _loc_3.push(new InventoryTypeInfo(_loc_5, 0, _loc_6));
                _loc_4 = _loc_4 - 1;
            }
            this.m_ContainerStorage.setPlayerGoods(_loc_3);
            this.m_ContainerStorage.setPlayerMoney(_loc_2);
            return;
        }// end function

        protected function readSINGAMESHOPSUCCESS(param1:ByteArray) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_2:* = param1.readUnsignedByte();
            _loc_3 = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_4 = param1.readInt();
            _loc_5 = param1.readInt();
            IngameShopManager.getInstance().completePurchase(_loc_3);
            IngameShopManager.getInstance().setCreditBalance(_loc_4, _loc_5);
            return;
        }// end function

        public function sendCGETOUTFIT() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CGETOUTFIT);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CGETOUTFIT, e);
            }
            return;
        }// end function

        public function sendCREQUESTSHOPOFFERS(param1:String) : void
        {
            var b:ByteArray;
            var a_CategoryName:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CREQUESTSHOPOFFERS);
                b.writeByte(IngameShopProduct.SERVICE_TYPE_UNKNOWN);
                StringHelper.s_WriteToByteArray(b, a_CategoryName);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CREQUESTSHOPOFFERS, e);
            }
            return;
        }// end function

        protected function readSUPDATINGSHOPBALANCE(param1:ByteArray) : void
        {
            var _loc_2:* = false;
            _loc_2 = param1.readUnsignedByte() == 1;
            IngameShopManager.getInstance().setCreditBalanceUpdating(_loc_2);
            return;
        }// end function

        public function sendCSETOUTFIT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
        {
            var b:ByteArray;
            var a_PlayerOutfit:* = param1;
            var a_Colour0:* = param2;
            var a_Colour1:* = param3;
            var a_Colour2:* = param4;
            var a_Colour3:* = param5;
            var a_Addons:* = param6;
            var a_MountOutfit:* = param7;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSETOUTFIT);
                b.writeShort(a_PlayerOutfit);
                b.writeByte(a_Colour0);
                b.writeByte(a_Colour1);
                b.writeByte(a_Colour2);
                b.writeByte(a_Colour3);
                b.writeByte(a_Addons);
                b.writeShort(a_MountOutfit);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSETOUTFIT, e);
            }
            return;
        }// end function

        protected function readSDEAD(param1:ByteArray) : void
        {
            var _loc_4:* = NaN;
            var _loc_2:* = new ConnectionEvent(ConnectionEvent.DEAD);
            _loc_2.message = null;
            var _loc_3:* = param1.readUnsignedByte();
            if (_loc_3 == 0)
            {
                _loc_4 = param1.readUnsignedByte();
                if (_loc_4 < 100)
                {
                    _loc_2.data = {type:ConnectionEvent.DEATH_UNFAIR, fairFightFactor:_loc_4};
                }
                else
                {
                    _loc_2.data = {type:ConnectionEvent.DEATH_REGULAR, fairFightFactor:0};
                }
            }
            else if (_loc_3 == 1)
            {
                _loc_2.data = {type:ConnectionEvent.DEATH_BLESSED, fairFightFactor:0};
            }
            else if (_loc_3 == 2)
            {
                _loc_2.data = {type:ConnectionEvent.DEATH_NOPENALTY, fairFightFactor:0};
            }
            else
            {
                throw new Error("Connection.readSDEAD: Invalid death type " + _loc_3);
            }
            this.m_ServerConnection.dispatchEvent(_loc_2);
            return;
        }// end function

        public function get beatDuration() : int
        {
            return this.m_BeatDuration;
        }// end function

        public function sendCMARKETCREATE(param1:int, param2:int, param3:int, param4:uint, param5:Boolean) : void
        {
            var b:ByteArray;
            var a_Kind:* = param1;
            var a_TypeID:* = param2;
            var a_Amount:* = param3;
            var a_PiecePrice:* = param4;
            var a_IsAnonymous:* = param5;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMARKETCREATE);
                b.writeByte(a_Kind);
                b.writeShort(a_TypeID);
                b.writeShort(a_Amount);
                b.writeUnsignedInt(a_PiecePrice);
                b.writeBoolean(a_IsAnonymous);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMARKETCREATE, e);
            }
            return;
        }// end function

        protected function readSCHANNELEVENT(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = this.m_ChatStorage.getChannel(_loc_2);
            _loc_4 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
            _loc_5 = param1.readUnsignedByte();
            if (_loc_3 != null && _loc_4 != null)
            {
                switch(_loc_5)
                {
                    case 0:
                    {
                        _loc_3.playerJoined(_loc_4);
                        break;
                    }
                    case 1:
                    {
                        _loc_3.playerLeft(_loc_4);
                        break;
                    }
                    case 2:
                    {
                        _loc_3.playerInvited(_loc_4);
                        break;
                    }
                    case 3:
                    {
                        _loc_3.playerExcluded(_loc_4);
                        break;
                    }
                    case 4:
                    {
                        _loc_3.playerPending(_loc_4);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function sendCEDITGUILDMESSAGE(param1:String) : void
        {
            var b:ByteArray;
            var a_Text:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CEDITGUILDMESSAGE);
                StringHelper.s_WriteToByteArray(b, a_Text, ChatStorage.MAX_GUILD_MOTD_LENGTH);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPRIVATECHANNEL, e);
            }
            return;
        }// end function

        protected function sendCQUITGAME() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CQUITGAME);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CQUITGAME, e);
            }
            return;
        }// end function

        protected function readSREQUESTPURCHASEDATA(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = param1.readUnsignedInt();
            _loc_3 = param1.readUnsignedByte();
            if (_loc_3 == IngameShopProduct.SERVICE_TYPE_CHARACTER_NAME_CHANGE)
            {
                IngameShopManager.getInstance().requestNameForNameChange(_loc_2);
            }
            return;
        }// end function

        public function sendCMARKETACCEPT(param1:Offer, param2:int) : void
        {
            var b:ByteArray;
            var a_Offer:* = param1;
            var a_Amount:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CMARKETACCEPT);
                b.writeUnsignedInt(a_Offer.offerID.timestamp);
                b.writeShort(a_Offer.offerID.counter);
                b.writeShort(a_Amount);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CMARKETACCEPT, e);
            }
            return;
        }// end function

        public function sendCADDBUDDY(param1:String) : void
        {
            var b:ByteArray;
            var a_Name:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CADDBUDDY);
                StringHelper.s_WriteToByteArray(b, a_Name, Creature.MAX_NAME_LENGHT);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CADDBUDDY, e);
            }
            return;
        }// end function

        public function sendCEDITBUDDY(param1:int, param2:String, param3:uint, param4:Boolean) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            var a_Description:* = param2;
            var a_Icon:* = param3;
            var a_Notify:* = param4;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CEDITBUDDY);
                b.writeUnsignedInt(a_ID);
                StringHelper.s_WriteToByteArray(b, a_Description, Creature.MAX_DESCRIPTION_LENGHT);
                b.writeUnsignedInt(a_Icon);
                b.writeBoolean(a_Notify);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CEDITBUDDY, e);
            }
            return;
        }// end function

        protected function readSCONTAINER(param1:ByteArray) : void
        {
            var _loc_14:* = null;
            var _loc_2:* = param1.readUnsignedByte();
            var _loc_3:* = this.readObjectInstance(param1);
            var _loc_4:* = StringHelper.s_Capitalise(StringHelper.s_ReadLongStringFromByteArray(param1, ContainerStorage.MAX_NAME_LENGTH));
            var _loc_5:* = param1.readUnsignedByte();
            var _loc_6:* = param1.readUnsignedByte() != 0;
            var _loc_7:* = param1.readUnsignedByte() != 0;
            var _loc_8:* = param1.readUnsignedByte() != 0;
            var _loc_9:* = param1.readUnsignedShort();
            var _loc_10:* = param1.readUnsignedShort();
            var _loc_11:* = param1.readUnsignedByte();
            if (param1.readUnsignedByte() > _loc_5)
            {
                throw new Error("Connection.readSCONTAINER: Number of content objects " + _loc_11 + " exceeds number of slots per page " + _loc_5, 0);
            }
            if (_loc_11 > _loc_9)
            {
                throw new Error("Connection.readSCONTAINER: Number of content objects " + _loc_11 + " exceeds number of total objects " + _loc_9, 1);
            }
            var _loc_12:* = this.m_ContainerStorage.createContainerView(_loc_2, _loc_3, _loc_4, _loc_6, _loc_7, _loc_8, _loc_5, _loc_9 - _loc_11, _loc_10);
            if (this.m_ContainerStorage.createContainerView(_loc_2, _loc_3, _loc_4, _loc_6, _loc_7, _loc_8, _loc_5, _loc_9 - _loc_11, _loc_10) == null)
            {
                throw new Error("Connection.readSCONTAINER: Failed to create view.", 2);
            }
            var _loc_13:* = 0;
            while (_loc_13 < _loc_11)
            {
                
                _loc_14 = this.readObjectInstance(param1);
                _loc_12.addObject(_loc_10 + _loc_13, _loc_14);
                _loc_13++;
            }
            return;
        }// end function

        public function sendCROTATEWEST() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CROTATEWEST);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CROTATEWEST, e);
            }
            return;
        }// end function

        protected function readSCREATUREPARTY(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_4.setPartyFlag(_loc_3);
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCUPCONTAINER(param1:int) : void
        {
            var b:ByteArray;
            var a_ID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CUPCONTAINER);
                b.writeByte(a_ID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CUPCONTAINER, e);
            }
            return;
        }// end function

        public function sendNameCRULEVIOLATIONREPORT(param1:int, param2:String, param3:String, param4:String) : void
        {
            var b:ByteArray;
            var a_Reason:* = param1;
            var a_CharacterName:* = param2;
            var a_Comment:* = param3;
            var a_Translation:* = param4;
            try
            {
                if (a_Translation == null)
                {
                    a_Translation;
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CRULEVIOLATIONREPORT);
                b.writeByte(Type.REPORT_NAME);
                b.writeByte(a_Reason);
                StringHelper.s_WriteToByteArray(b, a_CharacterName, Creature.MAX_NAME_LENGHT);
                StringHelper.s_WriteToByteArray(b, a_Comment, ReportWidget.MAX_COMMENT_LENGTH);
                StringHelper.s_WriteToByteArray(b, a_Translation, ReportWidget.MAX_TRANSLATION_LENGTH);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CRULEVIOLATIONREPORT, e);
            }
            return;
        }// end function

        public function readMessage(param1:IMessageReader) : void
        {
            var Type:int;
            var a_MessageReader:* = param1;
            Type = a_MessageReader.messageType;
            var CommunicationData:* = a_MessageReader.inputBuffer;
            try
            {
                switch(Type)
                {
                    case SPENDINGSTATEENTERED:
                    {
                        this.readSPENDINGSTATEENTERED(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SWORLDENTERED:
                    {
                        this.readSWORLDENTERED(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SLOGINSUCCESS:
                    {
                        this.readSLOGINSUCCESS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSTOREBUTTONINDICATORS:
                    {
                        this.readSSTOREBUTTONINDICATORS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SDEAD:
                    {
                        this.readSDEAD(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SFULLMAP:
                    {
                        this.readSFULLMAP(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case STOPROW:
                    {
                        this.readSTOPROW(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SRIGHTROW:
                    {
                        this.readSRIGHTROW(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SBOTTOMROW:
                    {
                        this.readSBOTTOMROW(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SLEFTROW:
                    {
                        this.readSLEFTROW(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SFIELDDATA:
                    {
                        this.readSFIELDDATA(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATEONMAP:
                    {
                        this.readSCREATEONMAP(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCHANGEONMAP:
                    {
                        this.readSCHANGEONMAP(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SDELETEONMAP:
                    {
                        this.readSDELETEONMAP(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMOVECREATURE:
                    {
                        this.readSMOVECREATURE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCONTAINER:
                    {
                        this.readSCONTAINER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCLOSECONTAINER:
                    {
                        this.readSCLOSECONTAINER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATEINCONTAINER:
                    {
                        this.readSCREATEINCONTAINER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCHANGEINCONTAINER:
                    {
                        this.readSCHANGEINCONTAINER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SDELETEINCONTAINER:
                    {
                        this.readSDELETEINCONTAINER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSETINVENTORY:
                    {
                        this.readSSETINVENTORY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SDELETEINVENTORY:
                    {
                        this.readSDELETEINVENTORY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SNPCOFFER:
                    {
                        this.readSNPCOFFER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPLAYERGOODS:
                    {
                        this.readSPLAYERGOODS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCLOSENPCTRADE:
                    {
                        this.readSCLOSENPCTRADE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SOWNOFFER:
                    {
                        this.readSOWNOFFER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCOUNTEROFFER:
                    {
                        this.readSCOUNTEROFFER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCLOSETRADE:
                    {
                        this.readSCLOSETRADE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SAMBIENTE:
                    {
                        this.readSAMBIENTE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SGRAPHICALEFFECT:
                    {
                        this.readSGRAPHICALEFFECT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMISSILEEFFECT:
                    {
                        this.readSMISSILEEFFECT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case STRAPPERS:
                    {
                        this.readSTRAPPERS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATUREHEALTH:
                    {
                        this.readSCREATUREHEALTH(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATURELIGHT:
                    {
                        this.readSCREATURELIGHT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATUREOUTFIT:
                    {
                        this.readSCREATUREOUTFIT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATURESPEED:
                    {
                        this.readSCREATURESPEED(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATURESKULL:
                    {
                        this.readSCREATURESKULL(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATUREPARTY:
                    {
                        this.readSCREATUREPARTY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATUREUNPASS:
                    {
                        this.readSCREATUREUNPASS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATUREPVPHELPERS:
                    {
                        this.readSCREATUREPVPHELPERS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATUREMARKS:
                    {
                        this.readSCREATUREMARKS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREATURETYPE:
                    {
                        this.readSCREATURETYPE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SEDITTEXT:
                    {
                        this.readSEDITTEXT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SEDITLIST:
                    {
                        this.readSEDITLIST(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SBLESSINGS:
                    {
                        this.readSBLESSINGS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSWITCHPRESET:
                    {
                        this.readSSWITCHPRESET(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPREMIUMTRIGGER:
                    {
                        this.readSPREMIUMTRIGGER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPLAYERDATABASIC:
                    {
                        this.readSPLAYERDATABASIC(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPLAYERDATACURRENT:
                    {
                        this.readSPLAYERDATACURRENT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPLAYERSKILLS:
                    {
                        this.readSPLAYERSKILLS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPLAYERSTATE:
                    {
                        this.readSPLAYERSTATE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCLEARTARGET:
                    {
                        this.readSCLEARTARGET(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSPELLDELAY:
                    {
                        this.readSSPELLDELAY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSPELLGROUPDELAY:
                    {
                        this.readSSPELLGROUPDELAY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMULTIUSEDELAY:
                    {
                        this.readSUSEDELAY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSETTACTICS:
                    {
                        this.readSSETTACTICS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSETSTOREDEEPLINK:
                    {
                        this.readSSETSTOREDEEPLINK(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case STALK:
                    {
                        this.readSTALK(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCHANNELS:
                    {
                        this.readSCHANNELS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SOPENCHANNEL:
                    {
                        this.readSOPENCHANNEL(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPRIVATECHANNEL:
                    {
                        this.readSPRIVATECHANNEL(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SEDITGUILDMESSAGE:
                    {
                        this.readSEDITGUILDMESSAGE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SOPENOWNCHANNEL:
                    {
                        this.readSOPENOWNCHANNEL(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCLOSECHANNEL:
                    {
                        this.readSCLOSECHANNEL(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMESSAGE:
                    {
                        this.readSMESSAGE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSNAPBACK:
                    {
                        this.readSSNAPBACK(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SWAIT:
                    {
                        this.readSWAIT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SUNJUSTIFIEDPOINTS:
                    {
                        this.readSUNJUSTIFIEDPOINTS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPVPSITUATIONS:
                    {
                        this.readSPVPSITUATIONS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case STOPFLOOR:
                    {
                        this.readSTOPFLOOR(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SBOTTOMFLOOR:
                    {
                        this.readSBOTTOMFLOOR(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SOUTFIT:
                    {
                        this.readSOUTFIT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SBUDDYDATA:
                    {
                        this.readSBUDDYDATA(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SBUDDYSTATUSCHANGE:
                    {
                        this.readSBUDDYSTATUSCHANGE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case STUTORIALHINT:
                    {
                        this.readSTUTORIALHINT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SAUTOMAPFLAG:
                    {
                        this.readSAUTOMAPFLAG(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCREDITBALANCE:
                    {
                        this.readSCREDITBALANCE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SINGAMESHOPERROR:
                    {
                        this.readSINGAMESHOPERROR(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SREQUESTPURCHASEDATA:
                    {
                        this.readSREQUESTPURCHASEDATA(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SQUESTLOG:
                    {
                        this.readSQUESTLOG(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SQUESTLINE:
                    {
                        this.readSQUESTLINE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SUPDATINGSHOPBALANCE:
                    {
                        this.readSUPDATINGSHOPBALANCE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SCHANNELEVENT:
                    {
                        this.readSCHANNELEVENT(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SOBJECTINFO:
                    {
                        this.readSOBJECTINFO(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPLAYERINVENTORY:
                    {
                        this.readSPLAYERINVENTORY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMARKETENTER:
                    {
                        this.readSMARKETENTER(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMARKETLEAVE:
                    {
                        this.readSMARKETLEAVE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMARKETDETAIL:
                    {
                        this.readSMARKETDETAIL(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SMARKETBROWSE:
                    {
                        this.readSMARKETBROWSE(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SSHOWMODALDIALOG:
                    {
                        this.readSSHOWMODALDIALOG(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPREMIUMSHOP:
                    {
                        this.readSPREMIUMSHOP(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SPREMIUMSHOPOFFERS:
                    {
                        this.readSPREMIUMSHOPOFFERS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case STRANSACTIONHISTORY:
                    {
                        this.readSTRANSACTIONHISTORY(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    case SINGAMESHOPSUCCESS:
                    {
                        this.readSINGAMESHOPSUCCESS(CommunicationData);
                        a_MessageReader.finishMessage();
                        break;
                    }
                    default:
                    {
                        return;
                        break;
                    }
                }
            }
            catch (_Error:Error)
            {
                handleReadError(Type, _Error);
                return;
            }
            return;
        }// end function

        public function sendCSETTACTICS(param1:int, param2:int, param3:int, param4:uint) : void
        {
            var b:ByteArray;
            var a_AttackMode:* = param1;
            var a_ChaseMode:* = param2;
            var a_SecureMode:* = param3;
            var a_PVPMode:* = param4;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CSETTACTICS);
                b.writeByte(a_AttackMode);
                b.writeByte(a_ChaseMode);
                b.writeByte(a_SecureMode);
                b.writeByte(a_PVPMode);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CSETTACTICS, e);
            }
            return;
        }// end function

        public function sendCPERFORMANCEMETRICS(param1:AccumulatingCounter, param2:AccumulatingCounter) : void
        {
            var b:ByteArray;
            var FLASH_FPS_LIMIT:uint;
            var a_ObjectCounter:* = param1;
            var a_FpsCounter:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CPERFORMANCEMETRICS);
                b.writeShort(a_ObjectCounter.minimum);
                b.writeShort(a_ObjectCounter.maximum);
                b.writeShort(a_ObjectCounter.average);
                b.writeShort(a_FpsCounter.minimum);
                b.writeShort(a_FpsCounter.maximum);
                b.writeShort(a_FpsCounter.average);
                FLASH_FPS_LIMIT;
                b.writeShort(FLASH_FPS_LIMIT);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPERFORMANCEMETRICS, e);
            }
            return;
        }// end function

        protected function readSMARKETDETAIL(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = [];
            _loc_4 = 0;
            _loc_4 = 0;
            while (_loc_4 <= MarketWidget.DETAIL_FIELD_WEIGHT)
            {
                
                _loc_13 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_3.push(_loc_13);
                _loc_4++;
            }
            _loc_5 = new Date().time / 1000 * OfferStatistics.SECONDS_PER_DAY;
            _loc_6 = 0;
            _loc_7 = 0;
            _loc_8 = 0;
            _loc_9 = 0;
            _loc_10 = 0;
            _loc_11 = [];
            _loc_6 = _loc_5;
            _loc_4 = param1.readUnsignedByte() - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_6 = _loc_6 - OfferStatistics.SECONDS_PER_DAY;
                _loc_7 = param1.readUnsignedInt();
                _loc_8 = param1.readUnsignedInt();
                _loc_9 = param1.readUnsignedInt();
                _loc_10 = param1.readUnsignedInt();
                _loc_11.push(new OfferStatistics(_loc_6, Offer.BUY_OFFER, _loc_7, _loc_8, _loc_9, _loc_10));
                _loc_4 = _loc_4 - 1;
            }
            _loc_6 = _loc_5;
            _loc_4 = param1.readUnsignedByte() - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_6 = _loc_6 - OfferStatistics.SECONDS_PER_DAY;
                _loc_7 = param1.readUnsignedInt();
                _loc_8 = param1.readUnsignedInt();
                _loc_9 = param1.readUnsignedInt();
                _loc_10 = param1.readUnsignedInt();
                _loc_11.push(new OfferStatistics(_loc_6, Offer.SELL_OFFER, _loc_7, _loc_8, _loc_9, _loc_10));
                _loc_4 = _loc_4 - 1;
            }
            _loc_12 = PopUpBase.getCurrent() as MarketWidget;
            if (_loc_12 != null)
            {
                _loc_12.mergeBrowseDetail(_loc_2, _loc_3, _loc_11);
            }
            return;
        }// end function

        protected function readSQUESTLOG(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = false;
            this.m_PendingQuestLine = -1;
            this.m_PendingQuestLog = false;
            _loc_2 = new Array();
            _loc_3 = param1.readUnsignedShort();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = param1.readUnsignedShort();
                _loc_7 = StringHelper.s_ReadLongStringFromByteArray(param1, QuestLine.MAX_NAME_LENGTH);
                _loc_8 = param1.readUnsignedByte() == 1;
                _loc_2.push(new QuestLine(_loc_6, _loc_7, _loc_8));
                _loc_4++;
            }
            _loc_5 = PopUpBase.getCurrent() as QuestLogWidget;
            if (_loc_5 == null)
            {
                _loc_5 = new QuestLogWidget();
            }
            _loc_5.questLines = _loc_2;
            _loc_5.show();
            return;
        }// end function

        public function sendCLEAVECHANNEL(param1:int) : void
        {
            var b:ByteArray;
            var a_ChannelID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CLEAVECHANNEL);
                b.writeShort(a_ChannelID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CLEAVECHANNEL, e);
            }
            return;
        }// end function

        protected function readSWORLDENTERED(param1:ByteArray) : void
        {
            if (this.m_ServerConnection.connectionState == CONNECTION_STATE_PENDING)
            {
                this.m_CreatureStorage.reset();
                this.m_MiniMapStorage.setPosition(0, 0, 0);
                this.m_WorldMapStorage.resetMap();
                this.m_WorldMapStorage.resetOnscreenMessages();
                this.m_WorldMapStorage.setPosition(0, 0, 0);
                this.m_WorldMapStorage.valid = false;
                ;
            }
            this.m_ServerConnection.setConnectionState(CONNECTION_STATE_GAME);
            return;
        }// end function

        protected function readCreatureInstance(param1:ByteArray, param2:int = -1, param3:Vector3D = null) : Creature
        {
            if (param1 == null || param2 == -1 && param1.bytesAvailable < 2)
            {
                throw new Error("Connection.readCreatureInstance: Not enough data.", 2147483625);
            }
            if (param2 == -1)
            {
                param2 = param1.readUnsignedShort();
            }
            if (param2 != AppearanceInstance.UNKNOWNCREATURE && param2 != AppearanceInstance.CREATURE && param2 != AppearanceInstance.OUTDATEDCREATURE)
            {
                throw new Error("Connection.readCreatureInstance: Invalid type.", 2147483624);
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = -1;
            var _loc_7:* = null;
            switch(param2)
            {
                case AppearanceInstance.UNKNOWNCREATURE:
                {
                    _loc_5 = param1.readUnsignedInt();
                    _loc_4 = param1.readUnsignedInt();
                    _loc_6 = param1.readUnsignedByte();
                    if (_loc_4 == this.m_Player.ID)
                    {
                        _loc_7 = this.m_Player;
                    }
                    else
                    {
                        _loc_7 = new Creature(_loc_4);
                    }
                    _loc_7 = this.m_CreatureStorage.replaceCreature(_loc_7, _loc_5);
                    if (_loc_7 != null)
                    {
                        _loc_7.type = _loc_6;
                        _loc_7.name = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
                        _loc_7.setSkillValue(SKILL_HITPOINTS_PERCENT, param1.readUnsignedByte());
                        _loc_7.direction = param1.readUnsignedByte();
                        _loc_7.outfit = this.readCreatureOutfit(param1, _loc_7.outfit);
                        _loc_7.mountOutfit = this.readMountOutfit(param1, _loc_7.mountOutfit);
                        _loc_7.brightness = param1.readUnsignedByte();
                        _loc_7.lightColour = Colour.s_FromEightBit(param1.readUnsignedByte());
                        _loc_7.setSkillValue(SKILL_GOSTRENGTH, param1.readUnsignedShort());
                        _loc_7.setPKFlag(param1.readUnsignedByte());
                        _loc_7.setPartyFlag(param1.readUnsignedByte());
                        _loc_7.guildFlag = param1.readUnsignedByte();
                        _loc_7.type = param1.readUnsignedByte();
                        _loc_7.speechCategory = param1.readUnsignedByte();
                        _loc_7.marks.setMark(Marks.MARK_TYPE_PERMANENT, param1.readUnsignedByte());
                        _loc_7.numberOfPVPHelpers = param1.readUnsignedShort();
                        _loc_7.isUnpassable = param1.readUnsignedByte() != 0;
                    }
                    else
                    {
                        throw new Error("Connection.readCreatureInstance: Failed to append creature.", 2147483623);
                    }
                    break;
                }
                case AppearanceInstance.OUTDATEDCREATURE:
                {
                    _loc_4 = param1.readUnsignedInt();
                    _loc_7 = this.m_CreatureStorage.getCreature(_loc_4);
                    if (_loc_7 != null)
                    {
                        _loc_7.setSkillValue(SKILL_HITPOINTS_PERCENT, param1.readUnsignedByte());
                        _loc_7.direction = param1.readUnsignedByte();
                        _loc_7.outfit = this.readCreatureOutfit(param1, _loc_7.outfit);
                        _loc_7.mountOutfit = this.readMountOutfit(param1, _loc_7.mountOutfit);
                        _loc_7.brightness = param1.readUnsignedByte();
                        _loc_7.lightColour = Colour.s_FromEightBit(param1.readUnsignedByte());
                        _loc_7.setSkillValue(SKILL_GOSTRENGTH, param1.readUnsignedShort());
                        _loc_7.setPKFlag(param1.readUnsignedByte());
                        _loc_7.setPartyFlag(param1.readUnsignedByte());
                        _loc_7.type = param1.readUnsignedByte();
                        _loc_7.speechCategory = param1.readUnsignedByte();
                        _loc_7.marks.setMark(Marks.MARK_TYPE_PERMANENT, param1.readUnsignedByte());
                        _loc_7.numberOfPVPHelpers = param1.readUnsignedShort();
                        _loc_7.isUnpassable = param1.readUnsignedByte() != 0;
                    }
                    else
                    {
                        throw new Error("Connection.readCreatureInstance: Outdated creature not found.", 2147483622);
                    }
                    break;
                }
                case AppearanceInstance.CREATURE:
                {
                    _loc_4 = param1.readUnsignedInt();
                    _loc_7 = this.m_CreatureStorage.getCreature(_loc_4);
                    if (_loc_7 != null)
                    {
                        _loc_7.direction = param1.readUnsignedByte();
                        _loc_7.isUnpassable = param1.readUnsignedByte() != 0;
                    }
                    else
                    {
                        throw new Error("Connection.readCreatureInstance: Known creature not found.", 2147483621);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param3 != null)
            {
                _loc_7.setPosition(param3.x, param3.y, param3.z);
            }
            this.m_CreatureStorage.markOpponentVisible(_loc_7, true);
            this.m_CreatureStorage.invalidateOpponents();
            return _loc_7;
        }// end function

        public function readCoordinate(param1:ByteArray, param2:int = -1, param3:int = -1, param4:int = -1) : Vector3D
        {
            if (param2 == -1)
            {
                param2 = param1.readUnsignedShort();
            }
            if (param3 == -1)
            {
                param3 = param1.readUnsignedShort();
            }
            if (param4 == -1)
            {
                param4 = param1.readUnsignedByte();
            }
            return new Vector3D(param2, param3, param4);
        }// end function

        public function sendCTHANKYOU(param1:uint) : void
        {
            var b:ByteArray;
            var a_StatementID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CTHANKYOU);
                b.writeUnsignedInt(a_StatementID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CTHANKYOU, e);
            }
            return;
        }// end function

        protected function readSOBJECTINFO(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            _loc_2 = param1.readUnsignedByte() - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = param1.readUnsignedShort();
                _loc_4 = param1.readUnsignedByte();
                _loc_5 = StringHelper.s_ReadLongStringFromByteArray(param1);
                this.m_AppearanceStorage.setCachedObjectTypeName(_loc_3, _loc_4, _loc_5);
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function sendCENTERWORLD() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CENTERWORLD);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CENTERWORLD, e);
            }
            return;
        }// end function

        protected function readSPREMIUMSHOPOFFERS(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            _loc_2 = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_3 = new Vector.<IngameShopOffer>;
            _loc_4 = param1.readUnsignedShort();
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readUnsignedInt();
                _loc_8 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_9 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_10 = new IngameShopOffer(_loc_7, _loc_8, _loc_9);
                _loc_10.price = param1.readUnsignedInt();
                _loc_10.highlightState = param1.readUnsignedByte();
                if (_loc_10.highlightState == IngameShopOffer.HIGHLIGHT_STATE_SALE)
                {
                    _loc_10.saleValidUntilTimestamp = param1.readUnsignedInt();
                    _loc_10.basePrice = param1.readUnsignedInt();
                }
                _loc_10.disabledState = param1.readUnsignedByte();
                if (_loc_10.disabledState == IngameShopOffer.DISABLED_STATE_DISABLED)
                {
                    _loc_10.disabledReason = StringHelper.s_ReadLongStringFromByteArray(param1);
                }
                _loc_11 = new Vector.<String>;
                _loc_12 = param1.readUnsignedByte();
                _loc_13 = 0;
                while (_loc_13 < _loc_12)
                {
                    
                    _loc_11.push(StringHelper.s_ReadLongStringFromByteArray(param1));
                    _loc_13 = _loc_13 + 1;
                }
                _loc_10.iconIdentifiers = _loc_11;
                _loc_14 = param1.readUnsignedShort();
                _loc_13 = 0;
                while (_loc_13 < _loc_14)
                {
                    
                    _loc_15 = StringHelper.s_ReadLongStringFromByteArray(param1);
                    _loc_16 = StringHelper.s_ReadLongStringFromByteArray(param1);
                    _loc_17 = new Vector.<String>;
                    _loc_18 = param1.readUnsignedByte();
                    _loc_19 = 0;
                    while (_loc_19 < _loc_18)
                    {
                        
                        _loc_17.push(StringHelper.s_ReadLongStringFromByteArray(param1));
                        _loc_19 = _loc_19 + 1;
                    }
                    _loc_20 = StringHelper.s_ReadLongStringFromByteArray(param1);
                    _loc_21 = new IngameShopProduct(_loc_15, _loc_16, _loc_20);
                    _loc_21.iconIdentifiers = _loc_17;
                    _loc_10.products.push(_loc_21);
                    _loc_13 = _loc_13 + 1;
                }
                if (_loc_10.disabledState != IngameShopOffer.DISABLED_STATE_HIDDEN)
                {
                    _loc_3.push(_loc_10);
                }
                _loc_5 = _loc_5 + 1;
            }
            _loc_6 = IngameShopManager.getInstance().getCategory(_loc_2);
            if (_loc_6 != null)
            {
                _loc_6.offers = _loc_3;
                if (IngameShopWidget.s_GetCurrentInstance() != null)
                {
                    IngameShopWidget.s_GetCurrentInstance().selectCategory(_loc_6);
                }
            }
            else
            {
                throw new Error("Communication.readSPREMIUMSHOPOFFERS: Invalid category \'" + _loc_2 + "\' for offers", 0);
            }
            return;
        }// end function

        protected function readSCHANGEONMAP(param1:ByteArray) : void
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            if (_loc_2 != 65535)
            {
                _loc_5 = this.readCoordinate(param1, _loc_2);
                if (!this.m_WorldMapStorage.isVisible(_loc_5.x, _loc_5.y, _loc_5.z, true))
                {
                    throw new Error("Connection.readSCHANGEONMAP: Co-ordinate " + _loc_5 + " is out of range.", 0);
                }
                _loc_6 = this.m_WorldMapStorage.toMap(_loc_5);
                _loc_4 = param1.readUnsignedByte();
                var _loc_12:* = this.m_WorldMapStorage.getObject(_loc_6.x, _loc_6.y, _loc_6.z, _loc_4);
                _loc_7 = this.m_WorldMapStorage.getObject(_loc_6.x, _loc_6.y, _loc_6.z, _loc_4);
                if (_loc_12 == null)
                {
                    throw new Error("Connection.readSCHANGEONMAP: Object not found.", 1);
                }
                var _loc_12:* = this.m_CreatureStorage.getCreature(_loc_7.data);
                _loc_8 = this.m_CreatureStorage.getCreature(_loc_7.data);
                if (_loc_7.ID == AppearanceInstance.CREATURE && _loc_12 == null)
                {
                    throw new Error("Connection.readSCHANGEONMAP: Creature not found: " + _loc_7.data, 2);
                }
                if (_loc_8 != null)
                {
                    this.m_CreatureStorage.markOpponentVisible(_loc_8, false);
                }
                _loc_9 = param1.readUnsignedShort();
                if (_loc_9 == AppearanceInstance.UNKNOWNCREATURE || _loc_9 == AppearanceInstance.OUTDATEDCREATURE || _loc_9 == AppearanceInstance.CREATURE)
                {
                    _loc_8 = this.readCreatureInstance(param1, _loc_9, _loc_5);
                    _loc_7 = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE, _loc_8.ID);
                }
                else
                {
                    _loc_7 = this.readObjectInstance(param1, _loc_9);
                }
                this.m_WorldMapStorage.changeObject(_loc_6.x, _loc_6.y, _loc_6.z, _loc_4, _loc_7);
            }
            else
            {
                _loc_3 = param1.readUnsignedInt();
                var _loc_12:* = this.m_CreatureStorage.getCreature(_loc_3);
                _loc_8 = this.m_CreatureStorage.getCreature(_loc_3);
                if (_loc_12 == null)
                {
                    throw new Error("Connection.readSDELETEONMAP: Creature not found: " + _loc_3, 3);
                }
                _loc_5 = _loc_8.position;
                if (!this.m_WorldMapStorage.isVisible(_loc_5.x, _loc_5.y, _loc_5.z, true))
                {
                    throw new Error("Connection.readSCHANGEONMAP: Co-ordinate " + _loc_5 + " is out of range.", 4);
                }
                _loc_6 = this.m_WorldMapStorage.toMap(_loc_5);
                this.m_CreatureStorage.markOpponentVisible(_loc_8, false);
                _loc_9 = param1.readUnsignedShort();
                if (_loc_9 == AppearanceInstance.UNKNOWNCREATURE || _loc_9 == AppearanceInstance.OUTDATEDCREATURE || _loc_9 == AppearanceInstance.CREATURE)
                {
                    _loc_8 = this.readCreatureInstance(param1, _loc_9);
                }
                else
                {
                    throw new Error("Connection.readSDELETEONMAP: Received object of type " + _loc_9 + " when a creature was expected.", 5);
                }
            }
            if (_loc_5.z == this.m_MiniMapStorage.getPositionZ())
            {
                this.m_WorldMapStorage.updateMiniMap(_loc_6.x, _loc_6.y, _loc_6.z);
                _loc_10 = this.m_WorldMapStorage.getMiniMapColour(_loc_6.x, _loc_6.y, _loc_6.z);
                _loc_11 = this.m_WorldMapStorage.getMiniMapCost(_loc_6.x, _loc_6.y, _loc_6.z);
                this.m_MiniMapStorage.updateField(_loc_5.x, _loc_5.y, _loc_5.z, _loc_10, _loc_11, false);
            }
            return;
        }// end function

        protected function readSCLOSETRADE(param1:ByteArray) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            var _loc_5:* = _loc_3.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget;
            _loc_4 = _loc_3.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget;
            if (_loc_2 != null && _loc_5 != null && _loc_5 != null)
            {
                _loc_4.ownName = null;
                _loc_4.ownItems = null;
                _loc_4.otherName = null;
                _loc_4.otherItems = null;
                _loc_3.hideWidgetType(Widget.TYPE_SAFETRADE, -1);
            }
            return;
        }// end function

        protected function readSMISSILEEFFECT(param1:ByteArray) : void
        {
            var _loc_2:* = this.readCoordinate(param1);
            var _loc_3:* = this.readCoordinate(param1);
            var _loc_4:* = param1.readUnsignedByte();
            var _loc_5:* = this.m_AppearanceStorage.createMissileInstance(_loc_4, _loc_2, _loc_3);
            this.m_WorldMapStorage.appendEffect(_loc_2.x, _loc_2.y, _loc_2.z, _loc_5);
            return;
        }// end function

        protected function readSOPENCHANNEL(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = StringHelper.s_ReadLongStringFromByteArray(param1, Channel.MAX_NAME_LENGTH);
            _loc_4 = this.m_ChatStorage.addChannel(_loc_2, _loc_3, MessageMode.MESSAGE_CHANNEL);
            _loc_5 = param1.readUnsignedShort();
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_9 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
                _loc_4.playerJoined(_loc_9);
                _loc_6++;
            }
            _loc_7 = param1.readUnsignedShort();
            _loc_8 = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_10 = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
                _loc_4.playerInvited(_loc_10);
                _loc_8++;
            }
            return;
        }// end function

        public function sendCGETQUESTLOG() : void
        {
            var b:ByteArray;
            try
            {
                if (!this.m_PendingQuestLog)
                {
                    b = this.m_ServerConnection.messageWriter.createMessage();
                    b.writeByte(CGETQUESTLOG);
                    this.m_ServerConnection.messageWriter.finishMessage();
                    this.m_PendingQuestLine = -1;
                    this.m_PendingQuestLog = true;
                }
            }
            catch (e:Error)
            {
                handleSendError(CGETQUESTLOG, e);
            }
            return;
        }// end function

        public function sendCCLOSENPCCHANNEL() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CCLOSENPCCHANNEL);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CCLOSENPCCHANNEL, e);
            }
            return;
        }// end function

        protected function readSOUTFIT(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = param1.readUnsignedByte();
            _loc_4 = param1.readUnsignedByte();
            _loc_5 = param1.readUnsignedByte();
            _loc_6 = param1.readUnsignedByte();
            _loc_7 = param1.readUnsignedByte();
            _loc_8 = param1.readUnsignedShort();
            _loc_9 = 0;
            _loc_10 = null;
            _loc_11 = 0;
            _loc_12 = null;
            _loc_13 = new ArrayCollection();
            _loc_14 = param1.readUnsignedByte();
            while (_loc_14 > 0)
            {
                
                _loc_9 = param1.readUnsignedShort();
                _loc_10 = StringHelper.s_ReadLongStringFromByteArray(param1, OutfitInstance.MAX_NAME_LENGTH);
                _loc_11 = param1.readUnsignedByte();
                _loc_12 = this.m_AppearanceStorage.getOutfitType(_loc_9);
                if (_loc_12 == null)
                {
                    throw new Error("Connection.readSOUTFIT: Unknown player outfit type " + _loc_9 + ".", 0);
                }
                _loc_11 = _loc_11 & (1 << (_loc_12.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternHeight - 1)) - 1;
                _loc_13.addItem({ID:_loc_9, name:_loc_10, addons:_loc_11});
                _loc_14 = _loc_14 - 1;
            }
            _loc_15 = new ArrayCollection();
            _loc_14 = param1.readUnsignedByte();
            while (_loc_14 > 0)
            {
                
                _loc_9 = param1.readUnsignedShort();
                _loc_10 = StringHelper.s_ReadLongStringFromByteArray(param1, OutfitInstance.MAX_NAME_LENGTH);
                _loc_12 = this.m_AppearanceStorage.getOutfitType(_loc_9);
                if (_loc_12 == null)
                {
                    throw new Error("Connection.readSOUTFIT: Unknown mount outfit type " + _loc_9 + ".", 1);
                }
                _loc_15.addItem({ID:_loc_9, name:_loc_10});
                _loc_14 = _loc_14 - 1;
            }
            _loc_16 = new SelectOutfitWidget();
            _loc_16.playerOutfits = _loc_13;
            _loc_16.playerType = _loc_2;
            _loc_16.playerColours = [_loc_3, _loc_4, _loc_5, _loc_6];
            _loc_16.playerAddons = _loc_7;
            _loc_16.mountOutfits = _loc_15;
            _loc_16.mountType = _loc_8;
            _loc_16.show();
            return;
        }// end function

        protected function readSCREATURELIGHT(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = param1.readUnsignedByte();
            var _loc_5:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_5.brightness = _loc_3;
                _loc_5.lightColour = Colour.s_FromEightBit(_loc_4);
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCATTACK(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                if (a_CreatureID != 0)
                {
                    this.m_Player.stopAutowalk(false);
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CATTACK);
                b.writeInt(a_CreatureID);
                b.writeInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CATTACK, e);
            }
            return;
        }// end function

        protected function readSPLAYERDATABASIC(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readBoolean();
            this.m_Player.premiumUntil = param1.readUnsignedInt();
            this.m_Player.premium = _loc_2;
            this.m_Player.profession = param1.readUnsignedByte();
            var _loc_3:* = [];
            var _loc_4:* = param1.readUnsignedShort() - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_3.push(param1.readUnsignedByte());
                _loc_4 = _loc_4 - 1;
            }
            this.m_Player.knownSpells = _loc_3;
            return;
        }// end function

        protected function readSTALK(param1:ByteArray) : void
        {
            var StatementID:int;
            var Speaker:String;
            var SpeakerLevel:int;
            var Mode:int;
            var Pos:Vector3D;
            var ChannelID:Object;
            var Text:String;
            var a_Bytes:* = param1;
            StatementID = a_Bytes.readUnsignedInt();
            Speaker = StringHelper.s_ReadLongStringFromByteArray(a_Bytes, Creature.MAX_NAME_LENGHT);
            SpeakerLevel = a_Bytes.readUnsignedShort();
            Mode = a_Bytes.readUnsignedByte();
            Pos;
            ChannelID;
            switch(Mode)
            {
                case MessageMode.MESSAGE_SAY:
                case MessageMode.MESSAGE_WHISPER:
                case MessageMode.MESSAGE_YELL:
                {
                    Pos = this.readCoordinate(a_Bytes);
                    ChannelID = ChatStorage.LOCAL_CHANNEL_ID;
                    break;
                }
                case MessageMode.MESSAGE_PRIVATE_FROM:
                {
                    Pos;
                    ChannelID = Speaker;
                    break;
                }
                case MessageMode.MESSAGE_CHANNEL:
                case MessageMode.MESSAGE_CHANNEL_HIGHLIGHT:
                {
                    Pos;
                    ChannelID = a_Bytes.readUnsignedShort();
                    break;
                }
                case MessageMode.MESSAGE_SPELL:
                {
                    Pos = this.readCoordinate(a_Bytes);
                    ChannelID = ChatStorage.LOCAL_CHANNEL_ID;
                    break;
                }
                case MessageMode.MESSAGE_NPC_FROM_START_BLOCK:
                {
                    Pos = this.readCoordinate(a_Bytes);
                    break;
                }
                case MessageMode.MESSAGE_NPC_FROM:
                {
                    break;
                }
                case MessageMode.MESSAGE_GAMEMASTER_BROADCAST:
                {
                    Pos;
                    ChannelID;
                    break;
                }
                case MessageMode.MESSAGE_GAMEMASTER_CHANNEL:
                {
                    Pos;
                    ChannelID = a_Bytes.readUnsignedShort();
                    break;
                }
                case MessageMode.MESSAGE_GAMEMASTER_PRIVATE_FROM:
                {
                    Pos;
                    ChannelID = Speaker;
                    break;
                }
                case MessageMode.MESSAGE_BARK_LOW:
                case MessageMode.MESSAGE_BARK_LOUD:
                {
                    Pos = this.readCoordinate(a_Bytes);
                    ChannelID;
                    break;
                }
                default:
                {
                    throw new Error("Connection.readSTALK: Invalid message mode " + Mode + ".", 0);
                    break;
                }
            }
            Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes, ChatStorage.MAX_TALK_LENGTH);
            if (Mode == MessageMode.MESSAGE_NPC_FROM_START_BLOCK)
            {
            }
            else if (Mode == MessageMode.MESSAGE_NPC_FROM)
            {
            }
            return;
        }// end function

        public function sendCLOOKATCREATURE(param1:int) : void
        {
            var b:ByteArray;
            var a_CreatureID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CLOOKATCREATURE);
                b.writeUnsignedInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CLOOKATCREATURE, e);
            }
            return;
        }// end function

        protected function readSCREATUREOUTFIT(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = this.readCreatureOutfit(param1, null);
            var _loc_4:* = this.readMountOutfit(param1, null);
            var _loc_5:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_5.outfit = _loc_3;
                _loc_5.mountOutfit = _loc_4;
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCROTATENORTH() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CROTATENORTH);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CROTATENORTH, e);
            }
            return;
        }// end function

        public function sendCBUYOBJECT(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
        {
            var b:ByteArray;
            var a_Type:* = param1;
            var a_Data:* = param2;
            var a_Amount:* = param3;
            var a_IgnoreCapacity:* = param4;
            var a_WithBackpacks:* = param5;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CBUYOBJECT);
                b.writeShort(a_Type);
                b.writeByte(a_Data);
                b.writeByte(a_Amount);
                b.writeBoolean(a_IgnoreCapacity);
                b.writeBoolean(a_WithBackpacks);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CBUYOBJECT, e);
            }
            return;
        }// end function

        protected function readSMARKETBROWSE(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_2 = param1.readUnsignedShort();
            _loc_3 = 0;
            _loc_4 = [];
            _loc_3 = param1.readUnsignedInt() - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4.push(this.readMarketOffer(param1, Offer.BUY_OFFER, _loc_2));
                _loc_3 = _loc_3 - 1;
            }
            _loc_3 = param1.readUnsignedInt() - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4.push(this.readMarketOffer(param1, Offer.SELL_OFFER, _loc_2));
                _loc_3 = _loc_3 - 1;
            }
            _loc_5 = PopUpBase.getCurrent() as MarketWidget;
            if (_loc_5 != null)
            {
                _loc_5.mergeBrowseOffers(_loc_2, _loc_4);
            }
            return;
        }// end function

        public function sendCROTATEEAST() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CROTATEEAST);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CROTATEEAST, e);
            }
            return;
        }// end function

        protected function readSCREATUREPVPHELPERS(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_4.numberOfPVPHelpers = _loc_3;
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        protected function readSMESSAGE(param1:ByteArray) : void
        {
            var SecondaryError:int;
            var Mode:int;
            var ChannelID:int;
            var Text:String;
            var Pos:Vector3D;
            var Value:Number;
            var Color:uint;
            var SpeakerMatch:Array;
            var Speaker:String;
            var NameFilter:NameFilterSet;
            var _MarketWidget:MarketWidget;
            var a_Bytes:* = param1;
            try
            {
                SecondaryError;
                Mode = a_Bytes.readUnsignedByte();
                ChannelID;
                Text;
                Pos;
                Value = NaN;
                Color;
                switch(Mode)
                {
                    case MessageMode.MESSAGE_CHANNEL_MANAGEMENT:
                    {
                        ChannelID = a_Bytes.readUnsignedShort();
                        Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes);
                        SpeakerMatch = Text.match(/^(.+?) invites you to |^You have been excluded from the channel ([^']+)'s Channel\.$/);
                        Speaker = SpeakerMatch != null ? (SpeakerMatch[1] != undefined ? (SpeakerMatch[1]) : (SpeakerMatch[2])) : (null);
                        NameFilter = Tibia.s_GetOptions().getNameFilterSet(NameFilterSet.DEFAULT_SET);
                        if (NameFilter != null && NameFilter.acceptMessage(Mode, Speaker, Text))
                        {
                            SecondaryError;
                            this.m_WorldMapStorage.addOnscreenMessage(null, -1, null, 0, Mode, Text);
                            SecondaryError;
                            this.m_ChatStorage.addChannelMessage(ChannelID, -1, null, 0, Mode, Text);
                        }
                        break;
                    }
                    case MessageMode.MESSAGE_GUILD:
                    case MessageMode.MESSAGE_PARTY_MANAGEMENT:
                    case MessageMode.MESSAGE_PARTY:
                    {
                        ChannelID = a_Bytes.readUnsignedShort();
                    }
                    case MessageMode.MESSAGE_LOGIN:
                    case MessageMode.MESSAGE_ADMIN:
                    case MessageMode.MESSAGE_GAME:
                    case MessageMode.MESSAGE_GAME_HIGHLIGHT:
                    case MessageMode.MESSAGE_FAILURE:
                    case MessageMode.MESSAGE_LOOK:
                    case MessageMode.MESSAGE_STATUS:
                    case MessageMode.MESSAGE_LOOT:
                    case MessageMode.MESSAGE_TRADE_NPC:
                    case MessageMode.MESSAGE_HOTKEY_USE:
                    {
                        Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes);
                        SecondaryError;
                        this.m_WorldMapStorage.addOnscreenMessage(null, -1, null, 0, Mode, Text);
                        SecondaryError;
                        this.m_ChatStorage.addChannelMessage(ChannelID, -1, null, 0, Mode, Text);
                        break;
                    }
                    case MessageMode.MESSAGE_MARKET:
                    {
                        Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes);
                        _MarketWidget = PopUpBase.getCurrent() as MarketWidget;
                        if (_MarketWidget != null)
                        {
                            _MarketWidget.serverResponsePending = false;
                            _MarketWidget.showMessage(Text);
                        }
                        break;
                    }
                    case MessageMode.MESSAGE_REPORT:
                    {
                        ReportWidget.s_ReportTimestampReset();
                        Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes);
                        SecondaryError;
                        this.m_WorldMapStorage.addOnscreenMessage(null, -1, null, 0, Mode, Text);
                        SecondaryError;
                        this.m_ChatStorage.addChannelMessage(-1, -1, null, 0, Mode, Text);
                        break;
                    }
                    case MessageMode.MESSAGE_DAMAGE_DEALED:
                    case MessageMode.MESSAGE_DAMAGE_RECEIVED:
                    case MessageMode.MESSAGE_DAMAGE_OTHERS:
                    {
                        Pos = this.readCoordinate(a_Bytes);
                        Value = a_Bytes.readUnsignedInt();
                        Color = a_Bytes.readUnsignedByte();
                        SecondaryError;
                        if (Value > 0)
                        {
                            this.m_WorldMapStorage.addOnscreenMessage(Pos, -1, null, 0, Mode, Value, Color);
                        }
                        Value = a_Bytes.readUnsignedInt();
                        Color = a_Bytes.readUnsignedByte();
                        SecondaryError;
                        if (Value > 0)
                        {
                            this.m_WorldMapStorage.addOnscreenMessage(Pos, -1, null, 0, Mode, Value, Color);
                        }
                        Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes);
                        SecondaryError;
                        this.m_ChatStorage.addChannelMessage(-1, -1, null, 0, Mode, Text);
                        break;
                    }
                    case MessageMode.MESSAGE_HEAL:
                    case MessageMode.MESSAGE_MANA:
                    case MessageMode.MESSAGE_EXP:
                    case MessageMode.MESSAGE_HEAL_OTHERS:
                    case MessageMode.MESSAGE_EXP_OTHERS:
                    {
                        Pos = this.readCoordinate(a_Bytes);
                        Value = a_Bytes.readUnsignedInt();
                        Color = a_Bytes.readUnsignedByte();
                        SecondaryError;
                        this.m_WorldMapStorage.addOnscreenMessage(Pos, -1, null, 0, Mode, Value, Color);
                        Text = StringHelper.s_ReadLongStringFromByteArray(a_Bytes);
                        SecondaryError;
                        this.m_ChatStorage.addChannelMessage(-1, -1, null, 0, Mode, Text);
                        break;
                    }
                    default:
                    {
                        throw new Error("Connection.readSMESSAGE: Invalid message mode " + Mode + ".", 0);
                        break;
                        break;
                    }
                }
            }
            catch (e:Error)
            {
                throw new Error("Connection.readSMESSAGE: Failed to add message of type " + Mode + ": " + e.message, SecondaryError);
            }
            return;
        }// end function

        protected function readSSHOWMODALDIALOG(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = false;
            var _loc_13:* = null;
            _loc_2 = param1.readUnsignedInt();
            _loc_3 = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_4 = StringHelper.s_ReadLongStringFromByteArray(param1);
            _loc_5 = new Vector.<Choice>;
            _loc_6 = null;
            _loc_7 = 0;
            _loc_8 = 0;
            _loc_8 = param1.readUnsignedByte();
            while (_loc_8 > 0)
            {
                
                _loc_6 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_7 = param1.readUnsignedByte();
                _loc_5.push(new Choice(_loc_6, _loc_7));
                _loc_8 = _loc_8 - 1;
            }
            _loc_9 = new Vector.<Choice>;
            _loc_8 = param1.readUnsignedByte();
            while (_loc_8 > 0)
            {
                
                _loc_6 = StringHelper.s_ReadLongStringFromByteArray(param1);
                _loc_7 = param1.readUnsignedByte();
                _loc_9.push(new Choice(_loc_6, _loc_7));
                _loc_8 = _loc_8 - 1;
            }
            _loc_10 = param1.readUnsignedByte();
            _loc_11 = param1.readUnsignedByte();
            _loc_12 = param1.readBoolean();
            _loc_13 = new ServerModalDialog(_loc_2);
            _loc_13.buttons = _loc_5;
            _loc_13.choices = _loc_9;
            _loc_13.defaultEnterButton = _loc_11;
            _loc_13.defaultEscapeButton = _loc_10;
            _loc_13.message = _loc_4;
            _loc_13.priority = PopUpBase.DEFAULT_PRIORITY + (_loc_12 ? (1) : (0));
            _loc_13.title = _loc_3;
            _loc_13.show();
            return;
        }// end function

        protected function readSCOUNTEROFFER(param1:ByteArray) : void
        {
            var _loc_8:* = null;
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1, Creature.MAX_NAME_LENGHT);
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = new ArrayCollection();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4.addItem(this.readObjectInstance(param1));
                _loc_5++;
            }
            var _loc_6:* = Tibia.s_GetOptions();
            var _loc_7:* = null;
            var _loc_9:* = _loc_6.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_7 = _loc_6.getSideBarSet(SideBarSet.DEFAULT_SET);
            if (_loc_6 != null && _loc_9 != null)
            {
                _loc_8 = _loc_7.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget;
                if (_loc_8 == null)
                {
                    _loc_8 = _loc_7.showWidgetType(Widget.TYPE_SAFETRADE, -1, -1) as SafeTradeWidget;
                }
                _loc_8.otherName = _loc_2;
                _loc_8.otherItems = _loc_4;
            }
            return;
        }// end function

        public function sendCJOINCHANNEL(param1:int) : void
        {
            var b:ByteArray;
            var a_ChannelID:* = param1;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CJOINCHANNEL);
                b.writeShort(a_ChannelID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CJOINCHANNEL, e);
            }
            return;
        }// end function

        public function get isGameRunning() : Boolean
        {
            return this.m_ServerConnection.isGameRunning;
        }// end function

        protected function readSCREATEONMAP(param1:ByteArray) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_2:* = this.readCoordinate(param1);
            if (!this.m_WorldMapStorage.isVisible(_loc_2.x, _loc_2.y, _loc_2.z, true))
            {
                throw new Error("Connection.readSCREATEONMAP: Co-ordinate " + _loc_2 + " is out of range.", 0);
            }
            var _loc_3:* = this.m_WorldMapStorage.toMap(_loc_2);
            var _loc_4:* = param1.readUnsignedByte();
            var _loc_5:* = param1.readUnsignedShort();
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (_loc_5 == AppearanceInstance.UNKNOWNCREATURE || _loc_5 == AppearanceInstance.OUTDATEDCREATURE || _loc_5 == AppearanceInstance.CREATURE)
            {
                _loc_7 = this.readCreatureInstance(param1, _loc_5, _loc_2);
                if (_loc_7.ID == this.m_Player.ID)
                {
                    this.m_Player.stopAutowalk(true);
                }
                _loc_6 = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE, _loc_7.ID);
            }
            else
            {
                _loc_6 = this.readObjectInstance(param1, _loc_5);
            }
            if (_loc_4 == 255)
            {
                this.m_WorldMapStorage.putObject(_loc_3.x, _loc_3.y, _loc_3.z, _loc_6);
            }
            else
            {
                if (_loc_4 >= MAPSIZE_W)
                {
                    throw new Error("Connection.readSCREATEONMAP: Invalid position.", 1);
                }
                this.m_WorldMapStorage.insertObject(_loc_3.x, _loc_3.y, _loc_3.z, _loc_4, _loc_6);
            }
            if (_loc_2.z == this.m_MiniMapStorage.getPositionZ())
            {
                this.m_WorldMapStorage.updateMiniMap(_loc_3.x, _loc_3.y, _loc_3.z);
                _loc_8 = this.m_WorldMapStorage.getMiniMapColour(_loc_3.x, _loc_3.y, _loc_3.z);
                _loc_9 = this.m_WorldMapStorage.getMiniMapCost(_loc_3.x, _loc_3.y, _loc_3.z);
                this.m_MiniMapStorage.updateField(_loc_2.x, _loc_2.y, _loc_2.z, _loc_8, _loc_9, false);
            }
            return;
        }// end function

        protected function readSCREATUREUNPASS(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readBoolean();
            var _loc_4:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_4.isUnpassable = _loc_3;
                ;
            }
            return;
        }// end function

        public function sendCGO(param1:Array) : void
        {
            var Type:int;
            var b:ByteArray;
            var i:int;
            var a_Path:* = param1;
            Type;
            try
            {
                this.m_CreatureStorage.clearTargets();
                if (a_Path == null || a_Path.length == 0)
                {
                    return;
                }
                b = this.m_ServerConnection.messageWriter.createMessage();
                switch(a_Path[0] & 65535)
                {
                    case PATH_EAST:
                    {
                        break;
                    }
                    case PATH_NORTH_EAST:
                    {
                        break;
                    }
                    case PATH_NORTH:
                    {
                        break;
                    }
                    case PATH_NORTH_WEST:
                    {
                        break;
                    }
                    case PATH_WEST:
                    {
                        break;
                    }
                    case PATH_SOUTH_WEST:
                    {
                        break;
                    }
                    case PATH_SOUTH:
                    {
                        break;
                    }
                    case PATH_SOUTH_EAST:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                while (i < a_Path.length)
                {
                }
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(Type, e);
            }
            return;
        }// end function

        protected function readSBUDDYSTATUSCHANGE(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_2 = param1.readUnsignedInt();
            _loc_3 = param1.readByte();
            _loc_4 = Tibia.s_GetOptions();
            _loc_5 = null;
            var _loc_6:* = _loc_4.getBuddySet(BuddySet.DEFAULT_SET);
            _loc_5 = _loc_4.getBuddySet(BuddySet.DEFAULT_SET);
            if (_loc_4 != null && _loc_6 != null)
            {
                _loc_5.updateBuddy(_loc_2, _loc_3);
            }
            return;
        }// end function

        public function sendCGUILDMESSAGE() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CGUILDMESSAGE);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPRIVATECHANNEL, e);
            }
            return;
        }// end function

        public function sendCUSEONCREATURE(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            var a_TypeID:* = param4;
            var a_PositionOrData:* = param5;
            var a_CreatureID:* = param6;
            try
            {
                this.m_Player.stopAutowalk(false);
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CUSEONCREATURE);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                b.writeShort(a_TypeID);
                b.writeByte(a_PositionOrData);
                b.writeUnsignedInt(a_CreatureID);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CUSEONCREATURE, e);
            }
            return;
        }// end function

        public function sendCBROWSEFIELD(param1:int, param2:int, param3:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CBROWSEFIELD);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CBROWSEFIELD, e);
            }
            return;
        }// end function

        protected function readSCREATURETYPE(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                _loc_4.type = _loc_3;
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCTURNOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var b:ByteArray;
            var a_X:* = param1;
            var a_Y:* = param2;
            var a_Z:* = param3;
            var a_TypeID:* = param4;
            var a_Position:* = param5;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CTURNOBJECT);
                b.writeShort(a_X);
                b.writeShort(a_Y);
                b.writeByte(a_Z);
                b.writeShort(a_TypeID);
                b.writeByte(a_Position);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CTURNOBJECT, e);
            }
            return;
        }// end function

        protected function readSCREATUREMARKS(param1:ByteArray) : void
        {
            var _loc_2:* = 0;
            _loc_2 = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            var _loc_4:* = param1.readUnsignedByte();
            var _loc_5:* = this.m_CreatureStorage.getCreature(_loc_2);
            if (this.m_CreatureStorage.getCreature(_loc_2) != null)
            {
                if (_loc_3 == 1)
                {
                    _loc_5.marks.setMark(Marks.MARK_TYPE_ONE_SECOND_TEMP, _loc_4);
                }
                else
                {
                    _loc_5.marks.setMark(Marks.MARK_TYPE_PERMANENT, _loc_4);
                }
                ;
            }
            this.m_CreatureStorage.invalidateOpponents();
            return;
        }// end function

        public function sendCINSPECTNPCTRADE(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var a_Type:* = param1;
            var a_Data:* = param2;
            try
            {
                b = this.m_ServerConnection.messageWriter.createMessage();
                b.writeByte(CINSPECTNPCTRADE);
                b.writeShort(a_Type);
                b.writeByte(a_Data);
                this.m_ServerConnection.messageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CINSPECTNPCTRADE, e);
            }
            return;
        }// end function

    }
}

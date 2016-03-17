package tibia.network
{
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import tibia.creatures.Creature;
   import tibia.appearances.AppearanceStorage;
   import tibia.appearances.AppearanceInstance;
   import tibia.appearances.OutfitInstance;
   import shared.utility.Vector3D;
   import tibia.market.Offer;
   import tibia.market.MarketWidget;
   import shared.utility.StringHelper;
   import tibia.market.OfferID;
   import tibia.options.OptionsStorage;
   import tibia.creatures.BuddySet;
   import flash.net.Socket;
   import flash.events.ProgressEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import tibia.reporting.reportType.Type;
   import tibia.reporting.ReportWidget;
   import tibia.game.EditListWidget;
   import tibia.appearances.ObjectInstance;
   import tibia.game.PopUpBase;
   import tibia.appearances.AppearanceTypeRef;
   import mx.collections.ArrayCollection;
   import mx.collections.IList;
   import tibia.chat.Channel;
   import tibia.chat.ChatStorage;
   import tibia.chat.ChannelSelectionWidget;
   import tibia.container.InventoryTypeInfo;
   import tibia.container.ContainerStorage;
   import mx.resources.ResourceManager;
   import tibia.container.Container;
   import tibia.trade.NPCTradeWidget;
   import tibia.trade.TradeObjectRef;
   import tibia.sidebar.SideBarSet;
   import tibia.sidebar.Widget;
   import tibia.worldmap.WorldMapStorage;
   import tibia.game.EditTextWidget;
   import tibia.chat.MessageMode;
   import tibia.questlog.QuestLogWidget;
   import tibia.questlog.QuestFlag;
   import tibia.magic.SpellStorage;
   import tibia.help.TutorialHint;
   import flash.utils.Endian;
   import flash.system.Security;
   import flash.utils.Timer;
   import flash.events.ErrorEvent;
   import tibia.creatures.Player;
   import tibia.trade.SafeTradeWidget;
   import tibia.appearances.EffectInstance;
   import shared.cryptography.XTEA;
   import tibia.game.BugReportWidget;
   import shared.utility.BrowserHelper;
   import flash.system.Capabilities;
   import tibia.creatures.CreatureStorage;
   import shared.cryptography.RSAPublicKey;
   import shared.utility.Colour;
   import tibia.minimap.MiniMapStorage;
   import tibia.market.OfferStatistics;
   import tibia.questlog.QuestLine;
   import tibia.appearances.AppearanceType;
   import tibia.creatures.SelectOutfitWidget;
   import tibia.appearances.MissileInstance;
   
   public class Connection extends EventDispatcher
   {
      
      protected static const CUPCONTAINER:int = 136;
      
      protected static const CQUITGAME:int = 20;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const CMARKETACCEPT:int = 248;
      
      protected static const CGONORTHWEST:int = 109;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const SOUTFIT:int = 200;
      
      protected static const CADDBUDDY:int = 220;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      protected static const CSETTACTICS:int = 160;
      
      protected static const CGOSOUTH:int = 103;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const ERR_COULD_NOT_CONNECT:int = 5;
      
      protected static const PATH_COST_OBSTACLE:int = 255;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      protected static const PACKETLENGTH_SIZE:int = 2;
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      protected static const SMESSAGE:int = 180;
      
      protected static const CPING:int = 29;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const SPLAYERDATABASIC:int = 159;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const CCLOSENPCCHANNEL:int = 158;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const CBUYOBJECT:int = 122;
      
      protected static const SPING:int = 29;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const CROTATENORTH:int = 111;
      
      protected static const SWAIT:int = 182;
      
      protected static const PATH_NORTH:int = 3;
      
      protected static const CGETQUESTLOG:int = 240;
      
      protected static const STATE_CONNECTING_STAGE2:int = 2;
      
      protected static const CHECKSUM_POS:int = PACKETLENGTH_POS + PACKETLENGTH_SIZE;
      
      protected static const CATTACK:int = 161;
      
      public static const LATENCY_LOW:Number = 200;
      
      protected static const CJOINCHANNEL:int = 152;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const STATE_CONNECTING_STAGE1:int = 1;
      
      protected static const CROTATEEAST:int = 112;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SBUDDYDATA:int = 210;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const CUSEONCREATURE:int = 132;
      
      public static const LATENCY_HIGH:Number = 1000;
      
      protected static const SCREATUREPARTY:int = 145;
      
      protected static const SQUESTLOG:int = 240;
      
      protected static const GROUND_LAYER:int = 7;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const ERR_INTERNAL:int = 0;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const SFIELDDATA:int = 105;
      
      protected static const PATH_EMPTY:int = 0;
      
      protected static const CCANCEL:int = 190;
      
      protected static const CREMOVEBUDDY:int = 221;
      
      protected static const CPASSLEADERSHIP:int = 166;
      
      protected static const SFULLMAP:int = 100;
      
      protected static const SCLOSECONTAINER:int = 111;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const SLEFTROW:int = 104;
      
      protected static const CGOWEST:int = 104;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const SMISSILEEFFECT:int = 133;
      
      protected static const PATH_MATRIX_SIZE:int = 2 * PATH_MAX_DISTANCE + 1;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PATH_ERROR_GO_UPSTAIRS:int = -2;
      
      protected static const PATH_COST_MAX:int = 250;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      private static const BUNDLE:String = "Connection";
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PATH_MAX_STEPS:int = 128;
      
      protected static const SSPELLGROUPDELAY:int = 165;
      
      protected static const SBOTTOMROW:int = 103;
      
      protected static const CGETOBJECTINFO:int = 243;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const CGOSOUTHWEST:int = 108;
      
      protected static const SLOGINERROR:int = 20;
      
      protected static const SQUESTLINE:int = 241;
      
      protected static const STATE_CONNECTED:int = 3;
      
      protected static const CREJECTTRADE:int = 128;
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const CREVOKEINVITATION:int = 165;
      
      protected static const SCREATURESKULL:int = 144;
      
      protected static const STRAPPERS:int = 135;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const SPLAYERDATACURRENT:int = 160;
      
      protected static const SBUDDYLOGIN:int = 211;
      
      protected static const CCLOSECONTAINER:int = 135;
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const CGETQUESTLINE:int = 241;
      
      protected static const SSNAPBACK:int = 181;
      
      protected static const CGETCHANNELS:int = 151;
      
      protected static const SOBJECTINFO:int = 244;
      
      protected static const NUM_EFFECTS:int = 200;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PATH_SOUTH:int = 7;
      
      protected static const CROTATESOUTH:int = 113;
      
      protected static const CACCEPTTRADE:int = 127;
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      protected static const PATH_NORTH_WEST:int = 4;
      
      protected static const ERR_CONNECTION_LOST:int = 6;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const SCHANNELS:int = 171;
      
      private static const PING_RETRY_COUNT:int = 3;
      
      protected static const SOPENCHANNEL:int = 172;
      
      protected static const STOPFLOOR:int = 190;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const SPRIVATECHANNEL:int = 173;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE + FIELD_HEIGHT;
      
      protected static const PATH_ERROR_UNREACHABLE:int = -4;
      
      protected static const PAYLOADLENGTH_POS:int = PAYLOAD_POS;
      
      protected static const SLOGINWAIT:int = 22;
      
      protected static const SCREATEONMAP:int = 106;
      
      protected static const SCHALLENGE:int = 31;
      
      protected static const PATH_SOUTH_WEST:int = 6;
      
      protected static const CLOOK:int = 140;
      
      protected static const ERR_INVALID_CHECKSUM:int = 2;
      
      protected static const CTRADEOBJECT:int = 125;
      
      protected static const CPRIVATECHANNEL:int = 154;
      
      protected static const SCONTAINER:int = 110;
      
      protected static const SNPCOFFER:int = 122;
      
      protected static const SBUDDYLOGOUT:int = 212;
      
      protected static const CEXCLUDEFROMCHANNEL:int = 172;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const PATH_WEST:int = 5;
      
      protected static const MAP_HEIGHT:int = 11;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const CMOUNT:int = 212;
      
      protected static const CCLOSENPCTRADE:int = 124;
      
      protected static const SMARKETBROWSE:int = 249;
      
      protected static const HEADER_POS:int = 0;
      
      protected static const CSELLOBJECT:int = 123;
      
      protected static const PRIME_2E16:int = 65521;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const CMARKETBROWSE:int = 245;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const SMARKETLEAVE:int = 247;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const SCOUNTEROFFER:int = 126;
      
      protected static const CFOLLOW:int = 162;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const PATH_EXISTS:int = 1;
      
      protected static const CMARKETCANCEL:int = 247;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const CENTERGAME:int = 10;
      
      protected static const SMARKETENTER:int = 246;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const SMARKCREATURE:int = 134;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const SCREATURESPEED:int = 143;
      
      protected static const SSPELLDELAY:int = 164;
      
      protected static const TERMINAL_VERSION:int = 950;
      
      protected static const SDELETEONMAP:int = 108;
      
      public static const LATENCY_MEDIUM:Number = 500;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const CROTATEWEST:int = 114;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const SCREATUREOUTFIT:int = 142;
      
      protected static const SAMBIENTE:int = 130;
      
      protected static const ERR_INVALID_SIZE:int = 1;
      
      protected static const CLEAVECHANNEL:int = 153;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const SPLAYERSKILLS:int = 161;
      
      protected static const CTHANKYOU:int = 231;
      
      protected static const SCREATUREUNPASS:int = 146;
      
      protected static const SKILL_STAMINA:int = 16;
      
      private static const PING_LATENCY_INTERVAL:uint = 15;
      
      protected static const CREFRESHCONTAINER:int = 202;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const SDELETEINCONTAINER:int = 114;
      
      protected static const PATH_MAX_DISTANCE:int = 110;
      
      protected static const SCREATEINCONTAINER:int = 112;
      
      protected static const CGONORTHEAST:int = 106;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const CERRORFILEENTRY:int = 232;
      
      protected static const HEADER_SIZE:int = PACKETLENGTH_SIZE + CHECKSUM_SIZE;
      
      protected static const CINSPECTNPCTRADE:int = 121;
      
      protected static const SCREATUREHEALTH:int = 140;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const SINITGAME:int = 10;
      
      protected static const STOPROW:int = 101;
      
      protected static const SBOTTOMFLOOR:int = 191;
      
      protected static const CTURNOBJECT:int = 133;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const CHECKSUM_SIZE:int = 4;
      
      protected static const ERR_INVALID_MESSAGE:int = 3;
      
      protected static const RECONNECT_DELAY:int = 3000;
      
      protected static const CUSEOBJECT:int = 130;
      
      protected static const CINVITETOCHANNEL:int = 171;
      
      protected static const CUSETWOOBJECTS:int = 131;
      
      protected static const PATH_ERROR_INTERNAL:int = -5;
      
      protected static const ERR_INVALID_STATE:int = 4;
      
      protected static const PATH_COST_UNDEFINED:int = 254;
      
      protected static const SCREATURELIGHT:int = 141;
      
      protected static const CINVITETOPARTY:int = 163;
      
      protected static const CPINGBACK:int = 30;
      
      protected static const SPINGBACK:int = 30;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const STUTORIALHINT:int = 220;
      
      protected static const SPLAYERGOODS:int = 123;
      
      protected static const CSTOP:int = 105;
      
      protected static const SPLAYERINVENTORY:int = 245;
      
      protected static const CMOVEOBJECT:int = 120;
      
      protected static const CRULEVIOLATIONREPORT:int = 242;
      
      protected static const SMOVECREATURE:int = 109;
      
      protected static const CGOEAST:int = 102;
      
      protected static const CEDITLIST:int = 138;
      
      protected static const CJOINPARTY:int = 164;
      
      protected static const SEDITLIST:int = 151;
      
      protected static const PK_NONE:int = 0;
      
      protected static const SCLOSETRADE:int = 127;
      
      protected static const SMULTIUSEDELAY:int = 166;
      
      private static const PING_RETRY_INTERVAL:uint = 5;
      
      protected static const SSETINVENTORY:int = 120;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const CLEAVEPARTY:int = 167;
      
      protected static const SCHANGEONMAP:int = 107;
      
      protected static const TERMINAL_TYPE:int = 3;
      
      protected static const CGOPATH:int = 100;
      
      protected static const CEQUIPOBJECT:int = 119;
      
      protected static const CGOSOUTHEAST:int = 107;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const COPENCHANNEL:int = 170;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const SCHANGEINCONTAINER:int = 113;
      
      protected static const SDEAD:int = 40;
      
      protected static const SDELETEINVENTORY:int = 121;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const STATE_DISCONNECTED:int = 0;
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const SLOGINADVICE:int = 21;
      
      protected static const SCHANNELEVENT:int = 243;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      protected static const MAP_MAX_Z:int = 15;
      
      protected static const SMARKETDETAIL:int = 248;
      
      protected static const CGONORTH:int = 101;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const CTALK:int = 150;
      
      protected static const PATH_NORTH_EAST:int = 2;
      
      protected static const PAYLOADDATA_POSITION:int = PAYLOADLENGTH_POS + PAYLOADLENGTH_SIZE;
      
      protected static const CEDITTEXT:int = 137;
      
      protected static const PATH_ERROR_TOO_FAR:int = -3;
      
      protected static const STALK:int = 170;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SCLOSENPCTRADE:int = 124;
      
      protected static const SRIGHTROW:int = 102;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const SGRAPHICALEFFECT:int = 131;
      
      protected static const SEDITTEXT:int = 150;
      
      protected static const SOPENOWNCHANNEL:int = 178;
      
      protected static const CINSPECTTRADE:int = 126;
      
      protected static const PAYLOADLENGTH_SIZE:int = 2;
      
      protected static const CBUGREPORT:int = 230;
      
      protected static const PATH_SOUTH_EAST:int = 8;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const CMARKETLEAVE:int = 244;
      
      protected static const CSHAREEXPERIENCE:int = 168;
      
      protected static const SCLEARTARGET:int = 163;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const SCLOSECHANNEL:int = 179;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const CSETOUTFIT:int = 211;
      
      protected static const PACKETLENGTH_POS:int = HEADER_POS;
      
      protected static const CGETOUTFIT:int = 210;
      
      protected static const SAUTOMAPFLAG:int = 221;
      
      protected static const SOWNOFFER:int = 125;
      
      protected static const PAYLOAD_POS:int = HEADER_POS + HEADER_SIZE;
      
      protected static const PATH_EAST:int = 1;
      
      protected static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PATH_MATRIX_CENTER:int = PATH_MAX_DISTANCE;
      
      protected static const CMARKETCREATE:int = 246;
      
      protected static const SPLAYERSTATE:int = 162;
       
      private var m_Address:String = null;
      
      private var m_AppearanceStorage:AppearanceStorage = null;
      
      private var m_BeatDuration:int = 0;
      
      private var m_LastEvent:int = 0;
      
      private var m_PingLatency:uint = 0;
      
      private var m_PingLatestTime:uint = 0;
      
      private var m_ConnectionState:int = 0;
      
      private var m_OutLength:int = 0;
      
      private var m_ContainerStorage:ContainerStorage = null;
      
      private var m_PingTimeout:uint = 0;
      
      private var m_WorldMapStorage:WorldMapStorage = null;
      
      private var m_CharacterName:String = null;
      
      private var m_SpellStorage:SpellStorage = null;
      
      private var m_BugreportsAllowed:Boolean = false;
      
      private var m_PingEarliestTime:uint = 0;
      
      private var m_ChatStorage:ChatStorage = null;
      
      private var m_Player:Player = null;
      
      private var m_LastSnapback:Vector3D;
      
      private var m_SessionKey:String = null;
      
      private var m_XTEA:XTEA = null;
      
      private var m_Port:int = 2.147483647E9;
      
      private var m_PingCount:int = 0;
      
      private var m_CreatureStorage:CreatureStorage = null;
      
      private var m_ConnectionDelay:Timer = null;
      
      private var m_MiniMapStorage:MiniMapStorage = null;
      
      private var m_SnapbackCount:int = 0;
      
      private var m_InBuffer:ByteArray = null;
      
      private var m_Nonce:uint = 0;
      
      private var m_PingTimer:Timer = null;
      
      private var m_RSAPublicKey:RSAPublicKey = null;
      
      private var m_Socket:Socket = null;
      
      private var m_OutBuffer:ByteArray = null;
      
      private var m_PendingQuestLog:Boolean = false;
      
      private var m_PendingQuestLine:int = -1;
      
      private var m_PingSent:uint = 0;
      
      private var m_ConnectedSince:int = 0;
      
      public function Connection(param1:AppearanceStorage, param2:ChatStorage, param3:ContainerStorage, param4:CreatureStorage, param5:MiniMapStorage, param6:Player, param7:SpellStorage, param8:WorldMapStorage)
      {
         this.m_LastSnapback = new Vector3D();
         super();
         this.m_ConnectionState = STATE_DISCONNECTED;
         this.m_Socket = null;
         this.m_InBuffer = new ByteArray();
         this.m_InBuffer.endian = Endian.LITTLE_ENDIAN;
         this.m_OutBuffer = new ByteArray();
         this.m_OutBuffer.endian = Endian.LITTLE_ENDIAN;
         this.m_OutLength = 0;
         this.m_RSAPublicKey = new RSAPublicKey();
         this.m_XTEA = new XTEA();
         if(param1 == null)
         {
            throw new Error("Connection.Connection: Invalid appearance data.",2147483645);
         }
         this.m_AppearanceStorage = param1;
         if(param2 == null)
         {
            throw new Error("Connection.Connection: Invalid chat data.",2147483644);
         }
         this.m_ChatStorage = param2;
         if(param3 == null)
         {
            throw new Error("Connection.Connection: Invalid container data.",2147483643);
         }
         this.m_ContainerStorage = param3;
         if(param4 == null)
         {
            throw new Error("Connection.Connection: Invalid creature list.",2147483642);
         }
         this.m_CreatureStorage = param4;
         if(param5 == null)
         {
            throw new Error("Connection.Connection: Invalid mini-map.",2147483641);
         }
         this.m_MiniMapStorage = param5;
         if(param6 == null)
         {
            throw new Error("Connection.Connection: Invalid player.",2147483640);
         }
         this.m_Player = param6;
         if(param7 == null)
         {
            throw new Error("Connection.Connection: Invalid spell data",2147483639);
         }
         this.m_SpellStorage = param7;
         if(param8 == null)
         {
            throw new Error("Connection.Connection: Invalid world map.",2147483638);
         }
         this.m_WorldMapStorage = param8;
      }
      
      protected static function s_GetAdler32(param1:ByteArray, param2:int = 0, param3:int = 0) : int
      {
         if(param1 == null)
         {
            throw new Error("Connection.s_GetAdler32: Invalid input.",2147483647);
         }
         if(param2 >= param1.length)
         {
            throw new Error("Connection.s_GetAdler32: Invalid offset.",2147483646);
         }
         var _loc4_:* = 1;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         param1.position = param2;
         while(param1.bytesAvailable > 0 && (param3 == 0 || _loc7_ < param3))
         {
            _loc6_ = param1.readUnsignedByte();
            _loc4_ = int((_loc4_ + _loc6_) % PRIME_2E16);
            _loc5_ = int((_loc5_ + _loc4_) % PRIME_2E16);
            _loc7_++;
         }
         _loc4_ = _loc4_ & 65535;
         _loc5_ = _loc5_ & 65535;
         return _loc5_ << 16 | _loc4_;
      }
      
      protected function readSCREATURESKULL(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.pkFlag = _loc3_;
         }
         else
         {
            log("Connection.readSCREATURESKULL: Creature not found: " + _loc2_);
         }
         this.m_CreatureStorage.invalidateOpponents();
      }
      
      protected function readMountOutfit(param1:ByteArray, param2:AppearanceInstance) : AppearanceInstance
      {
         if(param1 == null || param1.bytesAvailable < 2)
         {
            throw new Error("Connection.readMountOutfit: Not enough data.",2147483619);
         }
         var _loc3_:int = param1.readUnsignedShort();
         if(param2 is OutfitInstance && param2.ID == _loc3_)
         {
            return param2;
         }
         if(_loc3_ != 0)
         {
            return this.m_AppearanceStorage.createOutfitInstance(_loc3_,0,0,0,0,0);
         }
         return null;
      }
      
      public function sendCREMOVEBUDDY(param1:int) : void
      {
         var b:ByteArray = null;
         var a_ID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CREMOVEBUDDY);
            b.writeUnsignedInt(a_ID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CREMOVEBUDDY,e);
            return;
         }
      }
      
      protected function readSMARKCREATURE(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.markID = _loc3_;
         }
         else
         {
            log("Connection.readSMARKCREATURE: Creature not found: " + _loc2_);
         }
      }
      
      public function sendCUSEOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var b:ByteArray = null;
         var a_X:int = param1;
         var a_Y:int = param2;
         var a_Z:int = param3;
         var a_TypeID:int = param4;
         var a_PositionOrData:int = param5;
         var a_Window:int = param6;
         try
         {
            if(a_X != 65535)
            {
               this.m_Player.stopAutowalk(false);
            }
            b = this.createPacket();
            b.writeByte(CUSEOBJECT);
            b.writeShort(a_X);
            b.writeShort(a_Y);
            b.writeByte(a_Z);
            b.writeShort(a_TypeID);
            b.writeByte(a_PositionOrData);
            b.writeByte(a_Window);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CUSEOBJECT,e);
            return;
         }
      }
      
      protected function readSCLOSECHANNEL(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedShort();
         this.m_ChatStorage.closeChannel(_loc2_);
      }
      
      public function sendCPASSLEADERSHIP(param1:int) : void
      {
         var b:ByteArray = null;
         var a_CreatureID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CPASSLEADERSHIP);
            b.writeInt(a_CreatureID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CPASSLEADERSHIP,e);
            return;
         }
      }
      
      public function sendCCLOSECONTAINER(param1:int) : void
      {
         var b:ByteArray = null;
         var a_Window:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CCLOSECONTAINER);
            b.writeByte(a_Window);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CCLOSECONTAINER,e);
            return;
         }
      }
      
      public function sendCUSETWOOBJECTS(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int) : void
      {
         var b:ByteArray = null;
         var a_FirstX:int = param1;
         var a_FirstY:int = param2;
         var a_FirstZ:int = param3;
         var a_FirstTypeID:int = param4;
         var a_FirstPositionOrData:int = param5;
         var a_SndX:int = param6;
         var a_SndY:int = param7;
         var a_SndZ:int = param8;
         var a_SndTypeID:int = param9;
         var a_SndPosition:int = param10;
         try
         {
            if(a_FirstX != 65535 || a_SndX != 65535)
            {
               this.m_Player.stopAutowalk(false);
            }
            b = this.createPacket();
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
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CUSETWOOBJECTS,e);
            return;
         }
      }
      
      protected function readFloor(param1:ByteArray, param2:int, param3:int = 0) : int
      {
         var _loc10_:int = 0;
         if(param1 == null)
         {
            throw new Error("Connection.readFloor: Not enough data.",2147483617);
         }
         if(param2 < 0 || param2 >= MAPSIZE_Z)
         {
            throw new Error("Connection.readFloor: Floor number out of range.",2147483616);
         }
         var _loc4_:int = param3;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector3D = new Vector3D();
         var _loc8_:Vector3D = new Vector3D();
         var _loc9_:int = 0;
         while(_loc9_ <= MAPSIZE_X - 1)
         {
            _loc10_ = 0;
            while(_loc10_ <= MAPSIZE_Y - 1)
            {
               if(_loc4_ > 0)
               {
                  _loc4_--;
               }
               else
               {
                  _loc4_ = this.readField(param1,_loc9_,_loc10_,param2);
               }
               _loc7_.setComponents(_loc9_,_loc10_,param2);
               this.m_WorldMapStorage.toAbsolute(_loc7_,_loc8_);
               if(_loc8_.z == this.m_MiniMapStorage.getPositionZ())
               {
                  this.m_WorldMapStorage.updateMiniMap(_loc9_,_loc10_,param2);
                  _loc5_ = this.m_WorldMapStorage.getMiniMapColour(_loc9_,_loc10_,param2);
                  _loc6_ = this.m_WorldMapStorage.getMiniMapCost(_loc9_,_loc10_,param2);
                  this.m_MiniMapStorage.updateField(_loc8_.x,_loc8_.y,_loc8_.z,_loc5_,_loc6_,false);
               }
               _loc10_++;
            }
            _loc9_++;
         }
         return _loc4_;
      }
      
      protected function readSCREATUREHEALTH(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.setSkillValue(SKILL_HITPOINTS,_loc3_);
         }
         else
         {
            log("Connection.readSCREATUREHEALTH: Creature not found: " + _loc2_);
         }
         this.m_CreatureStorage.invalidateOpponents();
      }
      
      protected function readMarketOffer(param1:ByteArray, param2:int, param3:int) : Offer
      {
         var _loc4_:uint = param1.readUnsignedInt();
         var _loc5_:uint = param1.readUnsignedShort();
         var _loc6_:int = 0;
         switch(param3)
         {
            case MarketWidget.REQUEST_OWN_OFFERS:
            case MarketWidget.REQUEST_OWN_HISTORY:
               _loc6_ = param1.readUnsignedShort();
               break;
            default:
               _loc6_ = param3;
         }
         var _loc7_:int = param1.readUnsignedShort();
         var _loc8_:uint = param1.readUnsignedInt();
         var _loc9_:String = null;
         var _loc10_:int = Offer.ACTIVE;
         switch(param3)
         {
            case MarketWidget.REQUEST_OWN_OFFERS:
               break;
            case MarketWidget.REQUEST_OWN_HISTORY:
               _loc10_ = param1.readUnsignedByte();
               break;
            default:
               _loc9_ = StringHelper.s_ReadFromByteArray(param1);
         }
         return new Offer(new OfferID(_loc4_,_loc5_),param2,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
      }
      
      protected function readSBUDDYLOGOUT(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:OptionsStorage = null;
         var _loc4_:BuddySet = null;
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = Tibia.s_GetOptions();
         _loc4_ = null;
         if(_loc3_ != null && (_loc4_ = _loc3_.getBuddySet(BuddySet.DEFAULT_SET)) != null)
         {
            _loc4_.updateBuddy(_loc2_,false);
         }
      }
      
      protected function removeListeners(param1:Socket) : void
      {
         if(param1 != null)
         {
            param1.removeEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
            param1.removeEventListener(Event.CLOSE,this.onSocketClose);
            param1.removeEventListener(Event.CONNECT,this.onSocketConnect);
            param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
            param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketError);
         }
      }
      
      private function onCheckAlive(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ConnectionEvent = null;
         if(this.isGameRunning)
         {
            _loc2_ = this.m_PingTimer.currentCount;
            if(this.m_PingEarliestTime == 0)
            {
               this.m_PingEarliestTime = _loc2_;
            }
            if(_loc2_ >= this.m_PingEarliestTime && (_loc2_ - this.m_PingEarliestTime) % PING_RETRY_INTERVAL == 0 && uint((_loc2_ - this.m_PingEarliestTime) / PING_RETRY_INTERVAL) < PING_RETRY_COUNT)
            {
               this.m_PingTimeout = this.m_PingEarliestTime + PING_RETRY_COUNT * PING_RETRY_INTERVAL;
               this.m_PingCount++;
               this.m_PingSent = getTimer();
               this.sendCPING();
            }
            if(_loc2_ >= this.m_PingTimeout)
            {
               this.disconnectInternal();
               _loc3_ = new ConnectionEvent(ConnectionEvent.CONNECTION_LOST);
               dispatchEvent(_loc3_);
            }
         }
      }
      
      private function handleSendError(param1:int, param2:Error) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 != null?int(param2.errorID):-1;
         this.handleConnectionError(512 + param1,_loc3_,param2);
      }
      
      protected function readSTRAPPERS(param1:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Creature = null;
         var _loc2_:int = param1.readUnsignedByte();
         if(_loc2_ > NUM_TRAPPERS)
         {
            throw new Error("Connection.readSTRAPPERS: Too many trappers.",0);
         }
         var _loc3_:Vector.<Creature> = new Vector.<Creature>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = param1.readUnsignedInt();
            _loc6_ = this.m_CreatureStorage.getCreature(_loc5_);
            if(_loc6_ == null)
            {
               log("Connection.readSTRAPPERS: Creature not found: " + _loc5_);
            }
            _loc3_.push(_loc6_);
            _loc4_++;
         }
         this.m_CreatureStorage.setTrappers(_loc3_);
      }
      
      public function sendStatementCRULEVIOLATIONREPORT(param1:int, param2:String, param3:String, param4:String, param5:int) : void
      {
         var b:ByteArray = null;
         var a_Reason:int = param1;
         var a_CharacterName:String = param2;
         var a_Comment:String = param3;
         var a_Translation:String = param4;
         var a_StatementID:int = param5;
         try
         {
            if(a_Translation == null)
            {
               a_Translation = "";
            }
            b = this.createPacket();
            b.writeByte(CRULEVIOLATIONREPORT);
            b.writeByte(Type.REPORT_STATEMENT);
            b.writeByte(a_Reason);
            StringHelper.s_WriteToByteArray(b,a_CharacterName,Creature.MAX_NAME_LENGHT);
            StringHelper.s_WriteToByteArray(b,a_Comment,ReportWidget.MAX_COMMENT_LENGTH);
            StringHelper.s_WriteToByteArray(b,a_Translation,ReportWidget.MAX_TRANSLATION_LENGTH);
            b.writeUnsignedInt(a_StatementID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CRULEVIOLATIONREPORT,e);
            return;
         }
      }
      
      protected function sendCPINGBACK() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CPINGBACK);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CPINGBACK,e);
            return;
         }
      }
      
      protected function readSEDITLIST(param1:ByteArray) : void
      {
         var _loc2_:EditListWidget = new EditListWidget();
         _loc2_.type = param1.readUnsignedByte();
         _loc2_.ID = param1.readUnsignedInt();
         _loc2_.text = StringHelper.s_ReadFromByteArray(param1);
         _loc2_.show();
      }
      
      public function sendCINVITETOPARTY(param1:int) : void
      {
         var Bytes:ByteArray = null;
         var a_CreatureID:int = param1;
         try
         {
            Bytes = this.createPacket();
            Bytes.writeByte(CINVITETOPARTY);
            Bytes.writeInt(a_CreatureID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CINVITETOPARTY,e);
            return;
         }
      }
      
      protected function readSTOPROW(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.m_WorldMapStorage.getPosition();
         _loc2_.y--;
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_WorldMapStorage.scrollMap(0,1);
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         this.readArea(param1,0,0,MAPSIZE_X - 1,0);
      }
      
      protected function readObjectInstance(param1:ByteArray, param2:int = -1) : ObjectInstance
      {
         if(param1 == null || param2 == -1 && param1.bytesAvailable < 2)
         {
            throw new Error("Connection.readObjectInstance: Not enough data.",2147483628);
         }
         if(param2 == -1)
         {
            param2 = param1.readUnsignedShort();
         }
         if(param2 <= AppearanceInstance.CREATURE)
         {
            throw new Error("Connection.readObjectInstance: Invalid type.",2147483627);
         }
         var _loc3_:ObjectInstance = this.m_AppearanceStorage.createObjectInstance(param2,0);
         if(_loc3_ == null || _loc3_.m_Type == null)
         {
            throw new Error("Connection.readObjectInstance: Invalid instance.",2147483626);
         }
         if(Boolean(_loc3_.m_Type.isLiquidContainer) || Boolean(_loc3_.m_Type.isLiquidPool) || Boolean(_loc3_.m_Type.isCumulative))
         {
            _loc3_.data = param1.readUnsignedByte();
         }
         if(_loc3_.m_Type.isAnimation)
         {
            _loc3_.phase = param1.readUnsignedByte();
         }
         return _loc3_;
      }
      
      protected function readSSNAPBACK(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector3D = null;
         _loc2_ = param1.readUnsignedByte();
         _loc3_ = this.m_Player.position;
         if(_loc3_.equals(this.m_LastSnapback))
         {
            this.m_SnapbackCount++;
         }
         else
         {
            this.m_SnapbackCount = 0;
         }
         this.m_LastSnapback.setVector(_loc3_);
         if(this.m_SnapbackCount >= 16)
         {
            this.m_Player.stopAutowalk(true);
            this.m_CreatureStorage.setAttackTarget(null,false);
            this.sendCCANCEL();
            this.m_SnapbackCount = 0;
         }
         this.m_Player.abortAutowalk(_loc2_);
      }
      
      protected function readSFULLMAP(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.readCoordinate(param1);
         this.m_Player.stopAutowalk(true);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_WorldMapStorage.resetMap();
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_CreatureStorage.markAllOpponentsVisible(false);
         this.readArea(param1,0,0,MAPSIZE_X - 1,MAPSIZE_Y - 1);
         this.m_WorldMapStorage.valid = true;
      }
      
      public function sendCINVITETOCHANNEL(param1:String) : void
      {
         var b:ByteArray = null;
         var a_Name:String = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CINVITETOCHANNEL);
            StringHelper.s_WriteToByteArray(b,a_Name,Creature.MAX_NAME_LENGHT);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CINVITETOCHANNEL,e);
            return;
         }
      }
      
      protected function sendPacket(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this.m_OutLength = this.m_OutBuffer.position;
         if(param1)
         {
            _loc3_ = this.m_OutLength - HEADER_SIZE;
            this.m_OutBuffer.position = PAYLOADLENGTH_POS;
            this.m_OutBuffer.writeShort(_loc3_ - PAYLOADLENGTH_SIZE);
            this.m_OutLength = PAYLOAD_POS + this.m_XTEA.encrypt(this.m_OutBuffer,PAYLOAD_POS,_loc3_);
         }
         _loc2_ = s_GetAdler32(this.m_OutBuffer,PAYLOAD_POS,this.m_OutLength - HEADER_SIZE);
         this.m_OutBuffer.position = CHECKSUM_POS;
         this.m_OutBuffer.writeUnsignedInt(_loc2_);
         this.m_OutBuffer.position = PACKETLENGTH_POS;
         this.m_OutBuffer.writeShort(this.m_OutLength - PACKETLENGTH_SIZE);
         this.m_Socket.writeBytes(this.m_OutBuffer,0,this.m_OutLength);
         this.m_Socket.flush();
         this.m_OutBuffer.position = PAYLOAD_POS;
         this.m_OutLength = 0;
      }
      
      public function sendCSTOP() : void
      {
         var b:ByteArray = null;
         try
         {
            this.m_CreatureStorage.clearTargets();
            b = this.createPacket();
            b.writeByte(CSTOP);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CSTOP,e);
            return;
         }
      }
      
      protected function readSMARKETLEAVE(param1:ByteArray) : void
      {
         var _loc2_:MarketWidget = null;
         _loc2_ = PopUpBase.s_GetInstance() as MarketWidget;
         if(_loc2_ != null)
         {
            _loc2_.close(true);
         }
      }
      
      protected function onDelayComplete(param1:TimerEvent) : void
      {
         var a_Event:TimerEvent = param1;
         if(a_Event != null)
         {
            try
            {
               this.m_ConnectionDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayComplete);
               this.m_ConnectionDelay.stop();
               this.m_ConnectionDelay = null;
               this.m_LastEvent = getTimer();
               this.m_Socket.connect(this.m_Address,this.m_Port);
               return;
            }
            catch(e:Error)
            {
               handleConnectionError(ERR_COULD_NOT_CONNECT,0,e);
               return;
            }
         }
      }
      
      protected function readSLEFTROW(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.m_WorldMapStorage.getPosition();
         _loc2_.x--;
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_WorldMapStorage.scrollMap(1,0);
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         this.readArea(param1,0,0,0,MAPSIZE_Y - 1);
      }
      
      protected function readSCLOSECONTAINER(param1:ByteArray) : void
      {
         this.m_ContainerStorage.closeOpenContainer(param1.readUnsignedByte());
      }
      
      public function sendCGETOBJECTINFO(... rest) : void
      {
         var b:ByteArray = null;
         var v:Vector.<AppearanceTypeRef> = null;
         var i:int = 0;
         var n:int = 0;
         var a_Parameters:Array = rest;
         try
         {
            b = null;
            if(a_Parameters.length == 1 && a_Parameters[0] is Vector.<AppearanceTypeRef>)
            {
               v = a_Parameters[0] as Vector.<AppearanceTypeRef>;
               i = 0;
               n = Math.min(v.length,255);
               if(n > 0)
               {
                  b = this.createPacket();
                  b.writeByte(CGETOBJECTINFO);
                  b.writeByte(n);
                  i = 0;
                  while(i < n)
                  {
                     b.writeShort(v[i].ID);
                     b.writeByte(v[i].data);
                     i++;
                  }
                  this.sendPacket(true);
               }
            }
            else if(a_Parameters.length == 2)
            {
               b = this.createPacket();
               b.writeByte(CGETOBJECTINFO);
               b.writeByte(1);
               b.writeShort(int(a_Parameters[i]));
               b.writeByte(int(a_Parameters[i]));
               this.sendPacket(true);
            }
            else
            {
               throw new Error("Connection.sendCGETOBJECTINFO: Illegal overload.",0);
            }
            return;
         }
         catch(e:Error)
         {
            handleSendError(CGETOBJECTINFO,e);
            return;
         }
      }
      
      public function sendCMOVEOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int) : void
      {
         var b:ByteArray = null;
         var a_StartX:int = param1;
         var a_StartY:int = param2;
         var a_StartZ:int = param3;
         var a_TypeID:int = param4;
         var a_Position:int = param5;
         var a_DestX:int = param6;
         var a_DestY:int = param7;
         var a_DestZ:int = param8;
         var a_Amount:int = param9;
         try
         {
            if(a_StartX != 65535)
            {
               this.m_Player.stopAutowalk(false);
            }
            b = this.createPacket();
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
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMOVEOBJECT,e);
            return;
         }
      }
      
      protected function readSCHANNELS(param1:ByteArray) : void
      {
         var _loc2_:IList = new ArrayCollection();
         var _loc3_:int = param1.readUnsignedByte();
         while(_loc3_ > 0)
         {
            _loc2_.addItem({
               "ID":param1.readUnsignedShort(),
               "name":StringHelper.s_ReadFromByteArray(param1,Channel.MAX_NAME_LENGTH)
            });
            _loc3_--;
         }
         _loc2_.addItem({
            "ID":ChatStorage.NPC_CHANNEL_ID,
            "name":ChatStorage.NPC_CHANNEL_LABEL
         });
         var _loc4_:ChannelSelectionWidget = new ChannelSelectionWidget();
         _loc4_.channels = _loc2_;
         _loc4_.show();
      }
      
      protected function readSSPELLGROUPDELAY(param1:ByteArray) : void
      {
         this.m_SpellStorage.setSpellGroupDelay(param1.readUnsignedByte(),param1.readUnsignedInt());
      }
      
      protected function readCreatureOutfit(param1:ByteArray, param2:AppearanceInstance) : AppearanceInstance
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param1 == null || param1.bytesAvailable < 4)
         {
            throw new Error("Connection.readCreatureOutfit: Not enough data.",2147483620);
         }
         var _loc3_:int = param1.readUnsignedShort();
         if(_loc3_ != 0)
         {
            _loc4_ = param1.readUnsignedByte();
            _loc5_ = param1.readUnsignedByte();
            _loc6_ = param1.readUnsignedByte();
            _loc7_ = param1.readUnsignedByte();
            _loc8_ = param1.readUnsignedByte();
            if(param2 is OutfitInstance && param2.ID == _loc3_)
            {
               OutfitInstance(param2).updateProperties(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
               return param2;
            }
            return this.m_AppearanceStorage.createOutfitInstance(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
         }
         _loc9_ = param1.readUnsignedShort();
         if(param2 is ObjectInstance && param2.ID == _loc9_)
         {
            return param2;
         }
         if(_loc9_ == 0)
         {
            return this.m_AppearanceStorage.createOutfitInstance(OutfitInstance.INVISIBLE_OUTFIT_ID,0,0,0,0,0);
         }
         return this.m_AppearanceStorage.createObjectInstance(_loc9_,0);
      }
      
      public function sendCREVOKEINVITATION(param1:int) : void
      {
         var b:ByteArray = null;
         var a_CreatureID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CREVOKEINVITATION);
            b.writeInt(a_CreatureID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CREVOKEINVITATION,e);
            return;
         }
      }
      
      protected function readSTOPFLOOR(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = null;
         var _loc3_:Vector3D = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = this.m_WorldMapStorage.getPosition();
         _loc2_.x++;
         _loc2_.y++;
         _loc2_.z--;
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         if(_loc2_.z > GROUND_LAYER)
         {
            this.m_WorldMapStorage.scrollMap(0,0,-1);
            this.readFloor(param1,2 * UNDERGROUND_LAYER,0);
         }
         else if(_loc2_.z == GROUND_LAYER)
         {
            this.m_WorldMapStorage.scrollMap(0,0,-(UNDERGROUND_LAYER + 1));
            _loc7_ = 0;
            _loc8_ = UNDERGROUND_LAYER;
            while(_loc8_ <= GROUND_LAYER)
            {
               _loc7_ = this.readFloor(param1,_loc8_,_loc7_);
               _loc8_++;
            }
         }
         this.m_Player.stopAutowalk(true);
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         _loc3_ = this.m_WorldMapStorage.toMap(_loc2_);
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         while(_loc6_ < MAPSIZE_X)
         {
            _loc9_ = 0;
            while(_loc9_ < MAPSIZE_Y)
            {
               _loc3_.x = _loc6_;
               _loc3_.y = _loc9_;
               _loc2_ = this.m_WorldMapStorage.toAbsolute(_loc3_,_loc2_);
               this.m_WorldMapStorage.updateMiniMap(_loc3_.x,_loc3_.y,_loc3_.z);
               _loc4_ = this.m_WorldMapStorage.getMiniMapColour(_loc3_.x,_loc3_.y,_loc3_.z);
               _loc5_ = this.m_WorldMapStorage.getMiniMapCost(_loc3_.x,_loc3_.y,_loc3_.z);
               this.m_MiniMapStorage.updateField(_loc2_.x,_loc2_.y,_loc2_.z,_loc4_,_loc5_,false);
               _loc9_++;
            }
            _loc6_++;
         }
      }
      
      protected function readSPLAYERINVENTORY(param1:ByteArray) : void
      {
         var _loc2_:Vector.<InventoryTypeInfo> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = new Vector.<InventoryTypeInfo>();
         _loc3_ = param1.readUnsignedShort() - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = param1.readUnsignedByte();
            _loc6_ = param1.readUnsignedShort();
            _loc2_.push(new InventoryTypeInfo(_loc4_,_loc5_,_loc6_));
            _loc3_--;
         }
         this.m_ContainerStorage.setPlayerInventory(_loc2_);
      }
      
      protected function readSMARKETENTER(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:MarketWidget = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = param1.readUnsignedByte();
         _loc4_ = [];
         _loc5_ = param1.readUnsignedShort() - 1;
         while(_loc5_ >= 0)
         {
            _loc7_ = param1.readUnsignedShort();
            _loc8_ = param1.readUnsignedShort();
            _loc4_.push(new InventoryTypeInfo(_loc7_,0,_loc8_));
            _loc5_--;
         }
         _loc6_ = PopUpBase.s_GetInstance() as MarketWidget;
         if(_loc6_ == null)
         {
            _loc6_ = new MarketWidget();
            _loc6_.show();
         }
         _loc6_.serverResponsePending = false;
         _loc6_.accountBalance = _loc2_;
         _loc6_.activeOffers = _loc3_;
         _loc6_.depotContent = _loc4_;
      }
      
      protected function readSPLAYERSKILLS(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [SKILL_FIGHTFIST,SKILL_FIGHTCLUB,SKILL_FIGHTSWORD,SKILL_FIGHTAXE,SKILL_FIGHTDISTANCE,SKILL_FIGHTSHIELD,SKILL_FISHING];
         for each(_loc3_ in _loc2_)
         {
            this.m_Player.setSkill(_loc3_,param1.readUnsignedByte(),param1.readUnsignedByte(),param1.readUnsignedByte());
         }
      }
      
      public function sendCEDITLIST(param1:int, param2:int, param3:String) : void
      {
         var b:ByteArray = null;
         var a_Type:int = param1;
         var a_ID:int = param2;
         var a_Text:String = param3;
         try
         {
            b = this.createPacket();
            b.writeByte(CEDITLIST);
            b.writeByte(a_Type);
            b.writeUnsignedInt(a_ID);
            StringHelper.s_WriteToByteArray(b,a_Text);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CEDITLIST,e);
            return;
         }
      }
      
      protected function onSocketConnect(param1:Event) : void
      {
         this.m_LastEvent = this.m_ConnectedSince = getTimer();
         if(this.m_ConnectionState != STATE_CONNECTING_STAGE1)
         {
            this.handleConnectionError(ERR_INVALID_STATE,1,param1);
         }
      }
      
      protected function readSCLEARTARGET(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         if(_loc2_ == 0 || _loc2_ == this.m_Nonce)
         {
            this.m_CreatureStorage.setAttackTarget(null,false);
         }
      }
      
      public function sendCREJECTTRADE() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CREJECTTRADE);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CREJECTTRADE,e);
            return;
         }
      }
      
      public function sendCGETCHANNELS() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CGETCHANNELS);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CGETCHANNELS,e);
            return;
         }
      }
      
      protected function readSPING(param1:ByteArray) : void
      {
         this.sendCPINGBACK();
      }
      
      protected function readSWAIT(param1:ByteArray) : void
      {
         this.m_Player.earliestMoveTime = this.m_Player.earliestMoveTime + param1.readUnsignedShort();
      }
      
      protected function readSBUDDYDATA(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:OptionsStorage = null;
         var _loc6_:BuddySet = null;
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
         _loc4_ = param1.readUnsignedByte() == 1;
         _loc5_ = Tibia.s_GetOptions();
         _loc6_ = null;
         if(_loc5_ != null && (_loc6_ = _loc5_.getBuddySet(BuddySet.DEFAULT_SET)) != null)
         {
            _loc6_.updateBuddy(_loc2_,_loc3_,_loc4_);
         }
      }
      
      public function sendBotCRULEVIOLATIONREPORT(param1:int, param2:String, param3:String) : void
      {
         var b:ByteArray = null;
         var a_Reason:int = param1;
         var a_CharacterName:String = param2;
         var a_Comment:String = param3;
         try
         {
            b = this.createPacket();
            b.writeByte(CRULEVIOLATIONREPORT);
            b.writeByte(Type.REPORT_BOT);
            b.writeByte(a_Reason);
            StringHelper.s_WriteToByteArray(b,a_CharacterName,Creature.MAX_NAME_LENGHT);
            StringHelper.s_WriteToByteArray(b,a_Comment,ReportWidget.MAX_COMMENT_LENGTH);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CRULEVIOLATIONREPORT,e);
            return;
         }
      }
      
      public function sendCGETQUESTLINE(param1:int) : void
      {
         var b:ByteArray = null;
         var a_QuestLine:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CGETQUESTLINE);
            b.writeShort(a_QuestLine);
            this.sendPacket(true);
            this.m_PendingQuestLine = a_QuestLine;
            return;
         }
         catch(e:Error)
         {
            handleSendError(CGETQUESTLINE,e);
            return;
         }
      }
      
      protected function readSAUTOMAPFLAG(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = param1.readUnsignedShort();
         _loc3_ = param1.readUnsignedShort();
         _loc4_ = param1.readUnsignedByte();
         _loc5_ = param1.readUnsignedByte();
         _loc6_ = StringHelper.s_ReadFromByteArray(param1);
         this.m_MiniMapStorage.setMark(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
         this.m_MiniMapStorage.highlightMarks();
      }
      
      public function sendCJOINPARTY(param1:int) : void
      {
         var b:ByteArray = null;
         var a_CreatureID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CJOINPARTY);
            b.writeInt(a_CreatureID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CJOINPARTY,e);
            return;
         }
      }
      
      private function handleConnectionError(param1:int, param2:int = 0, param3:Object = null) : void
      {
         var _loc4_:String = null;
         var _loc5_:ConnectionEvent = null;
         this.disconnectInternal();
         _loc4_ = null;
         switch(param1)
         {
            case ERR_COULD_NOT_CONNECT:
               _loc4_ = ResourceManager.getInstance().getString(BUNDLE,"MSG_COULD_NOT_CONNECT");
               break;
            case ERR_CONNECTION_LOST:
               _loc4_ = ResourceManager.getInstance().getString(BUNDLE,"MSG_LOST_CONNECTION");
               break;
            case ERR_INTERNAL:
            default:
               _loc4_ = ResourceManager.getInstance().getString(BUNDLE,"MSG_INTERNAL_ERROR",[param1,param2]);
         }
         _loc5_ = new ConnectionEvent(ConnectionEvent.ERROR);
         _loc5_.message = _loc4_;
         _loc5_.data = null;
         dispatchEvent(_loc5_);
      }
      
      protected function readSDELETEINCONTAINER(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:Container = this.m_ContainerStorage.getOpenContainer(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.removeItemAt(_loc3_);
            if(_loc4_.length == ContainerStorage.ITEMS_PER_CONTAINER - 1)
            {
               this.sendCREFRESHCONTAINER(_loc2_);
            }
         }
      }
      
      public function sendCLEAVEPARTY() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CLEAVEPARTY);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CLEAVEPARTY,e);
            return;
         }
      }
      
      public function get connectionDuration() : int
      {
         if(this.m_ConnectionState == STATE_CONNECTED)
         {
            return getTimer() - this.m_ConnectedSince;
         }
         return 0;
      }
      
      protected function readSPLAYERSTATE(param1:ByteArray) : void
      {
         var _loc2_:uint = param1.readUnsignedShort();
         this.m_Player.stateFlags = _loc2_;
      }
      
      protected function readSDELETEONMAP(param1:ByteArray) : void
      {
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc2_:int = param1.readUnsignedShort();
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector3D = null;
         var _loc6_:Vector3D = null;
         var _loc7_:ObjectInstance = null;
         var _loc8_:Creature = null;
         if(_loc2_ != 65535)
         {
            _loc5_ = this.readCoordinate(param1,_loc2_);
            if(!this.m_WorldMapStorage.isVisible(_loc5_.x,_loc5_.y,_loc5_.z,true))
            {
               throw new Error("Connection.readSDELETEONMAP: Co-ordinate " + _loc5_ + " is out of range.",0);
            }
            _loc6_ = this.m_WorldMapStorage.toMap(_loc5_);
            _loc4_ = param1.readUnsignedByte();
            if((_loc7_ = this.m_WorldMapStorage.getObject(_loc6_.x,_loc6_.y,_loc6_.z,_loc4_)) == null)
            {
               throw new Error("Connection.readSDELETEONMAP: Object not found.",1);
            }
            if(_loc7_.ID == AppearanceInstance.CREATURE && (_loc8_ = this.m_CreatureStorage.getCreature(_loc7_.data)) == null)
            {
               throw new Error("Connection.readSDELETEONMAP: Creature not found: " + _loc7_.data,2);
            }
            this.m_WorldMapStorage.deleteObject(_loc6_.x,_loc6_.y,_loc6_.z,_loc4_);
         }
         else
         {
            _loc3_ = param1.readUnsignedInt();
            if((_loc8_ = this.m_CreatureStorage.getCreature(_loc3_)) == null)
            {
               throw new Error("Connection.readSDELETEONMAP: Creature not found: " + _loc3_,3);
            }
            _loc5_ = _loc8_.position;
            if(!this.m_WorldMapStorage.isVisible(_loc5_.x,_loc5_.y,_loc5_.z,true))
            {
               throw new Error("Connection.readSDELETEONMAP: Co-ordinate " + _loc5_ + " is out of range.",4);
            }
            _loc6_ = this.m_WorldMapStorage.toMap(_loc5_);
         }
         if(_loc8_ != null)
         {
            this.m_CreatureStorage.markOpponentVisible(_loc8_,false);
         }
         if(_loc5_.z == this.m_MiniMapStorage.getPositionZ())
         {
            this.m_WorldMapStorage.updateMiniMap(_loc6_.x,_loc6_.y,_loc6_.z);
            _loc9_ = this.m_WorldMapStorage.getMiniMapColour(_loc6_.x,_loc6_.y,_loc6_.z);
            _loc10_ = this.m_WorldMapStorage.getMiniMapCost(_loc6_.x,_loc6_.y,_loc6_.z);
            this.m_MiniMapStorage.updateField(_loc5_.x,_loc5_.y,_loc5_.z,_loc9_,_loc10_,false);
         }
      }
      
      public function sendCROTATESOUTH() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CROTATESOUTH);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CROTATESOUTH,e);
            return;
         }
      }
      
      protected function readSNPCOFFER(param1:ByteArray) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:NPCTradeWidget = null;
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1);
         var _loc3_:IList = new ArrayCollection();
         var _loc4_:IList = new ArrayCollection();
         var _loc5_:int = param1.readUnsignedShort();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = param1.readUnsignedShort();
            _loc10_ = param1.readUnsignedByte();
            _loc11_ = StringHelper.s_ReadFromByteArray(param1,NPCTradeWidget.MAX_WARE_NAME_LENGTH);
            _loc12_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc14_ = param1.readUnsignedInt();
            if(_loc13_ > 0)
            {
               _loc3_.addItem(new TradeObjectRef(_loc9_,_loc10_,_loc11_,_loc13_,_loc12_));
            }
            if(_loc14_ > 0)
            {
               _loc4_.addItem(new TradeObjectRef(_loc9_,_loc10_,_loc11_,_loc14_,_loc12_));
            }
            _loc6_++;
         }
         var _loc7_:OptionsStorage = Tibia.s_GetOptions();
         var _loc8_:SideBarSet = null;
         if(_loc7_ != null && (_loc8_ = _loc7_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null)
         {
            _loc15_ = _loc8_.getWidgetByType(Widget.TYPE_NPCTRADE) as NPCTradeWidget;
            if(_loc15_ == null)
            {
               _loc15_ = _loc8_.showWidgetType(Widget.TYPE_NPCTRADE,-1,-1) as NPCTradeWidget;
            }
            _loc15_.npcName = _loc2_;
            _loc15_.buyObjects = _loc3_;
            _loc15_.sellObjects = _loc4_;
            _loc15_.categories = null;
         }
      }
      
      public function sendCPRIVATECHANNEL(param1:String) : void
      {
         var b:ByteArray = null;
         var a_Name:String = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CPRIVATECHANNEL);
            StringHelper.s_WriteToByteArray(b,a_Name,Creature.MAX_NAME_LENGHT);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CPRIVATECHANNEL,e);
            return;
         }
      }
      
      public function disconnect(param1:Boolean) : void
      {
         var _loc2_:ConnectionEvent = null;
         if(this.m_ConnectionState == STATE_CONNECTED && !param1)
         {
            this.sendCQUITGAME();
         }
         else
         {
            this.disconnectInternal();
            _loc2_ = new ConnectionEvent(ConnectionEvent.DISCONNECTED);
            dispatchEvent(_loc2_);
         }
      }
      
      protected function addListeners(param1:Socket) : void
      {
         if(param1 != null)
         {
            param1.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
            param1.addEventListener(Event.CLOSE,this.onSocketClose);
            param1.addEventListener(Event.CONNECT,this.onSocketConnect);
            param1.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
            param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketError);
         }
      }
      
      protected function readSSPELLDELAY(param1:ByteArray) : void
      {
         this.m_SpellStorage.setSpellDelay(param1.readUnsignedByte(),param1.readUnsignedInt());
      }
      
      public function sendCACCEPTTRADE() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CACCEPTTRADE);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CACCEPTTRADE,e);
            return;
         }
      }
      
      protected function createPacket() : ByteArray
      {
         this.m_OutBuffer.position = PAYLOADDATA_POSITION;
         this.m_OutLength = HEADER_SIZE;
         return this.m_OutBuffer;
      }
      
      protected function readSCLOSENPCTRADE(param1:ByteArray) : void
      {
         var _loc2_:OptionsStorage = Tibia.s_GetOptions();
         var _loc3_:SideBarSet = null;
         var _loc4_:NPCTradeWidget = null;
         if(_loc2_ != null && (_loc3_ = _loc2_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null && (_loc4_ = _loc3_.getWidgetByType(Widget.TYPE_NPCTRADE) as NPCTradeWidget) != null)
         {
            _loc4_.buyObjects = null;
            _loc4_.sellObjects = null;
            _loc4_.categories = null;
            _loc3_.hideWidgetType(Widget.TYPE_NPCTRADE,-1);
         }
      }
      
      protected function readSFIELDDATA(param1:ByteArray) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc2_:Vector3D = this.readCoordinate(param1);
         if(!this.m_WorldMapStorage.isVisible(_loc2_.x,_loc2_.y,_loc2_.z,true))
         {
            throw new Error("Connection.readSFIELDDATA: Co-ordinate " + _loc2_ + " is out of range.",0);
         }
         var _loc3_:Vector3D = this.m_WorldMapStorage.toMap(_loc2_);
         this.m_WorldMapStorage.resetField(_loc3_.x,_loc3_.y,_loc3_.z,true,false);
         this.readField(param1,_loc3_.x,_loc3_.y,_loc3_.z);
         if(_loc2_.z == this.m_MiniMapStorage.getPositionZ())
         {
            this.m_WorldMapStorage.updateMiniMap(_loc3_.x,_loc3_.y,_loc3_.z);
            _loc4_ = this.m_WorldMapStorage.getMiniMapColour(_loc3_.x,_loc3_.y,_loc3_.z);
            _loc5_ = this.m_WorldMapStorage.getMiniMapCost(_loc3_.x,_loc3_.y,_loc3_.z);
            this.m_MiniMapStorage.updateField(_loc2_.x,_loc2_.y,_loc2_.z,_loc4_,_loc5_,false);
         }
      }
      
      protected function readSCREATEINCONTAINER(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:ObjectInstance = this.readObjectInstance(param1);
         var _loc4_:Container = this.m_ContainerStorage.getOpenContainer(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.addItemAt(0,_loc3_);
         }
      }
      
      public function sendCEQUIPOBJECT(param1:int, param2:int) : void
      {
         var b:ByteArray = null;
         var a_TypeID:int = param1;
         var a_Data:int = param2;
         try
         {
            b = this.createPacket();
            b.writeByte(CEQUIPOBJECT);
            b.writeShort(a_TypeID);
            b.writeByte(a_Data);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CEQUIPOBJECT,e);
            return;
         }
      }
      
      protected function readSRIGHTROW(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.m_WorldMapStorage.getPosition();
         _loc2_.x++;
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_WorldMapStorage.scrollMap(-1,0);
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         this.readArea(param1,MAPSIZE_X - 1,0,MAPSIZE_X - 1,MAPSIZE_Y - 1);
      }
      
      public function sendCOPENCHANNEL() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(COPENCHANNEL);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(COPENCHANNEL,e);
            return;
         }
      }
      
      protected function readSEDITTEXT(param1:ByteArray) : void
      {
         var _loc2_:EditTextWidget = new EditTextWidget();
         _loc2_.ID = param1.readUnsignedInt();
         var _loc3_:ObjectInstance = this.readObjectInstance(param1);
         _loc2_.object = new AppearanceTypeRef(_loc3_.ID,_loc3_.data);
         _loc2_.maxChars = param1.readUnsignedShort();
         _loc2_.text = StringHelper.s_ReadFromByteArray(param1);
         _loc2_.author = StringHelper.s_ReadFromByteArray(param1);
         _loc2_.date = StringHelper.s_ReadFromByteArray(param1);
         _loc2_.show();
      }
      
      private function handleReadError(param1:int, param2:Error) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 != null?int(param2.errorID):-1;
         this.handleConnectionError(256 + param1,_loc3_,param2);
      }
      
      protected function readSBOTTOMROW(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.m_WorldMapStorage.getPosition();
         _loc2_.y++;
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_WorldMapStorage.scrollMap(0,-1);
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         this.readArea(param1,0,MAPSIZE_Y - 1,MAPSIZE_X - 1,MAPSIZE_Y - 1);
      }
      
      protected function readSDELETEINVENTORY(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:Container = this.m_ContainerStorage.getBodyContainer();
         if(_loc3_ != null)
         {
            _loc3_.setItemAt(_loc2_ - ContainerStorage.BODY_HEAD,null);
         }
      }
      
      protected function readSUSEDELAY(param1:ByteArray) : void
      {
         this.m_ContainerStorage.setMultiUseDelay(param1.readUnsignedInt());
      }
      
      public function sendCLOOK(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var b:ByteArray = null;
         var a_X:int = param1;
         var a_Y:int = param2;
         var a_Z:int = param3;
         var a_TypeID:int = param4;
         var a_Position:int = param5;
         try
         {
            b = this.createPacket();
            b.writeByte(CLOOK);
            b.writeShort(a_X);
            b.writeShort(a_Y);
            b.writeByte(a_Z);
            b.writeShort(a_TypeID);
            b.writeByte(a_Position);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CLOOK,e);
            return;
         }
      }
      
      protected function readSPRIVATECHANNEL(param1:ByteArray) : void
      {
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
         this.m_ChatStorage.addChannel(_loc2_,_loc2_,MessageMode.MESSAGE_PRIVATE_TO);
      }
      
      protected function readSQUESTLINE(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:QuestLogWidget = null;
         _loc2_ = param1.readUnsignedShort();
         _loc3_ = param1.readUnsignedByte();
         _loc4_ = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = StringHelper.s_ReadFromByteArray(param1,QuestFlag.MAX_NAME_LENGTH);
            _loc7_ = StringHelper.s_ReadFromByteArray(param1,QuestFlag.MAX_DESCRIPTION_LENGTH);
            _loc4_.push(new QuestFlag(_loc6_,_loc7_));
            _loc5_++;
         }
         if(this.m_PendingQuestLine == _loc2_)
         {
            _loc8_ = PopUpBase.s_GetInstance() as QuestLogWidget;
            if(_loc8_ != null)
            {
               _loc8_.questFlags = _loc4_;
            }
            this.m_PendingQuestLine = -1;
         }
      }
      
      protected function onSocketClose(param1:Event) : void
      {
         var _loc2_:ConnectionEvent = null;
         this.m_LastEvent = getTimer();
         if(this.m_ConnectionState != STATE_CONNECTED)
         {
            switch(this.m_ConnectionState)
            {
               case STATE_DISCONNECTED:
                  this.handleConnectionError(ERR_INVALID_STATE,2,param1);
                  break;
               case STATE_CONNECTING_STAGE1:
                  this.handleConnectionError(ERR_COULD_NOT_CONNECT,0,param1);
                  break;
               case STATE_CONNECTING_STAGE2:
                  this.handleConnectionError(ERR_CONNECTION_LOST,0,param1);
            }
         }
         else
         {
            this.disconnectInternal();
            _loc2_ = new ConnectionEvent(ConnectionEvent.DISCONNECTED);
            dispatchEvent(_loc2_);
         }
      }
      
      public function sendCTALK(param1:int, ... rest) : void
      {
         var b:ByteArray = null;
         var a_Mode:int = param1;
         var a_Parameters:Array = rest;
         try
         {
            b = this.createPacket();
            b.writeByte(CTALK);
            b.writeByte(a_Mode);
            if(a_Parameters.length == 1 && a_Parameters[0] is String)
            {
               StringHelper.s_WriteToByteArray(b,a_Parameters[0] as String,ChatStorage.MAX_TALK_LENGTH);
            }
            else if(a_Parameters.length == 2 && a_Parameters[0] is String && a_Parameters[1] is String)
            {
               StringHelper.s_WriteToByteArray(b,a_Parameters[0] as String,Creature.MAX_NAME_LENGHT);
               StringHelper.s_WriteToByteArray(b,a_Parameters[1] as String,ChatStorage.MAX_TALK_LENGTH);
            }
            else if(a_Parameters.length == 2 && a_Parameters[0] is Number && a_Parameters[1] is String)
            {
               b.writeShort(a_Parameters[0] as Number);
               StringHelper.s_WriteToByteArray(b,a_Parameters[1] as String,ChatStorage.MAX_TALK_LENGTH);
            }
            else
            {
               throw new Error("Connection.sendCTALK: Invalid overloaded call.",0);
            }
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CTALK,e);
            return;
         }
      }
      
      public function sendCTRADEOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var b:ByteArray = null;
         var a_X:int = param1;
         var a_Y:int = param2;
         var a_Z:int = param3;
         var a_ObjectType:int = param4;
         var a_Position:int = param5;
         var a_TradePartner:int = param6;
         try
         {
            this.m_Player.stopAutowalk(false);
            b = this.createPacket();
            b.writeByte(CTRADEOBJECT);
            b.writeShort(a_X);
            b.writeShort(a_Y);
            b.writeByte(a_Z);
            b.writeShort(a_ObjectType);
            b.writeByte(a_Position);
            b.writeUnsignedInt(a_TradePartner);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CTRADEOBJECT,e);
            return;
         }
      }
      
      protected function readSTUTORIALHINT(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TutorialHint = null;
         _loc2_ = param1.readUnsignedByte();
         _loc3_ = new TutorialHint(_loc2_);
         _loc3_.known = true;
         _loc3_.perform();
      }
      
      public function connect(param1:String, param2:String, param3:String, param4:int) : void
      {
         var _loc7_:* = null;
         if(param1 == null || param1.length < 1)
         {
            throw new Error("Connection.connect: Invalid session key.",2147483638);
         }
         if(param2 == null || param2.length < 1)
         {
            throw new Error("Connection.connect: Invalid character name.",2147483636);
         }
         if(param3 == null || param3.length < 1)
         {
            throw new Error("Connection.connect: Invalid server address.",2147483635);
         }
         if(param4 < 0 || param4 > 65535)
         {
            throw new Error("Connection.connect: Invalid port number.",2147483634);
         }
         if(this.m_ConnectionState != STATE_DISCONNECTED)
         {
            throw new Error("Connection.connect: Invalid state.",2147483633);
         }
         this.m_XTEA.generateKey();
         if(this.m_Socket != null)
         {
            this.removeListeners(this.m_Socket);
            this.m_Socket = null;
         }
         this.m_Socket = new Socket();
         this.addListeners(this.m_Socket);
         if(this.m_InBuffer == null)
         {
            this.m_InBuffer = new ByteArray();
            this.m_InBuffer.endian = Endian.LITTLE_ENDIAN;
         }
         this.m_InBuffer.clear();
         if(Security.sandboxType != Security.LOCAL_TRUSTED)
         {
            _loc7_ = "xmlsocket://" + param3 + ":843";
            Security.loadPolicyFile(_loc7_);
         }
         this.m_SessionKey = param1;
         this.m_CharacterName = param2;
         this.m_Address = param3;
         this.m_Port = param4;
         this.m_ConnectionState = STATE_CONNECTING_STAGE1;
         this.m_ConnectedSince = 0;
         this.m_LastSnapback.setComponents(0,0,0);
         this.m_SnapbackCount = 0;
         this.m_Nonce = 0;
         this.m_PendingQuestLog = false;
         this.m_PendingQuestLine = -1;
         this.m_PingEarliestTime = 0;
         this.m_PingLatestTime = 0;
         this.m_PingTimeout = 0;
         this.m_PingCount = 0;
         this.m_PingTimer = new Timer(1000,0);
         this.m_PingTimer.addEventListener(TimerEvent.TIMER,this.onCheckAlive);
         this.m_PingTimer.start();
         this.m_PingSent = 0;
         this.m_PingLatency = 0;
         if(this.m_ConnectionDelay != null)
         {
            this.m_ConnectionDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayComplete);
            this.m_ConnectionDelay.stop();
            this.m_ConnectionDelay = null;
         }
         var _loc5_:int = Math.max(0,this.m_LastEvent + RECONNECT_DELAY - getTimer());
         this.m_ConnectionDelay = new Timer(_loc5_,1);
         this.m_ConnectionDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayComplete);
         this.m_ConnectionDelay.start();
         var _loc6_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTING);
         dispatchEvent(_loc6_);
      }
      
      protected function readSCREATURESPEED(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedShort();
         var _loc4_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.setSkillValue(SKILL_GOSTRENGTH,_loc3_);
         }
         else
         {
            log("Connection.readSCREATURESPEED: Creature not found: " + _loc2_);
         }
         this.m_CreatureStorage.invalidateOpponents();
      }
      
      public function sendCMARKETCANCEL(param1:Offer) : void
      {
         var b:ByteArray = null;
         var a_Offer:Offer = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CMARKETCANCEL);
            b.writeUnsignedInt(a_Offer.offerID.timestamp);
            b.writeShort(a_Offer.offerID.counter);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMARKETCANCEL,e);
            return;
         }
      }
      
      public function get allowBugreports() : Boolean
      {
         return this.m_BugreportsAllowed;
      }
      
      protected function onSocketError(param1:ErrorEvent) : void
      {
         this.m_LastEvent = getTimer();
         switch(this.m_ConnectionState)
         {
            case STATE_DISCONNECTED:
               this.handleConnectionError(ERR_INVALID_STATE,0,param1);
               break;
            case STATE_CONNECTING_STAGE1:
               this.handleConnectionError(ERR_COULD_NOT_CONNECT,0,param1);
               break;
            case STATE_CONNECTING_STAGE2:
            case STATE_CONNECTED:
               this.handleConnectionError(ERR_CONNECTION_LOST,0,param1);
         }
      }
      
      public function sendCEDITTEXT(param1:int, param2:String) : void
      {
         var b:ByteArray = null;
         var a_ID:int = param1;
         var a_Text:String = param2;
         try
         {
            b = this.createPacket();
            b.writeByte(CEDITTEXT);
            b.writeUnsignedInt(a_ID);
            StringHelper.s_WriteToByteArray(b,a_Text);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CEDITTEXT,e);
            return;
         }
      }
      
      public function sendCEXCLUDEFROMCHANNEL(param1:String) : void
      {
         var b:ByteArray = null;
         var a_Name:String = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CEXCLUDEFROMCHANNEL);
            StringHelper.s_WriteToByteArray(b,a_Name,Creature.MAX_NAME_LENGHT);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CEXCLUDEFROMCHANNEL,e);
            return;
         }
      }
      
      protected function onSocketData(param1:ProgressEvent) : void
      {
         this.m_LastEvent = getTimer();
         if(this.m_ConnectionState != STATE_CONNECTING_STAGE1 && this.m_ConnectionState != STATE_CONNECTING_STAGE2 && this.m_ConnectionState != STATE_CONNECTED)
         {
            this.handleConnectionError(ERR_INVALID_STATE,3,param1);
         }
         else
         {
            this.readSocketData();
         }
      }
      
      public function get latency() : uint
      {
         return this.m_PingLatency;
      }
      
      public function get isConnected() : Boolean
      {
         return this.m_ConnectionState == STATE_CONNECTING_STAGE1 || this.m_ConnectionState == STATE_CONNECTING_STAGE2 || this.m_ConnectionState == STATE_CONNECTED;
      }
      
      public function sendCMARKETBROWSE(param1:int) : void
      {
         var b:ByteArray = null;
         var a_TypeID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CMARKETBROWSE);
            b.writeShort(a_TypeID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMARKETBROWSE,e);
            return;
         }
      }
      
      public function sendCINSPECTTRADE(param1:int, param2:int) : void
      {
         var b:ByteArray = null;
         var a_Side:int = param1;
         var a_Position:int = param2;
         try
         {
            b = this.createPacket();
            b.writeByte(CINSPECTTRADE);
            b.writeByte(a_Side);
            b.writeByte(a_Position);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CINSPECTTRADE,e);
            return;
         }
      }
      
      public function sendCSELLOBJECT(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         var b:ByteArray = null;
         var a_Type:int = param1;
         var a_Data:int = param2;
         var a_Amount:int = param3;
         var a_KeepEquipped:Boolean = param4;
         try
         {
            b = this.createPacket();
            b.writeByte(CSELLOBJECT);
            b.writeShort(a_Type);
            b.writeByte(a_Data);
            b.writeByte(a_Amount);
            b.writeBoolean(a_KeepEquipped);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CSELLOBJECT,e);
            return;
         }
      }
      
      protected function readSMOVECREATURE(param1:ByteArray) : void
      {
         var _loc10_:Vector3D = null;
         var _loc15_:int = 0;
         var _loc2_:int = param1.readUnsignedShort();
         var _loc3_:Vector3D = null;
         var _loc4_:Vector3D = null;
         var _loc5_:int = -1;
         var _loc6_:ObjectInstance = null;
         var _loc7_:Creature = null;
         if(_loc2_ != 65535)
         {
            _loc3_ = this.readCoordinate(param1,_loc2_);
            if(!this.m_WorldMapStorage.isVisible(_loc3_.x,_loc3_.y,_loc3_.z,true))
            {
               throw new Error("Connection.readSMOVECREATURE: Start co-ordinate " + _loc3_ + " is invalid.",0);
            }
            _loc4_ = this.m_WorldMapStorage.toMap(_loc3_);
            _loc5_ = param1.readUnsignedByte();
            if((_loc6_ = this.m_WorldMapStorage.getObject(_loc4_.x,_loc4_.y,_loc4_.z,_loc5_)) == null || _loc6_.ID != AppearanceInstance.CREATURE || (_loc7_ = this.m_CreatureStorage.getCreature(_loc6_.data)) == null)
            {
               throw new Error("Connection.readSMOVECREATURE: No creature at position " + _loc3_ + ", index " + _loc5_ + ".",1);
            }
         }
         else
         {
            _loc15_ = param1.readUnsignedInt();
            _loc6_ = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE,_loc15_);
            if((_loc7_ = this.m_CreatureStorage.getCreature(_loc15_)) == null)
            {
               throw new Error("Connection.readSMOVECREATURE: Creature " + _loc15_ + " not found.",2);
            }
            _loc3_ = _loc7_.position;
            if(!this.m_WorldMapStorage.isVisible(_loc3_.x,_loc3_.y,_loc3_.z,true))
            {
               throw new Error("Connection.readSMOVECREATURE: Start co-ordinate " + _loc3_ + " is invalid.",3);
            }
            _loc4_ = this.m_WorldMapStorage.toMap(_loc3_);
         }
         var _loc8_:Vector3D = this.readCoordinate(param1);
         if(!this.m_WorldMapStorage.isVisible(_loc8_.x,_loc8_.y,_loc8_.z,true))
         {
            throw new Error("Connection.readSMOVECREATURE: Target co-ordinate " + _loc8_ + " is invalid.",4);
         }
         var _loc9_:Vector3D = this.m_WorldMapStorage.toMap(_loc8_);
         _loc10_ = _loc8_.sub(_loc3_);
         var _loc11_:Boolean = _loc10_.z != 0 || Math.abs(_loc10_.x) > 1 || Math.abs(_loc10_.y) > 1;
         var _loc12_:ObjectInstance = null;
         if(!_loc11_ && ((_loc12_ = this.m_WorldMapStorage.getObject(_loc9_.x,_loc9_.y,_loc9_.z,0)) == null || _loc12_.m_Type == null || !_loc12_.m_Type.isBank))
         {
            throw new Error("Connection.readSMOVECREATURE: Target field " + _loc8_ + " has no BANK.",5);
         }
         if(_loc2_ != 65535)
         {
            this.m_WorldMapStorage.deleteObject(_loc4_.x,_loc4_.y,_loc4_.z,_loc5_);
         }
         this.m_WorldMapStorage.putObject(_loc9_.x,_loc9_.y,_loc9_.z,_loc6_);
         _loc7_.setPosition(_loc8_.x,_loc8_.y,_loc8_.z);
         if(_loc11_)
         {
            if(_loc7_.ID == this.m_Player.ID)
            {
               Player(_loc7_).stopAutowalk(true);
            }
            if(_loc10_.x > 0)
            {
               _loc7_.direction = 1;
            }
            else if(_loc10_.x < 0)
            {
               _loc7_.direction = 3;
            }
            else if(_loc10_.y < 0)
            {
               _loc7_.direction = 0;
            }
            else if(_loc10_.y > 0)
            {
               _loc7_.direction = 2;
            }
            if(_loc7_.ID != this.m_Player.ID)
            {
               _loc7_.stopMovementAnimation();
            }
         }
         else
         {
            _loc7_.startMovementAnimation(_loc10_.x,_loc10_.y,_loc12_.m_Type.waypoints);
         }
         this.m_CreatureStorage.markOpponentVisible(_loc7_,true);
         this.m_CreatureStorage.invalidateOpponents();
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         if(_loc3_.z == this.m_MiniMapStorage.getPositionZ())
         {
            this.m_WorldMapStorage.updateMiniMap(_loc4_.x,_loc4_.y,_loc4_.z);
            _loc13_ = this.m_WorldMapStorage.getMiniMapColour(_loc4_.x,_loc4_.y,_loc4_.z);
            _loc14_ = this.m_WorldMapStorage.getMiniMapCost(_loc4_.x,_loc4_.y,_loc4_.z);
            this.m_MiniMapStorage.updateField(_loc3_.x,_loc3_.y,_loc3_.z,_loc13_,_loc14_,false);
         }
         if(_loc8_.z == this.m_MiniMapStorage.getPositionZ())
         {
            this.m_WorldMapStorage.updateMiniMap(_loc9_.x,_loc9_.y,_loc9_.z);
            _loc13_ = this.m_WorldMapStorage.getMiniMapColour(_loc9_.x,_loc9_.y,_loc9_.z);
            _loc14_ = this.m_WorldMapStorage.getMiniMapCost(_loc9_.x,_loc9_.y,_loc9_.z);
            this.m_MiniMapStorage.updateField(_loc8_.x,_loc8_.y,_loc8_.z,_loc13_,_loc14_,false);
         }
      }
      
      protected function readSPLAYERDATACURRENT(param1:ByteArray) : void
      {
         var _loc2_:Number = Tibia.s_FrameTimestamp;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         _loc3_ = param1.readUnsignedShort();
         _loc4_ = param1.readUnsignedShort();
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_HITPOINTS,_loc3_,_loc4_,_loc5_);
         _loc3_ = param1.readUnsignedInt();
         _loc4_ = param1.readUnsignedInt();
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_CARRYSTRENGTH,_loc3_,_loc4_,_loc5_);
         var _loc6_:uint = param1.readUnsignedInt();
         var _loc7_:uint = param1.readUnsignedInt();
         _loc3_ = _loc6_ + (_loc7_ << 32);
         _loc4_ = 1;
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_EXPERIENCE,_loc3_,_loc4_,_loc5_);
         _loc3_ = param1.readUnsignedShort();
         _loc4_ = 1;
         _loc5_ = param1.readUnsignedByte();
         this.m_Player.setSkill(SKILL_LEVEL,_loc3_,_loc4_,_loc5_);
         _loc3_ = param1.readUnsignedShort();
         _loc4_ = param1.readUnsignedShort();
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_MANA,_loc3_,_loc4_,_loc5_);
         _loc3_ = param1.readUnsignedByte();
         _loc4_ = param1.readUnsignedByte();
         _loc5_ = param1.readUnsignedByte();
         this.m_Player.setSkill(SKILL_MAGLEVEL,_loc3_,_loc4_,_loc5_);
         _loc3_ = param1.readUnsignedByte();
         _loc4_ = 1;
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_SOULPOINTS,_loc3_,_loc4_,_loc5_);
         _loc3_ = _loc2_ + 60 * 1000 * param1.readUnsignedShort();
         _loc4_ = _loc2_;
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_STAMINA,_loc3_,_loc4_,_loc5_);
         _loc3_ = this.m_Player.getSkillValue(SKILL_GOSTRENGTH);
         _loc4_ = param1.readUnsignedShort();
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_GOSTRENGTH,_loc3_,_loc4_,_loc5_);
         _loc3_ = _loc2_ + 1000 * param1.readUnsignedShort();
         _loc4_ = _loc2_;
         _loc5_ = 0;
         this.m_Player.setSkill(SKILL_FED,_loc3_,_loc4_,_loc5_);
      }
      
      protected function readSOWNOFFER(param1:ByteArray) : void
      {
         var _loc8_:SafeTradeWidget = null;
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:IList = new ArrayCollection();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_.addItem(this.readObjectInstance(param1));
            _loc5_++;
         }
         var _loc6_:OptionsStorage = Tibia.s_GetOptions();
         var _loc7_:SideBarSet = null;
         if(_loc6_ != null && (_loc7_ = _loc6_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null)
         {
            _loc8_ = _loc7_.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget;
            if(_loc8_ == null)
            {
               _loc8_ = _loc7_.showWidgetType(Widget.TYPE_SAFETRADE,-1,-1) as SafeTradeWidget;
            }
            _loc8_.ownName = _loc2_;
            _loc8_.ownItems = _loc4_;
         }
      }
      
      protected function readField(param1:ByteArray, param2:int, param3:int, param4:int) : int
      {
         var _loc12_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Vector3D = new Vector3D(param2,param3,param4);
         var _loc7_:Vector3D = this.m_WorldMapStorage.toAbsolute(_loc6_);
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:ObjectInstance = null;
         var _loc11_:Creature = null;
         while(true)
         {
            _loc12_ = param1.readUnsignedShort();
            if(_loc12_ >= 65280)
            {
               break;
            }
            if(!_loc5_)
            {
               _loc10_ = this.m_AppearanceStorage.createEnvironmentalEffect(_loc12_);
               this.m_WorldMapStorage.setEnvironmentalEffect(param2,param3,param4,_loc10_);
               _loc5_ = true;
            }
            else
            {
               if(_loc12_ == AppearanceInstance.UNKNOWNCREATURE || _loc12_ == AppearanceInstance.OUTDATEDCREATURE || _loc12_ == AppearanceInstance.CREATURE)
               {
                  _loc11_ = this.readCreatureInstance(param1,_loc12_,_loc7_);
                  _loc10_ = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE,_loc11_.ID);
                  if(_loc8_ < MAPSIZE_W)
                  {
                     this.m_WorldMapStorage.appendObject(param2,param3,param4,_loc10_);
                  }
               }
               else
               {
                  _loc10_ = this.readObjectInstance(param1,_loc12_);
                  if(_loc8_ < MAPSIZE_W)
                  {
                     this.m_WorldMapStorage.appendObject(param2,param3,param4,_loc10_);
                  }
                  else
                  {
                     throw new Error("Connection.readField: Expected creatues but received regular object.",2147483618);
                  }
               }
               _loc8_++;
            }
         }
         _loc9_ = _loc12_ - 65280;
         return _loc9_;
      }
      
      public function sendCMOUNT(param1:Boolean) : void
      {
         var b:ByteArray = null;
         var a_Mount:Boolean = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CMOUNT);
            b.writeBoolean(a_Mount);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMOUNT,e);
            return;
         }
      }
      
      public function sendCCLOSENPCTRADE() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CCLOSENPCTRADE);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CCLOSENPCTRADE,e);
            return;
         }
      }
      
      protected function readSBOTTOMFLOOR(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = null;
         var _loc3_:Vector3D = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = this.m_WorldMapStorage.getPosition();
         _loc2_.x--;
         _loc2_.y--;
         _loc2_.z++;
         this.m_WorldMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         this.m_MiniMapStorage.setPosition(_loc2_.x,_loc2_.y,_loc2_.z);
         if(_loc2_.z > GROUND_LAYER + 1)
         {
            this.m_WorldMapStorage.scrollMap(0,0,1);
            if(_loc2_.z <= MAP_MAX_Z - UNDERGROUND_LAYER)
            {
               this.readFloor(param1,0);
            }
         }
         else if(_loc2_.z == GROUND_LAYER + 1)
         {
            this.m_WorldMapStorage.scrollMap(0,0,UNDERGROUND_LAYER + 1);
            _loc7_ = 0;
            _loc8_ = UNDERGROUND_LAYER;
            while(_loc8_ >= 0)
            {
               _loc7_ = this.readFloor(param1,_loc8_,_loc7_);
               _loc8_--;
            }
         }
         this.m_Player.stopAutowalk(true);
         this.m_WorldMapStorage.invalidateOnscreenMessages();
         _loc3_ = this.m_WorldMapStorage.toMap(_loc2_);
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         while(_loc6_ < MAPSIZE_X)
         {
            _loc9_ = 0;
            while(_loc9_ < MAPSIZE_Y)
            {
               _loc3_.x = _loc6_;
               _loc3_.y = _loc9_;
               _loc2_ = this.m_WorldMapStorage.toAbsolute(_loc3_,_loc2_);
               this.m_WorldMapStorage.updateMiniMap(_loc3_.x,_loc3_.y,_loc3_.z);
               _loc4_ = this.m_WorldMapStorage.getMiniMapColour(_loc3_.x,_loc3_.y,_loc3_.z);
               _loc5_ = this.m_WorldMapStorage.getMiniMapCost(_loc3_.x,_loc3_.y,_loc3_.z);
               this.m_MiniMapStorage.updateField(_loc2_.x,_loc2_.y,_loc2_.z,_loc4_,_loc5_,false);
               _loc9_++;
            }
            _loc6_++;
         }
      }
      
      protected function readSGRAPHICALEFFECT(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.readCoordinate(param1);
         var _loc3_:EffectInstance = this.m_AppearanceStorage.createEffectInstance(param1.readUnsignedByte());
         this.m_WorldMapStorage.appendEffect(_loc2_.x,_loc2_.y,_loc2_.z,_loc3_);
      }
      
      public function sendCFOLLOW(param1:int) : void
      {
         var b:ByteArray = null;
         var a_CreatureID:int = param1;
         try
         {
            if(a_CreatureID != 0)
            {
               this.m_Player.stopAutowalk(false);
            }
            b = this.createPacket();
            b.writeByte(CFOLLOW);
            b.writeInt(a_CreatureID);
            b.writeInt(this.generateNonce());
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CFOLLOW,e);
            return;
         }
      }
      
      public function sendCBUGREPORT(param1:String, param2:* = null) : void
      {
         var Message:String = null;
         var SystemMessage:String = null;
         var b:ByteArray = null;
         var a_UserMessage:String = param1;
         var a_SystemMessage:* = param2;
         try
         {
            Message = "";
            if(a_UserMessage != null)
            {
               Message = Message + a_UserMessage.substr(0,BugReportWidget.MAX_USER_MESSAGE_LENGTH);
            }
            Message = Message + ("\nBuild=" + "release;vanilla;2012-04-02;12:59:11;trunk;733;not-modified");
            Message = Message + ("\nBrowser=" + BrowserHelper.s_GetBrowserString());
            Message = Message + ("\nFlash=" + Capabilities.serverString);
            SystemMessage = null;
            if(a_SystemMessage is ErrorEvent && Boolean(a_SystemMessage.hasOwnProperty("error")))
            {
               Message = Message + ("\nInternal=" + Error(a_SystemMessage["error"]).getStackTrace());
            }
            else if(a_SystemMessage != null)
            {
               Message = Message + ("\nInternal=" + String(a_SystemMessage));
            }
            if(Message.length > BugReportWidget.MAX_TOTAL_MESSAGE_LENGTH)
            {
               Message = Message.substr(0,BugReportWidget.MAX_TOTAL_MESSAGE_LENGTH);
            }
            b = this.createPacket();
            b.writeByte(CBUGREPORT);
            StringHelper.s_WriteToByteArray(b,Message);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CBUGREPORT,e);
            return;
         }
      }
      
      protected function readSSETINVENTORY(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:ObjectInstance = this.readObjectInstance(param1);
         var _loc4_:Container = this.m_ContainerStorage.getBodyContainer();
         if(_loc4_ != null)
         {
            _loc4_.setItemAt(_loc2_ - ContainerStorage.BODY_HEAD,_loc3_);
         }
      }
      
      public function sendCMARKETLEAVE() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CMARKETLEAVE);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMARKETLEAVE,e);
            return;
         }
      }
      
      protected function readArea(param1:ByteArray, param2:int, param3:int, param4:int, param5:int) : int
      {
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc6_:Vector3D = this.m_WorldMapStorage.getPosition();
         var _loc7_:Vector3D = new Vector3D();
         var _loc8_:Vector3D = new Vector3D();
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(_loc6_.z <= GROUND_LAYER)
         {
            _loc9_ = 0;
            _loc10_ = GROUND_LAYER + 1;
            _loc11_ = 1;
         }
         else
         {
            _loc9_ = 2 * UNDERGROUND_LAYER;
            _loc10_ = Math.max(-1,_loc6_.z - MAP_MAX_Z + 1);
            _loc11_ = -1;
         }
         var _loc12_:int = 0;
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         while(_loc9_ != _loc10_)
         {
            _loc15_ = param2;
            while(_loc15_ <= param4)
            {
               _loc16_ = param3;
               while(_loc16_ <= param5)
               {
                  if(_loc12_ > 0)
                  {
                     _loc12_--;
                  }
                  else
                  {
                     _loc12_ = this.readField(param1,_loc15_,_loc16_,_loc9_);
                  }
                  _loc7_.setComponents(_loc15_,_loc16_,_loc9_);
                  this.m_WorldMapStorage.toAbsolute(_loc7_,_loc8_);
                  if(_loc8_.z == this.m_MiniMapStorage.getPositionZ())
                  {
                     this.m_WorldMapStorage.updateMiniMap(_loc15_,_loc16_,_loc9_);
                     _loc13_ = this.m_WorldMapStorage.getMiniMapColour(_loc15_,_loc16_,_loc9_);
                     _loc14_ = this.m_WorldMapStorage.getMiniMapCost(_loc15_,_loc16_,_loc9_);
                     this.m_MiniMapStorage.updateField(_loc8_.x,_loc8_.y,_loc8_.z,_loc13_,_loc14_,false);
                  }
                  _loc16_++;
               }
               _loc15_++;
            }
            _loc9_ = _loc9_ + _loc11_;
         }
         return _loc12_;
      }
      
      protected function readSOPENOWNCHANNEL(param1:ByteArray) : void
      {
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:int = param1.readUnsignedShort();
         var _loc3_:String = StringHelper.s_ReadFromByteArray(param1,Channel.MAX_NAME_LENGTH);
         var _loc4_:Channel = this.m_ChatStorage.addChannel(_loc2_,_loc3_,MessageMode.MESSAGE_CHANNEL);
         this.m_ChatStorage.ownPrivateChannelID = _loc2_;
         var _loc5_:int = param1.readUnsignedShort();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
            _loc4_.playerJoined(_loc9_);
            _loc6_++;
         }
         var _loc7_:int = param1.readUnsignedShort();
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc10_ = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
            _loc4_.playerInvited(_loc10_);
            _loc8_++;
         }
      }
      
      public function sendCSHAREEXPERIENCE(param1:Boolean) : void
      {
         var b:ByteArray = null;
         var a_Enabled:Boolean = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CSHAREEXPERIENCE);
            b.writeBoolean(a_Enabled);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CSHAREEXPERIENCE,e);
            return;
         }
      }
      
      protected function readSCHANGEINCONTAINER(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:ObjectInstance = this.readObjectInstance(param1);
         var _loc5_:Container = this.m_ContainerStorage.getOpenContainer(_loc2_);
         if(_loc5_ != null)
         {
            _loc5_.setItemAt(_loc3_,_loc4_);
         }
      }
      
      protected function sendCENTERGAME(param1:int, param2:int) : void
      {
         var b:ByteArray = null;
         var PayloadStart:int = 0;
         var Channels:Array = null;
         var NumChannels:int = 0;
         var i:int = 0;
         var a_ChallengeTimeStamp:int = param1;
         var a_ChallengeRandom:int = param2;
         try
         {
            b = this.createPacket();
            b.position = b.position - PAYLOADLENGTH_SIZE;
            b.writeByte(CENTERGAME);
            b.writeShort(TERMINAL_TYPE);
            b.writeShort(TERMINAL_VERSION);
            PayloadStart = b.position;
            b.writeByte(0);
            this.m_XTEA.writeKey(b);
            b.writeByte(0);
            StringHelper.s_WriteToByteArray(b,this.m_SessionKey,Tibia.MAX_SESSION_KEY_LENGTH);
            StringHelper.s_WriteToByteArray(b,this.m_CharacterName,Creature.MAX_NAME_LENGHT);
            b.writeUnsignedInt(a_ChallengeTimeStamp);
            b.writeByte(a_ChallengeRandom);
            Channels = this.m_ChatStorage.loadChannels();
            NumChannels = Math.max(0,Math.min(Channels.length,RSAPublicKey.BLOCKSIZE - b.position - 1));
            b.writeByte(NumChannels);
            i = 0;
            while(i < NumChannels)
            {
               b.writeByte(Channels[i] & 255);
               i++;
            }
            this.m_RSAPublicKey.encrypt(b,PayloadStart,RSAPublicKey.BLOCKSIZE);
            this.sendPacket(false);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CENTERGAME,e);
            return;
         }
      }
      
      protected function readSPLAYERGOODS(param1:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:uint = param1.readUnsignedInt();
         var _loc3_:Vector.<InventoryTypeInfo> = new Vector.<InventoryTypeInfo>();
         var _loc4_:int = param1.readUnsignedByte() - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = param1.readUnsignedShort();
            _loc6_ = param1.readUnsignedByte();
            _loc3_.push(new InventoryTypeInfo(_loc5_,0,_loc6_));
            _loc4_--;
         }
         this.m_ContainerStorage.setPlayerMoney(_loc2_);
         this.m_ContainerStorage.setPlayerGoods(_loc3_);
      }
      
      protected function readSAMBIENTE(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:Colour = Colour.s_FromEightBit(param1.readUnsignedByte());
         this.m_WorldMapStorage.setAmbientLight(_loc3_,_loc2_);
      }
      
      public function sendCGETOUTFIT() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CGETOUTFIT);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CGETOUTFIT,e);
            return;
         }
      }
      
      protected function readSDEAD(param1:ByteArray) : void
      {
         var _loc2_:Number = param1.readUnsignedByte();
         var _loc3_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.DEAD);
         _loc3_.message = null;
         _loc3_.data = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      protected function readSCHALLENGE(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedByte();
         param1.position = param1.position + param1.bytesAvailable;
         this.sendCENTERGAME(_loc2_,_loc3_);
         this.m_ConnectionState = STATE_CONNECTING_STAGE2;
      }
      
      public function get beatDuration() : int
      {
         return this.m_BeatDuration;
      }
      
      protected function readSLOGINWAIT(param1:ByteArray) : void
      {
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1);
         var _loc3_:int = param1.readUnsignedByte() * 1000;
         this.disconnectInternal();
         var _loc4_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.LOGINWAIT);
         _loc4_.message = _loc2_;
         _loc4_.data = _loc3_;
         dispatchEvent(_loc4_);
      }
      
      public function sendCSETOUTFIT(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
      {
         var b:ByteArray = null;
         var a_PlayerOutfit:int = param1;
         var a_Colour0:int = param2;
         var a_Colour1:int = param3;
         var a_Colour2:int = param4;
         var a_Colour3:int = param5;
         var a_Addons:int = param6;
         var a_MountOutfit:int = param7;
         try
         {
            b = this.createPacket();
            b.writeByte(CSETOUTFIT);
            b.writeShort(a_PlayerOutfit);
            b.writeByte(a_Colour0);
            b.writeByte(a_Colour1);
            b.writeByte(a_Colour2);
            b.writeByte(a_Colour3);
            b.writeByte(a_Addons);
            b.writeShort(a_MountOutfit);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CSETOUTFIT,e);
            return;
         }
      }
      
      public function sendCMARKETCREATE(param1:int, param2:int, param3:int, param4:uint, param5:Boolean) : void
      {
         var b:ByteArray = null;
         var a_Kind:int = param1;
         var a_TypeID:int = param2;
         var a_Amount:int = param3;
         var a_PiecePrice:uint = param4;
         var a_IsAnonymous:Boolean = param5;
         try
         {
            b = this.createPacket();
            b.writeByte(CMARKETCREATE);
            b.writeByte(a_Kind);
            b.writeShort(a_TypeID);
            b.writeShort(a_Amount);
            b.writeUnsignedInt(a_PiecePrice);
            b.writeBoolean(a_IsAnonymous);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMARKETCREATE,e);
            return;
         }
      }
      
      protected function readSCHANNELEVENT(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Channel = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = param1.readUnsignedShort();
         _loc3_ = this.m_ChatStorage.getChannel(_loc2_);
         _loc4_ = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
         _loc5_ = param1.readUnsignedByte();
         if(_loc3_ != null && _loc4_ != null)
         {
            switch(_loc5_)
            {
               case 0:
                  _loc3_.playerJoined(_loc4_);
                  break;
               case 1:
                  _loc3_.playerLeft(_loc4_);
                  break;
               case 2:
                  _loc3_.playerInvited(_loc4_);
                  break;
               case 3:
                  _loc3_.playerExcluded(_loc4_);
            }
         }
      }
      
      protected function disconnectInternal() : void
      {
         if(this.m_Socket != null)
         {
            this.removeListeners(this.m_Socket);
            try
            {
               this.m_Socket.close();
            }
            catch(_Error:*)
            {
            }
            this.m_Socket = null;
         }
         if(this.m_InBuffer != null)
         {
            this.m_InBuffer.length = 0;
         }
         if(this.m_ConnectionDelay != null)
         {
            this.m_ConnectionDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayComplete);
            this.m_ConnectionDelay.stop();
            this.m_ConnectionDelay = null;
         }
         this.m_SessionKey = null;
         this.m_CharacterName = null;
         this.m_Address = null;
         this.m_Port = int.MAX_VALUE;
         this.m_ConnectionState = STATE_DISCONNECTED;
         this.m_PingEarliestTime = 0;
         this.m_PingLatestTime = 0;
         this.m_PingTimeout = 0;
         this.m_PingCount = 0;
         if(this.m_PingTimer != null)
         {
            this.m_PingTimer.removeEventListener(TimerEvent.TIMER,this.onCheckAlive);
            this.m_PingTimer.stop();
            this.m_PingTimer = null;
         }
         this.m_PingSent = 0;
         this.m_PingLatency = 0;
      }
      
      protected function generateNonce() : uint
      {
         this.m_Nonce++;
         if(this.m_Nonce == 0)
         {
            this.m_Nonce = 1;
         }
         return this.m_Nonce;
      }
      
      protected function readSLOGINERROR(param1:ByteArray) : void
      {
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1);
         this.disconnectInternal();
         var _loc3_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.LOGINERROR);
         _loc3_.message = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      public function sendCMARKETACCEPT(param1:Offer, param2:int) : void
      {
         var b:ByteArray = null;
         var a_Offer:Offer = param1;
         var a_Amount:int = param2;
         try
         {
            b = this.createPacket();
            b.writeByte(CMARKETACCEPT);
            b.writeUnsignedInt(a_Offer.offerID.timestamp);
            b.writeShort(a_Offer.offerID.counter);
            b.writeShort(a_Amount);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CMARKETACCEPT,e);
            return;
         }
      }
      
      public function sendCADDBUDDY(param1:String) : void
      {
         var b:ByteArray = null;
         var a_Name:String = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CADDBUDDY);
            StringHelper.s_WriteToByteArray(b,a_Name,Creature.MAX_NAME_LENGHT);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CADDBUDDY,e);
            return;
         }
      }
      
      protected function sendCQUITGAME() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CQUITGAME);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CQUITGAME,e);
            return;
         }
      }
      
      protected function readSCONTAINER(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedByte();
         var _loc3_:AppearanceInstance = this.readObjectInstance(param1);
         var _loc4_:String = StringHelper.s_ReadFromByteArray(param1,Container.MAX_NAME_LENGTH);
         var _loc5_:int = param1.readUnsignedByte();
         var _loc6_:* = param1.readUnsignedByte() != 0;
         var _loc7_:Container = new Container(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
         var _loc8_:int = 0;
         var _loc9_:int = param1.readUnsignedByte();
         while(_loc8_ < _loc9_)
         {
            _loc7_.addItemAt(_loc8_,this.readObjectInstance(param1));
            _loc8_++;
         }
         this.m_ContainerStorage.setOpenContainer(_loc2_,_loc7_);
      }
      
      public function sendCROTATEWEST() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CROTATEWEST);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CROTATEWEST,e);
            return;
         }
      }
      
      protected function readSINITGAME(param1:ByteArray) : void
      {
         this.m_Player.ID = param1.readUnsignedInt();
         this.m_Player.resetAutowalk();
         this.m_Player.resetFlags();
         this.m_Player.resetSkills();
         this.m_BeatDuration = param1.readUnsignedShort();
         this.m_BugreportsAllowed = param1.readUnsignedByte() == 1;
         this.m_MiniMapStorage.setPosition(0,0,0);
         this.m_WorldMapStorage.resetMap();
         this.m_WorldMapStorage.resetOnscreenMessages();
         this.m_WorldMapStorage.setPosition(0,0,0);
         this.m_WorldMapStorage.valid = false;
         this.m_ConnectionState = STATE_CONNECTED;
         var _loc2_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTED);
         dispatchEvent(_loc2_);
      }
      
      protected function readSCREATUREPARTY(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.partyFlag = _loc3_;
         }
         else
         {
            log("Connection.readSCREATUREPARTY: Creature not found: " + _loc2_);
         }
         this.m_CreatureStorage.invalidateOpponents();
      }
      
      public function sendCUPCONTAINER(param1:int) : void
      {
         var b:ByteArray = null;
         var a_Window:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CUPCONTAINER);
            b.writeByte(a_Window);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CUPCONTAINER,e);
            return;
         }
      }
      
      public function sendNameCRULEVIOLATIONREPORT(param1:int, param2:String, param3:String, param4:String) : void
      {
         var b:ByteArray = null;
         var a_Reason:int = param1;
         var a_CharacterName:String = param2;
         var a_Comment:String = param3;
         var a_Translation:String = param4;
         try
         {
            if(a_Translation == null)
            {
               a_Translation = "";
            }
            b = this.createPacket();
            b.writeByte(CRULEVIOLATIONREPORT);
            b.writeByte(Type.REPORT_NAME);
            b.writeByte(a_Reason);
            StringHelper.s_WriteToByteArray(b,a_CharacterName,Creature.MAX_NAME_LENGHT);
            StringHelper.s_WriteToByteArray(b,a_Comment,ReportWidget.MAX_COMMENT_LENGTH);
            StringHelper.s_WriteToByteArray(b,a_Translation,ReportWidget.MAX_TRANSLATION_LENGTH);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CRULEVIOLATIONREPORT,e);
            return;
         }
      }
      
      protected function readSMARKETDETAIL(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Array = null;
         var _loc12_:MarketWidget = null;
         var _loc13_:String = null;
         _loc2_ = param1.readUnsignedShort();
         _loc3_ = [];
         _loc4_ = 0;
         _loc4_ = 0;
         while(_loc4_ <= MarketWidget.DETAIL_FIELD_WEIGHT)
         {
            _loc13_ = StringHelper.s_ReadFromByteArray(param1);
            _loc3_.push(_loc13_);
            _loc4_++;
         }
         _loc5_ = new Date().time / 1000 * OfferStatistics.SECONDS_PER_DAY;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = 0;
         _loc11_ = [];
         _loc6_ = _loc5_;
         _loc4_ = param1.readUnsignedByte() - 1;
         while(_loc4_ >= 0)
         {
            _loc6_ = _loc6_ - OfferStatistics.SECONDS_PER_DAY;
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc11_.push(new OfferStatistics(_loc6_,Offer.BUY_OFFER,_loc7_,_loc8_,_loc9_,_loc10_));
            _loc4_--;
         }
         _loc6_ = _loc5_;
         _loc4_ = param1.readUnsignedByte() - 1;
         while(_loc4_ >= 0)
         {
            _loc6_ = _loc6_ - OfferStatistics.SECONDS_PER_DAY;
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc11_.push(new OfferStatistics(_loc6_,Offer.SELL_OFFER,_loc7_,_loc8_,_loc9_,_loc10_));
            _loc4_--;
         }
         _loc12_ = PopUpBase.s_GetInstance() as MarketWidget;
         if(_loc12_ != null)
         {
            _loc12_.mergeBrowseDetail(_loc2_,_loc3_,_loc11_);
         }
      }
      
      public function sendCSETTACTICS(param1:int, param2:int, param3:int) : void
      {
         var b:ByteArray = null;
         var a_AttackMode:int = param1;
         var a_ChaseMode:int = param2;
         var a_SecureMode:int = param3;
         try
         {
            b = this.createPacket();
            b.writeByte(CSETTACTICS);
            b.writeByte(a_AttackMode);
            b.writeByte(a_ChaseMode);
            b.writeByte(a_SecureMode);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CSETTACTICS,e);
            return;
         }
      }
      
      protected function readSQUESTLOG(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:QuestLogWidget = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:* = false;
         this.m_PendingQuestLine = -1;
         this.m_PendingQuestLog = false;
         _loc2_ = new Array();
         _loc3_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1.readUnsignedShort();
            _loc7_ = StringHelper.s_ReadFromByteArray(param1,QuestLine.MAX_NAME_LENGTH);
            _loc8_ = param1.readUnsignedByte() == 1;
            _loc2_.push(new QuestLine(_loc6_,_loc7_,_loc8_));
            _loc4_++;
         }
         _loc5_ = PopUpBase.s_GetInstance() as QuestLogWidget;
         if(_loc5_ == null)
         {
            _loc5_ = new QuestLogWidget();
         }
         _loc5_.questLines = _loc2_;
         _loc5_.show();
      }
      
      protected function readSBUDDYLOGIN(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:OptionsStorage = null;
         var _loc4_:BuddySet = null;
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = Tibia.s_GetOptions();
         _loc4_ = null;
         if(_loc3_ != null && (_loc4_ = _loc3_.getBuddySet(BuddySet.DEFAULT_SET)) != null)
         {
            _loc4_.updateBuddy(_loc2_,true);
         }
      }
      
      public function sendCLEAVECHANNEL(param1:int) : void
      {
         var b:ByteArray = null;
         var a_ChannelID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CLEAVECHANNEL);
            b.writeShort(a_ChannelID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CLEAVECHANNEL,e);
            return;
         }
      }
      
      protected function readSCLOSETRADE(param1:ByteArray) : void
      {
         var _loc2_:OptionsStorage = Tibia.s_GetOptions();
         var _loc3_:SideBarSet = null;
         var _loc4_:SafeTradeWidget = null;
         if(_loc2_ != null && (_loc3_ = _loc2_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null && (_loc4_ = _loc3_.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget) != null)
         {
            _loc4_.ownName = null;
            _loc4_.ownItems = null;
            _loc4_.otherName = null;
            _loc4_.otherItems = null;
            _loc3_.hideWidgetType(Widget.TYPE_SAFETRADE,-1);
         }
      }
      
      protected function readCreatureInstance(param1:ByteArray, param2:int = -1, param3:Vector3D = null) : Creature
      {
         if(param1 == null || param2 == -1 && param1.bytesAvailable < 2)
         {
            throw new Error("Connection.readCreatureInstance: Not enough data.",2147483625);
         }
         if(param2 == -1)
         {
            param2 = param1.readUnsignedShort();
         }
         if(param2 != AppearanceInstance.UNKNOWNCREATURE && param2 != AppearanceInstance.CREATURE && param2 != AppearanceInstance.OUTDATEDCREATURE)
         {
            throw new Error("Connection.readCreatureInstance: Invalid type.",2147483624);
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = -1;
         var _loc7_:Creature = null;
         switch(param2)
         {
            case AppearanceInstance.UNKNOWNCREATURE:
               _loc5_ = param1.readUnsignedInt();
               _loc4_ = param1.readUnsignedInt();
               _loc6_ = param1.readUnsignedByte();
               if(_loc4_ == this.m_Player.ID)
               {
                  _loc7_ = this.m_Player;
               }
               else
               {
                  _loc7_ = new Creature(_loc4_);
               }
               _loc7_ = this.m_CreatureStorage.replaceCreature(_loc7_,_loc5_);
               if(_loc7_ != null)
               {
                  _loc7_.type = _loc6_;
                  _loc7_.name = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
                  _loc7_.setSkillValue(SKILL_HITPOINTS,param1.readUnsignedByte());
                  _loc7_.direction = param1.readUnsignedByte();
                  _loc7_.outfit = this.readCreatureOutfit(param1,_loc7_.outfit);
                  _loc7_.mountOutfit = this.readMountOutfit(param1,_loc7_.mountOutfit);
                  _loc7_.brightness = param1.readUnsignedByte();
                  _loc7_.lightColour = Colour.s_FromEightBit(param1.readUnsignedByte());
                  _loc7_.setSkillValue(SKILL_GOSTRENGTH,param1.readUnsignedShort());
                  _loc7_.pkFlag = param1.readUnsignedByte();
                  _loc7_.partyFlag = param1.readUnsignedByte();
                  _loc7_.warFlag = param1.readUnsignedByte();
                  _loc7_.isUnpassable = param1.readUnsignedByte() != 0;
                  break;
               }
               throw new Error("Connection.readCreatureInstance: Failed to append creature.",2147483623);
            case AppearanceInstance.OUTDATEDCREATURE:
               _loc4_ = param1.readUnsignedInt();
               _loc7_ = this.m_CreatureStorage.getCreature(_loc4_);
               if(_loc7_ != null)
               {
                  _loc7_.setSkillValue(SKILL_HITPOINTS,param1.readUnsignedByte());
                  _loc7_.direction = param1.readUnsignedByte();
                  _loc7_.outfit = this.readCreatureOutfit(param1,_loc7_.outfit);
                  _loc7_.mountOutfit = this.readMountOutfit(param1,_loc7_.mountOutfit);
                  _loc7_.brightness = param1.readUnsignedByte();
                  _loc7_.lightColour = Colour.s_FromEightBit(param1.readUnsignedByte());
                  _loc7_.setSkillValue(SKILL_GOSTRENGTH,param1.readUnsignedShort());
                  _loc7_.pkFlag = param1.readUnsignedByte();
                  _loc7_.partyFlag = param1.readUnsignedByte();
                  _loc7_.isUnpassable = param1.readUnsignedByte() != 0;
                  break;
               }
               throw new Error("Connection.readCreatureInstance: Outdated creature not found.",2147483622);
            case AppearanceInstance.CREATURE:
               _loc4_ = param1.readUnsignedInt();
               _loc7_ = this.m_CreatureStorage.getCreature(_loc4_);
               if(_loc7_ != null)
               {
                  _loc7_.direction = param1.readUnsignedByte();
                  _loc7_.isUnpassable = param1.readUnsignedByte() != 0;
                  break;
               }
               throw new Error("Connection.readCreatureInstance: Known creature not found.",2147483621);
         }
         if(param3 != null)
         {
            _loc7_.setPosition(param3.x,param3.y,param3.z);
         }
         this.m_CreatureStorage.markOpponentVisible(_loc7_,true);
         this.m_CreatureStorage.invalidateOpponents();
         return _loc7_;
      }
      
      protected function sendCPING() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CPING);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CPING,e);
            return;
         }
      }
      
      protected function readCoordinate(param1:ByteArray, param2:int = -1, param3:int = -1, param4:int = -1) : Vector3D
      {
         if(param2 == -1)
         {
            param2 = param1.readUnsignedShort();
         }
         if(param3 == -1)
         {
            param3 = param1.readUnsignedShort();
         }
         if(param4 == -1)
         {
            param4 = param1.readUnsignedByte();
         }
         return new Vector3D(param2,param3,param4);
      }
      
      public function sendCTHANKYOU(param1:uint) : void
      {
         var b:ByteArray = null;
         var a_StatementID:uint = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CTHANKYOU);
            b.writeUnsignedInt(a_StatementID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CTHANKYOU,e);
            return;
         }
      }
      
      protected function readSOBJECTINFO(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         _loc2_ = param1.readUnsignedByte() - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = param1.readUnsignedShort();
            _loc4_ = param1.readUnsignedByte();
            _loc5_ = StringHelper.s_ReadFromByteArray(param1);
            this.m_AppearanceStorage.setCachedObjectTypeName(_loc3_,_loc4_,_loc5_);
            _loc2_--;
         }
      }
      
      protected function readSCHANGEONMAP(param1:ByteArray) : void
      {
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         var _loc2_:int = param1.readUnsignedShort();
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector3D = null;
         var _loc6_:Vector3D = null;
         var _loc7_:ObjectInstance = null;
         var _loc8_:Creature = null;
         var _loc9_:int = 0;
         if(_loc2_ != 65535)
         {
            _loc5_ = this.readCoordinate(param1,_loc2_);
            if(!this.m_WorldMapStorage.isVisible(_loc5_.x,_loc5_.y,_loc5_.z,true))
            {
               throw new Error("Connection.readSCHANGEONMAP: Co-ordinate " + _loc5_ + " is out of range.",0);
            }
            _loc6_ = this.m_WorldMapStorage.toMap(_loc5_);
            _loc4_ = param1.readUnsignedByte();
            if((_loc7_ = this.m_WorldMapStorage.getObject(_loc6_.x,_loc6_.y,_loc6_.z,_loc4_)) == null)
            {
               throw new Error("Connection.readSCHANGEONMAP: Object not found.",1);
            }
            if(_loc7_.ID == AppearanceInstance.CREATURE && (_loc8_ = this.m_CreatureStorage.getCreature(_loc7_.data)) == null)
            {
               throw new Error("Connection.readSCHANGEONMAP: Creature not found: " + _loc7_.data,2);
            }
            if(_loc8_ != null)
            {
               this.m_CreatureStorage.markOpponentVisible(_loc8_,false);
            }
            _loc9_ = param1.readUnsignedShort();
            if(_loc9_ == AppearanceInstance.UNKNOWNCREATURE || _loc9_ == AppearanceInstance.OUTDATEDCREATURE || _loc9_ == AppearanceInstance.CREATURE)
            {
               _loc8_ = this.readCreatureInstance(param1,_loc9_,_loc5_);
               _loc7_ = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE,_loc8_.ID);
            }
            else
            {
               _loc7_ = this.readObjectInstance(param1,_loc9_);
            }
            this.m_WorldMapStorage.changeObject(_loc6_.x,_loc6_.y,_loc6_.z,_loc4_,_loc7_);
         }
         else
         {
            _loc3_ = param1.readUnsignedInt();
            if((_loc8_ = this.m_CreatureStorage.getCreature(_loc3_)) == null)
            {
               throw new Error("Connection.readSDELETEONMAP: Creature not found: " + _loc3_,3);
            }
            _loc5_ = _loc8_.position;
            if(!this.m_WorldMapStorage.isVisible(_loc5_.x,_loc5_.y,_loc5_.z,true))
            {
               throw new Error("Connection.readSCHANGEONMAP: Co-ordinate " + _loc5_ + " is out of range.",4);
            }
            _loc6_ = this.m_WorldMapStorage.toMap(_loc5_);
            this.m_CreatureStorage.markOpponentVisible(_loc8_,false);
            _loc9_ = param1.readUnsignedShort();
            if(_loc9_ == AppearanceInstance.UNKNOWNCREATURE || _loc9_ == AppearanceInstance.OUTDATEDCREATURE || _loc9_ == AppearanceInstance.CREATURE)
            {
               _loc8_ = this.readCreatureInstance(param1,_loc9_);
            }
            else
            {
               throw new Error("Connection.readSDELETEONMAP: Received object of type " + _loc9_ + " when a creature was expected.",5);
            }
         }
         if(_loc5_.z == this.m_MiniMapStorage.getPositionZ())
         {
            this.m_WorldMapStorage.updateMiniMap(_loc6_.x,_loc6_.y,_loc6_.z);
            _loc10_ = this.m_WorldMapStorage.getMiniMapColour(_loc6_.x,_loc6_.y,_loc6_.z);
            _loc11_ = this.m_WorldMapStorage.getMiniMapCost(_loc6_.x,_loc6_.y,_loc6_.z);
            this.m_MiniMapStorage.updateField(_loc5_.x,_loc5_.y,_loc5_.z,_loc10_,_loc11_,false);
         }
      }
      
      protected function readSCREATURELIGHT(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:int = param1.readUnsignedByte();
         var _loc5_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc5_ != null)
         {
            _loc5_.brightness = _loc3_;
            _loc5_.lightColour = Colour.s_FromEightBit(_loc4_);
         }
         else
         {
            log("Connection.readSCREATURELIGHT: Creature not found: " + _loc2_);
         }
         this.m_CreatureStorage.invalidateOpponents();
      }
      
      public function sendCGETQUESTLOG() : void
      {
         var b:ByteArray = null;
         try
         {
            if(!this.m_PendingQuestLog)
            {
               b = this.createPacket();
               b.writeByte(CGETQUESTLOG);
               this.sendPacket(true);
               this.m_PendingQuestLine = -1;
               this.m_PendingQuestLog = true;
            }
            return;
         }
         catch(e:Error)
         {
            handleSendError(CGETQUESTLOG,e);
            return;
         }
      }
      
      public function sendCCLOSENPCCHANNEL() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CCLOSENPCCHANNEL);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CCLOSENPCCHANNEL,e);
            return;
         }
      }
      
      protected function readSOUTFIT(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:* = 0;
         var _loc12_:AppearanceType = null;
         var _loc13_:IList = null;
         var _loc14_:int = 0;
         var _loc15_:IList = null;
         var _loc16_:SelectOutfitWidget = null;
         _loc2_ = param1.readUnsignedShort();
         _loc3_ = param1.readUnsignedByte();
         _loc4_ = param1.readUnsignedByte();
         _loc5_ = param1.readUnsignedByte();
         _loc6_ = param1.readUnsignedByte();
         _loc7_ = param1.readUnsignedByte();
         _loc8_ = param1.readUnsignedShort();
         _loc9_ = 0;
         _loc10_ = null;
         _loc11_ = 0;
         _loc12_ = null;
         _loc13_ = new ArrayCollection();
         _loc14_ = param1.readUnsignedByte();
         while(_loc14_ > 0)
         {
            _loc9_ = param1.readUnsignedShort();
            _loc10_ = StringHelper.s_ReadFromByteArray(param1,OutfitInstance.MAX_NAME_LENGTH);
            _loc11_ = int(param1.readUnsignedByte());
            _loc12_ = this.m_AppearanceStorage.getOutfitType(_loc9_);
            if(_loc12_ == null)
            {
               throw new Error("Connection.readSOUTFIT: Unknown player outfit type " + _loc9_ + ".",0);
            }
            _loc11_ = _loc11_ & 1 << _loc12_.patternHeight - 1 - 1;
            _loc13_.addItem({
               "ID":_loc9_,
               "name":_loc10_,
               "addons":_loc11_
            });
            _loc14_--;
         }
         _loc15_ = new ArrayCollection();
         _loc14_ = param1.readUnsignedByte();
         while(_loc14_ > 0)
         {
            _loc9_ = param1.readUnsignedShort();
            _loc10_ = StringHelper.s_ReadFromByteArray(param1,OutfitInstance.MAX_NAME_LENGTH);
            _loc12_ = this.m_AppearanceStorage.getOutfitType(_loc9_);
            if(_loc12_ == null)
            {
               throw new Error("Connection.readSOUTFIT: Unknown mount outfit type " + _loc9_ + ".",1);
            }
            _loc15_.addItem({
               "ID":_loc9_,
               "name":_loc10_
            });
            _loc14_--;
         }
         _loc16_ = new SelectOutfitWidget();
         _loc16_.playerOutfits = _loc13_;
         _loc16_.playerType = _loc2_;
         _loc16_.playerColours = [_loc3_,_loc4_,_loc5_,_loc6_];
         _loc16_.playerAddons = _loc7_;
         _loc16_.mountOutfits = _loc15_;
         _loc16_.mountType = _loc8_;
         _loc16_.show();
      }
      
      protected function readSMISSILEEFFECT(param1:ByteArray) : void
      {
         var _loc2_:Vector3D = this.readCoordinate(param1);
         var _loc3_:Vector3D = this.readCoordinate(param1);
         var _loc4_:int = param1.readUnsignedByte();
         var _loc5_:MissileInstance = this.m_AppearanceStorage.createMissileInstance(_loc4_,_loc2_,_loc3_);
         this.m_WorldMapStorage.appendEffect(_loc2_.x,_loc2_.y,_loc2_.z,_loc5_);
      }
      
      public function sendCATTACK(param1:int) : void
      {
         var b:ByteArray = null;
         var a_CreatureID:int = param1;
         try
         {
            if(a_CreatureID != 0)
            {
               this.m_Player.stopAutowalk(false);
            }
            b = this.createPacket();
            b.writeByte(CATTACK);
            b.writeInt(a_CreatureID);
            b.writeInt(this.generateNonce());
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CATTACK,e);
            return;
         }
      }
      
      public function sendCREFRESHCONTAINER(param1:int) : void
      {
         var b:ByteArray = null;
         var a_Window:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CREFRESHCONTAINER);
            b.writeByte(a_Window);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CREFRESHCONTAINER,e);
            return;
         }
      }
      
      public function sendCBUYOBJECT(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
         var b:ByteArray = null;
         var a_Type:int = param1;
         var a_Data:int = param2;
         var a_Amount:int = param3;
         var a_IgnoreCapacity:Boolean = param4;
         var a_WithBackpacks:Boolean = param5;
         try
         {
            b = this.createPacket();
            b.writeByte(CBUYOBJECT);
            b.writeShort(a_Type);
            b.writeByte(a_Data);
            b.writeByte(a_Amount);
            b.writeBoolean(a_IgnoreCapacity);
            b.writeBoolean(a_WithBackpacks);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CBUYOBJECT,e);
            return;
         }
      }
      
      protected function readSTALK(param1:ByteArray) : void
      {
         var a_Bytes:ByteArray = param1;
         var StatementID:int = a_Bytes.readUnsignedInt();
         var Speaker:String = StringHelper.s_ReadFromByteArray(a_Bytes,Creature.MAX_NAME_LENGHT);
         var SpeakerLevel:int = a_Bytes.readUnsignedShort();
         var Mode:int = a_Bytes.readUnsignedByte();
         var Pos:Vector3D = null;
         var ChannelID:Object = null;
         switch(Mode)
         {
            case MessageMode.MESSAGE_SAY:
            case MessageMode.MESSAGE_WHISPER:
            case MessageMode.MESSAGE_YELL:
               Pos = this.readCoordinate(a_Bytes);
               ChannelID = ChatStorage.LOCAL_CHANNEL_ID;
               break;
            case MessageMode.MESSAGE_PRIVATE_FROM:
               Pos = null;
               ChannelID = Speaker;
               break;
            case MessageMode.MESSAGE_CHANNEL:
            case MessageMode.MESSAGE_CHANNEL_HIGHLIGHT:
               Pos = null;
               ChannelID = a_Bytes.readUnsignedShort();
               break;
            case MessageMode.MESSAGE_SPELL:
               Pos = this.readCoordinate(a_Bytes);
               ChannelID = ChatStorage.LOCAL_CHANNEL_ID;
               break;
            case MessageMode.MESSAGE_NPC_FROM:
               Pos = this.readCoordinate(a_Bytes);
               ChannelID = ChatStorage.NPC_CHANNEL_ID;
               break;
            case MessageMode.MESSAGE_GAMEMASTER_BROADCAST:
               Pos = null;
               ChannelID = null;
               break;
            case MessageMode.MESSAGE_GAMEMASTER_CHANNEL:
               Pos = null;
               ChannelID = a_Bytes.readUnsignedShort();
               break;
            case MessageMode.MESSAGE_GAMEMASTER_PRIVATE_FROM:
               Pos = null;
               ChannelID = Speaker;
               break;
            case MessageMode.MESSAGE_BARK_LOW:
            case MessageMode.MESSAGE_BARK_LOUD:
               Pos = this.readCoordinate(a_Bytes);
               ChannelID = -1;
               break;
            default:
               throw new Error("Connection.readSTALK: Invalid message mode " + Mode + ".",0);
         }
         var Text:String = StringHelper.s_ReadFromByteArray(a_Bytes,ChatStorage.MAX_TALK_LENGTH);
         log("Connection.readSTALK: Received message (mode=" + Mode + "): \"" + Text + "\"");
         try
         {
            this.m_WorldMapStorage.addOnscreenMessage(Pos,StatementID,Speaker,SpeakerLevel,Mode,Text);
         }
         catch(e:Error)
         {
            throw new Error("Connection.readSTALK: Failed to add message: " + e.message,1);
         }
         try
         {
            this.m_ChatStorage.addChannelMessage(ChannelID,StatementID,Speaker,SpeakerLevel,Mode,Text);
            return;
         }
         catch(e:Error)
         {
            throw new Error("Connection.readSTALK: Failed to add message: " + e.message,2);
         }
      }
      
      protected function readSPLAYERDATABASIC(param1:ByteArray) : void
      {
         this.m_Player.premium = param1.readBoolean();
         this.m_Player.profession = param1.readUnsignedByte();
         var _loc2_:Array = [];
         var _loc3_:int = param1.readUnsignedShort() - 1;
         while(_loc3_ >= 0)
         {
            _loc2_.push(param1.readUnsignedByte());
            _loc3_--;
         }
         this.m_Player.knownSpells = _loc2_;
      }
      
      protected function readSCREATUREOUTFIT(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:AppearanceInstance = this.readCreatureOutfit(param1,null);
         var _loc4_:AppearanceInstance = this.readMountOutfit(param1,null);
         var _loc5_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc5_ != null)
         {
            _loc5_.outfit = _loc3_;
            _loc5_.mountOutfit = _loc4_;
         }
         else
         {
            log("Connection.readSCREATUREOUTFIT: Creature not found: " + _loc2_);
         }
         this.m_CreatureStorage.invalidateOpponents();
      }
      
      public function sendCROTATENORTH() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CROTATENORTH);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CROTATENORTH,e);
            return;
         }
      }
      
      protected function readSMARKETBROWSE(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:MarketWidget = null;
         _loc2_ = param1.readUnsignedShort();
         _loc3_ = 0;
         _loc4_ = [];
         _loc3_ = param1.readUnsignedInt() - 1;
         while(_loc3_ >= 0)
         {
            _loc4_.push(this.readMarketOffer(param1,Offer.BUY_OFFER,_loc2_));
            _loc3_--;
         }
         _loc3_ = param1.readUnsignedInt() - 1;
         while(_loc3_ >= 0)
         {
            _loc4_.push(this.readMarketOffer(param1,Offer.SELL_OFFER,_loc2_));
            _loc3_--;
         }
         _loc5_ = PopUpBase.s_GetInstance() as MarketWidget;
         if(_loc5_ != null)
         {
            _loc5_.mergeBrowseOffers(_loc2_,_loc4_);
         }
      }
      
      public function sendCROTATEEAST() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CROTATEEAST);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CROTATEEAST,e);
            return;
         }
      }
      
      protected function readSOPENCHANNEL(param1:ByteArray) : void
      {
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:int = param1.readUnsignedShort();
         var _loc3_:String = StringHelper.s_ReadFromByteArray(param1,Channel.MAX_NAME_LENGTH);
         var _loc4_:Channel = this.m_ChatStorage.addChannel(_loc2_,_loc3_,MessageMode.MESSAGE_CHANNEL);
         var _loc5_:int = param1.readUnsignedShort();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
            _loc4_.playerJoined(_loc9_);
            _loc6_++;
         }
         var _loc7_:int = param1.readUnsignedShort();
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc10_ = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
            _loc4_.playerInvited(_loc10_);
            _loc8_++;
         }
      }
      
      protected function readSMESSAGE(param1:ByteArray) : void
      {
         var SecondaryError:int = 0;
         var Mode:int = 0;
         var ChannelID:uint = 0;
         var Text:String = null;
         var Pos:Vector3D = null;
         var Value:Number = NaN;
         var Color:uint = 0;
         var _MarketWidget:MarketWidget = null;
         var a_Bytes:ByteArray = param1;
         try
         {
            SecondaryError = 0;
            Mode = a_Bytes.readUnsignedByte();
            ChannelID = 0;
            Text = null;
            Pos = null;
            Value = NaN;
            Color = 0;
            switch(Mode)
            {
               case MessageMode.MESSAGE_CHANNEL_MANAGEMENT:
                  ChannelID = a_Bytes.readUnsignedShort();
                  Text = StringHelper.s_ReadFromByteArray(a_Bytes);
                  SecondaryError = 1;
                  this.m_WorldMapStorage.addOnscreenMessage(null,-1,null,0,Mode,Text);
                  SecondaryError = 2;
                  this.m_ChatStorage.addChannelMessage(ChannelID,-1,null,0,Mode,Text);
                  break;
               case MessageMode.MESSAGE_LOGIN:
               case MessageMode.MESSAGE_ADMIN:
               case MessageMode.MESSAGE_GAME:
               case MessageMode.MESSAGE_FAILURE:
               case MessageMode.MESSAGE_LOOK:
               case MessageMode.MESSAGE_STATUS:
               case MessageMode.MESSAGE_LOOT:
               case MessageMode.MESSAGE_TRADE_NPC:
               case MessageMode.MESSAGE_GUILD:
               case MessageMode.MESSAGE_PARTY_MANAGEMENT:
               case MessageMode.MESSAGE_PARTY:
               case MessageMode.MESSAGE_HOTKEY_USE:
                  Text = StringHelper.s_ReadFromByteArray(a_Bytes);
                  SecondaryError = 3;
                  this.m_WorldMapStorage.addOnscreenMessage(null,-1,null,0,Mode,Text);
                  SecondaryError = 4;
                  this.m_ChatStorage.addChannelMessage(-1,-1,null,0,Mode,Text);
                  break;
               case MessageMode.MESSAGE_MARKET:
                  Text = StringHelper.s_ReadFromByteArray(a_Bytes);
                  _MarketWidget = PopUpBase.s_GetInstance() as MarketWidget;
                  if(_MarketWidget != null)
                  {
                     _MarketWidget.serverResponsePending = false;
                     _MarketWidget.showMessage(Text);
                  }
                  break;
               case MessageMode.MESSAGE_REPORT:
                  ReportWidget.s_ReportTimestampReset();
                  Text = StringHelper.s_ReadFromByteArray(a_Bytes);
                  SecondaryError = 5;
                  this.m_WorldMapStorage.addOnscreenMessage(null,-1,null,0,Mode,Text);
                  SecondaryError = 6;
                  this.m_ChatStorage.addChannelMessage(-1,-1,null,0,Mode,Text);
                  break;
               case MessageMode.MESSAGE_DAMAGE_DEALED:
               case MessageMode.MESSAGE_DAMAGE_RECEIVED:
               case MessageMode.MESSAGE_DAMAGE_OTHERS:
                  Pos = this.readCoordinate(a_Bytes);
                  Value = a_Bytes.readUnsignedInt();
                  Color = a_Bytes.readUnsignedByte();
                  SecondaryError = 7;
                  if(Value > 0)
                  {
                     this.m_WorldMapStorage.addOnscreenMessage(Pos,-1,null,0,Mode,Value,Color);
                  }
                  Value = a_Bytes.readUnsignedInt();
                  Color = a_Bytes.readUnsignedByte();
                  SecondaryError = 8;
                  if(Value > 0)
                  {
                     this.m_WorldMapStorage.addOnscreenMessage(Pos,-1,null,0,Mode,Value,Color);
                  }
                  Text = StringHelper.s_ReadFromByteArray(a_Bytes);
                  SecondaryError = 9;
                  this.m_ChatStorage.addChannelMessage(-1,-1,null,0,Mode,Text);
                  break;
               case MessageMode.MESSAGE_HEAL:
               case MessageMode.MESSAGE_EXP:
               case MessageMode.MESSAGE_HEAL_OTHERS:
               case MessageMode.MESSAGE_EXP_OTHERS:
                  Pos = this.readCoordinate(a_Bytes);
                  Value = a_Bytes.readUnsignedInt();
                  Color = a_Bytes.readUnsignedByte();
                  SecondaryError = 10;
                  this.m_WorldMapStorage.addOnscreenMessage(Pos,-1,null,0,Mode,Value,Color);
                  Text = StringHelper.s_ReadFromByteArray(a_Bytes);
                  SecondaryError = 11;
                  this.m_ChatStorage.addChannelMessage(-1,-1,null,0,Mode,Text);
                  break;
               default:
                  throw new Error("Connection.readSMESSAGE: Invalid message mode " + Mode + ".",0);
            }
            return;
         }
         catch(e:Error)
         {
            throw new Error("Connection.readSMESSAGE: Failed to add message of type " + Mode + ": " + e.message,SecondaryError);
         }
      }
      
      protected function readSPINGBACK(param1:ByteArray) : void
      {
      }
      
      public function sendCJOINCHANNEL(param1:int) : void
      {
         var b:ByteArray = null;
         var a_ChannelID:int = param1;
         try
         {
            b = this.createPacket();
            b.writeByte(CJOINCHANNEL);
            b.writeShort(a_ChannelID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CJOINCHANNEL,e);
            return;
         }
      }
      
      public function sendCGO(param1:Array) : void
      {
         var Type:int = 0;
         var b:ByteArray = null;
         var i:int = 0;
         var a_Path:Array = param1;
         Type = -1;
         try
         {
            this.m_CreatureStorage.clearTargets();
            if(a_Path == null || a_Path.length == 0)
            {
               return;
            }
            b = this.createPacket();
            if(a_Path.length == 1)
            {
               switch(a_Path[0] & 65535)
               {
                  case PATH_EAST:
                     Type = CGOEAST;
                     break;
                  case PATH_NORTH_EAST:
                     Type = CGONORTHEAST;
                     break;
                  case PATH_NORTH:
                     Type = CGONORTH;
                     break;
                  case PATH_NORTH_WEST:
                     Type = CGONORTHWEST;
                     break;
                  case PATH_WEST:
                     Type = CGOWEST;
                     break;
                  case PATH_SOUTH_WEST:
                     Type = CGOSOUTHWEST;
                     break;
                  case PATH_SOUTH:
                     Type = CGOSOUTH;
                     break;
                  case PATH_SOUTH_EAST:
                     Type = CGOSOUTHEAST;
               }
               b.writeByte(Type);
            }
            else
            {
               Type = CGOPATH;
               b.writeByte(Type);
               b.writeByte(a_Path.length & 255);
               i = 0;
               while(i < a_Path.length)
               {
                  b.writeByte(a_Path[i] & 65535);
                  i++;
               }
            }
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(Type,e);
            return;
         }
      }
      
      protected function readSCREATEONMAP(param1:ByteArray) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc2_:Vector3D = this.readCoordinate(param1);
         if(!this.m_WorldMapStorage.isVisible(_loc2_.x,_loc2_.y,_loc2_.z,true))
         {
            throw new Error("Connection.readSCREATEONMAP: Co-ordinate " + _loc2_ + " is out of range.",0);
         }
         var _loc3_:Vector3D = this.m_WorldMapStorage.toMap(_loc2_);
         var _loc4_:int = param1.readUnsignedByte();
         var _loc5_:int = param1.readUnsignedShort();
         var _loc6_:ObjectInstance = null;
         var _loc7_:Creature = null;
         if(_loc5_ == AppearanceInstance.UNKNOWNCREATURE || _loc5_ == AppearanceInstance.OUTDATEDCREATURE || _loc5_ == AppearanceInstance.CREATURE)
         {
            _loc7_ = this.readCreatureInstance(param1,_loc5_,_loc2_);
            if(_loc7_.ID == this.m_Player.ID)
            {
               this.m_Player.stopAutowalk(true);
            }
            _loc6_ = this.m_AppearanceStorage.createObjectInstance(AppearanceInstance.CREATURE,_loc7_.ID);
         }
         else
         {
            _loc6_ = this.readObjectInstance(param1,_loc5_);
         }
         if(_loc6_.m_Type.isAnimation)
         {
            _loc6_.phase = AppearanceInstance.PHASE_ASYNCHRONOUS;
         }
         if(_loc4_ == 255)
         {
            this.m_WorldMapStorage.putObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc6_);
         }
         else
         {
            if(_loc4_ >= MAPSIZE_W)
            {
               throw new Error("Connection.readSCREATEONMAP: Invalid position.",1);
            }
            this.m_WorldMapStorage.insertObject(_loc3_.x,_loc3_.y,_loc3_.z,_loc4_,_loc6_);
         }
         if(_loc2_.z == this.m_MiniMapStorage.getPositionZ())
         {
            this.m_WorldMapStorage.updateMiniMap(_loc3_.x,_loc3_.y,_loc3_.z);
            _loc8_ = this.m_WorldMapStorage.getMiniMapColour(_loc3_.x,_loc3_.y,_loc3_.z);
            _loc9_ = this.m_WorldMapStorage.getMiniMapCost(_loc3_.x,_loc3_.y,_loc3_.z);
            this.m_MiniMapStorage.updateField(_loc2_.x,_loc2_.y,_loc2_.z,_loc8_,_loc9_,false);
         }
      }
      
      protected function readSCREATUREUNPASS(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readUnsignedInt();
         var _loc3_:* = param1.readUnsignedByte() != 0;
         var _loc4_:Creature = this.m_CreatureStorage.getCreature(_loc2_);
         if(_loc4_ != null)
         {
            _loc4_.isUnpassable = _loc3_;
         }
         else
         {
            log("Connection.readSCREATUREUNPASS: Creature not found: " + _loc2_);
         }
      }
      
      public function sendCUSEONCREATURE(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var b:ByteArray = null;
         var a_X:int = param1;
         var a_Y:int = param2;
         var a_Z:int = param3;
         var a_TypeID:int = param4;
         var a_PositionOrData:int = param5;
         var a_CreatureID:int = param6;
         try
         {
            this.m_Player.stopAutowalk(false);
            b = this.createPacket();
            b.writeByte(CUSEONCREATURE);
            b.writeShort(a_X);
            b.writeShort(a_Y);
            b.writeByte(a_Z);
            b.writeShort(a_TypeID);
            b.writeByte(a_PositionOrData);
            b.writeUnsignedInt(a_CreatureID);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CUSEONCREATURE,e);
            return;
         }
      }
      
      protected function readSLOGINADVICE(param1:ByteArray) : void
      {
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1);
         var _loc3_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.LOGINADVICE);
         _loc3_.message = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      protected function readSCOUNTEROFFER(param1:ByteArray) : void
      {
         var _loc8_:SafeTradeWidget = null;
         var _loc2_:String = StringHelper.s_ReadFromByteArray(param1,Creature.MAX_NAME_LENGHT);
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:IList = new ArrayCollection();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_.addItem(this.readObjectInstance(param1));
            _loc5_++;
         }
         var _loc6_:OptionsStorage = Tibia.s_GetOptions();
         var _loc7_:SideBarSet = null;
         if(_loc6_ != null && (_loc7_ = _loc6_.getSideBarSet(SideBarSet.DEFAULT_SET)) != null)
         {
            _loc8_ = _loc7_.getWidgetByType(Widget.TYPE_SAFETRADE) as SafeTradeWidget;
            if(_loc8_ == null)
            {
               _loc8_ = _loc7_.showWidgetType(Widget.TYPE_SAFETRADE,-1,-1) as SafeTradeWidget;
            }
            _loc8_.otherName = _loc2_;
            _loc8_.otherItems = _loc4_;
         }
      }
      
      public function readSocketData() : void
      {
         var PacketLength:int = 0;
         var PacketEOF:int = 0;
         var PacketChecksum:int = 0;
         var CompareChecksum:int = 0;
         var PayloadLength:int = 0;
         var PayloadEOF:int = 0;
         var RemainingBytes:int = 0;
         var Type:int = 0;
         var ReadPosition:int = 0;
         var WritePosition:int = 0;
         if(this.m_ConnectionState != STATE_CONNECTING_STAGE1 && this.m_ConnectionState != STATE_CONNECTING_STAGE2 && this.m_ConnectionState != STATE_CONNECTED)
         {
            return;
         }
         if(this.m_Socket != null && Boolean(this.m_Socket.connected) && this.m_Socket.bytesAvailable > 0)
         {
            this.m_Socket.readBytes(this.m_InBuffer,this.m_InBuffer.length);
         }
         loop0:
         while(this.m_InBuffer.length >= HEADER_SIZE)
         {
            this.m_InBuffer.position = PACKETLENGTH_POS;
            PacketLength = this.m_InBuffer.readUnsignedShort();
            PacketEOF = PacketLength + PACKETLENGTH_SIZE;
            if((PacketLength - CHECKSUM_SIZE) % XTEA.BLOCKSIZE != 0)
            {
               this.handleConnectionError(ERR_INVALID_SIZE,0,"Connection.readSocketData: Invalid packet size.");
               return;
            }
            if(this.m_InBuffer.bytesAvailable < PacketLength)
            {
               return;
            }
            this.m_InBuffer.position = CHECKSUM_POS;
            PacketChecksum = this.m_InBuffer.readUnsignedInt();
            CompareChecksum = s_GetAdler32(this.m_InBuffer,PAYLOAD_POS,PacketLength - CHECKSUM_SIZE);
            if(PacketChecksum !== CompareChecksum)
            {
               this.handleConnectionError(ERR_INVALID_CHECKSUM,0,"Connection.readSocketData: Invalid checksum.");
               return;
            }
            if(this.m_ConnectionState == STATE_CONNECTING_STAGE2 || this.m_ConnectionState == STATE_CONNECTED)
            {
               this.m_XTEA.decrypt(this.m_InBuffer,PAYLOAD_POS,PacketLength - CHECKSUM_SIZE);
            }
            this.m_InBuffer.position = PAYLOADLENGTH_POS;
            PayloadLength = this.m_InBuffer.readUnsignedShort();
            PayloadEOF = PAYLOADDATA_POSITION + PayloadLength;
            loop1:
            while(true)
            {
               if(this.m_InBuffer.position >= Math.min(this.m_InBuffer.length,PayloadEOF))
               {
                  RemainingBytes = 0;
                  if(this.m_InBuffer.length > PacketEOF)
                  {
                     RemainingBytes = this.m_InBuffer.length - PacketEOF;
                     ReadPosition = PacketEOF;
                     WritePosition = 0;
                     while(WritePosition < RemainingBytes)
                     {
                        this.m_InBuffer[WritePosition++] = this.m_InBuffer[ReadPosition++];
                     }
                  }
                  this.m_InBuffer.length = RemainingBytes;
                  continue loop0;
               }
               Type = this.m_InBuffer.readUnsignedByte();
               if(Type != SPING && Type != SPINGBACK)
               {
                  this.m_PingEarliestTime = Math.min(this.m_PingLatestTime,this.m_PingTimer.currentCount + PING_RETRY_INTERVAL);
               }
               else if(Type == SPINGBACK)
               {
                  this.m_PingEarliestTime = this.m_PingLatestTime = this.m_PingTimer.currentCount + PING_LATENCY_INTERVAL;
                  this.m_PingTimeout = this.m_PingEarliestTime + PING_RETRY_COUNT * PING_RETRY_INTERVAL;
                  if(this.m_PingCount > 0)
                  {
                     this.m_PingCount--;
                  }
                  if(this.m_PingCount == 0)
                  {
                     this.m_PingLatency = getTimer() - this.m_PingSent;
                  }
               }
               try
               {
                  switch(Type)
                  {
                     case SCHALLENGE:
                        this.readSCHALLENGE(this.m_InBuffer);
                        break;
                     case SLOGINERROR:
                        this.readSLOGINERROR(this.m_InBuffer);
                        break;
                     case SLOGINADVICE:
                        this.readSLOGINADVICE(this.m_InBuffer);
                        break;
                     case SLOGINWAIT:
                        this.readSLOGINWAIT(this.m_InBuffer);
                        break;
                     case SINITGAME:
                        this.readSINITGAME(this.m_InBuffer);
                        break;
                     case SPING:
                        this.readSPING(this.m_InBuffer);
                        break;
                     case SPINGBACK:
                        this.readSPINGBACK(this.m_InBuffer);
                        break;
                     case SDEAD:
                        this.readSDEAD(this.m_InBuffer);
                        break;
                     case SFULLMAP:
                        this.readSFULLMAP(this.m_InBuffer);
                        break;
                     case STOPROW:
                        this.readSTOPROW(this.m_InBuffer);
                        break;
                     case SRIGHTROW:
                        this.readSRIGHTROW(this.m_InBuffer);
                        break;
                     case SBOTTOMROW:
                        this.readSBOTTOMROW(this.m_InBuffer);
                        break;
                     case SLEFTROW:
                        this.readSLEFTROW(this.m_InBuffer);
                        break;
                     case SFIELDDATA:
                        this.readSFIELDDATA(this.m_InBuffer);
                        break;
                     case SCREATEONMAP:
                        this.readSCREATEONMAP(this.m_InBuffer);
                        break;
                     case SCHANGEONMAP:
                        this.readSCHANGEONMAP(this.m_InBuffer);
                        break;
                     case SDELETEONMAP:
                        this.readSDELETEONMAP(this.m_InBuffer);
                        break;
                     case SMOVECREATURE:
                        this.readSMOVECREATURE(this.m_InBuffer);
                        break;
                     case SCONTAINER:
                        this.readSCONTAINER(this.m_InBuffer);
                        break;
                     case SCLOSECONTAINER:
                        this.readSCLOSECONTAINER(this.m_InBuffer);
                        break;
                     case SCREATEINCONTAINER:
                        this.readSCREATEINCONTAINER(this.m_InBuffer);
                        break;
                     case SCHANGEINCONTAINER:
                        this.readSCHANGEINCONTAINER(this.m_InBuffer);
                        break;
                     case SDELETEINCONTAINER:
                        this.readSDELETEINCONTAINER(this.m_InBuffer);
                        break;
                     case SSETINVENTORY:
                        this.readSSETINVENTORY(this.m_InBuffer);
                        break;
                     case SDELETEINVENTORY:
                        this.readSDELETEINVENTORY(this.m_InBuffer);
                        break;
                     case SNPCOFFER:
                        this.readSNPCOFFER(this.m_InBuffer);
                        break;
                     case SPLAYERGOODS:
                        this.readSPLAYERGOODS(this.m_InBuffer);
                        break;
                     case SCLOSENPCTRADE:
                        this.readSCLOSENPCTRADE(this.m_InBuffer);
                        break;
                     case SOWNOFFER:
                        this.readSOWNOFFER(this.m_InBuffer);
                        break;
                     case SCOUNTEROFFER:
                        this.readSCOUNTEROFFER(this.m_InBuffer);
                        break;
                     case SCLOSETRADE:
                        this.readSCLOSETRADE(this.m_InBuffer);
                        break;
                     case SAMBIENTE:
                        this.readSAMBIENTE(this.m_InBuffer);
                        break;
                     case SGRAPHICALEFFECT:
                        this.readSGRAPHICALEFFECT(this.m_InBuffer);
                        break;
                     case SMISSILEEFFECT:
                        this.readSMISSILEEFFECT(this.m_InBuffer);
                        break;
                     case SMARKCREATURE:
                        this.readSMARKCREATURE(this.m_InBuffer);
                        break;
                     case STRAPPERS:
                        this.readSTRAPPERS(this.m_InBuffer);
                        break;
                     case SCREATUREHEALTH:
                        this.readSCREATUREHEALTH(this.m_InBuffer);
                        break;
                     case SCREATURELIGHT:
                        this.readSCREATURELIGHT(this.m_InBuffer);
                        break;
                     case SCREATUREOUTFIT:
                        this.readSCREATUREOUTFIT(this.m_InBuffer);
                        break;
                     case SCREATURESPEED:
                        this.readSCREATURESPEED(this.m_InBuffer);
                        break;
                     case SCREATURESKULL:
                        this.readSCREATURESKULL(this.m_InBuffer);
                        break;
                     case SCREATUREPARTY:
                        this.readSCREATUREPARTY(this.m_InBuffer);
                        break;
                     case SCREATUREUNPASS:
                        this.readSCREATUREUNPASS(this.m_InBuffer);
                        break;
                     case SEDITTEXT:
                        this.readSEDITTEXT(this.m_InBuffer);
                        break;
                     case SEDITLIST:
                        this.readSEDITLIST(this.m_InBuffer);
                        break;
                     case SPLAYERDATABASIC:
                        this.readSPLAYERDATABASIC(this.m_InBuffer);
                        break;
                     case SPLAYERDATACURRENT:
                        this.readSPLAYERDATACURRENT(this.m_InBuffer);
                        break;
                     case SPLAYERSKILLS:
                        this.readSPLAYERSKILLS(this.m_InBuffer);
                        break;
                     case SPLAYERSTATE:
                        this.readSPLAYERSTATE(this.m_InBuffer);
                        break;
                     case SCLEARTARGET:
                        this.readSCLEARTARGET(this.m_InBuffer);
                        break;
                     case SSPELLDELAY:
                        this.readSSPELLDELAY(this.m_InBuffer);
                        break;
                     case SSPELLGROUPDELAY:
                        this.readSSPELLGROUPDELAY(this.m_InBuffer);
                        break;
                     case SMULTIUSEDELAY:
                        this.readSUSEDELAY(this.m_InBuffer);
                        break;
                     case STALK:
                        this.readSTALK(this.m_InBuffer);
                        break;
                     case SCHANNELS:
                        this.readSCHANNELS(this.m_InBuffer);
                        break;
                     case SOPENCHANNEL:
                        this.readSOPENCHANNEL(this.m_InBuffer);
                        break;
                     case SPRIVATECHANNEL:
                        this.readSPRIVATECHANNEL(this.m_InBuffer);
                        break;
                     case SOPENOWNCHANNEL:
                        this.readSOPENOWNCHANNEL(this.m_InBuffer);
                        break;
                     case SCLOSECHANNEL:
                        this.readSCLOSECHANNEL(this.m_InBuffer);
                        break;
                     case SMESSAGE:
                        this.readSMESSAGE(this.m_InBuffer);
                        break;
                     case SSNAPBACK:
                        this.readSSNAPBACK(this.m_InBuffer);
                        break;
                     case SWAIT:
                        this.readSWAIT(this.m_InBuffer);
                        break;
                     case STOPFLOOR:
                        this.readSTOPFLOOR(this.m_InBuffer);
                        break;
                     case SBOTTOMFLOOR:
                        this.readSBOTTOMFLOOR(this.m_InBuffer);
                        break;
                     case SOUTFIT:
                        this.readSOUTFIT(this.m_InBuffer);
                        break;
                     case SBUDDYDATA:
                        this.readSBUDDYDATA(this.m_InBuffer);
                        break;
                     case SBUDDYLOGIN:
                        this.readSBUDDYLOGIN(this.m_InBuffer);
                        break;
                     case SBUDDYLOGOUT:
                        this.readSBUDDYLOGOUT(this.m_InBuffer);
                        break;
                     case STUTORIALHINT:
                        this.readSTUTORIALHINT(this.m_InBuffer);
                        break;
                     case SAUTOMAPFLAG:
                        this.readSAUTOMAPFLAG(this.m_InBuffer);
                        break;
                     case SQUESTLOG:
                        this.readSQUESTLOG(this.m_InBuffer);
                        break;
                     case SQUESTLINE:
                        this.readSQUESTLINE(this.m_InBuffer);
                        break;
                     case SCHANNELEVENT:
                        this.readSCHANNELEVENT(this.m_InBuffer);
                        break;
                     case SOBJECTINFO:
                        this.readSOBJECTINFO(this.m_InBuffer);
                        break;
                     case SPLAYERINVENTORY:
                        this.readSPLAYERINVENTORY(this.m_InBuffer);
                        break;
                     case SMARKETENTER:
                        this.readSMARKETENTER(this.m_InBuffer);
                        break;
                     case SMARKETLEAVE:
                        this.readSMARKETLEAVE(this.m_InBuffer);
                        break;
                     case SMARKETDETAIL:
                        this.readSMARKETDETAIL(this.m_InBuffer);
                        break;
                     case SMARKETBROWSE:
                        this.readSMARKETBROWSE(this.m_InBuffer);
                        break;
                     default:
                        break loop1;
                  }
               }
               catch(_Error:Error)
               {
                  handleReadError(Type,_Error);
                  return;
               }
            }
            this.handleConnectionError(ERR_INVALID_MESSAGE,0,"Connection.readSocketData: Invalid message type " + Type + ".");
            return;
         }
         this.m_WorldMapStorage.refreshFields();
         this.m_MiniMapStorage.refreshSectors();
         this.m_CreatureStorage.refreshOpponents();
      }
      
      public function sendCCANCEL() : void
      {
         var b:ByteArray = null;
         try
         {
            b = this.createPacket();
            b.writeByte(CCANCEL);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CCANCEL,e);
            return;
         }
      }
      
      public function sendCTURNOBJECT(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var b:ByteArray = null;
         var a_X:int = param1;
         var a_Y:int = param2;
         var a_Z:int = param3;
         var a_TypeID:int = param4;
         var a_Position:int = param5;
         try
         {
            b = this.createPacket();
            b.writeByte(CTURNOBJECT);
            b.writeShort(a_X);
            b.writeShort(a_Y);
            b.writeByte(a_Z);
            b.writeShort(a_TypeID);
            b.writeByte(a_Position);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CTURNOBJECT,e);
            return;
         }
      }
      
      public function get isGameRunning() : Boolean
      {
         return this.m_ConnectionState == STATE_CONNECTED;
      }
      
      public function sendCINSPECTNPCTRADE(param1:int, param2:int) : void
      {
         var b:ByteArray = null;
         var a_Type:int = param1;
         var a_Data:int = param2;
         try
         {
            b = this.createPacket();
            b.writeByte(CINSPECTNPCTRADE);
            b.writeShort(a_Type);
            b.writeByte(a_Data);
            this.sendPacket(true);
            return;
         }
         catch(e:Error)
         {
            handleSendError(CINSPECTNPCTRADE,e);
            return;
         }
      }
   }
}

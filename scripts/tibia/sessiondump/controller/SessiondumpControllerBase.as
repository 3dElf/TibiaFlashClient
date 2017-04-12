package tibia.sessiondump.controller
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import shared.utility.*;
    import tibia.sessiondump.*;
    import tibia.sessiondump.controller.*;

    public class SessiondumpControllerBase extends Object implements ISessiondumpRemoteControl
    {
        private var m_CalculatedPlayspeedFactors:Vector.<uint> = null;
        private var m_StartTimestamp:int = 0;
        private var m_LastProcessedSessiondumpPacketTimestamp:uint = 0;
        protected var m_Sessiondump:Sessiondump = null;
        private var m_PlaybackFactor:Number = 1;
        private var m_SuspendProcessingOfMessages:Boolean = false;
        private var m_CalculatedPlayspeedFactorCurrentIndex:uint = 0;
        private var m_YieldMessageProcessingAfterMilliseconds:uint = 200;
        protected var m_SecondaryTimestamp:int = 0;
        private var m_LastRealTimestamp:uint = 0;
        private var m_TargetSessiondumpLabel:SessiondumpTargetInformation = null;
        private var m_MaxPlayspeedFactor:uint = 1024;
        private var m_CalculatedPlayspeedLastProcessedSessiondumpPacketTimestamp:uint = 0;
        protected var m_SessiondumpReader:SessiondumpReader = null;
        static const CUPCONTAINER:int = 136;
        static const CQUITGAME:int = 20;
        static const CMARKETACCEPT:int = 248;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const CGONORTHWEST:int = 109;
        static const SOUTFIT:int = 200;
        static const CADDBUDDY:int = 220;
        static const CSETTACTICS:int = 160;
        static const CPERFORMANCEMETRICS:int = 31;
        static const SSHOWMESSAGEDIALOG:int = 237;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        static const SSETTACTICS:int = 167;
        static const SPLAYERDATABASIC:int = 159;
        static const CGOSOUTH:int = 103;
        static const PACKETLENGTH_SIZE:int = 2;
        static const SMESSAGE:int = 180;
        static const CPING:int = 29;
        static const SCREDITBALANCE:int = 223;
        static const SPREYDATA:int = 232;
        static const CGETQUESTLOG:int = 240;
        static const CENTERWORLD:int = 15;
        static const CBUYOBJECT:int = 122;
        static const SPING:int = 29;
        static const CROTATENORTH:int = 111;
        static const SWAIT:int = 182;
        static const CATTACK:int = 161;
        static const SLOGINSUCCESS:int = 23;
        static const CCLOSENPCCHANNEL:int = 158;
        static const CLOOKATCREATURE:int = 141;
        static const CJOINCHANNEL:int = 152;
        static const CROTATEEAST:int = 112;
        static const SBUDDYDATA:int = 210;
        static const CUSEONCREATURE:int = 132;
        static const CBROWSEFIELD:int = 203;
        static const CPREYACTION:int = 235;
        static const SCREATUREPARTY:int = 145;
        static const SQUESTLOG:int = 240;
        static const ERR_INTERNAL:int = 0;
        static const CCANCEL:int = 190;
        static const CGUILDMESSAGE:int = 155;
        static const SPREYTIMELEFT:int = 231;
        static const CAPPLYIMBUEMENT:int = 213;
        static const CREMOVEBUDDY:int = 221;
        static const CCLOSECONTAINER:int = 135;
        static const SFIELDDATA:int = 105;
        static const SCLOSECONTAINER:int = 111;
        static const SLEFTROW:int = 104;
        static const SFULLMAP:int = 100;
        static const CREQUESTRESOURCEBALANCE:int = 237;
        static const SMISSILEEFFECT:int = 133;
        public static const MESSAGEDIALOG_IMBUEMENT_ERROR:int = 1;
        static const CGOWEST:int = 104;
        static const CPASSLEADERSHIP:int = 166;
        static const SSPELLGROUPDELAY:int = 165;
        static const SBOTTOMROW:int = 103;
        static const CGETOBJECTINFO:int = 243;
        static const CSEEKINCONTAINER:int = 204;
        static const SQUESTLINE:int = 241;
        static const SUPDATINGSHOPBALANCE:int = 242;
        static const CGOSOUTHWEST:int = 108;
        static const SLOGINERROR:int = 20;
        static const SCREATUREMARKS:int = 147;
        static const SPREYFREELISTREROLLAVAILABILITY:int = 230;
        static const CREJECTTRADE:int = 128;
        static const SREQUESTPURCHASEDATA:int = 225;
        static const CREVOKEINVITATION:int = 165;
        static const ERR_CONNECTION_LOST:int = 6;
        static const CLOGIN:int = 10;
        public static const MESSAGEDIALOG_PREY_ERROR:int = 21;
        static const SCREATURESKULL:int = 144;
        static const SUNJUSTIFIEDPOINTS:int = 183;
        static const SPLAYERDATACURRENT:int = 160;
        static const STRAPPERS:int = 135;
        static const SOBJECTINFO:int = 244;
        static const CGETQUESTLINE:int = 241;
        static const SSNAPBACK:int = 181;
        static const CGETCHANNELS:int = 151;
        static const CROTATESOUTH:int = 113;
        static const CACCEPTTRADE:int = 127;
        static const SCHANNELS:int = 171;
        static const SOPENCHANNEL:int = 172;
        static const STOPFLOOR:int = 190;
        public static const MESSAGEDIALOG_PREY_MESSAGE:int = 20;
        static const CBUYPREMIUMOFFER:int = 252;
        static const CLOOKTRADE:int = 126;
        static const SPRIVATECHANNEL:int = 173;
        static const SBLESSINGS:int = 156;
        static const SINGAMESHOPSUCCESS:int = 254;
        static const SSTOREBUTTONINDICATORS:int = 25;
        static const CPRIVATECHANNEL:int = 154;
        static const PAYLOADLENGTH_POS:int = 6;
        static const SLOGINWAIT:int = 22;
        public static const RESOURCETYPE_BANK_GOLD:int = 0;
        static const SCREATEONMAP:int = 106;
        static const SPREYREROLLPRICE:int = 233;
        static const CTRADEOBJECT:int = 125;
        static const CGETTRANSACTIONHISTORY:int = 254;
        static const CLOOK:int = 140;
        static const ERR_INVALID_CHECKSUM:int = 2;
        public static const MESSAGEDIALOG_CLEARING_CHARM_SUCCESS:int = 10;
        static const SCONTAINER:int = 110;
        static const SNPCOFFER:int = 122;
        static const CMARKETCANCEL:int = 247;
        static const SWORLDENTERED:int = 15;
        static const HEADER_POS:int = 0;
        static const STRANSACTIONHISTORY:int = 253;
        static const SPREMIUMSHOPOFFERS:int = 252;
        static const CMOUNT:int = 212;
        static const CCLOSENPCTRADE:int = 124;
        static const SMARKETBROWSE:int = 249;
        static const CSELLOBJECT:int = 123;
        static const CMARKETBROWSE:int = 245;
        static const SMARKETLEAVE:int = 247;
        static const SCOUNTEROFFER:int = 126;
        static const CFOLLOW:int = 162;
        static const SBUDDYGROUPDATA:int = 212;
        static const CEXCLUDEFROMCHANNEL:int = 172;
        public static const MESSAGEDIALOG_IMBUING_STATION_NOT_FOUND:int = 3;
        static const SMARKETENTER:int = 246;
        static const SCLIENTCHECK:int = 99;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const SCREATURESPEED:int = 143;
        static const CREQUESTSHOPOFFERS:int = 251;
        static const CANSWERMODALDIALOG:int = 249;
        static const CCLOSEDIMBUINGDIALOG:int = 215;
        static const SSPELLDELAY:int = 164;
        static const CEDITBUDDY:int = 222;
        static const SDELETEONMAP:int = 108;
        static const CEDITGUILDMESSAGE:int = 156;
        static const CROTATEWEST:int = 114;
        public static const PROTOCOL_VERSION:int = 1121;
        static const SCREATUREOUTFIT:int = 142;
        static const SEDITGUILDMESSAGE:int = 174;
        static const SAMBIENTE:int = 130;
        static const ERR_INVALID_SIZE:int = 1;
        static const SLOGINCHALLENGE:int = 31;
        static const CLEAVECHANNEL:int = 153;
        static const SPLAYERSKILLS:int = 161;
        static const CTHANKYOU:int = 231;
        static const SRESOURCEBALANCE:int = 238;
        static const SCREATUREUNPASS:int = 146;
        static const SSHOWMODALDIALOG:int = 250;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const CGONORTHEAST:int = 106;
        static const SDELETEINCONTAINER:int = 114;
        public static const RESOURCETYPE_INVENTORY_GOLD:int = 1;
        static const SCREATEINCONTAINER:int = 112;
        static const CERRORFILEENTRY:int = 232;
        static const HEADER_SIZE:int = 6;
        static const SCREATUREHEALTH:int = 140;
        static const STOPROW:int = 101;
        static const SBOTTOMFLOOR:int = 191;
        static const CTURNOBJECT:int = 133;
        static const COPENPREMIUMSHOP:int = 250;
        static const CINSPECTPLAYER:int = 206;
        static const CUSEOBJECT:int = 130;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const CINVITETOCHANNEL:int = 171;
        static const CLOOKNPCTRADE:int = 121;
        static const ERR_INVALID_STATE:int = 4;
        static const CUSETWOOBJECTS:int = 131;
        static const SPREMIUMTRIGGER:int = 158;
        static const CINVITETOPARTY:int = 163;
        static const SCREATURELIGHT:int = 141;
        static const CPINGBACK:int = 30;
        static const SPINGBACK:int = 30;
        static const STUTORIALHINT:int = 220;
        static const SPLAYERGOODS:int = 123;
        static const CSTOP:int = 105;
        static const SPLAYERINVENTORY:int = 245;
        static const CINSPECTOBJECT:int = 205;
        static const SINSPECTIONSTATE:int = 119;
        static const CMOVEOBJECT:int = 120;
        static const CRULEVIOLATIONREPORT:int = 242;
        static const CJOINAGGRESSION:int = 142;
        static const SMOVECREATURE:int = 109;
        static const SSWITCHPRESET:int = 157;
        static const CGOEAST:int = 102;
        public static const MESSAGEDIALOG_CLEARING_CHARM_ERROR:int = 11;
        static const CEDITLIST:int = 138;
        static const CTOGGLEWRAPSTATE:int = 139;
        static const CJOINPARTY:int = 164;
        static const SCLOSETRADE:int = 127;
        static const CONNECTION_STATE_GAME:int = 4;
        static const SMULTIUSEDELAY:int = 166;
        static const CSTOREEVENT:int = 233;
        static const SEDITLIST:int = 151;
        static const SSETINVENTORY:int = 120;
        static const CGOPATH:int = 100;
        static const CLEAVEPARTY:int = 167;
        static const SCHANGEONMAP:int = 107;
        static const CGOSOUTHEAST:int = 107;
        static const SINSPECTIONLIST:int = 118;
        static const CEQUIPOBJECT:int = 119;
        static const SCREATUREPVPHELPERS:int = 148;
        static const COPENCHANNEL:int = 170;
        static const SDEAD:int = 40;
        static const SCHANGEINCONTAINER:int = 113;
        static const SIMBUINGDIALOGREFRESH:int = 235;
        public static const MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED:int = 2;
        static const SDELETEINVENTORY:int = 121;
        static const CTRANSFERCURRENCY:int = 239;
        static const SINGAMESHOPERROR:int = 224;
        static const SCHANNELEVENT:int = 243;
        static const SPVPSITUATIONS:int = 184;
        static const SLOGINADVICE:int = 21;
        static const CAPPLYCLEARINGCHARM:int = 214;
        static const CGONORTH:int = 101;
        static const SMARKETDETAIL:int = 248;
        public static const MESSAGEDIALOG_IMBUEMENT_SUCCESS:int = 0;
        static const CTALK:int = 150;
        static const PAYLOADDATA_POSITION:int = 8;
        static const SPREMIUMSHOP:int = 251;
        static const SEQUENCE_NUMBER_POS:int = 2;
        static const STALK:int = 170;
        static const CEDITTEXT:int = 137;
        static const SCLOSENPCTRADE:int = 124;
        static const SPENDINGSTATEENTERED:int = 10;
        static const PAYLOADLENGTH_SIZE:int = 2;
        static const SRIGHTROW:int = 102;
        static const SEDITTEXT:int = 150;
        static const SOPENOWNCHANNEL:int = 178;
        static const SGRAPHICALEFFECT:int = 131;
        static const CBUGREPORT:int = 230;
        static const SCLOSEIMBUINGDIALOG:int = 236;
        private static const CALCULATED_PLAYSPEED_FACTOR_SAMPLE_SIZE:uint = 3;
        static const CMARKETLEAVE:int = 244;
        static const SEQUENCE_NUMBER_SIZE:int = 4;
        static const COPENTRANSACTIONHISTORY:int = 253;
        static const CSHAREEXPERIENCE:int = 168;
        static const SCLEARTARGET:int = 163;
        static const SCREATURETYPE:int = 149;
        static const CGETOUTFIT:int = 210;
        static const SCLOSECHANNEL:int = 179;
        static const CSETOUTFIT:int = 211;
        static const PACKETLENGTH_POS:int = 0;
        static const SBUDDYSTATUSCHANGE:int = 211;
        static const SAUTOMAPFLAG:int = 221;
        static const SOWNOFFER:int = 125;
        static const PAYLOAD_POS:int = 6;
        public static const RESOURCETYPE_PREY_BONUS_REROLLS:int = 10;
        static const SSETSTOREDEEPLINK:int = 168;
        static const CMARKETCREATE:int = 246;
        static const SPLAYERSTATE:int = 162;

        public function SessiondumpControllerBase()
        {
            return;
        }// end function

        public function set suspendProcessing(param1:Boolean) : void
        {
            if (param1 != this.m_SuspendProcessingOfMessages && param1 == false)
            {
                this.synchronizeSessiondumpTimeWithTibiaTime(Tibia.s_GetTibiaTimer());
            }
            this.m_SuspendProcessingOfMessages = param1;
            return;
        }// end function

        public function set maxPlayspeedFactor(param1:uint) : void
        {
            if (param1 == 0)
            {
                throw new ArgumentError("Sessiondump.maxPlayspeedFactor: Value must be bigger than zero");
            }
            this.m_MaxPlayspeedFactor = param1;
            return;
        }// end function

        public function get calculatedPlaySpeedFactor() : Number
        {
            if (this.playSpeedFactor == 0 && this.playSpeedFactor <= 1)
            {
                return this.playSpeedFactor;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < CALCULATED_PLAYSPEED_FACTOR_SAMPLE_SIZE)
            {
                
                _loc_1 = _loc_1 + this.m_CalculatedPlayspeedFactors[_loc_3];
                _loc_2 = _loc_2 + 1;
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2 > 0)
            {
                return _loc_1 / _loc_2 + 0.5;
            }
            return 0;
        }// end function

        public function get targetTimestamp() : uint
        {
            if (this.m_TargetSessiondumpLabel != null)
            {
                return this.m_TargetSessiondumpLabel.offsetMilliseconds;
            }
            return 0;
        }// end function

        public function clearTargetTimestamp() : void
        {
            this.m_TargetSessiondumpLabel = null;
            return;
        }// end function

        public function stop() : void
        {
            Tibia.s_GetInstance().reset();
            this.m_Sessiondump.reconnect();
            this.playSpeedFactor = 1;
            return;
        }// end function

        public function get sessiondumpDuration() : uint
        {
            return this.m_Sessiondump.sessiondumpDuration;
        }// end function

        public function get isConnected() : Boolean
        {
            return this.m_Sessiondump.isConnected;
        }// end function

        public function get sessiondump() : Sessiondump
        {
            return this.m_Sessiondump;
        }// end function

        public function disconnect() : void
        {
            this.m_Sessiondump = null;
            var _loc_1:* = Tibia.s_GetSecondaryTimer();
            _loc_1.removeEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            return;
        }// end function

        public function get playSpeedFactor() : Number
        {
            return Tibia.s_TibiaTimerFactor;
        }// end function

        public function get yieldMessageProcessingAfterMilliseconds() : uint
        {
            return this.m_YieldMessageProcessingAfterMilliseconds;
        }// end function

        private function measureRealPlaybackSpeed() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = getTimer();
            if (this.m_CalculatedPlayspeedLastProcessedSessiondumpPacketTimestamp != this.m_LastProcessedSessiondumpPacketTimestamp && _loc_1 > this.m_LastRealTimestamp + 500)
            {
                _loc_2 = _loc_1 - this.m_LastRealTimestamp;
                _loc_3 = this.m_LastProcessedSessiondumpPacketTimestamp - this.m_CalculatedPlayspeedLastProcessedSessiondumpPacketTimestamp;
                if (_loc_2 > 0)
                {
                    _loc_4 = _loc_3 / _loc_2;
                    var _loc_5:* = this;
                    _loc_5.m_CalculatedPlayspeedFactorCurrentIndex = this.m_CalculatedPlayspeedFactorCurrentIndex + 1;
                    this.m_CalculatedPlayspeedFactors[this.m_CalculatedPlayspeedFactorCurrentIndex++ % CALCULATED_PLAYSPEED_FACTOR_SAMPLE_SIZE] = _loc_4;
                    this.m_LastRealTimestamp = _loc_1;
                    this.m_CalculatedPlayspeedLastProcessedSessiondumpPacketTimestamp = this.m_LastProcessedSessiondumpPacketTimestamp;
                }
            }
            return;
        }// end function

        private function cleanupBeforeForcedRender() : void
        {
            Tibia.s_GetWorldMapStorage().resetOnscreenMessages();
            return;
        }// end function

        public function play() : void
        {
            Tibia.s_TibiaTimerFactor = 1;
            this.m_TargetSessiondumpLabel = null;
            return;
        }// end function

        public function set yieldMessageProcessingAfterMilliseconds(param1:uint) : void
        {
            this.m_YieldMessageProcessingAfterMilliseconds = param1;
            return;
        }// end function

        public function setTargetTimestamp(param1:uint, param2:int = 0) : void
        {
            if (param1 != 0)
            {
                this.m_TargetSessiondumpLabel = new SessiondumpTargetInformation(param1, param2);
                if (this.playSpeedFactor < 1)
                {
                    this.playSpeedFactor = 1;
                }
                this.m_SuspendProcessingOfMessages = false;
            }
            else
            {
                this.m_TargetSessiondumpLabel = null;
            }
            return;
        }// end function

        public function set playSpeedFactor(param1:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = Math.min(this.m_MaxPlayspeedFactor, param1);
            if (!isNaN(param1) && Tibia.s_TibiaTimerFactor != _loc_2)
            {
                Tibia.s_TibiaTimerFactor = _loc_2;
                if (param1 == 0)
                {
                    _loc_3 = 0;
                    while (_loc_3 < CALCULATED_PLAYSPEED_FACTOR_SAMPLE_SIZE)
                    {
                        
                        this.m_CalculatedPlayspeedFactors[_loc_3] = 0;
                        _loc_3 = _loc_3 + 1;
                    }
                }
            }
            return;
        }// end function

        public function get currentSessiondumpTimestamp() : uint
        {
            if (this.m_SessiondumpReader.packetReader != null)
            {
                return this.m_LastProcessedSessiondumpPacketTimestamp;
            }
            return 0;
        }// end function

        public function get maxPlayspeedFactor() : uint
        {
            return this.m_MaxPlayspeedFactor;
        }// end function

        public function showInfo() : void
        {
            return;
        }// end function

        public function get nextSessiondumpPacketTimestamp() : uint
        {
            if (this.m_SessiondumpReader.isPacketReady)
            {
                return this.m_SessiondumpReader.packetReader.packetTimestamp;
            }
            return 0;
        }// end function

        public function get isGameRunning() : Boolean
        {
            return this.m_Sessiondump.connectionState == CONNECTION_STATE_GAME;
        }// end function

        protected function synchronizeSessiondumpTimeWithTibiaTime(param1:int) : void
        {
            var _loc_2:* = param1 - this.m_StartTimestamp;
            if (_loc_2 > this.nextSessiondumpPacketTimestamp || _loc_2 < this.m_LastProcessedSessiondumpPacketTimestamp)
            {
                this.m_StartTimestamp = param1 - Math.max(this.m_LastProcessedSessiondumpPacketTimestamp, this.nextSessiondumpPacketTimestamp);
            }
            return;
        }// end function

        public function connect(param1:Sessiondump, param2:SessiondumpReader) : void
        {
            this.m_Sessiondump = param1;
            this.m_SessiondumpReader = param2;
            this.m_CalculatedPlayspeedLastProcessedSessiondumpPacketTimestamp = 0;
            this.m_LastProcessedSessiondumpPacketTimestamp = 0;
            this.m_TargetSessiondumpLabel = null;
            this.m_LastRealTimestamp = 0;
            this.m_CalculatedPlayspeedFactorCurrentIndex = 0;
            this.synchronizeSessiondumpTimeWithTibiaTime(Tibia.s_GetTibiaTimer());
            this.m_PlaybackFactor = 1;
            Tibia.s_TibiaTimerFactor = this.m_PlaybackFactor;
            if (Tibia.s_GetMiniMapStorage() != null)
            {
                Tibia.s_GetMiniMapStorage().reset();
            }
            this.m_CalculatedPlayspeedFactors = new Vector.<uint>(CALCULATED_PLAYSPEED_FACTOR_SAMPLE_SIZE, true);
            var _loc_3:* = Tibia.s_GetSecondaryTimer();
            _loc_3.addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            return;
        }// end function

        public function get currentSessiondumpEstimatedTimestamp() : uint
        {
            if (this.m_Sessiondump == null)
            {
                return 0;
            }
            if (this.m_Sessiondump.sessiondumpDone)
            {
                return this.m_Sessiondump.sessiondumpDuration;
            }
            if (this.m_SuspendProcessingOfMessages)
            {
                this.synchronizeSessiondumpTimeWithTibiaTime(Tibia.s_GetTibiaTimer());
            }
            return Math.min(Math.max(Tibia.s_GetTibiaTimer() - this.m_StartTimestamp, this.currentSessiondumpTimestamp), this.nextSessiondumpPacketTimestamp);
        }// end function

        public function get suspendProcessing() : Boolean
        {
            return this.m_SuspendProcessingOfMessages;
        }// end function

        private function onSecondaryTimer(event:TimerEvent) : void
        {
            var _loc_2:* = Tibia.s_GetTibiaTimer();
            if (_loc_2 > this.m_SecondaryTimestamp)
            {
                this.processPackets();
            }
            this.m_SecondaryTimestamp = _loc_2;
            return;
        }// end function

        public function get stillLoading() : Boolean
        {
            return this.m_Sessiondump.stillLoading;
        }// end function

        public function gotoKeyframe(param1:uint) : void
        {
            var _loc_3:* = 0;
            if (this.m_Sessiondump.stillLoading)
            {
                throw new Error("Sessiondump.gotoKeyframe: Sessiondump has to be read completely for a goto to work");
            }
            this.m_SessiondumpReader.messageReader.finishMessage();
            this.m_SessiondumpReader.packetReader.finishPacket();
            this.m_SessiondumpReader.inputBuffer.position = param1;
            var _loc_2:* = false;
            if (this.m_SessiondumpReader.packetReader.isPacketReady)
            {
                this.m_LastProcessedSessiondumpPacketTimestamp = this.m_SessiondumpReader.packetReader.packetTimestamp;
                this.m_CalculatedPlayspeedLastProcessedSessiondumpPacketTimestamp = this.m_LastProcessedSessiondumpPacketTimestamp;
                while (this.m_SessiondumpReader.packetReader.containsUnreadMessage)
                {
                    
                    _loc_3 = this.m_SessiondumpReader.messageReader.messageType;
                    if (_loc_3 != Sessiondump.SKEYFRAMEBEGIN)
                    {
                        this.m_SessiondumpReader.messageReader.finishMessage();
                        continue;
                    }
                    _loc_2 = true;
                    break;
                }
            }
            if (_loc_2 == false)
            {
                throw new Error("Sessiondump.gotoKeyframe: Packet contains no KEYFRAMEBEGIN message");
            }
            this.m_Sessiondump.processNextKeyframe();
            Tibia.s_GetInstance().reset(false);
            this.synchronizeSessiondumpTimeWithTibiaTime(Tibia.s_GetTibiaTimer());
            this.playSpeedFactor = 1;
            return;
        }// end function

        protected function processPackets() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this.m_Sessiondump.sessiondumpDone || this.m_SuspendProcessingOfMessages)
            {
                return;
            }
            this.measureRealPlaybackSpeed();
            if (this.m_SessiondumpReader != null && this.m_SessiondumpReader.isPacketReady)
            {
                _loc_1 = true;
                _loc_2 = Tibia.s_GetTibiaTimer();
                _loc_3 = _loc_2 - this.m_StartTimestamp;
                while (_loc_1)
                {
                    
                    if (this.m_SuspendProcessingOfMessages)
                    {
                        _loc_1 = false;
                    }
                    else if (this.m_Sessiondump.state == Sessiondump.STATE_LOADED && this.m_SessiondumpReader.inputBuffer.bytesAvailable == 0)
                    {
                        _loc_1 = false;
                    }
                    else if (this.m_SessiondumpReader.packetReader.isPacketReady == false)
                    {
                        _loc_1 = false;
                    }
                    else if (this.isGameRunning && getTimer() - Tibia.s_FrameRealTimestamp > this.m_YieldMessageProcessingAfterMilliseconds)
                    {
                        _loc_1 = false;
                        if (_loc_3 > this.m_SessiondumpReader.packetReader.packetTimestamp)
                        {
                            this.synchronizeSessiondumpTimeWithTibiaTime(_loc_2);
                        }
                        this.cleanupBeforeForcedRender();
                    }
                    else if (this.m_TargetSessiondumpLabel != null && this.m_TargetSessiondumpLabel.calculatedOffsetMilliseconds > this.m_LastProcessedSessiondumpPacketTimestamp)
                    {
                        _loc_1 = true;
                        if (this.calculatedPlaySpeedFactor > 1)
                        {
                            this.playSpeedFactor = nextPowerOfTwo(this.calculatedPlaySpeedFactor);
                        }
                    }
                    else
                    {
                        if (this.m_TargetSessiondumpLabel != null)
                        {
                            if (this.m_TargetSessiondumpLabel.calculatedOffsetMilliseconds <= this.m_LastProcessedSessiondumpPacketTimestamp)
                            {
                                this.playSpeedFactor = 1;
                                this.synchronizeSessiondumpTimeWithTibiaTime(_loc_2);
                            }
                            if (this.m_TargetSessiondumpLabel.offsetMilliseconds <= this.m_LastProcessedSessiondumpPacketTimestamp)
                            {
                                if (this.m_Sessiondump.hasEventListener(SessiondumpEvent.TARGET_REACHED))
                                {
                                    _loc_4 = new SessiondumpEvent(SessiondumpEvent.TARGET_REACHED, false, false, 0, false, this.m_TargetSessiondumpLabel.offsetMilliseconds);
                                    this.m_Sessiondump.dispatchEvent(_loc_4);
                                }
                                this.m_TargetSessiondumpLabel = null;
                                this.playSpeedFactor = 1;
                                this.synchronizeSessiondumpTimeWithTibiaTime(_loc_2);
                                _loc_3 = 0;
                            }
                        }
                        _loc_1 = this.m_SessiondumpReader.packetReader.packetTimestamp < _loc_3;
                    }
                    if (_loc_1)
                    {
                        _loc_5 = false;
                        if (this.m_Sessiondump.hasEventListener(SessiondumpEvent.PACKET_AVAILABLE))
                        {
                            _loc_6 = new SessiondumpEvent(SessiondumpEvent.PACKET_AVAILABLE, false, true, 0, this.m_SessiondumpReader.packetReader.isClientPacket, this.m_SessiondumpReader.packetReader.packetTimestamp);
                            this.m_Sessiondump.dispatchEvent(_loc_6);
                            _loc_5 = _loc_6.isDefaultPrevented();
                        }
                        if (this.m_Sessiondump == null || _loc_5)
                        {
                            _loc_1 = false;
                            this.synchronizeSessiondumpTimeWithTibiaTime(_loc_2);
                        }
                        else
                        {
                            this.m_Sessiondump.readCommunicationData();
                            this.m_LastProcessedSessiondumpPacketTimestamp = this.m_SessiondumpReader.packetReader.packetTimestamp;
                        }
                        if (this.m_Sessiondump != null && this.m_Sessiondump.isConnected)
                        {
                            this.m_Sessiondump.communication.messageProcessingFinished(false);
                            continue;
                        }
                        _loc_1 = false;
                    }
                }
            }
            if (this.m_Sessiondump != null && (!this.m_Sessiondump.isConnected || this.m_Sessiondump.sessiondumpDone))
            {
                this.synchronizeSessiondumpTimeWithTibiaTime(_loc_2);
                Tibia.s_TibiaTimerFactor = 0;
                _loc_7 = new Event(Event.COMPLETE);
                this.m_Sessiondump.dispatchEvent(_loc_7);
            }
            return;
        }// end function

        public function pause() : void
        {
            this.playSpeedFactor = 0;
            this.synchronizeSessiondumpTimeWithTibiaTime(Tibia.s_GetTibiaTimer());
            this.m_TargetSessiondumpLabel = null;
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.events.*;

import flash.utils.*;

import shared.utility.*;

import tibia.sessiondump.*;

import tibia.sessiondump.controller.*;

class SessiondumpTargetInformation extends Object
{
    private var m_JumpOffsetMilliseconds:int = 0;
    private var m_OffsetMilliseconds:uint = 0;

    function SessiondumpTargetInformation(param1:uint, param2:int)
    {
        this.m_OffsetMilliseconds = param1;
        this.m_JumpOffsetMilliseconds = param2;
        return;
    }// end function

    public function get calculatedOffsetMilliseconds() : uint
    {
        return Math.max(0, this.m_OffsetMilliseconds + this.m_JumpOffsetMilliseconds);
    }// end function

    public function get offsetMilliseconds() : uint
    {
        return this.m_OffsetMilliseconds;
    }// end function

}


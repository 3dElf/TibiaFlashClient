package tibia.network
{
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.resources.*;
    import shared.cryptography.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.network.*;

    public class Connection extends EventDispatcher implements IServerConnection
    {
        private var m_Address:String = null;
        private var m_PingEarliestTime:uint = 0;
        private var m_CurrentConnectionData:IConnectionData = null;
        private var m_SessionKey:String = null;
        private var m_PacketReader:NetworkPacketReader = null;
        private var m_XTEA:XTEA = null;
        private var m_LastEvent:int = 0;
        private var m_Port:int = 2.14748e+009;
        protected var m_SecondaryTimestamp:int = 0;
        private var m_PingLatestTime:uint = 0;
        private var m_PingLatency:uint = 0;
        private var m_MessageReader:NetworkMessageReader = null;
        private var m_PingCount:int = 0;
        private var m_ConnectionDelay:Timer = null;
        private var m_ConnectionState:int = 0;
        private var m_Communication:IServerCommunication = null;
        private var m_ConnectionWasLost:Boolean = false;
        private var m_PingTimer:Timer = null;
        private var m_RSAPublicKey:RSAPublicKey = null;
        private var m_PingTimeout:uint = 0;
        private var m_Socket:Socket = null;
        private var m_InputBuffer:ByteArray = null;
        private var m_WorldName:String = null;
        private var m_PingSent:uint = 0;
        private var m_CharacterName:String = null;
        private var m_MessageWriter:NetworkMessageWriter = null;
        private var m_ConnectedSince:int = 0;
        static const CUPCONTAINER:int = 136;
        static const CQUITGAME:int = 20;
        static const CMARKETACCEPT:int = 248;
        static const CGONORTHWEST:int = 109;
        static const CADDBUDDY:int = 220;
        static const SOUTFIT:int = 200;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const CSETTACTICS:int = 160;
        static const CPERFORMANCEMETRICS:int = 31;
        static const SSHOWMESSAGEDIALOG:int = 237;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        static const CGOSOUTH:int = 103;
        static const SSETTACTICS:int = 167;
        static const SPLAYERDATABASIC:int = 159;
        static const PACKETLENGTH_SIZE:int = 2;
        static const SMESSAGE:int = 180;
        static const CPING:int = 29;
        static const SCREDITBALANCE:int = 223;
        static const SPREYDATA:int = 232;
        static const CGETQUESTLOG:int = 240;
        static const CENTERWORLD:int = 15;
        static const CBUYOBJECT:int = 122;
        public static const CLIENT_VERSION:uint = 2456;
        static const SPING:int = 29;
        static const CCLOSENPCCHANNEL:int = 158;
        public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
        static const SWAIT:int = 182;
        static const SLOGINSUCCESS:int = 23;
        static const CROTATENORTH:int = 111;
        static const CATTACK:int = 161;
        public static const LATENCY_LOW:Number = 200;
        static const CLOOKATCREATURE:int = 141;
        static const CJOINCHANNEL:int = 152;
        static const CROTATEEAST:int = 112;
        static const SBUDDYDATA:int = 210;
        static const CUSEONCREATURE:int = 132;
        public static const LATENCY_HIGH:Number = 1000;
        static const SPREYTIMELEFT:int = 231;
        static const CBROWSEFIELD:int = 203;
        static const CPREYACTION:int = 235;
        static const SCREATUREPARTY:int = 145;
        static const SQUESTLOG:int = 240;
        static const CGUILDMESSAGE:int = 155;
        static const CCANCEL:int = 190;
        static const ERR_INTERNAL:int = 0;
        static const CREMOVEBUDDY:int = 221;
        static const CAPPLYIMBUEMENT:int = 213;
        private static const BUNDLE:String = "Connection";
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
        static const CLOGIN:int = 10;
        static const SREQUESTPURCHASEDATA:int = 225;
        static const CREVOKEINVITATION:int = 165;
        static const SCREATURESKULL:int = 144;
        public static const MESSAGEDIALOG_PREY_ERROR:int = 21;
        static const CGETCHANNELS:int = 151;
        static const SUNJUSTIFIEDPOINTS:int = 183;
        static const SPLAYERDATACURRENT:int = 160;
        static const STRAPPERS:int = 135;
        static const SOBJECTINFO:int = 244;
        static const CGETQUESTLINE:int = 241;
        static const SSNAPBACK:int = 181;
        static const ERR_CONNECTION_LOST:int = 6;
        static const CROTATESOUTH:int = 113;
        static const CACCEPTTRADE:int = 127;
        static const SCHANNELS:int = 171;
        static const SOPENCHANNEL:int = 172;
        static const STOPFLOOR:int = 190;
        private static const PING_RETRY_COUNT:int = 3;
        public static const MESSAGEDIALOG_PREY_MESSAGE:int = 20;
        static const CBUYPREMIUMOFFER:int = 252;
        static const CLOOKTRADE:int = 126;
        static const SPRIVATECHANNEL:int = 173;
        static const SBLESSINGS:int = 156;
        static const SINGAMESHOPSUCCESS:int = 254;
        static const SSTOREBUTTONINDICATORS:int = 25;
        static const CPRIVATECHANNEL:int = 154;
        static const CGETTRANSACTIONHISTORY:int = 254;
        static const SLOGINWAIT:int = 22;
        public static const RESOURCETYPE_BANK_GOLD:int = 0;
        static const SCREATEONMAP:int = 106;
        static const SPREYREROLLPRICE:int = 233;
        public static const PREVIEW_STATE_REGULAR:uint = 0;
        static const CTRADEOBJECT:int = 125;
        public static const MESSAGEDIALOG_CLEARING_CHARM_SUCCESS:int = 10;
        static const CLOOK:int = 140;
        static const ERR_INVALID_CHECKSUM:int = 2;
        static const PAYLOADLENGTH_POS:int = 6;
        static const SCONTAINER:int = 110;
        static const SNPCOFFER:int = 122;
        static const CMARKETCANCEL:int = 247;
        static const SWORLDENTERED:int = 15;
        static const CEXCLUDEFROMCHANNEL:int = 172;
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
        public static const MESSAGEDIALOG_IMBUING_STATION_NOT_FOUND:int = 3;
        static const HEADER_POS:int = 0;
        static const SMARKETENTER:int = 246;
        static const SCLIENTCHECK:int = 99;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const SCREATURESPEED:int = 143;
        static const CREQUESTSHOPOFFERS:int = 251;
        static const CANSWERMODALDIALOG:int = 249;
        static const CCLOSEDIMBUINGDIALOG:int = 215;
        static const SSPELLDELAY:int = 164;
        static const CEDITBUDDY:int = 222;
        static const SDELETEONMAP:int = 108;
        static const CEDITGUILDMESSAGE:int = 156;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const CROTATEWEST:int = 114;
        public static const LATENCY_MEDIUM:Number = 500;
        static const SEDITGUILDMESSAGE:int = 174;
        static const SCREATUREOUTFIT:int = 142;
        public static const PROTOCOL_VERSION:int = 1121;
        static const SAMBIENTE:int = 130;
        static const ERR_INVALID_SIZE:int = 1;
        static const SLOGINCHALLENGE:int = 31;
        static const CLEAVECHANNEL:int = 153;
        private static const PING_LATENCY_INTERVAL:uint = 15;
        static const SPLAYERSKILLS:int = 161;
        static const CTHANKYOU:int = 231;
        static const SRESOURCEBALANCE:int = 238;
        static const SCREATUREUNPASS:int = 146;
        static const SSHOWMODALDIALOG:int = 250;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const CGONORTHEAST:int = 106;
        static const RECONNECT_DELAY:int = 3000;
        static const SDELETEINCONTAINER:int = 114;
        public static const RESOURCETYPE_INVENTORY_GOLD:int = 1;
        static const SCREATEINCONTAINER:int = 112;
        static const SCREATUREHEALTH:int = 140;
        static const CERRORFILEENTRY:int = 232;
        static const HEADER_SIZE:int = 6;
        static const STOPROW:int = 101;
        static const SBOTTOMFLOOR:int = 191;
        static const CTURNOBJECT:int = 133;
        static const COPENPREMIUMSHOP:int = 250;
        static const CINSPECTPLAYER:int = 206;
        static const CUSEOBJECT:int = 130;
        static const CLOOKNPCTRADE:int = 121;
        static const CINVITETOCHANNEL:int = 171;
        static const CUSETWOOBJECTS:int = 131;
        static const ERR_INVALID_STATE:int = 4;
        static const SPREMIUMTRIGGER:int = 158;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const CINVITETOPARTY:int = 163;
        static const SCREATURELIGHT:int = 141;
        static const CPINGBACK:int = 30;
        static const SPINGBACK:int = 30;
        static const STUTORIALHINT:int = 220;
        static const SPLAYERGOODS:int = 123;
        static const CSTOP:int = 105;
        static const SPLAYERINVENTORY:int = 245;
        static const SINSPECTIONSTATE:int = 119;
        static const CINSPECTOBJECT:int = 205;
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
        static const SEDITLIST:int = 151;
        static const SCLOSETRADE:int = 127;
        static const SMULTIUSEDELAY:int = 166;
        static const CONNECTION_STATE_GAME:int = 4;
        static const CSTOREEVENT:int = 233;
        static const SSETINVENTORY:int = 120;
        static const CGOPATH:int = 100;
        static const CLEAVEPARTY:int = 167;
        static const SCHANGEONMAP:int = 107;
        static const CGOSOUTHEAST:int = 107;
        static const SINSPECTIONLIST:int = 118;
        private static const PING_RETRY_INTERVAL:uint = 5;
        static const CEQUIPOBJECT:int = 119;
        static const SCREATUREPVPHELPERS:int = 148;
        public static const CLIENT_TYPE:uint = 3;
        static const COPENCHANNEL:int = 170;
        static const SDEAD:int = 40;
        static const SCHANGEINCONTAINER:int = 113;
        static const SIMBUINGDIALOGREFRESH:int = 235;
        public static const MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED:int = 2;
        static const SDELETEINVENTORY:int = 121;
        static const CTRANSFERCURRENCY:int = 239;
        static const SINGAMESHOPERROR:int = 224;
        static const SCHANNELEVENT:int = 243;
        static const SLOGINADVICE:int = 21;
        static const SPVPSITUATIONS:int = 184;
        static const CAPPLYCLEARINGCHARM:int = 214;
        static const CGONORTH:int = 101;
        static const SMARKETDETAIL:int = 248;
        public static const MESSAGEDIALOG_IMBUEMENT_SUCCESS:int = 0;
        static const CTALK:int = 150;
        static const SPREMIUMSHOP:int = 251;
        static const SEQUENCE_NUMBER_POS:int = 2;
        static const STALK:int = 170;
        static const CEDITTEXT:int = 137;
        static const SCLOSENPCTRADE:int = 124;
        static const SPENDINGSTATEENTERED:int = 10;
        public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
        static const SRIGHTROW:int = 102;
        static const SEDITTEXT:int = 150;
        static const SOPENOWNCHANNEL:int = 178;
        static const PAYLOADLENGTH_SIZE:int = 2;
        static const SGRAPHICALEFFECT:int = 131;
        static const CBUGREPORT:int = 230;
        public static const CLIENT_PREVIEW_STATE:uint = 0;
        static const PAYLOADDATA_POSITION:int = 8;
        static const SCLOSEIMBUINGDIALOG:int = 236;
        static const CMARKETLEAVE:int = 244;
        static const SEQUENCE_NUMBER_SIZE:int = 4;
        static const COPENTRANSACTIONHISTORY:int = 253;
        static const CSHAREEXPERIENCE:int = 168;
        static const SCLEARTARGET:int = 163;
        static const SCREATURETYPE:int = 149;
        static const SBUDDYSTATUSCHANGE:int = 211;
        static const CGETOUTFIT:int = 210;
        static const SCLOSECHANNEL:int = 179;
        static const CSETOUTFIT:int = 211;
        static const PACKETLENGTH_POS:int = 0;
        static const SAUTOMAPFLAG:int = 221;
        static const SOWNOFFER:int = 125;
        static const PAYLOAD_POS:int = 6;
        public static const RESOURCETYPE_PREY_BONUS_REROLLS:int = 10;
        static const SSETSTOREDEEPLINK:int = 168;
        static const CMARKETCREATE:int = 246;
        static const SPLAYERSTATE:int = 162;

        public function Connection()
        {
            this.setConnectionState(CONNECTION_STATE_DISCONNECTED, false);
            this.m_Socket = null;
            this.createNewInputBuffer();
            this.m_MessageWriter = new NetworkMessageWriter();
            this.m_RSAPublicKey = new RSAPublicKey();
            this.m_XTEA = new XTEA();
            return;
        }// end function

        public function get latency() : uint
        {
            return this.m_PingLatency;
        }// end function

        private function createNewInputBuffer() : void
        {
            this.m_InputBuffer = new ByteArray();
            this.m_InputBuffer.endian = Endian.LITTLE_ENDIAN;
            this.m_PacketReader = new NetworkPacketReader(this.m_InputBuffer);
            this.m_MessageReader = new NetworkMessageReader(this.m_InputBuffer);
            return;
        }// end function

        public function get isPending() : Boolean
        {
            return this.m_ConnectionState == CONNECTION_STATE_PENDING;
        }// end function

        private function handleSendError(param1:int, param2:Error) : void
        {
            var _loc_3:* = param2 != null ? (param2.errorID) : (-1);
            this.handleConnectionError(512 + param1, _loc_3, param2);
            return;
        }// end function

        public function dispose() : void
        {
            this.m_Communication = null;
            return;
        }// end function

        protected function removeListeners(param1:Socket) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                param1.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
                param1.removeEventListener(Event.CLOSE, this.onSocketClose);
                param1.removeEventListener(Event.CONNECT, this.onSocketConnect);
                param1.removeEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
                param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketError);
                _loc_2 = Tibia.s_GetSecondaryTimer();
                _loc_2.removeEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            }
            return;
        }// end function

        protected function sendCPINGBACK() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_MessageWriter.createMessage();
                b.writeByte(CPINGBACK);
                this.m_MessageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPINGBACK, e);
            }
            return;
        }// end function

        protected function onDelayComplete(event:TimerEvent) : void
        {
            var a_Event:* = event;
            if (a_Event != null)
            {
                try
                {
                    this.m_ConnectionDelay.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayComplete);
                    this.m_ConnectionDelay.stop();
                    this.m_ConnectionDelay = null;
                    this.m_LastEvent = getTimer();
                    this.m_Socket.connect(this.m_Address, this.m_Port);
                }
                catch (e:Error)
                {
                    handleConnectionError(ERR_COULD_NOT_CONNECT, 0, e);
                }
            }
            return;
        }// end function

        private function onMessageWriterFinished() : void
        {
            var _loc_1:* = this.m_MessageWriter.outputPacketBuffer;
            this.m_Socket.writeBytes(_loc_1, 0, _loc_1.length);
            this.m_Socket.flush();
            return;
        }// end function

        protected function onSocketConnect(event:Event) : void
        {
            var _loc_2:* = getTimer();
            this.m_ConnectedSince = getTimer();
            this.m_LastEvent = _loc_2;
            if (this.m_ConnectionState != CONNECTION_STATE_CONNECTING_STAGE1)
            {
                this.handleConnectionError(ERR_INVALID_STATE, 1, event);
            }
            else
            {
                this.sendProxyWorldNameIdentification();
            }
            return;
        }// end function

        public function get connectionState() : uint
        {
            return this.m_ConnectionState;
        }// end function

        private function sendProxyWorldNameIdentification() : void
        {
            var _loc_1:* = null;
            if (this.m_WorldName != null)
            {
                _loc_1 = this.m_WorldName + "\n";
                this.m_Socket.writeUTFBytes(_loc_1);
            }
            return;
        }// end function

        public function get messageWriter() : IMessageWriter
        {
            return this.m_MessageWriter;
        }// end function

        protected function sendCLOGIN(param1:int, param2:int) : void
        {
            var b:ByteArray;
            var PayloadStart:int;
            var a_ChallengeTimeStamp:* = param1;
            var a_ChallengeRandom:* = param2;
            try
            {
                b = this.m_MessageWriter.createMessage();
                b.writeByte(CLOGIN);
                b.writeShort(CLIENT_TYPE);
                b.writeShort(Communication.PROTOCOL_VERSION);
                b.writeUnsignedInt(CLIENT_VERSION);
                b.writeShort(Tibia.s_GetAppearanceStorage().contentRevision);
                b.writeByte(CLIENT_PREVIEW_STATE);
                PayloadStart = b.position;
                b.writeByte(0);
                this.m_XTEA.writeKey(b);
                b.writeByte(0);
                StringHelper.s_WriteToByteArray(b, this.m_SessionKey, Tibia.MAX_SESSION_KEY_LENGTH);
                StringHelper.s_WriteToByteArray(b, this.m_CharacterName, Creature.MAX_NAME_LENGHT);
                b.writeUnsignedInt(a_ChallengeTimeStamp);
                b.writeByte(a_ChallengeRandom);
                this.m_RSAPublicKey.encrypt(b, PayloadStart, RSAPublicKey.BLOCKSIZE);
                this.m_MessageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CLOGIN, e);
            }
            return;
        }// end function

        protected function readSPING(param1:ByteArray) : void
        {
            this.sendCPINGBACK();
            return;
        }// end function

        protected function readSLOGINWAIT(param1:ByteArray) : void
        {
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            var _loc_3:* = param1.readUnsignedByte() * 1000;
            this.disconnect(false);
            var _loc_4:* = new ConnectionEvent(ConnectionEvent.LOGINWAIT);
            _loc_4.message = _loc_2;
            _loc_4.data = _loc_3;
            dispatchEvent(_loc_4);
            return;
        }// end function

        protected function readSLOGINERROR(param1:ByteArray) : void
        {
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            this.disconnect(false);
            var _loc_3:* = new ConnectionEvent(ConnectionEvent.LOGINERROR);
            _loc_3.message = _loc_2;
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function handleConnectionError(param1:int, param2:int = 0, param3:Object = null) : void
        {
            this.disconnect(false);
            var _loc_4:* = null;
            switch(param1)
            {
                case ERR_COULD_NOT_CONNECT:
                {
                    _loc_4 = ResourceManager.getInstance().getString(BUNDLE, "MSG_COULD_NOT_CONNECT");
                    break;
                }
                case ERR_CONNECTION_LOST:
                {
                    _loc_4 = ResourceManager.getInstance().getString(BUNDLE, "MSG_LOST_CONNECTION");
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
            _loc_5.errorType = param1;
            dispatchEvent(_loc_5);
            return;
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
                this.m_PacketReader.xtea = null;
                this.m_MessageWriter.xtea = null;
                if (param2)
                {
                    _loc_3 = new ConnectionEvent(ConnectionEvent.CONNECTING);
                    _loc_3.data = this.m_CharacterName;
                    dispatchEvent(_loc_3);
                }
            }
            else if (this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE2)
            {
                this.m_PacketReader.xtea = this.m_XTEA;
                this.m_MessageWriter.xtea = this.m_XTEA;
            }
            return;
        }// end function

        public function get connectionDuration() : int
        {
            if (this.m_ConnectionState == CONNECTION_STATE_GAME)
            {
                return getTimer() - this.m_ConnectedSince;
            }
            return 0;
        }// end function

        public function disconnect(param1:Boolean = true) : void
        {
            var a_SendEvent:* = param1;
            if (this.m_Socket != null)
            {
                this.removeListeners(this.m_Socket);
                try
                {
                    this.m_Socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketErrorNoErrorHandling);
                    this.m_Socket.close();
                    this.m_Socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onSocketErrorNoErrorHandling);
                }
                catch (_Error)
                {
                }
                this.m_Socket = null;
            }
            if (this.m_InputBuffer != null)
            {
                this.m_InputBuffer.length = 0;
            }
            if (this.m_MessageWriter != null)
            {
                this.m_MessageWriter.registerMessageFinishedCallback(null);
            }
            if (this.m_ConnectionDelay != null)
            {
                this.m_ConnectionDelay.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayComplete);
                this.m_ConnectionDelay.stop();
                this.m_ConnectionDelay = null;
            }
            this.m_SessionKey = null;
            this.m_CharacterName = null;
            this.m_Address = null;
            this.m_Port = int.MAX_VALUE;
            this.m_WorldName = null;
            this.m_PingEarliestTime = 0;
            this.m_PingLatestTime = 0;
            this.m_PingTimeout = 0;
            this.m_PingCount = 0;
            if (this.m_PingTimer != null)
            {
                this.m_PingTimer.removeEventListener(TimerEvent.TIMER, this.onCheckAlive);
                this.m_PingTimer.stop();
                this.m_PingTimer = null;
            }
            this.m_PingSent = 0;
            this.m_PingLatency = 0;
            this.m_CurrentConnectionData = null;
            this.setConnectionState(CONNECTION_STATE_DISCONNECTED, a_SendEvent);
            return;
        }// end function

        protected function addListeners(param1:Socket) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                param1.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
                param1.addEventListener(Event.CLOSE, this.onSocketClose);
                param1.addEventListener(Event.CONNECT, this.onSocketConnect);
                param1.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
                param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketError);
                _loc_2 = Tibia.s_GetSecondaryTimer();
                _loc_2.addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            }
            return;
        }// end function

        public function get connectionData() : IConnectionData
        {
            return this.m_CurrentConnectionData;
        }// end function

        public function get messageReader() : IMessageReader
        {
            return this.m_MessageReader;
        }// end function

        public function set communication(param1:IServerCommunication) : void
        {
            this.m_Communication = param1;
            return;
        }// end function

        protected function sendCPING() : void
        {
            var b:ByteArray;
            try
            {
                b = this.m_MessageWriter.createMessage();
                b.writeByte(CPING);
                this.m_MessageWriter.finishMessage();
            }
            catch (e:Error)
            {
                handleSendError(CPING, e);
            }
            return;
        }// end function

        public function readCommunicationData() : void
        {
            var Type:uint;
            var e:ConnectionEvent;
            if (this.m_PacketReader == null)
            {
                throw new Error("Connection.readSocketData: Packet reader is null.");
            }
            if (this.messageReader == null)
            {
                throw new Error("Connection.readSocketData: Message reader is null.");
            }
            if (this.m_ConnectionState != CONNECTION_STATE_CONNECTING_STAGE1 && this.m_ConnectionState != CONNECTION_STATE_CONNECTING_STAGE2 && this.m_ConnectionState != CONNECTION_STATE_PENDING && this.m_ConnectionState != CONNECTION_STATE_GAME)
            {
                return;
            }
            if (this.m_Socket != null && this.m_Socket.connected && this.m_Socket.bytesAvailable > 0)
            {
                this.m_Socket.readBytes(this.m_InputBuffer, this.m_InputBuffer.length);
            }
            var readNextPacket:Boolean;
            while (readNextPacket)
            {
                
                if (this.m_PacketReader.isPacketReady)
                {
                    if (this.m_PacketReader.isValidPacket == false)
                    {
                        this.handleConnectionError(ERR_INVALID_CHECKSUM, 0, "Connection.readSocketData: Invalid checksum.");
                        return;
                    }
                    this.m_PacketReader.preparePacket();
                    do
                    {
                        
                        Type = this.messageReader.messageType;
                        if (Type != SPING && Type != SPINGBACK)
                        {
                            this.m_PingEarliestTime = Math.min(this.m_PingLatestTime, this.m_PingTimer.currentCount + PING_RETRY_INTERVAL);
                        }
                        else if (Type == SPINGBACK)
                        {
                            var _loc_2:* = this.m_PingTimer.currentCount + PING_LATENCY_INTERVAL;
                            this.m_PingLatestTime = this.m_PingTimer.currentCount + PING_LATENCY_INTERVAL;
                            this.m_PingEarliestTime = _loc_2;
                            this.m_PingTimeout = this.m_PingEarliestTime + PING_RETRY_COUNT * PING_RETRY_INTERVAL;
                            if (this.m_PingCount > 0)
                            {
                                var _loc_2:* = this;
                                var _loc_3:* = this.m_PingCount - 1;
                                _loc_2.m_PingCount = _loc_3;
                            }
                            if (this.m_PingCount == 0)
                            {
                                this.m_PingLatency = getTimer() - this.m_PingSent;
                                if (this.m_ConnectionWasLost)
                                {
                                    this.m_ConnectionWasLost = false;
                                    e = new ConnectionEvent(ConnectionEvent.CONNECTION_RECOVERED);
                                    dispatchEvent(e);
                                }
                            }
                        }
                        try
                        {
                            switch(Type)
                            {
                                case SPING:
                                {
                                    this.readSPING(this.m_InputBuffer);
                                    this.messageReader.finishMessage();
                                    break;
                                }
                                case SPINGBACK:
                                {
                                    this.readSPINGBACK(this.m_InputBuffer);
                                    this.messageReader.finishMessage();
                                    break;
                                }
                                case SLOGINCHALLENGE:
                                {
                                    this.readSLOGINCHALLENGE(this.m_InputBuffer);
                                    this.messageReader.finishMessage();
                                    break;
                                }
                                case SLOGINERROR:
                                {
                                    this.readSLOGINERROR(this.m_InputBuffer);
                                    this.messageReader.finishMessage();
                                    break;
                                }
                                case SLOGINADVICE:
                                {
                                    this.readSLOGINADVICE(this.m_InputBuffer);
                                    this.messageReader.finishMessage();
                                    break;
                                }
                                case SLOGINWAIT:
                                {
                                    this.readSLOGINWAIT(this.m_InputBuffer);
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
                            if (this.isConnected && this.messageReader.messageWasRead == false)
                            {
                                this.handleConnectionError(ERR_INVALID_MESSAGE, 0, "Connection.readSocketData: Invalid message type " + Type + ".");
                            }
                        }
                        catch (_Error:Error)
                        {
                            handleReadError(Type, _Error);
                            return;
                        }
                    }while (this.m_PacketReader.containsUnreadMessage)
                    this.m_PacketReader.finishPacket();
                }
                else
                {
                    readNextPacket;
                }
                if (this.communication != null)
                {
                    this.communication.messageProcessingFinished();
                }
            }
            return;
        }// end function

        private function handleReadError(param1:int, param2:Error) : void
        {
            var _loc_3:* = param2 != null ? (param2.errorID) : (-1);
            this.handleConnectionError(256 + param1, _loc_3, param2);
            return;
        }// end function

        public function get communication() : IServerCommunication
        {
            return this.m_Communication;
        }// end function

        protected function readSLOGINCHALLENGE(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readUnsignedInt();
            var _loc_3:* = param1.readUnsignedByte();
            param1.position = param1.position + param1.bytesAvailable;
            this.sendCLOGIN(_loc_2, _loc_3);
            this.setConnectionState(CONNECTION_STATE_CONNECTING_STAGE2, false);
            var _loc_4:* = new ConnectionEvent(ConnectionEvent.LOGINCHALLENGE);
            dispatchEvent(_loc_4);
            return;
        }// end function

        private function onCheckAlive(event:TimerEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.isGameRunning || this.isPending)
            {
                _loc_2 = this.m_PingTimer.currentCount;
                if (this.m_PingEarliestTime == 0)
                {
                    this.m_PingEarliestTime = _loc_2;
                }
                if (_loc_2 >= this.m_PingEarliestTime && (_loc_2 - this.m_PingEarliestTime) % PING_RETRY_INTERVAL == 0 && uint((_loc_2 - this.m_PingEarliestTime) / PING_RETRY_INTERVAL) < PING_RETRY_COUNT)
                {
                    this.m_PingTimeout = this.m_PingEarliestTime + PING_RETRY_COUNT * PING_RETRY_INTERVAL;
                    var _loc_4:* = this;
                    var _loc_5:* = this.m_PingCount + 1;
                    _loc_4.m_PingCount = _loc_5;
                    this.m_PingSent = getTimer();
                    this.sendCPING();
                }
                if (_loc_2 >= this.m_PingTimeout && !(false || false))
                {
                    if (this.m_ConnectionWasLost == false)
                    {
                        this.m_ConnectionWasLost = true;
                        _loc_3 = new ConnectionEvent(ConnectionEvent.CONNECTION_LOST);
                        dispatchEvent(_loc_3);
                    }
                }
            }
            return;
        }// end function

        protected function readSPINGBACK(param1:ByteArray) : void
        {
            return;
        }// end function

        protected function onSocketClose(event:Event) : void
        {
            this.m_LastEvent = getTimer();
            switch(this.m_ConnectionState)
            {
                case CONNECTION_STATE_DISCONNECTED:
                {
                    break;
                }
                case CONNECTION_STATE_CONNECTING_STAGE1:
                {
                    break;
                }
                case CONNECTION_STATE_CONNECTING_STAGE2:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function readSLOGINADVICE(param1:ByteArray) : void
        {
            var _loc_2:* = StringHelper.s_ReadLongStringFromByteArray(param1);
            var _loc_3:* = new ConnectionEvent(ConnectionEvent.LOGINADVICE);
            _loc_3.message = _loc_2;
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function onSecondaryTimer(event:TimerEvent) : void
        {
            var _loc_2:* = Tibia.s_GetTibiaTimer();
            if (_loc_2 > this.m_SecondaryTimestamp)
            {
                this.readCommunicationData();
            }
            this.m_SecondaryTimestamp = _loc_2;
            return;
        }// end function

        public function connect(param1:IConnectionData) : void
        {
            var _loc_4:* = null;
            if (!(param1 is AccountCharacter))
            {
                throw new Error("Connection.connect: Invalid connection data.", 2147483639);
            }
            var _loc_2:* = param1 as AccountCharacter;
            this.m_CurrentConnectionData = _loc_2;
            if (_loc_2.sessionKey == null || _loc_2.sessionKey.length < 1)
            {
                throw new Error("Connection.connect: Invalid session key.", 2147483638);
            }
            if (_loc_2.name == null || _loc_2.name.length < 1)
            {
                throw new Error("Connection.connect: Invalid character name.", 2147483636);
            }
            if (_loc_2.address == null || _loc_2.address.length < 1)
            {
                throw new Error("Connection.connect: Invalid server address.", 2147483635);
            }
            if (_loc_2.port < 0 || _loc_2.port > 65535)
            {
                throw new Error("Connection.connect: Invalid port number.", 2147483634);
            }
            if (this.m_ConnectionState != CONNECTION_STATE_DISCONNECTED)
            {
                throw new Error("Connection.connect: Invalid state.", 2147483633);
            }
            this.m_XTEA.generateKey();
            if (this.m_Socket != null)
            {
                this.removeListeners(this.m_Socket);
                this.m_Socket = null;
            }
            this.m_Socket = new Socket();
            this.addListeners(this.m_Socket);
            if (this.m_InputBuffer == null)
            {
                this.createNewInputBuffer();
            }
            this.m_InputBuffer.clear();
            this.m_PacketReader.xtea = null;
            this.m_MessageWriter.registerMessageFinishedCallback(this.onMessageWriterFinished);
            if (Security.sandboxType != Security.LOCAL_TRUSTED)
            {
                _loc_4 = "xmlsocket://" + _loc_2.address + ":843";
                Security.loadPolicyFile(_loc_4);
            }
            this.m_SessionKey = _loc_2.sessionKey;
            this.m_CharacterName = _loc_2.name;
            this.m_Address = _loc_2.address;
            this.m_Port = _loc_2.port;
            this.m_WorldName = _loc_2.world;
            this.m_ConnectedSince = 0;
            this.setConnectionState(CONNECTION_STATE_CONNECTING_STAGE1);
            this.m_PingEarliestTime = 0;
            this.m_PingLatestTime = 0;
            this.m_PingTimeout = 0;
            this.m_PingCount = 0;
            this.m_PingTimer = new Timer(1000, 0);
            this.m_PingTimer.addEventListener(TimerEvent.TIMER, this.onCheckAlive);
            this.m_PingTimer.start();
            this.m_PingSent = 0;
            this.m_PingLatency = 0;
            if (this.m_ConnectionDelay != null)
            {
                this.m_ConnectionDelay.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayComplete);
                this.m_ConnectionDelay.stop();
                this.m_ConnectionDelay = null;
            }
            var _loc_3:* = Math.max(0, this.m_LastEvent + RECONNECT_DELAY - getTimer());
            this.m_ConnectionDelay = new Timer(_loc_3, 1);
            this.m_ConnectionDelay.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelayComplete);
            this.m_ConnectionDelay.start();
            return;
        }// end function

        public function get isGameRunning() : Boolean
        {
            return this.m_ConnectionState == CONNECTION_STATE_GAME;
        }// end function

        protected function onSocketErrorNoErrorHandling(event:ErrorEvent) : void
        {
            return;
        }// end function

        protected function onSocketData(event:ProgressEvent) : void
        {
            this.m_LastEvent = getTimer();
            if (this.m_ConnectionState != CONNECTION_STATE_CONNECTING_STAGE1 && this.m_ConnectionState != CONNECTION_STATE_CONNECTING_STAGE2 && this.m_ConnectionState != CONNECTION_STATE_PENDING && this.m_ConnectionState != CONNECTION_STATE_GAME)
            {
                this.handleConnectionError(ERR_INVALID_STATE, 3, event);
            }
            else
            {
                this.readCommunicationData();
            }
            return;
        }// end function

        protected function onSocketError(event:ErrorEvent) : void
        {
            this.m_LastEvent = getTimer();
            switch(this.m_ConnectionState)
            {
                case CONNECTION_STATE_DISCONNECTED:
                {
                    this.handleConnectionError(ERR_INVALID_STATE, 0, event);
                    break;
                }
                case CONNECTION_STATE_CONNECTING_STAGE1:
                {
                    this.handleConnectionError(ERR_COULD_NOT_CONNECT, 0, event);
                    break;
                }
                case CONNECTION_STATE_CONNECTING_STAGE2:
                case CONNECTION_STATE_PENDING:
                case CONNECTION_STATE_GAME:
                {
                    this.handleConnectionError(ERR_CONNECTION_LOST, 0, event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get isConnected() : Boolean
        {
            return this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE1 || this.m_ConnectionState == CONNECTION_STATE_CONNECTING_STAGE2 || this.m_ConnectionState == CONNECTION_STATE_PENDING || this.m_ConnectionState == CONNECTION_STATE_GAME;
        }// end function

    }
}

package tibia.chat
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.events.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.network.*;
    import tibia.options.*;
    import tibia.reporting.reportType.*;

    public class ChatStorage extends EventDispatcher
    {
        protected var m_Channels:IList = null;
        protected var m_OwnPrivateChannelID:int = -1;
        protected var m_ChannelActivationTimeout:Number = 0;
        protected var m_Options:OptionsStorage = null;
        private static const BUNDLE:String = "ChatStorage";
        public static const DEBUG_CHANNEL_ID:int = 131069;
        public static const LOCAL_CHANNEL_LABEL:String = ResourceManager.getInstance().getString(BUNDLE, "LBL_LOCAL_CHANNEL");
        public static const MAX_GUILD_MOTD_LENGTH:int = 255;
        public static const DEBUG_CHANNEL_LABEL:String = ResourceManager.getInstance().getString(BUNDLE, "LBL_DEBUG_CHANNEL");
        private static const CHANNEL_ACTIVATION_TIMEOUT:int = 500;
        public static const LAST_PARTY_CHANNEL_ID:int = 65533;
        public static const LAST_PRIVATE_CHANNEL_ID:int = 9999;
        public static const NPC_CHANNEL_ID:int = 65534;
        public static const FIRST_GUILD_CHANNEL_ID:int = 10000;
        public static const ROOK_ADVERTISING_CHANNEL_ID:int = 6;
        private static const MSG_CHANNEL_NO_ANONYMOUS:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_CHANNEL_NO_ANONYMOUS");
        public static const HELP_CHANNEL_ID:int = 7;
        public static const PRIVATE_CHANNEL_ID:int = 65535;
        private static const MSG_CHANNEL_TO_SELF:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_CHANNEL_TO_SELF");
        public static const MAX_TALK_LENGTH:int = 255;
        public static const MAIN_ADVERTISING_CHANNEL_ID:int = 5;
        public static const FIRST_PRIVATE_CHANNEL_ID:int = 10;
        public static const SESSIONDUMP_CHANNEL_LABEL:String = ResourceManager.getInstance().getString(BUNDLE, "LBL_SESSIONDUMP_CHANNEL");
        private static const MSG_CHANNEL_CLOSED:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_CHANNEL_CLOSED");
        public static const LOCAL_CHANNEL_ID:int = 131071;
        public static const LAST_GUILD_CHANNEL_ID:int = 19999;
        public static const FIRST_PARTY_CHANNEL_ID:int = 20000;
        public static const SERVER_CHANNEL_ID:int = 131070;
        public static const NPC_CHANNEL_LABEL:String = ResourceManager.getInstance().getString(BUNDLE, "LBL_NPC_CHANNEL");
        public static const SESSIONDUMP_CHANNEL_ID:int = 131068;
        public static const SERVER_CHANNEL_LABEL:String = ResourceManager.getInstance().getString(BUNDLE, "LBL_SERVER_CHANNEL");

        public function ChatStorage()
        {
            this.m_Channels = new ArrayCollection();
            this.m_Channels.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onChannelsChange, false, EventPriority.DEFAULT_HANDLER, true);
            this.resetChannelActivationTimeout();
            return;
        }// end function

        public function get ownPrivateChannelID() : int
        {
            return this.m_OwnPrivateChannelID;
        }// end function

        public function getChannelIndex(param1:Object) : int
        {
            var _loc_4:* = null;
            var _loc_2:* = Channel.s_NormaliseIdentifier(param1);
            if (_loc_2 == null)
            {
                return -1;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.m_Channels.length)
            {
                
                _loc_4 = this.m_Channels.getItemAt(_loc_3) as Channel;
                if (_loc_4 != null && _loc_4.ID === _loc_2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function set ownPrivateChannelID(param1:int) : void
        {
            this.m_OwnPrivateChannelID = param1;
            return;
        }// end function

        public function leaveChannel(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = Channel.s_NormaliseIdentifier(param1);
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                if (s_IsPrivateChannel(_loc_2))
                {
                    _loc_4 = this.getChannel(_loc_2);
                    if (_loc_4 == null || _loc_4.sendAllowed)
                    {
                        _loc_3.sendCLEAVECHANNEL(int(_loc_2));
                    }
                }
                else if (_loc_2 === NPC_CHANNEL_ID)
                {
                    _loc_3.sendCCLOSENPCCHANNEL();
                }
                else if (_loc_2 is int)
                {
                    _loc_3.sendCLEAVECHANNEL(int(_loc_2));
                }
            }
            if (_loc_2 === this.m_OwnPrivateChannelID)
            {
                this.m_OwnPrivateChannelID = -1;
            }
            this.removeChannel(_loc_2);
            return;
        }// end function

        public function getChannel(param1:Object) : Channel
        {
            var _loc_4:* = null;
            var _loc_2:* = Channel.s_NormaliseIdentifier(param1);
            if (_loc_2 == null)
            {
                return null;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.m_Channels.length)
            {
                
                _loc_4 = this.m_Channels.getItemAt(_loc_3) as Channel;
                if (_loc_4 != null && _loc_4.ID === _loc_2)
                {
                    return _loc_4;
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function sendChannelMessage(param1:String, param2:Channel, param3:int) : String
        {
            var _loc_4:* = Tibia.s_GetCommunication();
            var _loc_5:* = Tibia.s_GetPlayer();
            if (_loc_4 == null || !_loc_4.isGameRunning || _loc_5 == null)
            {
                return "";
            }
            var _loc_6:* = StringHelper.s_Trim(param1).substr(0, ChatStorage.MAX_TALK_LENGTH);
            if (_loc_6.length < 1)
            {
                return "";
            }
            var _loc_7:* = param3 != MessageMode.MESSAGE_NONE ? (param3) : (param2.sendMode);
            var _loc_8:* = null;
            if (param2.ID !== DEBUG_CHANNEL_ID && param2.ID !== LOCAL_CHANNEL_ID && param2.ID !== SERVER_CHANNEL_ID && param2.sendAllowed)
            {
                _loc_8 = param2.ID;
            }
            var _loc_9:* = null;
            var _loc_10:* = /^#([sywbixc])\s+(.*)/i;
            var _loc_11:* = /^([*@$])([^\1]+?)\1\s*(.*)/;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = _loc_10.exec(_loc_6);
            _loc_12 = _loc_10.exec(_loc_6);
            switch(_loc_13)
            {
                case "b":
                {
                    break;
                }
                case "c":
                {
                    break;
                }
                case "i":
                {
                    break;
                }
                case "s":
                {
                    break;
                }
                case "w":
                {
                    break;
                }
                case "x":
                {
                    break;
                }
                case "y":
                {
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            if (_loc_14 != null)
            {
                switch(_loc_13)
                {
                    case "*":
                    {
                        break;
                    }
                    case "@":
                    {
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            if (_loc_7 == MessageMode.MESSAGE_GAMEMASTER_CHANNEL && (_loc_8 == null || _loc_8 is String || _loc_8 === NPC_CHANNEL_ID))
            {
                Tibia.s_GetWorldMapStorage().addOnscreenMessage(MessageMode.MESSAGE_FAILURE, MSG_CHANNEL_NO_ANONYMOUS);
                return "";
            }
            if (this.hasOwnPrivateChannel)
            {
                if (_loc_13 == "i")
                {
                    _loc_4.sendCINVITETOCHANNEL(_loc_6, this.ownPrivateChannelID);
                }
                else if (_loc_13 == "x")
                {
                    _loc_4.sendCEXCLUDEFROMCHANNEL(_loc_6, this.ownPrivateChannelID);
                }
            }
            switch(_loc_7)
            {
                case MessageMode.MESSAGE_NONE:
                {
                    break;
                }
                case MessageMode.MESSAGE_SAY:
                case MessageMode.MESSAGE_WHISPER:
                case MessageMode.MESSAGE_YELL:
                {
                    _loc_4.sendCTALK(_loc_7, _loc_6);
                    break;
                }
                case MessageMode.MESSAGE_CHANNEL:
                {
                    _loc_4.sendCTALK(_loc_7, int(_loc_8), _loc_6);
                    break;
                }
                case MessageMode.MESSAGE_PRIVATE_TO:
                {
                    this.addChannelMessage(_loc_8, -1, _loc_5.name, _loc_5.level, MessageMode.MESSAGE_PRIVATE_TO, _loc_6);
                    if (_loc_8 !== _loc_5.name.toLowerCase())
                    {
                        _loc_4.sendCTALK(_loc_7, String(_loc_8), _loc_6);
                    }
                    break;
                }
                case MessageMode.MESSAGE_NPC_TO:
                {
                    this.addChannelMessage(_loc_8, -1, _loc_5.name, _loc_5.level, MessageMode.MESSAGE_NPC_TO, _loc_6);
                    _loc_4.sendCTALK(_loc_7, _loc_6);
                    break;
                }
                case MessageMode.MESSAGE_GAMEMASTER_BROADCAST:
                {
                    _loc_4.sendCTALK(_loc_7, _loc_6);
                    break;
                }
                case MessageMode.MESSAGE_GAMEMASTER_CHANNEL:
                {
                    _loc_4.sendCTALK(_loc_7, int(_loc_8), _loc_6);
                    break;
                }
                case MessageMode.MESSAGE_GAMEMASTER_PRIVATE_TO:
                {
                    this.addChannelMessage(_loc_8, -1, _loc_5.name, _loc_5.level, MessageMode.MESSAGE_GAMEMASTER_PRIVATE_TO, _loc_6);
                    if (_loc_8 !== _loc_5.name.toLowerCase())
                    {
                        _loc_4.sendCTALK(_loc_7, String(_loc_8), _loc_6);
                    }
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            if (_loc_8 !== param2.ID && (_loc_7 == MessageMode.MESSAGE_PRIVATE_TO || _loc_7 == MessageMode.MESSAGE_GAMEMASTER_PRIVATE_TO))
            {
                return "*" + _loc_9 + "* ";
            }
            return "";
        }// end function

        public function get channels() : IList
        {
            return this.m_Channels;
        }// end function

        public function addChannelMessage(param1:Object, param2:int, param3:String, param4:int, param5:int, param6:String) : ChannelMessage
        {
            var _loc_10:* = false;
            var _loc_11:* = false;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_14:* = this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET);
            _loc_7 = this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET);
            var _loc_14:* = _loc_7.getMessageMode(param5);
            _loc_8 = _loc_7.getMessageMode(param5);
            var _loc_14:* = this.m_Options.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            _loc_9 = this.m_Options.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            if (this.m_Options != null && _loc_14 != null && _loc_14 != null && _loc_8.showChannelMessage && _loc_14 != null && (_loc_8.ignoreNameFilter || _loc_9.acceptMessage(param5, param3, param6)))
            {
                _loc_10 = param3 != null && (param1 === ChatStorage.HELP_CHANNEL_ID || param4 > 0);
                _loc_11 = param2 > 0;
                _loc_12 = null;
                _loc_13 = new ChannelMessage(param2, param3, param4, param5, param6);
                _loc_13.formatMessage(_loc_7.showTimestamps, _loc_7.showLevels, _loc_8.textARGB, _loc_8.highlightARGB);
                switch(param5)
                {
                    case MessageMode.MESSAGE_SAY:
                    case MessageMode.MESSAGE_WHISPER:
                    case MessageMode.MESSAGE_YELL:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_13.setReportTypeAllowed(Type.REPORT_STATEMENT, _loc_11);
                        _loc_12 = this.getChannel(LOCAL_CHANNEL_ID);
                        break;
                    }
                    case MessageMode.MESSAGE_PRIVATE_FROM:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_13.setReportTypeAllowed(Type.REPORT_STATEMENT, _loc_11);
                        _loc_12 = this.getChannel(param3);
                        if (_loc_12 == null)
                        {
                            _loc_12 = this.getChannel(LOCAL_CHANNEL_ID);
                        }
                        break;
                    }
                    case MessageMode.MESSAGE_PRIVATE_TO:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_13.setReportTypeAllowed(Type.REPORT_STATEMENT, _loc_11);
                        _loc_12 = this.getChannel(param1);
                        if (_loc_12 == null)
                        {
                            _loc_12 = this.getChannel(LOCAL_CHANNEL_ID);
                        }
                        break;
                    }
                    case MessageMode.MESSAGE_CHANNEL_MANAGEMENT:
                    {
                        _loc_12 = this.getChannel(param1);
                        if (_loc_12 == null)
                        {
                            _loc_12 = this.getChannel(SERVER_CHANNEL_ID);
                        }
                        break;
                    }
                    case MessageMode.MESSAGE_CHANNEL:
                    case MessageMode.MESSAGE_CHANNEL_HIGHLIGHT:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_13.setReportTypeAllowed(Type.REPORT_STATEMENT, _loc_11);
                        _loc_12 = this.getChannel(param1);
                        break;
                    }
                    case MessageMode.MESSAGE_SPELL:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_12 = this.getChannel(LOCAL_CHANNEL_ID);
                        break;
                    }
                    case MessageMode.MESSAGE_NPC_FROM_START_BLOCK:
                    case MessageMode.MESSAGE_NPC_FROM:
                    case MessageMode.MESSAGE_NPC_TO:
                    {
                        _loc_12 = this.addChannel(NPC_CHANNEL_ID, NPC_CHANNEL_LABEL, MessageMode.MESSAGE_NPC_TO);
                        break;
                    }
                    case MessageMode.MESSAGE_GAMEMASTER_BROADCAST:
                    {
                        _loc_12 = this.getChannel(SERVER_CHANNEL_ID);
                        break;
                    }
                    case MessageMode.MESSAGE_GAMEMASTER_CHANNEL:
                    {
                        _loc_12 = this.getChannel(param1);
                        break;
                    }
                    case MessageMode.MESSAGE_GAMEMASTER_PRIVATE_FROM:
                    case MessageMode.MESSAGE_GAMEMASTER_PRIVATE_TO:
                    {
                        _loc_12 = this.getChannel(SERVER_CHANNEL_ID);
                        break;
                    }
                    case MessageMode.MESSAGE_LOGIN:
                    case MessageMode.MESSAGE_ADMIN:
                    case MessageMode.MESSAGE_GAME:
                    case MessageMode.MESSAGE_GAME_HIGHLIGHT:
                    case MessageMode.MESSAGE_LOOK:
                    case MessageMode.MESSAGE_DAMAGE_DEALED:
                    case MessageMode.MESSAGE_DAMAGE_RECEIVED:
                    case MessageMode.MESSAGE_HEAL:
                    case MessageMode.MESSAGE_MANA:
                    case MessageMode.MESSAGE_EXP:
                    case MessageMode.MESSAGE_DAMAGE_OTHERS:
                    case MessageMode.MESSAGE_HEAL_OTHERS:
                    case MessageMode.MESSAGE_EXP_OTHERS:
                    case MessageMode.MESSAGE_STATUS:
                    case MessageMode.MESSAGE_LOOT:
                    case MessageMode.MESSAGE_TRADE_NPC:
                    case MessageMode.MESSAGE_REPORT:
                    case MessageMode.MESSAGE_HOTKEY_USE:
                    case MessageMode.MESSAGE_TUTORIAL_HINT:
                    case MessageMode.MESSAGE_THANKYOU:
                    {
                        _loc_12 = this.getChannel(SERVER_CHANNEL_ID);
                        break;
                    }
                    case MessageMode.MESSAGE_GUILD:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_13.setReportTypeAllowed(Type.REPORT_STATEMENT, _loc_11);
                        _loc_12 = this.getChannel(param1);
                        if (_loc_12 == null)
                        {
                        }
                        break;
                    }
                    case MessageMode.MESSAGE_PARTY_MANAGEMENT:
                    case MessageMode.MESSAGE_PARTY:
                    {
                        _loc_13.setReportTypeAllowed(Type.REPORT_NAME, _loc_10);
                        _loc_13.setReportTypeAllowed(Type.REPORT_STATEMENT, _loc_11);
                        _loc_12 = this.getChannel(param1);
                        if (_loc_12 == null)
                        {
                            _loc_12 = this.getChannel(SERVER_CHANNEL_ID);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                if (_loc_12 == null)
                {
                }
                else
                {
                    _loc_12.appendMessage(_loc_13);
                    return _loc_13;
                }
            }
            return null;
        }// end function

        public function loadChannels() : Vector.<int>
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = null;
            var _loc_6:* = this.m_Options.getChannelSet(ChannelSet.DEFAULT_SET);
            _loc_2 = this.m_Options.getChannelSet(ChannelSet.DEFAULT_SET);
            if (this.m_Options != null && _loc_6 != null)
            {
                _loc_3 = 0;
                _loc_4 = _loc_2.length;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_5 = _loc_2.getItemAt(_loc_3);
                    if (s_IsRestorableChannel(_loc_5) && this.getChannel(_loc_5) == null)
                    {
                        _loc_1.push(_loc_5);
                    }
                    _loc_3++;
                }
            }
            return _loc_1;
        }// end function

        public function resetChannelActivationTimeout() : void
        {
            this.m_ChannelActivationTimeout = getTimer() + CHANNEL_ACTIVATION_TIMEOUT;
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function removeChannel(param1:Object) : Channel
        {
            var _loc_3:* = 0;
            var _loc_2:* = this.getChannel(param1);
            if (_loc_2 != null)
            {
                _loc_3 = this.m_Channels.getItemIndex(_loc_2);
                if (_loc_3 > -1)
                {
                    this.m_Channels.removeItemAt(_loc_3);
                }
            }
            if (_loc_2 != null && _loc_2.ID === this.m_OwnPrivateChannelID)
            {
                this.m_OwnPrivateChannelID = -1;
            }
            return _loc_2;
        }// end function

        public function getChannelAt(param1:int) : Channel
        {
            if (param1 >= 0 && param1 < this.m_Channels.length)
            {
                return Channel(this.m_Channels.getItemAt(param1));
            }
            return null;
        }// end function

        public function addChannel(param1:Object, param2:String, param3:int) : Channel
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = this.getChannel(param1);
            switch(param1)
            {
                case HELP_CHANNEL_ID:
                {
                    break;
                }
                case MAIN_ADVERTISING_CHANNEL_ID:
                case ROOK_ADVERTISING_CHANNEL_ID:
                {
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            var _loc_5:* = Tibia.s_GetPlayer();
            if (Tibia.s_GetPlayer() != null && _loc_5.name != null)
            {
                _loc_4.playerJoined(_loc_5.name);
            }
            return _loc_4;
        }// end function

        protected function onChannelsChange(event:CollectionEvent) : void
        {
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = this.m_Channels.length - 1;
            while (_loc_2 >= 0)
            {
                
                Channel(this.m_Channels.removeItemAt(_loc_2)).dispose();
                _loc_2 = _loc_2 - 1;
            }
            _loc_1 = this.getChannel(LOCAL_CHANNEL_ID);
            if (_loc_1 == null)
            {
                _loc_1 = this.addChannel(LOCAL_CHANNEL_ID, LOCAL_CHANNEL_LABEL, MessageMode.MESSAGE_SAY);
                _loc_1.closable = false;
            }
            _loc_1 = this.getChannel(SERVER_CHANNEL_ID);
            if (_loc_1 == null)
            {
                _loc_1 = this.addChannel(SERVER_CHANNEL_ID, SERVER_CHANNEL_LABEL, MessageMode.MESSAGE_SAY);
                _loc_1.closable = false;
            }
            this.m_OwnPrivateChannelID = -1;
            this.resetChannelActivationTimeout();
            return;
        }// end function

        public function get channelActivationTimeout() : Number
        {
            return this.m_ChannelActivationTimeout;
        }// end function

        public function closeChannel(param1:Object) : void
        {
            var _loc_2:* = Channel.s_NormaliseIdentifier(param1);
            this.addChannelMessage(_loc_2, -1, null, 0, MessageMode.MESSAGE_CHANNEL_MANAGEMENT, MSG_CHANNEL_CLOSED);
            var _loc_3:* = this.getChannel(_loc_2);
            if (_loc_3 != null)
            {
                _loc_3.sendAllowed = false;
                _loc_3.closable = true;
                _loc_3.clearNicklist();
            }
            if (this.m_OwnPrivateChannelID === _loc_2)
            {
                this.m_OwnPrivateChannelID = -1;
            }
            return;
        }// end function

        public function saveChannels() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = null;
            var _loc_6:* = this.m_Options.getChannelSet(ChannelSet.DEFAULT_SET);
            _loc_1 = this.m_Options.getChannelSet(ChannelSet.DEFAULT_SET);
            if (this.m_Options != null && _loc_6 != null)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = this.m_Channels.length;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_5 = Channel(this.m_Channels.getItemAt(_loc_3));
                    if (_loc_5.isRestorable)
                    {
                        _loc_1.addItemAt(int(_loc_5.ID), _loc_2++);
                    }
                    _loc_3++;
                }
                _loc_1.length = _loc_2;
            }
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "messageFilterSet":
                    case "textColour":
                    case "highlightColour":
                    case "showTimestamps":
                    case "showLevels":
                    {
                        this.formatChannelMessages();
                        break;
                    }
                    case "channelSet":
                    {
                        this.arrangeChannelSet();
                        break;
                    }
                    case "*":
                    {
                        this.arrangeChannelSet();
                        this.formatChannelMessages();
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

        private function arrangeChannelSet() : void
        {
            return;
        }// end function

        private function formatChannelMessages() : void
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_1:* = null;
            var _loc_10:* = this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET);
            _loc_1 = this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET);
            if (this.m_Options != null && _loc_10 != null)
            {
                _loc_2 = _loc_1.showTimestamps;
                _loc_3 = _loc_1.showLevels;
                _loc_4 = this.m_Channels.length - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_5 = Channel(this.m_Channels.getItemAt(_loc_4)).messages;
                    _loc_6 = _loc_5.length - 1;
                    while (_loc_6 >= 0)
                    {
                        
                        _loc_8 = ChannelMessage(_loc_5.getItemAt(_loc_6));
                        _loc_9 = _loc_1.getMessageMode(_loc_8.mode);
                        _loc_8.formatMessage(_loc_2, _loc_3, _loc_9.textARGB, _loc_9.highlightARGB);
                        _loc_6 = _loc_6 - 1;
                    }
                    _loc_7 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _loc_7.kind = CollectionEventKind.RESET;
                    _loc_5.dispatchEvent(_loc_7);
                    _loc_4 = _loc_4 - 1;
                }
            }
            return;
        }// end function

        public function joinChannel(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_3 = Channel.s_NormaliseIdentifier(param1);
                if (_loc_3 is int && int(_loc_3) >= 0 && int(_loc_3) < NPC_CHANNEL_ID)
                {
                    _loc_2.sendCJOINCHANNEL(int(_loc_3));
                }
                else if (_loc_3 is int && int(_loc_3) == NPC_CHANNEL_ID)
                {
                    this.addChannel(NPC_CHANNEL_ID, NPC_CHANNEL_LABEL, MessageMode.MESSAGE_NPC_TO);
                }
                else if (_loc_3 is int && int(_loc_3) == PRIVATE_CHANNEL_ID)
                {
                    _loc_2.sendCOPENCHANNEL();
                }
                else if (_loc_3 is String)
                {
                    _loc_4 = Tibia.s_GetPlayer();
                    if (_loc_4 == null || _loc_4.name == null)
                    {
                        return;
                    }
                    if (_loc_3 == _loc_4.name.toLowerCase())
                    {
                        Tibia.s_GetWorldMapStorage().addOnscreenMessage(MessageMode.MESSAGE_FAILURE, MSG_CHANNEL_TO_SELF);
                    }
                    else
                    {
                        _loc_2.sendCPRIVATECHANNEL(String(_loc_3));
                    }
                }
            }
            return;
        }// end function

        public function get hasOwnPrivateChannel() : Boolean
        {
            return s_IsPrivateChannel(this.m_OwnPrivateChannelID);
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
            }
            return;
        }// end function

        static function s_IsPartyChannel(param1:Object) : Boolean
        {
            var _loc_2:* = 0;
            if (param1 is int)
            {
                _loc_2 = int(param1);
                return _loc_2 >= FIRST_PARTY_CHANNEL_ID && _loc_2 <= LAST_PARTY_CHANNEL_ID;
            }
            return false;
        }// end function

        static function s_IsPrivateChannel(param1:Object) : Boolean
        {
            if (param1 is int)
            {
                return int(param1) >= FIRST_PRIVATE_CHANNEL_ID && int(param1) <= LAST_PRIVATE_CHANNEL_ID;
            }
            return false;
        }// end function

        static function s_IsRestorableChannel(param1:Object) : Boolean
        {
            if (param1 is int)
            {
                return param1 < FIRST_PRIVATE_CHANNEL_ID;
            }
            return false;
        }// end function

        static function s_IsGuildChannel(param1:Object) : Boolean
        {
            var _loc_2:* = 0;
            if (param1 is int)
            {
                _loc_2 = int(param1);
                return _loc_2 >= FIRST_GUILD_CHANNEL_ID && _loc_2 <= LAST_GUILD_CHANNEL_ID;
            }
            return false;
        }// end function

    }
}

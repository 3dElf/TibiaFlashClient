package tibia.sessiondump.controller
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import loader.asset.*;
    import shared.utility.*;
    import tibia.chat.*;
    import tibia.creatures.*;
    import tibia.help.*;
    import tibia.sessiondump.*;
    import tibia.sessiondump.hints.*;
    import tibia.tutorial.*;

    public class SessiondumpControllerHints extends SessiondumpControllerBase
    {
        private var m_SessiondumpHints:SessiondumpHints = null;
        private var m_MessageStorage:MessageStorage = null;
        private var m_CurrentHint:SessiondumpHintBase = null;
        private var m_OriginalPlayerName:String = null;
        private var m_TutorialProgressServiceAsset:TutorialProgressServiceAsset = null;

        public function SessiondumpControllerHints()
        {
            var _loc_3:* = null;
            var _loc_1:* = Tibia.s_GetAssetProvider();
            var _loc_2:* = _loc_1.getAssetsByClass(SessiondumpHintsAsset);
            if (_loc_2.length == 1)
            {
                _loc_3 = _loc_2[0] as SessiondumpHintsAsset;
                this.m_SessiondumpHints = SessiondumpHints.s_Unmarshall(_loc_3.sessiondumpHintsObject);
            }
            else
            {
                throw new Error("SessiondumpControllerHints.SessiondumpControllerHints: No sessiondump hints asset");
            }
            _loc_2 = _loc_1.getAssetsByClass(TutorialProgressServiceAsset);
            if (_loc_2.length == 1)
            {
                this.m_TutorialProgressServiceAsset = _loc_2[0] as TutorialProgressServiceAsset;
            }
            else
            {
                throw new Error("SessiondumpControllerHints.SessiondumpControllerHints: No tutorial progress service asset");
            }
            this.m_MessageStorage = new MessageStorage();
            return;
        }// end function

        override public function setTargetTimestamp(param1:uint, param2:int = 0) : void
        {
            var _loc_3:* = null;
            if (this.m_SessiondumpHints != null)
            {
                _loc_3 = this.m_SessiondumpHints.getNextSessiondumpHintToProcess((param1 - 1));
                while (_loc_3 != null)
                {
                    
                    _loc_3.cancel();
                    _loc_3 = this.m_SessiondumpHints.getNextSessiondumpHintToProcess(param1);
                }
            }
            super.setTargetTimestamp(param1, param2);
            return;
        }// end function

        public function set sessiondumpHints(param1:SessiondumpHints) : void
        {
            this.m_SessiondumpHints = param1;
            return;
        }// end function

        public function get tutorialProgressServiceAsset() : TutorialProgressServiceAsset
        {
            return this.m_TutorialProgressServiceAsset;
        }// end function

        private function onSessiondumpComplete(event:Event) : void
        {
            m_Sessiondump.disconnect(true);
            return;
        }// end function

        private function onSessiondumpHeaderRead(event:SessiondumpEvent) : void
        {
            m_SessiondumpReader.packetReader.skipClientPackets = false;
            return;
        }// end function

        private function onSessiondumpMessageProcessed(event:SessiondumpEvent) : void
        {
            if (event.messageType == SPLAYERDATABASIC && this.m_SessiondumpHints != null)
            {
                if (this.m_SessiondumpHints.playerName != null)
                {
                    this.m_OriginalPlayerName = Tibia.s_GetPlayer().name;
                    Tibia.s_GetPlayer().name = this.m_SessiondumpHints.playerName;
                }
                if (this.m_SessiondumpHints.playerOutfit != null)
                {
                    Tibia.s_GetPlayer().outfit = this.m_SessiondumpHints.playerOutfit;
                }
            }
            return;
        }// end function

        override public function set playSpeedFactor(param1:Number) : void
        {
            if (param1 > 1)
            {
                if (this.m_CurrentHint != null)
                {
                    if (this.m_CurrentHint.processed == false)
                    {
                        this.m_CurrentHint.cancel();
                    }
                    super.suspendProcessing = false;
                }
            }
            super.playSpeedFactor = param1;
            return;
        }// end function

        private function onSessiondumpPacketReceived(event:SessiondumpEvent) : void
        {
            var _loc_2:* = this.processSessiondumpHints(m_SessiondumpReader.packetReader.packetTimestamp);
            if (_loc_2)
            {
                event.preventDefault();
                this.playSpeedFactor = 1;
            }
            return;
        }// end function

        override public function disconnect() : void
        {
            TransparentHintLayer.getInstance().hide();
            if (m_Sessiondump != null)
            {
                m_Sessiondump.removeEventListener(SessiondumpEvent.PACKET_AVAILABLE, this.onSessiondumpPacketReceived);
                m_Sessiondump.removeEventListener(SessiondumpEvent.MESSAGE_AVAILABLE, this.onSessiondumpMesageAvailable);
                m_Sessiondump.removeEventListener(SessiondumpEvent.MESSAGE_PROCESSED, this.onSessiondumpMessageProcessed);
                m_Sessiondump.removeEventListener(Event.COMPLETE, this.onSessiondumpComplete);
            }
            if (m_SessiondumpReader != null)
            {
                m_SessiondumpReader.removeEventListener(SessiondumpEvent.HEADER_READ, this.onSessiondumpHeaderRead);
            }
            this.unregisterSandboxListeners();
            super.disconnect();
            return;
        }// end function

        public function get sessiondumpHints() : SessiondumpHints
        {
            return this.m_SessiondumpHints;
        }// end function

        private function unregisterSandboxListeners() : void
        {
            var _loc_1:* = Tibia.s_GetInstance().systemManager.getSandboxRoot();
            if (_loc_1 != null)
            {
                _loc_1.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.RIGHT_CLICK, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.MIDDLE_CLICK, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, this.onSandboxMouseFilter, true);
                _loc_1.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onSandboxMouseFilter, true);
            }
            return;
        }// end function

        protected function readSTALK(param1:ByteArray) : void
        {
            var a_Bytes:* = param1;
            var StatementID:* = a_Bytes.readUnsignedInt();
            var Speaker:* = StringHelper.s_ReadLongStringFromByteArray(a_Bytes, Creature.MAX_NAME_LENGHT);
            var SpeakerLevel:* = a_Bytes.readUnsignedShort();
            var Mode:* = a_Bytes.readUnsignedByte();
            if (Speaker == this.m_OriginalPlayerName)
            {
                Speaker = Tibia.s_GetPlayer().name;
            }
            var Pos:Vector3D;
            var ChannelID:Object;
            switch(Mode)
            {
                case MessageMode.MESSAGE_SAY:
                case MessageMode.MESSAGE_WHISPER:
                case MessageMode.MESSAGE_YELL:
                {
                    Pos = Tibia.s_GetCommunication().readCoordinate(a_Bytes);
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
                    Pos = Tibia.s_GetCommunication().readCoordinate(a_Bytes);
                    ChannelID = ChatStorage.LOCAL_CHANNEL_ID;
                    break;
                }
                case MessageMode.MESSAGE_NPC_FROM_START_BLOCK:
                {
                    Pos = Tibia.s_GetCommunication().readCoordinate(a_Bytes);
                    ChannelID = ChatStorage.NPC_CHANNEL_ID;
                    break;
                }
                case MessageMode.MESSAGE_NPC_FROM:
                {
                    ChannelID = ChatStorage.NPC_CHANNEL_ID;
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
                    Pos = Tibia.s_GetCommunication().readCoordinate(a_Bytes);
                    ChannelID;
                    break;
                }
                default:
                {
                    throw new Error("Connection.readSTALK: Invalid message mode " + Mode + ".", 0);
                    break;
                }
            }
            var Text:* = StringHelper.s_ReadLongStringFromByteArray(a_Bytes, ChatStorage.MAX_TALK_LENGTH);
            if (Mode == MessageMode.MESSAGE_NPC_FROM_START_BLOCK)
            {
            }
            else if (Mode == MessageMode.MESSAGE_NPC_FROM)
            {
            }
            return;
        }// end function

        override public function connect(param1:Sessiondump, param2:SessiondumpReader) : void
        {
            super.connect(param1, param2);
            Tibia.s_GetUIEffectsManager().clearEffects();
            TransparentHintLayer.getInstance().show();
            SessiondumpMouseShield.getInstance().reset();
            if (this.m_SessiondumpHints != null)
            {
                this.m_SessiondumpHints.reset();
            }
            this.registerSandboxListeners();
            param1.addEventListener(SessiondumpEvent.PACKET_AVAILABLE, this.onSessiondumpPacketReceived);
            param1.addEventListener(SessiondumpEvent.MESSAGE_AVAILABLE, this.onSessiondumpMesageAvailable);
            param2.addEventListener(SessiondumpEvent.HEADER_READ, this.onSessiondumpHeaderRead);
            param1.addEventListener(SessiondumpEvent.MESSAGE_PROCESSED, this.onSessiondumpMessageProcessed);
            param1.addEventListener(Event.COMPLETE, this.onSessiondumpComplete);
            return;
        }// end function

        private function processSessiondumpHints(param1:uint) : Boolean
        {
            var _loc_2:* = null;
            if (this.m_SessiondumpHints != null)
            {
                _loc_2 = this.m_SessiondumpHints.getNextSessiondumpHintToProcess(param1);
                while (_loc_2 != null)
                {
                    
                    if (_loc_2 != null)
                    {
                        if (_loc_2.timestamp < currentSessiondumpTimestamp)
                        {
                            _loc_2.cancel();
                        }
                        else
                        {
                            _loc_2.perform();
                        }
                        if (_loc_2.processed == false)
                        {
                            if (this.m_CurrentHint == null)
                            {
                                this.m_CurrentHint = _loc_2;
                            }
                            break;
                        }
                        else
                        {
                            this.m_CurrentHint = null;
                        }
                    }
                    _loc_2 = this.m_SessiondumpHints.getNextSessiondumpHintToProcess(param1);
                }
            }
            if (_loc_2 == null)
            {
                this.m_CurrentHint = null;
            }
            return this.m_CurrentHint != null;
        }// end function

        public function continueSessiondump() : void
        {
            SessiondumpMouseShield.getInstance().endFadeAnimation();
            play();
            return;
        }// end function

        protected function onSandboxMouseFilter(event:MouseEvent) : void
        {
            event.preventDefault();
            event.stopImmediatePropagation();
            return;
        }// end function

        private function onSessiondumpMesageAvailable(event:SessiondumpEvent) : void
        {
            if (event.messageType == STALK)
            {
                this.readSTALK(m_Sessiondump.inputStream);
                m_Sessiondump.messageReader.finishMessage();
                event.preventDefault();
                log("onSessiondumpMesageAvailable: STALK");
            }
            return;
        }// end function

        private function registerSandboxListeners() : void
        {
            var _loc_1:* = Tibia.s_GetInstance().systemManager.getSandboxRoot();
            if (_loc_1 != null)
            {
                _loc_1.addEventListener(MouseEvent.DOUBLE_CLICK, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.RIGHT_CLICK, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.MIDDLE_CLICK, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
                _loc_1.addEventListener(MouseEvent.MOUSE_WHEEL, this.onSandboxMouseFilter, true, int.MAX_VALUE, false);
            }
            return;
        }// end function

        override protected function processPackets() : void
        {
            var _loc_1:* = nextSessiondumpPacketTimestamp;
            if (this.processSessiondumpHints(_loc_1) == false)
            {
                suspendProcessing = false;
                super.processPackets();
            }
            else
            {
                suspendProcessing = true;
                synchronizeSessiondumpTimeWithTibiaTime(Tibia.s_GetTibiaTimer());
                this.playSpeedFactor = 1;
            }
            return;
        }// end function

    }
}

package tibia.chat
{
    import __AS3__.vec.*;
    import flash.events.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.worldmap.*;

    public class MessageBlock extends Object
    {
        protected var m_Position:Vector3D = null;
        protected var m_TextPieces:Vector.<String>;
        protected var m_TimerEventRegistered:Boolean = false;
        protected var m_MinTimeForNextOnscreenMessage:uint = 0;
        protected var m_Speaker:String = null;
        protected var m_LastOnscreenBox:OnscreenMessageBox = null;
        protected var m_NextOnscreenMessageIndex:uint = 0;

        public function MessageBlock(param1:String, param2:Vector3D)
        {
            this.m_TextPieces = new Vector.<String>;
            if (param1 == null)
            {
                throw new ArgumentError("MessageBlock: speaker is null.");
            }
            if (param2 == null)
            {
                throw new ArgumentError("MessageBlock: display position is null.");
            }
            this.m_Speaker = param1;
            this.m_Position = param2;
            return;
        }// end function

        public function dispose(param1:Boolean = true) : void
        {
            if (this.m_TimerEventRegistered)
            {
                Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
                this.m_TimerEventRegistered = false;
            }
            if (param1 && this.m_LastOnscreenBox != null)
            {
                this.m_LastOnscreenBox.removeMessages();
                Tibia.s_GetWorldMapStorage().invalidateOnscreenMessages();
            }
            return;
        }// end function

        public function get posititon() : Vector3D
        {
            return this.m_Position;
        }// end function

        protected function showNextOnscreenMessage() : void
        {
            if (this.m_NextOnscreenMessageIndex < this.m_TextPieces.length)
            {
                if (this.isNpcInReach())
                {
                    this.m_LastOnscreenBox = Tibia.s_GetWorldMapStorage().addOnscreenMessage(this.m_Position, 0, this.m_Speaker, 0, MessageMode.MESSAGE_NPC_FROM, this.m_TextPieces[this.m_NextOnscreenMessageIndex]);
                    this.m_MinTimeForNextOnscreenMessage = Tibia.s_GetTibiaTimer() + MessageStorage.s_GetTalkDelay(this.m_TextPieces[this.m_NextOnscreenMessageIndex]);
                    var _loc_1:* = this;
                    var _loc_2:* = this.m_NextOnscreenMessageIndex + 1;
                    _loc_1.m_NextOnscreenMessageIndex = _loc_2;
                }
                else
                {
                    this.m_NextOnscreenMessageIndex = this.m_TextPieces.length;
                }
            }
            return;
        }// end function

        public function addText(param1:String) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("MessageBlock.addText: text is null.");
            }
            this.m_TextPieces.push(param1);
            var _loc_2:* = this.m_NextOnscreenMessageIndex == 0 ? (MessageMode.MESSAGE_NPC_FROM_START_BLOCK) : (MessageMode.MESSAGE_NPC_FROM);
            Tibia.s_GetChatStorage().addChannelMessage(ChatStorage.NPC_CHANNEL_ID, 0, this.m_Speaker, 0, _loc_2, param1);
            if (this.m_NextOnscreenMessageIndex == 0 || this.m_NextOnscreenMessageIndex > 0 && Tibia.s_GetTibiaTimer() > this.m_MinTimeForNextOnscreenMessage)
            {
                this.showNextOnscreenMessage();
            }
            else if (!this.m_TimerEventRegistered)
            {
                Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
                this.m_TimerEventRegistered = true;
            }
            return;
        }// end function

        private function onSecondaryTimer(event:TimerEvent) : void
        {
            if (this.m_NextOnscreenMessageIndex < this.m_TextPieces.length && this.isNpcInReach())
            {
                if (Tibia.s_GetTibiaTimer() > this.m_MinTimeForNextOnscreenMessage)
                {
                    this.showNextOnscreenMessage();
                }
            }
            else
            {
                Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
                this.m_TimerEventRegistered = false;
            }
            return;
        }// end function

        private function isNpcInReach() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = Tibia.s_GetCreatureStorage().getCreatureByName(this.m_Speaker);
            if (_loc_1 != null)
            {
                _loc_2 = Tibia.s_GetPlayer().position;
                _loc_3 = _loc_1.position;
                if (_loc_2.z == _loc_3.z && Math.abs(_loc_2.x - _loc_3.x) <= MessageStorage.MAX_NPC_DISTANCE && Math.abs(_loc_2.y - _loc_3.y) <= MessageStorage.MAX_NPC_DISTANCE)
                {
                    return true;
                }
                return false;
            }
            else
            {
                return false;
            }
        }// end function

        public function get speaker() : String
        {
            return this.m_Speaker;
        }// end function

    }
}

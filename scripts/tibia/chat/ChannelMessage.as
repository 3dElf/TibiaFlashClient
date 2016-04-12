package tibia.chat
{
    import shared.utility.*;
    import shared.utility.i18n.*;
    import tibia.reporting.*;

    public class ChannelMessage extends Object implements IReportable
    {
        protected var m_RawText:String = null;
        protected var m_Speaker:String = null;
        protected var m_AllowedReportTypes:uint = 0;
        protected var m_HTMLText:String = null;
        protected var m_Mode:int;
        protected var m_Timestamp:Number = NaN;
        protected var m_PlainText:String = null;
        protected var m_ID:int = 0;
        protected var m_SpeakerLevel:int = 0;
        private static var s_NextID:int = 0;

        public function ChannelMessage(param1:int, param2:String, param3:int, param4:int, param5:String)
        {
            this.m_Mode = MessageMode.MESSAGE_NONE;
            if (param1 <= 0)
            {
                s_NextID = (s_NextID - 1);
                this.m_ID = s_NextID - 1;
            }
            else
            {
                this.m_ID = param1;
            }
            this.m_Speaker = param2;
            this.m_SpeakerLevel = param3;
            this.m_Mode = param4;
            this.m_RawText = param5;
            var _loc_6:* = new Date();
            this.m_Timestamp = _loc_6.getTime() + _loc_6.getTimezoneOffset();
            return;
        }// end function

        public function get speakerLevel() : int
        {
            return this.m_SpeakerLevel;
        }// end function

        public function setReportTypeAllowed(param1:uint, param2:Boolean = true) : void
        {
            if (param2)
            {
                this.m_AllowedReportTypes = this.m_AllowedReportTypes | 1 << param1;
            }
            else
            {
                this.m_AllowedReportTypes = this.m_AllowedReportTypes & ~(1 << param1);
            }
            return;
        }// end function

        public function formatMessage(param1:Boolean, param2:Boolean, param3:uint, param4:uint) : void
        {
            var _loc_5:* = "";
            if (param1)
            {
                _loc_5 = i18nFormatTime(new Date(this.m_Timestamp));
            }
            if (this.m_Speaker != null)
            {
                _loc_5 = _loc_5 + (" " + this.m_Speaker);
                if (param2 && this.m_SpeakerLevel > 0)
                {
                    _loc_5 = _loc_5 + (" [" + this.m_SpeakerLevel + "]");
                }
            }
            if (_loc_5 != null && _loc_5.length > 0)
            {
                _loc_5 = _loc_5 + ": ";
            }
            var _loc_6:* = StringHelper.s_HTMLSpecialChars(this.m_RawText);
            if (this.m_Mode == MessageMode.MESSAGE_NPC_FROM || this.m_Mode == MessageMode.MESSAGE_NPC_FROM_START_BLOCK)
            {
                _loc_6 = StringHelper.s_HilightToHTML(_loc_6, param4 & 16777215);
            }
            this.m_HTMLText = "<p><font color=\"#" + (param3 & 16777215).toString(16) + "\">" + _loc_5 + _loc_6 + "</font></p>";
            _loc_6 = this.m_RawText;
            if (this.m_Mode == MessageMode.MESSAGE_NPC_FROM || this.m_Mode == MessageMode.MESSAGE_NPC_FROM_START_BLOCK)
            {
                _loc_6 = StringHelper.s_RemoveHilight(_loc_6);
            }
            this.m_PlainText = _loc_5 + _loc_6;
            return;
        }// end function

        public function get plainText() : String
        {
            return this.m_PlainText;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function get mode() : int
        {
            return this.m_Mode;
        }// end function

        public function get characterName() : String
        {
            return this.m_Speaker;
        }// end function

        public function isReportTypeAllowed(param1:uint) : Boolean
        {
            return (this.m_AllowedReportTypes & 1 << param1) != 0;
        }// end function

        public function get htmlText() : String
        {
            return this.m_HTMLText;
        }// end function

        public function get reportableText() : String
        {
            return StringHelper.s_RemoveHilight(this.m_RawText);
        }// end function

        public function get speaker() : String
        {
            return this.m_Speaker;
        }// end function

    }
}

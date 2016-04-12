package tibia.worldmap
{
    import flash.display.*;
    import flash.geom.*;
    import mx.collections.*;
    import shared.utility.*;
    import tibia.chat.*;

    public class OnscreenMessageBox extends Object
    {
        protected var m_Messages:RingBuffer = null;
        protected var m_X:Number = 0;
        protected var m_Visible:Boolean = true;
        protected var m_Speaker:String = null;
        protected var m_Width:Number = 0;
        protected var m_Mode:int = 0;
        protected var m_Y:Number = 0;
        protected var m_Height:Number = 0;
        protected var m_Position:Vector3D = null;
        protected var m_Fixing:int = 0;
        protected var m_VisibleMessages:int = 0;
        protected var m_SpeakerLevel:int = 0;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        public static const FIXING_NONE:int = 0;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const FIELD_CACHESIZE:int = 32;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        public static const FIXING_Y:int = 2;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const PLAYER_OFFSET_X:int = 8;
        public static const FIXING_BOTH:int = FIXING_X | FIXING_Y;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        public static const FIXING_X:int = 1;
        static const MAP_WIDTH:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const GROUND_LAYER:int = 7;

        public function OnscreenMessageBox(param1:Vector3D, param2:String, param3:int, param4:int, param5:int)
        {
            this.m_Position = param1;
            this.m_Speaker = param2;
            this.m_SpeakerLevel = param3;
            this.m_Mode = param4;
            this.m_Messages = new RingBuffer(param5);
            this.m_Visible = true;
            return;
        }// end function

        function set y(param1:Number) : void
        {
            this.m_Y = param1;
            return;
        }// end function

        public function removeMessages() : void
        {
            if (this.m_Messages != null)
            {
                this.m_Messages.removeAll();
            }
            return;
        }// end function

        function get width() : Number
        {
            return this.m_Width;
        }// end function

        public function expireMessages(param1:Number) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            if (this.m_Visible)
            {
                _loc_3 = this.getFirstNonHeaderIndex();
                while (this.m_Messages.length > _loc_3)
                {
                    
                    _loc_4 = OnscreenMessage(this.m_Messages.getItemAt(_loc_3));
                    if (_loc_4.visibleSince + _loc_4.TTL < param1)
                    {
                        this.m_Messages.removeItemAt(_loc_3);
                        _loc_2++;
                        continue;
                    }
                    break;
                }
            }
            return _loc_2;
        }// end function

        function get y() : Number
        {
            return this.m_Y;
        }// end function

        function set x(param1:Number) : void
        {
            this.m_X = param1;
            return;
        }// end function

        public function get messages() : IList
        {
            return this.m_Messages;
        }// end function

        public function get empty() : Boolean
        {
            return this.m_Messages.length - this.getFirstNonHeaderIndex() <= 0;
        }// end function

        public function get speakerLevel() : int
        {
            return this.m_SpeakerLevel;
        }// end function

        function get visibleMessages() : int
        {
            return this.m_Visible ? (this.m_VisibleMessages) : (0);
        }// end function

        function set fixing(param1:int) : void
        {
            this.m_Fixing = param1;
            return;
        }// end function

        function getCacheBitmap(param1:int, param2:Rectangle) : BitmapData
        {
            return OnscreenMessage(this.m_Messages.getItemAt(param1)).getCacheBitmap(param2);
        }// end function

        public function get mode() : int
        {
            return this.m_Mode;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this.m_Visible = param1;
            return;
        }// end function

        public function appendMessage(param1:OnscreenMessage) : void
        {
            if (this.m_Messages.length >= this.m_Messages.size)
            {
                this.m_Messages.removeItemAt(this.getFirstNonHeaderIndex());
            }
            this.m_Messages.addItem(param1);
            return;
        }// end function

        public function get minExpirationTime() : Number
        {
            var _loc_4:* = null;
            var _loc_1:* = Number.POSITIVE_INFINITY;
            var _loc_2:* = this.getFirstNonHeaderIndex();
            var _loc_3:* = this.m_Messages.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = OnscreenMessage(this.m_Messages.getItemAt(_loc_2));
                if (_loc_4.visibleSince < Number.POSITIVE_INFINITY)
                {
                    _loc_1 = Math.min(_loc_4.visibleSince + _loc_4.TTL, _loc_1);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        function get height() : Number
        {
            return this.m_Height;
        }// end function

        public function get position() : Vector3D
        {
            return this.m_Position;
        }// end function

        function get fixing() : int
        {
            return this.m_Fixing;
        }// end function

        public function expireOldestMessage() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            if (this.m_Visible)
            {
                _loc_2 = this.getFirstNonHeaderIndex();
                if (this.m_Messages.length > _loc_2)
                {
                    this.m_Messages.removeItemAt(_loc_2);
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        private function getFirstNonHeaderIndex() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (this.m_Messages.length > _loc_1)
            {
                
                _loc_2 = OnscreenMessage(this.m_Messages.getItemAt(_loc_1));
                if (_loc_2.TTL < Number.POSITIVE_INFINITY)
                {
                    break;
                    continue;
                }
                _loc_1++;
            }
            return _loc_1;
        }// end function

        function get x() : Number
        {
            return this.m_X;
        }// end function

        public function get visible() : Boolean
        {
            return this.m_Visible;
        }// end function

        function arrangeMessages() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.m_VisibleMessages = 0;
            this.m_Width = 0;
            this.m_Height = 0;
            if (this.m_Visible)
            {
                _loc_1 = null;
                _loc_2 = null;
                switch(this.m_Mode)
                {
                    case MessageMode.MESSAGE_SAY:
                    case MessageMode.MESSAGE_WHISPER:
                    case MessageMode.MESSAGE_YELL:
                    case MessageMode.MESSAGE_SPELL:
                    case MessageMode.MESSAGE_NPC_FROM:
                    case MessageMode.MESSAGE_BARK_LOW:
                    case MessageMode.MESSAGE_BARK_LOUD:
                    {
                        while (this.m_VisibleMessages < this.m_Messages.length)
                        {
                            
                            _loc_1 = OnscreenMessage(this.m_Messages.getItemAt(this.m_VisibleMessages));
                            _loc_2 = _loc_1.size;
                            if (this.m_Height + _loc_2.height <= ONSCREEN_MESSAGE_HEIGHT)
                            {
                                var _loc_3:* = this;
                                var _loc_4:* = this.m_VisibleMessages + 1;
                                _loc_3.m_VisibleMessages = _loc_4;
                                this.m_Width = Math.max(this.m_Width, _loc_2.width);
                                this.m_Height = this.m_Height + _loc_2.height;
                                _loc_1.visibleSince = Math.min(Tibia.s_FrameTibiaTimestamp, _loc_1.visibleSince);
                                continue;
                            }
                            break;
                        }
                        break;
                    }
                    default:
                    {
                        if (this.m_Messages.length > 0)
                        {
                            _loc_1 = OnscreenMessage(this.m_Messages.getItemAt(0));
                            _loc_2 = _loc_1.size;
                            this.m_VisibleMessages = 1;
                            this.m_Width = _loc_2.width;
                            this.m_Height = _loc_2.height;
                            _loc_1.visibleSince = Math.min(Tibia.s_FrameTibiaTimestamp, _loc_1.visibleSince);
                        }
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get speaker() : String
        {
            return this.m_Speaker;
        }// end function

    }
}

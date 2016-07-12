package tibia.worldmap
{
    import flash.display.*;
    import flash.geom.*;
    import shared.utility.*;
    import tibia.chat.*;
    import tibia.worldmap.widgetClasses.*;

    public class OnscreenMessage extends Object
    {
        protected var m_TTL:Number = NaN;
        protected var m_Speaker:String = null;
        protected var m_Mode:int = 0;
        protected var m_CacheText:String = null;
        protected var m_Text:String = null;
        protected var m_VisibleSince:Number = NaN;
        protected var m_ID:int = 0;
        protected var m_CacheSize:Rectangle = null;
        protected var m_SpeakerLevel:int = 0;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const FIELD_CACHESIZE:int = 32;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const PLAYER_OFFSET_X:int = 8;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        private static var s_CacheBitmap:BitmapCache = new OnscreenMessageCache(ONSCREEN_MESSAGE_WIDTH, ONSCREEN_MESSAGE_HEIGHT, 8 * NUM_ONSCREEN_MESSAGES);
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        private static var s_NextID:int = 0;
        static const GROUND_LAYER:int = 7;

        public function OnscreenMessage(param1:int, param2:String, param3:int, param4:int, param5:String)
        {
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
            this.m_Text = param5;
            this.m_VisibleSince = Number.POSITIVE_INFINITY;
            this.m_TTL = (30 + this.m_Text.length / 3) * 100;
            return;
        }// end function

        public function get speakerLevel() : int
        {
            return this.m_SpeakerLevel;
        }// end function

        function get size() : Rectangle
        {
            return this.m_CacheSize;
        }// end function

        function get TTL() : Number
        {
            return this.m_TTL;
        }// end function

        public function formatMessage(param1:String, param2:uint, param3:uint) : void
        {
            this.m_CacheText = StringHelper.s_HTMLSpecialChars(this.m_Text);
            if (this.m_Mode == MessageMode.MESSAGE_NPC_FROM)
            {
                this.m_CacheText = StringHelper.s_HilightToHTML(this.m_CacheText, param3);
            }
            if (param1 != null)
            {
                this.m_CacheText = param1 + this.m_CacheText;
            }
            this.m_CacheText = "<p align=\"center\">" + "<font color=\"#" + (param2 & 16777215).toString(16) + "\">" + this.m_CacheText + "</font>" + "</p>";
            this.m_CacheSize = s_CacheBitmap.getItem(this.m_ID, this.m_CacheText);
            return;
        }// end function

        function set visibleSince(param1:Number) : void
        {
            this.m_VisibleSince = param1;
            return;
        }// end function

        function set TTL(param1:Number) : void
        {
            this.m_TTL = param1;
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function get mode() : int
        {
            return this.m_Mode;
        }// end function

        function get visibleSince() : Number
        {
            return this.m_VisibleSince;
        }// end function

        public function get text() : String
        {
            return this.m_Text;
        }// end function

        function getCacheBitmap(param1:Rectangle) : BitmapData
        {
            if (this.m_CacheText != null)
            {
                param1.copyFrom(s_CacheBitmap.getItem(this.m_ID, this.m_CacheText));
                return s_CacheBitmap;
            }
            return null;
        }// end function

        public function get speaker() : String
        {
            return this.m_Speaker;
        }// end function

    }
}

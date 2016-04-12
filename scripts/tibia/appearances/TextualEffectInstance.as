package tibia.appearances
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import shared.utility.*;
    import tibia.appearances.widgetClasses.*;

    public class TextualEffectInstance extends AppearanceInstance
    {
        private const m_TempSpriteInformation:CachedSpriteInformation;
        protected var m_Colour:Colour = null;
        var m_Phase:uint = 0;
        var m_InstanceCache:Boolean = false;
        var m_InstanceBitmap:BitmapData = null;
        protected var m_Text:String = null;
        protected var m_LastPhaseChange:Number = 0;
        var m_InstanceRectangle:Rectangle = null;
        private var m_UncomittedRebuildCache:Boolean = true;
        protected var m_Value:Number = NaN;
        static const PHASE_DURATION:Number = 100;
        static const PHASE_COUNT:int = 10;

        public function TextualEffectInstance(param1:int, param2:AppearanceType, param3:int, param4:Number)
        {
            this.m_TempSpriteInformation = new CachedSpriteInformation();
            super(-1, null);
            this.m_Colour = Colour.s_FromEightBit(param3);
            this.m_Value = param4;
            this.m_Text = null;
            this.m_Phase = 0;
            this.m_LastPhaseChange = Tibia.s_FrameTibiaTimestamp;
            this.m_UncomittedRebuildCache = true;
            return;
        }// end function

        public function get colour() : Colour
        {
            return this.m_Colour;
        }// end function

        override public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : CachedSpriteInformation
        {
            this.rebuildCache();
            if (this.m_InstanceCache)
            {
                this.m_TempSpriteInformation.setCachedSpriteInformationTo(0, this.m_InstanceBitmap, this.m_InstanceRectangle, false);
                return this.m_TempSpriteInformation;
            }
            return null;
        }// end function

        public function get width() : Number
        {
            this.rebuildCache();
            return this.m_InstanceRectangle.width;
        }// end function

        override public function animate(param1:Number, param2:int = 0) : Boolean
        {
            var _loc_3:* = NaN;
            _loc_3 = Math.abs(param1 - this.m_LastPhaseChange);
            var _loc_4:* = int(_loc_3 / PHASE_DURATION);
            this.m_Phase = this.m_Phase + _loc_4;
            this.m_LastPhaseChange = this.m_LastPhaseChange + _loc_4 * PHASE_DURATION;
            return this.m_Phase < PHASE_COUNT;
        }// end function

        override public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            this.rebuildCache();
            if (this.m_InstanceCache)
            {
                s_TempPoint.setTo(param2 - this.m_InstanceRectangle.width, param3 - this.m_InstanceRectangle.height);
                param1.copyPixels(this.m_InstanceBitmap, this.m_InstanceRectangle, s_TempPoint, null, null, true);
            }
            return;
        }// end function

        public function get height() : Number
        {
            this.rebuildCache();
            return this.m_InstanceRectangle.height;
        }// end function

        public function get text() : String
        {
            return this.m_Text;
        }// end function

        public function rebuildCache() : void
        {
            var _loc_1:* = null;
            if (this.m_UncomittedRebuildCache == true)
            {
                this.m_UncomittedRebuildCache = false;
                this.m_Text = this.m_Value.toFixed(0);
                _loc_1 = new TextField();
                _loc_1.autoSize = TextFieldAutoSize.LEFT;
                _loc_1.defaultTextFormat = new TextFormat("Verdana", 11, this.m_Colour.ARGB, true);
                _loc_1.text = this.m_Text;
                _loc_1.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.MEDIUM, false, false)];
                if (this.m_InstanceBitmap != null)
                {
                    this.m_InstanceBitmap.dispose();
                    this.m_InstanceBitmap = null;
                }
                this.m_InstanceRectangle = new Rectangle(0, 0, _loc_1.width, _loc_1.height);
                this.m_InstanceBitmap = new BitmapData(this.m_InstanceRectangle.width, this.m_InstanceRectangle.height, true, 65280);
                this.m_InstanceBitmap.draw(_loc_1);
                this.m_InstanceCache = true;
            }
            return;
        }// end function

        public function get value() : Number
        {
            return this.m_Value;
        }// end function

        public function merge(param1:AppearanceInstance) : Boolean
        {
            var _loc_2:* = param1 as TextualEffectInstance;
            if (_loc_2 != null && _loc_2.m_Phase <= 0 && this.m_Phase <= 0 && _loc_2.m_Colour == this.m_Colour)
            {
                this.m_Value = this.m_Value + _loc_2.m_Value;
                this.m_UncomittedRebuildCache = true;
                return true;
            }
            return false;
        }// end function

        override public function get phase() : int
        {
            return this.m_Phase;
        }// end function

    }
}

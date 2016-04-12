package tibia.worldmap.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;

    public class TileCursor extends Object
    {
        private var m_UncommittedScaleOpacity:Boolean = false;
        private var m_ScaleOpacity:Boolean = false;
        private var m_CachedOpacity:Number = NaN;
        private var m_Opacity:Number = 1;
        protected var m_CachedFrameSize:Rectangle = null;
        protected var m_CachedFrameCount:int = 0;
        private var m_UncommittedBitmapData:Boolean = false;
        private var m_BitmapData:BitmapData = null;
        protected var m_CachedBitmapData:BitmapData = null;
        private var m_FrameDuration:Number = 0;
        private var m_UncommittedOpacity:Boolean = false;
        static const s_TempPoint:Point = new Point(0, 0);
        static const s_TempRect:Rectangle = new Rectangle(0, 0, 0, 0);

        public function TileCursor()
        {
            return;
        }// end function

        public function set bitmapData(param1:BitmapData) : void
        {
            if (this.m_BitmapData != param1)
            {
                this.m_BitmapData = param1;
                this.m_UncommittedOpacity = true;
                this.m_UncommittedBitmapData = true;
            }
            return;
        }// end function

        public function set frameDuration(param1:Number) : void
        {
            this.m_FrameDuration = param1;
            return;
        }// end function

        public function set scaleOpacity(param1:Boolean) : void
        {
            if (this.m_ScaleOpacity != param1)
            {
                this.m_ScaleOpacity = param1;
                this.m_UncommittedOpacity = true;
                this.m_UncommittedScaleOpacity = true;
            }
            return;
        }// end function

        protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.m_UncommittedBitmapData)
            {
                if (this.m_BitmapData != null)
                {
                    if (this.m_BitmapData.width % this.m_BitmapData.height == 0)
                    {
                        this.m_CachedFrameCount = this.m_BitmapData.width / this.m_BitmapData.height;
                        this.m_CachedFrameSize = new Rectangle(0, 0, this.m_BitmapData.height, this.m_BitmapData.height);
                    }
                    else
                    {
                        this.m_CachedFrameCount = 1;
                        this.m_CachedFrameSize = new Rectangle(0, 0, this.m_BitmapData.width, this.m_BitmapData.height);
                    }
                    this.m_CachedOpacity = 0;
                    _loc_1 = new Rectangle(0, 0, this.m_BitmapData.width, this.m_BitmapData.height);
                    _loc_2 = this.m_BitmapData.getVector(_loc_1);
                    for each (_loc_3 in _loc_2)
                    {
                        
                        this.m_CachedOpacity = Math.max(this.m_CachedOpacity, _loc_3 >>> 24);
                    }
                    this.m_CachedOpacity = this.m_CachedOpacity / 255;
                }
                else
                {
                    this.m_CachedFrameCount = 0;
                    this.m_CachedFrameSize = null;
                    this.m_CachedOpacity = NaN;
                }
                this.m_UncommittedBitmapData = false;
            }
            if (this.m_UncommittedOpacity || this.m_UncommittedScaleOpacity)
            {
                if (this.m_BitmapData != null)
                {
                    this.m_CachedBitmapData = this.m_BitmapData.clone();
                    if (this.m_CachedOpacity > 0)
                    {
                        _loc_4 = this.m_ScaleOpacity ? (this.m_Opacity / this.m_CachedOpacity) : (this.m_Opacity);
                        _loc_5 = new ColorTransform(1, 1, 1, _loc_4);
                        _loc_6 = new Rectangle(0, 0, this.m_CachedBitmapData.width, this.m_CachedBitmapData.height);
                        this.m_CachedBitmapData.colorTransform(_loc_6, _loc_5);
                    }
                }
                else
                {
                    this.m_CachedBitmapData = null;
                }
                this.m_UncommittedScaleOpacity = false;
                this.m_UncommittedOpacity = false;
            }
            return;
        }// end function

        public function get opacity() : Number
        {
            return this.m_Opacity;
        }// end function

        protected function getFrameIndex(param1:Number) : int
        {
            if (!isNaN(param1) && !isNaN(this.m_FrameDuration) && this.m_FrameDuration > 0 && this.m_CachedFrameCount > 0)
            {
                return int(param1 / this.m_FrameDuration) % this.m_CachedFrameCount;
            }
            return 0;
        }// end function

        public function drawTo(param1:BitmapData, param2:Number, param3:Number, param4:Number = NaN) : void
        {
            this.commitProperties();
            s_TempRect.setTo(this.getFrameIndex(param4) * this.m_CachedFrameSize.width, 0, this.m_CachedFrameSize.width, this.m_CachedFrameSize.height);
            s_TempPoint.setTo(param2 - this.m_CachedFrameSize.width, param3 - this.m_CachedFrameSize.height);
            param1.copyPixels(this.m_CachedBitmapData, s_TempRect, s_TempPoint, null, null, true);
            return;
        }// end function

        public function get frameDuration() : Number
        {
            return this.m_FrameDuration;
        }// end function

        public function set opacity(param1:Number) : void
        {
            param1 = Math.max(0, Math.min(param1, 1));
            if (this.m_Opacity != param1)
            {
                this.m_Opacity = param1;
                this.m_UncommittedOpacity = true;
            }
            return;
        }// end function

        public function get scaleOpacity() : Boolean
        {
            return this.m_ScaleOpacity;
        }// end function

        public function get bitmapData() : BitmapData
        {
            return this.m_BitmapData;
        }// end function

    }
}

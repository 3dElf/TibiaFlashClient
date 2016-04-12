package tibia.appearances.widgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.core.*;
    import shared.utility.*;
    import tibia.appearances.*;

    public class SimpleAppearanceRenderer extends FlexShape implements IFlexDisplayObject
    {
        private var m_Phase:int = -1;
        private var m_LocalAppearanceBitmapCache:BitmapData = null;
        private var m_HaveTimer:Boolean = false;
        private var m_Overlay:Boolean = true;
        private var m_PatternX:int = -1;
        private var m_PatternY:int = -1;
        private var m_PatternZ:int = -1;
        private var m_Appearance:AppearanceInstance = null;
        private var m_CacheDirty:Boolean = false;
        private var m_Size:int = 32;
        private var m_Smooth:Boolean = false;
        private var m_Scale:Number = NaN;
        private static var s_Rect:Rectangle = new Rectangle();
        private static var s_ZeroPoint:Point = new Point(0, 0);
        public static const ICON_SIZE:int = 32;
        private static var s_TextCache:TextFieldCache = new TextFieldCache(ICON_SIZE, TextFieldCache.DEFAULT_HEIGHT, 100, true);
        private static var s_Trans:Matrix = new Matrix();

        public function SimpleAppearanceRenderer()
        {
            return;
        }// end function

        public function get size() : int
        {
            return this.m_Size;
        }// end function

        public function set size(param1:int) : void
        {
            if (this.m_Size != param1)
            {
                this.m_Size = param1;
                this.draw();
            }
            return;
        }// end function

        public function get scale() : Number
        {
            return this.m_Scale;
        }// end function

        public function get overlay() : Boolean
        {
            return this.m_Overlay;
        }// end function

        public function set smooth(param1:Boolean) : void
        {
            if (this.m_Smooth != param1)
            {
                this.m_Smooth = param1;
                this.draw();
            }
            return;
        }// end function

        public function get appearance() : AppearanceInstance
        {
            return this.m_Appearance;
        }// end function

        public function get cacheDirty() : Boolean
        {
            return this.m_CacheDirty;
        }// end function

        public function draw() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            graphics.clear();
            var _loc_1:* = null;
            var _loc_10:* = this.m_Appearance.type;
            _loc_1 = this.m_Appearance.type;
            if (this.m_Appearance != null && _loc_10 != null)
            {
                _loc_2 = NaN;
                _loc_3 = NaN;
                if (isNaN(this.m_Scale))
                {
                    _loc_2 = this.m_Size / _loc_1.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize;
                    _loc_3 = this.m_Size;
                }
                else
                {
                    _loc_2 = this.m_Scale;
                    _loc_3 = _loc_1.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize * this.m_Scale;
                }
                _loc_4 = this.m_Appearance.getSprite(this.m_Phase, this.m_PatternX, this.m_PatternY, this.m_PatternZ);
                this.cacheDirty = _loc_4.cacheMiss;
                if (this.m_LocalAppearanceBitmapCache == null || this.m_LocalAppearanceBitmapCache.width < _loc_4.rectangle.width || this.m_LocalAppearanceBitmapCache.height < _loc_4.rectangle.height)
                {
                    this.m_LocalAppearanceBitmapCache = new BitmapData(_loc_4.rectangle.width, _loc_4.rectangle.height);
                }
                this.m_LocalAppearanceBitmapCache.copyPixels(_loc_4.bitmapData, _loc_4.rectangle, s_ZeroPoint);
                _loc_5 = this.m_LocalAppearanceBitmapCache;
                s_Rect.setTo(0, 0, _loc_4.rectangle.width, _loc_4.rectangle.height);
                if (_loc_5 != null)
                {
                    _loc_6 = this.m_Appearance is OutfitInstance ? (_loc_1.displacementX) : (0);
                    _loc_7 = this.m_Appearance is OutfitInstance ? (_loc_1.displacementY) : (0);
                    s_Trans.a = _loc_2;
                    s_Trans.d = _loc_2;
                    s_Trans.tx = (-s_Rect.right + _loc_1.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize - _loc_6) * _loc_2;
                    s_Trans.ty = (-s_Rect.bottom + _loc_1.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize - _loc_7) * _loc_2;
                    s_Rect.width = Math.min(_loc_3, s_Rect.width * _loc_2);
                    s_Rect.height = Math.min(_loc_3, s_Rect.height * _loc_2);
                    s_Rect.x = _loc_3 - s_Rect.width - _loc_6 * _loc_2;
                    s_Rect.y = _loc_3 - s_Rect.height - _loc_7 * _loc_2;
                    graphics.beginBitmapFill(_loc_5, s_Trans, true, this.m_Smooth);
                    graphics.drawRect(s_Rect.x, s_Rect.y, s_Rect.width, s_Rect.height);
                }
                if (this.m_Overlay && this.m_Appearance is ObjectInstance && _loc_1.isCumulative)
                {
                    _loc_8 = null;
                    _loc_9 = ObjectInstance(this.m_Appearance).data;
                    var _loc_10:* = s_TextCache.getItem(_loc_9, String(_loc_9), 4294967295);
                    _loc_8 = s_TextCache.getItem(_loc_9, String(_loc_9), 4294967295);
                    if (_loc_10 != null)
                    {
                        s_Rect.x = _loc_3 - _loc_8.width;
                        s_Rect.y = _loc_3 - _loc_8.height;
                        s_Trans.a = 1;
                        s_Trans.d = 1;
                        s_Trans.tx = -_loc_8.x + s_Rect.x;
                        s_Trans.ty = -_loc_8.y + s_Rect.y;
                        graphics.beginBitmapFill(s_TextCache, s_Trans, false, false);
                        graphics.drawRect(s_Rect.x, s_Rect.y, _loc_8.width, _loc_8.height);
                    }
                }
                graphics.endFill();
            }
            return;
        }// end function

        public function get phase() : int
        {
            return this.m_Phase;
        }// end function

        public function set patternX(param1:int) : void
        {
            if (this.m_PatternX != param1)
            {
                this.m_PatternX = param1;
                this.draw();
            }
            return;
        }// end function

        public function set patternY(param1:int) : void
        {
            if (this.m_PatternY != param1)
            {
                this.m_PatternY = param1;
                this.draw();
            }
            return;
        }// end function

        public function set patternZ(param1:int) : void
        {
            if (this.m_PatternZ != param1)
            {
                this.m_PatternZ = param1;
                this.draw();
            }
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            return this.m_Size;
        }// end function

        protected function onTimer(event:TimerEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            var _loc_4:* = this.m_Appearance.type;
            _loc_2 = this.m_Appearance.type;
            if (this.m_Appearance != null && _loc_4 != null && _loc_2.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].isAnimation)
            {
                this.m_Appearance.animate(Tibia.s_FrameTibiaTimestamp);
            }
            else if (this.m_CacheDirty == false)
            {
                _loc_3 = Tibia.s_GetSecondaryTimer();
                _loc_3.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this.m_HaveTimer = false;
            }
            this.draw();
            return;
        }// end function

        public function set overlay(param1:Boolean) : void
        {
            if (this.m_Overlay != param1)
            {
                this.m_Overlay = param1;
                this.draw();
            }
            return;
        }// end function

        public function set scale(param1:Number) : void
        {
            if (this.m_Scale != param1)
            {
                this.m_Scale = param1;
                this.draw();
            }
            return;
        }// end function

        public function get smooth() : Boolean
        {
            return this.m_Smooth;
        }// end function

        public function get measuredWidth() : Number
        {
            return this.m_Size;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            return;
        }// end function

        public function set appearance(param1:AppearanceInstance) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            if (this.m_Appearance != param1)
            {
                this.m_Appearance = param1;
                this.m_Phase = -1;
                this.m_PatternX = -1;
                this.m_PatternY = -1;
                this.m_PatternZ = -1;
                _loc_2 = null;
                var _loc_5:* = this.m_Appearance.type;
                _loc_2 = this.m_Appearance.type;
                _loc_3 = this.m_Appearance != null && _loc_5 != null && _loc_2.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].isAnimation;
                _loc_4 = Tibia.s_GetSecondaryTimer();
                if (_loc_3 && !this.m_HaveTimer)
                {
                    _loc_4.addEventListener(TimerEvent.TIMER, this.onTimer);
                    this.m_HaveTimer = true;
                }
                if (!_loc_3 && this.m_HaveTimer)
                {
                    _loc_4.removeEventListener(TimerEvent.TIMER, this.onTimer);
                    this.m_HaveTimer = false;
                }
                this.draw();
            }
            return;
        }// end function

        public function get patternY() : int
        {
            return this.m_PatternY;
        }// end function

        public function get patternZ() : int
        {
            return this.m_PatternZ;
        }// end function

        public function get patternX() : int
        {
            return this.m_PatternX;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            x = param1;
            y = param2;
            return;
        }// end function

        public function set cacheDirty(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this.m_CacheDirty = param1;
            if (this.m_CacheDirty && this.m_HaveTimer == false)
            {
                _loc_2 = Tibia.s_GetSecondaryTimer();
                _loc_2.addEventListener(TimerEvent.TIMER, this.onTimer);
                this.m_HaveTimer = true;
            }
            return;
        }// end function

        public function set phase(param1:int) : void
        {
            if (this.m_Phase != param1)
            {
                this.m_Phase = param1;
                this.draw();
            }
            return;
        }// end function

    }
}

package tibia.appearances.widgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.core.*;
    import tibia.appearances.*;

    public class SimpleAnimationRenderer extends FlexSprite implements IFlexDisplayObject
    {
        private var m_Animation:AppearanceAnimator;
        private var m_BitmapData:BitmapData;
        private var m_Size:int;
        private var m_HaveTimer:Boolean = false;
        private var m_LocalBitmapCache:BitmapData = null;
        private var m_MoveTarget:DisplayObject;
        private static var s_Rect:Rectangle = new Rectangle();
        private static var s_ZeroPoint:Point = new Point(0, 0);

        public function SimpleAnimationRenderer()
        {
            return;
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

        public function set moveTarget(param1:DisplayObject) : void
        {
            if (param1 != this.m_MoveTarget)
            {
                this.m_MoveTarget = param1;
                this.draw();
            }
            return;
        }// end function

        public function get size() : int
        {
            return this.m_Size;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            x = param1;
            y = param2;
            return;
        }// end function

        public function get measuredWidth() : Number
        {
            return this.m_Size;
        }// end function

        public function get measuredHeight() : Number
        {
            return this.m_Size;
        }// end function

        protected function onTimer(event:TimerEvent) : void
        {
            if (this.m_BitmapData != null && this.m_Animation != null)
            {
                this.m_Animation.animate(Tibia.s_FrameTibiaTimestamp);
            }
            this.draw();
            return;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            return;
        }// end function

        public function draw() : void
        {
            var _loc_1:* = NaN;
            graphics.clear();
            if (this.m_MoveTarget)
            {
                this.move(this.m_MoveTarget.x, this.m_MoveTarget.y);
            }
            if (this.m_BitmapData != null && this.m_Animation != null)
            {
                _loc_1 = this.m_Size;
                s_Rect.width = _loc_1;
                s_Rect.height = _loc_1;
                s_Rect.x = this.m_Animation.phase * _loc_1;
                s_Rect.y = 0;
                this.m_LocalBitmapCache.copyPixels(this.m_BitmapData, s_Rect, s_ZeroPoint);
                graphics.beginBitmapFill(this.m_LocalBitmapCache, null, false, false);
                graphics.drawRect(0, 0, _loc_1, _loc_1);
                graphics.endFill();
            }
            return;
        }// end function

        public function setAnimation(param1:BitmapData, param2:uint, param3:AppearanceAnimator) : void
        {
            this.m_BitmapData = param1;
            this.m_Size = param2;
            this.m_Animation = param3;
            this.m_LocalBitmapCache = new BitmapData(this.m_Size, this.m_Size);
            var _loc_4:* = this.m_BitmapData != null && this.m_Animation != null;
            var _loc_5:* = Tibia.s_GetSecondaryTimer();
            if (_loc_4 && !this.m_HaveTimer)
            {
                _loc_5.addEventListener(TimerEvent.TIMER, this.onTimer);
                this.m_HaveTimer = true;
            }
            if (!_loc_4 && this.m_HaveTimer)
            {
                _loc_5.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this.m_HaveTimer = false;
            }
            this.draw();
            return;
        }// end function

    }
}

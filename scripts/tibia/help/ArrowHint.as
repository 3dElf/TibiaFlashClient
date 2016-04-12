package tibia.help
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import shared.utility.*;

    public class ArrowHint extends UIComponent
    {
        private var m_CurrentArrow:uint = 0;
        private var m_MoveBack:Move = null;
        private var m_ArrowGraphicsRectangle:Rectangle = null;
        private var m_MoveAway:Move = null;
        private var m_Position:Point = null;
        private var m_GlowColor:uint = 1998756351;
        private var m_Sequence:Sequence = null;
        private static const ARROW_OFFSET_Y:int = -75;
        private static const ARROW_HINT:BitmapData = Bitmap(new ARROW_HINT_CLASS()).bitmapData;
        public static const ARROW_RIGHT:uint = 2;
        private static const MOVE_DISTANCE:uint = 30;
        private static const ARROW_OFFSET_X:int = -75;
        public static const ARROW_UP:uint = 1;
        private static var s_TempColor:Colour = new Colour();
        private static const ARROW_HINT_CLASS:Class = ArrowHint_ARROW_HINT_CLASS;
        public static const ARROW_DOWN:uint = 3;
        public static const ARROW_LEFT:uint = 0;
        private static const PHASES:uint = 4;

        public function ArrowHint(param1:Point)
        {
            this.m_Position = param1;
            this.initializeMoveSequence();
            this.m_ArrowGraphicsRectangle = new Rectangle(0, 0, ARROW_HINT.width / PHASES, ARROW_HINT.height);
            cacheAsBitmap = true;
            mouseFocusEnabled = false;
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public function get arrow() : uint
        {
            return this.m_CurrentArrow;
        }// end function

        public function updateArrowPosition(param1:Point) : void
        {
            var _loc_2:* = this.m_Sequence.isPlaying;
            if (this.m_MoveAway.xFrom != param1.x + ARROW_OFFSET_X || this.m_MoveAway.yFrom != param1.y + ARROW_OFFSET_Y)
            {
                if (_loc_2)
                {
                    this.m_Sequence.end();
                }
                this.m_MoveAway.xFrom = param1.x + ARROW_OFFSET_X;
                this.m_MoveAway.yFrom = param1.y + ARROW_OFFSET_Y;
                this.m_MoveAway.xTo = this.m_MoveAway.xFrom + MOVE_DISTANCE;
                this.m_MoveAway.yTo = this.m_MoveAway.yFrom;
                this.m_MoveBack.xFrom = this.m_MoveAway.xTo;
                this.m_MoveBack.yFrom = this.m_MoveAway.yTo;
                this.m_MoveBack.xTo = this.m_MoveAway.xFrom;
                this.m_MoveBack.yTo = this.m_MoveAway.yFrom;
                if (_loc_2)
                {
                    this.m_Sequence.play();
                }
            }
            return;
        }// end function

        public function set arrow(param1:uint) : void
        {
            this.m_CurrentArrow = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get glowColor() : uint
        {
            return this.m_GlowColor;
        }// end function

        public function set repeatCount(param1:uint) : void
        {
            this.m_Sequence.repeatCount = param1;
            return;
        }// end function

        private function initializeMoveSequence() : void
        {
            this.m_Sequence = new Sequence();
            this.m_Sequence.target = this;
            this.m_MoveAway = new Move();
            this.m_MoveAway.duration = 500;
            this.m_Sequence.addChild(this.m_MoveAway);
            var _loc_1:* = new Pause();
            _loc_1.duration = 200;
            this.m_Sequence.addChild(_loc_1);
            this.m_MoveBack = new Move();
            this.m_MoveBack.duration = 500;
            this.m_Sequence.addChild(this.m_MoveBack);
            this.updateArrowPosition(this.m_Position);
            this.m_Sequence.repeatCount = int.MAX_VALUE;
            return;
        }// end function

        public function set glowColor(param1:uint) : void
        {
            this.m_GlowColor = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function hide() : void
        {
            var Me:ArrowHint;
            Me;
            this.m_Sequence.end();
            var FadeEffect:* = new Fade();
            FadeEffect.alphaFrom = this.alpha;
            FadeEffect.alphaTo = 0;
            FadeEffect.duration = 500;
            FadeEffect.play([this]);
            FadeEffect.addEventListener(EffectEvent.EFFECT_END, function (event:Event) : void
            {
                TransparentHintLayer.getInstance().removeChild(Me);
                EventDispatcher(event.target).removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function get repeatCount() : uint
        {
            return this.m_Sequence.repeatCount;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            graphics.clear();
            var _loc_3:* = new Matrix();
            _loc_3.translate(this.m_CurrentArrow * this.m_ArrowGraphicsRectangle.width * -1, 0);
            graphics.beginBitmapFill(ARROW_HINT, _loc_3);
            graphics.drawRect(0, 0, this.m_ArrowGraphicsRectangle.width, this.m_ArrowGraphicsRectangle.height);
            graphics.endFill();
            s_TempColor.ARGB = this.m_GlowColor;
            var _loc_4:* = new GlowFilter();
            _loc_4.color = s_TempColor.RGB;
            _loc_4.alpha = s_TempColor.alphaFloat;
            _loc_4.blurX = 40;
            _loc_4.blurY = 40;
            _loc_4.strength = 5;
            _loc_4.quality = BitmapFilterQuality.HIGH;
            this.filters = [_loc_4];
            return;
        }// end function

        public function show() : void
        {
            this.alpha = 0;
            TransparentHintLayer.getInstance().addChild(this);
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = this.alpha;
            _loc_1.alphaTo = 1;
            _loc_1.duration = 500;
            _loc_1.play([this]);
            this.m_Sequence.play();
            return;
        }// end function

    }
}

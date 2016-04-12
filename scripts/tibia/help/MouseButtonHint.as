package tibia.help
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import shared.utility.*;

    public class MouseButtonHint extends UIComponent
    {
        private var m_HintText:String = null;
        private var m_UITextField:TextField;
        private var m_GlowColor:uint = 3.0031e+009;
        private var m_MouseGraphicsRectangle:Rectangle = null;
        private var m_Sequence:Sequence = null;
        private var m_MouseButtonPhase:uint = 0;
        private static var SEMI_TRANSPARENT_MOUSE_BUTTON_BITMAP:BitmapData = null;
        public static const CROSSHAIR_LEFT_MOUSE_BUTTON:uint = 1;
        private static const MOUSE_CURSOR_OFFSET_X:int = -10;
        public static const DEFAULT_NO_MOUSE_BUTTON:uint = 2;
        public static const DEFAULT_LEFT_MOUSE_BUTTON:uint = 3;
        private static var s_TempColor:Colour = new Colour();
        private static const MOUSE_BUTTON_HINT_CLASS:Class = MouseButtonHint_MOUSE_BUTTON_HINT_CLASS;
        public static const CROSSHAIR_NO_MOUSE_BUTTON:uint = 0;
        private static const MOUSE_BUTTON_HINT:BitmapData = Bitmap(new MOUSE_BUTTON_HINT_CLASS()).bitmapData;
        private static const MOUSE_CURSOR_OFFSET_Y:int = -9;
        private static const PHASES:uint = 4;

        public function MouseButtonHint()
        {
            this.m_UITextField = new TextField();
            this.m_MouseGraphicsRectangle = new Rectangle(0, 0, MOUSE_BUTTON_HINT.width / PHASES, MOUSE_BUTTON_HINT.height);
            if (SEMI_TRANSPARENT_MOUSE_BUTTON_BITMAP == null)
            {
                SEMI_TRANSPARENT_MOUSE_BUTTON_BITMAP = new BitmapData(MOUSE_BUTTON_HINT.width, MOUSE_BUTTON_HINT.height, true, 0);
                SEMI_TRANSPARENT_MOUSE_BUTTON_BITMAP.merge(MOUSE_BUTTON_HINT, MOUSE_BUTTON_HINT.rect, MOUSE_BUTTON_HINT.rect.topLeft, 255, 255, 255, 255 * 0.7);
            }
            cacheAsBitmap = true;
            mouseFocusEnabled = false;
            mouseEnabled = false;
            mouseChildren = false;
            this.m_Sequence = new Sequence();
            this.m_Sequence.target = this;
            return;
        }// end function

        public function get phase() : uint
        {
            return this.m_MouseButtonPhase;
        }// end function

        public function get repeatCount() : uint
        {
            return this.m_Sequence.repeatCount;
        }// end function

        public function show() : void
        {
            TransparentHintLayer.getInstance().addChild(this);
            return;
        }// end function

        public function addFadeIn(param1:Number, param2:uint = 200) : void
        {
            var _loc_3:* = new Fade();
            _loc_3.alphaFrom = 0;
            _loc_3.alphaTo = param1;
            _loc_3.duration = param2;
            this.m_Sequence.addChild(_loc_3);
            return;
        }// end function

        public function addFadeOut(param1:Number, param2:uint = 200) : void
        {
            var _loc_3:* = new Fade();
            _loc_3.alphaFrom = param1;
            _loc_3.alphaTo = 0;
            _loc_3.duration = param2;
            this.m_Sequence.addChild(_loc_3);
            return;
        }// end function

        public function addMove(param1:Point, param2:Point, param3:uint) : void
        {
            var _loc_4:* = new Move();
            _loc_4.xFrom = param1.x + MOUSE_CURSOR_OFFSET_X;
            _loc_4.yFrom = param1.y + MOUSE_CURSOR_OFFSET_Y;
            _loc_4.xTo = param2.x + MOUSE_CURSOR_OFFSET_X;
            _loc_4.yTo = param2.y + MOUSE_CURSOR_OFFSET_Y;
            _loc_4.duration = param3;
            this.m_Sequence.addChild(_loc_4);
            return;
        }// end function

        public function get hintText() : String
        {
            return this.m_HintText;
        }// end function

        public function addPause(param1:uint = 1000) : void
        {
            var _loc_2:* = new Pause();
            _loc_2.duration = param1;
            this.m_Sequence.addChild(_loc_2);
            return;
        }// end function

        public function get glowColor() : uint
        {
            return this.m_GlowColor;
        }// end function

        public function hide() : void
        {
            TransparentHintLayer.getInstance().removeChild(this);
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.m_UITextField.text = "";
            this.m_UITextField.x = 0;
            this.m_UITextField.y = this.m_MouseGraphicsRectangle.height;
            addChild(this.m_UITextField);
            return;
        }// end function

        private function onMouseButtonHintEnd(event:EffectEvent) : void
        {
            var _loc_2:* = null;
            if (event.currentTarget == this.m_Sequence)
            {
                _loc_2 = new Event(Event.COMPLETE);
                dispatchEvent(_loc_2);
            }
            else
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        public function addHintTextChange(param1:String, param2:uint = 0, param3:Boolean = false) : void
        {
            var _loc_7:* = null;
            var _loc_4:* = new Parallel();
            _loc_4.duration = param2;
            var _loc_5:* = null;
            _loc_5 = new SetPropertyAction();
            _loc_5.name = "hintText";
            _loc_5.value = param1;
            if (!param3)
            {
                _loc_4.addChild(_loc_5);
            }
            var _loc_6:* = new Sequence();
            _loc_4.addChild(_loc_6);
            if (param2 > 0)
            {
                if (param3)
                {
                    _loc_7 = new Fade();
                    _loc_7.target = this.m_UITextField;
                    _loc_7.duration = param2;
                    _loc_7.alphaFrom = 1;
                    _loc_7.alphaTo = 0.3;
                    _loc_7.duration = param2 / 2;
                    _loc_6.addChild(_loc_5);
                    _loc_7 = new Fade();
                    _loc_7.target = this.m_UITextField;
                    _loc_7.duration = param2;
                    _loc_7.alphaFrom = 0.3;
                    _loc_7.alphaTo = 1;
                    _loc_7.duration = param2 / 2;
                    _loc_6.addChild(_loc_7);
                }
                else if (param1 != null && param1.length > 0)
                {
                    _loc_7 = new Fade();
                    _loc_7.target = this.m_UITextField;
                    _loc_7.duration = param2;
                    _loc_7.alphaFrom = 0;
                    _loc_7.alphaTo = 1;
                    _loc_6.addChild(_loc_7);
                }
                else
                {
                    _loc_7 = new Fade();
                    _loc_7.target = this.m_UITextField;
                    _loc_7.duration = param2;
                    _loc_7.alphaFrom = 1;
                    _loc_7.alphaTo = 0;
                    _loc_6.addChild(_loc_7);
                }
            }
            this.m_Sequence.addChild(_loc_4);
            return;
        }// end function

        public function addMousePhaseChange(param1:uint) : void
        {
            var _loc_2:* = null;
            _loc_2 = new SetPropertyAction();
            _loc_2.name = "phase";
            _loc_2.value = param1;
            this.m_Sequence.addChild(_loc_2);
            this.m_MouseButtonPhase = param1;
            return;
        }// end function

        public function set hintText(param1:String) : void
        {
            this.m_HintText = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function end() : void
        {
            this.m_Sequence.removeEventListener(EffectEvent.EFFECT_END, this.onMouseButtonHintEnd);
            removeEventListener(EffectEvent.EFFECT_END, this.onMouseButtonHintEnd);
            this.m_Sequence.end();
            return;
        }// end function

        public function updateMoveEffect(param1:Point, param2:Point, param3:uint = 0) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = this.m_Sequence.isPlaying;
            var _loc_5:* = 0;
            for each (_loc_6 in this.m_Sequence.children)
            {
                
                if (_loc_6 is Move && _loc_5 == param3)
                {
                    _loc_7 = _loc_6 as Move;
                    if (_loc_7.xFrom != param1.x + MOUSE_CURSOR_OFFSET_X || _loc_7.yFrom != param1.y + MOUSE_CURSOR_OFFSET_Y || _loc_7.xTo != param2.x + MOUSE_CURSOR_OFFSET_X || _loc_7.yTo != param2.y + MOUSE_CURSOR_OFFSET_Y)
                    {
                        if (_loc_4)
                        {
                            this.m_Sequence.end();
                        }
                        _loc_7.xFrom = param1.x + MOUSE_CURSOR_OFFSET_X;
                        _loc_7.yFrom = param1.y + MOUSE_CURSOR_OFFSET_Y;
                        _loc_7.xTo = param2.x + MOUSE_CURSOR_OFFSET_X;
                        _loc_7.yTo = param2.y + MOUSE_CURSOR_OFFSET_Y;
                        if (_loc_4)
                        {
                            this.m_Sequence.play();
                        }
                    }
                    break;
                    continue;
                }
                if (_loc_6 is Move)
                {
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }// end function

        public function set glowColor(param1:uint) : void
        {
            this.m_GlowColor = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function set repeatCount(param1:uint) : void
        {
            this.m_Sequence.repeatCount = param1;
            return;
        }// end function

        public function play() : void
        {
            this.m_Sequence.addEventListener(EffectEvent.EFFECT_END, this.onMouseButtonHintEnd);
            addEventListener(EffectEvent.EFFECT_END, this.onMouseButtonHintEnd);
            this.m_Sequence.play();
            return;
        }// end function

        public function set phase(param1:uint) : void
        {
            this.m_MouseButtonPhase = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            graphics.clear();
            var _loc_3:* = new Matrix();
            _loc_3.translate(this.m_MouseButtonPhase * this.m_MouseGraphicsRectangle.width * -1, 0);
            graphics.beginBitmapFill(SEMI_TRANSPARENT_MOUSE_BUTTON_BITMAP, _loc_3);
            graphics.drawRect(0, 0, this.m_MouseGraphicsRectangle.width, this.m_MouseGraphicsRectangle.height);
            graphics.endFill();
            s_TempColor.ARGB = this.m_GlowColor;
            var _loc_4:* = new GlowFilter();
            _loc_4.color = s_TempColor.RGB;
            _loc_4.alpha = s_TempColor.alphaFloat;
            _loc_4.blurX = 40;
            _loc_4.blurY = 40;
            _loc_4.strength = 10;
            _loc_4.quality = BitmapFilterQuality.MEDIUM;
            this.filters = [_loc_4];
            this.m_UITextField.text = this.m_HintText == null ? ("") : (this.m_HintText);
            var _loc_5:* = new TextFormat();
            _loc_5.color = 16768894;
            _loc_5.font = "Verdana";
            _loc_5.size = 18;
            _loc_4 = new GlowFilter(0, 0.5, 2, 2, 10);
            _loc_4.quality = BitmapFilterQuality.MEDIUM;
            this.m_UITextField.filters = [_loc_4];
            this.m_UITextField.setTextFormat(_loc_5);
            return;
        }// end function

    }
}

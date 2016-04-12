package tibia.help
{
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import shared.utility.*;

    public class TextHint extends UIComponent
    {
        private var m_HintText:String = null;
        private var m_UITextField:TextField;
        private var m_Position:Point = null;
        private var m_GlowColor:uint = 3.0031e+009;
        private var m_Sequence:Sequence = null;
        private static var s_TempColor:Colour = new Colour();

        public function TextHint(param1:Point)
        {
            this.m_UITextField = new TextField();
            this.m_Position = param1;
            cacheAsBitmap = true;
            mouseFocusEnabled = false;
            mouseEnabled = false;
            mouseChildren = false;
            this.m_Sequence = new Sequence();
            this.m_Sequence.target = this;
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

        private function onTextHintEnd(event:EffectEvent) : void
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

        public function hide() : void
        {
            TransparentHintLayer.getInstance().removeChild(this);
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

        public function updateTextPosition(param1:Point) : void
        {
            this.m_Position = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function end() : void
        {
            this.m_Sequence.removeEventListener(EffectEvent.EFFECT_END, this.onTextHintEnd);
            removeEventListener(EffectEvent.EFFECT_END, this.onTextHintEnd);
            this.m_Sequence.end();
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

        public function set hintText(param1:String) : void
        {
            this.m_HintText = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.m_UITextField.autoSize = TextFieldAutoSize.LEFT;
            this.m_UITextField.mouseEnabled = false;
            addChild(this.m_UITextField);
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
            this.m_Sequence.addEventListener(EffectEvent.EFFECT_END, this.onTextHintEnd);
            addEventListener(EffectEvent.EFFECT_END, this.onTextHintEnd);
            this.m_Sequence.play();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            graphics.clear();
            s_TempColor.ARGB = this.m_GlowColor;
            var _loc_3:* = new GlowFilter();
            _loc_3.color = s_TempColor.RGB;
            _loc_3.alpha = s_TempColor.alphaFloat;
            _loc_3.blurX = 40;
            _loc_3.blurY = 40;
            _loc_3.strength = 10;
            _loc_3.quality = BitmapFilterQuality.MEDIUM;
            this.filters = [_loc_3];
            this.m_UITextField.text = this.m_HintText == null ? ("") : (this.m_HintText);
            var _loc_4:* = new TextFormat();
            _loc_4.color = 16768894;
            _loc_4.font = "Verdana";
            _loc_4.size = 18;
            this.m_UITextField.x = this.m_Position.x;
            this.m_UITextField.y = this.m_Position.y;
            _loc_3 = new GlowFilter(0, 0.5, 2, 2, 10);
            _loc_3.quality = BitmapFilterQuality.MEDIUM;
            this.m_UITextField.filters = [_loc_3];
            this.m_UITextField.setTextFormat(_loc_4);
            return;
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

    }
}

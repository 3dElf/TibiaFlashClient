package tibia.chat.chatWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.styles.*;
    import tibia.input.*;

    public class PassiveTextField extends Label
    {
        private var m_UncommittedCaretIndex:Boolean = false;
        protected var m_CaretVisible:int = 1;
        protected var m_CaretTimer:Timer = null;
        private var m_UncommittedOverwriteMode:Boolean = false;
        protected var m_CaretLayer:FlexSprite = null;
        protected var m_CaretIndex:int = 0;
        protected var m_SelectionOffset:int = 0;
        private var m_UncommittedMaxLength:Boolean = false;
        protected var m_OverwriteMode:Boolean = false;
        protected var m_Border:IFlexDisplayObject = null;
        protected var m_SelectionStart:int = 0;
        private var m_UncommittedEnabled:Boolean = false;
        protected var m_MaxLength:int = -1;
        private var m_UncommittedSelection:Boolean = false;
        static const BLINK_TIMEOUT:int = 500;

        public function PassiveTextField()
        {
            mouseChildren = false;
            focusEnabled = false;
            truncateToFit = false;
            addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseClick);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.m_CaretTimer = new Timer(BLINK_TIMEOUT, 0);
            this.m_CaretTimer.addEventListener(TimerEvent.TIMER, this.onCaretTimer);
            this.m_CaretTimer.start();
            return;
        }// end function

        public function onKeyboardInput(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean) : Boolean
        {
            if (enabled && (param1 == InputEvent.KEY_DOWN || param1 == InputEvent.KEY_REPEAT))
            {
                switch(param3)
                {
                    case Keyboard.BACKSPACE:
                    {
                        if (this.m_SelectionOffset == 0 && this.m_CaretIndex > 0)
                        {
                            this.setSelection((this.m_CaretIndex - 1), this.m_CaretIndex);
                        }
                        this.replaceSelectedText("");
                        break;
                    }
                    case Keyboard.SPACE:
                    {
                        this.replaceSelectedText(" ");
                        break;
                    }
                    case Keyboard.PAGE_UP:
                    case Keyboard.PAGE_DOWN:
                    {
                        break;
                    }
                    case Keyboard.END:
                    {
                        this.caretIndex = text.length;
                        break;
                    }
                    case Keyboard.HOME:
                    {
                        this.caretIndex = 0;
                        break;
                    }
                    case Keyboard.LEFT:
                    {
                        var _loc_7:* = this;
                        var _loc_8:* = this.caretIndex - 1;
                        _loc_7.caretIndex = _loc_8;
                        break;
                    }
                    case Keyboard.UP:
                    {
                        break;
                    }
                    case Keyboard.RIGHT:
                    {
                        var _loc_7:* = this;
                        var _loc_8:* = this.caretIndex + 1;
                        _loc_7.caretIndex = _loc_8;
                        break;
                    }
                    case Keyboard.DOWN:
                    {
                        break;
                    }
                    case Keyboard.INSERT:
                    {
                        this.overwriteMode = !this.overwriteMode;
                        break;
                    }
                    case Keyboard.DELETE:
                    {
                        if (this.m_SelectionOffset == 0 && this.m_CaretIndex < text.length)
                        {
                            this.setSelection(this.m_CaretIndex, (this.m_CaretIndex + 1));
                        }
                        this.replaceSelectedText("");
                        break;
                    }
                    default:
                    {
                        if (param2 != 0)
                        {
                            this.replaceSelectedText(String.fromCharCode(param2));
                        }
                        break;
                        break;
                    }
                }
            }
            return false;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            if (this.m_Border is IBorder)
            {
                return IBorder(this.m_Border).borderMetrics;
            }
            return EdgeMetrics.EMPTY;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (super.enabled != param1)
            {
                super.enabled = param1;
                this.m_UncommittedEnabled = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this.viewMetricsAndPadding;
            _loc_2 = textField.getUITextFormat().measureText("gG");
            var _loc_3:* = _loc_2.width + 4 + _loc_1.left + _loc_1.right;
            measuredWidth = _loc_2.width + 4 + _loc_1.left + _loc_1.right;
            measuredMinWidth = _loc_3;
            var _loc_3:* = _loc_2.height + 4 + _loc_1.top + _loc_1.bottom;
            measuredHeight = _loc_2.height + 4 + _loc_1.top + _loc_1.bottom;
            measuredMinHeight = _loc_3;
            return;
        }// end function

        public function get caretIndex() : int
        {
            return this.m_CaretIndex;
        }// end function

        protected function onMouseMove(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null && event.buttonDown && enabled)
            {
                _loc_2 = this.getCharIndexAtPoint(event.localX, event.localY);
                if (_loc_2 > -1)
                {
                    this.setSelection(this.m_SelectionStart, _loc_2);
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            var _loc_1:* = getStyle("borderSkin");
            if (_loc_1 != null)
            {
                this.m_Border = new _loc_1;
                if (this.m_Border is ISimpleStyleClient)
                {
                    (this.m_Border as ISimpleStyleClient).styleName = this;
                }
                addChildAt(this.m_Border as DisplayObject, 0);
            }
            if (textField != null)
            {
                textField.alwaysShowSelection = true;
            }
            if (this.m_CaretLayer == null)
            {
                this.m_CaretLayer = new FlexSprite();
                addChild(this.m_CaretLayer);
            }
            return;
        }// end function

        public function set overwriteMode(param1:Boolean) : void
        {
            if (this.m_OverwriteMode != param1)
            {
                this.m_OverwriteMode = param1;
                this.m_UncommittedOverwriteMode = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set caretIndex(param1:int) : void
        {
            if (this.m_CaretIndex != param1)
            {
                this.m_CaretIndex = param1;
                this.m_UncommittedCaretIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onMouseClick(event:MouseEvent) : void
        {
            if (event != null && enabled)
            {
                new PassiveTextFieldContextMenu(this).display(this, event.stageX, event.stageY);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            if (this.m_Border != null)
            {
                this.m_Border.move(0, 0);
                this.m_Border.setActualSize(param1, param2);
            }
            var _loc_3:* = this.viewMetricsAndPadding;
            textField.move(_loc_3.left, _loc_3.top);
            textField.setActualSize(param1 - _loc_3.left - _loc_3.right, param2 - _loc_3.top - _loc_3.bottom);
            var _loc_4:* = param1 - _loc_3.left - _loc_3.right;
            var _loc_5:* = new Rectangle(0, 0, 0, 0);
            if (this.m_CaretIndex > 0)
            {
                _loc_5 = textField.getCharBoundaries((this.m_CaretIndex - 1));
            }
            var _loc_6:* = 0;
            if (_loc_5 != null)
            {
                _loc_6 = _loc_5.right - textField.scrollH;
            }
            if (_loc_6 < 0)
            {
                textField.scrollH = _loc_5.right - 1;
                _loc_6 = 0;
            }
            if (_loc_6 > _loc_4)
            {
                textField.scrollH = _loc_5.right - _loc_4 + 1;
                _loc_6 = _loc_4;
            }
            _loc_6 = _loc_6 + _loc_3.left;
            this.m_CaretLayer.x = 0;
            this.m_CaretLayer.y = 0;
            var _loc_7:* = this.m_CaretLayer.graphics;
            _loc_7.clear();
            if (enabled && this.m_CaretVisible > 0)
            {
                _loc_8 = getStyle("color");
                _loc_9 = getStyle("caretWidth");
                if (isNaN(_loc_9) || _loc_9 < 1)
                {
                    _loc_9 = 1;
                }
                _loc_7.lineStyle(_loc_9, _loc_8, 1);
                _loc_7.moveTo(_loc_6, _loc_3.top + 2);
                _loc_7.lineTo(_loc_6, param2 - _loc_3.bottom - 2);
            }
            return;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            var _loc_1:* = this.borderMetrics.clone();
            _loc_1.bottom = _loc_1.bottom + getStyle("paddingBottom");
            _loc_1.left = _loc_1.left + getStyle("paddingLeft");
            _loc_1.right = _loc_1.right + getStyle("paddingRight");
            _loc_1.top = _loc_1.top + getStyle("paddingTop");
            return _loc_1;
        }// end function

        public function replaceSelectedText(param1:String) : void
        {
            var _loc_6:* = 0;
            var _loc_2:* = 0;
            if (this.m_SelectionOffset < 0)
            {
                _loc_2 = this.m_SelectionStart + this.m_SelectionOffset;
            }
            else if (this.m_SelectionOffset > 0)
            {
                _loc_2 = this.m_SelectionStart;
            }
            else
            {
                _loc_2 = this.m_CaretIndex;
            }
            var _loc_3:* = _loc_2 + Math.abs(this.m_SelectionOffset);
            var _loc_4:* = text;
            if (text == null)
            {
                _loc_4 = "";
            }
            if (this.m_MaxLength > 0)
            {
                _loc_6 = _loc_3 - _loc_2;
                param1 = param1.substr(0, this.m_MaxLength - _loc_4.length + _loc_6);
            }
            this.text = _loc_4.substring(0, _loc_2) + param1 + _loc_4.substring(_loc_3, _loc_4.length);
            var _loc_5:* = _loc_2 + param1.length;
            this.setSelection(_loc_5, _loc_5);
            return;
        }// end function

        public function clearSelection() : void
        {
            this.m_SelectionStart = 0;
            this.m_SelectionOffset = 0;
            this.m_UncommittedSelection = true;
            invalidateProperties();
            return;
        }// end function

        protected function onMouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null && enabled)
            {
                _loc_2 = this.getCharIndexAtPoint(event.localX, event.localY);
                if (_loc_2 > -1)
                {
                    this.m_CaretIndex = _loc_2;
                    this.m_UncommittedCaretIndex = true;
                    this.m_SelectionStart = _loc_2;
                    this.m_SelectionOffset = 0;
                    this.m_UncommittedSelection = true;
                    invalidateProperties();
                }
            }
            return;
        }// end function

        public function setSelection(param1:int, param2:int) : void
        {
            this.m_SelectionStart = param1;
            this.m_SelectionOffset = param2 - param1;
            this.m_UncommittedSelection = true;
            this.m_CaretIndex = param2;
            this.m_UncommittedCaretIndex = true;
            invalidateProperties();
            return;
        }// end function

        public function get overwriteMode() : Boolean
        {
            return this.m_OverwriteMode;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedCaretIndex)
            {
                if (this.m_CaretIndex < 0)
                {
                    this.m_CaretIndex = 0;
                }
                if (this.m_CaretIndex > text.length)
                {
                    this.m_CaretIndex = text.length;
                }
                this.m_CaretVisible = 2;
                invalidateDisplayList();
                this.m_UncommittedCaretIndex = false;
            }
            if (this.m_UncommittedSelection)
            {
                if (this.m_SelectionOffset == 0)
                {
                    textField.setSelection(this.m_CaretIndex, this.m_CaretIndex);
                }
                else
                {
                    textField.setSelection(this.m_SelectionStart, this.m_SelectionStart + this.m_SelectionOffset);
                }
                this.m_UncommittedSelection = false;
            }
            if (this.m_UncommittedMaxLength)
            {
                if (text != null && this.m_MaxLength > -1 && this.m_MaxLength < text.length)
                {
                    this.text = text.substr(0, this.m_MaxLength);
                }
                this.m_UncommittedMaxLength = false;
            }
            if (this.m_UncommittedOverwriteMode)
            {
                this.m_UncommittedOverwriteMode = false;
            }
            if (this.m_UncommittedEnabled)
            {
                if (enabled)
                {
                    if (this.m_CaretTimer != null && !this.m_CaretTimer.running)
                    {
                        this.m_CaretTimer.start();
                    }
                }
                else if (this.m_CaretTimer != null && this.m_CaretTimer.running)
                {
                    this.m_CaretTimer.stop();
                }
                this.m_UncommittedEnabled = false;
            }
            return;
        }// end function

        public function set maxLength(param1:int) : void
        {
            if (this.m_MaxLength != param1)
            {
                this.m_MaxLength = param1;
                this.m_UncommittedMaxLength = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get selectionBeginIndex() : int
        {
            return this.m_SelectionStart;
        }// end function

        public function getCharIndexAtPoint(param1:Number, param2:Number) : int
        {
            if (param2 < 0 || param2 > height)
            {
                return -1;
            }
            if (param1 < 0 || param1 > width)
            {
                return -1;
            }
            if (text.length < 1)
            {
                return 0;
            }
            param1 = param1 + textField.scrollH;
            var _loc_3:* = 0;
            var _loc_4:* = text.length - 1;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_5 = (_loc_3 + _loc_4) / 2;
                var _loc_7:* = textField.getCharBoundaries(_loc_5);
                _loc_6 = textField.getCharBoundaries(_loc_5);
                if (_loc_7 == null)
                {
                    return -1;
                }
                if (param1 < _loc_6.x)
                {
                    _loc_4 = _loc_5 - 1;
                    continue;
                }
                if (param1 > _loc_6.right)
                {
                    _loc_3 = _loc_5 + 1;
                    continue;
                }
                return _loc_5;
            }
            return (_loc_5 + 1);
        }// end function

        override public function set text(param1:String) : void
        {
            if (super.text != param1)
            {
                super.text = param1;
                if (param1 != null)
                {
                    this.m_CaretIndex = param1.length;
                }
                else
                {
                    this.m_CaretIndex = 0;
                }
                this.m_UncommittedCaretIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function getSelectedText() : String
        {
            if (this.m_SelectionOffset < 0)
            {
                return text.substr(this.m_SelectionStart + this.m_SelectionOffset, Math.abs(this.m_SelectionOffset));
            }
            if (this.m_SelectionOffset > 0)
            {
                return text.substr(this.m_SelectionStart, this.m_SelectionOffset);
            }
            return "";
        }// end function

        public function get selectionEndIndex() : int
        {
            return this.m_SelectionStart + this.m_SelectionOffset;
        }// end function

        public function get length() : int
        {
            return super.textField.length;
        }// end function

        public function get maxLength() : int
        {
            return this.m_MaxLength;
        }// end function

        public function get viewMetrics() : EdgeMetrics
        {
            return this.borderMetrics.clone();
        }// end function

        protected function onCaretTimer(event:TimerEvent) : void
        {
            if (this.m_CaretVisible > 1)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.m_CaretVisible - 1;
                _loc_2.m_CaretVisible = _loc_3;
            }
            else
            {
                this.m_CaretVisible = (this.m_CaretVisible + 1) % 2;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function onTextInput(param1:uint, param2:String) : Boolean
        {
            if (enabled && param1 == InputEvent.TEXT_INPUT)
            {
                this.replaceSelectedText(param2);
            }
            return false;
        }// end function

    }
}

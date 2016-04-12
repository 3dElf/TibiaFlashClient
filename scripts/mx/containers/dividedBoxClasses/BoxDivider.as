package mx.containers.dividedBoxClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;

    public class BoxDivider extends UIComponent
    {
        private var isMouseOver:Boolean = false;
        private var _state:String = "up";
        private var knob:DisplayObject;
        static const VERSION:String = "3.6.0.21751";

        public function BoxDivider()
        {
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            return;
        }// end function

        function set state(param1:String) : void
        {
            _state = param1;
            invalidateDisplayList();
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            if (!param1 || param1 == "dividerSkin" || param1 == "styleName")
            {
                if (knob)
                {
                    removeChild(knob);
                    knob = null;
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            if (isNaN(width) || isNaN(height))
            {
                return;
            }
            if (!parent)
            {
                return;
            }
            super.updateDisplayList(param1, param2);
            graphics.clear();
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
            var _loc_4:* = 1;
            var _loc_5:* = getStyle("dividerThickness");
            var _loc_6:* = DividedBox(owner).isVertical() ? (DividedBox(owner).getStyle("verticalGap")) : (DividedBox(owner).getStyle("horizontalGap"));
            if (state != DividerState.DOWN)
            {
                if (_loc_6 >= 6)
                {
                    if (!knob)
                    {
                        _loc_7 = Class(getStyle("dividerSkin"));
                        if (_loc_7)
                        {
                            knob = new _loc_7;
                        }
                        if (knob)
                        {
                            addChild(knob);
                        }
                    }
                    if (knob)
                    {
                        if (DividedBox(owner).isVertical())
                        {
                            knob.scaleX = 1;
                            knob.rotation = 0;
                        }
                        else
                        {
                            knob.scaleX = -1;
                            knob.rotation = -90;
                        }
                        knob.x = Math.round((width - knob.width) / 2);
                        knob.y = Math.round((height - knob.height) / 2);
                    }
                }
                return;
            }
            _loc_3 = getStyle("dividerColor");
            _loc_4 = getStyle("dividerAlpha");
            graphics.beginFill(_loc_3, _loc_4);
            if (DividedBox(owner).isVertical())
            {
                _loc_8 = _loc_5;
                if (_loc_8 > _loc_6)
                {
                    _loc_8 = _loc_6;
                }
                _loc_9 = (height - _loc_8) / 2;
                graphics.drawRect(0, _loc_9, width, _loc_8);
            }
            else
            {
                _loc_10 = _loc_5;
                if (_loc_10 > _loc_6)
                {
                    _loc_10 = _loc_6;
                }
                _loc_11 = (width - _loc_10) / 2;
                graphics.drawRect(_loc_11, 0, _loc_10, height);
            }
            graphics.endFill();
            return;
        }// end function

        private function mouseOutHandler(event:MouseEvent) : void
        {
            isMouseOver = false;
            if (!DividedBox(owner).activeDivider)
            {
                state = DividerState.UP;
                if (parent)
                {
                    DividedBox(owner).restoreCursor();
                }
            }
            return;
        }// end function

        private function mouseUpHandler(event:Event) : void
        {
            if (!isMouseOver)
            {
                DividedBox(owner).restoreCursor();
            }
            state = DividerState.OVER;
            DividedBox(owner).stopDividerDrag(this, event as MouseEvent);
            var _loc_2:* = systemManager.getSandboxRoot();
            _loc_2.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler);
            return;
        }// end function

        override public function set x(param1:Number) : void
        {
            var _loc_2:* = x;
            super.x = param1;
            if (!DividedBox(owner).isVertical())
            {
                DividedBox(owner).moveDivider(DividedBox(owner).getDividerIndex(this), param1 - _loc_2);
            }
            return;
        }// end function

        function get state() : String
        {
            return _state;
        }// end function

        private function mouseOverHandler(event:MouseEvent) : void
        {
            if (event.buttonDown)
            {
                return;
            }
            isMouseOver = true;
            if (!DividedBox(owner).activeDivider)
            {
                state = DividerState.OVER;
                DividedBox(owner).changeCursor(this);
            }
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            var _loc_2:* = y;
            super.y = param1;
            if (DividedBox(owner).isVertical())
            {
                DividedBox(owner).moveDivider(DividedBox(owner).getDividerIndex(this), param1 - _loc_2);
            }
            return;
        }// end function

        private function mouseDownHandler(event:MouseEvent) : void
        {
            DividedBox(owner).changeCursor(this);
            DividedBox(owner).startDividerDrag(this, event);
            var _loc_2:* = systemManager.getSandboxRoot();
            _loc_2.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler);
            return;
        }// end function

    }
}

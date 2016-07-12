package tibia.controls
{
    import __AS3__.vec.*;
    import flash.display.*;
    import mx.core.*;
    import mx.events.*;

    public class GridContainer extends UIComponent
    {
        protected var m_Child:Vector.<IUIComponent> = null;
        static const CHILD_RIGHT:int = 3;
        static const CHILD_TOP:int = 0;
        static const CHILD_CENTER:int = 4;
        static const CHILD_LEFT:int = 2;
        static const CHILD_BOTTOM:int = 1;

        public function GridContainer()
        {
            this.m_Child = new Vector.<IUIComponent>(5, true);
            return;
        }// end function

        public function set center(param1:IUIComponent) : void
        {
            var _loc_2:* = this.center;
            if (_loc_2 !== param1)
            {
                this._1364013995center = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "center", _loc_2, param1));
            }
            return;
        }// end function

        public function get top() : IUIComponent
        {
            return this.m_Child[CHILD_TOP];
        }// end function

        public function set bottom(param1:IUIComponent) : void
        {
            var _loc_2:* = this.bottom;
            if (_loc_2 !== param1)
            {
                this._1383228885bottom = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bottom", _loc_2, param1));
            }
            return;
        }// end function

        private function getExplicitOrMeasuredMinHeight(param1:IUIComponent) : Number
        {
            var _loc_2:* = 0;
            if (param1 != null)
            {
                _loc_2 = param1.explicitMinHeight;
                if (isNaN(_loc_2))
                {
                    _loc_2 = param1.measuredMinHeight;
                }
                if (isNaN(_loc_2))
                {
                    _loc_2 = 0;
                }
            }
            return _loc_2;
        }// end function

        public function get left() : IUIComponent
        {
            return this.m_Child[CHILD_LEFT];
        }// end function

        private function set _1383228885bottom(param1:IUIComponent) : void
        {
            this.setChild(CHILD_BOTTOM, param1);
            return;
        }// end function

        private function set _108511772right(param1:IUIComponent) : void
        {
            this.setChild(CHILD_RIGHT, param1);
            return;
        }// end function

        public function get bottom() : IUIComponent
        {
            return this.m_Child[CHILD_BOTTOM];
        }// end function

        private function set _1364013995center(param1:IUIComponent) : void
        {
            this.setChild(CHILD_CENTER, param1);
            return;
        }// end function

        private function set _115029top(param1:IUIComponent) : void
        {
            this.setChild(CHILD_TOP, param1);
            return;
        }// end function

        public function get center() : IUIComponent
        {
            return this.m_Child[CHILD_CENTER];
        }// end function

        private function getExplicitOrMeasuredMinWidth(param1:IUIComponent) : Number
        {
            var _loc_2:* = 0;
            if (param1 != null)
            {
                _loc_2 = param1.explicitMinWidth;
                if (isNaN(_loc_2))
                {
                    _loc_2 = param1.measuredMinWidth;
                }
                if (isNaN(_loc_2))
                {
                    _loc_2 = 0;
                }
            }
            return _loc_2;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = param1;
            var _loc_8:* = param2;
            if (this.m_Child[CHILD_TOP] != null && this.m_Child[CHILD_TOP].includeInLayout)
            {
                _loc_4 = Math.min(param2, this.m_Child[CHILD_TOP].getExplicitOrMeasuredHeight());
                _loc_6 = _loc_4;
                _loc_8 = _loc_8 - _loc_4;
                this.m_Child[CHILD_TOP].setActualSize(param1, _loc_4);
                this.m_Child[CHILD_TOP].move(0, 0);
            }
            if (this.m_Child[CHILD_BOTTOM] != null && this.m_Child[CHILD_BOTTOM].includeInLayout)
            {
                _loc_4 = Math.min(param2, this.m_Child[CHILD_BOTTOM].getExplicitOrMeasuredHeight());
                _loc_8 = _loc_8 - _loc_4;
                this.m_Child[CHILD_BOTTOM].setActualSize(param1, _loc_4);
                this.m_Child[CHILD_BOTTOM].move(0, param2 - _loc_4);
            }
            if (this.m_Child[CHILD_LEFT] != null && this.m_Child[CHILD_LEFT].includeInLayout)
            {
                _loc_3 = Math.min(param1, this.m_Child[CHILD_LEFT].getExplicitOrMeasuredWidth());
                _loc_5 = _loc_3;
                _loc_7 = _loc_7 - _loc_3;
                this.m_Child[CHILD_LEFT].setActualSize(_loc_3, _loc_8);
                this.m_Child[CHILD_LEFT].move(0, _loc_6);
            }
            if (this.m_Child[CHILD_RIGHT] != null && this.m_Child[CHILD_RIGHT].includeInLayout)
            {
                _loc_3 = Math.min(param1, this.m_Child[CHILD_RIGHT].getExplicitOrMeasuredWidth());
                _loc_7 = _loc_7 - _loc_3;
                this.m_Child[CHILD_RIGHT].setActualSize(_loc_3, _loc_8);
                this.m_Child[CHILD_RIGHT].move(param1 - _loc_3, _loc_6);
            }
            if (this.m_Child[CHILD_CENTER] != null && this.m_Child[CHILD_CENTER].includeInLayout)
            {
                this.m_Child[CHILD_CENTER].setActualSize(_loc_7, _loc_8);
                this.m_Child[CHILD_CENTER].move(_loc_5, _loc_6);
            }
            return;
        }// end function

        public function set right(param1:IUIComponent) : void
        {
            var _loc_2:* = this.right;
            if (_loc_2 !== param1)
            {
                this._108511772right = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "right", _loc_2, param1));
            }
            return;
        }// end function

        public function set top(param1:IUIComponent) : void
        {
            var _loc_2:* = this.top;
            if (_loc_2 !== param1)
            {
                this._115029top = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "top", _loc_2, param1));
            }
            return;
        }// end function

        protected function setChild(param1:int, param2:IUIComponent) : void
        {
            if (this.m_Child[param1] != null)
            {
                removeChild(this.m_Child[param1] as DisplayObject);
            }
            var _loc_3:* = this.m_Child.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (this.m_Child[_loc_3] == param2)
                {
                    this.m_Child[_loc_3] = null;
                }
                _loc_3 = _loc_3 - 1;
            }
            this.m_Child[param1] = param2;
            if (this.m_Child[param1] != null)
            {
                addChild(this.m_Child[param1] as DisplayObject);
            }
            invalidateDisplayList();
            invalidateSize();
            return;
        }// end function

        private function set _3317767left(param1:IUIComponent) : void
        {
            this.setChild(CHILD_LEFT, param1);
            return;
        }// end function

        public function get right() : IUIComponent
        {
            return this.m_Child[CHILD_RIGHT];
        }// end function

        public function set left(param1:IUIComponent) : void
        {
            var _loc_2:* = this.left;
            if (_loc_2 !== param1)
            {
                this._3317767left = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "left", _loc_2, param1));
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this.m_Child[CHILD_LEFT] != null && this.m_Child[CHILD_LEFT].includeInLayout)
            {
                _loc_1 = _loc_1 + this.m_Child[CHILD_LEFT].getExplicitOrMeasuredWidth();
                _loc_2 = _loc_2 + this.getExplicitOrMeasuredMinWidth(this.m_Child[CHILD_LEFT]);
                _loc_3 = Math.max(_loc_3, this.m_Child[CHILD_LEFT].getExplicitOrMeasuredHeight());
                _loc_4 = Math.max(_loc_4, this.getExplicitOrMeasuredMinHeight(this.m_Child[CHILD_LEFT]));
            }
            if (this.m_Child[CHILD_CENTER] != null && this.m_Child[CHILD_CENTER].includeInLayout)
            {
                _loc_1 = _loc_1 + this.m_Child[CHILD_CENTER].getExplicitOrMeasuredWidth();
                _loc_2 = _loc_2 + this.getExplicitOrMeasuredMinWidth(this.m_Child[CHILD_CENTER]);
                _loc_3 = Math.max(_loc_3, this.m_Child[CHILD_CENTER].getExplicitOrMeasuredHeight());
                _loc_4 = Math.max(_loc_4, this.getExplicitOrMeasuredMinHeight(this.m_Child[CHILD_CENTER]));
            }
            if (this.m_Child[CHILD_RIGHT] != null && this.m_Child[CHILD_RIGHT].includeInLayout)
            {
                _loc_1 = _loc_1 + this.m_Child[CHILD_RIGHT].getExplicitOrMeasuredWidth();
                _loc_2 = _loc_2 + this.getExplicitOrMeasuredMinWidth(this.m_Child[CHILD_RIGHT]);
                _loc_3 = Math.max(_loc_3, this.m_Child[CHILD_RIGHT].getExplicitOrMeasuredHeight());
                _loc_4 = Math.max(_loc_4, this.getExplicitOrMeasuredMinHeight(this.m_Child[CHILD_RIGHT]));
            }
            if (this.m_Child[CHILD_BOTTOM] != null && this.m_Child[CHILD_BOTTOM].includeInLayout)
            {
                _loc_1 = Math.max(_loc_1, this.m_Child[CHILD_BOTTOM].getExplicitOrMeasuredWidth());
                _loc_2 = Math.max(_loc_2, this.getExplicitOrMeasuredMinWidth(this.m_Child[CHILD_BOTTOM]));
                _loc_3 = _loc_3 + this.m_Child[CHILD_BOTTOM].getExplicitOrMeasuredHeight();
                _loc_4 = _loc_4 + this.getExplicitOrMeasuredMinHeight(this.m_Child[CHILD_BOTTOM]);
            }
            if (this.m_Child[CHILD_TOP] != null && this.m_Child[CHILD_TOP].includeInLayout)
            {
                _loc_1 = Math.max(_loc_1, this.m_Child[CHILD_TOP].getExplicitOrMeasuredWidth());
                _loc_2 = Math.max(_loc_2, this.getExplicitOrMeasuredMinWidth(this.m_Child[CHILD_TOP]));
                _loc_3 = _loc_3 + this.m_Child[CHILD_TOP].getExplicitOrMeasuredHeight();
                _loc_4 = _loc_4 + this.getExplicitOrMeasuredMinHeight(this.m_Child[CHILD_TOP]);
            }
            measuredMinWidth = _loc_2;
            measuredWidth = _loc_1;
            measuredMinHeight = _loc_4;
            measuredHeight = _loc_3;
            explicitMinWidth = _loc_2;
            explicitMinHeight = _loc_4;
            return;
        }// end function

    }
}

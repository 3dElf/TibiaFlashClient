package shared.controls
{
    import flash.events.*;
    import mx.core.*;

    public class ColourRenderer extends UIComponent
    {
        protected var m_Hover:Boolean = false;
        private var m_UncommittedSelected:Boolean = false;
        protected var m_Selected:Boolean = false;
        protected var m_Data:Object = null;
        private var m_UncommittedARGB:Boolean = false;
        protected var m_ARGB:uint = 0;

        public function ColourRenderer()
        {
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseEvent, false, EventPriority.DEFAULT, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseEvent, false, EventPriority.DEFAULT, true);
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this.m_Selected;
        }// end function

        public function get ARGB() : uint
        {
            return this.m_ARGB;
        }// end function

        public function set ARGB(param1:uint) : void
        {
            if (this.m_ARGB != param1)
            {
                this.m_ARGB = param1;
                this.m_UncommittedARGB = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        protected function onMouseEvent(event:MouseEvent) : void
        {
            if (event != null)
            {
                switch(event.type)
                {
                    case MouseEvent.MOUSE_OVER:
                    {
                        this.m_Hover = true;
                        invalidateDisplayList();
                        break;
                    }
                    case MouseEvent.MOUSE_OUT:
                    {
                    }
                    default:
                    {
                        this.m_Hover = false;
                        invalidateDisplayList();
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get data()
        {
            return this.m_Data;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (this.m_Selected != param1)
            {
                this.m_Selected = param1;
                this.m_UncommittedSelected = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = (this.m_ARGB >>> 24) / 255;
            var _loc_4:* = this.m_ARGB & 16777215;
            var _loc_5:* = getStyle("selectionAlpha");
            var _loc_6:* = getStyle("selectionColor");
            graphics.clear();
            if (this.m_Selected || this.m_Hover)
            {
                graphics.beginFill(_loc_4, _loc_3 * 0.33);
                graphics.drawRect(0, 0, param1, param2);
                graphics.beginFill(_loc_4, _loc_3);
                graphics.drawRect(2, 2, param1 - 4, param2 - 4);
                graphics.beginFill(0, NaN);
                graphics.lineStyle(1, _loc_6, _loc_5);
                graphics.drawRect(0, 0, (param1 - 1), (param2 - 1));
            }
            else
            {
                graphics.beginFill(_loc_4, _loc_3);
                graphics.drawRect(0, 0, param1, param2);
            }
            graphics.endFill();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedARGB)
            {
                this.m_UncommittedARGB = false;
            }
            if (this.m_UncommittedSelected)
            {
                this.m_UncommittedSelected = false;
            }
            return;
        }// end function

        public function set data(param1) : void
        {
            this.m_Data = param1;
            return;
        }// end function

    }
}

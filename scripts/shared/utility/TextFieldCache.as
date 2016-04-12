package shared.utility
{
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class TextFieldCache extends BitmapCache
    {
        protected var m_AddEllipsis:Boolean = true;
        protected var m_EllipsisWidth:int = 0;
        protected var m_Matrix:Matrix = null;
        protected var m_TextField:TextField = null;
        public static const DEFAULT_HEIGHT:int = 17;
        public static const DEFAULT_WIDTH:int = 330;
        static var s_Matrix:Matrix = new Matrix(1, 0, 0, 1, 0, 0);

        public function TextFieldCache(param1:int, param2:int, param3:uint, param4:Boolean)
        {
            super(param1, param2, param3);
            this.m_TextField = new TextField();
            this.m_TextField.autoSize = TextFieldAutoSize.LEFT;
            this.m_TextField.defaultTextFormat = new TextFormat("Verdana", 11, 0, true);
            this.m_TextField.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
            this.m_AddEllipsis = param4;
            this.updateEllipsis();
            return;
        }// end function

        private function updateEllipsis() : void
        {
            this.m_TextField.text = "...";
            this.m_EllipsisWidth = this.m_TextField.width;
            return;
        }// end function

        public function get textFormat() : TextFormat
        {
            return this.m_TextField.defaultTextFormat;
        }// end function

        public function set textFormat(param1:TextFormat) : void
        {
            this.m_TextField.defaultTextFormat = param1;
            this.updateEllipsis();
            return;
        }// end function

        public function get textFilters() : Array
        {
            return this.m_TextField.filters;
        }// end function

        override protected function addItem(param1:Rectangle, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = 0;
            if (param2 != null && param2.length > 0)
            {
                _loc_3 = String(param2[0]);
                _loc_4 = uint(this.m_TextField.defaultTextFormat.color);
                _loc_5 = slotWidth;
                if (param2.length > 1)
                {
                    _loc_4 = uint(param2[1]);
                }
                if (param2.length > 2)
                {
                    _loc_5 = Math.max(0, Math.min(Math.floor(param2[2]), slotWidth));
                }
                this.m_TextField.textColor = _loc_4;
                this.m_TextField.text = _loc_3;
                if (this.m_TextField.width > _loc_5)
                {
                    _loc_6 = 0;
                    if (this.m_AddEllipsis)
                    {
                        _loc_6 = this.m_TextField.getCharIndexAtPoint(_loc_5 - this.m_EllipsisWidth, this.m_TextField.height / 2);
                        this.m_TextField.text = _loc_3.substr(0, _loc_6) + "...";
                    }
                    else
                    {
                        _loc_6 = this.m_TextField.getCharIndexAtPoint(_loc_5, this.m_TextField.height / 2);
                        this.m_TextField.text = _loc_3.substr(0, _loc_6);
                    }
                }
                param1.width = this.m_TextField.width;
                param1.height = this.m_TextField.height;
                s_Matrix.tx = param1.x;
                s_Matrix.ty = param1.y;
                draw(this.m_TextField, s_Matrix, null, null, null, false);
            }
            return;
        }// end function

        public function set textFilters(param1:Array) : void
        {
            this.m_TextField.filters = param1;
            this.updateEllipsis();
            return;
        }// end function

    }
}

package tibia.sidebar.sideBarWidgetClasses
{
    import mx.core.*;
    import mx.skins.*;
    import shared.skins.*;

    public class WidgetViewSkin extends ProgrammaticSkin implements IBorder
    {
        private var m_Center:BitmapGrid;
        private var m_Footer:BitmapGrid;
        private var m_Header:BitmapGrid;

        public function WidgetViewSkin()
        {
            this.m_Header = new BitmapGrid(null, "borderHeader");
            this.m_Center = new BitmapGrid(null, "borderCenter");
            this.m_Footer = new BitmapGrid(null, "borderFooter");
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return Math.max(this.m_Header.measuredWidth, this.m_Center.measuredWidth, this.m_Footer.measuredWidth);
        }// end function

        public function get footerHeight() : Number
        {
            return this.m_Footer.measuredHeight;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            this.m_Header.styleChanged(param1);
            this.m_Center.styleChanged(param1);
            this.m_Footer.styleChanged(param1);
            return;
        }// end function

        override public function get measuredHeight() : Number
        {
            return this.m_Header.measuredHeight + this.m_Center.measuredHeight + this.m_Footer.measuredHeight;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            var _loc_1:* = new EdgeMetrics();
            var _loc_2:* = this.m_Center.borderMetrics;
            _loc_1.bottom = this.m_Footer.measuredHeight + _loc_2.bottom;
            _loc_1.left = _loc_2.left;
            _loc_1.right = _loc_2.right;
            _loc_1.top = this.m_Header.measuredHeight + _loc_2.top;
            return _loc_1;
        }// end function

        override public function set styleName(param1:Object) : void
        {
            super.styleName = param1;
            this.m_Header.styleName = param1;
            this.m_Center.styleName = param1;
            this.m_Footer.styleName = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = param2;
            var _loc_4:* = 0;
            graphics.clear();
            if (_loc_3 > 0)
            {
                this.m_Header.drawGrid(graphics, 0, 0, param1, this.m_Header.measuredHeight);
                _loc_4 = this.m_Header.measuredHeight;
                _loc_3 = _loc_3 - this.m_Header.measuredHeight;
            }
            if (_loc_3 > 0)
            {
                this.m_Footer.drawGrid(graphics, 0, param2 - this.m_Footer.measuredHeight, param1, this.m_Footer.measuredHeight);
                _loc_3 = _loc_3 - this.m_Footer.measuredHeight;
            }
            if (_loc_3 > 0)
            {
                this.m_Center.drawGrid(graphics, 0, _loc_4, param1, _loc_3);
            }
            graphics.endFill();
            return;
        }// end function

        public function get headerHeight() : Number
        {
            return this.m_Header.measuredHeight;
        }// end function

    }
}

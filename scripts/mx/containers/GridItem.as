package mx.containers
{

    public class GridItem extends HBox
    {
        var colIndex:int = 0;
        private var _rowSpan:int = 1;
        private var _colSpan:int = 1;
        static const VERSION:String = "3.6.0.21751";

        public function GridItem()
        {
            return;
        }// end function

        public function set rowSpan(param1:int) : void
        {
            _rowSpan = param1;
            invalidateSize();
            return;
        }// end function

        public function get colSpan() : int
        {
            return _colSpan;
        }// end function

        public function set colSpan(param1:int) : void
        {
            _colSpan = param1;
            invalidateSize();
            return;
        }// end function

        public function get rowSpan() : int
        {
            return _rowSpan;
        }// end function

    }
}

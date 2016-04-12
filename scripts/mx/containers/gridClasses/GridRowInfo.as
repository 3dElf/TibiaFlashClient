package mx.containers.gridClasses
{
    import mx.core.*;

    public class GridRowInfo extends Object
    {
        public var y:Number;
        public var preferred:Number;
        public var max:Number;
        public var height:Number;
        public var flex:Number;
        public var min:Number;
        static const VERSION:String = "3.6.0.21751";

        public function GridRowInfo()
        {
            min = 0;
            preferred = 0;
            max = UIComponent.DEFAULT_MAX_HEIGHT;
            flex = 0;
            return;
        }// end function

    }
}

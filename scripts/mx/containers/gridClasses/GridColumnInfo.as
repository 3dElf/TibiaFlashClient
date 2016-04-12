package mx.containers.gridClasses
{
    import mx.containers.utilityClasses.*;
    import mx.core.*;

    public class GridColumnInfo extends FlexChildInfo
    {
        public var x:Number;
        static const VERSION:String = "3.6.0.21751";

        public function GridColumnInfo()
        {
            min = 0;
            preferred = 0;
            max = UIComponent.DEFAULT_MAX_WIDTH;
            flex = 0;
            percent = 0;
            return;
        }// end function

    }
}

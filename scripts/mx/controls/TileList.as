package mx.controls
{
    import mx.controls.listClasses.*;
    import mx.core.*;

    public class TileList extends TileBase
    {
        static const VERSION:String = "3.6.0.21751";

        public function TileList()
        {
            _horizontalScrollPolicy = ScrollPolicy.AUTO;
            itemRenderer = new ClassFactory(TileListItemRenderer);
            return;
        }// end function

    }
}

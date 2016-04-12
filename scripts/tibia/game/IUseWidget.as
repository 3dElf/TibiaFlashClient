package tibia.game
{
    import flash.geom.*;

    public interface IUseWidget
    {

        public function IUseWidget();

        function getUseObjectUnderPoint(param1:Point) : Object;

        function getMultiUseObjectUnderPoint(param1:Point) : Object;

    }
}

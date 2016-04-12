package tibia.game
{
    import flash.geom.*;
    import tibia.game.*;

    public interface IMoveWidget extends ICoordinateWidget
    {

        public function IMoveWidget();

        function getMoveObjectUnderPoint(param1:Point) : Object;

    }
}

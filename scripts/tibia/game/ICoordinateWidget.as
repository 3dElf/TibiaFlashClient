package tibia.game
{
    import flash.geom.*;
    import shared.utility.*;

    public interface ICoordinateWidget
    {

        public function ICoordinateWidget();

        function pointToMap(param1:Point) : Vector3D;

        function pointToAbsolute(param1:Point) : Vector3D;

    }
}

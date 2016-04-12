package tibia.minimap
{
    import shared.utility.*;

    class PathItem extends HeapItem
    {
        public var y:int = 0;
        public var pathHeuristic:int = 2.14748e+009;
        public var predecessor:PathItem = null;
        public var cost:int = 2.14748e+009;
        public var distance:int = 2.14748e+009;
        public var x:int = 0;
        public var pathCost:int = 2.14748e+009;

        function PathItem(param1:int, param2:int)
        {
            this.x = param1;
            this.y = param2;
            this.distance = Math.abs(param1) + Math.abs(param2);
            return;
        }// end function

    }
}

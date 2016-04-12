package tibia.worldmap.widgetClasses
{

    public class RenderAtom extends Object
    {
        public var x:int = 0;
        public var y:int = 0;
        public var z:int = 0;
        public var object:Object = null;

        public function RenderAtom(param1:Object = null, param2:int = 0, param3:int = 0, param4:int = 0)
        {
            this.object = param1;
            this.x = param2;
            this.y = param3;
            this.z = param4;
            return;
        }// end function

        public function update(param1:Object = null, param2:int = 0, param3:int = 0, param4:int = 0) : void
        {
            this.object = param1;
            this.x = param2;
            this.y = param3;
            this.z = param4;
            return;
        }// end function

        public function reset() : void
        {
            this.update();
            return;
        }// end function

        public function assign(param1:RenderAtom) : void
        {
            if (param1 == null || param1 == this)
            {
                return;
            }
            this.object = param1.object;
            this.x = param1.x;
            this.y = param1.y;
            this.z = param1.z;
            return;
        }// end function

        public function clone() : RenderAtom
        {
            return new RenderAtom(this.object, this.x, this.y, this.z);
        }// end function

    }
}

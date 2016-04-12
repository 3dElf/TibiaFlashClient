package shared.utility
{

    public class Vector3D extends Object
    {
        public var x:int = 0;
        public var y:int = 0;
        public var z:int = 0;

        public function Vector3D(param1:int = 0, param2:int = 0, param3:int = 0)
        {
            this.x = param1;
            this.y = param2;
            this.z = param3;
            return;
        }// end function

        public function sub(param1:Vector3D) : Vector3D
        {
            return new Vector3D(this.x - param1.x, this.y - param1.y, this.z - param1.z);
        }// end function

        public function isZero() : Boolean
        {
            return this.x == 0 && this.y == 0 && this.z == 0;
        }// end function

        public function mul(param1:int) : void
        {
            this.x = this.x * param1;
            this.y = this.y * param1;
            this.z = this.z * param1;
            return;
        }// end function

        public function setVector(param1:Vector3D) : void
        {
            this.x = param1.x;
            this.y = param1.y;
            this.z = param1.z;
            return;
        }// end function

        public function equals(param1:Object) : Boolean
        {
            var _loc_2:* = param1 as Vector3D;
            return _loc_2 != null && _loc_2.x == this.x && _loc_2.y == this.y && _loc_2.z == this.z;
        }// end function

        public function add(param1:Vector3D) : Vector3D
        {
            return new Vector3D(this.x + param1.x, this.y + param1.y, this.z + param1.z);
        }// end function

        public function setZero() : void
        {
            this.x = 0;
            this.y = 0;
            this.z = 0;
            return;
        }// end function

        public function toString() : String
        {
            return "(" + this.x + ", " + this.y + ", " + this.z + ")";
        }// end function

        public function clone() : Vector3D
        {
            return new Vector3D(this.x, this.y, this.z);
        }// end function

        public function setComponents(param1:int, param2:int, param3:int) : void
        {
            this.x = param1;
            this.y = param2;
            this.z = param3;
            return;
        }// end function

    }
}

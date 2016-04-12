package tibia.game
{

    public class Delay extends Object
    {
        public var start:Number = 0;
        public var end:Number = 0;

        public function Delay(param1:Number, param2:Number)
        {
            this.start = param1;
            this.end = param2;
            return;
        }// end function

        public function get duration() : Number
        {
            return this.end - this.start;
        }// end function

        public function clone() : Delay
        {
            return new Delay(this.start, this.end);
        }// end function

        public function contains(param1:Number) : Boolean
        {
            return this.start <= param1 && param1 <= this.end;
        }// end function

        public static function merge(param1:Delay, param2:Delay) : Delay
        {
            if (param1 == null && param2 == null)
            {
                return new Delay(0, 0);
            }
            if (param1 == null)
            {
                return new Delay(param2.start, param2.end);
            }
            if (param2 == null)
            {
                return new Delay(param1.start, param1.end);
            }
            if (param1.end < param2.start || param1.start >= param2.start && param1.end <= param2.end)
            {
                return new Delay(param2.start, param2.end);
            }
            if (param1.start > param2.end || param1.start <= param2.start && param1.end >= param2.end)
            {
                return new Delay(param1.start, param1.end);
            }
            if (param1.start < param2.start && param1.end >= param2.start)
            {
                return new Delay(param1.start, param2.end);
            }
            if (param1.start <= param2.end && param1.end > param2.end)
            {
                return new Delay(param2.start, param1.end);
            }
            throw new Error("Delay.s_Merge: Can\'t merge delays.");
        }// end function

    }
}

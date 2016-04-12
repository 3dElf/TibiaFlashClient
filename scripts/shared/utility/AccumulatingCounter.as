package shared.utility
{

    public class AccumulatingCounter extends Object
    {
        private var m_Min:Number = 1.#INF;
        private var m_Max:Number = -1.#INF;
        private var m_Length:uint = 0;
        private var m_Total:Number = 0;

        public function AccumulatingCounter()
        {
            return;
        }// end function

        public function get length() : uint
        {
            return this.m_Length;
        }// end function

        public function get maximum() : Number
        {
            return this.m_Max;
        }// end function

        public function update(param1:Number) : void
        {
            if (param1 > this.m_Max)
            {
                this.m_Max = param1;
            }
            if (param1 < this.m_Min && param1 > 0)
            {
                this.m_Min = param1;
            }
            var _loc_2:* = this;
            var _loc_3:* = this.m_Length + 1;
            _loc_2.m_Length = _loc_3;
            this.m_Total = this.m_Total + param1;
            return;
        }// end function

        public function toString() : String
        {
            return this.m_Length + "/" + this.m_Total + "/" + this.minimum.toFixed(2) + "/" + this.average.toFixed(2) + "/" + this.maximum.toFixed(2);
        }// end function

        public function get minimum() : Number
        {
            return this.m_Min;
        }// end function

        public function get total() : Number
        {
            return this.m_Total;
        }// end function

        public function reset() : void
        {
            this.m_Length = 0;
            this.m_Max = Number.NEGATIVE_INFINITY;
            this.m_Min = Number.POSITIVE_INFINITY;
            this.m_Total = 0;
            return;
        }// end function

        public function get average() : Number
        {
            if (this.m_Length > 0)
            {
                return this.m_Total / this.m_Length;
            }
            return 0;
        }// end function

    }
}

package shared.utility
{
    import flash.utils.*;
    import shared.utility.*;

    public class AccumulatingPerformanceCounter extends Object implements IPerformanceCounter
    {
        private var m_PauseDuration:uint = 0;
        private var m_Total:Number = 0;
        private var m_Length:uint = 0;
        private var m_Min:Number = 1.#INF;
        private var m_Max:Number = -1.#INF;
        private var m_PauseStart:Number = NaN;
        private var m_Start:Number = NaN;

        public function AccumulatingPerformanceCounter()
        {
            return;
        }// end function

        public function stop() : void
        {
            var _loc_1:* = NaN;
            if (!isNaN(this.m_Start))
            {
                this.resume();
                _loc_1 = getTimer() - this.m_Start - this.m_PauseDuration;
                if (_loc_1 > this.m_Max)
                {
                    this.m_Max = _loc_1;
                }
                if (_loc_1 < this.m_Min)
                {
                    this.m_Min = _loc_1;
                }
                var _loc_2:* = this;
                var _loc_3:* = this.m_Length + 1;
                _loc_2.m_Length = _loc_3;
                this.m_Start = NaN;
                this.m_PauseStart = NaN;
                this.m_Total = this.m_Total + _loc_1;
            }
            return;
        }// end function

        public function get total() : Number
        {
            return this.m_Total;
        }// end function

        public function get minimum() : Number
        {
            return this.m_Min;
        }// end function

        public function reset() : void
        {
            this.m_Length = 0;
            this.m_Max = Number.NEGATIVE_INFINITY;
            this.m_Min = Number.POSITIVE_INFINITY;
            this.m_Start = NaN;
            this.m_Total = 0;
            return;
        }// end function

        public function get maximum() : Number
        {
            return this.m_Max;
        }// end function

        public function start() : void
        {
            this.m_Start = getTimer();
            this.m_PauseDuration = 0;
            this.m_PauseStart = NaN;
            return;
        }// end function

        public function get length() : uint
        {
            return this.m_Length;
        }// end function

        public function get average() : Number
        {
            if (this.m_Length > 0)
            {
                return this.m_Total / this.m_Length;
            }
            return 0;
        }// end function

        public function toString() : String
        {
            return this.m_Length + "/" + this.m_Total + "/" + this.minimum.toFixed(2) + "/" + this.average.toFixed(2) + "/" + this.maximum.toFixed(2);
        }// end function

        public function resume() : void
        {
            var _loc_1:* = NaN;
            if (!isNaN(this.m_PauseStart))
            {
                _loc_1 = getTimer() - this.m_PauseStart;
                this.m_PauseDuration = this.m_PauseDuration + _loc_1;
                this.m_PauseStart = NaN;
            }
            return;
        }// end function

        public function pause() : void
        {
            if (isNaN(this.m_PauseStart))
            {
                this.m_PauseStart = getTimer();
            }
            return;
        }// end function

    }
}

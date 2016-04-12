package shared.utility
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import shared.utility.*;

    public class SlidingWindowPerformanceCounter extends Object implements IPerformanceCounter
    {
        private var m_PauseDuration:uint = 0;
        private var m_Total:Number = 0;
        private var m_Length:uint = 0;
        private var m_Position:uint = 0;
        private var m_Data:Vector.<Number> = null;
        private var m_Min:Number = 1.#INF;
        private var m_Max:Number = -1.#INF;
        private var m_PauseStart:Number = NaN;
        private var m_Start:Number = NaN;

        public function SlidingWindowPerformanceCounter(param1:int)
        {
            if (param1 <= 0)
            {
                throw new ArgumentError("SlidingWindowPerformanceCounter.SlidingWindowPerformanceCounter: Invalid window size.");
            }
            this.m_Data = new Vector.<Number>(param1, true);
            return;
        }// end function

        public function stop() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = NaN;
            if (!isNaN(this.m_Start))
            {
                _loc_1 = this.m_Data.length;
                this.resume();
                _loc_2 = getTimer() - this.m_Start - this.m_PauseDuration;
                this.m_Total = this.m_Total - this.m_Data[this.m_Position] + _loc_2;
                this.m_Data[this.m_Position] = _loc_2;
                this.m_Position = (this.m_Position + 1) % _loc_1;
                var _loc_3:* = this;
                var _loc_4:* = this.m_Length + 1;
                _loc_3.m_Length = _loc_4;
                this.m_Max = NaN;
                this.m_Min = NaN;
                this.m_Start = NaN;
                this.m_PauseStart = NaN;
            }
            return;
        }// end function

        public function get total() : Number
        {
            return this.m_Total;
        }// end function

        public function get minimum() : Number
        {
            var _loc_1:* = 0;
            if (isNaN(this.m_Min))
            {
                this.m_Min = Number.POSITIVE_INFINITY;
                _loc_1 = Math.min(this.m_Length, this.m_Data.length) - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (this.m_Data[_loc_1] < this.m_Min)
                    {
                        this.m_Min = this.m_Data[_loc_1];
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            return this.m_Min;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = Math.min(this.m_Length, this.m_Data.length) - 1;
            while (_loc_1 >= 0)
            {
                
                this.m_Data[_loc_1] = 0;
                _loc_1 = _loc_1 - 1;
            }
            this.m_Length = 0;
            this.m_Max = Number.NEGATIVE_INFINITY;
            this.m_Min = Number.POSITIVE_INFINITY;
            this.m_Position = 0;
            this.m_Start = NaN;
            this.m_Total = 0;
            return;
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

        public function get maximum() : Number
        {
            var _loc_1:* = 0;
            if (isNaN(this.m_Max))
            {
                this.m_Max = Number.NEGATIVE_INFINITY;
                _loc_1 = Math.min(this.m_Length, this.m_Data.length) - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (this.m_Data[_loc_1] > this.m_Max)
                    {
                        this.m_Max = this.m_Data[_loc_1];
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            return this.m_Max;
        }// end function

        public function get average() : Number
        {
            if (this.m_Length > 0)
            {
                return this.m_Total / Math.min(this.m_Length, this.m_Data.length);
            }
            return 0;
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

        public function toString() : String
        {
            return this.m_Length + "/" + this.m_Total + "/" + this.minimum.toFixed(2) + "/" + this.average.toFixed(2) + "/" + this.maximum.toFixed(2);
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

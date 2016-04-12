package tibia.creatures
{
    import __AS3__.vec.*;

    public class SkillCounter extends Object
    {
        protected var m_DataPoints:Vector.<Number>;
        protected var m_DataTimestamps:Vector.<uint>;
        private static const NUM_DATA_POINTS:int = 15;

        public function SkillCounter()
        {
            this.m_DataPoints = new Vector.<Number>(NUM_DATA_POINTS, true);
            this.m_DataTimestamps = new Vector.<uint>(NUM_DATA_POINTS, true);
            this.reset();
            return;
        }// end function

        public function addSkillGain(param1:Number) : void
        {
            if (param1 < 0 || isNaN(param1))
            {
                throw new ArgumentError("SkillCounter.addSkillGain: Gain is negative.");
            }
            var _loc_2:* = uint(Tibia.s_GetTibiaTimer() / 60000);
            var _loc_3:* = _loc_2 % NUM_DATA_POINTS;
            if (this.m_DataTimestamps[_loc_3] != _loc_2)
            {
                this.m_DataTimestamps[_loc_3] = _loc_2;
                this.m_DataPoints[_loc_3] = param1;
            }
            else
            {
                this.m_DataPoints[_loc_3] = this.m_DataPoints[_loc_3] + param1;
            }
            return;
        }// end function

        public function getAverageGain() : Number
        {
            var _loc_1:* = 0;
            var _loc_2:* = uint(Tibia.s_GetTibiaTimer() / 60000);
            var _loc_3:* = NUM_DATA_POINTS - 1;
            while (_loc_3 >= 0)
            {
                
                if (this.m_DataTimestamps[_loc_3] + NUM_DATA_POINTS >= _loc_2)
                {
                    _loc_1 = _loc_1 + this.m_DataPoints[_loc_3];
                }
                _loc_3 = _loc_3 - 1;
            }
            return _loc_1 * 60 / NUM_DATA_POINTS;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < NUM_DATA_POINTS)
            {
                
                this.m_DataPoints[_loc_1] = 0;
                this.m_DataTimestamps[_loc_1] = 0;
                _loc_1++;
            }
            return;
        }// end function

    }
}

package tibia.appearances
{

    public class FrameDuration extends Object
    {
        private var m_MinimumDuration:uint = 0;
        private var m_MaximumDuration:uint = 0;

        public function FrameDuration(param1:uint, param2:uint)
        {
            if (param1 <= param2)
            {
                this.m_MinimumDuration = param1;
                this.m_MaximumDuration = param2;
            }
            else
            {
                throw new ArgumentError("FrameDuration: MinimumDuration > MaximumDuration");
            }
            return;
        }// end function

        public function get minimumDuration() : uint
        {
            return this.m_MinimumDuration;
        }// end function

        public function get maximumDuration() : uint
        {
            return this.m_MaximumDuration;
        }// end function

        public function get duration() : uint
        {
            var _loc_1:* = 0;
            if (this.m_MinimumDuration == this.m_MaximumDuration)
            {
                return this.m_MinimumDuration;
            }
            _loc_1 = this.m_MaximumDuration - this.m_MinimumDuration;
            return this.m_MinimumDuration + Math.round(Math.random() * _loc_1);
        }// end function

    }
}

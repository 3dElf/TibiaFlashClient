package tibia.market
{

    public class OfferID extends Object
    {
        private var m_Counter:uint = 0;
        private var m_Timestamp:uint = 0;

        public function OfferID(param1:uint, param2:uint)
        {
            this.m_Timestamp = param1;
            this.m_Counter = param2;
            return;
        }// end function

        public function isLessThan(param1:OfferID) : Boolean
        {
            return this.m_Timestamp < param1.m_Timestamp || this.m_Timestamp == param1.m_Timestamp && this.m_Counter < param1.m_Counter;
        }// end function

        public function get timestamp() : uint
        {
            return this.m_Timestamp;
        }// end function

        public function isEqual(param1:OfferID) : Boolean
        {
            return this.m_Timestamp == param1.m_Timestamp && this.m_Counter == param1.m_Counter;
        }// end function

        public function get counter() : uint
        {
            return this.m_Counter;
        }// end function

    }
}

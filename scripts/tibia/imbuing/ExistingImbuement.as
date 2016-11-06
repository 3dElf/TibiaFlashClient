package tibia.imbuing
{

    public class ExistingImbuement extends Object
    {
        private var m_RemainingDurationInSeconds:uint = 0;
        private var m_ImbuementData:ImbuementData = null;
        private var m_ClearingGoldCost:uint = 0;

        public function ExistingImbuement(param1:ImbuementData = null, param2:uint = 0, param3:uint = 0)
        {
            this.m_ImbuementData = param1;
            this.m_RemainingDurationInSeconds = param2;
            this.m_ClearingGoldCost = param3;
            return;
        }// end function

        public function set remainingDurationInSeconds(param1:uint) : void
        {
            this.m_RemainingDurationInSeconds = param1;
            return;
        }// end function

        public function get clearingGoldCost() : uint
        {
            return this.m_ClearingGoldCost;
        }// end function

        public function set imbuementData(param1:ImbuementData) : void
        {
            this.m_ImbuementData = param1;
            return;
        }// end function

        public function get empty() : Boolean
        {
            return this.m_ImbuementData == null;
        }// end function

        public function get remainingDurationInSeconds() : uint
        {
            return this.m_RemainingDurationInSeconds;
        }// end function

        public function get imbuementData() : ImbuementData
        {
            return this.m_ImbuementData;
        }// end function

        public function set clearingGoldCost(param1:uint) : void
        {
            this.m_ClearingGoldCost = param1;
            return;
        }// end function

    }
}

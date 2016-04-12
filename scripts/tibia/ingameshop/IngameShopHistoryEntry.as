package tibia.ingameshop
{

    public class IngameShopHistoryEntry extends Object
    {
        private var m_Timestamp:Number;
        private var m_TransactionType:int;
        private var m_TransactionName:String;
        private var m_CreditChange:Number;
        public static const TRANSACTION_GIFT:int = 1;
        public static const TRANSACTION_PURCHASE_OR_CREDITCHANGE:int = 0;
        public static const TRANSACTION_REFUND:int = 2;

        public function IngameShopHistoryEntry(param1:Number, param2:Number, param3:int, param4:String)
        {
            this.m_Timestamp = param1;
            this.m_CreditChange = param2;
            this.m_TransactionType = param3;
            this.m_TransactionName = param4;
            return;
        }// end function

        public function isRefund() : Boolean
        {
            return this.transactionType == TRANSACTION_REFUND;
        }// end function

        public function get creditChange() : Number
        {
            return this.m_CreditChange;
        }// end function

        public function get transactionName() : String
        {
            return this.m_TransactionName;
        }// end function

        public function get timestamp() : Number
        {
            return this.m_Timestamp;
        }// end function

        public function get transactionType() : int
        {
            return this.m_TransactionType;
        }// end function

        public function isGift() : Boolean
        {
            return this.transactionType == TRANSACTION_GIFT;
        }// end function

    }
}

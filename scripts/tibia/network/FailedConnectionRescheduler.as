package tibia.network
{
    import mx.resources.*;

    public class FailedConnectionRescheduler extends Object
    {
        private var m_AttemptedReconnects:int = 0;
        private static const BUNDLE:String = "Connection";
        private static const MAXIMUM_ATTEMPTED_RETRIES:int = 10;

        public function FailedConnectionRescheduler()
        {
            return;
        }// end function

        private function getReconnectionDelayForAttempt(param1:int) : int
        {
            if (param1 == 1)
            {
                return 1;
            }
            if (param1 == 2)
            {
                return 500;
            }
            if (param1 == 3)
            {
                return 1000;
            }
            if (param1 == 4)
            {
                return 2000;
            }
            if (param1 == 5)
            {
                return 4000;
            }
            return 5000;
        }// end function

        private function getDisplayMessageForReconnect() : String
        {
            return ResourceManager.getInstance().getString(BUNDLE, "MSG_CONNECT_FAILED_RECONNECT", [this.m_AttemptedReconnects]);
        }// end function

        public function buildEventForReconnectionAndIncreaseRetries() : ConnectionEvent
        {
            var _loc_2:* = this;
            var _loc_3:* = this.m_AttemptedReconnects + 1;
            _loc_2.m_AttemptedReconnects = _loc_3;
            var _loc_1:* = new ConnectionEvent(ConnectionEvent.LOGINWAIT);
            _loc_1.message = this.getDisplayMessageForReconnect();
            _loc_1.data = this.getReconnectionDelayForAttempt(this.m_AttemptedReconnects);
            return _loc_1;
        }// end function

        public function shouldAttemptReconnect() : Boolean
        {
            return this.m_AttemptedReconnects < (MAXIMUM_ATTEMPTED_RETRIES - 1);
        }// end function

        public function reset() : void
        {
            this.m_AttemptedReconnects = 0;
            return;
        }// end function

    }
}

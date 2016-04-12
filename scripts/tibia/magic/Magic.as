package tibia.magic
{

    public class Magic extends Object
    {
        private var m_RestrictProfession:int = -1;
        private var m_CastMana:int = 0;
        private var m_DelaySecondary:int = 0;
        private var m_GroupSecondary:int = -1;
        private var m_ID:int = -1;
        private var m_GroupPrimary:int = -1;
        private var m_RestrictLevel:int = -1;
        private var m_DelayPrimary:int = 0;
        private var m_DelaySelf:int = 0;

        public function Magic(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int)
        {
            this.m_ID = param1;
            this.m_GroupPrimary = param2;
            this.m_GroupSecondary = param3;
            this.m_RestrictLevel = param4;
            this.m_RestrictProfession = param5;
            this.m_CastMana = param6;
            this.m_DelaySelf = param7;
            this.m_DelayPrimary = param8;
            this.m_DelaySecondary = param9;
            return;
        }// end function

        public function get groupPrimary() : int
        {
            return this.m_GroupPrimary;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function get restrictProfession() : int
        {
            return this.m_RestrictProfession;
        }// end function

        public function get castMana() : int
        {
            return this.m_CastMana;
        }// end function

        public function get restrictLevel() : int
        {
            return this.m_RestrictLevel;
        }// end function

        public function get delaySelf() : int
        {
            return this.m_DelaySelf;
        }// end function

        public function get delaySecondary() : int
        {
            return this.m_DelaySecondary;
        }// end function

        public function get groupSecondary() : int
        {
            return this.m_GroupSecondary;
        }// end function

        public function get delayPrimary() : int
        {
            return this.m_DelayPrimary;
        }// end function

    }
}

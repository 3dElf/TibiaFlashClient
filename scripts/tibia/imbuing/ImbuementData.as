package tibia.imbuing
{
    import __AS3__.vec.*;

    public class ImbuementData extends Object
    {
        private var m_IconID:uint = 0;
        private var m_Description:String;
        private var m_AstralSources:Vector.<AstralSource>;
        private var m_ID:uint = 0;
        private var m_Category:String;
        private var m_PremiumOnly:Boolean = false;
        private var m_SuccessRatePercent:Number = 0;
        private var m_ProtectionGoldCost:uint = 0;
        private var m_DurationInSeconds:uint = 0;
        private var m_Name:String;
        private var m_GoldCost:uint = 0;

        public function ImbuementData(param1:uint, param2:String)
        {
            this.m_AstralSources = new Vector.<AstralSource>;
            this.m_ID = param1;
            this.m_Name = param2;
            return;
        }// end function

        public function set iconID(param1:uint) : void
        {
            this.m_IconID = param1;
            return;
        }// end function

        public function set astralSources(param1:Vector.<AstralSource>) : void
        {
            this.m_AstralSources = param1;
            return;
        }// end function

        public function get successRatePercent() : uint
        {
            return this.m_SuccessRatePercent;
        }// end function

        public function set category(param1:String) : void
        {
            this.m_Category = param1;
            return;
        }// end function

        public function set successRatePercent(param1:uint) : void
        {
            this.m_SuccessRatePercent = param1;
            return;
        }// end function

        public function get category() : String
        {
            return this.m_Category;
        }// end function

        public function get imbuementID() : uint
        {
            return this.m_ID;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function get goldCost() : uint
        {
            return this.m_GoldCost;
        }// end function

        public function set description(param1:String) : void
        {
            this.m_Description = param1;
            return;
        }// end function

        public function set durationInSeconds(param1:uint) : void
        {
            this.m_DurationInSeconds = param1;
            return;
        }// end function

        public function get protectionGoldCost() : uint
        {
            return this.m_ProtectionGoldCost;
        }// end function

        public function get iconID() : uint
        {
            return this.m_IconID;
        }// end function

        public function get astralSources() : Vector.<AstralSource>
        {
            return this.m_AstralSources;
        }// end function

        public function set premiumOnly(param1:Boolean) : void
        {
            this.m_PremiumOnly = param1;
            return;
        }// end function

        public function set goldCost(param1:uint) : void
        {
            this.m_GoldCost = param1;
            return;
        }// end function

        public function get premiumOnly() : Boolean
        {
            return this.m_PremiumOnly;
        }// end function

        public function set protectionGoldCost(param1:uint) : void
        {
            this.m_ProtectionGoldCost = param1;
            return;
        }// end function

        public function get durationInSeconds() : uint
        {
            return this.m_DurationInSeconds;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}

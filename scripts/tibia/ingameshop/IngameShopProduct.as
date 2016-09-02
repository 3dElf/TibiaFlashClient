package tibia.ingameshop
{
    import __AS3__.vec.*;

    public class IngameShopProduct extends Object
    {
        private var m_Name:String;
        private var m_Description:String;
        private var m_ServiceType:String;
        private var m_IconIdentifiers:Vector.<String>;
        public static const SERVICE_TYPE_PREMIUM:int = 2;
        public static const SERVICE_TYPE_UNKNOWN:int = 0;
        public static const SERVICE_TYPE_XPBOOST:int = 6;
        public static const SERVICE_TYPE_BLESSINGS:int = 5;
        public static const SERVICE_TYPE_CHARACTER_NAME_CHANGE:int = 1;
        public static const SERVICE_TYPE_MOUNTS:int = 4;
        public static const SERVICE_TYPE_OUTFITS:int = 3;

        public function IngameShopProduct(param1:String, param2:String, param3:String)
        {
            this.m_Name = param1;
            this.m_Description = param2;
            this.m_ServiceType = param3;
            this.m_IconIdentifiers = new Vector.<String>;
            return;
        }// end function

        public function set iconIdentifiers(param1:Vector.<String>) : void
        {
            this.m_IconIdentifiers = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function clone() : IngameShopProduct
        {
            var _loc_1:* = new IngameShopProduct(this.m_Name, this.m_Description, this.m_ServiceType);
            _loc_1.m_IconIdentifiers = this.m_IconIdentifiers;
            return _loc_1;
        }// end function

        public function get iconIdentifiers() : Vector.<String>
        {
            return this.m_IconIdentifiers;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}

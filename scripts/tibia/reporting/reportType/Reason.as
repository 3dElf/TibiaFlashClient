package tibia.reporting.reportType
{
    import mx.resources.*;

    public class Reason extends Object
    {
        private var m_Description:String = null;
        private var m_Name:String = null;
        private var m_Value:uint = 0;
        private static const BUNDLE:String = "ReportWidget";

        public function Reason(param1:String, param2:String, param3:uint)
        {
            var _loc_4:* = ResourceManager.getInstance();
            this.m_Name = _loc_4.getString(BUNDLE, param1);
            this.m_Description = _loc_4.getString(BUNDLE, param2);
            this.m_Value = param3;
            return;
        }// end function

        public function get value() : uint
        {
            return this.m_Value;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}

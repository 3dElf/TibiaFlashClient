package tibia.reporting.reportType
{
    import tibia.reporting.*;

    public class ReportableClone extends Object implements IReportable
    {
        private var m_CharacterName:String = null;
        private var m_ReportTypeAllowed:Object;
        private var m_ID:int = 0;

        public function ReportableClone(param1:int, param2:String)
        {
            this.m_ReportTypeAllowed = {};
            this.m_CharacterName = param2;
            this.m_ID = param1;
            return;
        }// end function

        public function get characterName() : String
        {
            return this.m_CharacterName;
        }// end function

        public function isReportTypeAllowed(param1:uint) : Boolean
        {
            if (this.m_ReportTypeAllowed.hasOwnProperty(param1))
            {
                return this.m_ReportTypeAllowed[param1];
            }
            return false;
        }// end function

        public function setReportTypeAllowed(param1:uint, param2:Boolean = true) : void
        {
            this.m_ReportTypeAllowed[param1] = param2;
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public static function s_CloneReportable(param1:IReportable) : IReportable
        {
            var _loc_2:* = new ReportableClone(param1.ID, param1.characterName);
            _loc_2.setReportTypeAllowed(Type.REPORT_BOT, param1.isReportTypeAllowed(Type.REPORT_BOT));
            _loc_2.setReportTypeAllowed(Type.REPORT_NAME, param1.isReportTypeAllowed(Type.REPORT_NAME));
            _loc_2.setReportTypeAllowed(Type.REPORT_STATEMENT, param1.isReportTypeAllowed(Type.REPORT_STATEMENT));
            return _loc_2;
        }// end function

    }
}

package tibia.reporting.reportWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class ViewBase extends VBox
    {
        private var m_Reportable:IReportable = null;
        private var m_Type:int = 0;
        private var m_UIConstructed:Boolean = false;
        private var m_UIHeader:Text = null;
        private var m_UncommittedHeader:Boolean = false;
        private var m_Header:String = null;
        private static const BUNDLE:String = "ReportWidget";

        public function ViewBase(param1:uint, param2:IReportable)
        {
            if (param1 != Type.REPORT_BOT && param1 != Type.REPORT_NAME && param1 != Type.REPORT_STATEMENT)
            {
                throw new ArgumentError("ViewBase.ViewBase: Invalid report type.");
            }
            this.m_Type = param1;
            if (param2 == null)
            {
                throw new ArgumentError("ViewBase.ViewBase: Invalid report subject.");
            }
            if (!param2.isReportTypeAllowed(this.m_Type))
            {
                throw new ArgumentError("ViewBase.ViewBase: Report type is not supported.");
            }
            this.m_Reportable = param2;
            percentHeight = 100;
            percentWidth = 100;
            setStyle("horizontalGap", 2);
            setStyle("verticalGap", 2);
            return;
        }// end function

        public function get type() : int
        {
            return this.m_Type;
        }// end function

        public function get isDataValid() : Boolean
        {
            return false;
        }// end function

        protected function set header(param1:String) : void
        {
            if (this.m_Header != param1)
            {
                this.m_Header = param1;
                this.m_UncommittedHeader = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedHeader)
            {
                this.m_UIHeader.text = this.m_Header;
                this.m_UncommittedHeader = false;
            }
            return;
        }// end function

        protected function get header() : String
        {
            return this.m_Header;
        }// end function

        public function get reportable() : IReportable
        {
            return this.m_Reportable;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIHeader = new Text();
                this.m_UIHeader.height = 46;
                this.m_UIHeader.percentHeight = NaN;
                this.m_UIHeader.percentWidth = 100;
                this.m_UIHeader.text = this.m_Header;
                this.m_UIHeader.width = NaN;
                addChild(this.m_UIHeader);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}

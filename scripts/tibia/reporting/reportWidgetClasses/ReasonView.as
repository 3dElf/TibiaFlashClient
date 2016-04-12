package tibia.reporting.reportWidgetClasses
{
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class ReasonView extends ViewBase
    {
        private var m_UIReasonValidation:Label = null;
        private var m_UIReasons:List = null;
        private var m_UncommittedSelectedReason:Boolean = false;
        private var m_SelectedReason:Reason = null;
        private var m_UIDescription:TextArea = null;
        private var m_UIConstructed:Boolean = false;
        private var m_Reasons:Array = null;
        private var m_UncommittedReasons:Boolean = false;
        private static const BUNDLE:String = "ReportWidget";

        public function ReasonView(param1:uint, param2:IReportable)
        {
            super(param1, param2);
            switch(type)
            {
                case Type.REPORT_BOT:
                {
                    header = resourceManager.getString(BUNDLE, "BOT_PROGRESS_STEP_REASON");
                    this.reasons = Type.REPORT_BOT_REASONS;
                    break;
                }
                case Type.REPORT_NAME:
                {
                    header = resourceManager.getString(BUNDLE, "NAME_PROGRESS_STEP_REASON");
                    this.reasons = Type.REPORT_NAME_REASONS;
                    break;
                }
                case Type.REPORT_STATEMENT:
                {
                    header = resourceManager.getString(BUNDLE, "STATEMENT_PROGRESS_STEP_REASON");
                    this.reasons = Type.REPORT_STATEMENT_REASONS;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.selectedReason = null;
            return;
        }// end function

        public function set selectedReason(param1:Reason) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = false;
            if (param1 == null)
            {
                _loc_2 = true;
            }
            else if (this.m_Reasons != null)
            {
                _loc_3 = this.m_Reasons.length;
                while (_loc_3 >= 0)
                {
                    
                    if (this.m_Reasons[_loc_3] === param1)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            if (!_loc_2)
            {
                throw new ArgumentError("ReasonView.set selectedReason: Invalid reason.");
            }
            if (this.m_SelectedReason != param1 || param1 == null)
            {
                this.m_SelectedReason = param1;
                this.m_UncommittedSelectedReason = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function get isDataValid() : Boolean
        {
            return this.m_SelectedReason != null;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedReasons)
            {
                this.m_UIReasons.dataProvider = this.m_Reasons;
                this.m_UIReasons.selectedItem = null;
                this.m_UncommittedReasons = false;
            }
            if (this.m_UncommittedSelectedReason)
            {
                this.m_UIReasons.selectedItem = this.m_SelectedReason;
                if (this.m_SelectedReason != null)
                {
                    this.m_UIDescription.text = this.m_SelectedReason.description;
                    this.m_UIReasonValidation.styleName = "validationFeedbackValid";
                    this.m_UIReasonValidation.text = "";
                }
                else
                {
                    this.m_UIDescription.text = "";
                    this.m_UIReasonValidation.styleName = "validationFeedbackError";
                    this.m_UIReasonValidation.text = resourceManager.getString(BUNDLE, "VALIDATION_SELECT_REASON");
                }
                this.m_UncommittedSelectedReason = false;
            }
            return;
        }// end function

        protected function set reasons(param1:Array) : void
        {
            if (this.m_Reasons != param1)
            {
                this.m_Reasons = param1;
                this.m_UncommittedReasons = true;
                invalidateProperties();
                this.selectedReason = null;
            }
            return;
        }// end function

        protected function get reasons() : Array
        {
            return this.m_Reasons;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIReasons = new CustomList();
                this.m_UIReasons.height = 176;
                this.m_UIReasons.labelField = "name";
                this.m_UIReasons.percentHeight = NaN;
                this.m_UIReasons.percentWidth = 100;
                this.m_UIReasons.width = NaN;
                this.m_UIReasons.addEventListener(ListEvent.CHANGE, function (event:ListEvent) : void
            {
                selectedReason = Reason(m_UIReasons.selectedItem);
                return;
            }// end function
            );
                addChild(this.m_UIReasons);
                this.m_UIDescription = new TextArea();
                this.m_UIDescription.editable = false;
                this.m_UIDescription.percentHeight = 100;
                this.m_UIDescription.percentWidth = 100;
                this.m_UIDescription.styleName = "popUpTextComponent";
                addChild(this.m_UIDescription);
                this.m_UIReasonValidation = new Label();
                this.m_UIReasonValidation.percentHeight = NaN;
                this.m_UIReasonValidation.percentWidth = 100;
                this.m_UIReasonValidation.setStyle("textAlign", "right");
                addChild(this.m_UIReasonValidation);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get selectedReason() : Reason
        {
            return this.m_SelectedReason;
        }// end function

    }
}

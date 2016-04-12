package tibia.reporting.reportWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import shared.utility.*;
    import tibia.chat.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class ConfirmView extends ViewBase
    {
        private var m_UIReason:TextArea = null;
        private var m_UncommittedComment:Boolean = false;
        private var m_UIComment:TextArea = null;
        private var m_UncommittedTranslation:Boolean = false;
        private var m_UITranslation:TextArea = null;
        private var m_Comment:String = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedReason:Boolean = false;
        private var m_Reason:Reason = null;
        private var m_Translation:String = null;
        private static const BUNDLE:String = "ReportWidget";

        public function ConfirmView(param1:uint, param2:IReportable)
        {
            super(param1, param2);
            switch(type)
            {
                case Type.REPORT_BOT:
                {
                    header = resourceManager.getString(BUNDLE, "BOT_PROGRESS_STEP_CONFIRM");
                    break;
                }
                case Type.REPORT_NAME:
                {
                    header = resourceManager.getString(BUNDLE, "NAME_PROGRESS_STEP_CONFIRM");
                    break;
                }
                case Type.REPORT_STATEMENT:
                {
                    header = resourceManager.getString(BUNDLE, "STATEMENT_PROGRESS_STEP_CONFIRM");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get reason() : Reason
        {
            return this.m_Reason;
        }// end function

        public function set reason(param1:Reason) : void
        {
            if (this.m_Reason != param1)
            {
                this.m_Reason = param1;
                this.m_UncommittedReason = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedComment)
            {
                this.m_UIComment.text = this.m_Comment;
                this.m_UncommittedComment = false;
            }
            if (this.m_UncommittedReason)
            {
                this.m_UIReason.text = this.m_Reason != null ? (this.m_Reason.name) : (null);
                this.m_UncommittedComment = false;
            }
            if (this.m_UncommittedTranslation)
            {
                if (this.m_UITranslation != null)
                {
                    this.m_UITranslation.text = this.m_Translation;
                }
                this.m_UncommittedTranslation = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = null;
                _loc_2 = new Grid();
                _loc_2.percentHeight = 100;
                _loc_2.percentWidth = 100;
                _loc_2.setStyle("horizontalGap", 2);
                _loc_2.setStyle("verticalGap", 2);
                _loc_3 = new TextArea();
                _loc_3.editable = false;
                _loc_3.height = 18;
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                _loc_3.text = reportable.characterName;
                _loc_3.width = NaN;
                _loc_1 = this.makeGridRow("LABEL_NAME", _loc_3);
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_2.addChild(_loc_1);
                this.m_UIReason = new TextArea();
                this.m_UIReason.editable = false;
                this.m_UIReason.height = 18;
                this.m_UIReason.percentHeight = NaN;
                this.m_UIReason.percentWidth = 100;
                this.m_UIReason.width = NaN;
                _loc_1 = this.makeGridRow("LABEL_REASON", this.m_UIReason);
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_2.addChild(_loc_1);
                if (type == Type.REPORT_STATEMENT && reportable is ChannelMessage)
                {
                    _loc_4 = new TextArea();
                    _loc_4.editable = false;
                    _loc_4.percentHeight = 100;
                    _loc_4.percentWidth = 100;
                    _loc_4.text = ChannelMessage(reportable).reportableText;
                    addChild(_loc_4);
                    _loc_1 = this.makeGridRow("LABEL_STATEMENT", _loc_4);
                    _loc_1.percentHeight = 100;
                    _loc_1.percentWidth = 100;
                    _loc_2.addChild(_loc_1);
                }
                if (type == Type.REPORT_NAME || type == Type.REPORT_STATEMENT)
                {
                    this.m_UITranslation = new TextArea();
                    this.m_UITranslation.editable = false;
                    this.m_UITranslation.percentHeight = 100;
                    this.m_UITranslation.percentWidth = 100;
                    _loc_1 = this.makeGridRow("LABEL_TRANSLATION", this.m_UITranslation);
                    _loc_1.percentHeight = 100;
                    _loc_1.percentWidth = 100;
                    _loc_2.addChild(_loc_1);
                }
                this.m_UIComment = new TextArea();
                this.m_UIComment.editable = false;
                this.m_UIComment.percentHeight = 100;
                this.m_UIComment.percentWidth = 100;
                _loc_1 = this.makeGridRow("LABEL_COMMENT", this.m_UIComment);
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_2.addChild(_loc_1);
                addChild(_loc_2);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get comment() : String
        {
            return this.m_Comment;
        }// end function

        public function set translation(param1:String) : void
        {
            if (param1 != null)
            {
                param1 = StringHelper.s_Trim(param1);
                if (param1.length > ReportWidget.MAX_TRANSLATION_LENGTH)
                {
                    throw new ArgumentError("ConfirmView.set translation: Invalid translation.");
                }
            }
            if (this.m_Translation != param1 || param1 == null)
            {
                this.m_Translation = param1;
                this.m_UncommittedTranslation = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function makeGridRow(param1:String, param2:UIComponent) : GridRow
        {
            var _loc_3:* = new GridRow();
            var _loc_4:* = new GridItem();
            var _loc_5:* = new Label();
            _loc_5.percentHeight = NaN;
            _loc_5.percentWidth = 100;
            _loc_5.text = resourceManager.getString(BUNDLE, param1);
            _loc_4.addChild(_loc_5);
            _loc_3.addChild(_loc_4);
            _loc_4 = new GridItem();
            _loc_4.percentHeight = NaN;
            _loc_4.percentWidth = 100;
            _loc_4.addChild(param2);
            _loc_3.addChild(_loc_4);
            return _loc_3;
        }// end function

        override public function get isDataValid() : Boolean
        {
            return true;
        }// end function

        public function get translation() : String
        {
            return this.m_Translation;
        }// end function

        public function set comment(param1:String) : void
        {
            if (param1 != null)
            {
                param1 = StringHelper.s_Trim(param1);
                if (param1.length > ReportWidget.MAX_COMMENT_LENGTH)
                {
                    throw new ArgumentError("ConfirmView.set comment: Invalid comment.");
                }
            }
            if (this.m_Comment != param1 || param1 == null)
            {
                this.m_Comment = param1;
                this.m_UncommittedComment = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}

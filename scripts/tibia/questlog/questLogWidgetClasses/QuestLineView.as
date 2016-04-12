package tibia.questlog.questLogWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.questlog.*;

    public class QuestLineView extends VBox
    {
        protected var m_QuestLine:QuestLine = null;
        private var m_UncommittedQuestLine:Boolean = false;
        protected var m_UIFlagDescription:TextArea = null;
        protected var m_UIFlagList:List = null;
        protected var m_UILineName:Label;
        private var m_UncommittedQuestFlags:Boolean = false;
        protected var m_QuestFlags:Array = null;
        private var m_UIConstructed:Boolean = false;

        public function QuestLineView()
        {
            return;
        }// end function

        public function get questFlags() : Array
        {
            return this.m_QuestFlags;
        }// end function

        public function set questFlags(param1:Array) : void
        {
            if (this.m_QuestFlags != param1)
            {
                this.m_QuestFlags = param1;
                this.m_UncommittedQuestFlags = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get questLine() : QuestLine
        {
            return this.m_QuestLine;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedQuestLine)
            {
                this.m_UILineName.text = this.m_QuestLine != null ? (this.m_QuestLine.name) : (null);
                this.m_UncommittedQuestLine = false;
            }
            if (this.m_UncommittedQuestFlags)
            {
                if (this.m_QuestFlags != null)
                {
                    this.m_QuestFlags.sortOn("name");
                }
                this.m_UIFlagList.dataProvider = this.m_QuestFlags;
                this.m_UIFlagList.selectedIndex = -1;
                this.m_UIFlagDescription.text = null;
                this.m_UncommittedQuestFlags = false;
            }
            return;
        }// end function

        public function get selectedQuestFlag() : QuestFlag
        {
            return this.m_UIFlagList != null ? (QuestFlag(this.m_UIFlagList.selectedItem)) : (null);
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UILineName = new Label();
                this.m_UILineName.percentHeight = NaN;
                this.m_UILineName.percentWidth = 100;
                addChild(this.m_UILineName);
                this.m_UIFlagList = new CustomList();
                this.m_UIFlagList.labelField = "name";
                this.m_UIFlagList.percentHeight = 50;
                this.m_UIFlagList.percentWidth = 100;
                this.m_UIFlagList.selectable = true;
                this.m_UIFlagList.addEventListener(ListEvent.CHANGE, this.onSelectedFlagChange);
                addChild(this.m_UIFlagList);
                this.m_UIFlagDescription = new TextArea();
                this.m_UIFlagDescription.editable = false;
                this.m_UIFlagDescription.percentHeight = 50;
                this.m_UIFlagDescription.percentWidth = 100;
                addChild(this.m_UIFlagDescription);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set selectedQuestFlag(param1:QuestFlag) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.m_UIFlagList != null)
            {
                _loc_2 = -1;
                if (this.m_QuestFlags != null && param1 != null)
                {
                    _loc_3 = this.m_QuestFlags.length - 1;
                    while (_loc_3 >= 0)
                    {
                        
                        if (QuestFlag(this.m_QuestFlags[_loc_3]).name == param1.name)
                        {
                            _loc_2 = _loc_3;
                            break;
                        }
                        _loc_3 = _loc_3 - 1;
                    }
                }
                this.m_UIFlagList.selectedIndex = _loc_2;
            }
            return;
        }// end function

        public function set questLine(param1:QuestLine) : void
        {
            if (this.m_QuestLine != param1)
            {
                this.m_QuestLine = param1;
                this.m_UncommittedQuestLine = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onSelectedFlagChange(event:ListEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null)
            {
                _loc_2 = this.m_UIFlagList.selectedIndex;
                if (this.m_QuestFlags != null && _loc_2 >= 0 && _loc_2 < this.m_QuestFlags.length)
                {
                    this.m_UIFlagDescription.text = QuestFlag(this.m_QuestFlags[_loc_2]).description;
                }
            }
            return;
        }// end function

    }
}

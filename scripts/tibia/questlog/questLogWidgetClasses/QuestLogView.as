package tibia.questlog.questLogWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.questlog.*;

    public class QuestLogView extends VBox
    {
        private var m_UncommittedQuestLines:Boolean = false;
        protected var m_QuestLines:Array = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UILines:List = null;
        private static const BUNDLE:String = "QuestLogWidget";

        public function QuestLogView()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UILines = new CustomList();
                this.m_UILines.doubleClickEnabled = true;
                this.m_UILines.labelFunction = this.getQuestLineLabel;
                this.m_UILines.percentHeight = 100;
                this.m_UILines.percentWidth = 100;
                this.m_UILines.selectable = true;
                this.m_UILines.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.onLineDoubleClick);
                addChild(this.m_UILines);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function onLineDoubleClick(event:ListEvent) : void
        {
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                dispatchEvent(event.clone());
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedQuestLines)
            {
                if (this.m_QuestLines != null)
                {
                    this.m_QuestLines.sortOn("name");
                }
                this.m_UILines.dataProvider = this.m_QuestLines;
                this.m_UILines.selectedIndex = -1;
                this.m_UncommittedQuestLines = false;
            }
            return;
        }// end function

        private function getQuestLineLabel(param1:Object) : String
        {
            var _loc_2:* = param1 as QuestLine;
            if (_loc_2.completed)
            {
                return _loc_2.name + resourceManager.getString(BUNDLE, "QUEST_LINE_COMPLETED_TAG");
            }
            return _loc_2.name;
        }// end function

        public function set selectedQuestLine(param1:QuestLine) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.m_UILines != null)
            {
                _loc_2 = -1;
                if (this.m_QuestLines != null && param1 != null)
                {
                    _loc_3 = this.m_QuestLines.length - 1;
                    while (_loc_3 >= 0)
                    {
                        
                        if (QuestLine(this.m_QuestLines[_loc_3]).ID == param1.ID)
                        {
                            _loc_2 = _loc_3;
                            break;
                        }
                        _loc_3 = _loc_3 - 1;
                    }
                }
                this.m_UILines.selectedIndex = _loc_2;
            }
            return;
        }// end function

        public function set questLines(param1:Array) : void
        {
            if (this.m_QuestLines != param1)
            {
                this.m_QuestLines = param1;
                this.m_UncommittedQuestLines = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get selectedQuestLine() : QuestLine
        {
            return this.m_UILines != null ? (QuestLine(this.m_UILines.selectedItem)) : (null);
        }// end function

        public function get questLines() : Array
        {
            return this.m_QuestLines;
        }// end function

    }
}

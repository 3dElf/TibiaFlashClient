package tibia.prey.preyWidgetClasses
{
    import __AS3__.vec.*;
    import mx.collections.*;
    import mx.core.*;
    import shared.controls.*;

    public class PreyMonsterSelection extends CustomTileList
    {
        private var m_MonsterList:Vector.<PreyMonsterInformation> = null;
        private var m_UncommittedMonsterList:Boolean = false;

        public function PreyMonsterSelection()
        {
            itemRenderer = new ClassFactory();
            columnWidth = this.RENDERER_SIZE;
            rowHeight = this.RENDERER_SIZE;
            var _loc_1:* = 3;
            maxRows = 3;
            maxColumns = _loc_1;
            styleName = "preyMonsterList";
            return;
        }// end function

        public function set monsterList(param1:Vector.<PreyMonsterInformation>) : void
        {
            clearSelected();
            this.m_MonsterList = param1;
            this.m_UncommittedMonsterList = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            super.commitProperties();
            if (this.m_UncommittedMonsterList)
            {
                if (this.m_MonsterList != null)
                {
                    _loc_1 = new Array();
                    _loc_2 = 0;
                    while (_loc_2 < this.m_MonsterList.length)
                    {
                        
                        _loc_1.push(this.m_MonsterList[_loc_2]);
                        _loc_2++;
                    }
                    dataProvider = new ArrayCollection(_loc_1);
                }
                else
                {
                    dataProvider = null;
                }
                this.m_UncommittedMonsterList = false;
            }
            return;
        }// end function

        public function get selectedMonsterIndex() : int
        {
            return selectedIndex;
        }// end function

    }
}

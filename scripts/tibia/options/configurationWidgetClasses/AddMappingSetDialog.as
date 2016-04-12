package tibia.options.configurationWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;

    public class AddMappingSetDialog extends EmbeddedDialog
    {
        private var m_SelectedIndex:int = -1;
        private var m_UncommittedSelectedIndex:Boolean = false;
        private var m_MappingSets:Array = null;
        private var m_UncommittedMappingSets:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_UIMappingSets:ComboBox = null;
        private static const BUNDLE:String = "OptionsConfigurationWidget";

        public function AddMappingSetDialog()
        {
            return;
        }// end function

        private function onSelectMappingSet(event:ListEvent) : void
        {
            this.selectedIndex = ComboBox(event.currentTarget).selectedIndex;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedMappingSets)
            {
                this.m_UIMappingSets.dataProvider = this.m_MappingSets;
                this.m_UncommittedMappingSets = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                this.m_UIMappingSets.selectedIndex = this.m_SelectedIndex;
                this.m_UncommittedSelectedIndex = false;
            }
            return;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            if (this.m_SelectedIndex != param1)
            {
                this.m_SelectedIndex = param1;
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.m_SelectedIndex;
        }// end function

        override protected function createContent(param1:Box) : void
        {
            super.createContent(param1);
            this.m_UIMappingSets = new ComboBox();
            this.m_UIMappingSets.dropdownFactory = new ClassFactory(CustomList);
            this.m_UIMappingSets.labelField = "name";
            this.m_UIMappingSets.addEventListener(ListEvent.CHANGE, this.onSelectMappingSet);
            param1.addChild(this.m_UIMappingSets);
            param1.minHeight = 62;
            param1.setStyle("horizontalAlign", "center");
            return;
        }// end function

        public function set mappingSets(param1:Array) : void
        {
            if (this.m_MappingSets != param1)
            {
                this.m_MappingSets = param1;
                this.m_UncommittedMappingSets = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get mappingSets() : Array
        {
            return this.m_MappingSets;
        }// end function

    }
}

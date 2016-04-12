package tibia.actionbar.configurationWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import tibia.actionbar.configurationWidgetClasses.*;
    import tibia.appearances.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;

    public class ObjectEditor extends VBox implements IActionEditor
    {
        private var m_UncommittedTarget:Boolean = false;
        private var m_Target:int = 0;
        protected var m_UITarget:RadioButtonGroup = null;
        private var m_UncommittedAppearanceData:Boolean = false;
        private var m_AppearanceData:int = 0;
        protected var m_UIConstructed:Boolean = false;
        private var m_UncommittedAppearanceType:Boolean = false;
        private var m_AppearanceType:AppearanceType = null;
        protected var m_UIRootContainer:VBox = null;
        private static const BUNDLE:String = "ActionButtonConfigurationWidget";

        public function ObjectEditor()
        {
            label = resourceManager.getString(BUNDLE, "OBJECT_TITLE");
            return;
        }// end function

        protected function get appearanceType() : AppearanceType
        {
            return this.m_AppearanceType;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = null;
            super.commitProperties();
            if (this.m_UncommittedAppearanceType)
            {
                _loc_1 = this.appearanceType != null && !this.appearanceType.isMultiUse;
                _loc_2 = !_loc_1;
                _loc_3 = this.appearanceType != null && this.appearanceType.isCloth;
                _loc_4 = null;
                this.m_UIRootContainer.removeAllChildren();
                if (_loc_1)
                {
                    _loc_4 = new RadioButton();
                    _loc_4.group = this.m_UITarget;
                    _loc_4.label = resourceManager.getString(BUNDLE, "OBJECT_USE_TARGET_SELF");
                    _loc_4.styleName = this;
                    _loc_4.value = UseAction.TARGET_SELF;
                    this.m_UIRootContainer.addChild(_loc_4);
                }
                if (_loc_2)
                {
                    _loc_4 = new RadioButton();
                    _loc_4.group = this.m_UITarget;
                    _loc_4.label = resourceManager.getString(BUNDLE, "OBJECT_MULTIUSE_TARGET_SELF");
                    _loc_4.styleName = this;
                    _loc_4.value = UseAction.TARGET_SELF;
                    this.m_UIRootContainer.addChild(_loc_4);
                    _loc_4 = new RadioButton();
                    _loc_4.group = this.m_UITarget;
                    _loc_4.label = resourceManager.getString(BUNDLE, "OBJECT_MULTIUSE_TARGET_ATTACK");
                    _loc_4.styleName = this;
                    _loc_4.value = UseAction.TARGET_ATTACK;
                    this.m_UIRootContainer.addChild(_loc_4);
                    _loc_4 = new RadioButton();
                    _loc_4.group = this.m_UITarget;
                    _loc_4.label = resourceManager.getString(BUNDLE, "OBJECT_MULTIUSE_TARGET_CROSSHAIR");
                    _loc_4.styleName = this;
                    _loc_4.value = UseAction.TARGET_CROSSHAIR;
                    this.m_UIRootContainer.addChild(_loc_4);
                }
                if (_loc_3)
                {
                    _loc_4 = new RadioButton();
                    _loc_4.value = EquipAction.TARGET_AUTO;
                    _loc_4.label = resourceManager.getString(BUNDLE, "OBJECT_EQUIP_TARGET_SELF");
                    _loc_4.group = this.m_UITarget;
                    _loc_4.styleName = this;
                    this.m_UIRootContainer.addChild(_loc_4);
                }
                this.m_UncommittedAppearanceType = false;
            }
            if (this.m_UncommittedAppearanceData)
            {
                this.m_UncommittedAppearanceData = false;
            }
            if (this.m_UncommittedTarget)
            {
                this.m_UITarget.selectedValue = this.target;
                this.m_UncommittedTarget = false;
            }
            return;
        }// end function

        protected function get target() : int
        {
            return this.m_Target;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIRootContainer = new VBox();
                this.m_UIRootContainer.percentHeight = 100;
                this.m_UIRootContainer.percentWidth = 100;
                this.m_UIRootContainer.styleName = "actionConfigurationWidgetRootContainer";
                addChild(this.m_UIRootContainer);
                this.m_UITarget = new RadioButtonGroup();
                this.m_UITarget.addEventListener(ItemClickEvent.ITEM_CLICK, this.onTargetChange);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function set appearanceData(param1:int) : void
        {
            if (this.m_AppearanceData != param1)
            {
                this.m_AppearanceData = param1;
                this.m_UncommittedAppearanceData = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function set target(param1:int) : void
        {
            if (this.m_Target != param1)
            {
                this.m_Target = param1;
                this.m_UncommittedTarget = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set action(param1:IAction) : void
        {
            var _loc_2:* = Tibia.s_GetAppearanceStorage();
            if (param1 is UseAction && _loc_2 != null)
            {
                this.appearanceType = UseAction(param1).type;
                this.appearanceData = UseAction(param1).data;
                this.target = UseAction(param1).target;
            }
            else if (param1 is EquipAction && _loc_2 != null)
            {
                this.appearanceType = EquipAction(param1).type;
                this.appearanceData = EquipAction(param1).data;
                this.target = EquipAction.TARGET_AUTO;
            }
            else
            {
                this.appearanceType = null;
                this.appearanceData = 0;
                this.target = UseAction.TARGET_SELF;
            }
            return;
        }// end function

        protected function get appearanceData() : int
        {
            return this.m_AppearanceData;
        }// end function

        private function onTargetChange(event:ItemClickEvent) : void
        {
            this.target = int(this.m_UITarget.selectedValue);
            return;
        }// end function

        protected function set appearanceType(param1:AppearanceType) : void
        {
            if (this.m_AppearanceType != param1)
            {
                this.m_AppearanceType = param1;
                this.m_UncommittedAppearanceType = true;
                invalidateProperties();
                this.appearanceData = 0;
            }
            return;
        }// end function

        public function get action() : IAction
        {
            if (this.appearanceType != null)
            {
                switch(this.target)
                {
                    case UseAction.TARGET_SELF:
                    case UseAction.TARGET_ATTACK:
                    case UseAction.TARGET_CROSSHAIR:
                    {
                        return new UseAction(this.appearanceType.ID, this.appearanceData, this.target);
                    }
                    case EquipAction.TARGET_AUTO:
                    {
                        return new EquipAction(this.appearanceType, this.appearanceData, this.target);
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return null;
        }// end function

    }
}

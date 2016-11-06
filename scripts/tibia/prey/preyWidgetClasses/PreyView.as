package tibia.prey.preyWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.*;
    import shared.utility.i18n.*;
    import tibia.controls.*;
    import tibia.creatures.statusWidgetClasses.*;
    import tibia.game.*;
    import tibia.ingameshop.*;
    import tibia.network.*;
    import tibia.prey.*;

    public class PreyView extends VBox
    {
        private var m_UncommittedMonsterSelection:Boolean = false;
        private var m_UIMonsterSelectionGrid:PreyMonsterSelection = null;
        private var m_UncommittedState:Boolean = false;
        private var m_UncommittedMonster:Boolean = false;
        private var m_UISelectMonsterButton:Button = null;
        private var m_UncommittedResources:Boolean = false;
        private var m_UncommittedBonus:Boolean = false;
        private var m_UIBonusRerollCost:TibiaCurrencyView = null;
        private var m_UIHoverHelp:Text = null;
        private var m_UIPreyActionBox:Box = null;
        private var m_UIListRerollCost:TibiaCurrencyView = null;
        private var m_UIRemainingTimeProgress:BitmapProgressBar = null;
        private var m_UILockedSpacer:Spacer = null;
        private var m_UIMonsterSelectRerollCost:TibiaCurrencyView = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIRerollMonsterListButton:Button = null;
        private var m_UIBonusRerollButton:Button = null;
        private var m_UITitleLabel:Label = null;
        private var m_ParentDialog:PopUpBase = null;
        private var m_UncommittedMonsterList:Boolean = false;
        private var m_UIUnlockWithCoinsButton:Button = null;
        private var m_UIMonsterDisplay:PreyMonsterDisplay = null;
        private var m_UIRerollMonsterListButtonSmall:Button = null;
        private var m_UIFreeRerollTimeSmall:BitmapProgressBar = null;
        private var m_UIUnlockWithPremiumButton:Button = null;
        private var m_UIFreeRerollTime:BitmapProgressBar = null;
        private var m_UIMonsterSelectionActionBox:Box = null;
        private var m_UncommittedTime:Boolean = false;
        private static const BUNDLE:String = "PreyWidget";

        public function PreyView(param1:PopUpBase)
        {
            width = 221;
            height = 420;
            setStyle("horizontalAlign", "center");
            this.m_ParentDialog = param1;
            PreyManager.getInstance().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyManagerDataChanged);
            Tibia.s_GetPlayer().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerDataChanged);
            return;
        }// end function

        protected function updateTitleString() : void
        {
            var _loc_1:* = null;
            _loc_1 = this.prey;
            var _loc_2:* = _loc_1.state == PreyData.STATE_SELECTION || _loc_1.state == PreyData.STATE_SELECTION_CHANGE_MONSTER;
            if (_loc_1.state == PreyData.STATE_INACTIVE && !_loc_2)
            {
                this.m_UITitleLabel.text = resourceManager.getString(BUNDLE, "PREY_STATE_INACTIVE");
            }
            else if (_loc_1.state == PreyData.STATE_ACTIVE)
            {
                this.m_UITitleLabel.text = _loc_1.monster.monsterName;
            }
            else if (_loc_2)
            {
                this.m_UITitleLabel.text = this.m_UIMonsterSelectionGrid.selectedMonsterIndex >= 0 ? (resourceManager.getString(BUNDLE, "PREY_STATE_SELECTED", [_loc_1.monsterList[this.m_UIMonsterSelectionGrid.selectedMonsterIndex].monsterName])) : (resourceManager.getString(BUNDLE, "PREY_STATE_SELECTION"));
            }
            else if (_loc_1.state == PreyData.STATE_LOCKED)
            {
                this.m_UITitleLabel.text = resourceManager.getString(BUNDLE, "PREY_STATE_LOCKED");
            }
            return;
        }// end function

        protected function onRerollBonusClicked(event:MouseEvent) : void
        {
            var _loc_2:* = new EmbeddedDialog();
            _loc_2.title = resourceManager.getString(BUNDLE, "CONFIRM_BONUSREROLL_TITLE");
            if (PreyManager.getInstance().bonusRerollAmount > 1)
            {
                _loc_2.text = resourceManager.getString(BUNDLE, "CONFIRM_BONUSREROLL_TEXT", [PreyManager.getInstance().bonusRerollAmount]);
            }
            else
            {
                _loc_2.text = resourceManager.getString(BUNDLE, "CONFIRM_LAST_BONUSREROLL_TEXT");
            }
            _loc_2.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onRerollBonusConfirmed);
            this.m_ParentDialog.embeddedDialog = _loc_2;
            return;
        }// end function

        public function dispose() : void
        {
            this.data = null;
            PreyManager.getInstance().removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyManagerDataChanged);
            Tibia.s_GetPlayer().removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerDataChanged);
            return;
        }// end function

        protected function onPreyMonsterSelected(event:ListEvent) : void
        {
            this.m_UncommittedMonsterSelection = true;
            invalidateProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UITitleLabel = new Label();
                this.m_UITitleLabel.styleName = "preyTitle";
                this.m_UITitleLabel.percentWidth = 100;
                addChild(this.m_UITitleLabel);
                this.m_UIMonsterSelectionGrid = new PreyMonsterSelection();
                var _loc_4:* = this.m_UIMonsterSelectionGrid.maxColumns * 64 + 3;
                this.m_UIMonsterSelectionGrid.height = this.m_UIMonsterSelectionGrid.maxColumns * 64 + 3;
                this.m_UIMonsterSelectionGrid.width = _loc_4;
                this.m_UIMonsterSelectionGrid.addEventListener(ListEvent.CHANGE, this.onPreyMonsterSelected);
                this.m_UIMonsterSelectionGrid.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIMonsterSelectionGrid.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                addChild(this.m_UIMonsterSelectionGrid);
                this.m_UIMonsterSelectionActionBox = new HBox();
                this.m_UIMonsterSelectionActionBox.percentWidth = 100;
                this.m_UIMonsterSelectionActionBox.styleName = "preyPaddedBox";
                addChild(this.m_UIMonsterSelectionActionBox);
                _loc_1 = new VBox();
                _loc_1.percentWidth = 100;
                this.m_UIMonsterSelectionActionBox.addChild(_loc_1);
                this.m_UIRerollMonsterListButtonSmall = new CustomButton();
                this.m_UIRerollMonsterListButtonSmall.percentWidth = 100;
                this.m_UIRerollMonsterListButtonSmall.height = 33;
                this.m_UIRerollMonsterListButtonSmall.styleName = "preyRerollListButtonSmall";
                this.m_UIRerollMonsterListButtonSmall.addEventListener(MouseEvent.CLICK, this.onRerollMonsterClicked);
                this.m_UIRerollMonsterListButtonSmall.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIRerollMonsterListButtonSmall.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                _loc_1.addChild(this.m_UIRerollMonsterListButtonSmall);
                this.m_UIFreeRerollTimeSmall = new BitmapProgressBar();
                this.m_UIFreeRerollTimeSmall.labelEnabled = true;
                this.m_UIFreeRerollTimeSmall.styleName = "preyDuration";
                this.m_UIFreeRerollTimeSmall.width = 70;
                this.m_UIFreeRerollTimeSmall.height = 22;
                this.m_UIFreeRerollTimeSmall.visible = true;
                this.m_UIFreeRerollTimeSmall.x = 60;
                this.m_UIFreeRerollTimeSmall.y = 6;
                this.m_UIFreeRerollTimeSmall.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIFreeRerollTimeSmall.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                _loc_1.rawChildren.addChild(this.m_UIFreeRerollTimeSmall);
                this.m_UIMonsterSelectRerollCost = new TibiaCurrencyView();
                this.m_UIMonsterSelectRerollCost.percentWidth = 100;
                this.m_UIMonsterSelectRerollCost.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_GOLD_COIN;
                _loc_1.addChild(this.m_UIMonsterSelectRerollCost);
                this.m_UISelectMonsterButton = new CustomButton();
                this.m_UISelectMonsterButton.styleName = "preySelectPreyMonsterButton";
                this.m_UISelectMonsterButton.enabled = false;
                this.m_UISelectMonsterButton.width = 66;
                this.m_UISelectMonsterButton.height = 58;
                this.m_UISelectMonsterButton.addEventListener(MouseEvent.CLICK, this.onPreyMonsterSelectionConfirmed);
                this.m_UISelectMonsterButton.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UISelectMonsterButton.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                this.m_UIMonsterSelectionActionBox.addChild(this.m_UISelectMonsterButton);
                this.m_UIMonsterDisplay = new PreyMonsterDisplay();
                this.m_UIMonsterDisplay.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIMonsterDisplay.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                addChild(this.m_UIMonsterDisplay);
                this.m_UIRemainingTimeProgress = new BitmapProgressBar();
                this.m_UIRemainingTimeProgress.percentWidth = 95;
                this.m_UIRemainingTimeProgress.styleName = "preyDuration";
                this.m_UIRemainingTimeProgress.labelEnabled = true;
                this.m_UIRemainingTimeProgress.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIRemainingTimeProgress.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                addChild(this.m_UIRemainingTimeProgress);
                this.m_UIPreyActionBox = new HBox();
                this.m_UIPreyActionBox.percentWidth = 100;
                this.m_UIPreyActionBox.styleName = "preyPaddedBox";
                addChild(this.m_UIPreyActionBox);
                _loc_2 = new VBox();
                _loc_2.percentWidth = 100;
                this.m_UIPreyActionBox.addChild(_loc_2);
                this.m_UIRerollMonsterListButton = new CustomButton();
                this.m_UIRerollMonsterListButton.percentWidth = 100;
                this.m_UIRerollMonsterListButton.height = 74;
                this.m_UIRerollMonsterListButton.styleName = "preyRerollListButton";
                this.m_UIRerollMonsterListButton.addEventListener(MouseEvent.CLICK, this.onRerollMonsterClicked);
                this.m_UIRerollMonsterListButton.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIRerollMonsterListButton.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                _loc_2.addChild(this.m_UIRerollMonsterListButton);
                this.m_UIFreeRerollTime = new BitmapProgressBar();
                this.m_UIFreeRerollTime.labelEnabled = true;
                this.m_UIFreeRerollTime.styleName = "preyDuration";
                this.m_UIFreeRerollTime.width = 125;
                this.m_UIFreeRerollTime.height = 22;
                this.m_UIFreeRerollTime.visible = true;
                this.m_UIFreeRerollTime.x = 5;
                this.m_UIFreeRerollTime.y = 47;
                this.m_UIFreeRerollTime.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIFreeRerollTime.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                _loc_2.rawChildren.addChild(this.m_UIFreeRerollTime);
                this.m_UIListRerollCost = new TibiaCurrencyView();
                this.m_UIListRerollCost.percentWidth = 100;
                this.m_UIListRerollCost.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_GOLD_COIN;
                _loc_2.addChild(this.m_UIListRerollCost);
                _loc_3 = new VBox();
                this.m_UIPreyActionBox.addChild(_loc_3);
                this.m_UIBonusRerollButton = new CustomButton();
                this.m_UIBonusRerollButton.width = 66;
                this.m_UIBonusRerollButton.height = 74;
                this.m_UIBonusRerollButton.styleName = "preyRerollBonusButton";
                this.m_UIBonusRerollButton.addEventListener(MouseEvent.CLICK, this.onRerollBonusClicked);
                this.m_UIBonusRerollButton.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIBonusRerollButton.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                _loc_3.addChild(this.m_UIBonusRerollButton);
                this.m_UIBonusRerollCost = new TibiaCurrencyView();
                this.m_UIBonusRerollCost.width = this.m_UIBonusRerollButton.width;
                this.m_UIBonusRerollCost.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_BONUS_REROLL;
                _loc_3.addChild(this.m_UIBonusRerollCost);
                this.m_UILockedSpacer = new Spacer();
                this.m_UILockedSpacer.height = 3;
                addChild(this.m_UILockedSpacer);
                this.m_UIUnlockWithCoinsButton = new CustomButton();
                this.m_UIUnlockWithCoinsButton.percentWidth = 95;
                this.m_UIUnlockWithCoinsButton.height = 50;
                this.m_UIUnlockWithCoinsButton.label = resourceManager.getString(BUNDLE, "BUTTON_UNLOCK_PERMANENTLY");
                this.m_UIUnlockWithCoinsButton.styleName = "preyUnlockPermanentlyButton";
                this.m_UIUnlockWithCoinsButton.addEventListener(MouseEvent.CLICK, this.onUnlockPreySlotRequested);
                this.m_UIUnlockWithCoinsButton.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIUnlockWithCoinsButton.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                addChild(this.m_UIUnlockWithCoinsButton);
                this.m_UIUnlockWithPremiumButton = new CustomButton();
                this.m_UIUnlockWithPremiumButton.percentWidth = this.m_UIUnlockWithCoinsButton.percentWidth;
                this.m_UIUnlockWithPremiumButton.height = this.m_UIUnlockWithCoinsButton.height;
                this.m_UIUnlockWithPremiumButton.label = resourceManager.getString(BUNDLE, "BUTTON_UNLOCK_TEMPORARILY");
                this.m_UIUnlockWithPremiumButton.styleName = "preyUnlockTemporarilyButton";
                this.m_UIUnlockWithPremiumButton.addEventListener(MouseEvent.CLICK, this.onUnlockPreySlotRequested);
                this.m_UIUnlockWithPremiumButton.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTextRequested);
                this.m_UIUnlockWithPremiumButton.addEventListener(MouseEvent.MOUSE_OUT, this.onClearHelpTextRequested);
                addChild(this.m_UIUnlockWithPremiumButton);
                this.m_UIHoverHelp = new Text();
                this.m_UIHoverHelp.percentHeight = 100;
                this.m_UIHoverHelp.percentWidth = 100;
                addChild(this.m_UIHoverHelp);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function onPreyPropertyChanged(event:PropertyChangeEvent) : void
        {
            if (event.property == "state")
            {
                this.m_UncommittedState = true;
            }
            else if (event.property == "bonusType" || event.property == "bonusValue")
            {
                this.m_UncommittedBonus = true;
            }
            else if (event.property == "monster")
            {
                this.m_UncommittedMonster = true;
            }
            else if (event.property == "monsterList")
            {
                this.m_UncommittedMonsterList = true;
            }
            else if (event.property == "preyTimeLeft")
            {
                this.m_UncommittedTime = true;
            }
            else if (event.property == "timeUntilFreeListReroll")
            {
                this.m_UncommittedResources = true;
                this.m_UncommittedTime = true;
            }
            invalidateProperties();
            return;
        }// end function

        protected function onRerollMonsterConfirmed(event:CloseEvent) : void
        {
            this.m_ParentDialog.embeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onRerollMonsterConfirmed);
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && this.prey != null && event.detail == EmbeddedDialog.YES)
            {
                _loc_2.sendCPREYACTION(this.prey.id, PreyManager.PREY_ACTION_LISTREROLL, 0);
            }
            return;
        }// end function

        protected function get isInactive() : Boolean
        {
            return this.prey != null && (this.prey.state == PreyData.STATE_INACTIVE || this.prey.state == PreyData.STATE_SELECTION);
        }// end function

        protected function onRerollMonsterClicked(event:MouseEvent) : void
        {
            var _loc_2:* = new EmbeddedDialog();
            _loc_2.title = resourceManager.getString(BUNDLE, "CONFIRM_LISTREROLL_TITLE");
            if (this.prey.timeUntilFreeListReroll > 0)
            {
                _loc_2.text = resourceManager.getString(BUNDLE, "CONFIRM_LISTREROLL_GOLD", [i18nFormatNumber(PreyManager.getInstance().listRerollPrice), i18nFormatNumber(Tibia.s_GetPlayer().bankGoldBalance + Tibia.s_GetPlayer().inventoryGoldBalance)]);
            }
            else
            {
                _loc_2.text = resourceManager.getString(BUNDLE, "CONFIRM_LISTREROLL_FREE");
            }
            _loc_2.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onRerollMonsterConfirmed);
            this.m_ParentDialog.embeddedDialog = _loc_2;
            return;
        }// end function

        protected function get prey() : PreyData
        {
            return data as PreyData;
        }// end function

        protected function onUnlockPreySlotRequested(event:MouseEvent) : void
        {
            var _loc_2:* = IngameShopProduct.SERVICE_TYPE_PREY;
            if (event.currentTarget == this.m_UIUnlockWithPremiumButton)
            {
                _loc_2 = IngameShopProduct.SERVICE_TYPE_PREMIUM;
            }
            IngameShopManager.getInstance().openShopWindow(true, _loc_2);
            return;
        }// end function

        protected function updatePreyBonus() : void
        {
            this.m_UIMonsterDisplay.setBonus(this.prey.bonusType, this.prey.bonusValue);
            return;
        }// end function

        protected function updatePreyState() : void
        {
            var _loc_1:* = null;
            if (contains(this.m_UIMonsterDisplay))
            {
                removeChild(this.m_UIMonsterDisplay);
            }
            if (contains(this.m_UIMonsterSelectionGrid))
            {
                removeChild(this.m_UIMonsterSelectionGrid);
            }
            _loc_1 = this.prey;
            var _loc_2:* = _loc_1.state == PreyData.STATE_SELECTION || _loc_1.state == PreyData.STATE_SELECTION_CHANGE_MONSTER;
            addChildAt(_loc_2 ? (this.m_UIMonsterSelectionGrid) : (this.m_UIMonsterDisplay), 1);
            var _loc_3:* = _loc_2;
            this.m_UIMonsterSelectionActionBox.includeInLayout = _loc_2;
            this.m_UIMonsterSelectionActionBox.visible = _loc_3;
            var _loc_3:* = _loc_1.state != PreyData.STATE_LOCKED && !_loc_2;
            this.m_UIPreyActionBox.includeInLayout = _loc_1.state != PreyData.STATE_LOCKED && !_loc_2;
            this.m_UIPreyActionBox.visible = _loc_3;
            var _loc_3:* = !_loc_2;
            this.m_UIRemainingTimeProgress.includeInLayout = !_loc_2;
            this.m_UIRemainingTimeProgress.visible = _loc_3;
            this.m_UIRemainingTimeProgress.labelEnabled = _loc_1.state != PreyData.STATE_LOCKED && _loc_1.state != PreyData.STATE_INACTIVE;
            var _loc_3:* = _loc_1.state == PreyData.STATE_LOCKED && (_loc_1.unlockOption == PreyData.UNLOCK_PREMIUM_OR_STORE || _loc_1.unlockOption == PreyData.UNLOCK_STORE);
            this.m_UIUnlockWithCoinsButton.includeInLayout = _loc_1.state == PreyData.STATE_LOCKED && (_loc_1.unlockOption == PreyData.UNLOCK_PREMIUM_OR_STORE || _loc_1.unlockOption == PreyData.UNLOCK_STORE);
            this.m_UIUnlockWithCoinsButton.visible = _loc_3;
            this.m_UIUnlockWithPremiumButton.visible = _loc_1.state == PreyData.STATE_LOCKED && _loc_1.unlockOption == PreyData.UNLOCK_PREMIUM_OR_STORE;
            this.m_UIUnlockWithPremiumButton.includeInLayout = _loc_1.state == PreyData.STATE_LOCKED;
            var _loc_3:* = this.m_UIUnlockWithCoinsButton.visible;
            this.m_UILockedSpacer.includeInLayout = this.m_UIUnlockWithCoinsButton.visible;
            this.m_UILockedSpacer.visible = _loc_3;
            this.updateTitleString();
            this.m_UIRerollMonsterListButton.styleName = !this.isInactive ? ("preyRerollListButton") : ("preyRerollListButtonReactivate");
            this.m_UIRerollMonsterListButtonSmall.styleName = !this.isInactive ? ("preyRerollListButtonSmall") : ("preyRerollListButtonReactivateSmall");
            return;
        }// end function

        protected function updateTime() : void
        {
            var _loc_1:* = null;
            _loc_1 = this.prey;
            this.m_UIRemainingTimeProgress.minValue = 0;
            this.m_UIRemainingTimeProgress.maxValue = PreyData.PREY_FULL_DURATION;
            this.m_UIRemainingTimeProgress.value = _loc_1.preyTimeLeft;
            this.m_UIRemainingTimeProgress.labelFormat = StringHelper.s_MillisecondsToTimeString(_loc_1.preyTimeLeft * 60 * 1000, false).slice(0, -3);
            var _loc_2:* = new Date(0, 0, 0, _loc_1.timeUntilFreeListReroll / 60, _loc_1.timeUntilFreeListReroll % 60);
            this.m_UIFreeRerollTime.minValue = 0;
            this.m_UIFreeRerollTime.maxValue = _loc_1.timeUntilFreeListRerollMax;
            this.m_UIFreeRerollTime.value = _loc_1.timeUntilFreeListReroll;
            this.m_UIFreeRerollTime.labelFormat = _loc_1.timeUntilFreeListReroll == 0 ? (resourceManager.getString(BUNDLE, "LIST_REROLL_FREE")) : (i18nFormatTime(_loc_2));
            this.m_UIFreeRerollTimeSmall.minValue = 0;
            this.m_UIFreeRerollTimeSmall.maxValue = _loc_1.timeUntilFreeListRerollMax;
            this.m_UIFreeRerollTimeSmall.value = _loc_1.timeUntilFreeListReroll;
            this.m_UIFreeRerollTimeSmall.labelFormat = _loc_1.timeUntilFreeListReroll == 0 ? (resourceManager.getString(BUNDLE, "LIST_REROLL_FREE_SMALL")) : (i18nFormatTime(_loc_2));
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = this.prey;
            if (_loc_1 != null)
            {
                if (this.m_UncommittedState)
                {
                    this.updatePreyState();
                    this.m_UncommittedState = false;
                }
                if (this.m_UncommittedBonus)
                {
                    this.updatePreyBonus();
                    this.m_UncommittedBonus = false;
                }
                if (this.m_UncommittedMonster)
                {
                    this.updatePreyMonster();
                    this.m_UncommittedMonster = false;
                }
                if (this.m_UncommittedMonsterList)
                {
                    this.updatePreyMonsterList();
                    this.m_UncommittedMonsterList = false;
                }
            }
            if (this.m_UncommittedMonsterSelection)
            {
                this.m_UISelectMonsterButton.enabled = this.m_UIMonsterSelectionGrid.selectedMonsterIndex >= 0;
                this.updateTitleString();
                this.m_UncommittedMonsterSelection = false;
            }
            if (this.m_UncommittedResources)
            {
                this.updateResourceDisplayElements();
                this.m_UncommittedResources = false;
            }
            if (this.m_UncommittedTime)
            {
                if (_loc_1 != null)
                {
                    this.updateTime();
                }
                this.m_UncommittedTime = false;
            }
            return;
        }// end function

        protected function onRerollBonusConfirmed(event:CloseEvent) : void
        {
            this.m_ParentDialog.embeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onRerollBonusConfirmed);
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && this.prey != null && event.detail == EmbeddedDialog.YES)
            {
                _loc_2.sendCPREYACTION(this.prey.id, PreyManager.PREY_ACTION_BONUSREROLL, 0);
            }
            return;
        }// end function

        protected function onPreyManagerDataChanged(event:PropertyChangeEvent) : void
        {
            this.m_UncommittedResources = true;
            invalidateProperties();
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            if (this.prey != null)
            {
                this.prey.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyPropertyChanged);
            }
            super.data = param1;
            if (this.prey != null)
            {
                this.prey.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyPropertyChanged);
            }
            this.m_UncommittedState = true;
            this.m_UncommittedBonus = true;
            this.m_UncommittedMonster = true;
            this.m_UncommittedMonsterList = true;
            this.m_UncommittedResources = true;
            this.m_UncommittedTime = true;
            invalidateProperties();
            return;
        }// end function

        protected function updatePreyMonster() : void
        {
            if (this.prey.monster != null)
            {
                this.m_UIMonsterDisplay.setMonster(this.prey.monster.monsterAppearanceInstance);
            }
            else
            {
                this.m_UIMonsterDisplay.setMonster(null);
            }
            return;
        }// end function

        protected function onHelpTextRequested(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            if (this.prey == null)
            {
                return;
            }
            var _loc_2:* = "";
            if (event.currentTarget == this.m_UIMonsterDisplay || event.currentTarget == this.m_UIRemainingTimeProgress)
            {
                if (this.prey.state == PreyData.STATE_LOCKED)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_PREYDESCRIPTION_LOCKED");
                }
                else if (this.prey.state == PreyData.STATE_INACTIVE)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_PREYDESCRIPTION_INACTIVE");
                }
                else
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_PREYDESCRIPTION", [this.prey.monster.monsterName, StringHelper.s_MillisecondsToTimeString(this.prey.preyTimeLeft * 60 * 1000, false).slice(0, -3), this.prey.bonusValue, this.prey.generateBonusString(), this.prey.generateBonusDescription()]);
                }
            }
            else if (event.currentTarget == this.m_UIUnlockWithCoinsButton)
            {
                _loc_2 = resourceManager.getString(BUNDLE, "HELP_UNLOCK_PERMANENTLY");
            }
            else if (event.currentTarget == this.m_UIUnlockWithPremiumButton)
            {
                _loc_2 = resourceManager.getString(BUNDLE, "HELP_UNLOCK_TEMPORARILY");
            }
            else if (event.currentTarget == this.m_UIMonsterSelectionGrid)
            {
                if (this.isInactive)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_MONSTERSELECTION_REACTIVATE");
                }
                else
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_MONSTERSELECTION_CHANGE", [this.prey.bonusValue, this.prey.generateBonusString()]);
                }
            }
            else if (event.currentTarget == this.m_UIRerollMonsterListButton || event.currentTarget == this.m_UIRerollMonsterListButtonSmall)
            {
                if ((event.currentTarget as Button).enabled)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_LISTREROLL");
                }
                else
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_LISTREROLL_NOTENOUGHGOLD");
                }
            }
            else if (event.currentTarget == this.m_UIFreeRerollTime || event.currentTarget == this.m_UIFreeRerollTimeSmall)
            {
                if (this.prey.timeUntilFreeListReroll == 0)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_LISTREROLL_DURATION_FREE");
                }
                else
                {
                    _loc_3 = new Date(0, 0, 0, this.prey.timeUntilFreeListReroll / 60, this.prey.timeUntilFreeListReroll % 60);
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_LISTREROLL_DURATION_REMAINING", [i18nFormatTime(_loc_3)]);
                }
            }
            else if (event.currentTarget == this.m_UIBonusRerollButton)
            {
                if (this.prey.state == PreyData.STATE_INACTIVE)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_BONUSREROLL_INACTIVE");
                }
                else if ((event.currentTarget as Button).enabled)
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_BONUSREROLL");
                }
                else
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_BONUSREROLL_NOTENOUGHREROLLS");
                }
            }
            else if (event.currentTarget == this.m_UISelectMonsterButton)
            {
                if ((event.currentTarget as Button).enabled)
                {
                    if (!this.isInactive)
                    {
                        _loc_2 = resourceManager.getString(BUNDLE, "HELP_CONFIRMMONSTER_CHANGE", [this.prey.monsterList[this.m_UIMonsterSelectionGrid.selectedMonsterIndex].monsterName, this.prey.bonusValue, this.prey.generateBonusString()]);
                    }
                    else
                    {
                        _loc_2 = resourceManager.getString(BUNDLE, "HELP_CONFIRMMONSTER_REACTIVATE", [this.prey.monsterList[this.m_UIMonsterSelectionGrid.selectedMonsterIndex].monsterName]);
                    }
                }
                else
                {
                    _loc_2 = resourceManager.getString(BUNDLE, "HELP_CONFIRMMONSTER_DISABLED");
                }
            }
            this.m_UIHoverHelp.text = _loc_2;
            return;
        }// end function

        protected function updateResourceDisplayElements() : void
        {
            var _loc_1:* = false;
            _loc_1 = this.prey != null && this.prey.timeUntilFreeListReroll == 0;
            var _loc_2:* = _loc_1 ? (PreyManager.getInstance().listRerollPrice) : (Number.NaN);
            var _loc_3:* = _loc_1 ? (0) : (PreyManager.getInstance().listRerollPrice);
            var _loc_4:* = _loc_3 <= Tibia.s_GetPlayer().bankGoldBalance + Tibia.s_GetPlayer().inventoryGoldBalance;
            this.m_UIRerollMonsterListButtonSmall.enabled = _loc_4;
            this.m_UIMonsterSelectRerollCost.baseCurrency = _loc_2;
            this.m_UIMonsterSelectRerollCost.currentCurrency = _loc_3;
            this.m_UIMonsterSelectRerollCost.notEnoughCurrency = !_loc_4;
            this.m_UIRerollMonsterListButton.enabled = _loc_4;
            this.m_UIListRerollCost.baseCurrency = _loc_2;
            this.m_UIListRerollCost.currentCurrency = _loc_3;
            this.m_UIListRerollCost.notEnoughCurrency = !_loc_4;
            this.m_UIBonusRerollButton.enabled = PreyManager.getInstance().bonusRerollAmount > 0 && (this.prey != null && this.prey.state == PreyData.STATE_ACTIVE);
            this.m_UIBonusRerollCost.currentCurrency = 1;
            this.m_UIBonusRerollCost.notEnoughCurrency = PreyManager.getInstance().bonusRerollAmount == 0;
            return;
        }// end function

        protected function onPlayerDataChanged(event:PropertyChangeEvent) : void
        {
            if (event.property == "*" || event.property == "bankGoldBalance" || event.property == "inventoryGoldBalance")
            {
                this.m_UncommittedResources = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onClearHelpTextRequested(param1) : void
        {
            this.m_UIHoverHelp.text = "";
            return;
        }// end function

        protected function onPreyMonsterSelectionConfirmed(event:MouseEvent) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && this.prey != null)
            {
                _loc_2.sendCPREYACTION(this.prey.id, PreyManager.PREY_ACTION_MONSTERSELECTION, this.m_UIMonsterSelectionGrid.selectedMonsterIndex);
            }
            return;
        }// end function

        protected function updatePreyMonsterList() : void
        {
            if (this.prey.monsterList != null)
            {
                this.m_UIMonsterSelectionGrid.monsterList = this.prey.monsterList;
                this.m_UISelectMonsterButton.enabled = false;
                this.updateTitleString();
            }
            return;
        }// end function

    }
}

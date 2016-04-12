package tibia.trade.npcTradeWidgetClasses
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.network.*;
    import tibia.sidebar.sideBarWidgetClasses.*;
    import tibia.trade.*;

    public class NPCTradeWidgetView extends WidgetView
    {
        protected var m_AppearanceStorage:AppearanceStorage = null;
        protected var m_UILabelWeight:Label = null;
        private var m_UncommittedTradeAmount:Boolean = false;
        private var m_UncommittedCategories:Boolean = false;
        protected var m_UIObjectLayout:Button = null;
        protected var m_Player:Player = null;
        private var m_UncommittedTradeMode:Boolean = false;
        protected var m_NPCName:String = null;
        protected var m_UITradeMode:TabBar = null;
        private var m_CachedPlayerCapacity:Number = 0;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedPlayer:Boolean = false;
        protected var m_Categories:IList = null;
        private var m_InvalidObjectSummary:Boolean = false;
        protected var m_ContainerStorage:ContainerStorage = null;
        private var m_UncommittedAppearanceStorage:Boolean = false;
        protected var m_SellObjects:IList = null;
        protected var m_UIObjectSelector:ObjectRefSelectorBase = null;
        private var m_UncommittedSellObjects:Boolean = false;
        protected var m_UIAmountSelector:AmountSelector = null;
        private var m_UncommittedBuyObjects:Boolean = false;
        protected var m_UIObjectSelectorBox:HBox = null;
        protected var m_TradeMode:int = 0;
        private var m_UncommittedNPCName:Boolean = false;
        protected var m_UICategorySelector:CategorySelector = null;
        protected var m_UILabelCapacity:Label = null;
        protected var m_UIButtonCommit:Button = null;
        protected var m_TradeObject:TradeObjectRef = null;
        protected var m_UILabelBudget:Label = null;
        private var m_InvalidObjectAmounts:Boolean = false;
        protected var m_BuyObjects:IList = null;
        protected var m_TradeAmount:int = 0;
        private var m_UncommittedContainerStorage:Boolean = false;
        private var m_UncommittedTradeObject:Boolean = false;
        protected var m_UILabelPrice:Label = null;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const GUILD_NONE:int = 0;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        static const TYPE_NPC:int = 2;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        private static const UI_TRADE_MODE:Array = [{resource:"TRADE_MODE_BUY", mode:MODE_BUY}, {resource:"TRADE_MODE_SELL", mode:MODE_SELL}];
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        public static const MODE_SELL:int = 1;
        private static const BUNDLE:String = "NPCTradeWidget";
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const STATE_PZ_ENTERED:int = 14;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SUMMON_OWN:int = 1;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const BLESSING_NONE:int = 0;
        static const STATE_FAST:int = 6;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const TYPE_MONSTER:int = 1;
        static const STATE_POISONED:int = 0;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        public static const MODE_BUY:int = 0;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function NPCTradeWidgetView()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            maxHeight = int.MAX_VALUE;
            titleText = this.getTitleLabel();
            return;
        }// end function

        private function getTradeModeLabel(param1:Object) : String
        {
            if (param1 != null)
            {
                return resourceManager.getString(BUNDLE, param1.resource);
            }
            return null;
        }// end function

        function set npcName(param1:String) : void
        {
            if (this.m_NPCName != param1)
            {
                this.m_NPCName = param1;
                this.m_UncommittedNPCName = true;
                invalidateProperties();
            }
            return;
        }// end function

        function get npcName() : String
        {
            return this.m_NPCName;
        }// end function

        function get categories() : IList
        {
            return this.m_Categories;
        }// end function

        private function getMaxSellAmount(param1:TradeObjectRef) : uint
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = 0;
            if (options != null && this.m_ContainerStorage != null && this.m_AppearanceStorage != null && param1 != null)
            {
                _loc_3 = this.m_AppearanceStorage.getObjectType(param1.ID);
                _loc_4 = _loc_3 != null && _loc_3.isCumulative;
                _loc_5 = _loc_3 != null && _loc_3.isLiquidContainer;
                _loc_2 = this.m_ContainerStorage.getAvailableGoods(param1.ID, param1.data);
                if (_loc_2 > 0 && options.npcTradeSellKeepEquipped)
                {
                    _loc_6 = this.m_ContainerStorage.getBodyContainerView();
                    _loc_7 = BodyContainerView.FIRST_SLOT;
                    while (_loc_7 <= BodyContainerView.LAST_SLOT)
                    {
                        
                        _loc_8 = _loc_6.getObject(_loc_7) as ObjectInstance;
                        if (_loc_8 != null && _loc_8.ID == param1.ID && (!_loc_5 || _loc_8.data == param1.data))
                        {
                            _loc_2 = _loc_2 - (_loc_4 ? (_loc_8.data) : (1));
                        }
                        _loc_7++;
                    }
                }
            }
            return Math.max(0, Math.min(_loc_2, NPCTradeWidget.TRADE_MAX_AMOUNT));
        }// end function

        private function updateObjectSummary() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_1:* = 0;
            if (this.m_ContainerStorage != null)
            {
                _loc_1 = this.m_ContainerStorage.getPlayerMoney();
                this.m_UILabelBudget.text = resourceManager.getString(BUNDLE, "LBL_MONEY_FORMAT", [_loc_1.toFixed(0)]);
            }
            else
            {
                this.m_UILabelBudget.text = null;
            }
            var _loc_2:* = NaN;
            if (this.m_Player != null)
            {
                _loc_2 = this.m_Player.getSkillValue(SKILL_CARRYSTRENGTH);
                this.m_UILabelCapacity.text = resourceManager.getString(BUNDLE, "LBL_WEIGHT_FORMAT", [(_loc_2 / 100).toFixed(2)]);
            }
            else
            {
                this.m_UILabelCapacity.text = null;
            }
            var _loc_3:* = this.m_TradeMode == MODE_BUY;
            var _loc_4:* = getStyle("color");
            var _loc_5:* = getStyle("errorColor");
            if (this.m_TradeObject != null)
            {
                _loc_6 = Math.max(1, this.m_TradeAmount);
                _loc_7 = Math.max(1, this.m_TradeObject.amount);
                _loc_8 = 0;
                _loc_9 = 0;
                if (_loc_3 && (options == null || options.npcTradeBuyWithBackpacks))
                {
                    _loc_10 = Tibia.s_GetAppearanceStorage();
                    _loc_11 = null;
                    _loc_12 = _loc_6;
                    var _loc_14:* = _loc_10.getObjectType(this.m_TradeObject.ID);
                    _loc_11 = _loc_10.getObjectType(this.m_TradeObject.ID);
                    if (_loc_10 != null && _loc_14 != null && _loc_11.isCumulative)
                    {
                        _loc_12 = Math.ceil(_loc_6 / 100);
                    }
                    _loc_13 = Math.ceil(_loc_12 / NPCTradeWidget.TRADE_BACKPACK_CAPACITY);
                    _loc_8 = _loc_13 * NPCTradeWidget.TRADE_BACKPACK_PRICE + _loc_6 * this.m_TradeObject.price;
                    _loc_9 = _loc_13 * NPCTradeWidget.TRADE_BACKPACK_WEIGHT + _loc_6 * this.m_TradeObject.weight;
                }
                else
                {
                    _loc_8 = _loc_6 * this.m_TradeObject.price;
                    _loc_9 = _loc_6 * this.m_TradeObject.weight;
                }
                this.m_UIAmountSelector.minimum = 1;
                this.m_UIAmountSelector.maximum = _loc_7;
                this.m_UIAmountSelector.value = _loc_6;
                this.m_UIButtonCommit.enabled = this.m_TradeAmount > 0 && this.m_TradeAmount <= this.m_TradeObject.amount;
                this.m_UIButtonCommit.label = resourceManager.getString(BUNDLE, _loc_3 ? ("TRADE_MODE_BUY") : ("TRADE_MODE_SELL"));
                this.m_UILabelPrice.text = resourceManager.getString(BUNDLE, "LBL_MONEY_FORMAT", [_loc_8]);
                this.m_UILabelPrice.setStyle("color", _loc_3 && _loc_8 > _loc_1 ? (_loc_5) : (_loc_4));
                this.m_UILabelWeight.text = resourceManager.getString(BUNDLE, "LBL_WEIGHT_FORMAT", [(_loc_9 / 100).toFixed(2)]);
                this.m_UILabelWeight.setStyle("color", _loc_3 && _loc_9 > _loc_2 ? (_loc_5) : (_loc_4));
            }
            else
            {
                this.m_UIAmountSelector.minimum = 1;
                this.m_UIAmountSelector.maximum = 1;
                this.m_UIAmountSelector.value = 1;
                this.m_UIButtonCommit.enabled = false;
                this.m_UIButtonCommit.label = resourceManager.getString(BUNDLE, _loc_3 ? ("TRADE_MODE_BUY") : ("TRADE_MODE_SELL"));
                this.m_UILabelPrice.text = null;
                this.m_UILabelPrice.setStyle("color", _loc_4);
                this.m_UILabelWeight.text = null;
                this.m_UILabelWeight.setStyle("color", _loc_4);
            }
            return;
        }// end function

        function get tradeMode() : int
        {
            return this.m_TradeMode;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UICategorySelector = new CategorySelector();
                this.m_UICategorySelector.dataProvider = this.m_Categories;
                this.m_UICategorySelector.height = NaN;
                this.m_UICategorySelector.includeInLayout = this.m_Categories != null;
                this.m_UICategorySelector.visible = this.m_Categories != null;
                this.m_UICategorySelector.width = unscaledInnerWidth;
                this.m_UICategorySelector.setStyle("horizontalAlign", "center");
                addChild(this.m_UICategorySelector);
                this.m_UITradeMode = new TabBar();
                this.m_UITradeMode.dataProvider = UI_TRADE_MODE;
                this.m_UITradeMode.labelFunction = this.getTradeModeLabel;
                this.m_UITradeMode.percentHeight = NaN;
                this.m_UITradeMode.percentWidth = 100;
                this.m_UITradeMode.selectedIndex = this.getTradeModeIndex();
                this.m_UITradeMode.styleName = getStyle("tradeModeTabBarStyle");
                this.m_UITradeMode.addEventListener(ItemClickEvent.ITEM_CLICK, this.onModeChange);
                this.m_UITradeMode.setStyle("tabStyleName", getStyle("tradeModeTabStyle"));
                this.m_UITradeMode.setStyle("tabHeight", getStyle("tradeModeTabHeight"));
                this.m_UITradeMode.setStyle("tabWidth", getStyle("tradeModeTabWidth"));
                _loc_1 = options == null || options.npcTradeLayout == ObjectRefSelectorBase.LAYOUT_GRID;
                this.m_UIObjectLayout = new CustomButton();
                this.m_UIObjectLayout.toggle = true;
                this.m_UIObjectLayout.toolTip = resourceManager.getString(BUNDLE, _loc_1 ? ("LAYOUT_MODE_GRID") : ("LAYOUT_MODE_LIST"));
                this.m_UIObjectLayout.selected = _loc_1;
                this.m_UIObjectLayout.styleName = getStyle("tradeModeLayoutButtonStyle");
                this.m_UIObjectLayout.addEventListener(MouseEvent.CLICK, this.onLayoutChange);
                _loc_2 = new HBox();
                _loc_2.height = 27;
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.width = NaN;
                _loc_2.styleName = getStyle("tradeModeBoxStyle");
                _loc_2.addChild(this.m_UITradeMode);
                _loc_2.addChild(this.m_UIObjectLayout);
                addChild(_loc_2);
                this.m_UIObjectSelectorBox = new HBox();
                this.m_UIObjectSelectorBox.percentHeight = 100;
                this.m_UIObjectSelectorBox.percentWidth = 100;
                this.m_UIObjectSelectorBox.styleName = getStyle("objectBoxStyle");
                addChild(this.m_UIObjectSelectorBox);
                this.updateObjectSelector();
                _loc_2 = new HBox();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.styleName = getStyle("amountBoxStyle");
                this.m_UIAmountSelector = new AmountSelector();
                this.m_UIAmountSelector.minimum = 1;
                this.m_UIAmountSelector.maximum = NPCTradeWidget.TRADE_MAX_AMOUNT;
                this.m_UIAmountSelector.percentHeight = NaN;
                this.m_UIAmountSelector.percentWidth = 100;
                this.m_UIAmountSelector.styleName = getStyle("amountSelectorStyle");
                this.m_UIAmountSelector.addEventListener(Event.CHANGE, this.onAmountChange);
                _loc_2.addChild(this.m_UIAmountSelector);
                addChild(_loc_2);
                _loc_2 = new HBox();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.styleName = getStyle("summaryBoxStyle");
                _loc_3 = new Form();
                _loc_3.percentHeight = 100;
                _loc_3.percentWidth = 100;
                _loc_3.styleName = getStyle("summaryFormStyle");
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(BUNDLE, "LBL_CURRENT_PRICE");
                this.m_UILabelPrice = new Label();
                this.m_UILabelPrice.setStyle("fontWeight", "bold");
                _loc_4.addChild(this.m_UILabelPrice);
                _loc_3.addChild(_loc_4);
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(BUNDLE, "LBL_AVAILABLE_MONEY");
                this.m_UILabelBudget = new Label();
                this.m_UILabelBudget.setStyle("fontWeight", "bold");
                _loc_4.addChild(this.m_UILabelBudget);
                _loc_3.addChild(_loc_4);
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(BUNDLE, "LBL_CURRENT_WEIGHT");
                this.m_UILabelWeight = new Label();
                this.m_UILabelWeight.setStyle("fontWeight", "bold");
                _loc_4.addChild(this.m_UILabelWeight);
                _loc_3.addChild(_loc_4);
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(BUNDLE, "LBL_AVAILABLE_CAPACITY");
                this.m_UILabelCapacity = new Label();
                this.m_UILabelCapacity.setStyle("fontWeight", "bold");
                _loc_4.addChild(this.m_UILabelCapacity);
                _loc_3.addChild(_loc_4);
                _loc_2.addChild(_loc_3);
                addChild(_loc_2);
                _loc_2 = new HBox();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.styleName = getStyle("commitBoxStyle");
                this.m_UIButtonCommit = new CustomButton();
                this.m_UIButtonCommit.label = resourceManager.getString(BUNDLE, this.m_TradeMode == MODE_BUY ? ("TRADE_MODE_BUY") : ("TRADE_MODE_SELL"));
                this.m_UIButtonCommit.percentWidth = 100;
                this.m_UIButtonCommit.addEventListener(MouseEvent.CLICK, this.onButtonCommit);
                _loc_2.addChild(this.m_UIButtonCommit);
                addChild(_loc_2);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        function set categories(param1:IList) : void
        {
            if (this.m_Categories != param1)
            {
                this.m_Categories = param1;
                this.m_UncommittedCategories = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onObjectChange(event:Event) : void
        {
            this.tradeObject = this.m_UIObjectSelector.selectedObject;
            this.tradeAmount = this.tradeMode == MODE_SELL && this.tradeObject != null ? (this.tradeObject.amount) : (1);
            return;
        }// end function

        override protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            super.onOptionsChange(event);
            if (event.property == "npcTradeBuyIgnoreCapacity" || event.property == "npcTradeBuyWithBackpacks" || event.property == "npcTradeSellKeepEquipped" || event.property == "*")
            {
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
            }
            if (event.property == "npcTradeLayout" || event.property == "npcTradeSort" || event.property == "*")
            {
                this.updateObjectSelector();
            }
            return;
        }// end function

        function set buyObjects(param1:IList) : void
        {
            if (this.m_BuyObjects != param1)
            {
                this.m_BuyObjects = param1;
                this.m_UncommittedBuyObjects = true;
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        protected function invalidateObjectAmounts() : void
        {
            this.m_InvalidObjectAmounts = true;
            invalidateProperties();
            return;
        }// end function

        function set tradeMode(param1:int) : void
        {
            if (param1 != MODE_BUY && param1 != MODE_SELL)
            {
                param1 = MODE_BUY;
            }
            if (this.m_TradeMode != param1)
            {
                this.m_TradeMode = param1;
                this.m_UncommittedTradeMode = true;
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitOptions() : void
        {
            super.commitOptions();
            this.invalidateObjectAmounts();
            this.invalidateObjectSummary();
            return;
        }// end function

        function get sellObjects() : IList
        {
            return this.m_SellObjects;
        }// end function

        private function updateObjectSelector() : void
        {
            var _loc_1:* = options != null ? (options.npcTradeLayout) : (ObjectRefSelectorBase.LAYOUT_LIST);
            var _loc_2:* = options != null ? (options.npcTradeSort) : (ObjectRefSelectorBase.SORT_NAME);
            if (this.m_UIObjectSelector != null && this.m_UIObjectSelector.layout != _loc_1)
            {
                this.m_UIObjectSelector.dataProvider = null;
                this.m_UIObjectSelector.removeEventListener(Event.CHANGE, this.onObjectChange);
                this.m_UIObjectSelector = null;
                this.m_UIObjectSelectorBox.removeAllChildren();
            }
            if (this.m_UIObjectSelector == null)
            {
                this.m_UIObjectSelector = ObjectRefSelectorBase.s_Create(_loc_1);
                this.m_UIObjectSelector.percentHeight = 100;
                this.m_UIObjectSelector.percentWidth = 100;
                this.m_UIObjectSelector.styleName = getStyle("objectSelectorStyle");
                this.m_UIObjectSelector.addEventListener(Event.CHANGE, this.onObjectChange);
                this.m_UIObjectSelectorBox.removeAllChildren();
                this.m_UIObjectSelectorBox.addChild(this.m_UIObjectSelector);
            }
            this.m_UIObjectSelector.dataProvider = this.tradeMode == MODE_BUY ? (this.buyObjects) : (this.sellObjects);
            this.m_UIObjectSelector.sortOrder = _loc_2;
            this.m_UIObjectSelector.tradeMode = this.tradeMode;
            return;
        }// end function

        protected function onModeChange(event:ItemClickEvent) : void
        {
            if (event.item != null)
            {
                this.tradeMode = event.item.mode;
            }
            return;
        }// end function

        function set containerStorage(param1:ContainerStorage) : void
        {
            if (this.m_ContainerStorage != param1)
            {
                if (this.m_ContainerStorage != null)
                {
                    this.m_ContainerStorage.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onContainerChange);
                }
                this.m_ContainerStorage = param1;
                if (this.m_ContainerStorage != null)
                {
                    this.m_ContainerStorage.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onContainerChange);
                }
                this.m_UncommittedContainerStorage = true;
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        function get appearanceStorage() : AppearanceStorage
        {
            return this.m_AppearanceStorage;
        }// end function

        private function getTitleLabel() : String
        {
            if (this.m_NPCName != null)
            {
                return resourceManager.getString(BUNDLE, "TITLE_WITH_NAME", [this.m_NPCName]);
            }
            return resourceManager.getString(BUNDLE, "TITLE_NO_NAME");
        }// end function

        protected function onPlayerChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = NaN;
            if (event.property == "skill" || event.property == "*")
            {
                _loc_2 = this.m_Player.getSkillValue(SKILL_CARRYSTRENGTH);
                if (this.m_CachedPlayerCapacity != _loc_2)
                {
                    this.m_CachedPlayerCapacity = _loc_2;
                    this.invalidateObjectAmounts();
                    this.invalidateObjectSummary();
                }
            }
            return;
        }// end function

        protected function onButtonCommit(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = Tibia.s_GetCommunication();
            _loc_2 = Tibia.s_GetCommunication();
            if (options != null && this.tradeObject != null && this.tradeAmount >= 1 && this.tradeAmount <= this.tradeObject.amount && _loc_3 != null && _loc_2.isGameRunning)
            {
                if (this.m_TradeMode == MODE_BUY)
                {
                    _loc_2.sendCBUYOBJECT(this.tradeObject.ID, this.tradeObject.data, this.tradeAmount, options.npcTradeBuyIgnoreCapacity, options.npcTradeBuyWithBackpacks);
                }
                else
                {
                    _loc_2.sendCSELLOBJECT(this.tradeObject.ID, this.tradeObject.data, this.tradeAmount, options.npcTradeSellKeepEquipped);
                }
                this.m_UncommittedTradeObject = true;
                this.m_UncommittedTradeAmount = true;
            }
            return;
        }// end function

        function set tradeObject(param1:TradeObjectRef) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = null;
            var _loc_3:* = this.m_TradeMode == MODE_BUY ? (this.m_BuyObjects) : (this.m_SellObjects);
            if (_loc_3 != null)
            {
                _loc_4 = _loc_3.length - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_5 = TradeObjectRef(_loc_3.getItemAt(_loc_4));
                    if (_loc_5.equals(param1))
                    {
                        _loc_2 = _loc_5;
                        break;
                    }
                    _loc_4 = _loc_4 - 1;
                }
            }
            if ((this.m_TradeObject == null || !this.m_TradeObject.equals(_loc_2)) && (this.m_TradeObject != null || _loc_2 != null))
            {
                this.m_TradeObject = _loc_2;
                this.m_UncommittedTradeObject = true;
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        private function updateObjectAmounts() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = null;
            if (this.buyObjects != null)
            {
                _loc_4 = false;
                _loc_2 = this.buyObjects.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = TradeObjectRef(this.buyObjects.getItemAt(_loc_2));
                    _loc_1 = this.getMaxBuyAmount(_loc_3);
                    _loc_4 = _loc_4 || _loc_3.amount != _loc_1;
                    _loc_3.amount = _loc_1;
                    _loc_2 = _loc_2 - 1;
                }
                if (_loc_4 && this.buyObjects is ICollectionView)
                {
                    _loc_5 = this.m_UIObjectSelector.selectedObject;
                    ICollectionView(this.buyObjects).refresh();
                    if (_loc_5 != null)
                    {
                        this.m_UIObjectSelector.selectedObject = _loc_5;
                    }
                }
            }
            if (this.sellObjects != null)
            {
                _loc_4 = false;
                _loc_2 = this.sellObjects.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = TradeObjectRef(this.sellObjects.getItemAt(_loc_2));
                    _loc_1 = this.getMaxSellAmount(_loc_3);
                    _loc_4 = _loc_4 || _loc_3.amount != _loc_1;
                    _loc_3.amount = _loc_1;
                    _loc_2 = _loc_2 - 1;
                }
                if (_loc_4 && this.sellObjects is ICollectionView)
                {
                    _loc_5 = this.m_UIObjectSelector.selectedObject;
                    ICollectionView(this.sellObjects).refresh();
                    if (_loc_5 != null && _loc_5.amount == 0)
                    {
                        this.tradeObject = null;
                        this.tradeAmount = 0;
                    }
                }
            }
            return;
        }// end function

        protected function onContainerChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "bodyItem" || event.property == "playerGoods" || event.property == "playerMoney")
            {
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
            }
            return;
        }// end function

        protected function onAmountChange(event:Event) : void
        {
            this.tradeAmount = this.m_UIAmountSelector.value;
            return;
        }// end function

        function set tradeAmount(param1:int) : void
        {
            if (this.m_TradeObject != null)
            {
                param1 = Math.max(0, Math.min(param1, this.m_TradeObject.amount));
            }
            else
            {
                param1 = 0;
            }
            if (this.m_TradeAmount != param1)
            {
                this.m_TradeAmount = param1;
                this.m_UncommittedTradeAmount = true;
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        function get containerStorage() : ContainerStorage
        {
            return this.m_ContainerStorage;
        }// end function

        public function releaseInstance() : void
        {
            super.releaseInstance();
            this.m_UITradeMode.removeEventListener(ItemClickEvent.ITEM_CLICK, this.onModeChange);
            this.m_UIObjectLayout.removeEventListener(MouseEvent.CLICK, this.onLayoutChange);
            this.m_UIAmountSelector.removeEventListener(Event.CHANGE, this.onAmountChange);
            this.m_UIButtonCommit.removeEventListener(MouseEvent.CLICK, this.onButtonCommit);
            this.m_UIObjectSelector.removeEventListener(Event.CHANGE, this.onObjectChange);
            return;
        }// end function

        function get buyObjects() : IList
        {
            return this.m_BuyObjects;
        }// end function

        function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                if (this.m_Player != null)
                {
                    this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
                this.m_Player = param1;
                if (this.m_Player != null)
                {
                    this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
                this.m_UncommittedPlayer = true;
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        function get tradeObject() : TradeObjectRef
        {
            return this.m_TradeObject;
        }// end function

        function set sellObjects(param1:IList) : void
        {
            if (this.m_SellObjects != param1)
            {
                this.m_SellObjects = param1;
                this.m_UncommittedSellObjects = true;
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            if (this.m_UncommittedAppearanceStorage)
            {
                this.m_UncommittedAppearanceStorage = false;
            }
            if (this.m_UncommittedContainerStorage)
            {
                this.m_UncommittedContainerStorage = false;
            }
            if (this.m_UncommittedPlayer)
            {
                this.m_UncommittedPlayer = false;
            }
            if (this.m_UncommittedNPCName)
            {
                titleText = this.getTitleLabel();
                this.m_UncommittedNPCName = false;
            }
            if (this.m_UncommittedBuyObjects)
            {
                if (this.m_TradeMode == MODE_BUY)
                {
                    this.tradeAmount = 0;
                    this.tradeObject = null;
                    this.m_UIObjectSelector.dataProvider = this.m_BuyObjects;
                }
                this.m_UncommittedBuyObjects = false;
            }
            if (this.m_UncommittedCategories)
            {
                this.m_UICategorySelector.dataProvider = this.m_Categories;
                this.m_UICategorySelector.includeInLayout = this.m_Categories != null;
                this.m_UICategorySelector.visible = this.m_Categories != null;
                this.m_UncommittedCategories = false;
            }
            if (this.m_UncommittedSellObjects)
            {
                if (this.m_TradeMode != MODE_BUY)
                {
                    this.tradeAmount = 0;
                    this.tradeObject = null;
                    this.m_UIObjectSelector.dataProvider = this.m_SellObjects;
                }
                this.m_UncommittedSellObjects = false;
            }
            if (this.m_UncommittedTradeMode)
            {
                this.tradeAmount = 0;
                this.tradeObject = null;
                this.m_UIObjectSelector.dataProvider = this.tradeMode == MODE_BUY ? (this.m_BuyObjects) : (this.m_SellObjects);
                this.m_UIObjectSelector.tradeMode = this.tradeMode;
                this.m_UITradeMode.selectedIndex = this.getTradeModeIndex();
                this.m_UncommittedTradeMode = false;
            }
            if (this.m_InvalidObjectAmounts)
            {
                this.updateObjectAmounts();
                this.tradeAmount = Math.max(1, this.tradeAmount);
                this.m_InvalidObjectAmounts = false;
            }
            if (this.m_InvalidObjectSummary)
            {
                this.updateObjectSummary();
                this.m_InvalidObjectSummary = false;
            }
            if (this.m_UncommittedTradeAmount)
            {
                this.m_UIAmountSelector.value = this.tradeAmount;
                this.m_UncommittedTradeAmount = false;
            }
            if (this.m_UncommittedTradeObject)
            {
                this.m_UIObjectSelector.selectedObject = this.tradeObject;
                this.m_UncommittedTradeObject = false;
            }
            super.commitProperties();
            return;
        }// end function

        function get tradeAmount() : int
        {
            return this.m_TradeAmount;
        }// end function

        function get player() : Player
        {
            return this.m_Player;
        }// end function

        private function getTradeModeIndex(param1:int = -1) : int
        {
            if (param1 == -1)
            {
                param1 = this.m_TradeMode;
            }
            if (param1 != MODE_BUY && param1 != MODE_SELL)
            {
                param1 = MODE_BUY;
            }
            var _loc_2:* = UI_TRADE_MODE.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (UI_TRADE_MODE[_loc_2].mode == param1)
                {
                    return _loc_2;
                }
                _loc_2 = _loc_2 - 1;
            }
            return 0;
        }// end function

        protected function invalidateObjectSummary() : void
        {
            this.m_InvalidObjectSummary = true;
            invalidateProperties();
            return;
        }// end function

        function set appearanceStorage(param1:AppearanceStorage) : void
        {
            if (this.m_AppearanceStorage != param1)
            {
                this.m_AppearanceStorage = param1;
                this.m_UncommittedAppearanceStorage = true;
                this.invalidateObjectAmounts();
                this.invalidateObjectSummary();
                invalidateProperties();
            }
            return;
        }// end function

        private function getMaxBuyAmount(param1:TradeObjectRef) : uint
        {
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = int.MAX_VALUE;
            if (options != null && this.m_Player != null && this.m_ContainerStorage != null && this.m_AppearanceStorage != null && param1 != null)
            {
                _loc_4 = this.m_AppearanceStorage.getObjectType(param1.ID);
                _loc_5 = _loc_4 != null && _loc_4.isCumulative;
                _loc_6 = this.m_ContainerStorage.getPlayerMoney();
                _loc_7 = this.m_Player.getSkillValue(SKILL_CARRYSTRENGTH);
                if (options.npcTradeBuyWithBackpacks)
                {
                    _loc_8 = NPCTradeWidget.TRADE_BACKPACK_CAPACITY * (_loc_5 ? (100) : (1));
                    _loc_9 = NPCTradeWidget.TRADE_BACKPACK_PRICE + _loc_8 * param1.price;
                    _loc_10 = NPCTradeWidget.TRADE_BACKPACK_WEIGHT + _loc_8 * param1.weight;
                    _loc_2 = Math.floor(_loc_6 / _loc_9);
                    _loc_6 = _loc_6 - (_loc_2 * _loc_9 + NPCTradeWidget.TRADE_BACKPACK_PRICE);
                    _loc_2 = _loc_2 * _loc_8;
                    if (_loc_6 > 0)
                    {
                        _loc_2 = _loc_2 + Math.floor(_loc_6 / param1.price);
                    }
                    if (!options.npcTradeBuyIgnoreCapacity)
                    {
                        _loc_3 = Math.floor(_loc_7 / _loc_10);
                        _loc_7 = _loc_7 - (_loc_3 * _loc_10 + NPCTradeWidget.TRADE_BACKPACK_WEIGHT);
                        _loc_3 = _loc_3 * _loc_8;
                        if (_loc_7 > 0)
                        {
                            _loc_3 = _loc_3 + Math.floor(_loc_7 / param1.weight);
                        }
                    }
                }
                else
                {
                    _loc_2 = Math.floor(_loc_6 / param1.price);
                    if (!options.npcTradeBuyIgnoreCapacity)
                    {
                        _loc_3 = Math.floor(_loc_7 / param1.weight);
                    }
                }
            }
            return Math.max(0, Math.min(_loc_2, _loc_3, NPCTradeWidget.TRADE_MAX_AMOUNT));
        }// end function

        protected function onLayoutChange(event:Event) : void
        {
            if (options != null)
            {
                options.npcTradeLayout = options.npcTradeLayout == ObjectRefSelectorBase.LAYOUT_GRID ? (ObjectRefSelectorBase.LAYOUT_LIST) : (ObjectRefSelectorBase.LAYOUT_GRID);
                this.m_UIObjectLayout.toolTip = resourceManager.getString(BUNDLE, options.npcTradeLayout == ObjectRefSelectorBase.LAYOUT_GRID ? ("LAYOUT_MODE_GRID") : ("LAYOUT_MODE_LIST"));
            }
            return;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.textAlign = "center";
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            Selector;
            Decl = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.horizontalGap = 0;
                this.verticalGap = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}

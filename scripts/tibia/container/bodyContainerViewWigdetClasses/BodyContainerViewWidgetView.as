package tibia.container.bodyContainerViewWigdetClasses
{
    import __AS3__.vec.*;
    import build.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.container.containerViewWidgetClasses.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.help.*;
    import tibia.ingameshop.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.mapping.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class BodyContainerViewWidgetView extends WidgetView implements IUseWidget, IMoveWidget
    {
        private var m_UICapacity:TextField = null;
        private const m_DragHandler:ObjectDragImpl;
        private var m_TriggerExpiryTime:int = 0;
        private var m_UIOpenStoreCancel:Button = null;
        private var m_BodyContainer:BodyContainerView = null;
        private var m_Player:Player = null;
        private var m_UIOpenStoreConfirmText:Label = null;
        private var m_RolloverSlot:ContainerSlot = null;
        private var m_UIOpenStore:Button = null;
        private var m_UIBlessings:Button = null;
        private var m_ConfirmationOpenedTimestamp:uint = 0;
        private var m_UIOpenStoreConfirm:Button = null;
        private var m_UncommittedPlayer:Boolean = false;
        private var m_UIOpenStoreInbox:Button = null;
        private var m_CursorHelper:CursorHelper;
        private var m_UICapacityTooltipOverlay:Box = null;
        private var m_UncommittedBodyContainer:Boolean = false;
        private var m_UIStoreButtonsContainer:HBox = null;
        private static const WIDGET_COMPONENTS:Array = [{slot:-1, left:123, top:140, width:28, height:11, style:null, blessedStyle:null, tooltip:null}, {slot:BodyContainerView.HEAD, left:70, top:2, width:NaN, height:NaN, style:"bodySlotHeadStyle", blessedStyle:"bodySlotHeadBlessedStyle", tooltip:null}, {slot:BodyContainerView.NECK, left:26, top:8, width:NaN, height:NaN, style:"bodySlotNeckStyle", blessedStyle:"bodySlotNeckBlessedStyle", tooltip:null}, {slot:BodyContainerView.BACK, left:114, top:8, width:NaN, height:NaN, style:"bodySlotBackStyle", blessedStyle:"bodySlotBackBlessedStyle", tooltip:null}, {slot:BodyContainerView.TORSO, left:70, top:39, width:NaN, height:NaN, style:"bodySlotTorsoStyle", blessedStyle:"bodySlotTorsoBlessedStyle", tooltip:null}, {slot:BodyContainerView.RIGHT_HAND, left:120, top:53, width:NaN, height:NaN, style:"bodySlotRightHandStyle", blessedStyle:"bodySlotRightHandBlessedStyle", tooltip:null}, {slot:BodyContainerView.LEFT_HAND, left:19, top:54, width:NaN, height:NaN, style:"bodySlotLeftHandStyle", blessedStyle:"bodySlotLeftHandBlessedStyle", tooltip:null}, {slot:BodyContainerView.LEGS, left:70, top:77, width:NaN, height:NaN, style:"bodySlotLegsStyle", blessedStyle:"bodySlotLegsBlessedStyle", tooltip:null}, {slot:BodyContainerView.FEET, left:70, top:115, width:NaN, height:NaN, style:"bodySlotFeetStyle", blessedStyle:"bodySlotFeetBlessedStyle", tooltip:null}, {slot:BodyContainerView.FINGER, left:26, top:99, width:NaN, height:NaN, style:"bodySlotFingerStyle", blessedStyle:"bodySlotFingerBlessedStyle", tooltip:null}, {slot:BodyContainerView.HIP, left:114, top:98, width:NaN, height:NaN, style:"bodySlotHipStyle", blessedStyle:"bodySlotHipBlessedStyle", tooltip:null}, {slot:BodyContainerView.STOREINBOX, left:106, top:0, width:NaN, height:NaN, style:"buttonStoreInboxStyle", blessedStyle:null, tooltip:"TOOLTIP_STOREINBOX"}, {slot:BodyContainerView.STORE, left:0, top:0, width:NaN, height:NaN, style:"buttonIngameShopStyle", blessedStyle:null, tooltip:"TOOLTIP_STORE"}, {slot:BodyContainerView.BLESSINGS, left:2, top:1, width:NaN, height:NaN, style:"bodySlotBlessingStyle", blessedStyle:null, tooltip:null}];
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        private static const ACTION_USE_OR_OPEN:int = 101;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        static const GUILD_NONE:int = 0;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        static const TYPE_NPC:int = 2;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_STAMINA:int = 17;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        private static const WIDGET_VIEW_WIDTH:Number = 176;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        private static const ACTION_ATTACK:int = 1;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        private static const BUNDLE:String = "BodyContainerViewWidget";
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        public static const HIGHLIGHT_TIMEOUT:int = 600000;
        static const BLESSING_BLOOD_OF_THE_MOUNTAIN:int = BLESSING_HEART_OF_THE_MOUNTAIN << 1;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        private static const WIDGET_VIEW_HEIGHT:Number = 179;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const STATE_PZ_ENTERED:int = 14;
        private static const ACTION_OPEN:int = 8;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const BLESSING_HEART_OF_THE_MOUNTAIN:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        private static const ACTION_TALK:int = 9;
        static const SUMMON_OWN:int = 1;
        private static const ACTION_LOOK:int = 6;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        private static const CONFIRMATION_TIMEOUT:int = 30000;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_TWIST_OF_FATE << 1;
        private static const ACTION_SMARTCLICK:int = 100;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_ADVENTURER << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        private static const ACTION_CONTEXT_MENU:int = 5;
        private static const VALID_ACTIONS:Vector.<uint> = BodyContainerViewWidgetView.Vector.<uint>([ACTION_USE, ACTION_OPEN, ACTION_LOOK, ACTION_CONTEXT_MENU]);
        static const BLESSING_NONE:int = 0;
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
        private static const ACTION_NONE:int = 0;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        static const TYPE_MONSTER:int = 1;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        private static const ACTION_UNSET:int = -1;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        private static const ACTION_USE:int = 7;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        private static const ACTION_AUTOWALK:int = 3;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const TYPE_PLAYERSUMMON:int = 3;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_FIRE_OF_SUNS << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function BodyContainerViewWidgetView()
        {
            this.m_DragHandler = ObjectDragImplFactory.s_CreateObjectDragImpl();
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.MEDIUM);
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            Tibia.s_GetInputHandler().addEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            Tibia.s_GetUIEffectsManager().addEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.CURRENTLY_FEATURED_SERVICE_TYPE_CHANGED, this.onCurrentlyFeaturedServiceTypeChanged);
            return;
        }// end function

        private function replaceConfirmationWithButton() : void
        {
            this.m_UIOpenStore.addEventListener(MouseEvent.CLICK, this.onIngameShopClick);
            this.m_UIOpenStoreConfirm.removeEventListener(MouseEvent.CLICK, this.onOpenStoreConfirmButtonClick);
            this.m_UIOpenStoreCancel.removeEventListener(MouseEvent.CLICK, this.onOpenStoreConfirmButtonClick);
            this.m_UIStoreButtonsContainer.removeAllChildren();
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStore);
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStoreInbox);
            invalidateDisplayList();
            invalidateSize();
            return;
        }// end function

        private function onUIEffectsCommandEvent(event:UIEffectsRetrieveComponentCommandEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event.type == UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT && event.identifier == BodyContainerViewWidgetView)
            {
                this.widgetCollapsed = false;
                _loc_2 = event.subIdentifier as int;
                if (_loc_2 == -1)
                {
                    event.resultUIComponent = this;
                }
                else
                {
                    _loc_3 = 0;
                    while (_loc_3 < numChildren)
                    {
                        
                        _loc_4 = BodySlot(getChildAt(_loc_3));
                        if (_loc_4.position == _loc_2)
                        {
                            event.resultUIComponent = _loc_4;
                            break;
                        }
                        _loc_3++;
                    }
                }
            }
            return;
        }// end function

        protected function onSlotRollOver(event:MouseEvent) : void
        {
            this.m_RolloverSlot = event.target as BodySlot;
            this.determineAction(event, false, true);
            return;
        }// end function

        private function onSlotClick(event:MouseEvent) : void
        {
            this.determineAction(event, true, false);
            return;
        }// end function

        private function startStoreButtonHighlighting(param1:int) : void
        {
            this.m_UIOpenStore.selected = true;
            this.m_TriggerExpiryTime = Tibia.s_GetTibiaTimer() + param1;
            return;
        }// end function

        protected function onSecondaryTimer(event:TimerEvent) : void
        {
            var _loc_2:* = Tibia.s_GetTibiaTimer();
            if (this.m_UIOpenStore.selected && this.m_TriggerExpiryTime < _loc_2)
            {
                this.stopStoreButtonHighlighting();
            }
            if (this.m_UIStoreButtonsContainer.contains(this.m_UIStoreButtonsContainer) && this.m_ConfirmationOpenedTimestamp + CONFIRMATION_TIMEOUT < _loc_2)
            {
                this.replaceConfirmationWithButton();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_2:* = null;
            super.createChildren();
            this.m_UICapacity = createInFontContext(TextField) as TextField;
            this.m_UICapacity.autoSize = TextFieldAutoSize.CENTER;
            this.m_UICapacity.defaultTextFormat = this.getCapacityTextFormat();
            this.m_UICapacity.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
            this.m_UICapacity.selectable = false;
            this.m_UICapacity.text = this.getCapacityLabel();
            rawChildren.addChild(this.m_UICapacity);
            this.m_UICapacityTooltipOverlay = new HBox();
            this.m_UICapacityTooltipOverlay.toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_CAPACITY");
            rawChildren.addChild(this.m_UICapacityTooltipOverlay);
            this.m_UIStoreButtonsContainer = new HBox();
            this.m_UIStoreButtonsContainer.setStyle("horizontalGap", 6);
            this.m_UIOpenStore = new CustomButton();
            if (WIDGET_COMPONENTS[BodyContainerView.STORE].style != null)
            {
                this.m_UIOpenStore.styleName = getStyle(WIDGET_COMPONENTS[BodyContainerView.STORE].style);
            }
            if (WIDGET_COMPONENTS[BodyContainerView.STORE].tooltip != null)
            {
                this.m_UIOpenStore.toolTip = resourceManager.getString(BUNDLE, WIDGET_COMPONENTS[BodyContainerView.STORE].tooltip);
            }
            this.m_UIOpenStore.addEventListener(MouseEvent.CLICK, this.onIngameShopClick);
            this.m_UIOpenStore.label = "Store";
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStore);
            this.m_UIOpenStoreInbox = new CustomButton();
            if (WIDGET_COMPONENTS[BodyContainerView.STOREINBOX].style != null)
            {
                this.m_UIOpenStoreInbox.styleName = getStyle(WIDGET_COMPONENTS[BodyContainerView.STOREINBOX].style);
            }
            if (WIDGET_COMPONENTS[BodyContainerView.STOREINBOX].tooltip != null)
            {
                this.m_UIOpenStoreInbox.toolTip = resourceManager.getString(BUNDLE, WIDGET_COMPONENTS[BodyContainerView.STOREINBOX].tooltip);
            }
            this.m_UIOpenStoreInbox.addEventListener(MouseEvent.CLICK, this.onStoreInboxClick);
            this.m_UIOpenStoreInbox.label = "";
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStoreInbox);
            rawChildren.addChild(this.m_UIStoreButtonsContainer);
            this.m_UIBlessings = new CustomButton();
            if (WIDGET_COMPONENTS[BodyContainerView.BLESSINGS].style != null)
            {
                this.m_UIBlessings.styleName = getStyle(WIDGET_COMPONENTS[BodyContainerView.BLESSINGS].style);
            }
            rawChildren.addChild(this.m_UIBlessings);
            var _loc_1:* = BodyContainerView.FIRST_SLOT;
            while (_loc_1 <= BodyContainerView.LAST_SLOT)
            {
                
                if (_loc_1 == BodyContainerView.STORE || _loc_1 == BodyContainerView.STOREINBOX || _loc_1 == BodyContainerView.BLESSINGS)
                {
                }
                else
                {
                    _loc_2 = new BodySlot();
                    _loc_2.appearance = null;
                    _loc_2.position = _loc_1;
                    if (WIDGET_COMPONENTS[_loc_1].style != null)
                    {
                        _loc_2.styleName = getStyle(WIDGET_COMPONENTS[_loc_1].style);
                    }
                    if (WIDGET_COMPONENTS[_loc_1].tooltip != null)
                    {
                        _loc_2.toolTip = resourceManager.getString(BUNDLE, WIDGET_COMPONENTS[_loc_1].tooltip);
                    }
                    _loc_2.addEventListener(MouseEvent.CLICK, this.onSlotClick);
                    _loc_2.addEventListener(MouseEvent.RIGHT_CLICK, this.onSlotClick);
                    _loc_2.addEventListener(MouseEvent.MIDDLE_CLICK, this.onSlotClick);
                    _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.onSlotRollOver);
                    _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.onSlotRollOut);
                    this.m_DragHandler.addDragComponent(_loc_2);
                    addChild(_loc_2);
                }
                _loc_1++;
            }
            this.m_UIOpenStoreConfirmText = new Label();
            this.m_UIOpenStoreConfirmText.text = resourceManager.getString(BUNDLE, "LBL_OPEN_STORE_CONFIRM");
            this.m_UIOpenStoreConfirmText.styleName = "storeConfirmation";
            this.m_UIOpenStoreConfirm = new CustomButton();
            this.m_UIOpenStoreConfirm.label = resourceManager.getString(BUNDLE, "BTN_OPEN_STORE_CONFIRM");
            this.m_UIOpenStoreCancel = new CustomButton();
            this.m_UIOpenStoreCancel.label = resourceManager.getString(BUNDLE, "BTN_OPEN_STORE_CANCEL");
            return;
        }// end function

        public function getUseObjectUnderPoint(param1:Point) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = getClassInstanceUnderPoint(stage, param1, BodySlot);
            _loc_2 = getClassInstanceUnderPoint(stage, param1, BodySlot);
            if (this.bodyContainer != null && _loc_3 != null)
            {
                return {object:_loc_2.appearance, absolute:new Vector3D(65535, _loc_2.position, 0), position:0};
            }
            return null;
        }// end function

        private function getCapacityLabel() : String
        {
            var _loc_1:* = NaN;
            if (this.m_Player != null)
            {
                _loc_1 = this.m_Player.getSkillValue(SKILL_CARRYSTRENGTH);
                return resourceManager.getString(BUNDLE, "LBL_CAPACITY_FORMAT", [Math.round(_loc_1 / 100)]);
            }
            return null;
        }// end function

        public function getMoveObjectUnderPoint(param1:Point) : Object
        {
            return this.getUseObjectUnderPoint(param1);
        }// end function

        private function onBodyContainerChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "objects")
            {
                this.updateSlots();
            }
            return;
        }// end function

        public function pointToMap(param1:Point) : Vector3D
        {
            return null;
        }// end function

        public function releaseInstance() : void
        {
            var _loc_2:* = null;
            super.releaseInstance();
            var _loc_1:* = 0;
            while (_loc_1 < numChildren)
            {
                
                _loc_2 = BodySlot(removeChildAt(_loc_1));
                _loc_2.appearance = null;
                _loc_2.removeEventListener(MouseEvent.CLICK, this.onSlotClick);
                _loc_2.removeEventListener(MouseEvent.RIGHT_CLICK, this.onSlotClick);
                _loc_2.removeEventListener(MouseEvent.MIDDLE_CLICK, this.onSlotClick);
                _loc_2.removeEventListener(MouseEvent.ROLL_OVER, this.onSlotRollOver);
                _loc_2.removeEventListener(MouseEvent.ROLL_OUT, this.onSlotRollOut);
                this.m_DragHandler.removeDragComponent(_loc_2);
                _loc_1++;
            }
            this.m_UIOpenStore.removeEventListener(MouseEvent.CLICK, this.onIngameShopClick);
            this.m_UIOpenStoreInbox.removeEventListener(MouseEvent.CLICK, this.onStoreInboxClick);
            Tibia.s_GetInputHandler().removeEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            Tibia.s_GetUIEffectsManager().removeEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            IngameShopManager.getInstance().removeEventListener(IngameShopEvent.CURRENTLY_FEATURED_SERVICE_TYPE_CHANGED, this.onCurrentlyFeaturedServiceTypeChanged);
            return;
        }// end function

        private function onStoreInboxClick(event:MouseEvent) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = Tibia.s_GetContainerStorage();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = _loc_2.getBodyContainerView();
            _loc_3 = _loc_2.getBodyContainerView();
            var _loc_6:* = _loc_3.getObject(BodyContainerView.STOREINBOX);
            _loc_4 = _loc_3.getObject(BodyContainerView.STOREINBOX);
            if (_loc_2 != null && _loc_6 != null && _loc_6 != null && _loc_4.type != null)
            {
                _loc_5 = new Vector3D(65535, BodyContainerView.STOREINBOX, 0);
                Tibia.s_GameActionFactory.createUseAction(_loc_5, _loc_4.ID, 0, UseActionImpl.TARGET_AUTO).perform();
            }
            return;
        }// end function

        private function replaceButtonWithConfirmation() : void
        {
            this.m_UIOpenStore.removeEventListener(MouseEvent.CLICK, this.onIngameShopClick);
            this.m_UIOpenStoreConfirm.addEventListener(MouseEvent.CLICK, this.onOpenStoreConfirmButtonClick);
            this.m_UIOpenStoreCancel.addEventListener(MouseEvent.CLICK, this.onOpenStoreConfirmButtonClick);
            this.m_UIStoreButtonsContainer.removeAllChildren();
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStoreConfirmText);
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStoreConfirm);
            this.m_UIStoreButtonsContainer.addChild(this.m_UIOpenStoreCancel);
            invalidateDisplayList();
            invalidateSize();
            this.m_ConfirmationOpenedTimestamp = Tibia.s_GetTibiaTimer();
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "capacityFontColor":
                case "capacityFontFamily":
                case "capacityFontSize":
                case "capacityFontStyle":
                case "capacityFontWeight":
                {
                    this.m_UICapacity.defaultTextFormat = this.getCapacityTextFormat();
                    invalidateDisplayList();
                    break;
                }
                default:
                {
                    super.styleChanged(param1);
                    break;
                }
            }
            return;
        }// end function

        public function pointToAbsolute(param1:Point) : Vector3D
        {
            var _loc_2:* = null;
            var _loc_3:* = getClassInstanceUnderPoint(stage, param1, BodySlot);
            _loc_2 = getClassInstanceUnderPoint(stage, param1, BodySlot);
            if (this.bodyContainer != null && _loc_3 != null)
            {
                return new Vector3D(65535, _loc_2.position, 0);
            }
            return null;
        }// end function

        protected function onOpenStoreConfirmButtonClick(event:MouseEvent) : void
        {
            if (event != null && event.target != null)
            {
                if (event.target == this.m_UIOpenStoreConfirm)
                {
                    IngameShopManager.getInstance().openShopWindow(true, IngameShopManager.getInstance().currentlyFeaturedServiceType);
                    this.stopStoreButtonHighlighting();
                }
            }
            this.replaceConfirmationWithButton();
            return;
        }// end function

        private function getCapacityTextFormat() : TextFormat
        {
            var _loc_1:* = getStyle("capacityFontFamily");
            var _loc_2:* = getStyle("capacityFontSize");
            var _loc_3:* = getStyle("capacityFontColor");
            var _loc_4:* = getStyle("capacityFontWeight") === "bold";
            var _loc_5:* = getStyle("capacityFontStyle") === "italic";
            return new TextFormat(_loc_1, _loc_2, _loc_3, _loc_4, _loc_5);
        }// end function

        override protected function commitProperties() : void
        {
            if (this.m_UncommittedBodyContainer)
            {
                this.updateSlots();
                this.m_UncommittedBodyContainer = false;
            }
            super.commitProperties();
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = viewMetricsAndPadding;
            var _loc_2:* = _loc_1.left + WIDGET_VIEW_WIDTH + _loc_1.right;
            measuredWidth = _loc_1.left + WIDGET_VIEW_WIDTH + _loc_1.right;
            measuredMinWidth = _loc_2;
            var _loc_2:* = _loc_1.top + WIDGET_VIEW_HEIGHT + _loc_1.bottom;
            measuredHeight = _loc_1.top + WIDGET_VIEW_HEIGHT + _loc_1.bottom;
            measuredMinHeight = _loc_2;
            return;
        }// end function

        private function stopStoreButtonHighlighting() : void
        {
            this.m_UIOpenStore.selected = false;
            return;
        }// end function

        function get player() : Player
        {
            return this.m_Player;
        }// end function

        protected function onSlotRollOut(event:MouseEvent) : void
        {
            this.m_RolloverSlot = null;
            this.m_CursorHelper.resetCursor();
            return;
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
                this.m_UncommittedPlayer = true;
                invalidateProperties();
                if (this.m_Player != null)
                {
                    this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
            }
            return;
        }// end function

        private function getBlessingTooltip() : String
        {
            var _loc_1:* = new Vector.<String>;
            if (this.m_Player != null)
            {
                if (this.m_Player.hasBlessing(BLESSING_ADVENTURER))
                {
                    _loc_1.push(resourceManager.getString(BUNDLE, "TOOLTIP_BLESSING_ADVENTURER"));
                }
            }
            if (_loc_1.length == 0)
            {
                _loc_1.push(resourceManager.getString(BUNDLE, "TOOLTIP_NO_BLESSINGS"));
            }
            return _loc_1.join("\n");
        }// end function

        protected function determineAction(event:MouseEvent, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_10:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = new Vector3D(0, 0, 0);
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = ACTION_NONE;
            if (m_Options == null)
            {
                return;
            }
            if (event != null)
            {
                _loc_8 = m_Options.mouseMapping.findBindingByMouseEvent(event);
                _loc_4 = event.target as BodySlot;
            }
            else
            {
                _loc_8 = m_Options.mouseMapping.findBindingForLeftMouseButtonAndPressedModifierKey();
                _loc_4 = this.m_RolloverSlot;
            }
            if (_loc_8 != null)
            {
                _loc_9 = _loc_8.action;
            }
            if (_loc_4 == null)
            {
                return;
            }
            _loc_7 = _loc_4.appearance;
            _loc_6 = new Vector3D(65535, _loc_4.position, 0);
            if (_loc_7 != null)
            {
                _loc_9 = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc_9, _loc_7, VALID_ACTIONS);
            }
            else
            {
                _loc_9 = ACTION_NONE;
            }
            if (param3 && m_Options != null && m_Options.mouseMapping != null && m_Options.mouseMapping.showMouseCursorForAction)
            {
                this.m_CursorHelper.setCursor(MouseActionHelper.actionToMouseCursor(_loc_9));
            }
            if (param2)
            {
                switch(_loc_9)
                {
                    case ACTION_USE:
                    case ACTION_OPEN:
                    {
                        Tibia.s_GameActionFactory.createUseAction(_loc_6, _loc_7.type, _loc_6.z, UseActionImpl.TARGET_AUTO).perform();
                        break;
                    }
                    case ACTION_LOOK:
                    {
                        new LookActionImpl(_loc_6, _loc_7.type, _loc_6.z).perform();
                        break;
                    }
                    case ACTION_CONTEXT_MENU:
                    {
                        if (_loc_4.appearance != null)
                        {
                            _loc_10 = {position:_loc_6.z, object:_loc_7};
                            new ObjectContextMenu(_loc_6, _loc_10, _loc_10, null).display(this, event.stageX, event.stageY);
                        }
                        break;
                    }
                    case ACTION_NONE:
                    {
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function getMultiUseObjectUnderPoint(param1:Point) : Object
        {
            return this.getUseObjectUnderPoint(param1);
        }// end function

        private function updateSlots() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = numChildren - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = BodySlot(getChildAt(_loc_1));
                if (this.bodyContainer != null)
                {
                    _loc_2.appearance = this.bodyContainer.getObject(_loc_2.position);
                }
                else
                {
                    _loc_2.appearance = null;
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        private function onPlayerChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "skill" || event.property == "*")
            {
                this.m_UICapacity.text = this.getCapacityLabel();
                invalidateDisplayList();
            }
            else if (event.property == "blessings")
            {
                invalidateDisplayList();
            }
            return;
        }// end function

        private function onModifierKeyEvent(event:ModifierKeyEvent) : void
        {
            this.determineAction(null, false, true);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = !(widgetClosed || widgetCollapsed);
            var _loc_4:* = viewMetricsAndPadding;
            var _loc_10:* = _loc_3;
            this.m_UICapacityTooltipOverlay.visible = _loc_3;
            this.m_UICapacity.visible = _loc_10;
            var _loc_10:* = _loc_4.left + WIDGET_COMPONENTS[0].left;
            this.m_UICapacityTooltipOverlay.x = _loc_4.left + WIDGET_COMPONENTS[0].left;
            this.m_UICapacity.x = _loc_10;
            var _loc_10:* = _loc_4.top + WIDGET_COMPONENTS[0].top - 2;
            this.m_UICapacityTooltipOverlay.y = _loc_4.top + WIDGET_COMPONENTS[0].top - 2;
            this.m_UICapacity.y = _loc_10;
            var _loc_10:* = WIDGET_COMPONENTS[0].width;
            this.m_UICapacityTooltipOverlay.width = WIDGET_COMPONENTS[0].width;
            this.m_UICapacity.width = _loc_10;
            var _loc_10:* = WIDGET_COMPONENTS[0].height;
            this.m_UICapacityTooltipOverlay.height = WIDGET_COMPONENTS[0].height;
            this.m_UICapacity.height = _loc_10;
            this.m_UIStoreButtonsContainer.visible = true;
            this.m_UIStoreButtonsContainer.move(_loc_4.left + 8, _loc_4.top + 156);
            this.m_UIStoreButtonsContainer.setActualSize(this.m_UIStoreButtonsContainer.getExplicitOrMeasuredWidth(), this.m_UIStoreButtonsContainer.getExplicitOrMeasuredHeight());
            this.m_UIOpenStore.visible = _loc_3;
            this.m_UIOpenStore.setActualSize(this.m_UIOpenStore.getExplicitOrMeasuredWidth(), this.m_UIOpenStore.getExplicitOrMeasuredHeight());
            this.m_UIOpenStoreInbox.visible = _loc_3;
            this.m_UIOpenStoreInbox.setActualSize(this.m_UIOpenStoreInbox.getExplicitOrMeasuredWidth(), this.m_UIOpenStoreInbox.getExplicitOrMeasuredHeight());
            this.m_UIOpenStoreConfirmText.width = 79;
            var _loc_5:* = this.m_Player != null && this.m_Player.hasBlessing(BLESSING_ADVENTURER);
            this.m_UIBlessings.visible = _loc_3;
            this.m_UIBlessings.enabled = _loc_5;
            this.m_UIBlessings.toolTip = this.getBlessingTooltip();
            this.m_UIBlessings.move(_loc_4.left + WIDGET_COMPONENTS[BodyContainerView.BLESSINGS].left, _loc_4.top + WIDGET_COMPONENTS[BodyContainerView.BLESSINGS].top);
            this.m_UIBlessings.setActualSize(this.m_UIBlessings.getExplicitOrMeasuredWidth(), this.m_UIBlessings.getExplicitOrMeasuredHeight());
            var _loc_6:* = numChildren - 1;
            while (_loc_6 >= 0)
            {
                
                _loc_7 = BodySlot(getChildAt(_loc_6));
                if (_loc_5 && WIDGET_COMPONENTS[_loc_7.position].blessedStyle != null)
                {
                    _loc_7.styleName = getStyle(WIDGET_COMPONENTS[_loc_7.position].blessedStyle);
                }
                else
                {
                    _loc_7.styleName = getStyle(WIDGET_COMPONENTS[_loc_7.position].style);
                }
                _loc_8 = WIDGET_COMPONENTS[_loc_7.position].width;
                if (isNaN(_loc_8))
                {
                    _loc_8 = _loc_7.getExplicitOrMeasuredWidth();
                }
                _loc_9 = WIDGET_COMPONENTS[_loc_7.position].height;
                if (isNaN(_loc_9))
                {
                    _loc_9 = _loc_7.getExplicitOrMeasuredHeight();
                }
                _loc_7.visible = _loc_3;
                _loc_7.move(WIDGET_COMPONENTS[_loc_7.position].left, WIDGET_COMPONENTS[_loc_7.position].top);
                _loc_7.setActualSize(_loc_8, _loc_9);
                _loc_6 = _loc_6 - 1;
            }
            return;
        }// end function

        protected function onCurrentlyFeaturedServiceTypeChanged(event:IngameShopEvent) : void
        {
            if (IngameShopManager.getInstance().currentlyFeaturedServiceType == IngameShopProduct.SERVICE_TYPE_UNKNOWN)
            {
                this.stopStoreButtonHighlighting();
            }
            else
            {
                this.startStoreButtonHighlighting(HIGHLIGHT_TIMEOUT);
            }
            return;
        }// end function

        private function onIngameShopClick(event:MouseEvent) : void
        {
            if (Tibia.s_GetPlayer().isFighting)
            {
                this.replaceButtonWithConfirmation();
            }
            else
            {
                IngameShopManager.getInstance().openShopWindow(true, IngameShopManager.getInstance().currentlyFeaturedServiceType);
                this.stopStoreButtonHighlighting();
            }
            return;
        }// end function

        function set bodyContainer(param1:BodyContainerView) : void
        {
            if (param1 != this.m_BodyContainer)
            {
                if (this.m_BodyContainer != null)
                {
                    this.m_BodyContainer.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onBodyContainerChange);
                }
                this.m_BodyContainer = param1;
                if (this.m_BodyContainer != null)
                {
                    this.m_BodyContainer.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onBodyContainerChange);
                }
                this.m_UncommittedBodyContainer = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        function get bodyContainer() : BodyContainerView
        {
            return this.m_BodyContainer;
        }// end function

    }
}

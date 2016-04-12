package tibia.creatures.battlelistWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.container.containerViewWidgetClasses.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.help.*;
    import tibia.input.*;
    import tibia.input.mapping.*;
    import tibia.network.*;
    import tibia.options.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class BattlelistWidgetView extends WidgetView implements IUseWidget
    {
        private var m_MouseCursorOverWidget:Boolean = false;
        protected var m_Opponents:IList = null;
        protected var m_CreatureStorage:CreatureStorage = null;
        private var m_CursorHelper:CursorHelper;
        private var m_RolloverCreature:Creature = null;
        protected var m_UIFilterButtons:Vector.<Button>;
        protected var m_UIList:SmoothList = null;
        private var m_UncommittedOpponents:Boolean = false;
        private var m_UncommittedCreatureStorage:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_InvalidFilter:Boolean = false;
        private static const ACTION_UNSET:int = -1;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_USE_OR_OPEN:int = 101;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        private static const ACTION_LOOK:int = 6;
        private static const BUNDLE:String = "BattlelistWidget";
        private static const ACTION_TALK:int = 9;
        private static const VALID_ACTIONS:Vector.<uint> = BattlelistWidgetView.Vector.<uint>([ACTION_ATTACK, ACTION_TALK, ACTION_LOOK, ACTION_CONTEXT_MENU]);
        private static const ACTION_USE:int = 7;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        private static const ACTION_NONE:int = 0;
        private static const ACTION_AUTOWALK:int = 3;
        private static const OPPONENT_FILTER_MODES:Array = [{value:CreatureStorage.FILTER_PLAYER, style:"hidePlayerButtonStyle", tip:"TIP_HIDE_PLAYER"}, {value:CreatureStorage.FILTER_NPC, style:"hideNPCButtonStyle", tip:"TIP_HIDE_NPC"}, {value:CreatureStorage.FILTER_MONSTER, style:"hideMonsterButtonStyle", tip:"TIP_HIDE_MONSTER"}, {value:CreatureStorage.FILTER_NON_SKULLED, style:"hideNonSkulledButtonStyle", tip:"TIP_HIDE_NON_SKULLED"}, {value:CreatureStorage.FILTER_PARTY, style:"hidePartyButtonStyle", tip:"TIP_HIDE_PARTY"}];
        private static const ACTION_ATTACK:int = 1;
        private static const ACTION_OPEN:int = 8;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const ACTION_CONTEXT_MENU:int = 5;
        private static const ACTION_ATTACK_OR_TALK:int = 102;

        public function BattlelistWidgetView()
        {
            this.m_UIFilterButtons = new Vector.<Button>;
            this.m_CursorHelper = new CursorHelper();
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            verticalScrollPolicy = ScrollPolicy.OFF;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            maxHeight = int.MAX_VALUE;
            addEventListener(MouseEvent.CLICK, this.onItemClick);
            addEventListener(MouseEvent.RIGHT_CLICK, this.onItemClick);
            addEventListener(MouseEvent.MIDDLE_CLICK, this.onItemClick);
            Tibia.s_GetUIEffectsManager().addEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            Tibia.s_GetInputHandler().addEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            return;
        }// end function

        public function releaseInstance() : void
        {
            var _loc_1:* = null;
            super.releaseInstance();
            removeEventListener(MouseEvent.CLICK, this.onItemClick);
            removeEventListener(MouseEvent.RIGHT_CLICK, this.onItemClick);
            removeEventListener(MouseEvent.MIDDLE_CLICK, this.onItemClick);
            Tibia.s_GetUIEffectsManager().removeEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            Tibia.s_GetInputHandler().removeEventListener(ModifierKeyEvent.MODIFIER_KEYS_CHANGED, this.onModifierKeyEvent);
            for each (_loc_1 in this.m_UIFilterButtons)
            {
                
                _loc_1.removeEventListener(MouseEvent.CLICK, this.onFilterModeChange);
            }
            this.m_UIList.removeEventListener(ListEvent.ITEM_ROLL_OVER, this.onItemRollOver);
            this.m_UIList.removeEventListener(ListEvent.ITEM_ROLL_OUT, this.onItemRollOut);
            return;
        }// end function

        protected function invalidateFilter() : void
        {
            this.m_InvalidFilter = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedCreatureStorage)
            {
                this.m_UncommittedCreatureStorage = false;
            }
            if (this.m_UncommittedOpponents)
            {
                this.m_UIList.dataProvider = this.m_Opponents;
                this.m_UncommittedOpponents = false;
            }
            if (this.m_InvalidFilter)
            {
                for each (_loc_1 in this.m_UIFilterButtons)
                {
                    
                    _loc_1.selected = m_Options != null && (m_Options.opponentFilter & int(_loc_1.data)) > 0;
                }
                this.m_InvalidFilter = false;
            }
            if (this.m_RolloverCreature != null)
            {
                this.determineAction(null, false, true);
            }
            return;
        }// end function

        public function getMultiUseObjectUnderPoint(param1:Point) : Object
        {
            return this.getUseObjectUnderPoint(param1);
        }// end function

        override protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            super.onOptionsChange(event);
            if (event != null)
            {
                switch(event.property)
                {
                    case "opponentFilter":
                    case "*":
                    {
                        this.invalidateFilter();
                        break;
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

        protected function onItemRollOut(event:ListEvent) : void
        {
            this.m_MouseCursorOverWidget = false;
            this.m_CursorHelper.resetCursor();
            this.m_CreatureStorage.setAim(null);
            this.m_RolloverCreature = null;
            return;
        }// end function

        override protected function commitOptions() : void
        {
            super.commitOptions();
            this.invalidateFilter();
            if (m_Options != null && BattlelistItemRenderer.s_BattlelistMarksView != null)
            {
                BattlelistItemRenderer.s_InitialiseMarksView(m_Options.statusCreaturePvpFrames);
            }
            return;
        }// end function

        public function getUseObjectUnderPoint(param1:Point) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.m_CreatureStorage != null)
            {
                _loc_2 = this.m_CreatureStorage.opponents;
                _loc_3 = this.m_UIList.pointToItemIndex(param1.x, param1.y);
                _loc_4 = Tibia.s_GetAppearanceStorage();
                if (_loc_3 > -1 && _loc_3 < _loc_2.length)
                {
                    _loc_5 = Creature(_loc_2.getItemAt(_loc_3));
                    _loc_6 = _loc_4.createObjectInstance(AppearanceInstance.CREATURE, _loc_5.ID);
                    return {object:_loc_6, absolute:null, position:-1};
                }
            }
            return null;
        }// end function

        protected function determineAction(event:MouseEvent, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            if (this.m_MouseCursorOverWidget == false)
            {
                return;
            }
            var _loc_4:* = null;
            if (event == null)
            {
                _loc_4 = this.m_RolloverCreature;
            }
            else if (!widgetCollapsed && this.m_CreatureStorage != null)
            {
                _loc_11 = this.m_UIList.mouseEventToItemRenderer(event);
                _loc_4 = _loc_11 != null ? (Creature(_loc_11.data)) : (null);
            }
            if (_loc_4 == null)
            {
                return;
            }
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = new Vector3D(0, 0, 0);
            var _loc_8:* = null;
            var _loc_9:* = Tibia.s_GetOptions();
            var _loc_10:* = ACTION_NONE;
            if (_loc_4 != null)
            {
                _loc_12 = null;
                if (event != null)
                {
                    if (event is MouseClickBothEvent)
                    {
                        _loc_12 = _loc_9.mouseMapping.findBindingByMouseEvent(event);
                    }
                    else if (event.type == MouseEvent.CLICK && !event.altKey && !event.ctrlKey && !event.shiftKey)
                    {
                        _loc_10 = ACTION_ATTACK_OR_TALK;
                    }
                    else if (event.type == MouseEvent.RIGHT_CLICK && !event.altKey && !event.ctrlKey && !event.shiftKey)
                    {
                        _loc_10 = ACTION_CONTEXT_MENU;
                    }
                    else
                    {
                        _loc_12 = _loc_9.mouseMapping.findBindingByMouseEvent(event);
                    }
                }
                else
                {
                    _loc_13 = Tibia.s_GetInputHandler();
                    if (_loc_13.isModifierKeyPressed())
                    {
                        _loc_12 = _loc_9.mouseMapping.findBindingForLeftMouseButtonAndPressedModifierKey();
                    }
                    else
                    {
                        _loc_10 = ACTION_ATTACK_OR_TALK;
                    }
                }
                if (_loc_12 != null)
                {
                    _loc_10 = _loc_12.action;
                }
                _loc_10 = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc_10, _loc_4, VALID_ACTIONS);
            }
            if (param3 && m_Options != null && m_Options.mouseMapping != null && m_Options.mouseMapping.showMouseCursorForAction)
            {
                this.m_CursorHelper.setCursor(MouseActionHelper.actionToMouseCursor(_loc_10));
            }
            if (param2)
            {
                switch(_loc_10)
                {
                    case ACTION_NONE:
                    {
                        break;
                    }
                    case ACTION_ATTACK:
                    {
                        if (_loc_4 != null)
                        {
                            Tibia.s_GameActionFactory.createToggleAttackTargetAction(_loc_4, true).perform();
                        }
                        break;
                    }
                    case ACTION_TALK:
                    {
                        if (_loc_4 != null)
                        {
                            Tibia.s_GameActionFactory.createGreetAction(_loc_4).perform();
                        }
                        break;
                    }
                    case ACTION_LOOK:
                    {
                        _loc_14 = null;
                        var _loc_15:* = Tibia.s_GetCommunication();
                        _loc_14 = Tibia.s_GetCommunication();
                        if (_loc_4 != null && _loc_15 != null && _loc_14.isGameRunning)
                        {
                            _loc_14.sendCLOOKATCREATURE(_loc_4.ID);
                        }
                        break;
                    }
                    case ACTION_CONTEXT_MENU:
                    {
                        if (event != null)
                        {
                            new BattlelistItemContextMenu(m_Options, this.m_CreatureStorage, _loc_4).display(this, event.stageX, event.stageY);
                        }
                        break;
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

        protected function onItemClick(event:MouseEvent) : void
        {
            this.determineAction(event, true, false);
            return;
        }// end function

        private function onModifierKeyEvent(event:ModifierKeyEvent) : void
        {
            this.determineAction(null, false, true);
            return;
        }// end function

        protected function onItemRollOver(event:ListEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.m_MouseCursorOverWidget = true;
            if (event != null && event.itemRenderer != null && !widgetCollapsed && this.m_CreatureStorage != null)
            {
                _loc_2 = BattlelistItemRenderer(event.itemRenderer);
                if (_loc_2 != null)
                {
                    _loc_3 = _loc_2.data as Creature;
                    if (_loc_3 != this.m_RolloverCreature)
                    {
                        this.m_CreatureStorage.setAim(_loc_3);
                        this.m_RolloverCreature = _loc_3;
                        this.determineAction(null, false, true);
                    }
                }
            }
            return;
        }// end function

        protected function onFilterModeChange(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (event != null && !widgetCollapsed && event.currentTarget is Button && m_Options != null)
            {
                _loc_2 = Button(event.currentTarget);
                _loc_3 = int(_loc_2.data);
                if (_loc_2.selected)
                {
                    m_Options.opponentFilter = m_Options.opponentFilter | _loc_3;
                }
                else
                {
                    m_Options.opponentFilter = m_Options.opponentFilter & ~_loc_3;
                }
            }
            return;
        }// end function

        function set creatureStorage(param1:CreatureStorage) : void
        {
            if (this.m_CreatureStorage != param1)
            {
                this.m_CreatureStorage = param1;
                this.m_UncommittedCreatureStorage = true;
                if (this.m_CreatureStorage != null)
                {
                    this.m_Opponents = this.m_CreatureStorage.opponents;
                }
                else
                {
                    this.m_Opponents = null;
                }
                this.m_UncommittedOpponents = true;
                invalidateProperties();
            }
            return;
        }// end function

        function get creatureStorage() : CreatureStorage
        {
            return this.m_CreatureStorage;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                _loc_1.height = 27;
                _loc_1.minHeight = 27;
                _loc_1.minWidth = NaN;
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_1.width = NaN;
                _loc_1.styleName = getStyle("headerBoxStyle");
                _loc_2 = 0;
                while (_loc_2 < OPPONENT_FILTER_MODES.length)
                {
                    
                    _loc_3 = new CustomButton();
                    _loc_3.data = OPPONENT_FILTER_MODES[_loc_2].value;
                    _loc_3.selected = m_Options != null && (m_Options.opponentFilter & OPPONENT_FILTER_MODES[_loc_2].value) > 0;
                    _loc_3.styleName = getStyle(OPPONENT_FILTER_MODES[_loc_2].style);
                    _loc_3.toggle = true;
                    _loc_3.toolTip = resourceManager.getString(BUNDLE, OPPONENT_FILTER_MODES[_loc_2].tip);
                    _loc_3.addEventListener(MouseEvent.CLICK, this.onFilterModeChange);
                    this.m_UIFilterButtons.push(_loc_3);
                    _loc_1.addChild(_loc_3);
                    _loc_2++;
                }
                addChild(_loc_1);
                _loc_1 = new HBox();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_1.styleName = getStyle("listBoxStyle");
                this.m_UIList = new SmoothList(BattlelistItemRenderer, BattlelistItemRenderer.HEIGHT_HINT);
                this.m_UIList.name = "Battlelist";
                this.m_UIList.defaultItemCount = 3;
                this.m_UIList.followTailPolicy = SmoothList.FOLLOW_TAIL_OFF;
                this.m_UIList.minItemCount = 3;
                this.m_UIList.percentWidth = 100;
                this.m_UIList.percentHeight = 100;
                this.m_UIList.selectable = false;
                this.m_UIList.styleName = getStyle("listStyle");
                this.m_UIList.addEventListener(ListEvent.ITEM_ROLL_OVER, this.onItemRollOver);
                this.m_UIList.addEventListener(ListEvent.ITEM_ROLL_OUT, this.onItemRollOut);
                _loc_1.addChild(this.m_UIList);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function onUIEffectsCommandEvent(event:UIEffectsRetrieveComponentCommandEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (event.type == UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT && event.identifier == BattlelistWidgetView)
            {
                this.widgetCollapsed = false;
                _loc_2 = event.subIdentifier as Creature;
                _loc_3 = 0;
                while (_loc_3 < this.m_Opponents.length)
                {
                    
                    if (this.m_Opponents[_loc_3] == _loc_2)
                    {
                        event.resultUIComponent = this.m_UIList.itemIndexToItemRenderer(_loc_3) as BattlelistItemRenderer;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public static function s_ClearCreatureCache(param1:String) : void
        {
            if (BattlelistItemRenderer.s_NameCache != null)
            {
                BattlelistItemRenderer.s_NameCache.removeItem(param1);
            }
            return;
        }// end function

    }
}

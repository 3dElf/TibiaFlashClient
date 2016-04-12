package tibia.creatures
{
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.managers.dragClasses.*;
    import mx.resources.*;
    import tibia.controls.*;
    import tibia.creatures.statusWidgetClasses.*;
    import tibia.options.*;

    public class StatusWidget extends Box
    {
        protected var DRAG_SNAP_DISTANCE:int = 100;
        private var m_RealX:Number = 0;
        private var m_RealY:Number = 0;
        private var m_UIState:StateRenderer = null;
        private var m_UIMana:BitmapProgressBar = null;
        protected var m_Player:Player = null;
        private var m_UncommittedStyle:Boolean = true;
        private var m_UncommittedVisible:Boolean = true;
        protected var m_Options:OptionsStorage = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIHitpoints:BitmapProgressBar = null;
        protected var m_Style:int = 1;
        private var m_UncommittedSkill:Boolean = false;
        private var m_UISkill:SkillProgressBar = null;
        private var m_UncommittedOptions:Boolean = false;
        private var m_UncommittedPlayer:Boolean = false;
        protected var m_Skill:int = -1;
        private var m_UncommittedLocation:Boolean = true;
        protected var m_Location:int = 0;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        public static const LOCATION_BOTTOM:int = 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const DRAG_TYPE_CHANNEL:String = "channel";
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
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
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
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        public static const LOCATION_LEFT:int = 2;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const DRAG_TYPE_ACTION:String = "action";
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        public static const DIRECTION_AUTO:String = "a";
        private static const BUNDLE:String = "StatusWidget";
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
        public static const STATUS_STYLE_COMPACT:int = 2;
        public static const STATUS_STYLE_PARALLEL:int = 3;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        public static const LOCATION_RIGHT:int = 3;
        public static const DIRECTION_TOP_TO_BOTTOM:String = "tb";
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SUMMON_OWN:int = 1;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        public static const DIRECTION_BOTTOM_TO_TOP:String = "bt";
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        public static const DIRECTION_RIGHT_TO_LEFT:String = "rl";
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        public static const STATUS_STYLE_FAT:int = 4;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const DRAG_TYPE_OBJECT:String = "object";
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const BLESSING_NONE:int = 0;
        static const STATE_FAST:int = 6;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        public static const DIRECTION_LEFT_TO_RIGHT:String = "lr";
        static const STATE_MANA_SHIELD:int = 4;
        public static const STATUS_STYLE_OFF:int = 0;
        static const SKILL_MANA:int = 5;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        public static const LOCATION_TOP:int = 0;
        static const TYPE_MONSTER:int = 1;
        static const STATE_POISONED:int = 0;
        static const DRAG_TYPE_SPELL:String = "spell";
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
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
        static const DRAG_OPACITY:Number = 0.75;
        public static const STATUS_STYLE_DEFAULT:int = 1;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function StatusWidget()
        {
            mx_internal::layoutObject = new DefaultStatusWidgetStyle();
            clipContent = false;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            addEventListener(MouseEvent.MOUSE_DOWN, this.onDragInit);
            addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseClick);
            return;
        }// end function

        override public function set explicitMinHeight(param1:Number) : void
        {
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            if (this.isHorizontal())
            {
                super.width = param1;
            }
            else
            {
                super.height = param1;
            }
            return;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            if (mx_internal::border is IBorder)
            {
                return IBorder(mx_internal::border).borderMetrics;
            }
            return super.borderMetrics;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            if (direction == DIRECTION_BOTTOM_TO_TOP)
            {
                transform.matrix = new Matrix(0, -1, 1, 0, this.m_RealX, this.m_RealY + param1);
            }
            else if (direction == DIRECTION_TOP_TO_BOTTOM)
            {
                transform.matrix = new Matrix(0, 1, -1, 0, this.m_RealX + param2, this.m_RealY);
            }
            else
            {
                transform.matrix = new Matrix(1, 0, 0, 1, this.m_RealX, this.m_RealY);
            }
            this.m_UIState.transform.matrix = new Matrix();
            super.updateDisplayList(param1, param2);
            if (direction == DIRECTION_BOTTOM_TO_TOP)
            {
                _loc_3 = this.m_UIState.transform.matrix;
                this.m_UIState.transform.matrix = new Matrix(-1, 0, 0, -1, this.m_UIState.getExplicitOrMeasuredWidth() + _loc_3.tx, this.m_UIState.getExplicitOrMeasuredHeight() + _loc_3.ty);
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function set skill(param1:int) : void
        {
            if (this.m_Skill != param1)
            {
                this.m_Skill = param1;
                this.m_UncommittedSkill = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        protected function onDragEvent(event:DragEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_9:* = event.dragSource;
            _loc_2 = event.dragSource;
            var _loc_9:* = event.currentTarget as IUIComponent;
            _loc_3 = event.currentTarget as IUIComponent;
            if (_loc_9 != null && _loc_2.hasFormat("dragType") && _loc_2.dataForFormat("dragType") == DRAG_TYPE_STATUSWIDGET && _loc_9 != null)
            {
                _loc_4 = _loc_3.localToGlobal(new Point(0, 0));
                _loc_5 = new Rectangle(_loc_4.x, _loc_4.y, _loc_3.width / _loc_3.scaleX, _loc_3.height / _loc_3.scaleY);
                _loc_6 = -1;
                if (_loc_5.contains(stage.mouseX, stage.mouseY))
                {
                    if (stage.mouseY < _loc_5.top + this.DRAG_SNAP_DISTANCE)
                    {
                        _loc_6 = LOCATION_TOP;
                    }
                    else if (stage.mouseY > _loc_5.bottom - this.DRAG_SNAP_DISTANCE)
                    {
                        _loc_6 = LOCATION_BOTTOM;
                    }
                    else if (stage.mouseX < _loc_5.left + this.DRAG_SNAP_DISTANCE)
                    {
                        _loc_6 = LOCATION_LEFT;
                    }
                    else if (stage.mouseX > _loc_5.right - this.DRAG_SNAP_DISTANCE)
                    {
                        _loc_6 = LOCATION_RIGHT;
                    }
                }
                switch(event.type)
                {
                    case DragEvent.DRAG_DROP:
                    {
                        if (_loc_6 > -1 && this.m_Location != _loc_6)
                        {
                            this.m_Location = _loc_6;
                            this.m_UncommittedLocation = true;
                            invalidateProperties();
                        }
                        _loc_3.removeEventListener(DragEvent.DRAG_DROP, this.onDragEvent);
                        _loc_3.removeEventListener(DragEvent.DRAG_ENTER, this.onDragEvent);
                        _loc_3.removeEventListener(DragEvent.DRAG_EXIT, this.onDragEvent);
                        _loc_3.removeEventListener(DragEvent.DRAG_OVER, this.onDragEvent);
                        break;
                    }
                    case DragEvent.DRAG_ENTER:
                    {
                        DragManager.acceptDragDrop(_loc_3);
                    }
                    case DragEvent.DRAG_EXIT:
                    case DragEvent.DRAG_OVER:
                    {
                        _loc_7 = mx_internal::dragProxy;
                        _loc_8 = null;
                        var _loc_9:* = _loc_7.getChildAt(0) as IFlexDisplayObject;
                        _loc_8 = _loc_7.getChildAt(0) as IFlexDisplayObject;
                        if (_loc_7 != null && _loc_9 != null)
                        {
                            if (_loc_6 == LOCATION_TOP)
                            {
                                _loc_7.move(_loc_5.left, _loc_5.top);
                                _loc_7.setActualSize(_loc_5.width, unscaledHeight);
                                _loc_8.setActualSize(_loc_5.width, unscaledHeight);
                            }
                            else if (_loc_6 == LOCATION_BOTTOM)
                            {
                                _loc_7.move(_loc_5.left, _loc_5.bottom - unscaledHeight);
                                _loc_7.setActualSize(_loc_5.width, unscaledHeight);
                                _loc_8.setActualSize(_loc_5.width, unscaledHeight);
                            }
                            else if (_loc_6 == LOCATION_LEFT)
                            {
                                _loc_7.move(_loc_5.left, _loc_5.top);
                                _loc_7.setActualSize(unscaledHeight, _loc_5.height);
                                _loc_8.setActualSize(unscaledHeight, _loc_5.height);
                            }
                            else if (_loc_6 == LOCATION_RIGHT)
                            {
                                _loc_7.move(_loc_5.right - unscaledHeight, _loc_5.top);
                                _loc_7.setActualSize(unscaledHeight, _loc_5.height);
                                _loc_8.setActualSize(unscaledHeight, _loc_5.height);
                            }
                            else
                            {
                                _loc_7.setActualSize(unscaledWidth, unscaledHeight);
                                _loc_8.setActualSize(unscaledWidth, unscaledHeight);
                            }
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

        override public function set explicitMaxHeight(param1:Number) : void
        {
            return;
        }// end function

        public function get style() : int
        {
            return this.m_Style;
        }// end function

        override public function set measuredHeight(param1:Number) : void
        {
            if (this.isHorizontal())
            {
                super.measuredHeight = param1;
            }
            else
            {
                super.measuredWidth = param1;
            }
            return;
        }// end function

        public function get location() : int
        {
            return this.m_Location;
        }// end function

        protected function onPlayerChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "skill" || event.property == "*")
            {
                this.updateHitpoints();
                this.updateMana();
            }
            return;
        }// end function

        override public function setActualSize(param1:Number, param2:Number) : void
        {
            if (this.isHorizontal())
            {
                super.setActualSize(param1, param2);
            }
            else
            {
                super.setActualSize(param2, param1);
            }
            return;
        }// end function

        protected function onMouseClick(event:MouseEvent) : void
        {
            new StatusWidgetContextMenu(this.m_Options).display(this, event.stageX, event.stageY);
            return;
        }// end function

        override public function set explicitMaxWidth(param1:Number) : void
        {
            return;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                this.m_UncommittedOptions = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIHitpoints = new BitmapProgressBar();
                this.m_UIHitpoints.labelEnabled = true;
                this.m_UIHitpoints.labelFormat = "{1}/{2}";
                this.m_UIHitpoints.name = "hitpoints";
                this.m_UIHitpoints.percentHeight = NaN;
                this.m_UIHitpoints.percentWidth = 100;
                this.m_UIHitpoints.styleName = getStyle("hitpointsStyle");
                this.m_UIHitpoints.addEventListener(ToolTipEvent.TOOL_TIP_SHOW, this.onTooltipShow);
                this.m_UIHitpoints.toolTip = " ";
                this.updateHitpoints();
                addChild(this.m_UIHitpoints);
                this.m_UIMana = new BitmapProgressBar();
                this.m_UIMana.labelEnabled = true;
                this.m_UIMana.labelFormat = "{1}/{2}";
                this.m_UIMana.name = "mana";
                this.m_UIMana.percentHeight = NaN;
                this.m_UIMana.percentWidth = 100;
                this.m_UIMana.styleName = getStyle("manaStyle");
                this.m_UIMana.addEventListener(ToolTipEvent.TOOL_TIP_SHOW, this.onTooltipShow);
                this.m_UIMana.toolTip = " ";
                this.updateMana();
                addChild(this.m_UIMana);
                this.m_UISkill = new SkillProgressBar();
                this.m_UISkill.name = "skill";
                this.m_UISkill.styleName = getStyle("skillStyle");
                addChild(this.m_UISkill);
                this.m_UIState = new StateRenderer();
                this.m_UIState.maxColumns = int.MAX_VALUE;
                this.m_UIState.maxRows = this.m_Style == STATUS_STYLE_FAT ? (2) : (1);
                this.m_UIState.minColumns = 4;
                this.m_UIState.minRows = 1;
                this.m_UIState.name = "state";
                this.m_UIState.styleName = getStyle("stateStyle");
                addChild(this.m_UIState);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function updateHitpoints() : void
        {
            if (this.m_Player != null)
            {
                this.m_UIHitpoints.maxValue = this.m_Player.hitpointsMax;
                this.m_UIHitpoints.value = this.m_Player.hitpoints;
            }
            else
            {
                this.m_UIHitpoints.maxValue = 100;
                this.m_UIHitpoints.value = 100;
            }
            return;
        }// end function

        private function updateMana() : void
        {
            if (this.m_Player != null)
            {
                this.m_UIMana.maxValue = this.m_Player.manaMax;
                this.m_UIMana.value = this.m_Player.mana;
            }
            else
            {
                this.m_UIMana.maxValue = 100;
                this.m_UIMana.value = 100;
            }
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                if (this.m_Player != null)
                {
                    this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
                this.m_Player = param1;
                this.m_UncommittedPlayer = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
                if (this.m_Player != null)
                {
                    this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            if (this.m_UncommittedPlayer)
            {
                this.m_UISkill.character = this.player;
                this.m_UIState.character = this.player;
                this.updateHitpoints();
                this.updateMana();
                this.m_UncommittedPlayer = false;
            }
            if (this.m_UncommittedOptions)
            {
                if (this.m_Options != null)
                {
                    this.location = this.m_Options.statusWidgetLocation;
                    this.skill = this.m_Options.statusWidgetSkill;
                    this.style = this.m_Options.statusWidgetStyle;
                    this.visible = this.m_Options.statusWidgetVisible;
                }
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedSkill)
            {
                this.m_UISkill.skill = this.skill;
                this.m_UncommittedSkill = false;
            }
            if (this.m_UncommittedStyle)
            {
                switch(this.m_Style)
                {
                    case STATUS_STYLE_DEFAULT:
                    {
                        mx_internal::layoutObject = new DefaultStatusWidgetStyle();
                        styleName = "statusWidgetDefault";
                        break;
                    }
                    case STATUS_STYLE_COMPACT:
                    {
                        mx_internal::layoutObject = new CompactStatusWidgetStyle();
                        styleName = "statusWidgetCompact";
                        break;
                    }
                    case STATUS_STYLE_FAT:
                    {
                        mx_internal::layoutObject = new CompactStatusWidgetStyle();
                        styleName = "statusWidgetFat";
                        break;
                    }
                    case STATUS_STYLE_PARALLEL:
                    {
                        mx_internal::layoutObject = new ParallelStatusWidgetStyle();
                        styleName = "statusWidgetParallel";
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                mx_internal::layoutObject.direction = this.getDirectionFromLocation(this.m_Location);
                mx_internal::layoutObject.target = this;
                this.m_UIHitpoints.styleName = getStyle("hitpointsStyle");
                this.m_UIMana.styleName = getStyle("manaStyle");
                this.m_UISkill.styleName = getStyle("skillStyle");
                this.m_UIState.styleName = getStyle("stateStyle");
                this.m_UIState.maxRows = this.m_Style == STATUS_STYLE_FAT ? (2) : (1);
                if (this.m_Options != null)
                {
                    this.m_Options.statusWidgetStyle = this.m_Style;
                }
                this.m_UncommittedStyle = false;
            }
            if (this.m_UncommittedVisible)
            {
                includeInLayout = visible;
                if (this.m_Options != null)
                {
                    this.m_Options.statusWidgetVisible = visible;
                }
                this.m_UncommittedVisible = false;
            }
            if (this.m_UncommittedLocation)
            {
                _loc_1 = parent as GridContainer;
                if (_loc_1 != null)
                {
                    switch(this.m_Location)
                    {
                        case LOCATION_TOP:
                        {
                            _loc_1.top = this;
                            break;
                        }
                        case LOCATION_BOTTOM:
                        {
                            _loc_1.bottom = this;
                            break;
                        }
                        case LOCATION_LEFT:
                        {
                            _loc_1.left = this;
                            break;
                        }
                        case LOCATION_RIGHT:
                        {
                            _loc_1.right = this;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                if (mx_internal::layoutObject != null)
                {
                    mx_internal::layoutObject.direction = this.getDirectionFromLocation(this.m_Location);
                }
                if (this.m_Options != null)
                {
                    this.m_Options.statusWidgetLocation = this.m_Location;
                }
                this.m_UncommittedLocation = false;
            }
            super.commitProperties();
            return;
        }// end function

        override public function set measuredWidth(param1:Number) : void
        {
            if (this.isHorizontal())
            {
                super.measuredWidth = param1;
            }
            else
            {
                super.measuredHeight = param1;
            }
            return;
        }// end function

        override public function set explicitMinWidth(param1:Number) : void
        {
            return;
        }// end function

        public function get skill() : int
        {
            return this.m_Skill;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (this.isHorizontal())
            {
                super.height = param1;
            }
            else
            {
                super.width = param1;
            }
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            switch(event.property)
            {
                case "statusWidgetLocation":
                {
                    this.location = this.m_Options.statusWidgetLocation;
                    break;
                }
                case "statusWidgetSkill":
                {
                    this.skill = this.m_Options.statusWidgetSkill;
                    break;
                }
                case "statusWidgetStyle":
                {
                    this.style = this.m_Options.statusWidgetStyle;
                    break;
                }
                case "statusWidgetVisible":
                {
                    this.visible = this.m_Options.statusWidgetVisible;
                    break;
                }
                case "*":
                {
                    this.location = this.m_Options.statusWidgetLocation;
                    this.skill = this.m_Options.statusWidgetSkill;
                    this.style = this.m_Options.statusWidgetStyle;
                    this.visible = this.m_Options.statusWidgetVisible;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onTooltipShow(event:ToolTipEvent) : void
        {
            if (event.target == this.m_UIMana)
            {
                event.toolTip.text = this.m_UIMana.value + "/" + this.m_UIMana.maxValue;
            }
            else if (event.target == this.m_UIHitpoints)
            {
                event.toolTip.text = this.m_UIHitpoints.value + "/" + this.m_UIHitpoints.maxValue;
            }
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function set style(param1:int) : void
        {
            if (this.m_Style != param1)
            {
                if (param1 == STATUS_STYLE_COMPACT || param1 == STATUS_STYLE_DEFAULT || param1 == STATUS_STYLE_FAT || param1 == STATUS_STYLE_PARALLEL)
                {
                    this.m_Style = param1;
                    this.m_UncommittedStyle = true;
                    invalidateDisplayList();
                    invalidateProperties();
                    invalidateSize();
                }
                else
                {
                    throw new ArgumentError("StatusWidget.set style: Invalid style: " + param1);
                }
            }
            return;
        }// end function

        protected function onDragInit(event:Event) : void
        {
            var _loc_2:* = null;
            switch(event.type)
            {
                case MouseEvent.MOUSE_DOWN:
                {
                    addEventListener(MouseEvent.MOUSE_MOVE, this.onDragInit);
                    addEventListener(MouseEvent.MOUSE_UP, this.onDragInit);
                    addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onDragInit);
                    break;
                }
                case MouseEvent.MOUSE_MOVE:
                {
                    if (parent != null)
                    {
                        parent.addEventListener(DragEvent.DRAG_DROP, this.onDragEvent);
                        parent.addEventListener(DragEvent.DRAG_ENTER, this.onDragEvent);
                        parent.addEventListener(DragEvent.DRAG_EXIT, this.onDragEvent);
                        parent.addEventListener(DragEvent.DRAG_OVER, this.onDragEvent);
                        _loc_2 = new DragSource();
                        _loc_2.addData(DRAG_TYPE_STATUSWIDGET, "dragType");
                        DragManager.doDrag(this, _loc_2, event as MouseEvent);
                    }
                }
                case MouseEvent.MOUSE_UP:
                case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                {
                    removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragInit);
                    removeEventListener(MouseEvent.MOUSE_UP, this.onDragInit);
                    removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onDragInit);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        override public function set explicitWidth(param1:Number) : void
        {
            return;
        }// end function

        private function getDirectionFromLocation(param1:int) : String
        {
            switch(param1)
            {
                case LOCATION_BOTTOM:
                {
                    return DIRECTION_LEFT_TO_RIGHT;
                }
                case LOCATION_LEFT:
                {
                    return DIRECTION_BOTTOM_TO_TOP;
                }
                case LOCATION_RIGHT:
                {
                    return DIRECTION_TOP_TO_BOTTOM;
                }
                case LOCATION_TOP:
                {
                    return DIRECTION_LEFT_TO_RIGHT;
                }
                default:
                {
                    return null;
                    break;
                }
            }
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            if (this.m_RealX != param1 || this.m_RealY != param2)
            {
                this.m_RealX = param1;
                this.m_RealY = param2;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function set location(param1:int) : void
        {
            if (param1 != LOCATION_TOP && param1 != LOCATION_BOTTOM && param1 != LOCATION_LEFT && param1 != LOCATION_RIGHT)
            {
                throw new ArgumentError("StatusWidget.set location: Invalid location.");
            }
            if (this.m_Location != param1)
            {
                this.m_Location = param1;
                this.m_UncommittedLocation = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override public function set measuredMinHeight(param1:Number) : void
        {
            if (this.isHorizontal())
            {
                super.measuredMinHeight = param1;
            }
            else
            {
                super.measuredMinWidth = param1;
            }
            return;
        }// end function

        private function isHorizontal() : Boolean
        {
            return direction == DIRECTION_LEFT_TO_RIGHT || direction == DIRECTION_RIGHT_TO_LEFT;
        }// end function

        override public function set x(param1:Number) : void
        {
            if (this.m_RealX != param1)
            {
                this.m_RealX = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            if (this.m_RealY != param1)
            {
                this.m_RealY = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        override public function set measuredMinWidth(param1:Number) : void
        {
            if (this.isHorizontal())
            {
                super.measuredMinWidth = param1;
            }
            else
            {
                super.measuredMinHeight = param1;
            }
            return;
        }// end function

        override public function set explicitHeight(param1:Number) : void
        {
            return;
        }// end function

        override public function get x() : Number
        {
            return this.m_RealX;
        }// end function

        override public function get y() : Number
        {
            return this.m_RealY;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (super.visible != param1)
            {
                super.visible = param1;
                this.m_UncommittedVisible = true;
                invalidateProperties();
            }
            return;
        }// end function

        public static function s_GetSkillName(param1:int) : String
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case SKILL_NONE:
                {
                    _loc_2 = "SKILL_NONE";
                    break;
                }
                case SKILL_LEVEL:
                {
                    _loc_2 = "SKILL_LEVEL";
                    break;
                }
                case SKILL_MAGLEVEL:
                {
                    _loc_2 = "SKILL_MAGLEVEL";
                    break;
                }
                case SKILL_FIGHTAXE:
                {
                    _loc_2 = "SKILL_FIGHTAXE";
                    break;
                }
                case SKILL_FIGHTCLUB:
                {
                    _loc_2 = "SKILL_FIGHTCLUB";
                    break;
                }
                case SKILL_FIGHTDISTANCE:
                {
                    _loc_2 = "SKILL_FIGHTDISTANCE";
                    break;
                }
                case SKILL_FIGHTFIST:
                {
                    _loc_2 = "SKILL_FIGHTFIST";
                    break;
                }
                case SKILL_FIGHTSHIELD:
                {
                    _loc_2 = "SKILL_FIGHTSHIELD";
                    break;
                }
                case SKILL_FIGHTSWORD:
                {
                    _loc_2 = "SKILL_FIGHTSWORD";
                    break;
                }
                case SKILL_FISHING:
                {
                    _loc_2 = "SKILL_FISHING";
                    break;
                }
                default:
                {
                    _loc_2 = null;
                    break;
                    break;
                }
            }
            return ResourceManager.getInstance().getString(BUNDLE, _loc_2);
        }// end function

        public static function s_GetStyleName(param1:int) : String
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case STATUS_STYLE_COMPACT:
                {
                    _loc_2 = "STYLE_COMPACT";
                    break;
                }
                case STATUS_STYLE_DEFAULT:
                {
                    _loc_2 = "STYLE_DEFAULT";
                    break;
                }
                case STATUS_STYLE_FAT:
                {
                    _loc_2 = "STYLE_FAT";
                    break;
                }
                case STATUS_STYLE_OFF:
                {
                    _loc_2 = "STYLE_OFF";
                    break;
                }
                case STATUS_STYLE_PARALLEL:
                {
                    _loc_2 = "STYLE_PARALLEL";
                    break;
                }
                default:
                {
                    _loc_2 = null;
                    break;
                    break;
                }
            }
            return ResourceManager.getInstance().getString(BUNDLE, _loc_2);
        }// end function

    }
}

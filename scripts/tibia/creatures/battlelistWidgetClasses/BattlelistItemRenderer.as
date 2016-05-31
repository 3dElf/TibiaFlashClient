package tibia.creatures.battlelistWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.creatures.*;

    public class BattlelistItemRenderer extends UIComponent implements IListItemRenderer, IDataRenderer
    {
        private var m_InvalidHaveTimer:Boolean = false;
        protected var m_HaveTimer:Boolean = false;
        private var m_LocalAppearanceBitmapCache:BitmapData = null;
        protected var m_Data:Creature = null;
        private var m_UncommittedData:Boolean = false;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        public static const CREATURE_ICON_SIZE:int = 24;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        private static const s_TempHealthColor:Colour = new Colour(0, 0, 0);
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
        static const FIELD_HEIGHT:int = 24;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        static const TYPE_NPC:int = 2;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const FIELD_SIZE:int = 32;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static var s_Rect:Rectangle = new Rectangle();
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const GROUND_LAYER:int = 7;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static var s_BattlelistMarksView:MarksView = null;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static var s_Point:Point = new Point();
        public static const HEIGHT_HINT:int = 28;
        static const STATE_PZ_ENTERED:int = 14;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static var s_NameCache:TextFieldCache = new TextFieldCache(192, TextFieldCache.DEFAULT_HEIGHT, NUM_CREATURES, true);
        static const MAP_MIN_X:int = 24576;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        private static var s_ZeroPoint:Point = new Point(0, 0);
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const NUM_EFFECTS:int = 200;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SUMMON_OWN:int = 1;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const UNDERGROUND_LAYER:int = 2;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const FIELD_CACHESIZE:int = 32;
        static const PROFESSION_PALADIN:int = 2;
        static const PLAYER_OFFSET_X:int = 8;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PLAYER_OFFSET_Y:int = 6;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const SKILL_SOULPOINTS:int = 16;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const STATE_FAST:int = 6;
        static const BLESSING_NONE:int = 0;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const NUM_FIELDS:int = 2016;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        static var s_Trans:Matrix = new Matrix(1, 0, 0, 1);
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        static const MAPSIZE_Z:int = 8;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        static const MAPSIZE_Y:int = 14;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const MAPSIZE_X:int = 18;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const MAPSIZE_W:int = 10;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function BattlelistItemRenderer()
        {
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            if (this.m_UncommittedData)
            {
                toolTip = this.m_Data != null ? (this.m_Data.name) : (null);
                this.m_UncommittedData = false;
            }
            if (this.m_InvalidHaveTimer)
            {
                _loc_1 = this.m_Data != null && (this.m_Data.partyFlag != PARTY_NONE || this.m_Data.pkFlag != PK_NONE || this.m_Data.guildFlag != GUILD_NONE || this.m_Data.riskinessFlag != RISKINESS_NONE || this.m_Data.summonFlag != SUMMON_NONE);
                if (_loc_1 && !this.m_HaveTimer)
                {
                    Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onTimer);
                }
                else if (!_loc_1 && this.m_HaveTimer)
                {
                    Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onTimer);
                }
                this.m_HaveTimer = _loc_1;
                this.m_InvalidHaveTimer = false;
            }
            super.commitProperties();
            return;
        }// end function

        protected function invalidateTimer() : void
        {
            this.m_InvalidHaveTimer = true;
            invalidateProperties();
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (param1 == "healthbarHeight" || param1 == "healthbarWidth")
            {
                invalidateSize();
            }
            else
            {
                super.styleChanged(param1);
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            if (param1 == this.m_Data)
            {
                return;
            }
            if (this.m_Data != null)
            {
                this.m_Data.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onDataChange);
            }
            this.m_Data = param1 as Creature;
            this.m_UncommittedData = true;
            invalidateDisplayList();
            invalidateProperties();
            this.invalidateTimer();
            if (this.m_Data != null)
            {
                this.m_Data.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onDataChange, false, EventPriority.DEFAULT, true);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_3:* = NaN;
            super.measure();
            var _loc_1:* = this.viewMetricsAndPadding;
            var _loc_2:* = CREATURE_ICON_SIZE + getStyle("horizontalGap") + Math.max(CreatureStorage.STATE_FLAG_SIZE, s_NameCache.slotWidth, getStyle("healthbarWidth"));
            _loc_3 = Math.max(CREATURE_ICON_SIZE, Math.max(CreatureStorage.STATE_FLAG_SIZE, s_NameCache.slotHeight) + getStyle("verticalGap") + getStyle("healthbarHeight"));
            var _loc_4:* = _loc_1.left + _loc_2 + _loc_1.right;
            measuredWidth = _loc_1.left + _loc_2 + _loc_1.right;
            measuredMinWidth = _loc_4;
            var _loc_4:* = _loc_1.top + _loc_3 + _loc_1.bottom;
            measuredHeight = _loc_1.top + _loc_3 + _loc_1.bottom;
            measuredMinHeight = _loc_4;
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            if (event != null)
            {
                invalidateDisplayList();
            }
            return;
        }// end function

        private function drawCreatureFlag(param1:Graphics, param2:BitmapData, param3:Rectangle, param4:Point) : void
        {
            s_Trans.a = 1;
            s_Trans.d = 1;
            s_Trans.tx = -param3.x + param4.x;
            s_Trans.ty = -param3.y + param4.y;
            param1.beginBitmapFill(param2, s_Trans, false, false);
            param1.drawRect(param4.x, param4.y, param3.width, param3.height);
            return;
        }// end function

        public function get data() : Object
        {
            return this.m_Data;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            super.updateDisplayList(param1, param2);
            graphics.clear();
            graphics.beginFill(65280, 0);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            if (this.m_Data != null)
            {
                _loc_3 = this.viewMetricsAndPadding;
                _loc_4 = _loc_3.left;
                _loc_5 = _loc_3.top;
                _loc_6 = getStyle("horizontalGap");
                _loc_7 = getStyle("verticalGap");
                _loc_8 = param1 - _loc_4 - _loc_3.right;
                _loc_9 = param2 - _loc_3.top - _loc_3.bottom;
                _loc_10 = null;
                if (this.m_Data.marks.areAnyMarksSet(this.Vector.<uint>([Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_TYPE_PERMANENT])))
                {
                    _loc_10 = s_BattlelistMarksView.getMarksBitmap(this.m_Data.marks, s_Rect);
                    s_Trans.a = 1;
                    s_Trans.d = 1;
                    s_Trans.tx = -(s_Rect.x + (s_Rect.width - CREATURE_ICON_SIZE) / 2) + _loc_4;
                    s_Trans.ty = -(s_Rect.y + (s_Rect.height - CREATURE_ICON_SIZE) / 2) + _loc_5;
                    graphics.beginBitmapFill(_loc_10, s_Trans, false, false);
                    graphics.drawRect(_loc_4, _loc_5, CREATURE_ICON_SIZE, CREATURE_ICON_SIZE);
                }
                _loc_11 = this.m_Data.outfit;
                _loc_12 = null;
                var _loc_23:* = _loc_11.getSprite(0, 2, 0, 0);
                _loc_12 = _loc_11.getSprite(0, 2, 0, 0);
                if (_loc_11 != null && _loc_11.ID != OutfitInstance.INVISIBLE_OUTFIT_ID && _loc_11.type != null && _loc_23 != null)
                {
                    if (_loc_12.cacheMiss)
                    {
                        this.invalidateTimer();
                    }
                    if (this.m_LocalAppearanceBitmapCache == null || this.m_LocalAppearanceBitmapCache.width < _loc_12.rectangle.width || this.m_LocalAppearanceBitmapCache.height < _loc_12.rectangle.height)
                    {
                        this.m_LocalAppearanceBitmapCache = new BitmapData(_loc_12.rectangle.width, _loc_12.rectangle.height);
                    }
                    this.m_LocalAppearanceBitmapCache.copyPixels(_loc_12.bitmapData, _loc_12.rectangle, s_ZeroPoint);
                    s_Rect.setTo(0, 0, _loc_12.rectangle.width, _loc_12.rectangle.height);
                    _loc_10 = this.m_LocalAppearanceBitmapCache;
                    _loc_19 = _loc_11.type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize;
                    _loc_20 = Math.min(Math.ceil(Math.sqrt(_loc_19) * CREATURE_ICON_SIZE / Math.sqrt(2 * FIELD_SIZE)), CREATURE_ICON_SIZE);
                    _loc_21 = _loc_20 / _loc_19;
                    _loc_22 = CREATURE_ICON_SIZE - _loc_20;
                    s_Trans.a = _loc_21;
                    s_Trans.d = _loc_21;
                    s_Trans.tx = (-s_Rect.right + _loc_19) * _loc_21 + _loc_4 + _loc_22;
                    s_Trans.ty = (-s_Rect.bottom + _loc_19) * _loc_21 + _loc_5 + _loc_22;
                    graphics.beginBitmapFill(_loc_10, s_Trans, false, false);
                    graphics.drawRect(_loc_4 + _loc_22, _loc_5 + _loc_22, _loc_20, _loc_20);
                    graphics.endFill();
                }
                _loc_4 = _loc_4 + (CREATURE_ICON_SIZE + _loc_6);
                _loc_8 = param1 - _loc_4 - _loc_3.right;
                _loc_13 = Math.floor(_loc_8);
                _loc_14 = Math.max(CreatureStorage.STATE_FLAG_SIZE, s_NameCache.slotHeight - 4);
                if (this.m_Data.isHuman && this.m_Data.pkFlag > PK_NONE)
                {
                    _loc_13 = _loc_13 - CreatureStorage.STATE_FLAG_SIZE;
                    _loc_10 = CreatureStorage.s_GetPKFlag(this.m_Data.pkFlag, s_Rect);
                    s_Point.setTo(_loc_4 + _loc_13, _loc_5 + (_loc_14 - CreatureStorage.STATE_FLAG_SIZE) / 2);
                    this.drawCreatureFlag(graphics, _loc_10, s_Rect, s_Point);
                    _loc_13 = _loc_13 - _loc_6;
                }
                if (this.m_Data.isHuman && this.m_Data.partyFlag > PARTY_NONE)
                {
                    _loc_13 = _loc_13 - CreatureStorage.STATE_FLAG_SIZE;
                    _loc_10 = CreatureStorage.s_GetPartyFlag(this.m_Data.partyFlag, s_Rect);
                    s_Point.setTo(_loc_4 + _loc_13, _loc_5 + (_loc_14 - CreatureStorage.STATE_FLAG_SIZE) / 2);
                    this.drawCreatureFlag(graphics, _loc_10, s_Rect, s_Point);
                    _loc_13 = _loc_13 - _loc_6;
                }
                if (this.m_Data.isHuman && this.m_Data.guildFlag > GUILD_NONE)
                {
                    _loc_13 = _loc_13 - CreatureStorage.STATE_FLAG_SIZE;
                    _loc_10 = CreatureStorage.s_GetGuildFlag(this.m_Data.guildFlag, s_Rect);
                    s_Point.setTo(_loc_4 + _loc_13, _loc_5 + (_loc_14 - CreatureStorage.STATE_FLAG_SIZE) / 2);
                    this.drawCreatureFlag(graphics, _loc_10, s_Rect, s_Point);
                    _loc_13 = _loc_13 - _loc_6;
                }
                if (this.m_Data.isHuman && this.m_Data.riskinessFlag > RISKINESS_NONE)
                {
                    _loc_13 = _loc_13 - CreatureStorage.STATE_FLAG_SIZE;
                    _loc_10 = CreatureStorage.s_GetRiskinessFlag(this.m_Data.riskinessFlag, s_Rect);
                    s_Point.setTo(_loc_4 + _loc_13, _loc_5 + (_loc_14 - CreatureStorage.STATE_FLAG_SIZE) / 2);
                    this.drawCreatureFlag(graphics, _loc_10, s_Rect, s_Point);
                    _loc_13 = _loc_13 - _loc_6;
                }
                if (this.m_Data.isSummon && this.m_Data.summonFlag > SUMMON_NONE)
                {
                    _loc_13 = _loc_13 - CreatureStorage.STATE_FLAG_SIZE;
                    _loc_10 = CreatureStorage.s_GetSummonFlag(this.m_Data.summonFlag, s_Rect);
                    s_Point.setTo(_loc_4 + _loc_13, _loc_5 + (_loc_14 - CreatureStorage.STATE_FLAG_SIZE) / 2);
                    this.drawCreatureFlag(graphics, _loc_10, s_Rect, s_Point);
                    _loc_13 = _loc_13 - _loc_6;
                }
                _loc_15 = 0;
                switch(this.m_Data.marks.getMarkColor(Marks.MARK_TYPE_CLIENT_BATTLELIST))
                {
                    case Marks.MARK_AIM:
                    {
                        _loc_15 = 16777215;
                        break;
                    }
                    case Marks.MARK_AIM_ATTACK:
                    case Marks.MARK_ATTACK:
                    {
                        _loc_15 = 16711680;
                        break;
                    }
                    case Marks.MARK_AIM_FOLLOW:
                    case Marks.MARK_FOLLOW:
                    {
                        _loc_15 = 65280;
                        break;
                    }
                    default:
                    {
                        _loc_15 = getStyle("color");
                        break;
                        break;
                    }
                }
                _loc_16 = s_NameCache.getItem(this.m_Data.name + String(_loc_15) + String(_loc_13), this.m_Data.name, _loc_15, _loc_13);
                if (_loc_16 != null)
                {
                    s_Trans.a = 1;
                    s_Trans.d = 1;
                    s_Trans.tx = -_loc_16.x + _loc_4;
                    s_Trans.ty = -_loc_16.y + _loc_5 + (_loc_14 - (s_NameCache.slotHeight - 4)) / 2 - 2;
                    graphics.beginBitmapFill(s_NameCache, s_Trans, false, false);
                    graphics.drawRect(_loc_4, _loc_5 + (_loc_14 - (s_NameCache.slotHeight - 4)) / 2 - 2, _loc_13, s_NameCache.slotHeight);
                }
                _loc_17 = (_loc_8 - 2) * this.m_Data.hitpointsPercent / 100;
                _loc_18 = getStyle("healthbarHeight");
                graphics.beginFill(0, 1);
                graphics.drawRect(_loc_4, param2 - _loc_3.bottom - _loc_18, _loc_8, _loc_18);
                s_TempHealthColor.ARGB = Creature.s_GetHealthColourARGB(this.m_Data.hitpointsPercent);
                graphics.beginFill(s_TempHealthColor.RGB, 1);
                graphics.drawRect((_loc_4 + 1), param2 - _loc_3.bottom - _loc_18 + 1, _loc_17, _loc_18 - 2);
            }
            graphics.endFill();
            return;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            return new EdgeMetrics(getStyle("paddingLeft"), getStyle("paddingTop"), getStyle("paddingRight"), getStyle("paddingBottom"));
        }// end function

        private function onDataChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "partyFlag" || event.property == "pkFlag" || event.property == "guildFlag")
            {
                invalidateDisplayList();
                this.invalidateTimer();
            }
            else if (event.property == "name" || event.property == "outfit" || event.property == "marks")
            {
                invalidateDisplayList();
            }
            return;
        }// end function

        static function s_InitialiseMarksView(param1:Boolean) : void
        {
            s_BattlelistMarksView = new MarksView(4);
            s_BattlelistMarksView.addMarkToView(Marks.MARK_TYPE_CLIENT_BATTLELIST, MarksView.MARK_THICKNESS_THIN);
            if (param1)
            {
                s_BattlelistMarksView.addMarkToView(Marks.MARK_TYPE_PERMANENT, MarksView.MARK_THICKNESS_THIN);
            }
            return;
        }// end function

        private static function s_InitialiseStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.factory = function () : void
            {
                this.color = 13684944;
                this.paddingBottom = 2;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.horizontalGap = 2;
                this.verticalGap = 2;
                this.healthbarHeight = 5;
                this.healthbarWidth = 50;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitialiseStyle();
        s_InitialiseMarksView(true);
    }
}

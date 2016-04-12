package tibia.creatures.unjustPointsWidgetClasses
{
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.styles.*;
    import tibia.creatures.*;

    public class UnjustPointsBarRenderer extends UIComponent implements IDataRenderer
    {
        private var m_BarColor:BitmapData;
        private var m_MarkCount:uint = 0;
        private var m_Player:Player;
        private var m_MaximumValue:Number = 100;
        private var m_CurrentValue:Number = 0;
        private var m_MinimumValue:Number = 0;
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
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        private static var s_Rect:Rectangle = new Rectangle();
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        private static var s_Point:Point = new Point();
        static const STATE_PZ_ENTERED:int = 14;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        private static const UNJUST_BAR_GREEN_BITMAP:BitmapData = (new UNJUST_BAR_GREEN() as BitmapAsset).bitmapData;
        private static const UNJUST_BAR_GREEN:Class = UnjustPointsBarRenderer_UNJUST_BAR_GREEN;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        private static const UNJUST_BAR_RED:Class = UnjustPointsBarRenderer_UNJUST_BAR_RED;
        public static const SCALE_DAY:uint = 0;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        private static const UNJUST_BAR_RED_BITMAP:BitmapData = (new UNJUST_BAR_RED() as BitmapAsset).bitmapData;
        static const PROFESSION_SORCERER:int = 3;
        public static const SCALE_MONTH:uint = 2;
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
        private static const UNJUST_BAR_YELLOW_BITMAP:BitmapData = (new UNJUST_BAR_YELLOW() as BitmapAsset).bitmapData;
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
        private static const UNJUST_BAR_YELLOW:Class = UnjustPointsBarRenderer_UNJUST_BAR_YELLOW;
        private static var s_Trans:Matrix = new Matrix(1, 0, 0, 1);
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
        public static const SCALE_WEEK:uint = 1;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function UnjustPointsBarRenderer()
        {
            this.m_BarColor = UNJUST_BAR_GREEN_BITMAP;
            return;
        }// end function

        public function get maximumValue() : Number
        {
            return this.m_MaximumValue;
        }// end function

        public function get minimumValue() : Number
        {
            return this.m_MinimumValue;
        }// end function

        public function set minimumValue(param1:Number) : void
        {
            if (param1 != this.m_MinimumValue)
            {
                this.m_MinimumValue = param1;
                this.m_CurrentValue = Math.max(param1, this.m_CurrentValue);
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            return;
        }// end function

        public function set marks(param1:uint) : void
        {
            if (param1 != this.m_MarkCount)
            {
                this.m_MarkCount = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function get marks() : uint
        {
            return this.m_MarkCount;
        }// end function

        public function get data() : Object
        {
            return this.m_Player;
        }// end function

        private function getNextPkFlag() : int
        {
            switch(this.m_Player.pkFlag)
            {
                case PK_PLAYERKILLER:
                case PK_EXCPLAYERKILLER:
                {
                    return PK_EXCPLAYERKILLER;
                }
                default:
                {
                    return PK_PLAYERKILLER;
                    break;
                }
            }
        }// end function

        public function set maximumValue(param1:Number) : void
        {
            if (param1 != this.m_MaximumValue)
            {
                this.m_MaximumValue = param1;
                this.m_CurrentValue = Math.min(param1, this.m_CurrentValue);
                invalidateDisplayList();
            }
            return;
        }// end function

        public function set barColor(param1:BitmapData) : void
        {
            this.m_BarColor = param1;
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            param1 = Math.max(Math.min(this.maximumValue, param1), this.minimumValue);
            if (param1 != this.m_CurrentValue)
            {
                this.m_CurrentValue = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            var _loc_2:* = param1 as Player;
            if (_loc_2 != null)
            {
                this.m_Player = _loc_2;
            }
            else
            {
                throw new ArgumentError("UnjustPointsBarRenderer: Invalid type for data");
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

        private function getCurrentPkFlag() : int
        {
            return PK_NONE;
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
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            super.updateDisplayList(param1, param2);
            graphics.clear();
            graphics.beginFill(65280, 0);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            if (this.m_Player != null)
            {
                _loc_3 = this.viewMetricsAndPadding;
                _loc_4 = _loc_3.left;
                _loc_5 = _loc_3.top;
                _loc_6 = getStyle("horizontalGap");
                _loc_7 = getStyle("verticalGap");
                _loc_8 = param1 - (_loc_4 + _loc_3.right);
                _loc_9 = param2 - (_loc_3.top + _loc_3.bottom);
                _loc_10 = CreatureStorage.s_GetPKFlag(this.getCurrentPkFlag(), s_Rect);
                s_Point.x = _loc_4;
                s_Point.y = _loc_5;
                this.drawCreatureFlag(graphics, _loc_10, s_Rect, s_Point);
                _loc_11 = CreatureStorage.s_GetPKFlag(this.getNextPkFlag(), s_Rect);
                s_Point.x = _loc_8 - s_Rect.width - _loc_3.right;
                s_Point.y = _loc_5;
                this.drawCreatureFlag(graphics, _loc_11, s_Rect, s_Point);
                s_Rect.x = _loc_4 + getStyle("pointbarLeft");
                s_Rect.y = _loc_5 + getStyle("pointbarTop");
                s_Rect.width = getStyle("pointbarWidth");
                s_Rect.height = getStyle("pointbarHeight");
                _loc_12 = this.maximumValue > 0 ? ((this.value - this.minimumValue) / (this.maximumValue - this.minimumValue)) : (1);
                graphics.beginBitmapFill(this.m_BarColor);
                graphics.drawRect(s_Rect.x, s_Rect.y, Math.max(0, s_Rect.width * _loc_12), s_Rect.height);
                _loc_13 = s_Rect.width / (this.m_MarkCount + 1);
                graphics.beginFill(0, 1);
                _loc_14 = 1;
                while (_loc_14 <= this.m_MarkCount)
                {
                    
                    _loc_15 = s_Rect.x + _loc_14 * _loc_13 - 1;
                    _loc_16 = s_Rect.y;
                    graphics.drawRect(_loc_15, _loc_16, 1, s_Rect.height);
                    _loc_14++;
                }
            }
            graphics.endFill();
            return;
        }// end function

        public function get value() : Number
        {
            return this.m_CurrentValue;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            return new EdgeMetrics(getStyle("paddingLeft"), getStyle("paddingTop"), getStyle("paddingRight"), getStyle("paddingBottom"));
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
                this.pointbarHeight = 4;
                this.pointbarWidth = 70;
                this.pointbarLeft = 22;
                this.pointbarTop = 2;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        public static function getBarColorForRemainingKills(param1:uint) : BitmapData
        {
            if (param1 > 2)
            {
                return UNJUST_BAR_GREEN_BITMAP;
            }
            if (param1 > 1)
            {
                return UNJUST_BAR_YELLOW_BITMAP;
            }
            return UNJUST_BAR_RED_BITMAP;
        }// end function

        s_InitialiseStyle();
    }
}

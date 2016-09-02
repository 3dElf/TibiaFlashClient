package tibia.creatures.statusWidgetClasses
{
    import flash.display.*;
    import mx.core.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.creatures.*;

    public class StateRenderer extends UIComponent
    {
        private var m_UncommittedBitSet:Boolean = true;
        private var m_BitSet:uint = 4.29497e+009;
        private var m_UncommittedMaxColumns:Boolean = false;
        private var m_MaxColumns:int = 2.14748e+009;
        private var m_UncommittedMaxRows:Boolean = false;
        private var m_MinRows:int = 1;
        private var m_ChildColumns:int = 0;
        private var m_UncommittedMinColumns:Boolean = false;
        private var m_UncommittedCharacter:Boolean = false;
        private var m_ChildRows:int = 0;
        private var m_MinColumns:int = 1;
        private var m_MaxRows:int = 2.14748e+009;
        private var m_InvalidedStyle:Boolean = true;
        private var m_Character:Player = null;
        private var m_UncommittedMinRows:Boolean = false;
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
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
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
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
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
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        private static const STATE_OPTIONS:Array = [{value:STATE_POISONED, styleProp:"iconStatePoisoned", toolTip:"TIP_STATE_POISONED"}, {value:STATE_BURNING, styleProp:"iconStateBurning", toolTip:"TIP_STATE_BURNING"}, {value:STATE_ELECTRIFIED, styleProp:"iconStateElectrified", toolTip:"TIP_STATE_ELECTRIFIED"}, {value:STATE_DRUNK, styleProp:"iconStateDrunk", toolTip:"TIP_STATE_DRUNK"}, {value:STATE_MANA_SHIELD, styleProp:"iconStateManaShield", toolTip:"TIP_STATE_MANA_SHIELD"}, {value:STATE_SLOW, styleProp:"iconStateSlow", toolTip:"TIP_STATE_SLOW"}, {value:STATE_FAST, styleProp:"iconStateFast", toolTip:"TIP_STATE_FAST"}, {value:STATE_FIGHTING, styleProp:"iconStateFighting", toolTip:"TIP_STATE_FIGHTING"}, {value:STATE_DROWNING, styleProp:"iconStateDrowning", toolTip:"TIP_STATE_DROWNING"}, {value:STATE_FREEZING, styleProp:"iconStateFreezing", toolTip:"TIP_STATE_FREEZING"}, {value:STATE_DAZZLED, styleProp:"iconStateDazzled", toolTip:"TIP_STATE_DAZZLED"}, {value:STATE_CURSED, styleProp:"iconStateCursed", toolTip:"TIP_STATE_CURSED"}, {value:STATE_STRENGTHENED, styleProp:"iconStateStrengthened", toolTip:"TIP_STATE_STRENGTHENED"}, {value:STATE_PZ_BLOCK, styleProp:"iconStatePZBlock", toolTip:"TIP_STATE_PZ_BLOCK"}, {value:STATE_PZ_ENTERED, styleProp:"iconStatePZEntered", toolTip:"TIP_STATE_PZ_ENTERED"}, {value:STATE_BLEEDING, styleProp:"iconStateBleeding", toolTip:"TIP_STATE_BLEEDING"}, {value:STATE_HUNGRY, styleProp:"iconStateHungry", toolTip:"TIP_STATE_HUNGRY"}];
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SUMMON_OWN:int = 1;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        private static var s_ChildWidth:Number = NaN;
        private static var s_ChildHeight:Number = NaN;
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
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
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
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function StateRenderer()
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (isNaN(s_ChildWidth) && isNaN(s_ChildHeight))
            {
                s_ChildWidth = 0;
                s_ChildHeight = 0;
                for each (_loc_1 in STATE_OPTIONS)
                {
                    
                    if (_loc_1.hasOwnProperty("styleInstance") && _loc_1.styleInstance is DisplayObject)
                    {
                        _loc_2 = DisplayObject(_loc_1.styleInstance).width;
                        if (!isNaN(_loc_2))
                        {
                            s_ChildWidth = Math.max(s_ChildWidth, _loc_2);
                        }
                        _loc_3 = DisplayObject(_loc_1.styleInstance).height;
                        if (!isNaN(_loc_3))
                        {
                            s_ChildHeight = Math.max(s_ChildHeight, _loc_3);
                        }
                    }
                }
            }
            return;
        }// end function

        public function get minColumns() : int
        {
            return this.m_MinColumns;
        }// end function

        public function get minRows() : int
        {
            return this.m_MinRows;
        }// end function

        public function set maxRows(param1:int) : void
        {
            param1 = Math.max(1, param1);
            if (this.m_MaxRows != param1)
            {
                this.m_MaxRows = param1;
                this.m_UncommittedMaxRows = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function set minRows(param1:int) : void
        {
            param1 = Math.max(1, param1);
            if (this.m_MinRows != param1)
            {
                this.m_MinRows = param1;
                this.m_UncommittedMinRows = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedCharacter)
            {
                if (this.character != null)
                {
                    this.bitSet = this.character.stateFlags;
                }
                else
                {
                    this.bitSet = 16777215;
                }
                this.m_UncommittedCharacter = false;
            }
            if (this.m_UncommittedBitSet)
            {
                _loc_1 = numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    removeChildAt(_loc_1);
                    _loc_1 = _loc_1 - 1;
                }
                for each (_loc_2 in STATE_OPTIONS)
                {
                    
                    if (this.bitSet & 1 << _loc_2.value)
                    {
                        _loc_3 = new RotatingShapeWrapper();
                        _loc_3.explicitHeight = s_ChildHeight;
                        _loc_3.explicitWidth = s_ChildWidth;
                        _loc_3.toolTip = resourceManager.getString(BUNDLE, _loc_2.toolTip);
                        _loc_3.addChild(_loc_2.styleInstance);
                        addChild(_loc_3);
                    }
                }
                this.m_UncommittedBitSet = false;
            }
            if (this.m_UncommittedMinColumns)
            {
                this.m_UncommittedMinColumns = false;
            }
            if (this.m_UncommittedMaxColumns)
            {
                this.m_UncommittedMaxColumns = false;
            }
            if (this.m_UncommittedMinRows)
            {
                this.m_UncommittedMinRows = false;
            }
            if (this.m_UncommittedMaxRows)
            {
                this.m_UncommittedMaxRows = false;
            }
            return;
        }// end function

        public function set character(param1:Player) : void
        {
            if (this.m_Character != param1)
            {
                if (this.m_Character != null)
                {
                    this.m_Character.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onCharacterChange);
                }
                this.m_Character = param1;
                this.m_UncommittedCharacter = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
                if (this.m_Character != null)
                {
                    this.m_Character.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onCharacterChange);
                }
            }
            return;
        }// end function

        protected function get bitSet() : uint
        {
            return this.m_BitSet;
        }// end function

        private function onCharacterChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "stateFlags" || event.property == "*")
            {
                this.bitSet = this.character.stateFlags;
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            this.m_InvalidedStyle = true;
            invalidateProperties();
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_3:* = null;
            var _loc_7:* = NaN;
            super.measure();
            this.m_ChildColumns = this.m_MinColumns;
            this.m_ChildRows = this.m_MinRows;
            var _loc_1:* = 0;
            var _loc_2:* = STATE_OPTIONS.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.bitSet & 1 << STATE_OPTIONS[_loc_2].value)
                {
                    _loc_1++;
                }
                _loc_2 = _loc_2 - 1;
            }
            while (this.m_ChildRows * this.m_ChildColumns < _loc_1)
            {
                
                if (this.m_ChildColumns < this.m_MaxColumns)
                {
                    var _loc_8:* = this;
                    var _loc_9:* = this.m_ChildColumns + 1;
                    _loc_8.m_ChildColumns = _loc_9;
                    continue;
                }
                if (this.m_ChildRows < this.m_MaxRows)
                {
                    var _loc_8:* = this;
                    var _loc_9:* = this.m_ChildRows + 1;
                    _loc_8.m_ChildRows = _loc_9;
                    continue;
                }
                break;
            }
            _loc_3 = this.viewMetricsAndPadding;
            var _loc_4:* = getStyle("horizontalGap");
            var _loc_5:* = _loc_3.left + _loc_3.right;
            measuredMinWidth = this.m_MinColumns * s_ChildWidth + (this.m_MinColumns - 1) * _loc_4 + _loc_5;
            measuredWidth = Math.max(measuredMinWidth, this.m_ChildColumns * s_ChildWidth + (this.m_ChildColumns - 1) * _loc_4 + _loc_5);
            var _loc_6:* = getStyle("verticalGap");
            _loc_7 = _loc_3.top + _loc_3.bottom;
            measuredMinHeight = this.m_MinRows * s_ChildHeight + (this.m_MinRows - 1) * _loc_6 + _loc_7;
            measuredHeight = Math.max(measuredMinHeight, this.m_ChildRows * s_ChildHeight + (this.m_ChildRows - 1) * _loc_6 + _loc_7);
            return;
        }// end function

        public function get maxColumns() : int
        {
            return this.m_MaxColumns;
        }// end function

        public function set minColumns(param1:int) : void
        {
            param1 = Math.max(1, param1);
            if (this.m_MinColumns != param1)
            {
                this.m_MinColumns = param1;
                this.m_UncommittedMinColumns = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get character() : Player
        {
            return this.m_Character;
        }// end function

        protected function set bitSet(param1:uint) : void
        {
            if (this.m_BitSet != param1)
            {
                this.m_BitSet = param1;
                this.m_UncommittedBitSet = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get maxRows() : int
        {
            return this.m_MaxRows;
        }// end function

        public function set maxColumns(param1:int) : void
        {
            param1 = Math.max(1, param1);
            if (this.m_MaxColumns != param1)
            {
                this.m_MaxColumns = param1;
                this.m_UncommittedMaxColumns = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            super.updateDisplayList(param1, param2);
            if (this.m_ChildRows == 0 || this.m_ChildColumns == 0)
            {
                return;
            }
            _loc_3 = this.viewMetricsAndPadding;
            var _loc_4:* = getStyle("horizontalGap");
            _loc_5 = getStyle("verticalGap");
            var _loc_6:* = this.m_ChildRows * s_ChildHeight + (this.m_ChildRows - 1) * _loc_5;
            var _loc_7:* = param2 - _loc_3.top - _loc_3.bottom;
            var _loc_8:* = param1 - _loc_3.left - _loc_3.right;
            var _loc_9:* = _loc_3.left;
            var _loc_10:* = _loc_3.top + (_loc_7 - _loc_6) / 2 - s_ChildHeight - _loc_5;
            var _loc_11:* = 0;
            var _loc_12:* = numChildren;
            while (_loc_11 < _loc_12)
            {
                
                if (_loc_11 % this.m_ChildColumns == 0)
                {
                    _loc_16 = Math.min(_loc_12 - _loc_11, this.m_ChildColumns);
                    _loc_17 = _loc_16 * s_ChildWidth + (_loc_16 - 1) * _loc_4;
                    _loc_9 = _loc_3.left + (_loc_8 - _loc_17) / 2;
                    _loc_10 = _loc_10 + (s_ChildHeight + _loc_5);
                }
                _loc_13 = UIComponent(getChildAt(_loc_11));
                _loc_14 = _loc_13.getExplicitOrMeasuredHeight();
                _loc_15 = _loc_13.getExplicitOrMeasuredWidth();
                _loc_13.move(_loc_9 + (s_ChildWidth - _loc_15) / 2, _loc_10 + (s_ChildHeight - _loc_14) / 2);
                _loc_13.setActualSize(_loc_15, _loc_14);
                _loc_9 = _loc_9 + (s_ChildWidth + _loc_4);
                _loc_11++;
            }
            return;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            return EdgeMetrics.EMPTY;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            var _loc_1:* = this.borderMetrics.clone();
            _loc_1.bottom = _loc_1.bottom + getStyle("paddingBottom");
            _loc_1.left = _loc_1.left + getStyle("paddingLeft");
            _loc_1.right = _loc_1.right + getStyle("paddingRight");
            _loc_1.top = _loc_1.top + getStyle("paddingTop");
            return _loc_1;
        }// end function

        cacheStyleInstance(STATE_OPTIONS, ".statusWidgetIcons");
    }
}

import flash.display.*;

import mx.core.*;

import mx.events.*;

import shared.utility.*;

import tibia.creatures.*;

class RotatingShapeWrapper extends ShapeWrapper
{

    function RotatingShapeWrapper()
    {
        return;
    }// end function

    override protected function updateDisplayList(param1:Number, param2:Number) : void
    {
        var _loc_3:* = null;
        var _loc_4:* = null;
        var _loc_5:* = NaN;
        var _loc_6:* = NaN;
        var _loc_7:* = NaN;
        var _loc_8:* = NaN;
        super.updateDisplayList(param1, param2);
        if (numChildren > 0)
        {
            _loc_3 = getChildAt(0);
            _loc_4 = transform.concatenatedMatrix;
            _loc_5 = _loc_4.a;
            _loc_6 = _loc_4.b;
            if (_loc_5 == _loc_4.d && Math.abs(_loc_5) <= 1 && _loc_6 == -_loc_4.c && Math.abs(_loc_6) <= 1)
            {
                _loc_7 = _loc_3.width / 2;
                _loc_8 = _loc_3.height / 2;
                _loc_3.transform.matrix = new Matrix(_loc_5, -_loc_6, _loc_6, _loc_5, (-_loc_7) * _loc_5 - _loc_8 * _loc_6 + _loc_7, _loc_7 * _loc_6 - _loc_8 * _loc_5 + _loc_8);
            }
        }
        return;
    }// end function

}


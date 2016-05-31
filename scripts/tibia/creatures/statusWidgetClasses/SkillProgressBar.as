package tibia.creatures.statusWidgetClasses
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.creatures.*;

    public class SkillProgressBar extends HBox
    {
        private var m_UncommittedSkill:Boolean = true;
        private var m_UILabelWrapper:ShapeWrapper = null;
        private var m_TextStyle:CSSStyleDeclaration = null;
        private var m_UncommittedSkillLabel:Boolean = false;
        private var m_SkillLabel:String = null;
        private var m_UncommittedCharacter:Boolean = false;
        private var m_TextField:TextField = null;
        private var m_Skill:int = -1;
        private var m_UIProgress:BitmapProgressBar = null;
        private var m_UILabel:Bitmap = null;
        private var m_Character:Player = null;
        private var m_UIIcon:ShapeWrapper = null;
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
        private static const SKILL_OPTIONS:Array = [{value:SKILL_CARRYSTRENGTH, styleProp:null}, {value:SKILL_EXPERIENCE, styleProp:null}, {value:SKILL_FED, styleProp:null}, {value:SKILL_FIGHTAXE, styleProp:"iconSkillFightAxe"}, {value:SKILL_FIGHTCLUB, styleProp:"iconSkillFightClub"}, {value:SKILL_FIGHTDISTANCE, styleProp:"iconSkillFightDistance"}, {value:SKILL_FIGHTFIST, styleProp:"iconSkillFightFist"}, {value:SKILL_FIGHTSHIELD, styleProp:"iconSkillFightShield"}, {value:SKILL_FIGHTSWORD, styleProp:"iconSkillFightSword"}, {value:SKILL_FISHING, styleProp:"iconSkillFishing"}, {value:SKILL_GOSTRENGTH, styleProp:null}, {value:SKILL_HITPOINTS, styleProp:null}, {value:SKILL_LEVEL, styleProp:"iconSkillLevel"}, {value:SKILL_MAGLEVEL, styleProp:"iconSkillMagLevel"}, {value:SKILL_MANA, styleProp:null}, {value:SKILL_NONE, styleProp:null}, {value:SKILL_OFFLINETRAINING, styleProp:null}, {value:SKILL_SOULPOINTS, styleProp:null}, {value:SKILL_STAMINA, styleProp:null}];
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

        public function SkillProgressBar()
        {
            toolTip = "toolTip";
            addEventListener(ToolTipEvent.TOOL_TIP_SHOW, this.onToolTip);
            return;
        }// end function

        private function onToolTip(event:ToolTipEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            if (this.skill != SKILL_NONE && this.character != null)
            {
                _loc_2 = NaN;
                _loc_3 = NaN;
                _loc_4 = NaN;
                _loc_5 = null;
                _loc_6 = StatusWidget.s_GetSkillName(this.skill);
                _loc_2 = this.character.getSkillValue(this.skill);
                if (this.skill == SKILL_LEVEL)
                {
                    _loc_3 = this.character.getSkillGain(SKILL_EXPERIENCE);
                    _loc_4 = Player.s_GetExperienceForLevel((this.character.level + 1)) - this.character.getSkillValue(SKILL_EXPERIENCE);
                    _loc_5 = resourceManager.getString(BUNDLE, "TIP_SKILL_UNIT_EXPERIENCE");
                }
                else
                {
                    _loc_3 = this.character.getSkillGain(this.skill);
                    _loc_4 = 100 - this.character.getSkillProgress(this.skill);
                    _loc_5 = resourceManager.getString(BUNDLE, "TIP_SKILL_UNIT_DEFAULT");
                }
                _loc_4 = Math.max(0, _loc_4);
                _loc_7 = event.toolTip;
                if (_loc_3 > 0)
                {
                    _loc_9 = Math.floor(_loc_4 * 60 / _loc_3);
                    _loc_10 = Math.floor(_loc_9 / 60);
                    _loc_9 = _loc_9 - _loc_10 * 60;
                    _loc_7.text = resourceManager.getString(BUNDLE, "TIP_SKILL_TEXT_EXTENDED", [_loc_6, _loc_2, _loc_4, _loc_5, _loc_3, _loc_10, _loc_9]);
                }
                else
                {
                    _loc_7.text = resourceManager.getString(BUNDLE, "TIP_SKILL_TEXT_SIMPLE", [_loc_6, _loc_2, _loc_4, _loc_5]);
                }
                _loc_8 = this.character.experienceBonus * 100;
                if (this.skill == SKILL_LEVEL && _loc_8 > 0)
                {
                    _loc_7.text = _loc_7.text + resourceManager.getString(BUNDLE, "TIP_SKILL_TEXT_EXP_BONUS", [_loc_8]);
                }
                if (_loc_7 is IInvalidating)
                {
                    IInvalidating(_loc_7).validateNow();
                    _loc_11 = _loc_7.getExplicitOrMeasuredWidth();
                    _loc_12 = _loc_7.getExplicitOrMeasuredHeight();
                    _loc_13 = Math.max(0, Math.min(_loc_7.x, stage.stageWidth - _loc_11));
                    _loc_14 = Math.max(0, Math.min(_loc_7.y, stage.stageHeight - _loc_12));
                    _loc_7.move(_loc_13, _loc_14);
                    _loc_7.setActualSize(_loc_11, _loc_12);
                }
            }
            else
            {
                event.preventDefault();
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function set skillLabel(param1:String) : void
        {
            if (this.m_SkillLabel != param1)
            {
                this.m_SkillLabel = param1;
                this.m_UncommittedSkillLabel = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function updateSkillLabel(param1:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = 33;
            var _loc_3:* = 10;
            if (param1 != null)
            {
                if (this.m_TextField == null)
                {
                    this.m_TextField = createInFontContext(TextField) as TextField;
                    this.m_TextField.autoSize = TextFieldAutoSize.LEFT;
                    this.m_TextField.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
                }
                _loc_5 = StyleManager.getStyleDeclaration(getStyle("labelStyleName"));
                if (this.m_TextStyle != _loc_5)
                {
                    this.m_TextStyle = _loc_5;
                }
                if (this.m_TextStyle != null)
                {
                    this.m_TextField.defaultTextFormat = new TextFormat(this.m_TextStyle.getStyle("fontFamily"), this.m_TextStyle.getStyle("fontSize"), this.m_TextStyle.getStyle("fontColor"), this.m_TextStyle.getStyle("fontWeight") == "bold", this.m_TextStyle.getStyle("fontStyle") == "italic");
                }
                this.m_TextField.text = param1;
                _loc_2 = Math.max(33, Math.min(this.m_TextField.textWidth, 66));
                _loc_3 = this.m_TextField.textHeight;
            }
            var _loc_4:* = this.m_UILabel.bitmapData;
            if (this.m_UILabel.bitmapData == null || _loc_4.width != _loc_2 || _loc_4.height != _loc_3)
            {
                _loc_4 = new BitmapData(_loc_2, _loc_3, true, 65280);
                _loc_4.lock();
                this.m_UILabel.bitmapData = _loc_4;
                this.m_UILabelWrapper.invalidateSize();
            }
            else
            {
                _loc_4.lock();
                _loc_4.fillRect(new Rectangle(0, 0, _loc_4.width, _loc_4.height), 65280);
            }
            if (param1 != null)
            {
                _loc_6 = new Matrix(1, 0, 0, 1, (_loc_4.width - this.m_TextField.textWidth) / 2 - 2, -2);
                _loc_4.draw(this.m_TextField, _loc_6);
            }
            _loc_4.unlock();
            return;
        }// end function

        public function get skill() : int
        {
            return this.m_Skill;
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
                invalidateProperties();
                if (this.m_Character != null)
                {
                    this.m_Character.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onCharacterChange);
                }
            }
            return;
        }// end function

        private function onCharacterChange(event:PropertyChangeEvent) : void
        {
            if ((event.property == "skill" || event.property == "*") && this.skill != SKILL_NONE)
            {
                this.skillLabel = String(this.character.getSkillValue(this.skill));
                this.m_UIProgress.value = this.character.getSkillProgress(this.skill);
                this.updateExperienceBarStyle();
            }
            return;
        }// end function

        private function updateExperienceBarStyle() : void
        {
            if (this.m_UIProgress != null)
            {
                if (this.m_Character != null && this.m_Character.experienceBonus > 0)
                {
                    this.m_UIProgress.styleName = getStyle("progressBarBonusStyleName");
                }
                else
                {
                    this.m_UIProgress.styleName = getStyle("progressBarStyleName");
                }
            }
            return;
        }// end function

        public function get progressDirection() : String
        {
            return this.m_UIProgress != null ? (this.m_UIProgress.direction) : (null);
        }// end function

        public function set skill(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = SKILL_NONE;
            for each (_loc_3 in SKILL_OPTIONS)
            {
                
                if (_loc_3.value === param1 && _loc_3.styleProp != null)
                {
                    _loc_2 = param1;
                    break;
                }
            }
            if (this.m_Skill != _loc_2)
            {
                this.m_Skill = _loc_2;
                this.m_UncommittedSkill = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function get skillLabel() : String
        {
            return this.m_SkillLabel;
        }// end function

        public function get character() : Player
        {
            return this.m_Character;
        }// end function

        public function set progressDirection(param1:String) : void
        {
            if (this.m_UIProgress != null)
            {
                this.m_UIProgress.direction = param1;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedCharacter)
            {
                if (this.character != null && this.skill != SKILL_NONE)
                {
                    this.skillLabel = String(this.character.getSkillValue(this.skill));
                    this.m_UIProgress.value = this.character.getSkillProgress(this.skill);
                }
                this.m_UncommittedCharacter = false;
            }
            if (this.m_UncommittedSkill)
            {
                this.m_UIIcon.removeChildren();
                for each (_loc_1 in SKILL_OPTIONS)
                {
                    
                    if (_loc_1.value === this.skill && _loc_1.styleInstance is DisplayObject)
                    {
                        this.m_UIIcon.addChild(_loc_1.styleInstance);
                        break;
                    }
                }
                if (this.character != null && this.skill != SKILL_NONE)
                {
                    includeInLayout = true;
                    this.skillLabel = String(this.character.getSkillValue(this.skill));
                    visible = true;
                    this.m_UIProgress.value = this.character.getSkillProgress(this.skill);
                }
                else
                {
                    includeInLayout = false;
                    visible = false;
                }
                this.updateExperienceBarStyle();
                this.m_UncommittedSkill = false;
            }
            if (this.m_UncommittedSkillLabel)
            {
                this.updateSkillLabel(this.skillLabel);
                this.m_UncommittedSkillLabel = false;
            }
            return;
        }// end function

        override public function set styleName(param1:Object) : void
        {
            super.styleName = param1;
            if (this.m_UIIcon != null)
            {
                this.m_UIIcon.styleName = getStyle("iconStyleName");
            }
            this.updateExperienceBarStyle();
            this.m_UncommittedSkillLabel = true;
            invalidateProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIIcon = new ShapeWrapper();
            this.m_UIIcon.styleName = getStyle("iconStyleName");
            addChild(this.m_UIIcon);
            this.m_UILabel = new Bitmap();
            this.m_UILabelWrapper = new ShapeWrapper();
            this.m_UILabelWrapper.addChild(this.m_UILabel);
            addChild(this.m_UILabelWrapper);
            this.m_UIProgress = new BitmapProgressBar();
            this.m_UIProgress.labelEnabled = false;
            this.m_UIProgress.labelFormat = "{1}%";
            this.m_UIProgress.percentWidth = 100;
            this.m_UIProgress.styleName = getStyle("progressBarStyleName");
            this.m_UIProgress.tickValues = [25, 50, 75];
            addChild(this.m_UIProgress);
            return;
        }// end function

        cacheStyleInstance(SKILL_OPTIONS, ".statusWidgetIcons");
    }
}

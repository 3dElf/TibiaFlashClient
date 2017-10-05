package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.options.*;
    import tibia.options.configurationWidgetClasses.*;
    import tibia.worldmap.widgetClasses.*;

    public class StatusOptions extends VBox implements IOptionsEditor
    {
        protected var m_UIOwnHealth:CheckBox = null;
        protected var m_UIOtherHealth:CheckBox = null;
        private var m_UncommittedWidgetStyle:Boolean = false;
        protected var m_UIOwnStyle:ComboBox = null;
        private var m_UncommittedValues:Boolean = true;
        private var m_UncommittedWidgetSkill:Boolean = false;
        protected var m_UIOtherFlags:CheckBox = null;
        protected var m_UIOwnName:CheckBox = null;
        protected var m_UICreatureStyle:ComboBox = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_Options:OptionsStorage = null;
        protected var m_UIOtherName:CheckBox = null;
        protected var m_UIOtherIcons:CheckBox = null;
        protected var m_OtherStyle:int = 1;
        protected var m_UIWidgetStyle:ComboBox = null;
        protected var m_UIBothPvPFrames:CheckBox = null;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_WidgetStyle:int = 1;
        protected var m_UIWidgetSkill:ComboBox = null;
        protected var m_UIOwnMana:CheckBox = null;
        private var m_UncommittedOtherStyle:Boolean = false;
        protected var m_UIOwnFlags:CheckBox = null;
        protected var m_WidgetSkill:int = 0;
        private var m_UncommittedOwnStyle:Boolean = false;
        protected var m_OwnStyle:int = 1;
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
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const WIDGET_STATUS_SKILLS:Array = [{value:SKILL_NONE}, {value:SKILL_LEVEL}, {value:SKILL_MAGLEVEL}, {value:SKILL_FIGHTFIST}, {value:SKILL_FIGHTCLUB}, {value:SKILL_FIGHTSWORD}, {value:SKILL_FIGHTAXE}, {value:SKILL_FIGHTDISTANCE}, {value:SKILL_FIGHTSHIELD}, {value:SKILL_FISHING}];
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const BLESSING_BLOOD_OF_THE_MOUNTAIN:int = BLESSING_HEART_OF_THE_MOUNTAIN << 1;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const STATE_PZ_ENTERED:int = 14;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const OTHER_STATUS_STYLES:Array = [{value:RendererImpl.STATUS_STYLE_CLASSIC, label:"STATUS_RENDERER_STATUS_STYLE_CLASSIC"}, {value:RendererImpl.STATUS_STYLE_OFF, label:"STATUS_RENDERER_STATUS_STYLE_OFF"}];
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const OWN_STATUS_STYLES:Array = [{value:RendererImpl.STATUS_STYLE_CLASSIC, label:"STATUS_RENDERER_STATUS_STYLE_CLASSIC"}, {value:RendererImpl.STATUS_STYLE_HUD, label:"STATUS_RENDERER_STATUS_STYLE_HUD"}, {value:RendererImpl.STATUS_STYLE_OFF, label:"STATUS_RENDERER_STATUS_STYLE_OFF"}];
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
        static const WIDGET_STATUS_STYLES:Array = [{value:StatusWidget.STATUS_STYLE_DEFAULT}, {value:StatusWidget.STATUS_STYLE_COMPACT}, {value:StatusWidget.STATUS_STYLE_PARALLEL}, {value:StatusWidget.STATUS_STYLE_FAT}, {value:StatusWidget.STATUS_STYLE_OFF}];
        static const SUMMON_OWN:int = 1;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_TWIST_OF_FATE << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_ADVENTURER << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
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
        static const TYPE_PLAYERSUMMON:int = 3;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_FIRE_OF_SUNS << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function StatusOptions()
        {
            label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_LABEL");
            return;
        }// end function

        public function close(param1:Boolean = false) : void
        {
            if (this.m_Options != null && param1 && this.m_UncommittedValues)
            {
                this.m_Options.statusPlayerStyle = this.m_OwnStyle;
                this.m_Options.statusPlayerName = this.m_UIOwnName.selected;
                this.m_Options.statusPlayerHealth = this.m_UIOwnHealth.selected;
                this.m_Options.statusPlayerMana = this.m_UIOwnMana.selected;
                this.m_Options.statusPlayerFlags = this.m_UIOwnFlags.selected;
                this.m_Options.statusCreatureStyle = this.m_OtherStyle;
                this.m_Options.statusCreatureName = this.m_UIOtherName.selected;
                this.m_Options.statusCreatureHealth = this.m_UIOtherHealth.selected;
                this.m_Options.statusCreatureFlags = this.m_UIOtherFlags.selected;
                this.m_Options.statusCreatureIcons = this.m_UIOtherIcons.selected;
                this.m_Options.statusCreaturePvpFrames = this.m_UIBothPvPFrames.selected;
                if (this.m_WidgetStyle == StatusWidget.STATUS_STYLE_OFF)
                {
                    this.m_Options.statusWidgetVisible = false;
                }
                else
                {
                    this.m_Options.statusWidgetStyle = this.m_WidgetStyle;
                    this.m_Options.statusWidgetVisible = true;
                }
                this.m_Options.statusWidgetSkill = this.m_WidgetSkill;
                this.m_UncommittedValues = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var LocalisedLabelFunction:Function;
            var LocalisedStyleLabelFunction:Function;
            var LocalisedSkillLabelFunction:Function;
            var Frm:Form;
            var Heading:FormHeading;
            var Item:FormItem;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                LocalisedLabelFunction = function (param1:Object) : String
            {
                if (param1.hasOwnProperty("label"))
                {
                    return resourceManager.getString(ConfigurationWidget.BUNDLE, param1.label);
                }
                return String(param1);
            }// end function
            ;
                LocalisedStyleLabelFunction = function (param1:Object) : String
            {
                var _loc_2:* = param1.hasOwnProperty("value") ? (int(param1.value)) : (StatusWidget.STATUS_STYLE_OFF);
                return StatusWidget.s_GetStyleName(_loc_2);
            }// end function
            ;
                LocalisedSkillLabelFunction = function (param1:Object) : String
            {
                var _loc_2:* = param1.hasOwnProperty("value") ? (int(param1.value)) : (SKILL_NONE);
                return StatusWidget.s_GetSkillName(_loc_2);
            }// end function
            ;
                Frm = new Form();
                Frm.styleName = "optionsConfigurationWidgetRootContainer";
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_PLAYER_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_PLAYER_STYLE");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOwnStyle = new ComboBox();
                this.m_UIOwnStyle.dataProvider = OWN_STATUS_STYLES;
                this.m_UIOwnStyle.dropdownFactory = new ClassFactory(CustomList);
                this.m_UIOwnStyle.labelField = "label";
                this.m_UIOwnStyle.labelFunction = LocalisedLabelFunction;
                this.m_UIOwnStyle.addEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UIOwnStyle.addEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UIOwnStyle.addEventListener(ListEvent.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOwnStyle);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_PLAYER_NAME");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOwnName = new CheckBox();
                this.m_UIOwnName.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOwnName);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_PLAYER_HEALTH");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOwnHealth = new CheckBox();
                this.m_UIOwnHealth.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOwnHealth);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_PLAYER_MANA");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOwnMana = new CheckBox();
                this.m_UIOwnMana.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOwnMana);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_PLAYER_FLAGS");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOwnFlags = new CheckBox();
                this.m_UIOwnFlags.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOwnFlags);
                Frm.addChild(Item);
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_STYLE");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UICreatureStyle = new ComboBox();
                this.m_UICreatureStyle.dataProvider = OTHER_STATUS_STYLES;
                this.m_UICreatureStyle.dropdownFactory = new ClassFactory(CustomList);
                this.m_UICreatureStyle.labelField = "label";
                this.m_UICreatureStyle.labelFunction = LocalisedLabelFunction;
                this.m_UICreatureStyle.addEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UICreatureStyle.addEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UICreatureStyle.addEventListener(ListEvent.CHANGE, this.onValueChange);
                Item.addChild(this.m_UICreatureStyle);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_NAME");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOtherName = new CheckBox();
                this.m_UIOtherName.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOtherName);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_HEALTH");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOtherHealth = new CheckBox();
                this.m_UIOtherHealth.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOtherHealth);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_FLAGS");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOtherFlags = new CheckBox();
                this.m_UIOtherFlags.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOtherFlags);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_ICONS");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIOtherIcons = new CheckBox();
                this.m_UIOtherIcons.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIOtherIcons);
                Frm.addChild(Item);
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_BOTH_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_CREATURE_PVPFRAMES");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIBothPvPFrames = new CheckBox();
                this.m_UIBothPvPFrames.addEventListener(Event.CHANGE, this.onValueChange);
                this.m_UIBothPvPFrames.enabled = this.m_Options.uiHints.canChangePvPFramingOption;
                Item.addChild(this.m_UIBothPvPFrames);
                Frm.addChild(Item);
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_WIDGET_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_WIDGET_STYLE");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIWidgetStyle = new ComboBox();
                this.m_UIWidgetStyle.dataProvider = WIDGET_STATUS_STYLES;
                this.m_UIWidgetStyle.dropdownFactory = new ClassFactory(CustomList);
                this.m_UIWidgetStyle.labelField = "value";
                this.m_UIWidgetStyle.labelFunction = LocalisedStyleLabelFunction;
                this.m_UIWidgetStyle.addEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UIWidgetStyle.addEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UIWidgetStyle.addEventListener(ListEvent.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIWidgetStyle);
                Frm.addChild(Item);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "STATUS_WIDGET_SKILL");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIWidgetSkill = new ComboBox();
                this.m_UIWidgetSkill.dataProvider = WIDGET_STATUS_SKILLS;
                this.m_UIWidgetSkill.dropdownFactory = new ClassFactory(CustomList);
                this.m_UIWidgetSkill.labelField = "value";
                this.m_UIWidgetSkill.labelFunction = LocalisedSkillLabelFunction;
                this.m_UIWidgetSkill.addEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UIWidgetSkill.addEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UIWidgetSkill.addEventListener(ListEvent.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIWidgetSkill);
                Frm.addChild(Item);
                addChild(Frm);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        private function onValueChange(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        protected function onComboBoxChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = -1;
                _loc_3 = null;
                switch(event.currentTarget)
                {
                    case this.m_UIOwnStyle:
                    {
                        _loc_2 = this.m_UIOwnStyle.selectedIndex;
                        if (_loc_2 >= 0 && _loc_2 < OWN_STATUS_STYLES.length)
                        {
                            this.m_OwnStyle = OWN_STATUS_STYLES[_loc_2].value;
                            this.m_UncommittedOwnStyle = true;
                            invalidateProperties();
                        }
                        break;
                    }
                    case this.m_UICreatureStyle:
                    {
                        _loc_2 = this.m_UICreatureStyle.selectedIndex;
                        if (_loc_2 >= 0 && _loc_2 < OTHER_STATUS_STYLES.length)
                        {
                            this.m_OtherStyle = OTHER_STATUS_STYLES[_loc_2].value;
                            this.m_UncommittedOtherStyle = true;
                            invalidateProperties();
                        }
                        break;
                    }
                    case this.m_UIWidgetStyle:
                    {
                        _loc_2 = this.m_UIWidgetStyle.selectedIndex;
                        if (_loc_2 >= 0 && _loc_2 < WIDGET_STATUS_STYLES.length)
                        {
                            this.m_WidgetStyle = WIDGET_STATUS_STYLES[_loc_2].value;
                            this.m_UncommittedWidgetStyle = true;
                            invalidateProperties();
                        }
                        break;
                    }
                    case this.m_UIWidgetSkill:
                    {
                        _loc_2 = this.m_UIWidgetSkill.selectedIndex;
                        if (_loc_2 >= 0 && _loc_2 < WIDGET_STATUS_SKILLS.length)
                        {
                            this.m_WidgetSkill = WIDGET_STATUS_SKILLS[_loc_2].value;
                            this.m_UncommittedWidgetSkill = true;
                            invalidateProperties();
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

        public function set options(param1:OptionsStorage) : void
        {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                if (this.m_Options != null)
                {
                    this.m_OwnStyle = this.m_Options.statusPlayerStyle;
                    this.m_UIOwnName.selected = this.m_Options.statusPlayerName;
                    this.m_UIOwnHealth.selected = this.m_Options.statusPlayerHealth;
                    this.m_UIOwnMana.selected = this.m_Options.statusPlayerMana;
                    this.m_UIOwnFlags.selected = this.m_Options.statusPlayerFlags;
                    this.m_OtherStyle = this.m_Options.statusCreatureStyle;
                    this.m_UIOtherName.selected = this.m_Options.statusCreatureName;
                    this.m_UIOtherHealth.selected = this.m_Options.statusCreatureHealth;
                    this.m_UIOtherFlags.selected = this.m_Options.statusCreatureFlags;
                    this.m_UIOtherIcons.selected = this.m_Options.statusCreatureIcons;
                    this.m_UIBothPvPFrames.selected = this.m_Options.statusCreaturePvpFrames;
                    this.m_WidgetStyle = this.m_Options.statusWidgetVisible ? (this.m_Options.statusWidgetStyle) : (StatusWidget.STATUS_STYLE_OFF);
                    this.m_WidgetSkill = this.m_Options.statusWidgetSkill;
                }
                else
                {
                    this.m_OwnStyle = RendererImpl.STATUS_STYLE_CLASSIC;
                    this.m_UIOwnName.selected = false;
                    this.m_UIOwnHealth.selected = false;
                    this.m_UIOwnMana.selected = false;
                    this.m_UIOwnFlags.selected = false;
                    this.m_OtherStyle = RendererImpl.STATUS_STYLE_CLASSIC;
                    this.m_UIOtherName.selected = false;
                    this.m_UIOtherHealth.selected = false;
                    this.m_UIOtherFlags.selected = false;
                    this.m_UIOtherIcons.selected = false;
                    this.m_UIBothPvPFrames.selected = false;
                    this.m_WidgetStyle = StatusWidget.STATUS_STYLE_OFF;
                    this.m_WidgetSkill = SKILL_EXPERIENCE;
                }
                this.m_UncommittedOwnStyle = true;
                this.m_UncommittedOtherStyle = true;
                this.m_UncommittedWidgetStyle = true;
                this.m_UncommittedOptions = false;
            }
            var _loc_1:* = false;
            if (this.m_UncommittedOwnStyle)
            {
                this.m_UIOwnStyle.selectedIndex = ArrayHelper.s_IndexOf(OWN_STATUS_STYLES, "value", this.m_OwnStyle);
                _loc_1 = this.m_OwnStyle != RendererImpl.STATUS_STYLE_OFF;
                this.m_UIOwnName.enabled = _loc_1;
                this.m_UIOwnHealth.enabled = _loc_1;
                this.m_UIOwnMana.enabled = _loc_1;
                this.m_UIOwnFlags.enabled = _loc_1;
                this.m_UncommittedOwnStyle = false;
            }
            if (this.m_UncommittedOtherStyle)
            {
                this.m_UICreatureStyle.selectedIndex = ArrayHelper.s_IndexOf(OTHER_STATUS_STYLES, "value", this.m_OtherStyle);
                _loc_1 = this.m_OtherStyle != RendererImpl.STATUS_STYLE_OFF;
                this.m_UIOtherName.enabled = _loc_1;
                this.m_UIOtherHealth.enabled = _loc_1;
                this.m_UIOtherFlags.enabled = _loc_1;
                this.m_UIOtherIcons.enabled = _loc_1;
                this.m_UncommittedOtherStyle = false;
            }
            if (this.m_UncommittedWidgetStyle)
            {
                this.m_UIWidgetStyle.selectedIndex = ArrayHelper.s_IndexOf(WIDGET_STATUS_STYLES, "value", this.m_WidgetStyle);
                _loc_1 = this.m_WidgetStyle != StatusWidget.STATUS_STYLE_OFF;
                this.m_UIWidgetSkill.enabled = _loc_1;
                this.m_UIWidgetSkill.selectedIndex = ArrayHelper.s_IndexOf(WIDGET_STATUS_SKILLS, "value", this.m_WidgetSkill);
                this.m_UncommittedWidgetStyle = false;
            }
            return;
        }// end function

    }
}

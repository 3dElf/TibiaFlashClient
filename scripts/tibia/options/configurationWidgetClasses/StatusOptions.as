package tibia.options.configurationWidgetClasses
{
   import mx.containers.VBox;
   import tibia.worldmap.widgetClasses.RendererImpl;
   import tibia.creatures.StatusWidget;
   import mx.controls.CheckBox;
   import mx.containers.Form;
   import mx.containers.FormItem;
   import mx.containers.FormHeading;
   import tibia.options.ConfigurationWidget;
   import mx.controls.ComboBox;
   import mx.core.ClassFactory;
   import shared.controls.CustomList;
   import mx.events.DropdownEvent;
   import mx.events.ListEvent;
   import flash.events.Event;
   import tibia.options.OptionsStorage;
   import shared.utility.ArrayHelper;
   
   public class StatusOptions extends VBox implements IOptionsEditor
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      protected static const WIDGET_STATUS_STYLES:Array = [{"value":StatusWidget.STATUS_STYLE_DEFAULT},{"value":StatusWidget.STATUS_STYLE_COMPACT},{"value":StatusWidget.STATUS_STYLE_PARALLEL},{"value":StatusWidget.STATUS_STYLE_FAT},{"value":StatusWidget.STATUS_STYLE_OFF}];
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const WIDGET_STATUS_SKILLS:Array = [{"value":SKILL_NONE},{"value":SKILL_LEVEL},{"value":SKILL_MAGLEVEL},{"value":SKILL_FIGHTFIST},{"value":SKILL_FIGHTCLUB},{"value":SKILL_FIGHTSWORD},{"value":SKILL_FIGHTAXE},{"value":SKILL_FIGHTDISTANCE},{"value":SKILL_FIGHTSHIELD},{"value":SKILL_FISHING}];
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const CREATURE_STATUS_STYLES:Array = [{
         "value":RendererImpl.STATUS_STYLE_CLASSIC,
         "label":"STATUS_RENDERER_STATUS_STYLE_CLASSIC"
      },{
         "value":RendererImpl.STATUS_STYLE_OFF,
         "label":"STATUS_RENDERER_STATUS_STYLE_OFF"
      }];
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const PLAYER_STATUS_STYLES:Array = [{
         "value":RendererImpl.STATUS_STYLE_CLASSIC,
         "label":"STATUS_RENDERER_STATUS_STYLE_CLASSIC"
      },{
         "value":RendererImpl.STATUS_STYLE_HUD,
         "label":"STATUS_RENDERER_STATUS_STYLE_HUD"
      },{
         "value":RendererImpl.STATUS_STYLE_OFF,
         "label":"STATUS_RENDERER_STATUS_STYLE_OFF"
      }];
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      protected var m_UICreatureFlags:CheckBox = null;
      
      protected var m_UIPlayerMana:CheckBox = null;
      
      private var m_UncommittedValues:Boolean = true;
      
      private var m_UncommittedWidgetSkill:Boolean = false;
      
      protected var m_UIPlayerFlags:CheckBox = null;
      
      private var m_UncommittedCreatureStyle:Boolean = false;
      
      protected var m_Options:OptionsStorage = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UICreatureStyle:ComboBox = null;
      
      protected var m_UICreatureName:CheckBox = null;
      
      protected var m_CreatureStyle:int = 1;
      
      protected var m_UICreatureHealth:CheckBox = null;
      
      protected var m_UIPlayerStyle:ComboBox = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      protected var m_UIWidgetStyle:ComboBox = null;
      
      protected var m_UIPlayerName:CheckBox = null;
      
      protected var m_WidgetStyle:int = 1;
      
      protected var m_PlayerStyle:int = 1;
      
      protected var m_UIPlayerHealth:CheckBox = null;
      
      protected var m_UIWidgetSkill:ComboBox = null;
      
      protected var m_WidgetSkill:int = 0;
      
      private var m_UncommittedWidgetStyle:Boolean = false;
      
      private var m_UncommittedPlayerStyle:Boolean = false;
      
      public function StatusOptions()
      {
         super();
         label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_LABEL");
      }
      
      public function close(param1:Boolean = false) : void
      {
         if(this.m_Options != null && Boolean(param1) && Boolean(this.m_UncommittedValues))
         {
            this.m_Options.statusPlayerStyle = this.m_PlayerStyle;
            this.m_Options.statusPlayerName = this.m_UIPlayerName.selected;
            this.m_Options.statusPlayerHealth = this.m_UIPlayerHealth.selected;
            this.m_Options.statusPlayerMana = this.m_UIPlayerMana.selected;
            this.m_Options.statusPlayerFlags = this.m_UIPlayerFlags.selected;
            this.m_Options.statusCreatureStyle = this.m_CreatureStyle;
            this.m_Options.statusCreatureName = this.m_UICreatureName.selected;
            this.m_Options.statusCreatureHealth = this.m_UICreatureHealth.selected;
            this.m_Options.statusCreatureFlags = this.m_UICreatureFlags.selected;
            if(this.m_WidgetStyle == StatusWidget.STATUS_STYLE_OFF)
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
      }
      
      override protected function createChildren() : void
      {
         var LocalisedLabelFunction:Function = null;
         var LocalisedStyleLabelFunction:Function = null;
         var LocalisedSkillLabelFunction:Function = null;
         var Frm:Form = null;
         var Heading:FormHeading = null;
         var Item:FormItem = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            LocalisedLabelFunction = function(param1:Object):String
            {
               if(param1.hasOwnProperty("label"))
               {
                  return resourceManager.getString(ConfigurationWidget.BUNDLE,param1.label);
               }
               return String(param1);
            };
            LocalisedStyleLabelFunction = function(param1:Object):String
            {
               var _loc2_:int = !!param1.hasOwnProperty("value")?int(int(param1.value)):int(StatusWidget.STATUS_STYLE_OFF);
               return StatusWidget.s_GetStyleName(_loc2_);
            };
            LocalisedSkillLabelFunction = function(param1:Object):String
            {
               var _loc2_:int = !!param1.hasOwnProperty("value")?int(int(param1.value)):int(SKILL_NONE);
               return StatusWidget.s_GetSkillName(_loc2_);
            };
            Frm = new Form();
            Frm.styleName = "optionsConfigurationWidgetRootContainer";
            Heading = new FormHeading();
            Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_PLAYER_HEADING");
            Heading.percentHeight = NaN;
            Heading.percentWidth = 100;
            Frm.addChild(Heading);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_PLAYER_STYLE");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIPlayerStyle = new ComboBox();
            this.m_UIPlayerStyle.dataProvider = PLAYER_STATUS_STYLES;
            this.m_UIPlayerStyle.dropdownFactory = new ClassFactory(CustomList);
            this.m_UIPlayerStyle.labelField = "label";
            this.m_UIPlayerStyle.labelFunction = LocalisedLabelFunction;
            this.m_UIPlayerStyle.addEventListener(DropdownEvent.CLOSE,this.onComboBoxChange);
            this.m_UIPlayerStyle.addEventListener(ListEvent.CHANGE,this.onComboBoxChange);
            this.m_UIPlayerStyle.addEventListener(ListEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIPlayerStyle);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_PLAYER_NAME");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIPlayerName = new CheckBox();
            this.m_UIPlayerName.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIPlayerName);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_PLAYER_HEALTH");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIPlayerHealth = new CheckBox();
            this.m_UIPlayerHealth.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIPlayerHealth);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_PLAYER_MANA");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIPlayerMana = new CheckBox();
            this.m_UIPlayerMana.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIPlayerMana);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_PLAYER_FLAGS");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIPlayerFlags = new CheckBox();
            this.m_UIPlayerFlags.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIPlayerFlags);
            Frm.addChild(Item);
            Heading = new FormHeading();
            Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_CREATURE_HEADING");
            Heading.percentHeight = NaN;
            Heading.percentWidth = 100;
            Frm.addChild(Heading);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_CREATURE_STYLE");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UICreatureStyle = new ComboBox();
            this.m_UICreatureStyle.dataProvider = CREATURE_STATUS_STYLES;
            this.m_UICreatureStyle.dropdownFactory = new ClassFactory(CustomList);
            this.m_UICreatureStyle.labelField = "label";
            this.m_UICreatureStyle.labelFunction = LocalisedLabelFunction;
            this.m_UICreatureStyle.addEventListener(DropdownEvent.CLOSE,this.onComboBoxChange);
            this.m_UICreatureStyle.addEventListener(ListEvent.CHANGE,this.onComboBoxChange);
            this.m_UICreatureStyle.addEventListener(ListEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UICreatureStyle);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_CREATURE_NAME");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UICreatureName = new CheckBox();
            this.m_UICreatureName.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UICreatureName);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_CREATURE_HEALTH");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UICreatureHealth = new CheckBox();
            this.m_UICreatureHealth.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UICreatureHealth);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_CREATURE_FLAGS");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UICreatureFlags = new CheckBox();
            this.m_UICreatureFlags.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UICreatureFlags);
            Frm.addChild(Item);
            Heading = new FormHeading();
            Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_WIDGET_HEADING");
            Heading.percentHeight = NaN;
            Heading.percentWidth = 100;
            Frm.addChild(Heading);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_WIDGET_STYLE");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIWidgetStyle = new ComboBox();
            this.m_UIWidgetStyle.dataProvider = WIDGET_STATUS_STYLES;
            this.m_UIWidgetStyle.dropdownFactory = new ClassFactory(CustomList);
            this.m_UIWidgetStyle.labelField = "value";
            this.m_UIWidgetStyle.labelFunction = LocalisedStyleLabelFunction;
            this.m_UIWidgetStyle.addEventListener(DropdownEvent.CLOSE,this.onComboBoxChange);
            this.m_UIWidgetStyle.addEventListener(ListEvent.CHANGE,this.onComboBoxChange);
            this.m_UIWidgetStyle.addEventListener(ListEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIWidgetStyle);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"STATUS_WIDGET_SKILL");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIWidgetSkill = new ComboBox();
            this.m_UIWidgetSkill.dataProvider = WIDGET_STATUS_SKILLS;
            this.m_UIWidgetSkill.dropdownFactory = new ClassFactory(CustomList);
            this.m_UIWidgetSkill.labelField = "value";
            this.m_UIWidgetSkill.labelFunction = LocalisedSkillLabelFunction;
            this.m_UIWidgetSkill.addEventListener(DropdownEvent.CLOSE,this.onComboBoxChange);
            this.m_UIWidgetSkill.addEventListener(ListEvent.CHANGE,this.onComboBoxChange);
            this.m_UIWidgetSkill.addEventListener(ListEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIWidgetSkill);
            Frm.addChild(Item);
            addChild(Frm);
            this.m_UIConstructed = true;
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      private function onValueChange(param1:Event) : void
      {
         var _loc2_:OptionsEditorEvent = null;
         if(param1 != null)
         {
            _loc2_ = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
            dispatchEvent(_loc2_);
         }
      }
      
      protected function onComboBoxChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         if(param1 != null)
         {
            _loc2_ = -1;
            _loc3_ = null;
            switch(param1.currentTarget)
            {
               case this.m_UIPlayerStyle:
                  _loc2_ = this.m_UIPlayerStyle.selectedIndex;
                  if(_loc2_ >= 0 && _loc2_ < PLAYER_STATUS_STYLES.length)
                  {
                     this.m_PlayerStyle = PLAYER_STATUS_STYLES[_loc2_].value;
                     this.m_UncommittedPlayerStyle = true;
                     invalidateProperties();
                  }
                  break;
               case this.m_UICreatureStyle:
                  _loc2_ = this.m_UICreatureStyle.selectedIndex;
                  if(_loc2_ >= 0 && _loc2_ < CREATURE_STATUS_STYLES.length)
                  {
                     this.m_CreatureStyle = CREATURE_STATUS_STYLES[_loc2_].value;
                     this.m_UncommittedCreatureStyle = true;
                     invalidateProperties();
                  }
                  break;
               case this.m_UIWidgetStyle:
                  _loc2_ = this.m_UIWidgetStyle.selectedIndex;
                  if(_loc2_ >= 0 && _loc2_ < WIDGET_STATUS_STYLES.length)
                  {
                     this.m_WidgetStyle = WIDGET_STATUS_STYLES[_loc2_].value;
                     this.m_UncommittedWidgetStyle = true;
                     invalidateProperties();
                  }
                  break;
               case this.m_UIWidgetSkill:
                  _loc2_ = this.m_UIWidgetSkill.selectedIndex;
                  if(_loc2_ >= 0 && _loc2_ < WIDGET_STATUS_SKILLS.length)
                  {
                     this.m_WidgetSkill = WIDGET_STATUS_SKILLS[_loc2_].value;
                     this.m_UncommittedWidgetSkill = true;
                     invalidateProperties();
                  }
            }
         }
      }
      
      public function set options(param1:OptionsStorage) : void
      {
         if(this.m_Options != param1)
         {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedOptions)
         {
            if(this.m_Options != null)
            {
               this.m_PlayerStyle = this.m_Options.statusPlayerStyle;
               this.m_UIPlayerName.selected = this.m_Options.statusPlayerName;
               this.m_UIPlayerHealth.selected = this.m_Options.statusPlayerHealth;
               this.m_UIPlayerMana.selected = this.m_Options.statusPlayerMana;
               this.m_UIPlayerFlags.selected = this.m_Options.statusPlayerFlags;
               this.m_CreatureStyle = this.m_Options.statusCreatureStyle;
               this.m_UICreatureName.selected = this.m_Options.statusCreatureName;
               this.m_UICreatureHealth.selected = this.m_Options.statusCreatureHealth;
               this.m_UICreatureFlags.selected = this.m_Options.statusCreatureFlags;
               this.m_WidgetStyle = !!this.m_Options.statusWidgetVisible?int(this.m_Options.statusWidgetStyle):int(StatusWidget.STATUS_STYLE_OFF);
               this.m_WidgetSkill = this.m_Options.statusWidgetSkill;
            }
            else
            {
               this.m_PlayerStyle = RendererImpl.STATUS_STYLE_CLASSIC;
               this.m_UIPlayerName.selected = false;
               this.m_UIPlayerHealth.selected = false;
               this.m_UIPlayerMana.selected = false;
               this.m_UIPlayerFlags.selected = false;
               this.m_CreatureStyle = RendererImpl.STATUS_STYLE_CLASSIC;
               this.m_UICreatureName.selected = false;
               this.m_UICreatureHealth.selected = false;
               this.m_UICreatureFlags.selected = false;
               this.m_WidgetStyle = StatusWidget.STATUS_STYLE_OFF;
               this.m_WidgetSkill = SKILL_EXPERIENCE;
            }
            this.m_UIPlayerStyle.selectedIndex = ArrayHelper.s_IndexOf(PLAYER_STATUS_STYLES,"value",this.m_PlayerStyle);
            this.m_UICreatureStyle.selectedIndex = ArrayHelper.s_IndexOf(CREATURE_STATUS_STYLES,"value",this.m_CreatureStyle);
            this.m_UIWidgetStyle.selectedIndex = ArrayHelper.s_IndexOf(WIDGET_STATUS_STYLES,"value",this.m_WidgetStyle);
            this.m_UIWidgetSkill.selectedIndex = ArrayHelper.s_IndexOf(WIDGET_STATUS_SKILLS,"value",this.m_WidgetSkill);
            this.m_UncommittedOptions = false;
         }
         var _loc1_:* = false;
         if(this.m_UncommittedPlayerStyle)
         {
            _loc1_ = this.m_PlayerStyle != RendererImpl.STATUS_STYLE_OFF;
            this.m_UIPlayerName.enabled = _loc1_;
            this.m_UIPlayerHealth.enabled = _loc1_;
            this.m_UIPlayerMana.enabled = _loc1_;
            this.m_UIPlayerFlags.enabled = _loc1_;
            this.m_UncommittedPlayerStyle = false;
         }
         if(this.m_UncommittedCreatureStyle)
         {
            _loc1_ = this.m_CreatureStyle != RendererImpl.STATUS_STYLE_OFF;
            this.m_UICreatureName.enabled = _loc1_;
            this.m_UICreatureHealth.enabled = _loc1_;
            this.m_UICreatureFlags.enabled = _loc1_;
            this.m_UncommittedCreatureStyle = false;
         }
         if(this.m_UncommittedWidgetStyle)
         {
            _loc1_ = this.m_WidgetStyle != StatusWidget.STATUS_STYLE_OFF;
            this.m_UIWidgetSkill.enabled = _loc1_;
            this.m_UncommittedWidgetStyle = false;
         }
      }
   }
}

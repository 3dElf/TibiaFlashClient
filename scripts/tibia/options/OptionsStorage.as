package tibia.options
{
   import flash.events.EventDispatcher;
   import tibia.creatures.StatusWidget;
   import tibia.chat.NameFilterSet;
   import tibia.chat.ChannelSet;
   import mx.events.PropertyChangeEvent;
   import shared.utility.XMLHelper;
   import tibia.help.TutorialHint;
   import tibia.market.marketWidgetClasses.AppearanceTypeBrowser;
   import tibia.chat.MessageFilterSet;
   import mx.events.PropertyChangeEventKind;
   import tibia.input.MappingSet;
   import tibia.trade.npcTradeWidgetClasses.ObjectRefSelectorBase;
   import tibia.container.ContainerStorage;
   import tibia.market.MarketWidget;
   import tibia.actionbar.ActionBarSet;
   import tibia.creatures.BuddySet;
   import flash.events.IEventDispatcher;
   import mx.events.CollectionEvent;
   import tibia.appearances.AppearanceType;
   import flash.events.Event;
   import tibia.sidebar.SideBarSet;
   import tibia.worldmap.widgetClasses.RendererImpl;
   import tibia.creatures.CreatureStorage;
   
   public class OptionsStorage extends EventDispatcher
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 4;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      public static const COMBAT_CHASE_OFF:int = 0;
      
      public static const COMBAT_SECURE_ON:int = 1;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const PK_PARTYMODE:int = 2;
      
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
      
      protected static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_NONE:int = -1;
      
      public static const COMBAT_ATTACK_DEFENSIVE:int = 3;
      
      protected static const SKILL_OFFLINETRAINING:int = 17;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      public static const COMBAT_SECURE_OFF:int = 0;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      private static const OPTION_GROUPS:Array = [{
         "XMLName":"general",
         "localName":"General"
      },{
         "XMLName":"renderer",
         "localName":"Renderer"
      },{
         "XMLName":"combat",
         "localName":"Combat"
      },{
         "XMLName":"status",
         "localName":"Status"
      },{
         "XMLName":"npctrade",
         "localName":"NPCTrade"
      },{
         "XMLName":"opponent",
         "localName":"Opponent"
      },{
         "XMLName":"help",
         "localName":"Help"
      },{
         "XMLName":"sidebarset",
         "localName":"SideBarSet"
      },{
         "XMLName":"actionbarset",
         "localName":"ActionBarSet"
      },{
         "XMLName":"mappingset",
         "localName":"MappingSet"
      },{
         "XMLName":"messagefilterset",
         "localName":"MessageFilterSet"
      },{
         "XMLName":"channelset",
         "localName":"ChannelSet"
      },{
         "XMLName":"namefilterset",
         "localName":"NameFilterSet"
      },{
         "XMLName":"buddyset",
         "localName":"BuddySet"
      },{
         "XMLName":"market",
         "localName":"Market"
      }];
      
      protected static const PROFESSION_DRUID:int = 4;
      
      public static const COMBAT_ATTACK_BALANCED:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      public static const COMBAT_CHASE_ON:int = 1;
      
      public static const COMBAT_ATTACK_OFFENSIVE:int = 1;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      private var m_MarketSelectedType:int = -1;
      
      private var m_StatusPlayerMana:Boolean = false;
      
      private var m_GeneralInputSetMode:int = -1;
      
      private var m_CombatChaseMode:int = -1;
      
      private var m_NPCTradeLayout:int = -1;
      
      private var m_StatusPlayerName:Boolean = false;
      
      private var m_GeneralInputClassicControls:Boolean = false;
      
      private var m_RendererLightEnabled:Boolean = false;
      
      private var m_GeneralUIGameWindowHeight:Number = -1;
      
      private var m_KnownTutorialHint:Vector.<int>;
      
      private var m_GeneralUIChatLeftViewWidth:Number = -1;
      
      private var m_MarketBrowserName:String = null;
      
      private var m_StatusPlayerStyle:int = -1;
      
      private var m_NPCTradeBuyIgnoreCapacity:Boolean = false;
      
      private var m_MarketBrowserLayout:int = -1;
      
      private var m_SideBarSet:Vector.<SideBarSet>;
      
      private var m_NPCTradeBuyWithBackpacks:Boolean = false;
      
      private var m_StatusCreatureHealth:Boolean = false;
      
      private var m_MarketBrowserLevel:Boolean = false;
      
      private var m_NPCTradeSellKeepEquipped:Boolean = false;
      
      private var m_StatusPlayerHealth:Boolean = false;
      
      private var m_MarketBrowserBodyPosition:int = -1;
      
      private var m_MarketBrowserEditor:int = -1;
      
      private var m_GeneralInputSetID:int = -1;
      
      private var m_StatusCreatureStyle:int = -1;
      
      private var m_GeneralActionBarsLock:Boolean = false;
      
      private var m_RendererShowFrameRate:Boolean = false;
      
      private var m_StatusWidgetStyle:int = -1;
      
      private var m_NameFilterSet:Vector.<NameFilterSet>;
      
      private var m_RendererAmbientBrightness:Number = -1;
      
      private var m_MessageFilterSet:Vector.<MessageFilterSet>;
      
      private var m_RendererScaleMap:Boolean = false;
      
      private var m_OpponentSort:int = -1;
      
      private var m_StatusWidgetLocation:int = -1;
      
      private var m_StatusPlayerFlags:Boolean = false;
      
      private var m_OpponentFilter:int = -1;
      
      private var m_BuddySet:Vector.<BuddySet>;
      
      private var m_MarketSelectedView:int = -1;
      
      private var m_MarketBrowserProfession:Boolean = false;
      
      private var m_MarketBrowserDepot:Boolean = false;
      
      private var m_CombatSecureMode:int = -1;
      
      private var m_ChannelSet:Vector.<ChannelSet>;
      
      private var m_RendererLevelSeparator:Number = -1;
      
      private var m_StatusWidgetSkill:int = -1;
      
      private var m_StatusCreatureName:Boolean = false;
      
      private var m_CombatAutoChaseOff:Boolean = false;
      
      private var m_StatusCreatureFlags:Boolean = false;
      
      private var m_CombatAttackMode:int = -1;
      
      private var m_ActionBarSet:Vector.<ActionBarSet>;
      
      private var m_StatusWidgetVisible:Boolean = false;
      
      private var m_MappingSet:Vector.<MappingSet>;
      
      private var m_NPCTradeSort:int = -1;
      
      private var m_MarketBrowserCategory:int = -1;
      
      private var m_RendererMaxFrameRate:int = -1;
      
      public function OptionsStorage()
      {
         var _loc1_:Object = null;
         var _loc2_:PropertyChangeEvent = null;
         var _loc3_:String = null;
         this.m_KnownTutorialHint = new Vector.<int>();
         this.m_SideBarSet = new Vector.<SideBarSet>();
         this.m_ActionBarSet = new Vector.<ActionBarSet>();
         this.m_MappingSet = new Vector.<MappingSet>();
         this.m_MessageFilterSet = new Vector.<MessageFilterSet>();
         this.m_ChannelSet = new Vector.<ChannelSet>();
         this.m_NameFilterSet = new Vector.<NameFilterSet>();
         this.m_BuddySet = new Vector.<BuddySet>();
         super();
         for each(_loc1_ in OPTION_GROUPS)
         {
            _loc3_ = "initialise" + _loc1_.localName;
            if(this.hasMethod(_loc3_))
            {
               this[_loc3_]();
            }
            else
            {
               log("OptionsStorage.OptionsStorage: No initialisation handler for: " + _loc1_.localName + ".");
            }
         }
         _loc2_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc2_.kind = PropertyChangeEventKind.UPDATE;
         _loc2_.property = "*";
         dispatchEvent(_loc2_);
      }
      
      private function set _1091413675statusWidgetLocation(param1:int) : void
      {
         if(param1 == StatusWidget.LOCATION_TOP || param1 == StatusWidget.LOCATION_BOTTOM || param1 == StatusWidget.LOCATION_LEFT || param1 == StatusWidget.LOCATION_RIGHT)
         {
            this.m_StatusWidgetLocation = param1;
            return;
         }
         throw new ArgumentError("OptionsStorage.set statusWidgetLocation: Invalid location: " + param1);
      }
      
      private function initialiseNameFilterSet() : void
      {
         this.removeAllListItems(this.m_NameFilterSet,null);
         this.addListItem(this.m_NameFilterSet,new NameFilterSet(NameFilterSet.DEFAULT_SET),null);
      }
      
      public function removeChannelSet(param1:int) : ChannelSet
      {
         return ChannelSet(this.removeListItem(this.m_ChannelSet,param1,"channelSet"));
      }
      
      private function marshallOpponent(param1:XML) : void
      {
         param1.appendChild(<opponent>
                          <sort>{this.m_OpponentSort}</sort>
                          <filter>{this.m_OpponentFilter}</filter>
                        </opponent>);
      }
      
      public function get statusCreatureHealth() : Boolean
      {
         return this.m_StatusCreatureHealth;
      }
      
      public function get npcTradeBuyIgnoreCapacity() : Boolean
      {
         return this.m_NPCTradeBuyIgnoreCapacity;
      }
      
      [Bindable(event="propertyChange")]
      public function set generalUIGameWindowHeight(param1:Number) : void
      {
         var _loc2_:Object = this.generalUIGameWindowHeight;
         if(_loc2_ !== param1)
         {
            this._1916522523generalUIGameWindowHeight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"generalUIGameWindowHeight",_loc2_,param1));
         }
      }
      
      public function get npcTradeLayout() : int
      {
         return this.m_NPCTradeLayout;
      }
      
      [Bindable(event="propertyChange")]
      public function set generalInputSetMode(param1:int) : void
      {
         var _loc2_:Object = this.generalInputSetMode;
         if(_loc2_ !== param1)
         {
            this._410094845generalInputSetMode = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"generalInputSetMode",_loc2_,param1));
         }
      }
      
      public function get statusPlayerStyle() : int
      {
         return this.m_StatusPlayerStyle;
      }
      
      private function unmarshallHelp(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null || param1.localName() != "help" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallHelp: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "knownTutorialHints":
                  for each(_loc4_ in _loc3_.elements("hint"))
                  {
                     _loc5_ = XMLHelper.s_UnmarshallInteger(_loc4_);
                     _loc6_ = this.getKnownTutorialHintIndex(_loc5_);
                     if(Boolean(TutorialHint.s_CheckHint(_loc5_)) && _loc6_ < 0)
                     {
                        this.m_KnownTutorialHint.splice(-_loc6_ - 1,0,_loc5_);
                     }
                  }
                  continue;
               default:
                  continue;
            }
         }
      }
      
      private function set _251830874statusPlayerMana(param1:Boolean) : void
      {
         this.m_StatusPlayerMana = param1;
      }
      
      private function hasMethod(param1:String) : Boolean
      {
         var a_Name:String = param1;
         var Result:Boolean = false;
         try
         {
            Result = this[a_Name] is Function;
         }
         catch(_Error:*)
         {
         }
         return Result;
      }
      
      public function get combatChaseMode() : int
      {
         return this.m_CombatChaseMode;
      }
      
      [Bindable(event="propertyChange")]
      public function set npcTradeBuyIgnoreCapacity(param1:Boolean) : void
      {
         var _loc2_:Object = this.npcTradeBuyIgnoreCapacity;
         if(_loc2_ !== param1)
         {
            this._120469519npcTradeBuyIgnoreCapacity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcTradeBuyIgnoreCapacity",_loc2_,param1));
         }
      }
      
      public function get combatAttackMode() : int
      {
         return this.m_CombatAttackMode;
      }
      
      private function set _1254385703marketBrowserEditor(param1:int) : void
      {
         if(param1 != AppearanceTypeBrowser.EDITOR_CATEGORY && param1 != AppearanceTypeBrowser.EDITOR_NAME)
         {
            param1 = AppearanceTypeBrowser.EDITOR_CATEGORY;
         }
         this.m_MarketBrowserEditor = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set statusCreatureHealth(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusCreatureHealth;
         if(_loc2_ !== param1)
         {
            this._1714951155statusCreatureHealth = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusCreatureHealth",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set npcTradeBuyWithBackpacks(param1:Boolean) : void
      {
         var _loc2_:Object = this.npcTradeBuyWithBackpacks;
         if(_loc2_ !== param1)
         {
            this._1147639562npcTradeBuyWithBackpacks = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcTradeBuyWithBackpacks",_loc2_,param1));
         }
      }
      
      public function removeMessageFilterSet(param1:int) : MessageFilterSet
      {
         return MessageFilterSet(this.removeListItem(this.m_MessageFilterSet,param1,"messageFilterSet"));
      }
      
      [Bindable(event="propertyChange")]
      public function set npcTradeLayout(param1:int) : void
      {
         var _loc2_:Object = this.npcTradeLayout;
         if(_loc2_ !== param1)
         {
            this._738874381npcTradeLayout = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcTradeLayout",_loc2_,param1));
         }
      }
      
      private function unmarshallRenderer(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         if(param1 == null || param1.localName() != "renderer" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallRenderer: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "lightEnabled":
                  this.m_RendererLightEnabled = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "ambientBrightness":
                  this.m_RendererAmbientBrightness = Math.max(0,Math.min(XMLHelper.s_UnmarshallDecimal(_loc3_),1));
                  continue;
               case "levelSeparator":
                  this.m_RendererLevelSeparator = Math.max(0,Math.min(XMLHelper.s_UnmarshallDecimal(_loc3_),1));
                  continue;
               case "scaleMap":
                  this.m_RendererScaleMap = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "maxFrameRate":
                  this.m_RendererMaxFrameRate = Math.max(10,Math.min(XMLHelper.s_UnmarshallInteger(_loc3_),60));
                  continue;
               case "showFrameRate":
                  this.m_RendererShowFrameRate = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      public function unmarshall(param1:*) : void
      {
         var Group:Object = null;
         var XMLNode:XML = null;
         var _Event:PropertyChangeEvent = null;
         var UnmarshallFunctionName:String = null;
         var InitialiseFunctioName:String = null;
         var a_Input:* = param1;
         var _XML:XML = null;
         if(a_Input is String)
         {
            try
            {
               _XML = XML(a_Input as String);
            }
            catch(_Error:*)
            {
            }
         }
         else if(a_Input is XML)
         {
            _XML = a_Input as XML;
         }
         if(_XML == null || _XML.localName() != "options")
         {
            throw new Error("OptionsStorage.unmarshall: Invalid root element: " + _XML.localName());
         }
         var Version:Number = _XML.@version;
         if(Version < OPTIONS_MIN_COMPATIBLE_VERSION || Version > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshall: Invalid version: " + Version);
         }
         Group = null;
         var UnmarshalledElements:Vector.<String> = new Vector.<String>();
         for each(XMLNode in _XML.elements())
         {
            for each(Group in OPTION_GROUPS)
            {
               if(Group.XMLName == XMLNode.localName())
               {
                  UnmarshallFunctionName = "unmarshall" + Group.localName;
                  if(this.hasMethod(UnmarshallFunctionName))
                  {
                     try
                     {
                        this[UnmarshallFunctionName](XMLNode,Version);
                        UnmarshalledElements.push(Group.localName);
                     }
                     catch(_Error:*)
                     {
                        log("OptionsStorage.unmarshall: Failed to unmarshall element: " + Group.localName + ".");
                     }
                  }
                  else
                  {
                     log("OptionsStorage.unmarshall: No unmarshall handler for: " + Group.localName + ".");
                  }
                  break;
               }
            }
         }
         for each(Group in OPTION_GROUPS)
         {
            if(UnmarshalledElements.indexOf(Group.localName) < 0)
            {
               InitialiseFunctioName = "initialise" + Group.localName;
               if(this.hasMethod(InitialiseFunctioName))
               {
                  this[InitialiseFunctioName]();
               }
               else
               {
                  log("OptionsStorage.unmarshall: No initialisation handler for: " + Group.localName + ".");
               }
            }
         }
         _Event = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _Event.property = "*";
         _Event.kind = PropertyChangeEventKind.UPDATE;
         dispatchEvent(_Event);
      }
      
      private function marshallStatus(param1:XML) : void
      {
         param1.appendChild(<status>
                          <widgetLocation>{this.m_StatusWidgetLocation}</widgetLocation>
                          <widgetSkill>{this.m_StatusWidgetSkill}</widgetSkill>
                          <widgetStyle>{this.m_StatusWidgetStyle}</widgetStyle>
                          <widgetVisible>{this.m_StatusWidgetVisible}</widgetVisible>
                          <playerStyle>{this.m_StatusPlayerStyle}</playerStyle>
                          <playerName>{this.m_StatusPlayerName}</playerName>
                          <playerHealth>{this.m_StatusPlayerHealth}</playerHealth>
                          <playerMana>{this.m_StatusPlayerMana}</playerMana>
                          <playerFlags>{this.m_StatusPlayerFlags}</playerFlags>
                          <creatureStyle>{this.m_StatusCreatureStyle}</creatureStyle>
                          <creatureName>{this.m_StatusCreatureName}</creatureName>
                          <creatureHealth>{this.m_StatusCreatureHealth}</creatureHealth>
                          <creatureFlags>{this.m_StatusCreatureFlags}</creatureFlags>
                        </status>);
      }
      
      private function initialiseGeneral() : void
      {
         this.m_GeneralActionBarsLock = false;
         this.m_GeneralInputClassicControls = false;
         this.m_GeneralInputSetID = MappingSet.DEFAULT_SET;
         this.m_GeneralInputSetMode = MappingSet.CHAT_MODE_ON;
         this.m_GeneralUIGameWindowHeight = 7500;
         this.m_GeneralUIChatLeftViewWidth = 100;
      }
      
      [Bindable(event="propertyChange")]
      public function set npcTradeSellKeepEquipped(param1:Boolean) : void
      {
         var _loc2_:Object = this.npcTradeSellKeepEquipped;
         if(_loc2_ !== param1)
         {
            this._2042619673npcTradeSellKeepEquipped = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcTradeSellKeepEquipped",_loc2_,param1));
         }
      }
      
      public function addMappingSet(param1:MappingSet) : MappingSet
      {
         return MappingSet(this.addListItem(this.m_MappingSet,param1,"mappingSet"));
      }
      
      [Bindable(event="propertyChange")]
      public function set statusWidgetSkill(param1:int) : void
      {
         var _loc2_:Object = this.statusWidgetSkill;
         if(_loc2_ !== param1)
         {
            this._2037454619statusWidgetSkill = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusWidgetSkill",_loc2_,param1));
         }
      }
      
      private function marshallMessageFilterSet(param1:XML) : void
      {
         var _loc2_:int = this.m_MessageFilterSet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_MessageFilterSet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      private function set _1408018027rendererScaleMap(param1:Boolean) : void
      {
         this.m_RendererScaleMap = param1;
      }
      
      private function unmarshallMappingSet(param1:XML, param2:Number) : void
      {
         var _loc3_:MappingSet = MappingSet.s_Unmarshall(param1,param2);
         if(this.m_MappingSet.length >= MappingSet.NUM_SETS && this.getListItem(this.m_MappingSet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallMappingSet: Too many sets.");
         }
         this.addListItem(this.m_MappingSet,_loc3_,null);
      }
      
      private function set _1893979327npcTradeSort(param1:int) : void
      {
         if(param1 != ObjectRefSelectorBase.SORT_NAME && param1 != ObjectRefSelectorBase.SORT_PRICE && param1 != ObjectRefSelectorBase.SORT_WEIGHT)
         {
            throw new ArgumentError("OptionsStorage.set npcTradeSort: Invalid value: " + param1 + ".");
         }
         this.m_NPCTradeSort = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set combatAttackMode(param1:int) : void
      {
         var _loc2_:Object = this.combatAttackMode;
         if(_loc2_ !== param1)
         {
            this._251195935combatAttackMode = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"combatAttackMode",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set combatChaseMode(param1:int) : void
      {
         var _loc2_:Object = this.combatChaseMode;
         if(_loc2_ !== param1)
         {
            this._558862877combatChaseMode = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"combatChaseMode",_loc2_,param1));
         }
      }
      
      private function set _1147639562npcTradeBuyWithBackpacks(param1:Boolean) : void
      {
         this.m_NPCTradeBuyWithBackpacks = param1;
      }
      
      public function get marketSelectedView() : int
      {
         return this.m_MarketSelectedView;
      }
      
      private function set _1191209559marketBrowserBodyPosition(param1:int) : void
      {
         if(param1 != ContainerStorage.BODY_BOTH_HANDS && param1 != ContainerStorage.BODY_LEFT_HAND)
         {
            param1 = -1;
         }
         this.m_MarketBrowserBodyPosition = param1;
      }
      
      public function getBuddySetIDs() : Array
      {
         return this.getListIDs(this.m_BuddySet);
      }
      
      private function getListItem(param1:*, param2:int) : *
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            if(_loc3_.ID == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get marketBrowserDepot() : Boolean
      {
         return this.m_MarketBrowserDepot;
      }
      
      public function getChannelSetIDs() : Array
      {
         return this.getListIDs(this.m_ChannelSet);
      }
      
      public function addMessageFilterSet(param1:MessageFilterSet) : MessageFilterSet
      {
         return MessageFilterSet(this.addListItem(this.m_MessageFilterSet,param1,"messageFilterSet"));
      }
      
      public function getNameFilterSetIDs() : Array
      {
         return this.getListIDs(this.m_NameFilterSet);
      }
      
      private function unmarshallNPCTrade(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == null || param1.localName() != "npctrade" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallNPCTrade: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "buyIgnoreCapacity":
                  this.m_NPCTradeBuyIgnoreCapacity = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "buyWithBackpacks":
                  this.m_NPCTradeBuyWithBackpacks = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "sellKeepEquipped":
                  this.m_NPCTradeSellKeepEquipped = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "sort":
                  _loc4_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc4_ == ObjectRefSelectorBase.SORT_NAME || _loc4_ == ObjectRefSelectorBase.SORT_PRICE || _loc4_ == ObjectRefSelectorBase.SORT_WEIGHT)
                  {
                     this.m_NPCTradeSort = _loc4_;
                  }
                  continue;
               case "layout":
                  _loc5_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc5_ == ObjectRefSelectorBase.LAYOUT_GRID || _loc5_ == ObjectRefSelectorBase.LAYOUT_LIST)
                  {
                     this.m_NPCTradeLayout = _loc5_;
                  }
                  continue;
               default:
                  continue;
            }
         }
      }
      
      public function getChannelSet(param1:int) : ChannelSet
      {
         return ChannelSet(this.getListItem(this.m_ChannelSet,param1));
      }
      
      public function get marketBrowserBodyPosition() : int
      {
         return this.m_MarketBrowserBodyPosition;
      }
      
      private function set _960463546generalInputClassicControls(param1:Boolean) : void
      {
         this.m_GeneralInputClassicControls = param1;
      }
      
      public function get statusPlayerMana() : Boolean
      {
         return this.m_StatusPlayerMana;
      }
      
      public function get generalInputSetID() : int
      {
         return this.m_GeneralInputSetID;
      }
      
      private function set _449599592marketBrowserLevel(param1:Boolean) : void
      {
         this.m_MarketBrowserLevel = param1;
      }
      
      private function set _2037454619statusWidgetSkill(param1:int) : void
      {
         this.m_StatusWidgetSkill = param1;
      }
      
      public function removeMappingSet(param1:int) : MappingSet
      {
         return MappingSet(this.removeListItem(this.m_MappingSet,param1,"mappingSet"));
      }
      
      private function initialiseMessageFilterSet() : void
      {
         this.removeAllListItems(this.m_MessageFilterSet,null);
         this.addListItem(this.m_MessageFilterSet,new MessageFilterSet(MessageFilterSet.DEFAULT_SET),null);
      }
      
      private function set _131184534marketBrowserCategory(param1:int) : void
      {
         if(!MarketWidget.isValidCategoryID(param1))
         {
            param1 = MarketWidget.CATEGORY_AMULETS;
         }
         this.m_MarketBrowserCategory = param1;
      }
      
      private function set _1843511116rendererMaxFrameRate(param1:int) : void
      {
         this.m_RendererMaxFrameRate = Math.max(10,Math.min(param1,60));
      }
      
      public function addNameFilterSet(param1:NameFilterSet) : NameFilterSet
      {
         return NameFilterSet(this.addListItem(this.m_NameFilterSet,param1,"nameFilterSet"));
      }
      
      public function addActionBarSet(param1:ActionBarSet) : ActionBarSet
      {
         return ActionBarSet(this.addListItem(this.m_ActionBarSet,param1,"actionBarSet"));
      }
      
      public function removeBuddySet(param1:int) : BuddySet
      {
         return BuddySet(this.removeListItem(this.m_BuddySet,param1,"buddySet"));
      }
      
      private function set _2103194300statusWidgetVisible(param1:Boolean) : void
      {
         this.m_StatusWidgetVisible = param1;
      }
      
      private function set _1731192988rendererLevelSeparator(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         this.m_RendererLevelSeparator = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set statusPlayerStyle(param1:int) : void
      {
         var _loc2_:Object = this.statusPlayerStyle;
         if(_loc2_ !== param1)
         {
            this._777059330statusPlayerStyle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusPlayerStyle",_loc2_,param1));
         }
      }
      
      public function get marketBrowserCategory() : int
      {
         return this.m_MarketBrowserCategory;
      }
      
      private function set _789326636statusPlayerFlags(param1:Boolean) : void
      {
         this.m_StatusPlayerFlags = param1;
      }
      
      private function marshallBuddySet(param1:XML) : void
      {
         var _loc2_:int = this.m_BuddySet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_BuddySet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      private function marshallGeneral(param1:XML) : void
      {
         var _loc2_:int = -1;
         switch(this.m_GeneralInputSetMode)
         {
            case MappingSet.CHAT_MODE_OFF:
            case MappingSet.CHAT_MODE_TEMPORARY:
               _loc2_ = MappingSet.CHAT_MODE_OFF;
               break;
            case MappingSet.CHAT_MODE_ON:
               _loc2_ = MappingSet.CHAT_MODE_ON;
         }
         param1.appendChild(<general>
                          <actionBarsLock>{this.m_GeneralActionBarsLock}</actionBarsLock>
                          <inputClassicControls>{this.m_GeneralInputClassicControls}</inputClassicControls>
                          <inputSetID>{this.m_GeneralInputSetID}</inputSetID>
                          <inputSetMode>{_loc2_}</inputSetMode>
                          <uiGameWindowHeight>{this.m_GeneralUIGameWindowHeight}</uiGameWindowHeight>
                          <uiChatLeftViewWidth>{this.m_GeneralUIChatLeftViewWidth}</uiChatLeftViewWidth>
                        </general>);
      }
      
      public function get statusWidgetStyle() : int
      {
         return this.m_StatusWidgetStyle;
      }
      
      private function set _2037738107statusWidgetStyle(param1:int) : void
      {
         if(param1 == StatusWidget.STATUS_STYLE_COMPACT || param1 == StatusWidget.STATUS_STYLE_DEFAULT || param1 == StatusWidget.STATUS_STYLE_FAT || param1 == StatusWidget.STATUS_STYLE_PARALLEL)
         {
            this.m_StatusWidgetStyle = param1;
            return;
         }
         throw new ArgumentError("OptionsStorage.set statusWidgetStyle: Invalid style: " + param1);
      }
      
      private function initialiseChannelSet() : void
      {
         this.removeAllListItems(this.m_ChannelSet,null);
         this.addListItem(this.m_ChannelSet,new ChannelSet(ChannelSet.DEFAULT_SET),null);
      }
      
      [Bindable(event="propertyChange")]
      public function set marketSelectedView(param1:int) : void
      {
         var _loc2_:Object = this.marketSelectedView;
         if(_loc2_ !== param1)
         {
            this._356338236marketSelectedView = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketSelectedView",_loc2_,param1));
         }
      }
      
      private function set _1918651986rendererLightEnabled(param1:Boolean) : void
      {
         this.m_RendererLightEnabled = param1;
      }
      
      public function get statusCreatureName() : Boolean
      {
         return this.m_StatusCreatureName;
      }
      
      public function get combatAutoChaseOff() : Boolean
      {
         return this.m_CombatAutoChaseOff;
      }
      
      public function get rendererAmbientBrightness() : Number
      {
         return this.m_RendererAmbientBrightness;
      }
      
      [Bindable(event="propertyChange")]
      public function set npcTradeSort(param1:int) : void
      {
         var _loc2_:Object = this.npcTradeSort;
         if(_loc2_ !== param1)
         {
            this._1893979327npcTradeSort = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcTradeSort",_loc2_,param1));
         }
      }
      
      private function initialiseCombat() : void
      {
         this.m_CombatAttackMode = COMBAT_ATTACK_BALANCED;
         this.m_CombatAutoChaseOff = true;
         this.m_CombatChaseMode = COMBAT_CHASE_OFF;
         this.m_CombatSecureMode = COMBAT_SECURE_ON;
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserDepot(param1:Boolean) : void
      {
         var _loc2_:Object = this.marketBrowserDepot;
         if(_loc2_ !== param1)
         {
            this._456993208marketBrowserDepot = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserDepot",_loc2_,param1));
         }
      }
      
      private function addListItem(param1:*, param2:*, param3:String) : *
      {
         var _loc7_:PropertyChangeEvent = null;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc4_:* = this.removeListItem(param1,param2.ID,null);
         var _loc5_:int = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_ && param1[_loc6_].ID <= param2.ID)
         {
            _loc6_++;
         }
         param1.splice(_loc6_,0,param2);
         if(param2 is IEventDispatcher)
         {
            IEventDispatcher(param2).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onListItemEvent);
            IEventDispatcher(param2).addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onListItemEvent);
         }
         if(param3 != null)
         {
            _loc7_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc7_.kind = PropertyChangeEventKind.UPDATE;
            _loc7_.property = param3;
            dispatchEvent(_loc7_);
         }
         return _loc4_;
      }
      
      [Bindable(event="propertyChange")]
      public function set generalInputClassicControls(param1:Boolean) : void
      {
         var _loc2_:Object = this.generalInputClassicControls;
         if(_loc2_ !== param1)
         {
            this._960463546generalInputClassicControls = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"generalInputClassicControls",_loc2_,param1));
         }
      }
      
      private function set _356294353marketSelectedType(param1:*) : void
      {
         if(param1 is AppearanceType)
         {
            this.m_MarketSelectedType = AppearanceType(param1).ID;
         }
         else
         {
            this.m_MarketSelectedType = int(param1);
         }
      }
      
      public function marshall() : XML
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc1_:XML = <options version="{OPTIONS_MAX_COMPATIBLE_VERSION}"></options>;
         for each(_loc2_ in OPTION_GROUPS)
         {
            _loc3_ = "marshall" + _loc2_.localName;
            if(this.hasMethod(_loc3_))
            {
               this[_loc3_](_loc1_);
            }
            else
            {
               log("OptionsStorage.unmarshall: No unmarshall handler for: " + _loc2_.localName + ".");
            }
         }
         return _loc1_;
      }
      
      private function marshallMarket(param1:XML) : void
      {
         param1.appendChild(<market>
                          <browserLayout>{this.m_MarketBrowserLayout}</browserLayout>
                          <browserEditor>{this.m_MarketBrowserEditor}</browserEditor>
                          <browserDepot>{this.m_MarketBrowserDepot}</browserDepot>
                          <browserCategory>{this.m_MarketBrowserCategory}</browserCategory>
                          <browserLevel>{this.m_MarketBrowserLevel}</browserLevel>
                          <browserProfession>{this.m_MarketBrowserProfession}</browserProfession>
                          <browserBodyPosition>{this.m_MarketBrowserBodyPosition}</browserBodyPosition>
                          <browserName>{this.m_MarketBrowserName}</browserName>
                          <selectedView>{this.m_MarketSelectedView}</selectedView>
                          <selectedType>{this.m_MarketSelectedType}</selectedType>
                        </market>);
      }
      
      private function initialiseHelp() : void
      {
         this.m_KnownTutorialHint.length = 0;
      }
      
      public function get opponentSort() : int
      {
         return this.m_OpponentSort;
      }
      
      public function get statusPlayerName() : Boolean
      {
         return this.m_StatusPlayerName;
      }
      
      private function unmarshallNameFilterSet(param1:XML, param2:Number) : void
      {
         var _loc3_:NameFilterSet = NameFilterSet.s_Unmarshall(param1,param2);
         if(this.m_NameFilterSet.length >= NameFilterSet.NUM_SETS && this.getListItem(this.m_NameFilterSet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallNameFilterSet: Too many sets.");
         }
         this.addListItem(this.m_NameFilterSet,_loc3_,null);
      }
      
      private function initialiseRenderer() : void
      {
         this.m_RendererAmbientBrightness = 0.25;
         this.m_RendererLevelSeparator = 0.33;
         this.m_RendererLightEnabled = false;
         this.m_RendererMaxFrameRate = 50;
         this.m_RendererScaleMap = true;
         this.m_RendererShowFrameRate = false;
      }
      
      [Bindable(event="propertyChange")]
      public function set opponentFilter(param1:int) : void
      {
         var _loc2_:Object = this.opponentFilter;
         if(_loc2_ !== param1)
         {
            this._999334091opponentFilter = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"opponentFilter",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set rendererMaxFrameRate(param1:int) : void
      {
         var _loc2_:Object = this.rendererMaxFrameRate;
         if(_loc2_ !== param1)
         {
            this._1843511116rendererMaxFrameRate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rendererMaxFrameRate",_loc2_,param1));
         }
      }
      
      public function getMappingSet(param1:int) : MappingSet
      {
         return MappingSet(this.getListItem(this.m_MappingSet,param1));
      }
      
      public function get statusWidgetLocation() : int
      {
         return this.m_StatusWidgetLocation;
      }
      
      [Bindable(event="propertyChange")]
      public function set generalUIChatLeftViewWidth(param1:Number) : void
      {
         var _loc2_:Object = this.generalUIChatLeftViewWidth;
         if(_loc2_ !== param1)
         {
            this._1252438854generalUIChatLeftViewWidth = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"generalUIChatLeftViewWidth",_loc2_,param1));
         }
      }
      
      private function set _512938034combatSecureMode(param1:int) : void
      {
         if(param1 != COMBAT_SECURE_OFF && param1 != COMBAT_SECURE_ON)
         {
            throw new ArgumentError("OptionsStorage.set combatSecureMode: Invalid mode.");
         }
         this.m_CombatSecureMode = param1;
      }
      
      private function onListItemEvent(param1:Event) : void
      {
         if(param1 != null && (!param1.cancelable || !param1.isDefaultPrevented()))
         {
            dispatchEvent(param1);
         }
      }
      
      private function unmarshallOpponent(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         if(param1 == null || param1.localName() != "opponent" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallOpponent: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "sort":
                  this.m_OpponentSort = XMLHelper.s_UnmarshallInteger(_loc3_);
                  continue;
               case "filter":
                  this.m_OpponentFilter = XMLHelper.s_UnmarshallInteger(_loc3_);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      private function marshallSideBarSet(param1:XML) : void
      {
         var _loc2_:int = this.m_SideBarSet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_SideBarSet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserBodyPosition(param1:int) : void
      {
         var _loc2_:Object = this.marketBrowserBodyPosition;
         if(_loc2_ !== param1)
         {
            this._1191209559marketBrowserBodyPosition = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserBodyPosition",_loc2_,param1));
         }
      }
      
      public function get statusCreatureFlags() : Boolean
      {
         return this.m_StatusCreatureFlags;
      }
      
      [Bindable(event="propertyChange")]
      public function set statusPlayerMana(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusPlayerMana;
         if(_loc2_ !== param1)
         {
            this._251830874statusPlayerMana = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusPlayerMana",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set generalInputSetID(param1:int) : void
      {
         var _loc2_:Object = this.generalInputSetID;
         if(_loc2_ !== param1)
         {
            this._442884517generalInputSetID = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"generalInputSetID",_loc2_,param1));
         }
      }
      
      private function unmarshallGeneral(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         if(param1 == null || param1.localName() != "general" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallGeneral: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "actionBarsLock":
                  this.m_GeneralActionBarsLock = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "inputClassicControls":
                  this.m_GeneralInputClassicControls = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "inputSetID":
                  this.m_GeneralInputSetID = XMLHelper.s_UnmarshallInteger(_loc3_);
                  continue;
               case "inputSetMode":
                  _loc4_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc4_ == MappingSet.CHAT_MODE_OFF || _loc4_ == MappingSet.CHAT_MODE_ON)
                  {
                     this.m_GeneralInputSetMode = _loc4_;
                  }
                  continue;
               case "uiGameWindowHeight":
                  this.m_GeneralUIGameWindowHeight = Math.max(0,Math.min(XMLHelper.s_UnmarshallDecimal(_loc3_),10000));
                  continue;
               case "uiChatLeftViewWidth":
                  this.m_GeneralUIChatLeftViewWidth = Math.max(0,Math.min(XMLHelper.s_UnmarshallDecimal(_loc3_),100));
                  continue;
               default:
                  continue;
            }
         }
      }
      
      public function get statusWidgetVisible() : Boolean
      {
         return this.m_StatusWidgetVisible;
      }
      
      private function getKnownTutorialHintIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this.m_KnownTutorialHint.length - 1;
         var _loc4_:int = 0;
         while(_loc2_ <= _loc3_)
         {
            _loc4_ = (_loc2_ + _loc3_) / 2;
            if(this.m_KnownTutorialHint[_loc4_] < param1)
            {
               _loc2_ = _loc4_ + 1;
               continue;
            }
            if(this.m_KnownTutorialHint[_loc4_] > param1)
            {
               _loc3_ = _loc4_ - 1;
               continue;
            }
            return _loc4_;
         }
         return -_loc2_ - 1;
      }
      
      [Bindable(event="propertyChange")]
      public function set rendererLevelSeparator(param1:Number) : void
      {
         var _loc2_:Object = this.rendererLevelSeparator;
         if(_loc2_ !== param1)
         {
            this._1731192988rendererLevelSeparator = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rendererLevelSeparator",_loc2_,param1));
         }
      }
      
      private function set _1823004292combatAutoChaseOff(param1:Boolean) : void
      {
         this.m_CombatAutoChaseOff = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserProfession(param1:Boolean) : void
      {
         var _loc2_:Object = this.marketBrowserProfession;
         if(_loc2_ !== param1)
         {
            this._273891688marketBrowserProfession = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserProfession",_loc2_,param1));
         }
      }
      
      public function get marketSelectedType() : int
      {
         return this.m_MarketSelectedType;
      }
      
      private function marshallActionBarSet(param1:XML) : void
      {
         var _loc2_:int = this.m_ActionBarSet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_ActionBarSet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      private function set _777059330statusPlayerStyle(param1:int) : void
      {
         if(param1 == RendererImpl.STATUS_STYLE_OFF || param1 == RendererImpl.STATUS_STYLE_CLASSIC || param1 == RendererImpl.STATUS_STYLE_HUD)
         {
            this.m_StatusPlayerStyle = param1;
            return;
         }
         throw new ArgumentError("OptionsStorage.set statusPlayerStyle: Invalid style: " + param1);
      }
      
      private function set _456993208marketBrowserDepot(param1:Boolean) : void
      {
         this.m_MarketBrowserDepot = param1;
      }
      
      private function initialiseNPCTrade() : void
      {
         this.m_NPCTradeBuyIgnoreCapacity = false;
         this.m_NPCTradeBuyWithBackpacks = false;
         this.m_NPCTradeLayout = ObjectRefSelectorBase.LAYOUT_LIST;
         this.m_NPCTradeSellKeepEquipped = true;
         this.m_NPCTradeSort = ObjectRefSelectorBase.SORT_NAME;
      }
      
      public function get statusPlayerFlags() : Boolean
      {
         return this.m_StatusPlayerFlags;
      }
      
      private function set _1351476655statusPlayerHealth(param1:Boolean) : void
      {
         this.m_StatusPlayerHealth = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set generalActionBarsLock(param1:Boolean) : void
      {
         var _loc2_:Object = this.generalActionBarsLock;
         if(_loc2_ !== param1)
         {
            this._259410793generalActionBarsLock = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"generalActionBarsLock",_loc2_,param1));
         }
      }
      
      private function initialiseMappingSet() : void
      {
         this.removeAllListItems(this.m_MappingSet,null);
         var _loc1_:MappingSet = new MappingSet(MappingSet.DEFAULT_SET);
         _loc1_.initialiseDefaultBindings();
         this.addListItem(this.m_MappingSet,_loc1_,null);
      }
      
      private function marshallHelp(param1:XML) : void
      {
         var _loc2_:XML = <knownTutorialHints/>;
         var _loc3_:int = 0;
         var _loc4_:int = this.m_KnownTutorialHint.length;
         while(_loc3_ < _loc4_)
         {
            _loc2_.appendChild(<hint>{this.m_KnownTutorialHint[_loc3_]}</hint>);
            _loc3_++;
         }
         param1.appendChild(<help>
                          {_loc2_}
                        </help>);
      }
      
      [Bindable(event="propertyChange")]
      public function set rendererShowFrameRate(param1:Boolean) : void
      {
         var _loc2_:Object = this.rendererShowFrameRate;
         if(_loc2_ !== param1)
         {
            this._1621507731rendererShowFrameRate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rendererShowFrameRate",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserCategory(param1:int) : void
      {
         var _loc2_:Object = this.marketBrowserCategory;
         if(_loc2_ !== param1)
         {
            this._131184534marketBrowserCategory = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserCategory",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set statusCreatureName(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusCreatureName;
         if(_loc2_ !== param1)
         {
            this._1361517692statusCreatureName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusCreatureName",_loc2_,param1));
         }
      }
      
      public function getMessageFilterSet(param1:int) : MessageFilterSet
      {
         return MessageFilterSet(this.getListItem(this.m_MessageFilterSet,param1));
      }
      
      [Bindable(event="propertyChange")]
      public function set statusWidgetStyle(param1:int) : void
      {
         var _loc2_:Object = this.statusWidgetStyle;
         if(_loc2_ !== param1)
         {
            this._2037738107statusWidgetStyle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusWidgetStyle",_loc2_,param1));
         }
      }
      
      private function set _1916522523generalUIGameWindowHeight(param1:Number) : void
      {
         this.m_GeneralUIGameWindowHeight = Math.max(0,Math.min(param1,100));
      }
      
      private function set _442884517generalInputSetID(param1:int) : void
      {
         if(this.getActionBarSet(param1) == null || this.getMappingSet(param1) == null)
         {
            throw new ArgumentError("OptionsStorage.set generalInputSetID: Invalid set ID.");
         }
         this.m_GeneralInputSetID = param1;
      }
      
      public function get generalInputSetMode() : int
      {
         return this.m_GeneralInputSetMode;
      }
      
      private function unmarshallActionBarSet(param1:XML, param2:Number) : void
      {
         var _loc3_:ActionBarSet = ActionBarSet.s_Unmarshall(param1,param2);
         if(this.m_ActionBarSet.length >= ActionBarSet.NUM_SETS && this.getListItem(this.m_ActionBarSet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallActionBarSet: Too many sets.");
         }
         this.addListItem(this.m_ActionBarSet,_loc3_,null);
      }
      
      private function set _999334091opponentFilter(param1:int) : void
      {
         this.m_OpponentFilter = param1;
      }
      
      public function addSideBarSet(param1:SideBarSet) : SideBarSet
      {
         return SideBarSet(this.addListItem(this.m_SideBarSet,param1,"sideBarSet"));
      }
      
      private function unmarshallStatus(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1 == null || param1.localName() != "status" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallStatus: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "widgetLocation":
                  _loc4_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc4_ == StatusWidget.LOCATION_TOP || _loc4_ == StatusWidget.LOCATION_BOTTOM || _loc4_ == StatusWidget.LOCATION_LEFT || _loc4_ == StatusWidget.LOCATION_RIGHT)
                  {
                     this.m_StatusWidgetLocation = _loc4_;
                  }
                  continue;
               case "widgetStyle":
                  _loc5_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc5_ == StatusWidget.STATUS_STYLE_OFF)
                  {
                     this.m_StatusWidgetVisible = false;
                  }
                  else if(_loc5_ == StatusWidget.STATUS_STYLE_COMPACT || _loc5_ == StatusWidget.STATUS_STYLE_DEFAULT || _loc5_ == StatusWidget.STATUS_STYLE_FAT || _loc5_ == StatusWidget.STATUS_STYLE_PARALLEL)
                  {
                     this.m_StatusWidgetStyle = _loc5_;
                  }
                  continue;
               case "widgetSkill":
                  _loc6_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(StatusWidget.s_GetSkillName(_loc6_) != null)
                  {
                     this.m_StatusWidgetSkill = _loc6_;
                  }
                  continue;
               case "widgetVisible":
                  this.m_StatusWidgetVisible = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "playerStyle":
                  _loc7_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc7_ == RendererImpl.STATUS_STYLE_OFF || _loc7_ == RendererImpl.STATUS_STYLE_CLASSIC || _loc7_ == RendererImpl.STATUS_STYLE_HUD)
                  {
                     this.m_StatusPlayerStyle = _loc7_;
                  }
                  continue;
               case "playerName":
                  this.m_StatusPlayerName = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "playerFlags":
                  this.m_StatusPlayerFlags = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "playerHealth":
                  this.m_StatusPlayerHealth = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "playerMana":
                  this.m_StatusPlayerMana = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "creatureStyle":
                  _loc8_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc8_ == RendererImpl.STATUS_STYLE_OFF || _loc8_ == RendererImpl.STATUS_STYLE_CLASSIC || _loc8_ == RendererImpl.STATUS_STYLE_HUD)
                  {
                     this.m_StatusCreatureStyle = _loc8_;
                  }
                  continue;
               case "creatureName":
                  this.m_StatusCreatureName = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "creatureFlags":
                  this.m_StatusCreatureFlags = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "creatureHealth":
                  this.m_StatusCreatureHealth = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set rendererAmbientBrightness(param1:Number) : void
      {
         var _loc2_:Object = this.rendererAmbientBrightness;
         if(_loc2_ !== param1)
         {
            this._1869292922rendererAmbientBrightness = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rendererAmbientBrightness",_loc2_,param1));
         }
      }
      
      public function unload() : void
      {
         this.removeAllListItems(this.m_SideBarSet,null);
         this.removeAllListItems(this.m_ActionBarSet,null);
         this.removeAllListItems(this.m_MappingSet,null);
         this.removeAllListItems(this.m_MessageFilterSet,null);
         this.removeAllListItems(this.m_ChannelSet,null);
         this.removeAllListItems(this.m_NameFilterSet,null);
         this.removeAllListItems(this.m_BuddySet,null);
         var _loc1_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc1_.property = "*";
         _loc1_.kind = PropertyChangeEventKind.UPDATE;
         dispatchEvent(_loc1_);
      }
      
      [Bindable(event="propertyChange")]
      public function set combatAutoChaseOff(param1:Boolean) : void
      {
         var _loc2_:Object = this.combatAutoChaseOff;
         if(_loc2_ !== param1)
         {
            this._1823004292combatAutoChaseOff = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"combatAutoChaseOff",_loc2_,param1));
         }
      }
      
      public function get npcTradeBuyWithBackpacks() : Boolean
      {
         return this.m_NPCTradeBuyWithBackpacks;
      }
      
      private function unmarshallBuddySet(param1:XML, param2:Number) : void
      {
         var _loc3_:BuddySet = BuddySet.s_Unmarshall(param1,param2);
         if(this.m_BuddySet.length >= BuddySet.NUM_SETS && this.getListItem(this.m_BuddySet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallBuddySet: Too many sets.");
         }
         this.addListItem(this.m_BuddySet,_loc3_,null);
      }
      
      public function get npcTradeSellKeepEquipped() : Boolean
      {
         return this.m_NPCTradeSellKeepEquipped;
      }
      
      public function get statusWidgetSkill() : int
      {
         return this.m_StatusWidgetSkill;
      }
      
      private function set _356338236marketSelectedView(param1:int) : void
      {
         if(param1 != MarketWidget.VIEW_MARKET_DETAILS && param1 != MarketWidget.VIEW_MARKET_OFFERS && param1 != MarketWidget.VIEW_MARKET_STATISTICS && param1 != MarketWidget.VIEW_OWN_HISTORY && param1 != MarketWidget.VIEW_OWN_OFFERS)
         {
            param1 = MarketWidget.VIEW_MARKET_OFFERS;
         }
         this.m_MarketSelectedView = param1;
      }
      
      private function set _1869292922rendererAmbientBrightness(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         this.m_RendererAmbientBrightness = param1;
      }
      
      private function set _1361517692statusCreatureName(param1:Boolean) : void
      {
         this.m_StatusCreatureName = param1;
      }
      
      private function getListIDs(param1:*) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1 != null)
         {
            _loc3_ = 0;
            _loc4_ = param1.length;
            while(_loc3_ < _loc4_)
            {
               _loc2_.push(param1[_loc3_].ID);
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function unmarshallSideBarSet(param1:XML, param2:Number) : void
      {
         var _loc3_:SideBarSet = SideBarSet.s_Unmarshall(param1,param2);
         if(this.m_SideBarSet.length >= SideBarSet.NUM_SETS && this.getListItem(this.m_SideBarSet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallSideBarSet: Too many sets.");
         }
         this.addListItem(this.m_SideBarSet,_loc3_,null);
      }
      
      public function getMessageFilterSetIDs() : Array
      {
         return this.getListIDs(this.m_MessageFilterSet);
      }
      
      private function set _1714951155statusCreatureHealth(param1:Boolean) : void
      {
         this.m_StatusCreatureHealth = param1;
      }
      
      public function removeSideBarSet(param1:int) : SideBarSet
      {
         return SideBarSet(this.removeListItem(this.m_SideBarSet,param1,"sideBarSet"));
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserLevel(param1:Boolean) : void
      {
         var _loc2_:Object = this.marketBrowserLevel;
         if(_loc2_ !== param1)
         {
            this._449599592marketBrowserLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserLevel",_loc2_,param1));
         }
      }
      
      private function marshallCombat(param1:XML) : void
      {
         param1.appendChild(<combat>
                          <attackMode>{this.m_CombatAttackMode}</attackMode>
                          <chaseMode>{this.m_CombatChaseMode}</chaseMode>
                          <autoChaseOff>{this.m_CombatAutoChaseOff}</autoChaseOff>
                          <secureMode>{this.m_CombatSecureMode}</secureMode>
                        </combat>);
      }
      
      private function set _120469519npcTradeBuyIgnoreCapacity(param1:Boolean) : void
      {
         this.m_NPCTradeBuyIgnoreCapacity = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserLayout(param1:int) : void
      {
         var _loc2_:Object = this.marketBrowserLayout;
         if(_loc2_ !== param1)
         {
            this._1056280170marketBrowserLayout = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserLayout",_loc2_,param1));
         }
      }
      
      private function initialiseOpponent() : void
      {
         this.m_OpponentFilter = CreatureStorage.FILTER_NONE;
         this.m_OpponentSort = CreatureStorage.SORT_KNOWN_SINCE_ASC;
      }
      
      [Bindable(event="propertyChange")]
      public function set opponentSort(param1:int) : void
      {
         var _loc2_:Object = this.opponentSort;
         if(_loc2_ !== param1)
         {
            this._407350117opponentSort = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"opponentSort",_loc2_,param1));
         }
      }
      
      private function set _251195935combatAttackMode(param1:int) : void
      {
         if(param1 != COMBAT_ATTACK_OFFENSIVE && param1 != COMBAT_ATTACK_BALANCED && param1 != COMBAT_ATTACK_DEFENSIVE)
         {
            throw new ArgumentError("OptionsStorage.set combatAttackMode: Invalid mode.");
         }
         this.m_CombatAttackMode = param1;
      }
      
      public function getKnownTutorialHint(param1:int) : Boolean
      {
         return this.getKnownTutorialHintIndex(param1) > -1;
      }
      
      public function get opponentFilter() : int
      {
         return this.m_OpponentFilter;
      }
      
      public function getActionBarSetIDs() : Array
      {
         return this.getListIDs(this.m_ActionBarSet);
      }
      
      public function get npcTradeSort() : int
      {
         return this.m_NPCTradeSort;
      }
      
      private function set _410094845generalInputSetMode(param1:int) : void
      {
         if(param1 != MappingSet.CHAT_MODE_OFF && param1 != MappingSet.CHAT_MODE_ON && param1 != MappingSet.CHAT_MODE_TEMPORARY)
         {
            throw new ArgumentError("OptionsStorage.set generalInputSetMode: Invalid mode: " + param1);
         }
         this.m_GeneralInputSetMode = param1;
      }
      
      private function unmarshallMarket(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         if(param1 == null || param1.localName() != "market" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallMarket: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "browserLayout":
                  this.m_MarketBrowserLayout = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(this.m_MarketBrowserLayout != AppearanceTypeBrowser.LAYOUT_LIST && this.m_MarketBrowserLayout != AppearanceTypeBrowser.LAYOUT_TILE)
                  {
                     this.m_MarketBrowserLayout = AppearanceTypeBrowser.LAYOUT_TILE;
                  }
                  continue;
               case "browserEditor":
                  this.m_MarketBrowserEditor = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(this.m_MarketBrowserEditor != AppearanceTypeBrowser.EDITOR_CATEGORY && this.m_MarketBrowserEditor != AppearanceTypeBrowser.EDITOR_NAME)
                  {
                     this.m_MarketBrowserEditor = AppearanceTypeBrowser.EDITOR_CATEGORY;
                  }
                  continue;
               case "browserDepot":
                  this.m_MarketBrowserDepot = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "browserCategory":
                  this.m_MarketBrowserCategory = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(!MarketWidget.isValidCategoryID(this.m_MarketBrowserCategory))
                  {
                     this.m_MarketBrowserCategory = MarketWidget.CATEGORY_AMULETS;
                  }
                  continue;
               case "browserLevel":
                  this.m_MarketBrowserLevel = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "browserProfession":
                  this.m_MarketBrowserProfession = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "browserBodyPosition":
                  this.m_MarketBrowserBodyPosition = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(this.m_MarketBrowserBodyPosition != ContainerStorage.BODY_BOTH_HANDS && this.m_MarketBrowserBodyPosition != ContainerStorage.BODY_LEFT_HAND)
                  {
                     this.m_MarketBrowserBodyPosition = -1;
                  }
                  continue;
               case "browserName":
                  this.m_MarketBrowserName = XMLHelper.s_UnmarshallString(_loc3_);
                  continue;
               case "selectedView":
                  this.m_MarketSelectedView = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(this.m_MarketSelectedView != MarketWidget.VIEW_MARKET_DETAILS && this.m_MarketSelectedView != MarketWidget.VIEW_MARKET_OFFERS && this.m_MarketSelectedView != MarketWidget.VIEW_MARKET_STATISTICS && this.m_MarketSelectedView != MarketWidget.VIEW_OWN_HISTORY && this.m_MarketSelectedView != MarketWidget.VIEW_OWN_OFFERS)
                  {
                     this.m_MarketSelectedView = MarketWidget.VIEW_MARKET_OFFERS;
                  }
                  continue;
               case "selectedType":
                  this.m_MarketSelectedType = XMLHelper.s_UnmarshallInteger(_loc3_);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      public function get generalInputClassicControls() : Boolean
      {
         return this.m_GeneralInputClassicControls;
      }
      
      private function set _738874381npcTradeLayout(param1:int) : void
      {
         if(param1 != ObjectRefSelectorBase.LAYOUT_GRID && param1 != ObjectRefSelectorBase.LAYOUT_LIST)
         {
            throw new ArgumentError("OptionsStorage.set npcTradeLayout: Invalid value: " + param1 + ".");
         }
         this.m_NPCTradeLayout = param1;
      }
      
      public function getBuddySet(param1:int) : BuddySet
      {
         return BuddySet(this.getListItem(this.m_BuddySet,param1));
      }
      
      [Bindable(event="propertyChange")]
      public function set statusPlayerName(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusPlayerName;
         if(_loc2_ !== param1)
         {
            this._251860638statusPlayerName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusPlayerName",_loc2_,param1));
         }
      }
      
      public function get rendererMaxFrameRate() : int
      {
         return this.m_RendererMaxFrameRate;
      }
      
      public function get generalUIChatLeftViewWidth() : Number
      {
         return this.m_GeneralUIChatLeftViewWidth;
      }
      
      [Bindable(event="propertyChange")]
      public function set statusWidgetLocation(param1:int) : void
      {
         var _loc2_:Object = this.statusWidgetLocation;
         if(_loc2_ !== param1)
         {
            this._1091413675statusWidgetLocation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusWidgetLocation",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set rendererScaleMap(param1:Boolean) : void
      {
         var _loc2_:Object = this.rendererScaleMap;
         if(_loc2_ !== param1)
         {
            this._1408018027rendererScaleMap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rendererScaleMap",_loc2_,param1));
         }
      }
      
      public function removeNameFilterSet(param1:int) : NameFilterSet
      {
         return NameFilterSet(this.removeListItem(this.m_NameFilterSet,param1,"nameFilterSet"));
      }
      
      [Bindable(event="propertyChange")]
      public function set statusPlayerHealth(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusPlayerHealth;
         if(_loc2_ !== param1)
         {
            this._1351476655statusPlayerHealth = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusPlayerHealth",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set rendererLightEnabled(param1:Boolean) : void
      {
         var _loc2_:Object = this.rendererLightEnabled;
         if(_loc2_ !== param1)
         {
            this._1918651986rendererLightEnabled = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rendererLightEnabled",_loc2_,param1));
         }
      }
      
      public function get rendererLevelSeparator() : Number
      {
         return this.m_RendererLevelSeparator;
      }
      
      public function get marketBrowserProfession() : Boolean
      {
         return this.m_MarketBrowserProfession;
      }
      
      public function get generalActionBarsLock() : Boolean
      {
         return this.m_GeneralActionBarsLock;
      }
      
      public function get rendererShowFrameRate() : Boolean
      {
         return this.m_RendererShowFrameRate;
      }
      
      private function marshallRenderer(param1:XML) : void
      {
         param1.appendChild(<renderer>
                          <lightEnabled>{this.m_RendererLightEnabled}</lightEnabled>
                          <ambientBrightness>{this.m_RendererAmbientBrightness}</ambientBrightness>
                          <levelSeparator>{this.m_RendererLevelSeparator}</levelSeparator>
                          <scaleMap>{this.m_RendererScaleMap}</scaleMap>
                          <maxFrameRate>{this.m_RendererMaxFrameRate}</maxFrameRate>
                          <showFrameRate>{this.m_RendererShowFrameRate}</showFrameRate>
                        </renderer>);
      }
      
      [Bindable(event="propertyChange")]
      public function set statusCreatureFlags(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusCreatureFlags;
         if(_loc2_ !== param1)
         {
            this._749696330statusCreatureFlags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusCreatureFlags",_loc2_,param1));
         }
      }
      
      public function getSideBarSet(param1:int) : SideBarSet
      {
         return SideBarSet(this.getListItem(this.m_SideBarSet,param1));
      }
      
      private function set _1056280170marketBrowserLayout(param1:int) : void
      {
         if(param1 != AppearanceTypeBrowser.LAYOUT_LIST && param1 != AppearanceTypeBrowser.LAYOUT_TILE)
         {
            param1 = AppearanceTypeBrowser.LAYOUT_TILE;
         }
         this.m_MarketBrowserLayout = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set statusWidgetVisible(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusWidgetVisible;
         if(_loc2_ !== param1)
         {
            this._2103194300statusWidgetVisible = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusWidgetVisible",_loc2_,param1));
         }
      }
      
      private function set _1252438854generalUIChatLeftViewWidth(param1:Number) : void
      {
         this.m_GeneralUIChatLeftViewWidth = Math.max(0,Math.min(param1,100));
      }
      
      private function initialiseActionBarSet() : void
      {
         this.removeAllListItems(this.m_ActionBarSet,null);
         var _loc1_:ActionBarSet = new ActionBarSet(ActionBarSet.DEFAULT_SET);
         _loc1_.initialiseDefaultActionBars();
         this.addListItem(this.m_ActionBarSet,_loc1_,null);
      }
      
      public function addBuddySet(param1:BuddySet) : BuddySet
      {
         return BuddySet(this.addListItem(this.m_BuddySet,param1,"buddySet"));
      }
      
      private function set _558862877combatChaseMode(param1:int) : void
      {
         if(param1 != COMBAT_CHASE_OFF && param1 != COMBAT_CHASE_ON)
         {
            throw new ArgumentError("OptionsStorage.set combatChaseMode: Invalid mode.");
         }
         this.m_CombatChaseMode = param1;
      }
      
      private function initialiseStatus() : void
      {
         this.m_StatusCreatureFlags = true;
         this.m_StatusCreatureHealth = true;
         this.m_StatusCreatureName = true;
         this.m_StatusPlayerFlags = true;
         this.m_StatusPlayerHealth = true;
         this.m_StatusPlayerName = true;
         this.m_StatusPlayerMana = true;
         this.m_StatusPlayerStyle = RendererImpl.STATUS_STYLE_CLASSIC;
         this.m_StatusCreatureStyle = RendererImpl.STATUS_STYLE_CLASSIC;
         this.m_StatusWidgetLocation = StatusWidget.LOCATION_TOP;
         this.m_StatusWidgetSkill = SKILL_LEVEL;
         this.m_StatusWidgetStyle = StatusWidget.STATUS_STYLE_DEFAULT;
         this.m_StatusWidgetVisible = true;
      }
      
      private function marshallChannelSet(param1:XML) : void
      {
         var _loc2_:int = this.m_ChannelSet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_ChannelSet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      private function initialiseBuddySet() : void
      {
         this.removeAllListItems(this.m_BuddySet,null);
         this.addListItem(this.m_BuddySet,new BuddySet(BuddySet.DEFAULT_SET),null);
      }
      
      public function get rendererScaleMap() : Boolean
      {
         return this.m_RendererScaleMap;
      }
      
      private function removeListItem(param1:*, param2:int, param3:String) : *
      {
         var _loc6_:PropertyChangeEvent = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:* = null;
         var _loc5_:int = param1.length - 1;
         while(_loc5_ >= 0)
         {
            if(param1[_loc5_].ID == param2)
            {
               _loc4_ = param1.splice(_loc5_,1)[0];
               break;
            }
            _loc5_--;
         }
         if(_loc4_ is IEventDispatcher)
         {
            IEventDispatcher(_loc4_).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onListItemEvent);
            IEventDispatcher(_loc4_).removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onListItemEvent);
         }
         if(_loc4_ != null && param3 != null)
         {
            _loc6_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc6_.kind = PropertyChangeEventKind.UPDATE;
            _loc6_.property = param3;
            dispatchEvent(_loc6_);
         }
         return _loc4_;
      }
      
      public function get marketBrowserLevel() : Boolean
      {
         return this.m_MarketBrowserLevel;
      }
      
      private function set _737429024statusCreatureStyle(param1:int) : void
      {
         if(param1 == RendererImpl.STATUS_STYLE_CLASSIC || param1 == RendererImpl.STATUS_STYLE_OFF)
         {
            this.m_StatusCreatureStyle = param1;
            return;
         }
         this.m_StatusCreatureStyle = param1;
         throw new ArgumentError("OptionsStorage.set rendererCreatureStyle: Invalid style.");
      }
      
      [Bindable(event="propertyChange")]
      public function set combatSecureMode(param1:int) : void
      {
         var _loc2_:Object = this.combatSecureMode;
         if(_loc2_ !== param1)
         {
            this._512938034combatSecureMode = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"combatSecureMode",_loc2_,param1));
         }
      }
      
      private function marshallNameFilterSet(param1:XML) : void
      {
         var _loc2_:int = this.m_NameFilterSet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_NameFilterSet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      private function initialiseSideBarSet() : void
      {
         this.removeAllListItems(this.m_SideBarSet,null);
         var _loc1_:SideBarSet = new SideBarSet(SideBarSet.DEFAULT_SET);
         _loc1_.initialiseDefaultWidgets();
         this.addListItem(this.m_SideBarSet,_loc1_,null);
      }
      
      public function get marketBrowserLayout() : int
      {
         return this.m_MarketBrowserLayout;
      }
      
      private function set _273891688marketBrowserProfession(param1:Boolean) : void
      {
         this.m_MarketBrowserProfession = param1;
      }
      
      private function set _259410793generalActionBarsLock(param1:Boolean) : void
      {
         this.m_GeneralActionBarsLock = param1;
      }
      
      public function getActionBarSet(param1:int) : ActionBarSet
      {
         return ActionBarSet(this.getListItem(this.m_ActionBarSet,param1));
      }
      
      private function set _251860638statusPlayerName(param1:Boolean) : void
      {
         this.m_StatusPlayerName = param1;
      }
      
      public function setKnownTutorialHint(param1:int, param2:Boolean) : Boolean
      {
         var _loc5_:PropertyChangeEvent = null;
         if(!TutorialHint.s_CheckHint(param1))
         {
            return false;
         }
         var _loc3_:int = this.getKnownTutorialHintIndex(param1);
         var _loc4_:Boolean = false;
         if(_loc3_ > -1 && !param2)
         {
            this.m_KnownTutorialHint.splice(_loc3_,1);
            _loc4_ = true;
         }
         if(_loc3_ < 0 && Boolean(param2))
         {
            this.m_KnownTutorialHint.splice(-_loc3_ - 1,0,param1);
            _loc4_ = true;
         }
         if(_loc4_)
         {
            _loc5_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc5_.property = "knownTutorialHint";
            _loc5_.kind = PropertyChangeEventKind.UPDATE;
            _loc5_.oldValue = _loc3_ > -1;
            _loc5_.newValue = param2;
            dispatchEvent(_loc5_);
         }
         return _loc3_ > -1;
      }
      
      public function get statusPlayerHealth() : Boolean
      {
         return this.m_StatusPlayerHealth;
      }
      
      private function set _1621507731rendererShowFrameRate(param1:Boolean) : void
      {
         this.m_RendererShowFrameRate = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserEditor(param1:int) : void
      {
         var _loc2_:Object = this.marketBrowserEditor;
         if(_loc2_ !== param1)
         {
            this._1254385703marketBrowserEditor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserEditor",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set statusPlayerFlags(param1:Boolean) : void
      {
         var _loc2_:Object = this.statusPlayerFlags;
         if(_loc2_ !== param1)
         {
            this._789326636statusPlayerFlags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusPlayerFlags",_loc2_,param1));
         }
      }
      
      private function set _749696330statusCreatureFlags(param1:Boolean) : void
      {
         this.m_StatusCreatureFlags = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set marketSelectedType(param1:*) : void
      {
         var _loc2_:Object = this.marketSelectedType;
         if(_loc2_ !== param1)
         {
            this._356294353marketSelectedType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketSelectedType",_loc2_,param1));
         }
      }
      
      public function getSideBarSetIDs() : Array
      {
         return this.getListIDs(this.m_SideBarSet);
      }
      
      public function get rendererLightEnabled() : Boolean
      {
         return this.m_RendererLightEnabled;
      }
      
      private function set _407350117opponentSort(param1:int) : void
      {
         this.m_OpponentSort = param1;
      }
      
      private function removeAllListItems(param1:*, param2:String) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:PropertyChangeEvent = null;
         if(param1 != null)
         {
            for each(_loc3_ in param1)
            {
               if(_loc3_ is IEventDispatcher)
               {
                  IEventDispatcher(_loc3_).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onListItemEvent);
                  IEventDispatcher(_loc3_).removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onListItemEvent);
               }
            }
            param1.length = 0;
            if(param2 != null)
            {
               _loc4_ = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
               _loc4_.kind = PropertyChangeEventKind.UPDATE;
               _loc4_.property = param2;
               dispatchEvent(_loc4_);
            }
         }
      }
      
      private function set _124099575marketBrowserName(param1:String) : void
      {
         this.m_MarketBrowserName = param1;
      }
      
      public function removeActionBarSet(param1:int) : ActionBarSet
      {
         return ActionBarSet(this.removeListItem(this.m_ActionBarSet,param1,"actionBarSet"));
      }
      
      [Bindable(event="propertyChange")]
      public function set statusCreatureStyle(param1:int) : void
      {
         var _loc2_:Object = this.statusCreatureStyle;
         if(_loc2_ !== param1)
         {
            this._737429024statusCreatureStyle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusCreatureStyle",_loc2_,param1));
         }
      }
      
      private function set _2042619673npcTradeSellKeepEquipped(param1:Boolean) : void
      {
         this.m_NPCTradeSellKeepEquipped = param1;
      }
      
      private function initialiseMarket() : void
      {
         this.m_MarketBrowserLayout = AppearanceTypeBrowser.LAYOUT_TILE;
         this.m_MarketBrowserEditor = AppearanceTypeBrowser.EDITOR_CATEGORY;
         this.m_MarketBrowserDepot = false;
         this.m_MarketBrowserCategory = MarketWidget.CATEGORY_AMULETS;
         this.m_MarketBrowserLevel = false;
         this.m_MarketBrowserProfession = false;
         this.m_MarketBrowserBodyPosition = -1;
         this.m_MarketBrowserName = "";
         this.m_MarketSelectedView = MarketWidget.VIEW_MARKET_OFFERS;
         this.m_MarketSelectedType = 0;
      }
      
      public function get combatSecureMode() : int
      {
         return this.m_CombatSecureMode;
      }
      
      public function getNameFilterSet(param1:int) : NameFilterSet
      {
         return NameFilterSet(this.getListItem(this.m_NameFilterSet,param1));
      }
      
      public function getMappingSetIDs() : Array
      {
         return this.getListIDs(this.m_MappingSet);
      }
      
      private function marshallNPCTrade(param1:XML) : void
      {
         param1.appendChild(<npctrade>
                          <buyIgnoreCapacity>{this.m_NPCTradeBuyIgnoreCapacity}</buyIgnoreCapacity>
                          <buyWithBackpacks>{this.m_NPCTradeBuyWithBackpacks}</buyWithBackpacks>
                          <sellKeepEquipped>{this.m_NPCTradeSellKeepEquipped}</sellKeepEquipped>
                          <sort>{this.m_NPCTradeSort}</sort>
                          <layout>{this.m_NPCTradeLayout}</layout>
                        </npctrade>);
      }
      
      public function get statusCreatureStyle() : int
      {
         return this.m_StatusCreatureStyle;
      }
      
      private function marshallMappingSet(param1:XML) : void
      {
         var _loc2_:int = this.m_MappingSet.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.appendChild(this.m_MappingSet[_loc3_].marshall());
            _loc3_++;
         }
      }
      
      public function get generalUIGameWindowHeight() : Number
      {
         return this.m_GeneralUIGameWindowHeight;
      }
      
      public function addChannelSet(param1:ChannelSet) : ChannelSet
      {
         return ChannelSet(this.addListItem(this.m_ChannelSet,param1,"channelSet"));
      }
      
      public function get marketBrowserEditor() : int
      {
         return this.m_MarketBrowserEditor;
      }
      
      private function unmarshallMessageFilterSet(param1:XML, param2:Number) : void
      {
         var _loc3_:MessageFilterSet = MessageFilterSet.s_Unmarshall(param1,param2);
         if(this.m_MessageFilterSet.length >= MessageFilterSet.NUM_SETS && this.getListItem(this.m_MessageFilterSet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallMessageFilterSet: Too many sets.");
         }
         this.addListItem(this.m_MessageFilterSet,_loc3_,null);
      }
      
      private function unmarshallChannelSet(param1:XML, param2:Number) : void
      {
         var _loc3_:ChannelSet = ChannelSet.s_Unmarshall(param1,param2);
         if(this.m_ChannelSet.length >= ChannelSet.NUM_SETS && this.getListItem(this.m_ChannelSet,_loc3_.ID) == null)
         {
            throw new Error("OptionsStorage.unmarshallChannelSet: Too many sets.");
         }
         this.addListItem(this.m_ChannelSet,_loc3_,null);
      }
      
      public function get marketBrowserName() : String
      {
         return this.m_MarketBrowserName;
      }
      
      private function unmarshallCombat(param1:XML, param2:Number) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null || param1.localName() != "combat" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
         {
            throw new Error("OptionsStorage.unmarshallCombat: Invalid input.");
         }
         for each(_loc3_ in param1.elements())
         {
            switch(_loc3_.localName())
            {
               case "attackMode":
                  _loc4_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc4_ == COMBAT_ATTACK_OFFENSIVE || _loc4_ == COMBAT_ATTACK_BALANCED || _loc4_ == COMBAT_ATTACK_DEFENSIVE)
                  {
                     this.m_CombatAttackMode = _loc4_;
                  }
                  continue;
               case "chaseMode":
                  _loc5_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc5_ == COMBAT_CHASE_OFF || _loc5_ == COMBAT_CHASE_ON)
                  {
                     this.m_CombatChaseMode = _loc5_;
                  }
                  continue;
               case "autoChaseOff":
                  this.m_CombatAutoChaseOff = XMLHelper.s_UnmarshallBoolean(_loc3_);
                  continue;
               case "secureMode":
                  _loc6_ = XMLHelper.s_UnmarshallInteger(_loc3_);
                  if(_loc6_ == COMBAT_SECURE_OFF || _loc6_ == COMBAT_SECURE_ON)
                  {
                     this.m_CombatSecureMode = _loc6_;
                  }
                  continue;
               default:
                  continue;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set marketBrowserName(param1:String) : void
      {
         var _loc2_:Object = this.marketBrowserName;
         if(_loc2_ !== param1)
         {
            this._124099575marketBrowserName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"marketBrowserName",_loc2_,param1));
         }
      }
   }
}

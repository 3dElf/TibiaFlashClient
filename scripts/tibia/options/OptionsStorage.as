package tibia.options
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import mx.utils.*;
    import shared.utility.*;
    import tibia.actionbar.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.help.*;
    import tibia.input.*;
    import tibia.input.mapping.*;
    import tibia.market.*;
    import tibia.market.marketWidgetClasses.*;
    import tibia.sidebar.*;
    import tibia.trade.npcTradeWidgetClasses.*;
    import tibia.worldmap.widgetClasses.*;

    public class OptionsStorage extends EventDispatcher
    {
        private var m_MarketSelectedType:int = -1;
        private var m_RendererAntialiasing:Boolean = false;
        private var m_StatusPlayerMana:Boolean = false;
        private var m_GeneralInputSetMode:int = -1;
        private var m_RendererMaxFrameRate:int = -1;
        private var m_CombatChaseMode:int = -1;
        private var m_NPCTradeLayout:int = -1;
        private var m_DefaultOptionsXml:XML = null;
        private var m_StatusPlayerName:Boolean = false;
        private var m_StatusCreatureIcons:Boolean = false;
        private var m_RendererLightEnabled:Boolean = false;
        private var m_GeneralInputMouseControls:int = -1;
        private var m_GeneralShopShowBuyConfirmation:Boolean = true;
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
        private var m_Version:Number = 5;
        private var m_MarketBrowserEditor:int = -1;
        private var m_GeneralInputSetID:int = -1;
        private var m_StatusCreatureStyle:int = -1;
        private var m_RendererShowFrameRate:Boolean = false;
        private var m_GeneralActionBarsLock:Boolean = false;
        private var m_StatusWidgetStyle:int = -1;
        private var m_NameFilterSet:Vector.<NameFilterSet>;
        private var m_RendererAmbientBrightness:Number = -1;
        private var m_MouseMapping:MouseMapping;
        private var m_StatusCreaturePvpFrames:Boolean = false;
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
        private var m_ServerUIHints:UiServerHints = null;
        private var m_ChannelSet:Vector.<ChannelSet>;
        private var m_RendererLevelSeparator:Number = -1;
        private var m_StatusWidgetSkill:int = -1;
        private var m_StatusCreatureName:Boolean = false;
        private var m_CombatAutoChaseOff:Boolean = false;
        private var m_RendererHighlight:Number = -1;
        private var m_StatusCreatureFlags:Boolean = false;
        private var m_StatusWidgetVisible:Boolean = false;
        private var m_CombatAttackMode:int = -1;
        private var m_ActionBarSet:Vector.<ActionBarSet>;
        private var m_CombatPVPMode:int = 0;
        private var m_MappingSet:Vector.<MappingSet>;
        private var m_NPCTradeSort:int = -1;
        private var m_MarketBrowserCategory:int = -1;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        public static const COMBAT_PVP_MODE_YELLOW_HAND:uint = 2;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        public static const COMBAT_PVP_MODE_WHITE_HAND:uint = 1;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        public static const COMBAT_SECURE_ON:int = 1;
        static const GUILD_NONE:int = 0;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const TYPE_NPC:int = 2;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        static const SKILL_FISHING:int = 14;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        public static const COMBAT_ATTACK_OFFENSIVE:int = 1;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        public static const COMBAT_ATTACK_DEFENSIVE:int = 3;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        public static const COMBAT_PVP_MODE_DOVE:uint = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const STATE_PZ_ENTERED:int = 14;
        public static const COMBAT_SECURE_OFF:int = 0;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        public static const COMBAT_CHASE_ON:int = 1;
        private static const OPTION_GROUPS:Array = [{XMLName:"general", localName:"General"}, {XMLName:"renderer", localName:"Renderer"}, {XMLName:"combat", localName:"Combat"}, {XMLName:"status", localName:"Status"}, {XMLName:"npctrade", localName:"NPCTrade"}, {XMLName:"opponent", localName:"Opponent"}, {XMLName:"help", localName:"Help"}, {XMLName:"sidebarset", localName:"SideBarSet"}, {XMLName:"actionbarset", localName:"ActionBarSet"}, {XMLName:"mappingset", localName:"MappingSet"}, {XMLName:"mousemapping", localName:"MouseMapping"}, {XMLName:"messagefilterset", localName:"MessageFilterSet"}, {XMLName:"channelset", localName:"ChannelSet"}, {XMLName:"namefilterset", localName:"NameFilterSet"}, {XMLName:"market", localName:"Market"}];
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_SORCERER:int = 3;
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
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const BLESSING_NONE:int = 0;
        static const STATE_FAST:int = 6;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        public static const COMBAT_PVP_MODE_RED_FIST:uint = 3;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const STATE_POISONED:int = 0;
        static const TYPE_MONSTER:int = 1;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        public static const COMBAT_CHASE_OFF:int = 0;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const NPC_SPEECH_NORMAL:uint = 1;
        public static const COMBAT_ATTACK_BALANCED:int = 2;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function OptionsStorage(param1:XML, param2:XML, param3:Boolean = false)
        {
            var a_DefaultOptions:* = param1;
            var a_CurrentOptions:* = param2;
            var a_IgnoreAdditionalMappingSets:* = param3;
            this.m_KnownTutorialHint = new Vector.<int>;
            this.m_SideBarSet = new Vector.<SideBarSet>;
            this.m_ActionBarSet = new Vector.<ActionBarSet>;
            this.m_MappingSet = new Vector.<MappingSet>;
            this.m_MouseMapping = new MouseMapping();
            this.m_MessageFilterSet = new Vector.<MessageFilterSet>;
            this.m_ChannelSet = new Vector.<ChannelSet>;
            this.m_NameFilterSet = new Vector.<NameFilterSet>;
            this.m_BuddySet = new Vector.<BuddySet>;
            if (a_DefaultOptions == null)
            {
                throw new ArgumentError("OptionsStorage.OptionsStorage: Default options were not set.");
            }
            if (a_CurrentOptions == null)
            {
                a_CurrentOptions = a_DefaultOptions;
            }
            this.m_DefaultOptionsXml = a_DefaultOptions;
            try
            {
                this.unmarshall(this.m_DefaultOptionsXml, a_IgnoreAdditionalMappingSets);
            }
            catch (e:Error)
            {
                throw new Error("OptionsStorage.OptionsStorage: Could not load default option set.");
            }
            if (a_CurrentOptions != null && a_CurrentOptions.localName() == "options")
            {
                try
                {
                    this.removeStarterMappings();
                    this.unmarshall(a_CurrentOptions);
                }
                catch (e:Error)
                {
                }
            }
            this.initialiseBuddySet();
            this.m_ServerUIHints = new UiServerHints(this);
            var _Event:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _Event.kind = PropertyChangeEventKind.UPDATE;
            _Event.property = "*";
            dispatchEvent(_Event);
            return;
        }// end function

        private function set _747180215statusCreatureIcons(param1:Boolean) : void
        {
            this.m_StatusCreatureIcons = param1;
            return;
        }// end function

        public function get statusPlayerStyle() : int
        {
            return this.m_StatusPlayerStyle;
        }// end function

        private function initialiseNameFilterSet() : void
        {
            this.removeAllListItems(this.m_NameFilterSet, null);
            this.addListItem(this.m_NameFilterSet, new NameFilterSet(NameFilterSet.DEFAULT_SET), null);
            return;
        }// end function

        public function removeChannelSet(param1:int) : ChannelSet
        {
            return ChannelSet(this.removeListItem(this.m_ChannelSet, param1, "channelSet"));
        }// end function

        private function marshallOpponent(param1:XML) : void
        {
            param1.appendChild(new XML("<opponent>\r\n                          " + ("<sort>" + this.m_OpponentSort + "</sort>") + "\r\n                          " + ("<filter>" + this.m_OpponentFilter + "</filter>") + "\r\n                        </opponent>"));
            return;
        }// end function

        public function get statusCreatureHealth() : Boolean
        {
            return this.m_StatusCreatureHealth;
        }// end function

        public function get npcTradeBuyIgnoreCapacity() : Boolean
        {
            return this.m_NPCTradeBuyIgnoreCapacity;
        }// end function

        public function set generalUIGameWindowHeight(param1:Number) : void
        {
            var _loc_2:* = this.generalUIGameWindowHeight;
            if (_loc_2 !== param1)
            {
                this._1916522523generalUIGameWindowHeight = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "generalUIGameWindowHeight", _loc_2, param1));
            }
            return;
        }// end function

        private function unmarshallCombat(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param1 == null || param1.localName() != "combat" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallCombat: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "attackMode":
                    {
                        _loc_5 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_5 == COMBAT_ATTACK_OFFENSIVE || _loc_5 == COMBAT_ATTACK_BALANCED || _loc_5 == COMBAT_ATTACK_DEFENSIVE)
                        {
                            this.m_CombatAttackMode = _loc_5;
                        }
                        break;
                    }
                    case "chaseMode":
                    {
                        _loc_6 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_6 == COMBAT_CHASE_OFF || _loc_6 == COMBAT_CHASE_ON)
                        {
                            this.m_CombatChaseMode = _loc_6;
                        }
                        break;
                    }
                    case "autoChaseOff":
                    {
                        this.m_CombatAutoChaseOff = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "secureMode":
                    {
                        _loc_7 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_7 == COMBAT_SECURE_OFF || _loc_7 == COMBAT_SECURE_ON)
                        {
                            this.m_CombatSecureMode = _loc_7;
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

        public function get npcTradeLayout() : int
        {
            return this.m_NPCTradeLayout;
        }// end function

        public function set generalInputSetMode(param1:int) : void
        {
            var _loc_2:* = this.generalInputSetMode;
            if (_loc_2 !== param1)
            {
                this._410094845generalInputSetMode = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "generalInputSetMode", _loc_2, param1));
            }
            return;
        }// end function

        private function marshallMouseMapping(param1:XML) : void
        {
            param1.appendChild(this.m_MouseMapping.marshall());
            return;
        }// end function

        private function hasMethod(param1:String) : Boolean
        {
            var a_Name:* = param1;
            var Result:Boolean;
            try
            {
                Result = this[a_Name] is Function;
            }
            catch (_Error)
            {
            }
            return Result;
        }// end function

        public function get combatChaseMode() : int
        {
            return this.m_CombatChaseMode;
        }// end function

        public function set npcTradeBuyIgnoreCapacity(param1:Boolean) : void
        {
            var _loc_2:* = this.npcTradeBuyIgnoreCapacity;
            if (_loc_2 !== param1)
            {
                this._120469519npcTradeBuyIgnoreCapacity = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcTradeBuyIgnoreCapacity", _loc_2, param1));
            }
            return;
        }// end function

        public function get combatAttackMode() : int
        {
            return this.m_CombatAttackMode;
        }// end function

        private function set _1254385703marketBrowserEditor(param1:int) : void
        {
            if (param1 != AppearanceTypeBrowser.EDITOR_CATEGORY && param1 != AppearanceTypeBrowser.EDITOR_NAME)
            {
                param1 = AppearanceTypeBrowser.EDITOR_CATEGORY;
            }
            this.m_MarketBrowserEditor = param1;
            return;
        }// end function

        private function set _251830874statusPlayerMana(param1:Boolean) : void
        {
            this.m_StatusPlayerMana = param1;
            return;
        }// end function

        public function set npcTradeBuyWithBackpacks(param1:Boolean) : void
        {
            var _loc_2:* = this.npcTradeBuyWithBackpacks;
            if (_loc_2 !== param1)
            {
                this._1147639562npcTradeBuyWithBackpacks = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcTradeBuyWithBackpacks", _loc_2, param1));
            }
            return;
        }// end function

        public function removeMessageFilterSet(param1:int) : MessageFilterSet
        {
            return MessageFilterSet(this.removeListItem(this.m_MessageFilterSet, param1, "messageFilterSet"));
        }// end function

        public function set statusCreatureHealth(param1:Boolean) : void
        {
            var _loc_2:* = this.statusCreatureHealth;
            if (_loc_2 !== param1)
            {
                this._1714951155statusCreatureHealth = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusCreatureHealth", _loc_2, param1));
            }
            return;
        }// end function

        private function unmarshallHelp(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param1 == null || param1.localName() != "help" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallHelp: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "knownTutorialHints":
                    {
                        for each (_loc_5 in _loc_4.elements("hint"))
                        {
                            
                            _loc_6 = XMLHelper.s_UnmarshallInteger(_loc_5);
                            _loc_7 = this.getKnownTutorialHintIndex(_loc_6);
                            if (TutorialHint.checkHint(_loc_6) && _loc_7 < 0)
                            {
                                this.m_KnownTutorialHint.splice(-_loc_7 - 1, 0, _loc_6);
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

        private function unmarshallRenderer(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (param1 == null || param1.localName() != "renderer" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallRenderer: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "lightEnabled":
                    {
                        this.m_RendererLightEnabled = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "ambientBrightness":
                    {
                        this.m_RendererAmbientBrightness = Math.max(0, Math.min(XMLHelper.s_UnmarshallDecimal(_loc_4), 1));
                        break;
                    }
                    case "highlight":
                    {
                        this.m_RendererHighlight = Math.max(0, Math.min(XMLHelper.s_UnmarshallDecimal(_loc_4), 1));
                        break;
                    }
                    case "levelSeparator":
                    {
                        this.m_RendererLevelSeparator = Math.max(0, Math.min(XMLHelper.s_UnmarshallDecimal(_loc_4), 1));
                        break;
                    }
                    case "scaleMap":
                    {
                        this.m_RendererScaleMap = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "antialiasing":
                    {
                        this.m_RendererAntialiasing = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "maxFrameRate":
                    {
                        this.m_RendererMaxFrameRate = Math.max(10, Math.min(XMLHelper.s_UnmarshallInteger(_loc_4), 60));
                        break;
                    }
                    case "showFrameRate":
                    {
                        this.m_RendererShowFrameRate = XMLHelper.s_UnmarshallBoolean(_loc_4);
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

        public function unmarshall(param1, param2:Boolean = false) : void
        {
            var XMLNode:XML;
            var _Event:PropertyChangeEvent;
            var UnmarshallFunctionName:String;
            var InitialiseFunctioName:String;
            var a_Input:* = param1;
            var a_IsDefault:* = param2;
            var _XML:XML;
            if (a_Input is String)
            {
                try
                {
                    _XML = XML(a_Input as String);
                }
                catch (_Error)
                {
                }
            }
            else if (a_Input is XML)
            {
                _XML = a_Input as XML;
            }
            if (_XML == null || _XML.localName() != "options")
            {
                throw new Error("OptionsStorage.unmarshall: Invalid root element: " + _XML.localName());
            }
            this.m_Version = _XML.@version;
            if (this.m_Version < OPTIONS_MIN_COMPATIBLE_VERSION || this.m_Version > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshall: Invalid version: " + this.m_Version);
            }
            var Group:Object;
            var UnmarshalledElements:* = new Vector.<String>;
            var _loc_4:* = 0;
            var _loc_5:* = _XML.elements();
            while (_loc_5 in _loc_4)
            {
                
                XMLNode = _loc_5[_loc_4];
                var _loc_6:* = 0;
                var _loc_7:* = OPTION_GROUPS;
                while (_loc_7 in _loc_6)
                {
                    
                    Group = _loc_7[_loc_6];
                    if (Group.XMLName == XMLNode.localName())
                    {
                        UnmarshallFunctionName = "unmarshall" + Group.localName;
                        if (this.hasMethod(UnmarshallFunctionName))
                        {
                            try
                            {
                                var _loc_8:* = this;
                                _loc_8[UnmarshallFunctionName](XMLNode, this.m_Version, a_IsDefault);
                                UnmarshalledElements.push(Group.localName);
                            }
                            catch (_Error)
                            {
                            }
                            ;
                        }
                        break;
                    }
                }
            }
            var _loc_4:* = 0;
            var _loc_5:* = OPTION_GROUPS;
            while (_loc_5 in _loc_4)
            {
                
                Group = _loc_5[_loc_4];
                if (UnmarshalledElements.indexOf(Group.localName) < 0)
                {
                    InitialiseFunctioName = "initialise" + Group.localName;
                    if (this.hasMethod(InitialiseFunctioName))
                    {
                        var _loc_6:* = this;
                        _loc_6[InitialiseFunctioName]();
                        continue;
                    }
                }
            }
            _Event = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _Event.property = "*";
            _Event.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_Event);
            return;
        }// end function

        private function marshallStatus(param1:XML) : void
        {
            param1.appendChild(new XML("<status>\r\n                          " + ("<widgetLocation>" + this.m_StatusWidgetLocation + "</widgetLocation>") + "\r\n                          " + ("<widgetSkill>" + this.m_StatusWidgetSkill + "</widgetSkill>") + "\r\n                          " + ("<widgetStyle>" + this.m_StatusWidgetStyle + "</widgetStyle>") + "\r\n                          " + ("<widgetVisible>" + this.m_StatusWidgetVisible + "</widgetVisible>") + "\r\n                          " + ("<playerStyle>" + this.m_StatusPlayerStyle + "</playerStyle>") + "\r\n                          " + ("<playerName>" + this.m_StatusPlayerName + "</playerName>") + "\r\n                          " + ("<playerHealth>" + this.m_StatusPlayerHealth + "</playerHealth>") + "\r\n                          " + ("<playerMana>" + this.m_StatusPlayerMana + "</playerMana>") + "\r\n                          " + ("<playerFlags>" + this.m_StatusPlayerFlags + "</playerFlags>") + "\r\n                          " + ("<creatureStyle>" + this.m_StatusCreatureStyle + "</creatureStyle>") + "\r\n                          " + ("<creatureName>" + this.m_StatusCreatureName + "</creatureName>") + "\r\n                          " + ("<creatureHealth>" + this.m_StatusCreatureHealth + "</creatureHealth>") + "\r\n                          " + ("<creatureFlags>" + this.m_StatusCreatureFlags + "</creatureFlags>") + "\r\n                          " + ("<creatureIcons>" + this.m_StatusCreatureIcons + "</creatureIcons>") + "\r\n                          " + ("<creaturePvpFrames>" + this.m_StatusCreaturePvpFrames + "</creaturePvpFrames>") + "\r\n                        </status>"));
            return;
        }// end function

        private function unmarshallMouseMapping(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            MouseMapping.s_Unmarshall(param1, param2, this.m_MouseMapping);
            return;
        }// end function

        private function initialiseGeneral() : void
        {
            this.m_GeneralActionBarsLock = false;
            this.m_GeneralInputSetID = MappingSet.DEFAULT_SET;
            this.m_GeneralInputSetMode = MappingSet.CHAT_MODE_ON;
            this.m_GeneralUIGameWindowHeight = 7500;
            this.m_GeneralUIChatLeftViewWidth = 100;
            this.m_GeneralShopShowBuyConfirmation = true;
            return;
        }// end function

        public function set npcTradeLayout(param1:int) : void
        {
            var _loc_2:* = this.npcTradeLayout;
            if (_loc_2 !== param1)
            {
                this._738874381npcTradeLayout = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcTradeLayout", _loc_2, param1));
            }
            return;
        }// end function

        public function addMappingSet(param1:MappingSet) : MappingSet
        {
            return MappingSet(this.addListItem(this.m_MappingSet, param1, "mappingSet"));
        }// end function

        private function marshallMessageFilterSet(param1:XML) : void
        {
            var _loc_2:* = this.m_MessageFilterSet.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.appendChild(this.m_MessageFilterSet[_loc_3].marshall());
                _loc_3++;
            }
            return;
        }// end function

        public function set npcTradeSellKeepEquipped(param1:Boolean) : void
        {
            var _loc_2:* = this.npcTradeSellKeepEquipped;
            if (_loc_2 !== param1)
            {
                this._2042619673npcTradeSellKeepEquipped = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcTradeSellKeepEquipped", _loc_2, param1));
            }
            return;
        }// end function

        private function set _1408018027rendererScaleMap(param1:Boolean) : void
        {
            this.m_RendererScaleMap = param1;
            return;
        }// end function

        private function unmarshallMappingSet(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = MappingSet.s_Unmarshall(param1, param2);
            if (this.m_MappingSet.length >= MappingSet.NUM_SETS && this.getListItem(this.m_MappingSet, _loc_4.ID) == null)
            {
                throw new Error("OptionsStorage.unmarshallMappingSet: Too many sets.");
            }
            if (_loc_4.ID == 0 || !param3)
            {
                this.addListItem(this.m_MappingSet, _loc_4, null);
            }
            return;
        }// end function

        private function set _1893979327npcTradeSort(param1:int) : void
        {
            if (param1 != ObjectRefSelectorBase.SORT_NAME && param1 != ObjectRefSelectorBase.SORT_PRICE && param1 != ObjectRefSelectorBase.SORT_WEIGHT)
            {
                throw new ArgumentError("OptionsStorage.set npcTradeSort: Invalid value: " + param1 + ".");
            }
            this.m_NPCTradeSort = param1;
            return;
        }// end function

        public function set statusWidgetSkill(param1:int) : void
        {
            var _loc_2:* = this.statusWidgetSkill;
            if (_loc_2 !== param1)
            {
                this._2037454619statusWidgetSkill = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusWidgetSkill", _loc_2, param1));
            }
            return;
        }// end function

        public function set combatAttackMode(param1:int) : void
        {
            var _loc_2:* = this.combatAttackMode;
            if (_loc_2 !== param1)
            {
                this._251195935combatAttackMode = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "combatAttackMode", _loc_2, param1));
            }
            return;
        }// end function

        public function get generalShopShowBuyConfirmation() : Boolean
        {
            return this.m_GeneralShopShowBuyConfirmation;
        }// end function

        public function set combatChaseMode(param1:int) : void
        {
            var _loc_2:* = this.combatChaseMode;
            if (_loc_2 !== param1)
            {
                this._558862877combatChaseMode = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "combatChaseMode", _loc_2, param1));
            }
            return;
        }// end function

        private function set _1147639562npcTradeBuyWithBackpacks(param1:Boolean) : void
        {
            this.m_NPCTradeBuyWithBackpacks = param1;
            return;
        }// end function

        public function get marketSelectedView() : int
        {
            return this.m_MarketSelectedView;
        }// end function

        private function set _1191209559marketBrowserBodyPosition(param1:int) : void
        {
            if (param1 != BodyContainerView.BOTH_HANDS && param1 != BodyContainerView.LEFT_HAND)
            {
                param1 = -1;
            }
            this.m_MarketBrowserBodyPosition = param1;
            return;
        }// end function

        public function set statusCreaturePvpFrames(param1:Boolean) : void
        {
            var _loc_2:* = this.statusCreaturePvpFrames;
            if (_loc_2 !== param1)
            {
                this._147163423statusCreaturePvpFrames = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusCreaturePvpFrames", _loc_2, param1));
            }
            return;
        }// end function

        public function getBuddySetIDs() : Array
        {
            return this.getListIDs(this.m_BuddySet);
        }// end function

        private function getListItem(param1, param2:int)
        {
            var _loc_3:* = undefined;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3.ID == param2)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private function searchDefaultXmlFirstLevelElements(param1:String) : XMLList
        {
            var _loc_2:* = null;
            for each (_loc_2 in OPTION_GROUPS)
            {
                
                if (_loc_2.localName == param1)
                {
                    return this.m_DefaultOptionsXml[_loc_2.XMLName];
                }
            }
            throw new Error("OptionsStorage.searchXmlFirstLevelElements: Invalid local name: " + param1);
        }// end function

        public function getChannelSetIDs() : Array
        {
            return this.getListIDs(this.m_ChannelSet);
        }// end function

        public function addMessageFilterSet(param1:MessageFilterSet) : MessageFilterSet
        {
            return MessageFilterSet(this.addListItem(this.m_MessageFilterSet, param1, "messageFilterSet"));
        }// end function

        public function get marketBrowserDepot() : Boolean
        {
            return this.m_MarketBrowserDepot;
        }// end function

        private function unmarshallNPCTrade(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1 == null || param1.localName() != "npctrade" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallNPCTrade: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "buyIgnoreCapacity":
                    {
                        this.m_NPCTradeBuyIgnoreCapacity = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "buyWithBackpacks":
                    {
                        this.m_NPCTradeBuyWithBackpacks = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "sellKeepEquipped":
                    {
                        this.m_NPCTradeSellKeepEquipped = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "sort":
                    {
                        _loc_5 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_5 == ObjectRefSelectorBase.SORT_NAME || _loc_5 == ObjectRefSelectorBase.SORT_PRICE || _loc_5 == ObjectRefSelectorBase.SORT_WEIGHT)
                        {
                            this.m_NPCTradeSort = _loc_5;
                        }
                        break;
                    }
                    case "layout":
                    {
                        _loc_6 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_6 == ObjectRefSelectorBase.LAYOUT_GRID || _loc_6 == ObjectRefSelectorBase.LAYOUT_LIST)
                        {
                            this.m_NPCTradeLayout = _loc_6;
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

        public function getChannelSet(param1:int) : ChannelSet
        {
            return ChannelSet(this.getListItem(this.m_ChannelSet, param1));
        }// end function

        public function removeMappingSet(param1:int) : MappingSet
        {
            return MappingSet(this.removeListItem(this.m_MappingSet, param1, "mappingSet"));
        }// end function

        public function get combatPVPMode() : uint
        {
            return this.m_CombatPVPMode;
        }// end function

        public function get generalInputSetID() : int
        {
            return this.m_GeneralInputSetID;
        }// end function

        private function set _449599592marketBrowserLevel(param1:Boolean) : void
        {
            this.m_MarketBrowserLevel = param1;
            return;
        }// end function

        private function set _2037454619statusWidgetSkill(param1:int) : void
        {
            this.m_StatusWidgetSkill = param1;
            return;
        }// end function

        public function set statusPlayerStyle(param1:int) : void
        {
            var _loc_2:* = this.statusPlayerStyle;
            if (_loc_2 !== param1)
            {
                this._777059330statusPlayerStyle = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusPlayerStyle", _loc_2, param1));
            }
            return;
        }// end function

        public function get statusPlayerMana() : Boolean
        {
            return this.m_StatusPlayerMana;
        }// end function

        private function set _131184534marketBrowserCategory(param1:int) : void
        {
            if (!MarketWidget.isValidCategoryID(param1))
            {
                param1 = MarketWidget.CATEGORY_AMULETS;
            }
            this.m_MarketBrowserCategory = param1;
            return;
        }// end function

        private function set _1843511116rendererMaxFrameRate(param1:int) : void
        {
            this.m_RendererMaxFrameRate = Math.max(10, Math.min(param1, 60));
            return;
        }// end function

        public function addNameFilterSet(param1:NameFilterSet) : NameFilterSet
        {
            return NameFilterSet(this.addListItem(this.m_NameFilterSet, param1, "nameFilterSet"));
        }// end function

        public function get marketBrowserBodyPosition() : int
        {
            return this.m_MarketBrowserBodyPosition;
        }// end function

        private function set _2103194300statusWidgetVisible(param1:Boolean) : void
        {
            this.m_StatusWidgetVisible = param1;
            return;
        }// end function

        public function get mouseMapping() : MouseMapping
        {
            return this.m_MouseMapping;
        }// end function

        private function set _1731192988rendererLevelSeparator(param1:Number) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > 1)
            {
                param1 = 1;
            }
            this.m_RendererLevelSeparator = param1;
            return;
        }// end function

        public function addActionBarSet(param1:ActionBarSet) : ActionBarSet
        {
            return ActionBarSet(this.addListItem(this.m_ActionBarSet, param1, "actionBarSet"));
        }// end function

        public function removeBuddySet(param1:int) : BuddySet
        {
            return BuddySet(this.removeListItem(this.m_BuddySet, param1, "buddySet"));
        }// end function

        public function get marketBrowserCategory() : int
        {
            return this.m_MarketBrowserCategory;
        }// end function

        public function set rendererScaleMap(param1:Boolean) : void
        {
            var _loc_2:* = this.rendererScaleMap;
            if (_loc_2 !== param1)
            {
                this._1408018027rendererScaleMap = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererScaleMap", _loc_2, param1));
            }
            return;
        }// end function

        private function set _789326636statusPlayerFlags(param1:Boolean) : void
        {
            this.m_StatusPlayerFlags = param1;
            return;
        }// end function

        private function marshallGeneral(param1:XML) : void
        {
            var _loc_2:* = -1;
            switch(this.m_GeneralInputSetMode)
            {
                case MappingSet.CHAT_MODE_OFF:
                case MappingSet.CHAT_MODE_TEMPORARY:
                {
                    _loc_2 = MappingSet.CHAT_MODE_OFF;
                    break;
                }
                case MappingSet.CHAT_MODE_ON:
                {
                    _loc_2 = MappingSet.CHAT_MODE_ON;
                    break;
                }
                default:
                {
                    break;
                }
            }
            param1.appendChild(new XML("<general>\r\n                          " + ("<actionBarsLock>" + this.m_GeneralActionBarsLock + "</actionBarsLock>") + "\r\n                          " + ("<inputMouseControls>" + this.m_GeneralInputMouseControls + "</inputMouseControls>") + "\r\n                          " + ("<inputSetID>" + this.m_GeneralInputSetID + "</inputSetID>") + "\r\n                          " + ("<inputSetMode>" + _loc_2 + "</inputSetMode>") + "\r\n                          " + ("<uiGameWindowHeight>" + this.m_GeneralUIGameWindowHeight + "</uiGameWindowHeight>") + "\r\n                          " + ("<uiChatLeftViewWidth>" + this.m_GeneralUIChatLeftViewWidth + "</uiChatLeftViewWidth>") + "\r\n                          " + ("<shopBuyConfirmation>" + this.m_GeneralShopShowBuyConfirmation + "</shopBuyConfirmation>") + "\r\n                        </general>"));
            return;
        }// end function

        public function get statusWidgetStyle() : int
        {
            return this.m_StatusWidgetStyle;
        }// end function

        private function set _2037738107statusWidgetStyle(param1:int) : void
        {
            if (param1 == StatusWidget.STATUS_STYLE_COMPACT || param1 == StatusWidget.STATUS_STYLE_DEFAULT || param1 == StatusWidget.STATUS_STYLE_FAT || param1 == StatusWidget.STATUS_STYLE_PARALLEL)
            {
                this.m_StatusWidgetStyle = param1;
            }
            else
            {
                throw new ArgumentError("OptionsStorage.set statusWidgetStyle: Invalid style: " + param1);
            }
            return;
        }// end function

        private function initialiseChannelSet() : void
        {
            this.removeAllListItems(this.m_ChannelSet, null);
            this.addListItem(this.m_ChannelSet, new ChannelSet(ChannelSet.DEFAULT_SET), null);
            return;
        }// end function

        public function set marketSelectedView(param1:int) : void
        {
            var _loc_2:* = this.marketSelectedView;
            if (_loc_2 !== param1)
            {
                this._356338236marketSelectedView = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketSelectedView", _loc_2, param1));
            }
            return;
        }// end function

        public function set generalShopShowBuyConfirmation(param1:Boolean) : void
        {
            var _loc_2:* = this.generalShopShowBuyConfirmation;
            if (_loc_2 !== param1)
            {
                this._1775083584generalShopShowBuyConfirmation = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "generalShopShowBuyConfirmation", _loc_2, param1));
            }
            return;
        }// end function

        private function set _1918651986rendererLightEnabled(param1:Boolean) : void
        {
            this.m_RendererLightEnabled = param1;
            return;
        }// end function

        public function get statusCreatureName() : Boolean
        {
            return this.m_StatusCreatureName;
        }// end function

        public function get combatAutoChaseOff() : Boolean
        {
            return this.m_CombatAutoChaseOff;
        }// end function

        public function get rendererAmbientBrightness() : Number
        {
            return this.m_RendererAmbientBrightness;
        }// end function

        private function initialiseMessageFilterSet() : void
        {
            this.removeAllListItems(this.m_MessageFilterSet, null);
            this.addListItem(this.m_MessageFilterSet, new MessageFilterSet(MessageFilterSet.DEFAULT_SET), null);
            return;
        }// end function

        public function getNameFilterSetIDs() : Array
        {
            return this.getListIDs(this.m_NameFilterSet);
        }// end function

        public function set npcTradeSort(param1:int) : void
        {
            var _loc_2:* = this.npcTradeSort;
            if (_loc_2 !== param1)
            {
                this._1893979327npcTradeSort = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcTradeSort", _loc_2, param1));
            }
            return;
        }// end function

        private function initialiseCombat() : void
        {
            this.m_CombatAttackMode = COMBAT_ATTACK_BALANCED;
            this.m_CombatAutoChaseOff = true;
            this.m_CombatChaseMode = COMBAT_CHASE_OFF;
            this.m_CombatSecureMode = COMBAT_SECURE_ON;
            this.m_CombatPVPMode = COMBAT_PVP_MODE_DOVE;
            return;
        }// end function

        public function set rendererHighlight(param1:Number) : void
        {
            var _loc_2:* = this.rendererHighlight;
            if (_loc_2 !== param1)
            {
                this._498046769rendererHighlight = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererHighlight", _loc_2, param1));
            }
            return;
        }// end function

        private function addListItem(param1, param2, param3:String)
        {
            var _loc_7:* = null;
            if (param1 == null || param2 == null)
            {
                return null;
            }
            var _loc_4:* = this.removeListItem(param1, param2.ID, null);
            var _loc_5:* = param1.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5 && param1[_loc_6].ID <= param2.ID)
            {
                
                _loc_6++;
            }
            param1.splice(_loc_6, 0, param2);
            if (param2 is IEventDispatcher)
            {
                IEventDispatcher(param2).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onListItemEvent);
                IEventDispatcher(param2).addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onListItemEvent);
            }
            if (param3 != null)
            {
                _loc_7 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_7.kind = PropertyChangeEventKind.UPDATE;
                _loc_7.property = param3;
                dispatchEvent(_loc_7);
            }
            return _loc_4;
        }// end function

        public function set generalUIChatLeftViewWidth(param1:Number) : void
        {
            var _loc_2:* = this.generalUIChatLeftViewWidth;
            if (_loc_2 !== param1)
            {
                this._1252438854generalUIChatLeftViewWidth = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "generalUIChatLeftViewWidth", _loc_2, param1));
            }
            return;
        }// end function

        private function set _356294353marketSelectedType(param1) : void
        {
            if (param1 is AppearanceType)
            {
                this.m_MarketSelectedType = AppearanceType(param1).ID;
            }
            else
            {
                this.m_MarketSelectedType = int(param1);
            }
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = new XML("<options version=\"" + OPTIONS_MAX_COMPATIBLE_VERSION + "\"></options>");
            for each (_loc_2 in OPTION_GROUPS)
            {
                
                _loc_3 = "marshall" + _loc_2.localName;
                if (this.hasMethod(_loc_3))
                {
                    var _loc_6:* = this;
                    _loc_6[_loc_3](_loc_1);
                    continue;
                }
            }
            return _loc_1;
        }// end function

        private function marshallMarket(param1:XML) : void
        {
            param1.appendChild(new XML("<market>\r\n                          " + ("<browserLayout>" + this.m_MarketBrowserLayout + "</browserLayout>") + "\r\n                          " + ("<browserEditor>" + this.m_MarketBrowserEditor + "</browserEditor>") + "\r\n                          " + ("<browserDepot>" + this.m_MarketBrowserDepot + "</browserDepot>") + "\r\n                          " + ("<browserCategory>" + this.m_MarketBrowserCategory + "</browserCategory>") + "\r\n                          " + ("<browserLevel>" + this.m_MarketBrowserLevel + "</browserLevel>") + "\r\n                          " + ("<browserProfession>" + this.m_MarketBrowserProfession + "</browserProfession>") + "\r\n                          " + ("<browserBodyPosition>" + this.m_MarketBrowserBodyPosition + "</browserBodyPosition>") + "\r\n                          " + ("<browserName>" + this.m_MarketBrowserName + "</browserName>") + "\r\n                          " + ("<selectedView>" + this.m_MarketSelectedView + "</selectedView>") + "\r\n                          " + ("<selectedType>" + this.m_MarketSelectedType + "</selectedType>") + "\r\n                        </market>"));
            return;
        }// end function

        public function get uiHints() : UiServerHints
        {
            return this.m_ServerUIHints;
        }// end function

        public function set statusCreatureIcons(param1:Boolean) : void
        {
            var _loc_2:* = this.statusCreatureIcons;
            if (_loc_2 !== param1)
            {
                this._747180215statusCreatureIcons = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusCreatureIcons", _loc_2, param1));
            }
            return;
        }// end function

        public function get opponentSort() : int
        {
            return this.m_OpponentSort;
        }// end function

        public function get statusPlayerName() : Boolean
        {
            return this.m_StatusPlayerName;
        }// end function

        private function initialiseHelp() : void
        {
            this.m_KnownTutorialHint.length = 0;
            return;
        }// end function

        private function initialiseRenderer() : void
        {
            this.m_RendererAmbientBrightness = 0.25;
            this.m_RendererHighlight = 0.75;
            this.m_RendererLevelSeparator = 0.33;
            this.m_RendererLightEnabled = false;
            this.m_RendererMaxFrameRate = 50;
            this.m_RendererScaleMap = true;
            this.m_RendererAntialiasing = false;
            this.m_RendererShowFrameRate = false;
            return;
        }// end function

        public function set opponentFilter(param1:int) : void
        {
            var _loc_2:* = this.opponentFilter;
            if (_loc_2 !== param1)
            {
                this._999334091opponentFilter = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "opponentFilter", _loc_2, param1));
            }
            return;
        }// end function

        private function unmarshallNameFilterSet(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = NameFilterSet.s_Unmarshall(param1, param2);
            if (this.m_NameFilterSet.length >= NameFilterSet.NUM_SETS && this.getListItem(this.m_NameFilterSet, _loc_4.ID) == null)
            {
                throw new Error("OptionsStorage.unmarshallNameFilterSet: Too many sets.");
            }
            this.addListItem(this.m_NameFilterSet, _loc_4, null);
            return;
        }// end function

        public function set marketBrowserDepot(param1:Boolean) : void
        {
            var _loc_2:* = this.marketBrowserDepot;
            if (_loc_2 !== param1)
            {
                this._456993208marketBrowserDepot = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserDepot", _loc_2, param1));
            }
            return;
        }// end function

        public function getMappingSet(param1:int) : MappingSet
        {
            return MappingSet(this.getListItem(this.m_MappingSet, param1));
        }// end function

        public function get statusWidgetLocation() : int
        {
            return this.m_StatusWidgetLocation;
        }// end function

        private function set _512938034combatSecureMode(param1:int) : void
        {
            if (param1 != COMBAT_SECURE_OFF && param1 != COMBAT_SECURE_ON)
            {
                throw new ArgumentError("OptionsStorage.set combatSecureMode: Invalid mode.");
            }
            this.m_CombatSecureMode = param1;
            return;
        }// end function

        private function onListItemEvent(event:Event) : void
        {
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function set combatPVPMode(param1:uint) : void
        {
            var _loc_2:* = this.combatPVPMode;
            if (_loc_2 !== param1)
            {
                this._614115751combatPVPMode = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "combatPVPMode", _loc_2, param1));
            }
            return;
        }// end function

        private function unmarshallOpponent(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (param1 == null || param1.localName() != "opponent" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallOpponent: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "sort":
                    {
                        this.m_OpponentSort = XMLHelper.s_UnmarshallInteger(_loc_4);
                        break;
                    }
                    case "filter":
                    {
                        this.m_OpponentFilter = XMLHelper.s_UnmarshallInteger(_loc_4);
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

        private function marshallSideBarSet(param1:XML) : void
        {
            var _loc_2:* = this.m_SideBarSet.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.appendChild(this.m_SideBarSet[_loc_3].marshall());
                _loc_3++;
            }
            return;
        }// end function

        public function set rendererAntialiasing(param1:Boolean) : void
        {
            var _loc_2:* = this.rendererAntialiasing;
            if (_loc_2 !== param1)
            {
                this._1851025751rendererAntialiasing = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererAntialiasing", _loc_2, param1));
            }
            return;
        }// end function

        public function get statusCreatureFlags() : Boolean
        {
            return this.m_StatusCreatureFlags;
        }// end function

        public function set statusPlayerMana(param1:Boolean) : void
        {
            var _loc_2:* = this.statusPlayerMana;
            if (_loc_2 !== param1)
            {
                this._251830874statusPlayerMana = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusPlayerMana", _loc_2, param1));
            }
            return;
        }// end function

        public function set generalInputSetID(param1:int) : void
        {
            var _loc_2:* = this.generalInputSetID;
            if (_loc_2 !== param1)
            {
                this._442884517generalInputSetID = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "generalInputSetID", _loc_2, param1));
            }
            return;
        }// end function

        private function unmarshallGeneral(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            if (param1 == null || param1.localName() != "general" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallGeneral: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "actionBarsLock":
                    {
                        this.m_GeneralActionBarsLock = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "inputClassicControls":
                    {
                        _loc_5 = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        if (_loc_5)
                        {
                            this.m_MouseMapping.replaceAll(MouseMapping.PRESET_SMART_RIGHT_CLICK.mouseBindings);
                        }
                        else
                        {
                            this.m_MouseMapping.replaceAll(MouseMapping.PRESET_KEYMODIFIED_LEFT_CLICK.mouseBindings);
                        }
                        break;
                    }
                    case "inputMouseControls":
                    {
                        this.m_GeneralInputMouseControls = XMLHelper.s_UnmarshallInteger(_loc_4);
                    }
                    case "inputSetID":
                    {
                        this.m_GeneralInputSetID = XMLHelper.s_UnmarshallInteger(_loc_4);
                        break;
                    }
                    case "inputSetMode":
                    {
                        _loc_6 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_6 == MappingSet.CHAT_MODE_OFF || _loc_6 == MappingSet.CHAT_MODE_ON)
                        {
                            this.m_GeneralInputSetMode = _loc_6;
                        }
                        break;
                    }
                    case "uiGameWindowHeight":
                    {
                        this.m_GeneralUIGameWindowHeight = Math.max(0, Math.min(XMLHelper.s_UnmarshallDecimal(_loc_4), 10000));
                        break;
                    }
                    case "uiChatLeftViewWidth":
                    {
                        this.m_GeneralUIChatLeftViewWidth = Math.max(0, Math.min(XMLHelper.s_UnmarshallDecimal(_loc_4), 100));
                        break;
                    }
                    case "shopBuyConfirmation":
                    {
                        this.m_GeneralShopShowBuyConfirmation = XMLHelper.s_UnmarshallBoolean(_loc_4);
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

        public function get statusWidgetVisible() : Boolean
        {
            return this.m_StatusWidgetVisible;
        }// end function

        private function set _1823004292combatAutoChaseOff(param1:Boolean) : void
        {
            this.m_CombatAutoChaseOff = param1;
            return;
        }// end function

        public function set rendererMaxFrameRate(param1:int) : void
        {
            var _loc_2:* = this.rendererMaxFrameRate;
            if (_loc_2 !== param1)
            {
                this._1843511116rendererMaxFrameRate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererMaxFrameRate", _loc_2, param1));
            }
            return;
        }// end function

        public function set marketBrowserBodyPosition(param1:int) : void
        {
            var _loc_2:* = this.marketBrowserBodyPosition;
            if (_loc_2 !== param1)
            {
                this._1191209559marketBrowserBodyPosition = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserBodyPosition", _loc_2, param1));
            }
            return;
        }// end function

        private function getKnownTutorialHintIndex(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = this.m_KnownTutorialHint.length - 1;
            var _loc_4:* = 0;
            while (_loc_2 <= _loc_3)
            {
                
                _loc_4 = (_loc_2 + _loc_3) / 2;
                if (this.m_KnownTutorialHint[_loc_4] < param1)
                {
                    _loc_2 = _loc_4 + 1;
                    continue;
                }
                if (this.m_KnownTutorialHint[_loc_4] > param1)
                {
                    _loc_3 = _loc_4 - 1;
                    continue;
                }
                return _loc_4;
            }
            return -_loc_2 - 1;
        }// end function

        public function set rendererLevelSeparator(param1:Number) : void
        {
            var _loc_2:* = this.rendererLevelSeparator;
            if (_loc_2 !== param1)
            {
                this._1731192988rendererLevelSeparator = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererLevelSeparator", _loc_2, param1));
            }
            return;
        }// end function

        public function getDefaultActionBarSet(param1:int = 0) : ActionBarSet
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this.searchDefaultXmlFirstLevelElements("ActionBarSet");
            if (_loc_2.length() > 0)
            {
                for each (_loc_3 in _loc_2)
                {
                    
                    _loc_4 = ActionBarSet.s_Unmarshall(_loc_3, this.m_Version);
                    if (_loc_4.ID == param1)
                    {
                        return _loc_4;
                    }
                }
            }
            throw new Error(StringUtil.substitute("OptionsStorage.getDefaultActionBarSet: No actionbar set width ID {0} found in default options", param1));
        }// end function

        private function set _456993208marketBrowserDepot(param1:Boolean) : void
        {
            this.m_MarketBrowserDepot = param1;
            return;
        }// end function

        private function marshallActionBarSet(param1:XML) : void
        {
            var _loc_2:* = this.m_ActionBarSet.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.appendChild(this.m_ActionBarSet[_loc_3].marshall());
                _loc_3++;
            }
            return;
        }// end function

        private function set _777059330statusPlayerStyle(param1:int) : void
        {
            if (param1 == RendererImpl.STATUS_STYLE_OFF || param1 == RendererImpl.STATUS_STYLE_CLASSIC || param1 == RendererImpl.STATUS_STYLE_HUD)
            {
                this.m_StatusPlayerStyle = param1;
            }
            else
            {
                throw new ArgumentError("OptionsStorage.set statusPlayerStyle: Invalid style: " + param1);
            }
            return;
        }// end function

        public function set marketBrowserProfession(param1:Boolean) : void
        {
            var _loc_2:* = this.marketBrowserProfession;
            if (_loc_2 !== param1)
            {
                this._273891688marketBrowserProfession = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserProfession", _loc_2, param1));
            }
            return;
        }// end function

        public function get marketSelectedType() : int
        {
            return this.m_MarketSelectedType;
        }// end function

        public function set generalActionBarsLock(param1:Boolean) : void
        {
            var _loc_2:* = this.generalActionBarsLock;
            if (_loc_2 !== param1)
            {
                this._259410793generalActionBarsLock = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "generalActionBarsLock", _loc_2, param1));
            }
            return;
        }// end function

        private function initialiseNPCTrade() : void
        {
            this.m_NPCTradeBuyIgnoreCapacity = false;
            this.m_NPCTradeBuyWithBackpacks = false;
            this.m_NPCTradeLayout = ObjectRefSelectorBase.LAYOUT_LIST;
            this.m_NPCTradeSellKeepEquipped = true;
            this.m_NPCTradeSort = ObjectRefSelectorBase.SORT_NAME;
            return;
        }// end function

        public function get statusPlayerFlags() : Boolean
        {
            return this.m_StatusPlayerFlags;
        }// end function

        private function set _1351476655statusPlayerHealth(param1:Boolean) : void
        {
            this.m_StatusPlayerHealth = param1;
            return;
        }// end function

        private function set _460459880uiHints(param1:UiServerHints) : void
        {
            this.m_ServerUIHints = param1;
            this.m_ServerUIHints.options = this;
            return;
        }// end function

        private function marshallHelp(param1:XML) : void
        {
            var _loc_2:* = <knownTutorialHints/>;
            var _loc_3:* = 0;
            var _loc_4:* = this.m_KnownTutorialHint.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_2.appendChild(new XML("<hint>" + this.m_KnownTutorialHint[_loc_3] + "</hint>"));
                _loc_3++;
            }
            param1.appendChild(new XML("<help>\r\n                          " + _loc_2 + "\r\n                        </help>"));
            return;
        }// end function

        private function set _1916522523generalUIGameWindowHeight(param1:Number) : void
        {
            this.m_GeneralUIGameWindowHeight = Math.max(0, Math.min(param1, 100));
            return;
        }// end function

        private function set _1851025751rendererAntialiasing(param1:Boolean) : void
        {
            this.m_RendererAntialiasing = param1;
            return;
        }// end function

        public function set marketBrowserCategory(param1:int) : void
        {
            var _loc_2:* = this.marketBrowserCategory;
            if (_loc_2 !== param1)
            {
                this._131184534marketBrowserCategory = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserCategory", _loc_2, param1));
            }
            return;
        }// end function

        private function initialiseMappingSet() : void
        {
            this.removeAllListItems(this.m_MappingSet, null);
            var _loc_1:* = new MappingSet(MappingSet.DEFAULT_SET);
            _loc_1.initialiseDefaultBindings();
            this.addListItem(this.m_MappingSet, _loc_1, null);
            return;
        }// end function

        public function getMessageFilterSet(param1:int) : MessageFilterSet
        {
            return MessageFilterSet(this.getListItem(this.m_MessageFilterSet, param1));
        }// end function

        public function set rendererShowFrameRate(param1:Boolean) : void
        {
            var _loc_2:* = this.rendererShowFrameRate;
            if (_loc_2 !== param1)
            {
                this._1621507731rendererShowFrameRate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererShowFrameRate", _loc_2, param1));
            }
            return;
        }// end function

        public function set statusWidgetStyle(param1:int) : void
        {
            var _loc_2:* = this.statusWidgetStyle;
            if (_loc_2 !== param1)
            {
                this._2037738107statusWidgetStyle = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusWidgetStyle", _loc_2, param1));
            }
            return;
        }// end function

        public function unload() : void
        {
            this.removeAllListItems(this.m_SideBarSet, null);
            this.removeAllListItems(this.m_ActionBarSet, null);
            this.removeAllListItems(this.m_MappingSet, null);
            this.removeAllListItems(this.m_MessageFilterSet, null);
            this.removeAllListItems(this.m_ChannelSet, null);
            this.removeAllListItems(this.m_NameFilterSet, null);
            this.removeAllListItems(this.m_BuddySet, null);
            var _loc_1:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_1.property = "*";
            _loc_1.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_1);
            return;
        }// end function

        public function resetMessageFilterSet() : void
        {
            var _loc_1:* = this.searchDefaultXmlFirstLevelElements("MessageFilterSet");
            if (_loc_1.length() > 0)
            {
                this.unmarshallMessageFilterSet(_loc_1[0], this.m_Version);
            }
            return;
        }// end function

        private function set _442884517generalInputSetID(param1:int) : void
        {
            if (this.getActionBarSet(param1) == null || this.getMappingSet(param1) == null)
            {
                throw new ArgumentError("OptionsStorage.set generalInputSetID: Invalid set ID.");
            }
            this.m_GeneralInputSetID = param1;
            return;
        }// end function

        public function get generalInputSetMode() : int
        {
            return this.m_GeneralInputSetMode;
        }// end function

        private function unmarshallActionBarSet(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = ActionBarSet.s_Unmarshall(param1, param2);
            if (this.m_ActionBarSet.length >= ActionBarSet.NUM_SETS && this.getListItem(this.m_ActionBarSet, _loc_4.ID) == null)
            {
                throw new Error("OptionsStorage.unmarshallActionBarSet: Too many sets.");
            }
            if (_loc_4.ID == 0 || !param3)
            {
                this.addListItem(this.m_ActionBarSet, _loc_4, null);
            }
            return;
        }// end function

        public function addSideBarSet(param1:SideBarSet) : SideBarSet
        {
            return SideBarSet(this.addListItem(this.m_SideBarSet, param1, "sideBarSet"));
        }// end function

        private function unmarshallStatus(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (param1 == null || param1.localName() != "status" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallStatus: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "widgetLocation":
                    {
                        _loc_5 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_5 == StatusWidget.LOCATION_TOP || _loc_5 == StatusWidget.LOCATION_BOTTOM || _loc_5 == StatusWidget.LOCATION_LEFT || _loc_5 == StatusWidget.LOCATION_RIGHT)
                        {
                            this.m_StatusWidgetLocation = _loc_5;
                        }
                        break;
                    }
                    case "widgetStyle":
                    {
                        _loc_6 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_6 == StatusWidget.STATUS_STYLE_OFF)
                        {
                            this.m_StatusWidgetVisible = false;
                        }
                        else if (_loc_6 == StatusWidget.STATUS_STYLE_COMPACT || _loc_6 == StatusWidget.STATUS_STYLE_DEFAULT || _loc_6 == StatusWidget.STATUS_STYLE_FAT || _loc_6 == StatusWidget.STATUS_STYLE_PARALLEL)
                        {
                            this.m_StatusWidgetStyle = _loc_6;
                        }
                        break;
                    }
                    case "widgetSkill":
                    {
                        _loc_7 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (StatusWidget.s_GetSkillName(_loc_7) != null)
                        {
                            this.m_StatusWidgetSkill = _loc_7;
                        }
                        break;
                    }
                    case "widgetVisible":
                    {
                        this.m_StatusWidgetVisible = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "playerStyle":
                    {
                        _loc_8 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_8 == RendererImpl.STATUS_STYLE_OFF || _loc_8 == RendererImpl.STATUS_STYLE_CLASSIC || _loc_8 == RendererImpl.STATUS_STYLE_HUD)
                        {
                            this.m_StatusPlayerStyle = _loc_8;
                        }
                        break;
                    }
                    case "playerName":
                    {
                        this.m_StatusPlayerName = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "playerFlags":
                    {
                        this.m_StatusPlayerFlags = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "playerHealth":
                    {
                        this.m_StatusPlayerHealth = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "playerMana":
                    {
                        this.m_StatusPlayerMana = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "creatureStyle":
                    {
                        _loc_9 = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (_loc_9 == RendererImpl.STATUS_STYLE_OFF || _loc_9 == RendererImpl.STATUS_STYLE_CLASSIC || _loc_9 == RendererImpl.STATUS_STYLE_HUD)
                        {
                            this.m_StatusCreatureStyle = _loc_9;
                        }
                        break;
                    }
                    case "creatureName":
                    {
                        this.m_StatusCreatureName = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "creatureFlags":
                    {
                        this.m_StatusCreatureFlags = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "creatureIcons":
                    {
                        this.m_StatusCreatureIcons = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "creatureHealth":
                    {
                        this.m_StatusCreatureHealth = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "creaturePvpFrames":
                    {
                        this.m_StatusCreaturePvpFrames = XMLHelper.s_UnmarshallBoolean(_loc_4);
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

        public function set rendererAmbientBrightness(param1:Number) : void
        {
            var _loc_2:* = this.rendererAmbientBrightness;
            if (_loc_2 !== param1)
            {
                this._1869292922rendererAmbientBrightness = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererAmbientBrightness", _loc_2, param1));
            }
            return;
        }// end function

        public function set combatAutoChaseOff(param1:Boolean) : void
        {
            var _loc_2:* = this.combatAutoChaseOff;
            if (_loc_2 !== param1)
            {
                this._1823004292combatAutoChaseOff = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "combatAutoChaseOff", _loc_2, param1));
            }
            return;
        }// end function

        public function set statusCreatureName(param1:Boolean) : void
        {
            var _loc_2:* = this.statusCreatureName;
            if (_loc_2 !== param1)
            {
                this._1361517692statusCreatureName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusCreatureName", _loc_2, param1));
            }
            return;
        }// end function

        public function get npcTradeBuyWithBackpacks() : Boolean
        {
            return this.m_NPCTradeBuyWithBackpacks;
        }// end function

        private function set _1775083584generalShopShowBuyConfirmation(param1:Boolean) : void
        {
            this.m_GeneralShopShowBuyConfirmation = param1;
            return;
        }// end function

        private function set _999334091opponentFilter(param1:int) : void
        {
            this.m_OpponentFilter = param1;
            return;
        }// end function

        public function get npcTradeSellKeepEquipped() : Boolean
        {
            return this.m_NPCTradeSellKeepEquipped;
        }// end function

        private function set _356338236marketSelectedView(param1:int) : void
        {
            if (param1 != MarketWidget.VIEW_MARKET_DETAILS && param1 != MarketWidget.VIEW_MARKET_OFFERS && param1 != MarketWidget.VIEW_MARKET_STATISTICS && param1 != MarketWidget.VIEW_OWN_HISTORY && param1 != MarketWidget.VIEW_OWN_OFFERS)
            {
                param1 = MarketWidget.VIEW_MARKET_OFFERS;
            }
            this.m_MarketSelectedView = param1;
            return;
        }// end function

        private function set _1869292922rendererAmbientBrightness(param1:Number) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > 1)
            {
                param1 = 1;
            }
            this.m_RendererAmbientBrightness = param1;
            return;
        }// end function

        public function get statusCreaturePvpFrames() : Boolean
        {
            return this.m_StatusCreaturePvpFrames;
        }// end function

        private function getListIDs(param1) : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = [];
            if (param1 != null)
            {
                _loc_3 = 0;
                _loc_4 = param1.length;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_2.push(param1[_loc_3].ID);
                    _loc_3++;
                }
            }
            return _loc_2;
        }// end function

        private function unmarshallSideBarSet(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = SideBarSet.s_Unmarshall(param1, param2);
            if (this.m_SideBarSet.length >= SideBarSet.NUM_SETS && this.getListItem(this.m_SideBarSet, _loc_4.ID) == null)
            {
                throw new Error("OptionsStorage.unmarshallSideBarSet: Too many sets.");
            }
            this.addListItem(this.m_SideBarSet, _loc_4, null);
            return;
        }// end function

        public function getMessageFilterSetIDs() : Array
        {
            return this.getListIDs(this.m_MessageFilterSet);
        }// end function

        private function set _1361517692statusCreatureName(param1:Boolean) : void
        {
            this.m_StatusCreatureName = param1;
            return;
        }// end function

        private function set _1714951155statusCreatureHealth(param1:Boolean) : void
        {
            this.m_StatusCreatureHealth = param1;
            return;
        }// end function

        public function get statusWidgetSkill() : int
        {
            return this.m_StatusWidgetSkill;
        }// end function

        public function getDefaultMappingSet() : MappingSet
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = this.searchDefaultXmlFirstLevelElements("MappingSet");
            if (_loc_1.length() > 0)
            {
                for each (_loc_2 in _loc_1)
                {
                    
                    _loc_3 = MappingSet.s_Unmarshall(_loc_2, this.m_Version);
                    if (_loc_3.ID == 0)
                    {
                        return _loc_3;
                    }
                }
            }
            throw new Error("OptionsStorage.getDefaultMappingSet: No mapping set width ID 0 found in default options");
        }// end function

        public function set uiHints(param1:UiServerHints) : void
        {
            var _loc_2:* = this.uiHints;
            if (_loc_2 !== param1)
            {
                this._460459880uiHints = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uiHints", _loc_2, param1));
            }
            return;
        }// end function

        public function get rendererHighlight() : Number
        {
            return this.m_RendererHighlight;
        }// end function

        private function set _120469519npcTradeBuyIgnoreCapacity(param1:Boolean) : void
        {
            this.m_NPCTradeBuyIgnoreCapacity = param1;
            return;
        }// end function

        public function set marketBrowserLayout(param1:int) : void
        {
            var _loc_2:* = this.marketBrowserLayout;
            if (_loc_2 !== param1)
            {
                this._1056280170marketBrowserLayout = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserLayout", _loc_2, param1));
            }
            return;
        }// end function

        private function initialiseOpponent() : void
        {
            this.m_OpponentFilter = CreatureStorage.FILTER_NONE;
            this.m_OpponentSort = CreatureStorage.SORT_KNOWN_SINCE_ASC;
            return;
        }// end function

        public function set opponentSort(param1:int) : void
        {
            var _loc_2:* = this.opponentSort;
            if (_loc_2 !== param1)
            {
                this._407350117opponentSort = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "opponentSort", _loc_2, param1));
            }
            return;
        }// end function

        public function set marketBrowserLevel(param1:Boolean) : void
        {
            var _loc_2:* = this.marketBrowserLevel;
            if (_loc_2 !== param1)
            {
                this._449599592marketBrowserLevel = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserLevel", _loc_2, param1));
            }
            return;
        }// end function

        private function set _251195935combatAttackMode(param1:int) : void
        {
            if (param1 != COMBAT_ATTACK_OFFENSIVE && param1 != COMBAT_ATTACK_BALANCED && param1 != COMBAT_ATTACK_DEFENSIVE)
            {
                throw new ArgumentError("OptionsStorage.set combatAttackMode: Invalid mode.");
            }
            this.m_CombatAttackMode = param1;
            return;
        }// end function

        public function getKnownTutorialHint(param1:int) : Boolean
        {
            return this.getKnownTutorialHintIndex(param1) > -1;
        }// end function

        public function get opponentFilter() : int
        {
            return this.m_OpponentFilter;
        }// end function

        public function getActionBarSetIDs() : Array
        {
            return this.getListIDs(this.m_ActionBarSet);
        }// end function

        public function get npcTradeSort() : int
        {
            return this.m_NPCTradeSort;
        }// end function

        private function set _410094845generalInputSetMode(param1:int) : void
        {
            if (param1 != MappingSet.CHAT_MODE_OFF && param1 != MappingSet.CHAT_MODE_ON && param1 != MappingSet.CHAT_MODE_TEMPORARY)
            {
                throw new ArgumentError("OptionsStorage.set generalInputSetMode: Invalid mode: " + param1);
            }
            this.m_GeneralInputSetMode = param1;
            return;
        }// end function

        private function unmarshallMarket(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (param1 == null || param1.localName() != "market" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("OptionsStorage.unmarshallMarket: Invalid input.");
            }
            for each (_loc_4 in param1.elements())
            {
                
                switch(_loc_4.localName())
                {
                    case "browserLayout":
                    {
                        this.m_MarketBrowserLayout = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (this.m_MarketBrowserLayout != AppearanceTypeBrowser.LAYOUT_LIST && this.m_MarketBrowserLayout != AppearanceTypeBrowser.LAYOUT_TILE)
                        {
                            this.m_MarketBrowserLayout = AppearanceTypeBrowser.LAYOUT_TILE;
                        }
                        break;
                    }
                    case "browserEditor":
                    {
                        this.m_MarketBrowserEditor = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (this.m_MarketBrowserEditor != AppearanceTypeBrowser.EDITOR_CATEGORY && this.m_MarketBrowserEditor != AppearanceTypeBrowser.EDITOR_NAME)
                        {
                            this.m_MarketBrowserEditor = AppearanceTypeBrowser.EDITOR_CATEGORY;
                        }
                        break;
                    }
                    case "browserDepot":
                    {
                        this.m_MarketBrowserDepot = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "browserCategory":
                    {
                        this.m_MarketBrowserCategory = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (!MarketWidget.isValidCategoryID(this.m_MarketBrowserCategory))
                        {
                            this.m_MarketBrowserCategory = MarketWidget.CATEGORY_AMULETS;
                        }
                        break;
                    }
                    case "browserLevel":
                    {
                        this.m_MarketBrowserLevel = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "browserProfession":
                    {
                        this.m_MarketBrowserProfession = XMLHelper.s_UnmarshallBoolean(_loc_4);
                        break;
                    }
                    case "browserBodyPosition":
                    {
                        this.m_MarketBrowserBodyPosition = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (this.m_MarketBrowserBodyPosition != BodyContainerView.BOTH_HANDS && this.m_MarketBrowserBodyPosition != BodyContainerView.LEFT_HAND)
                        {
                            this.m_MarketBrowserBodyPosition = -1;
                        }
                        break;
                    }
                    case "browserName":
                    {
                        this.m_MarketBrowserName = XMLHelper.s_UnmarshallString(_loc_4);
                        break;
                    }
                    case "selectedView":
                    {
                        this.m_MarketSelectedView = XMLHelper.s_UnmarshallInteger(_loc_4);
                        if (this.m_MarketSelectedView != MarketWidget.VIEW_MARKET_DETAILS && this.m_MarketSelectedView != MarketWidget.VIEW_MARKET_OFFERS && this.m_MarketSelectedView != MarketWidget.VIEW_MARKET_STATISTICS && this.m_MarketSelectedView != MarketWidget.VIEW_OWN_HISTORY && this.m_MarketSelectedView != MarketWidget.VIEW_OWN_OFFERS)
                        {
                            this.m_MarketSelectedView = MarketWidget.VIEW_MARKET_OFFERS;
                        }
                        break;
                    }
                    case "selectedType":
                    {
                        this.m_MarketSelectedType = XMLHelper.s_UnmarshallInteger(_loc_4);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function marshallCombat(param1:XML) : void
        {
            param1.appendChild(new XML("<combat>\r\n                          " + ("<attackMode>" + this.m_CombatAttackMode + "</attackMode>") + "\r\n                          " + ("<chaseMode>" + this.m_CombatChaseMode + "</chaseMode>") + "\r\n                          " + ("<autoChaseOff>" + this.m_CombatAutoChaseOff + "</autoChaseOff>") + "\r\n                          " + ("<secureMode>" + this.m_CombatSecureMode + "</secureMode>") + "\r\n                        </combat>"));
            return;
        }// end function

        public function get generalUIChatLeftViewWidth() : Number
        {
            return this.m_GeneralUIChatLeftViewWidth;
        }// end function

        public function get statusCreatureIcons() : Boolean
        {
            return this.m_StatusCreatureIcons;
        }// end function

        public function getBuddySet(param1:int) : BuddySet
        {
            return BuddySet(this.getListItem(this.m_BuddySet, param1));
        }// end function

        public function resetMouseBindings() : void
        {
            var _loc_1:* = this.searchDefaultXmlFirstLevelElements("MouseMapping");
            if (_loc_1.length() > 0)
            {
                this.unmarshallMouseMapping(_loc_1[0], this.m_Version);
            }
            else
            {
                this.m_MouseMapping.initialiseDefaultBindings();
            }
            return;
        }// end function

        public function get rendererMaxFrameRate() : int
        {
            return this.m_RendererMaxFrameRate;
        }// end function

        public function reset() : void
        {
            this.initialiseActionBarSet();
            this.initialiseChannelSet();
            this.initialiseMappingSet();
            this.initialiseMessageFilterSet();
            this.initialiseNameFilterSet();
            this.initialiseSideBarSet();
            this.unmarshall(this.m_DefaultOptionsXml);
            return;
        }// end function

        private function set _738874381npcTradeLayout(param1:int) : void
        {
            if (param1 != ObjectRefSelectorBase.LAYOUT_GRID && param1 != ObjectRefSelectorBase.LAYOUT_LIST)
            {
                throw new ArgumentError("OptionsStorage.set npcTradeLayout: Invalid value: " + param1 + ".");
            }
            this.m_NPCTradeLayout = param1;
            return;
        }// end function

        public function set statusPlayerName(param1:Boolean) : void
        {
            var _loc_2:* = this.statusPlayerName;
            if (_loc_2 !== param1)
            {
                this._251860638statusPlayerName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusPlayerName", _loc_2, param1));
            }
            return;
        }// end function

        private function set _147163423statusCreaturePvpFrames(param1:Boolean) : void
        {
            this.m_StatusCreaturePvpFrames = param1;
            return;
        }// end function

        public function set statusWidgetLocation(param1:int) : void
        {
            var _loc_2:* = this.statusWidgetLocation;
            if (_loc_2 !== param1)
            {
                this._1091413675statusWidgetLocation = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusWidgetLocation", _loc_2, param1));
            }
            return;
        }// end function

        public function get rendererAntialiasing() : Boolean
        {
            return this.m_RendererAntialiasing;
        }// end function

        public function removeNameFilterSet(param1:int) : NameFilterSet
        {
            return NameFilterSet(this.removeListItem(this.m_NameFilterSet, param1, "nameFilterSet"));
        }// end function

        public function set statusPlayerHealth(param1:Boolean) : void
        {
            var _loc_2:* = this.statusPlayerHealth;
            if (_loc_2 !== param1)
            {
                this._1351476655statusPlayerHealth = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusPlayerHealth", _loc_2, param1));
            }
            return;
        }// end function

        public function removeSideBarSet(param1:int) : SideBarSet
        {
            return SideBarSet(this.removeListItem(this.m_SideBarSet, param1, "sideBarSet"));
        }// end function

        public function get rendererLevelSeparator() : Number
        {
            return this.m_RendererLevelSeparator;
        }// end function

        public function get marketBrowserProfession() : Boolean
        {
            return this.m_MarketBrowserProfession;
        }// end function

        public function get generalActionBarsLock() : Boolean
        {
            return this.m_GeneralActionBarsLock;
        }// end function

        public function set rendererLightEnabled(param1:Boolean) : void
        {
            var _loc_2:* = this.rendererLightEnabled;
            if (_loc_2 !== param1)
            {
                this._1918651986rendererLightEnabled = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rendererLightEnabled", _loc_2, param1));
            }
            return;
        }// end function

        public function get rendererShowFrameRate() : Boolean
        {
            return this.m_RendererShowFrameRate;
        }// end function

        private function marshallRenderer(param1:XML) : void
        {
            param1.appendChild(new XML("<renderer>\r\n                          " + ("<lightEnabled>" + this.m_RendererLightEnabled + "</lightEnabled>") + "\r\n                          " + ("<ambientBrightness>" + this.m_RendererAmbientBrightness + "</ambientBrightness>") + "\r\n                          " + ("<highlight>" + this.m_RendererHighlight + "</highlight>") + "\r\n                          " + ("<levelSeparator>" + this.m_RendererLevelSeparator + "</levelSeparator>") + "\r\n                          " + ("<scaleMap>" + this.m_RendererScaleMap + "</scaleMap>") + "\r\n                          " + ("<antialiasing>" + this.m_RendererAntialiasing + "</antialiasing>") + "\r\n                          " + ("<maxFrameRate>" + this.m_RendererMaxFrameRate + "</maxFrameRate>") + "\r\n                          " + ("<showFrameRate>" + this.m_RendererShowFrameRate + "</showFrameRate>") + "\r\n                        </renderer>"));
            return;
        }// end function

        public function set statusCreatureFlags(param1:Boolean) : void
        {
            var _loc_2:* = this.statusCreatureFlags;
            if (_loc_2 !== param1)
            {
                this._749696330statusCreatureFlags = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusCreatureFlags", _loc_2, param1));
            }
            return;
        }// end function

        public function getSideBarSet(param1:int) : SideBarSet
        {
            return SideBarSet(this.getListItem(this.m_SideBarSet, param1));
        }// end function

        private function set _1056280170marketBrowserLayout(param1:int) : void
        {
            if (param1 != AppearanceTypeBrowser.LAYOUT_LIST && param1 != AppearanceTypeBrowser.LAYOUT_TILE)
            {
                param1 = AppearanceTypeBrowser.LAYOUT_TILE;
            }
            this.m_MarketBrowserLayout = param1;
            return;
        }// end function

        public function clone() : OptionsStorage
        {
            var _loc_1:* = null;
            _loc_1 = this.marshall();
            var _loc_2:* = new OptionsStorage(this.m_DefaultOptionsXml, _loc_1, true);
            var _loc_3:* = null;
            var _loc_5:* = this.getBuddySet(BuddySet.DEFAULT_SET);
            _loc_3 = this.getBuddySet(BuddySet.DEFAULT_SET);
            if (_loc_5 != null)
            {
                _loc_2.addBuddySet(_loc_3.clone());
            }
            var _loc_4:* = null;
            var _loc_5:* = this.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            _loc_4 = this.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            if (_loc_5 != null)
            {
                _loc_2.addNameFilterSet(_loc_4.clone());
            }
            _loc_2.uiHints = this.uiHints.clone();
            return _loc_2;
        }// end function

        private function set _1252438854generalUIChatLeftViewWidth(param1:Number) : void
        {
            this.m_GeneralUIChatLeftViewWidth = Math.max(0, Math.min(param1, 100));
            return;
        }// end function

        public function addBuddySet(param1:BuddySet) : BuddySet
        {
            return BuddySet(this.addListItem(this.m_BuddySet, param1, "buddySet"));
        }// end function

        private function set _558862877combatChaseMode(param1:int) : void
        {
            if (param1 != COMBAT_CHASE_OFF && param1 != COMBAT_CHASE_ON)
            {
                throw new ArgumentError("OptionsStorage.set combatChaseMode: Invalid mode.");
            }
            this.m_CombatChaseMode = param1;
            return;
        }// end function

        private function initialiseStatus() : void
        {
            this.m_StatusCreatureFlags = true;
            this.m_StatusCreatureIcons = true;
            this.m_StatusCreatureHealth = true;
            this.m_StatusCreatureName = true;
            this.m_StatusCreaturePvpFrames = true;
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
            return;
        }// end function

        public function setMappingAndActionBarSets(param1:String, param2:Boolean = false) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = this.getMappingSetIDs();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                _loc_6 = this.getMappingSet(_loc_5);
                if (_loc_6 != null && _loc_6.name == param1)
                {
                    this.generalInputSetID = _loc_6.ID;
                    break;
                }
                _loc_6 = null;
                _loc_4++;
            }
            if (_loc_6 == null && param2)
            {
                _loc_7 = this.searchDefaultXmlFirstLevelElements("MappingSet");
                if (_loc_7.length() > 0)
                {
                    for each (_loc_8 in _loc_7)
                    {
                        
                        _loc_6 = MappingSet.s_Unmarshall(_loc_8, this.m_Version);
                        if (_loc_6.name == param1)
                        {
                            this.addMappingSet(_loc_6);
                            this.addActionBarSet(this.getDefaultActionBarSet(_loc_6.ID));
                            break;
                        }
                        _loc_6 = null;
                    }
                }
            }
            if (_loc_6 != null)
            {
                this.generalInputSetID = _loc_6.ID;
            }
            return;
        }// end function

        private function initialiseActionBarSet() : void
        {
            this.removeAllListItems(this.m_ActionBarSet, null);
            var _loc_1:* = new ActionBarSet(ActionBarSet.DEFAULT_SET);
            _loc_1.initialiseDefaultActionBars();
            this.addListItem(this.m_ActionBarSet, _loc_1, null);
            return;
        }// end function

        private function marshallChannelSet(param1:XML) : void
        {
            var _loc_2:* = this.m_ChannelSet.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.appendChild(this.m_ChannelSet[_loc_3].marshall());
                _loc_3++;
            }
            return;
        }// end function

        public function set statusWidgetVisible(param1:Boolean) : void
        {
            var _loc_2:* = this.statusWidgetVisible;
            if (_loc_2 !== param1)
            {
                this._2103194300statusWidgetVisible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusWidgetVisible", _loc_2, param1));
            }
            return;
        }// end function

        private function initialiseBuddySet() : void
        {
            this.removeAllListItems(this.m_BuddySet, null);
            this.addListItem(this.m_BuddySet, new BuddySet(BuddySet.DEFAULT_SET), null);
            return;
        }// end function

        public function get rendererScaleMap() : Boolean
        {
            return this.m_RendererScaleMap;
        }// end function

        private function removeListItem(param1, param2:int, param3:String)
        {
            var _loc_6:* = null;
            if (param1 == null)
            {
                return null;
            }
            var _loc_4:* = null;
            var _loc_5:* = param1.length - 1;
            while (_loc_5 >= 0)
            {
                
                if (param1[_loc_5].ID == param2)
                {
                    _loc_4 = param1.splice(_loc_5, 1)[0];
                    break;
                }
                _loc_5 = _loc_5 - 1;
            }
            if (_loc_4 is IEventDispatcher)
            {
                IEventDispatcher(_loc_4).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onListItemEvent);
                IEventDispatcher(_loc_4).removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onListItemEvent);
            }
            if (_loc_4 != null && param3 != null)
            {
                _loc_6 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_6.kind = PropertyChangeEventKind.UPDATE;
                _loc_6.property = param3;
                dispatchEvent(_loc_6);
            }
            return _loc_4;
        }// end function

        public function get marketBrowserLevel() : Boolean
        {
            return this.m_MarketBrowserLevel;
        }// end function

        private function set _737429024statusCreatureStyle(param1:int) : void
        {
            if (param1 == RendererImpl.STATUS_STYLE_CLASSIC || param1 == RendererImpl.STATUS_STYLE_OFF)
            {
                this.m_StatusCreatureStyle = param1;
            }
            else
            {
                this.m_StatusCreatureStyle = param1;
                throw new ArgumentError("OptionsStorage.set rendererCreatureStyle: Invalid style.");
            }
            return;
        }// end function

        public function set combatSecureMode(param1:int) : void
        {
            var _loc_2:* = this.combatSecureMode;
            if (_loc_2 !== param1)
            {
                this._512938034combatSecureMode = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "combatSecureMode", _loc_2, param1));
            }
            return;
        }// end function

        private function marshallNameFilterSet(param1:XML) : void
        {
            var _loc_2:* = this.m_NameFilterSet.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.appendChild(this.m_NameFilterSet[_loc_3].marshall());
                _loc_3++;
            }
            return;
        }// end function

        private function initialiseSideBarSet() : void
        {
            this.removeAllListItems(this.m_SideBarSet, null);
            var _loc_1:* = new SideBarSet(SideBarSet.DEFAULT_SET);
            _loc_1.initialiseDefaultWidgets();
            this.addListItem(this.m_SideBarSet, _loc_1, null);
            return;
        }// end function

        public function get marketBrowserLayout() : int
        {
            return this.m_MarketBrowserLayout;
        }// end function

        private function set _273891688marketBrowserProfession(param1:Boolean) : void
        {
            this.m_MarketBrowserProfession = param1;
            return;
        }// end function

        private function set _259410793generalActionBarsLock(param1:Boolean) : void
        {
            this.m_GeneralActionBarsLock = param1;
            return;
        }// end function

        private function set _498046769rendererHighlight(param1:Number) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > 1)
            {
                param1 = 1;
            }
            this.m_RendererHighlight = param1;
            return;
        }// end function

        private function set _251860638statusPlayerName(param1:Boolean) : void
        {
            this.m_StatusPlayerName = param1;
            return;
        }// end function

        public function setKnownTutorialHint(param1:int, param2:Boolean) : Boolean
        {
            var _loc_5:* = null;
            if (!TutorialHint.checkHint(param1))
            {
                return false;
            }
            var _loc_3:* = this.getKnownTutorialHintIndex(param1);
            var _loc_4:* = false;
            if (_loc_3 > -1 && !param2)
            {
                this.m_KnownTutorialHint.splice(_loc_3, 1);
                _loc_4 = true;
            }
            if (_loc_3 < 0 && param2)
            {
                this.m_KnownTutorialHint.splice(-_loc_3 - 1, 0, param1);
                _loc_4 = true;
            }
            if (_loc_4)
            {
                _loc_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_5.property = "knownTutorialHint";
                _loc_5.kind = PropertyChangeEventKind.UPDATE;
                _loc_5.oldValue = _loc_3 > -1;
                _loc_5.newValue = param2;
                dispatchEvent(_loc_5);
            }
            return _loc_3 > -1;
        }// end function

        public function get statusPlayerHealth() : Boolean
        {
            return this.m_StatusPlayerHealth;
        }// end function

        private function set _1621507731rendererShowFrameRate(param1:Boolean) : void
        {
            this.m_RendererShowFrameRate = param1;
            return;
        }// end function

        public function set marketBrowserEditor(param1:int) : void
        {
            var _loc_2:* = this.marketBrowserEditor;
            if (_loc_2 !== param1)
            {
                this._1254385703marketBrowserEditor = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserEditor", _loc_2, param1));
            }
            return;
        }// end function

        public function getActionBarSet(param1:int) : ActionBarSet
        {
            return ActionBarSet(this.getListItem(this.m_ActionBarSet, param1));
        }// end function

        public function set statusPlayerFlags(param1:Boolean) : void
        {
            var _loc_2:* = this.statusPlayerFlags;
            if (_loc_2 !== param1)
            {
                this._789326636statusPlayerFlags = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusPlayerFlags", _loc_2, param1));
            }
            return;
        }// end function

        private function set _749696330statusCreatureFlags(param1:Boolean) : void
        {
            this.m_StatusCreatureFlags = param1;
            return;
        }// end function

        public function set marketSelectedType(param1) : void
        {
            var _loc_2:* = this.marketSelectedType;
            if (_loc_2 !== param1)
            {
                this._356294353marketSelectedType = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketSelectedType", _loc_2, param1));
            }
            return;
        }// end function

        public function getSideBarSetIDs() : Array
        {
            return this.getListIDs(this.m_SideBarSet);
        }// end function

        public function get rendererLightEnabled() : Boolean
        {
            return this.m_RendererLightEnabled;
        }// end function

        private function set _407350117opponentSort(param1:int) : void
        {
            this.m_OpponentSort = param1;
            return;
        }// end function

        private function removeAllListItems(param1, param2:String) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (param1 != null)
            {
                for each (_loc_3 in param1)
                {
                    
                    if (_loc_3 is IEventDispatcher)
                    {
                        IEventDispatcher(_loc_3).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onListItemEvent);
                        IEventDispatcher(_loc_3).removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onListItemEvent);
                    }
                }
                _loc_6.length = 0;
                if (param2 != null)
                {
                    _loc_4 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _loc_4.kind = PropertyChangeEventKind.UPDATE;
                    _loc_4.property = param2;
                    dispatchEvent(_loc_4);
                }
            }
            return;
        }// end function

        private function set _124099575marketBrowserName(param1:String) : void
        {
            this.m_MarketBrowserName = param1;
            return;
        }// end function

        private function set _614115751combatPVPMode(param1:uint) : void
        {
            if (param1 != COMBAT_PVP_MODE_DOVE && param1 != COMBAT_PVP_MODE_WHITE_HAND && param1 != COMBAT_PVP_MODE_YELLOW_HAND && param1 != COMBAT_PVP_MODE_RED_FIST)
            {
                throw new ArgumentError("OptionsStorage.set combatPVPMode: Invalid mode.");
            }
            this.m_CombatPVPMode = param1;
            return;
        }// end function

        public function set statusCreatureStyle(param1:int) : void
        {
            var _loc_2:* = this.statusCreatureStyle;
            if (_loc_2 !== param1)
            {
                this._737429024statusCreatureStyle = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statusCreatureStyle", _loc_2, param1));
            }
            return;
        }// end function

        private function set _2042619673npcTradeSellKeepEquipped(param1:Boolean) : void
        {
            this.m_NPCTradeSellKeepEquipped = param1;
            return;
        }// end function

        public function get combatSecureMode() : int
        {
            return this.m_CombatSecureMode;
        }// end function

        public function removeActionBarSet(param1:int) : ActionBarSet
        {
            return ActionBarSet(this.removeListItem(this.m_ActionBarSet, param1, "actionBarSet"));
        }// end function

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
            return;
        }// end function

        private function marshallNPCTrade(param1:XML) : void
        {
            param1.appendChild(new XML("<npctrade>\r\n                          " + ("<buyIgnoreCapacity>" + this.m_NPCTradeBuyIgnoreCapacity + "</buyIgnoreCapacity>") + "\r\n                          " + ("<buyWithBackpacks>" + this.m_NPCTradeBuyWithBackpacks + "</buyWithBackpacks>") + "\r\n                          " + ("<sellKeepEquipped>" + this.m_NPCTradeSellKeepEquipped + "</sellKeepEquipped>") + "\r\n                          " + ("<sort>" + this.m_NPCTradeSort + "</sort>") + "\r\n                          " + ("<layout>" + this.m_NPCTradeLayout + "</layout>") + "\r\n                        </npctrade>"));
            return;
        }// end function

        public function get statusCreatureStyle() : int
        {
            return this.m_StatusCreatureStyle;
        }// end function

        public function getNameFilterSet(param1:int) : NameFilterSet
        {
            return NameFilterSet(this.getListItem(this.m_NameFilterSet, param1));
        }// end function

        private function marshallMappingSet(param1:XML) : void
        {
            var _loc_2:* = this.m_MappingSet.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.appendChild(this.m_MappingSet[_loc_3].marshall());
                _loc_3++;
            }
            return;
        }// end function

        public function get generalUIGameWindowHeight() : Number
        {
            return this.m_GeneralUIGameWindowHeight;
        }// end function

        public function get marketBrowserEditor() : int
        {
            return this.m_MarketBrowserEditor;
        }// end function

        private function unmarshallMessageFilterSet(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = MessageFilterSet.s_Unmarshall(param1, param2);
            if (this.m_MessageFilterSet.length >= MessageFilterSet.NUM_SETS && this.getListItem(this.m_MessageFilterSet, _loc_4.ID) == null)
            {
                throw new Error("OptionsStorage.unmarshallMessageFilterSet: Too many sets.");
            }
            this.addListItem(this.m_MessageFilterSet, _loc_4, null);
            return;
        }// end function

        public function addChannelSet(param1:ChannelSet) : ChannelSet
        {
            return ChannelSet(this.addListItem(this.m_ChannelSet, param1, "channelSet"));
        }// end function

        private function unmarshallChannelSet(param1:XML, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = ChannelSet.s_Unmarshall(param1, param2);
            if (this.m_ChannelSet.length >= ChannelSet.NUM_SETS && this.getListItem(this.m_ChannelSet, _loc_4.ID) == null)
            {
                throw new Error("OptionsStorage.unmarshallChannelSet: Too many sets.");
            }
            this.addListItem(this.m_ChannelSet, _loc_4, null);
            return;
        }// end function

        public function get marketBrowserName() : String
        {
            return this.m_MarketBrowserName;
        }// end function

        public function getMappingSetIDs() : Array
        {
            return this.getListIDs(this.m_MappingSet);
        }// end function

        public function set marketBrowserName(param1:String) : void
        {
            var _loc_2:* = this.marketBrowserName;
            if (_loc_2 !== param1)
            {
                this._124099575marketBrowserName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketBrowserName", _loc_2, param1));
            }
            return;
        }// end function

        private function set _1091413675statusWidgetLocation(param1:int) : void
        {
            if (param1 == StatusWidget.LOCATION_TOP || param1 == StatusWidget.LOCATION_BOTTOM || param1 == StatusWidget.LOCATION_LEFT || param1 == StatusWidget.LOCATION_RIGHT)
            {
                this.m_StatusWidgetLocation = param1;
            }
            else
            {
                throw new ArgumentError("OptionsStorage.set statusWidgetLocation: Invalid location: " + param1);
            }
            return;
        }// end function

        private function removeStarterMappings() : void
        {
            this.m_MappingSet = this.m_MappingSet.filter(function (param1:MappingSet, param2:int, param3:Vector.<MappingSet>) : Boolean
            {
                return param1.name != "Knight" && param1.name != "Paladin" && param1.name != "Sorcerer" && param1.name != "Druid";
            }// end function
            );
            return;
        }// end function

    }
}

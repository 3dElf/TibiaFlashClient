package 
{
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.managers.*;
    import tibia.controls.*;

    public class _Tibia_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory
    {
        private var _preloadedRSLs:Dictionary;

        public function _Tibia_mx_managers_SystemManager()
        {
            FlexVersion.compatibilityVersionString = "3.0.0";
            return;
        }// end function

        override public function create(... args) : Object
        {
            if (args.length > 0 && !(args[0] is String))
            {
                return super.create.apply(this, args);
            }
            args = args.length == 0 ? ("Tibia") : (String(args[0]));
            var _loc_3:* = Class(getDefinitionByName(args));
            if (!_loc_3)
            {
                return null;
            }
            var _loc_4:* = new _loc_3;
            if (new _loc_3 is IFlexModule)
            {
                IFlexModule(_loc_4).moduleFactory = this;
            }
            return _loc_4;
        }// end function

        override public function allowInsecureDomain(... args) : void
        {
            args = null;
            Security.allowInsecureDomain(args);
            for (args in this._preloadedRSLs)
            {
                
                if (args.content && "allowInsecureDomainInRSL" in args.content)
                {
                    var _loc_5:* = args.content;
                    _loc_5["allowInsecureDomainInRSL"](args);
                }
            }
            return;
        }// end function

        override public function info() : Object
        {
            return {activate:"onActivation(event)", applicationComplete:"onApplicationComplete(event)", compiledLocales:["en_US"], compiledResourceBundleNames:["ActionBarWidget", "ActionButtonConfigurationWidget", "BattlelistWidget", "BodyContainerViewWidget", "BuddylistWidget", "BugReportWidget", "ChannelSelectionWidget", "CharacterProfileWidget", "CharacterSelectionWidget", "ChatStorage", "ChatWidget", "CombatControlWidget", "Communication", "Connection", "ContainerViewWidget", "DeathMessageWidget", "EditBuddyWidget", "EditListWidget", "EditMarkWidget", "EditTextWidget", "GeneralButtonsWidget", "Global", "ImbuingWidget", "IngameShopWidget", "InputHandler", "MarketWidget", "MessageMode", "MiniMapWidget", "NPCTradeWidget", "ObjectContextMenu", "OptionsConfigurationWidget", "PremiumWidget", "PreyWidget", "QuestLogWidget", "ReportWidget", "SafeTradeWidget", "SelectOutfitWidget", "SharedResources", "SideBarHeader", "SpellListWidget", "SplitStackWidget", "StaticAction", "StatusWidget", "Tibia", "TutorialHintWidget", "UnjustPointsWidget", "WorldMapStorage", "collections", "containers", "controls", "core", "effects", "formatters", "skins", "styles", "utils"], currentDomain:ApplicationDomain.currentDomain, deactivate:"onActivation(event)", layout:"absolute", mainClassName:"Tibia", mixins:["_Tibia_FlexInit", "_headerDateTextStyle", "_dataGridStylesStyle", "_ComboBoxStyle", "_FormHeadingStyle", "_errorTipStyle", "_activeTabStyleStyle", "_textAreaHScrollBarStyleStyle", "_DataGridItemRendererStyle", "_weekDayStyleStyle", "_RadioButtonStyle", "_windowStatusStyle", "_ButtonStyle", "_SWFLoaderStyle", "_ToolTipStyle", "_popUpMenuStyle", "_globalStyle", "_ApplicationControlBarStyle", "_ButtonBarStyle", "_DataGridStyle", "_ButtonBarButtonStyle", "_TabStyle", "_FormItemLabelStyle", "_HSliderStyle", "_dateFieldPopupStyle", "_TabBarStyle", "_ScrollBarStyle", "_todayStyleStyle", "_FormItemStyle", "_plainStyle", "_windowStylesStyle", "_CheckBoxStyle", "_TabNavigatorStyle", "_richTextEditorTextAreaStyleStyle", "_FormStyle", "_DragManagerStyle", "_TextInputStyle", "_swatchPanelTextFieldStyle", "_headerDragProxyStyleStyle", "_ControlBarStyle", "_HRuleStyle", "_activeButtonStyleStyle", "_ListBaseStyle", "_CursorManagerStyle", "_alertButtonStyleStyle", "_linkButtonStyleStyle", "_textAreaVScrollBarStyleStyle", "_MenuBarStyle", "_ContainerStyle", "_TreeStyle", "_DividedBoxStyle", "_opaquePanelStyle", "_ApplicationStyle", "_comboDropdownStyle", "_TileListStyle", "_MenuStyle", "_TextAreaStyle", "_TibiaWatcherSetupUtil"], preinitialize:"onPreinitialise(event)", preloader:CustomDownloadProgressBar};
        }// end function

        override public function get preloadedRSLs() : Dictionary
        {
            if (this._preloadedRSLs == null)
            {
                this._preloadedRSLs = new Dictionary(true);
            }
            return this._preloadedRSLs;
        }// end function

        override public function allowDomain(... args) : void
        {
            args = null;
            Security.allowDomain(args);
            for (args in this._preloadedRSLs)
            {
                
                if (args.content && "allowDomainInRSL" in args.content)
                {
                    var _loc_5:* = args.content;
                    _loc_5["allowDomainInRSL"](args);
                }
            }
            return;
        }// end function

    }
}

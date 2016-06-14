package 
{
    import Tibia.*;
    import __AS3__.vec.*;
    import build.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import loader.asset.*;
    import mx.binding.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import shared.controls.*;
    import shared.skins.*;
    import shared.utility.*;
    import tibia.actionbar.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.container.*;
    import tibia.controls.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.help.*;
    import tibia.ingameshop.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.magic.*;
    import tibia.minimap.*;
    import tibia.network.*;
    import tibia.options.*;
    import tibia.premium.*;
    import tibia.sessiondump.*;
    import tibia.sessiondump.controller.*;
    import tibia.sessiondump.hints.gameaction.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;
    import tibia.worldmap.*;

    public class Tibia extends Application implements IBindingClient, IGameClient
    {
        private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_640104851:Class;
        private var _embed_css_images_Slot_InventoryArmor_png_1976141778:Class;
        private var _embed_css_images_BG_BohemianTileable_Game_png_477087436:Class;
        private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1012163085:Class;
        private var _embed_css_images_Button_Maximize_idle_png_481005166:Class;
        protected var m_CurrentOptionsAsset:OptionsAsset = null;
        private var _embed_css_images_Icons_WidgetHeaders_VipList_png_375643883:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1095386428:Class;
        private var _embed_css_images_Scrollbar_Arrow_down_idle_png_368252608:Class;
        private var _embed_css_images_slot_Hotkey_png_884797115:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_401045620:Class;
        private var _embed_css_images_Slot_InventoryHead_protected_png_893284254:Class;
        private var _embed_css_images_Button_Standard_tileable_end_idle_png_1252448280:Class;
        private var _embed_css_images_Button_ChatTabNew_pressed_png_1719858715:Class;
        private var _embed_css_images_Button_Gold_tileable_end_pressed_png_1615409205:Class;
        private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1579884353:Class;
        private var _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292:Class;
        var _bindingsByDestination:Object;
        private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1924166356:Class;
        private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1723628123:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_851799561:Class;
        protected var m_ContainerStorage:ContainerStorage = null;
        protected var m_CurrentOptionsUploadErrorDelay:int = 0;
        private var _embed_css_images_Button_Standard_tileable_gold_over_png_130746045:Class;
        private var _1020379552m_UITibiaRootContainer:HBox;
        private var _embed_css_images_BG_Bars_fat_enpiece_png_430241160:Class;
        protected var m_IsActive:Boolean = false;
        private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883572083:Class;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_739130423:Class;
        private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1329550823:Class;
        private var _embed_css_images_slot_container_png_2109452872:Class;
        private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_2100731363:Class;
        private var _embed_css_images_Button_GetPremium_tileable_end_pressed_png_1620609808:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1541911384:Class;
        protected var m_Options:OptionsStorage = null;
        protected var m_CurrentOptionsLastUpload:int = -2.14748e+009;
        private var _embed_css_images_Button_Minimize_idle_png_1856333664:Class;
        private var _embed_css_images_BG_ChatTab_tileable_png_1624887026:Class;
        private var _embed_css_images_Button_Highlight_tileable_end_over_png_391435917:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1964355702:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_707321527:Class;
        private var _embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1772931177:Class;
        private var m_TutorialMode:Boolean = false;
        private var _embed_css_images_Icons_CombatControls_PvPOn_idle_png_252644152:Class;
        private var _embed_css_images_Slot_InventoryAmmo_protected_png_235989040:Class;
        private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_886932366:Class;
        private var _1174474338m_UIActionBarLeft:VActionBarWidget;
        private var _embed_css_images_Icons_WidgetMenu_GetPremium_active_png_94620137:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1553385195:Class;
        private var m_FailedConnectionRescheduler:FailedConnectionRescheduler;
        private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1345701772:Class;
        protected var m_CurrentOptionsDirty:Boolean = false;
        private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_512828469:Class;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979642586:Class;
        private var _embed_css_images_Scrollbar_Arrow_up_over_png_1067260293:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_36388793:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1962358646:Class;
        private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_221750764:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1471954475:Class;
        private var _embed_css_images_BarsHealth_fat_RedLow2_png_2111643698:Class;
        private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1424152862:Class;
        private var _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382:Class;
        private var _embed_css_images_BarsHealth_compact_GreenLow_png_1297750638:Class;
        private var _embed_css_images_BarsHealth_compact_RedFull_png_1716395667:Class;
        private var _embed_css_images_BarsHealth_fat_Mana_png_1996703790:Class;
        private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_915659237:Class;
        private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_436343953:Class;
        private var m_GameClientReady:Boolean = false;
        private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_823465367:Class;
        private var _embed_css_images_Button_Highlight_tileable_pressed_png_848137525:Class;
        private var _embed_css_images_slot_Hotkey_disabled_png_196057824:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785:Class;
        private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1061435765:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1921465284:Class;
        private var _embed_css_images_Icons_Inventory_Store_png_1554221163:Class;
        private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1598990274:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_814210095:Class;
        private var _embed_css_images_Slot_InventoryBackpack_png_1143422153:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Spells_png_583290679:Class;
        private var _embed_css_images_Button_Minimize_pressed_png_1954633012:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1415932517:Class;
        private var _embed_css_images_Widget_Footer_tileable_end02_png_765792891:Class;
        private var _embed_css_images_BG_BarsXP_default_tileable_png_1611106463:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1938199697:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_510613324:Class;
        private var _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688:Class;
        private var _embed_css_images_Button_Highlight_tileable_end_idle_png_141598323:Class;
        private var _embed_css_images_BG_Bars_compact_tileable_png_1510304069:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1849311559:Class;
        private var _embed_css_images_Icons_WidgetMenu_Skull_idle_png_1425419057:Class;
        var _bindingsBeginWithWord:Object;
        private var _embed_css_images_Slot_InventoryShield_png_608340556:Class;
        private var _embed_css_images_ChatWindow_Mover_png_1661714110:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_971915191:Class;
        private var _embed_css_images_BG_Stone2_Tileable_png_2077472744:Class;
        private var _embed_css_images_Slot_Hotkey_Cooldown_png_1214707955:Class;
        private var _1404294856m_UIGameWindow:GridContainer;
        private var _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823:Class;
        private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_966925036:Class;
        private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636131991:Class;
        private var _embed_css_images_Icons_Conditions_Logoutblock_png_821848109:Class;
        private var _embed_css_images_Icons_ProgressBars_Fishing_png_157830983:Class;
        protected var m_Connection:IServerConnection = null;
        private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_571868347:Class;
        private var _embed_css_images_Button_ChatTabIgnore_pressed_png_449883375:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_437906913:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1214578473:Class;
        private var _embed_css_images_BarsHealth_default_RedLow_png_1517088146:Class;
        private var _64278965m_UISideBarA:SideBarWidget;
        private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_167339657:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_1081889455:Class;
        private var _embed_css_images_Icons_Conditions_Drunk_png_23604170:Class;
        private var _embed_css_images_Border02_WidgetSidebar_png_524401277:Class;
        private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975:Class;
        private var _embed_css_images_Scrollbar_Arrow_up_idle_png_719956101:Class;
        protected var m_ConnectionDataPending:int = -1;
        private var _embed_css_images_Button_ChatTab_Close_idle_png_596973064:Class;
        private var _embed_css_images_Minimap_ZoomIn_idle_png_271390787:Class;
        private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_546707386:Class;
        private var _embed_css_images_BarsHealth_compact_Yellow_png_1621758843:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_535957073:Class;
        private var _embed_css_images_Minimap_ZoomOut_pressed_png_1302018254:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertMode_over_png_749704414:Class;
        private var _embed_css_images_Border02_corners_png_1814375145:Class;
        private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1675031287:Class;
        private var _embed_css_images_Button_GetPremium_tileable_pressed_png_68377076:Class;
        private var _embed_css_images_Icons_Conditions_Haste_png_380779077:Class;
        private var _embed_css_images_BarsXP_default__png_715141111:Class;
        private var _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932:Class;
        protected var m_WorldMapStorage:WorldMapStorage = null;
        private var _embed_css_images_BG_Bars_compact_enpiece_png_1794070574:Class;
        private var _embed_css_images_Scrollbar_Handler_png_150592189:Class;
        private var _embed_css_images_Icons_Conditions_Poisoned_png_1941243675:Class;
        private var _embed_css_images_Icons_Conditions_PZ_png_1992640810:Class;
        private var _embed_css_images_Border_Widget_png_668780695:Class;
        private var _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_411052018:Class;
        private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1886138848:Class;
        protected var m_SpellStorage:SpellStorage = null;
        private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1668393027:Class;
        private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153:Class;
        private var _1568861366m_UIOuterRootContainer:DividedBox;
        private var _embed_css_images_Bars_ProgressMarker_png_1430413740:Class;
        private var _embed_css_images_Icons_Conditions_Cursed_png_629458754:Class;
        private var _embed_css_images_Button_Minimize_over_png_2097489824:Class;
        protected var m_CharacterDeath:Boolean = false;
        private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_820025018:Class;
        private var _embed_css_images_Slot_InventoryRing_protected_png_817340434:Class;
        private var _embed_css_images_Inventory_png_553308346:Class;
        private var _embed_css_images_Scrollbar_tileable_png_1485067795:Class;
        private var _embed_css_images_Button_Standard_tileable_idle_png_81709028:Class;
        private var _embed_css_images_Button_ChatTab_Close_over_png_2020181768:Class;
        private var _embed_css_images_Slot_InventoryShield_protected_png_1679014625:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1091888606:Class;
        private var _embed_css_images_BarsHealth_fat_RedFull_png_1001083219:Class;
        private var _embed_css_images_Button_ChatTab_Close_pressed_png_1103699684:Class;
        private var _embed_css_images_Scrollbar_Arrow_down_over_png_1631401408:Class;
        private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_846497374:Class;
        protected var m_SecondaryTimestamp:int = 0;
        private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_1667993954:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1421479100:Class;
        private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1817970777:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Skull_png_318007965:Class;
        private var _embed_css_images_Arrow_WidgetToggle_over_png_68165687:Class;
        private var _embed_css_images_Slot_Statusicon_highlighted_png_1406275102:Class;
        private var _embed_css_images_Minimap_ZoomOut_over_png_112502810:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_660047056:Class;
        private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_461534559:Class;
        private var _embed_css_images_BarsHealth_default_RedLow2_png_1313758662:Class;
        private var _embed_css_images_ChatTab_tileable_idle_png_688152709:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_981288301:Class;
        protected var m_PremiumManager:PremiumManager = null;
        private var _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_2088825037:Class;
        private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1398862963:Class;
        private var _embed_css_images_Minimap_Center_active_png_1335260772:Class;
        private var _embed_css_images_Slot_InventoryWeapon_png_2107549357:Class;
        private var _embed_css_images_Icons_ProgressBars_FistFighting_png_946071051:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_887453159:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_17040615:Class;
        private var _embed_css_images_Arrow_ScrollTabs_over_png_1724638544:Class;
        private var _embed_css_images_BG_Combat_ExpertOff_png_1001256734:Class;
        private var _64278964m_UISideBarB:SideBarWidget;
        private var _embed_css_images_UnjustifiedPoints_png_1243898267:Class;
        private var _embed_css_images_Button_GetPremium_tileable_over_png_121930648:Class;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_622418263:Class;
        private var _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387:Class;
        private var _embed_css_images_Minimap_ZoomOut_idle_png_1686759142:Class;
        private var _embed_css_images_BarsHealth_fat_GreenFull_png_1004610075:Class;
        private var _embed_css_images_Icons_Conditions_Freezing_png_2037155332:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1068232037:Class;
        private var _embed_css_images_BarsHealth_default_GreenLow_png_1548787312:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1805314658:Class;
        private var _embed_css_images_Slot_InventoryHead_png_1095562647:Class;
        private var _embed_css_images_Button_ChatTabNew_idle_png_1801992145:Class;
        private var _embed_css_images_BG_Bars_default_tileable_png_411547495:Class;
        private var _embed_css_images_Button_ChatTabIgnore_idle_png_1042862317:Class;
        var _bindings:Array;
        private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1401422619:Class;
        private var _embed_css_images_Button_Highlight_tileable_over_png_345315681:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_over_png_594657599:Class;
        private var _embed_css_images_Icons_ProgressBars_Shielding_png_940600668:Class;
        private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115:Class;
        private var _embed_css_images_Border02_png_653295686:Class;
        private var _embed_css_images_Button_Gold_tileable_end_idle_png_1097174497:Class;
        private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_648576020:Class;
        private var _embed_css_images_Button_MaximizePremium_idle_png_1413812249:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767895794:Class;
        private var _embed_css_images_BarsXP_default_improved_png_944734739:Class;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_351247284:Class;
        private var _embed_css_images_Slot_InventoryLegs_png_1771204248:Class;
        private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_998762331:Class;
        private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1758613678:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_1237957567:Class;
        private var _embed_css_images_Slot_InventoryRing_png_670392057:Class;
        private var _embed_css_images_Minimap_Center_idle_png_2072960978:Class;
        private var _embed_css_images_Button_LockHotkeys_Locked_over_png_553743711:Class;
        private var _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030:Class;
        private var _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_398765199:Class;
        private var _embed_css_images_Icons_IngameShop_12x12_Yes_png_409063775:Class;
        private var _embed_css_images_Slot_InventoryBoots_protected_png_810833177:Class;
        private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_390746770:Class;
        private var _embed_css_images_Button_Gold_tileable_idle_png_579625621:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1260694341:Class;
        private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_1208800333:Class;
        private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_865218367:Class;
        private var _embed_css_images_slot_container_disabled_png_1480414781:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_818508452:Class;
        private var _2056921391m_UISideBarToggleLeft:ToggleBar;
        private var _embed_css_images_Button_Close_pressed_png_1029688314:Class;
        private var _embed_css_images_BarsHealth_default_RedFull_png_468004747:Class;
        private var _embed_css_images_BarsHealth_fat_GreenLow_png_560143288:Class;
        private var _embed_css_images_Widget_HeaderBG_png_532450703:Class;
        private var _embed_css_images_Slot_Statusicon_png_1343906902:Class;
        private var _embed_css_images_BarsHealth_compact_RedLow_png_695116672:Class;
        private var _embed_css_images_Button_Close_over_png_1224962954:Class;
        private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_124439502:Class;
        private var _embed_css_images_ChatTab_tileable_png_1415808930:Class;
        private var _embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1664555364:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_504631023:Class;
        private var _embed_css_images_slot_container_highlighted_png_1493388964:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_818989716:Class;
        protected var m_AssetProvider:IAssetProvider = null;
        private var _embed_css_images_Icons_Conditions_Electrified_png_1645251154:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_852280450:Class;
        private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673:Class;
        private var _embed_css_images_BarsHealth_compact_Mana_png_1911706548:Class;
        private var _embed_css_images_Slot_InventoryLegs_protected_png_720943931:Class;
        private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_331481802:Class;
        private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_883471643:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_667468207:Class;
        protected var m_DefaultOptionsAsset:OptionsAsset = null;
        private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1581698428:Class;
        private var _embed_css_images_Icons_CombatControls_StandOff_over_png_145107486:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_290537603:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_977404663:Class;
        private var _embed_css_images_Icons_Conditions_Hungry_png_220632303:Class;
        private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1478391534:Class;
        private var _embed_css_images_Icons_WidgetMenu_Skull_active_png_1940183455:Class;
        private var _embed_css_images_Icons_CombatControls_Mounted_over_png_323447629:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1864732663:Class;
        private var _embed_css_images_Button_ContainerUp_idle_png_346363474:Class;
        private var _embed_css_images_Button_GetPremium_tileable_end_over_png_1386203804:Class;
        private var m_ForceDisableGameWindowSizeCalc:Boolean = false;
        private var _64278963m_UISideBarC:SideBarWidget;
        private var _embed_css_images_Button_Gold_tileable_pressed_png_365071001:Class;
        private var _embed_css_images_Icons_Conditions_Dazzled_png_1739263772:Class;
        private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_924761898:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Trades_png_759837731:Class;
        private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_454831310:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_245174782:Class;
        private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_876439723:Class;
        private var _embed_css_images_BG_ChatTab_Tabdrop_png_472094208:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_2033096949:Class;
        private var _embed_css_images_Slot_InventoryWeapon_protected_png_1820724014:Class;
        private var _embed_css_images_BG_Widget_Menu_png_1047900232:Class;
        protected var m_CreatureStorage:CreatureStorage = null;
        private var _embed_css_images_slot_Hotkey_protected_png_872375520:Class;
        private var _embed_css_images_Button_Maximize_pressed_png_878790694:Class;
        private var _embed_css_images_Icons_CombatControls_PvPOff_active_png_192388584:Class;
        private var _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_759314308:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Combat_png_724053726:Class;
        private var _embed_css_images_Button_Gold_tileable_end_over_png_894104289:Class;
        private var _embed_css_images_Minimap_Center_over_png_472159534:Class;
        private var _1356021457m_UICenterColumn:CustomDividedBox;
        private var _embed_css_images_Button_ContainerUp_pressed_png_567833978:Class;
        private var _embed_css_images_Icons_WidgetMenu_Blessings_active_png_1822781778:Class;
        private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_941597865:Class;
        private var _embed_css_images_slot_Hotkey_highlighted_png_2001599143:Class;
        protected var m_UIEffectsManager:UIEffectsManager = null;
        private var _embed_css_images_Icons_Inventory_StoreInbox_png_1908239703:Class;
        private var _embed_css_images_Icons_Conditions_MagicShield_png_51896356:Class;
        protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
        private var _embed_css_images_Minimap_ZoomIn_pressed_png_1091121313:Class;
        private var _embed_css_images_Button_Standard_tileable_pressed_png_2061718888:Class;
        private var _embed_css_images_Button_Standard_tileable_end_pressed_png_365075596:Class;
        private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457:Class;
        private var _embed_css_images_Button_Gold_tileable_over_png_1989275541:Class;
        private var _embed_css_images_Button_Combat_Stop_idle_png_1424042235:Class;
        private var _embed_css_images_Button_Maximize_over_png_1318781074:Class;
        private var _embed_css_images_Icons_Conditions_Bleeding_png_719748952:Class;
        private var _228925540m_UIStatusWidget:StatusWidget;
        private var _embed_css_images_Slot_InventoryBoots_png_1925185108:Class;
        private var _967396880m_UIBottomContainer:HBox;
        private var _embed_css_images_Button_GetPremium_tileable_idle_png_1922106008:Class;
        private var _2043305115m_UIActionBarRight:VActionBarWidget;
        private var _embed_css_images_Button_ChatTabNew_over_png_540129489:Class;
        private var _embed_css_images_BuySellTab_idle_png_1611782140:Class;
        private var _embed_css_images_BarsHealth_default_Yellow_png_397166041:Class;
        private var _embed_css_images_Icons_Conditions_Burning_png_1686487037:Class;
        private var _embed_css_images_BarsHealth_fat_RedLow_png_767405462:Class;
        private var _embed_css_images_Slot_InventoryNecklace_png_1810394141:Class;
        protected var m_AppearanceStorage:AppearanceStorage = null;
        private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_2063060441:Class;
        private var _embed_css_images_Button_Combat_Stop_over_png_375093765:Class;
        private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908:Class;
        private var _embed_css_images_Slot_InventoryNecklace_protected_png_1321263128:Class;
        private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_784118109:Class;
        private var _embed_css_images_Slot_InventoryArmor_protected_png_793628133:Class;
        private var _embed_css_images_Border02_WidgetSidebar_slim_png_420836441:Class;
        private var _629924354m_UIActionBarBottom:HActionBarWidget;
        private var _embed_css_images_Button_Standard_tileable_over_png_268131044:Class;
        public var _Tibia_Array1:Array;
        public var _Tibia_Array2:Array;
        protected var m_ConnectionDataCurrent:int = -1;
        private var _embed_css_images_Icons_Conditions_Strenghtened_png_1096277941:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1808018121:Class;
        private var _embed_css_images_Button_Close_disabled_png_1265071570:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1525887613:Class;
        private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_155670682:Class;
        private var _embed_css_images_BarsHealth_compact_GreenFull_png_220598049:Class;
        private var _embed_css_images_Button_Highlight_tileable_end_pressed_png_401542369:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939:Class;
        private var _embed_css_images_BG_Bars_default_enpiece_png_195008000:Class;
        private var _embed_css_images_Button_ChatTabIgnore_over_png_757185043:Class;
        private var _embed_css_images_Button_Standard_tileable_disabled_png_981449860:Class;
        private var _embed_css_images_BarsHealth_default_Mana_png_1612234378:Class;
        private var _embed_css_images_Button_MaximizePremium_over_png_200837401:Class;
        private var _748017946m_UIInputHandler:InputHandler;
        private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1502561270:Class;
        private var _embed_css_images_Icons_Conditions_PZlock_png_1628388119:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1582640445:Class;
        private var _1423351586m_UIActionBarTop:HActionBarWidget;
        private var _embed_css_images_BG_Bars_fat_tileable_png_2059592705:Class;
        private var _64278962m_UISideBarD:SideBarWidget;
        private var _embed_css_images_BG_BohemianTileable_png_1633084633:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_322604605:Class;
        private var _embed_css_images_BarsHealth_fat_Yellow_png_1059668033:Class;
        private var _embed_css_images_Border_Widget_corner_png_764128473:Class;
        private var _embed_css_images_Icons_WidgetHeaders_GetPremium_png_582604369:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_877580159:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_248709373:Class;
        private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1357302191:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_542673852:Class;
        private var _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_72820468:Class;
        protected var m_TutorialData:Object;
        private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_743255753:Class;
        protected var m_CurrentOptionsUploading:Boolean = false;
        private var _embed_css_images_Icons_Conditions_Slowed_png_613969280:Class;
        private var _embed_css_images_Icons_CombatControls_PvPOn_active_png_1071084502:Class;
        private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_739972599:Class;
        private var _embed_css_images_Button_Close_idle_png_880644746:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1842737870:Class;
        private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1464650688:Class;
        protected var m_ChatStorage:ChatStorage = null;
        private var _embed_css_images_BarsHealth_compact_RedLow2_png_660179048:Class;
        protected var m_Player:Player = null;
        protected var m_SessionKey:String = null;
        private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1900393862:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_625811990:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1632903030:Class;
        private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1186738992:Class;
        private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_2110866166:Class;
        private var _embed_css_images_Icons_IngameShop_12x12_No_png_754863577:Class;
        private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
        private var _665607314m_UISideBarToggleRight:ToggleBar;
        protected var m_SeconaryTimer:Timer = null;
        private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_905733223:Class;
        private var _embed_css_images_Icons_Conditions_Drowning_png_265936470:Class;
        private var _embed_css_images_Icons_CombatControls_PvPOff_idle_png_1711575894:Class;
        private var _embed_css_images_Button_ContainerUp_over_png_941742:Class;
        private var _embed_css_images_Minimap_png_3417015:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1835625099:Class;
        protected var m_Communication:Communication = null;
        private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1998398050:Class;
        private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1682326431:Class;
        protected var m_MiniMapStorage:MiniMapStorage = null;
        private var _embed_css_images_Slot_InventoryBackpack_protected_png_336111998:Class;
        private var _embed_css_images_Widget_Footer_tileable_png_2100911011:Class;
        private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_887674463:Class;
        private var _embed_css_images_BG_Combat_ExpertOn_png_1586084142:Class;
        private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1825691630:Class;
        private var _embed_css_images_Button_GetPremium_tileable_end_idle_png_1719225244:Class;
        private var _embed_css_images_Button_Combat_Stop_pressed_png_1196904143:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_898351276:Class;
        private var _883427326m_UIChatWidget:ChatWidget;
        private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_661855834:Class;
        var _watchers:Array;
        private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1612481051:Class;
        private var _embed_css_images_Widget_Footer_tileable_end01_png_772758022:Class;
        private var _embed_css_images_Slot_InventoryAmmo_png_1347869915:Class;
        private var m_GameActionFactory:GameActionFactory = null;
        protected var m_ChannelsPending:Vector.<int> = null;
        private var m_ConnectionLostDialog:ConnectionLostWidget;
        private var _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_382995454:Class;
        private var _embed_css_images_BuySellTab_active_png_860073354:Class;
        private var _embed_css_images_Minimap_ZoomIn_over_png_1551341379:Class;
        private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_126080788:Class;
        private var _embed_css_images_Button_Standard_tileable_end_over_png_1241269528:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_152924109:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_704659135:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415:Class;
        private var _embed_css_images_BarsHealth_default_GreenFull_png_734293341:Class;
        private var _embed_css_images_Button_Highlight_tileable_idle_png_1625405537:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1930213085:Class;
        private var _embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_799933556:Class;
        private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352:Class;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_536182326:Class;
        static const CONNECTION_STATE_GAME:int = 4;
        private static const SHAREDOBJECT_NAME:String = "options";
        static const CONNECTION_STATE_PENDING:int = 3;
        public static const BUGGY_FLASH_PLAYER_VERSION:String = "21,0,0,182";
        public static const PROTOCOL_VERSION:int = 1095;
        public static var s_FrameTibiaTimestamp:Number = 0;
        public static var s_FrameRealTimestamp:Number = 0;
        static const ERR_INVALID_SIZE:int = 1;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        public static const MAX_SESSION_KEY_LENGTH:int = 30;
        public static const CLIENT_TYPE:uint = 3;
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        static const PACKETLENGTH_SIZE:int = 2;
        private static var s_LastTibiaFactorChangeRealTimestamp:int = 0;
        static const CHECKSUM_POS:int = 2;
        public static const CLIENT_VERSION:uint = 2265;
        public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
        static const PAYLOADLENGTH_POS:int = 6;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        private static const OPTIONS_SAVE_INTERVAL:int = 1.8e+006;
        public static const PREVIEW_STATE_REGULAR:uint = 0;
        static const ERR_INVALID_CHECKSUM:int = 2;
        static const HEADER_SIZE:int = 6;
        static const ERR_INTERNAL:int = 0;
        static const CHECKSUM_SIZE:int = 4;
        static const PAYLOADDATA_POSITION:int = 8;
        static const HEADER_POS:int = 0;
        static const ERR_INVALID_MESSAGE:int = 3;
        public static var s_TibiaLoginTimestamp:Number = 0;
        private static const BUNDLE:String = "Tibia";
        public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
        static const ERR_INVALID_STATE:int = 4;
        static const PAYLOADLENGTH_SIZE:int = 2;
        private static var s_InternalTibiaTimerFactor:Number = 1;
        public static const CLIENT_PREVIEW_STATE:uint = 0;
        static var _Tibia_StylesInit_done:Boolean = false;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
        private static var s_LastTibiaTimestamp:int = 0;
        static const PACKETLENGTH_POS:int = 0;
        static const PAYLOAD_POS:int = 6;
        static const ERR_CONNECTION_LOST:int = 6;

        public function Tibia()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Application, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:DividedBox, id:"m_UIOuterRootContainer", propertiesFactory:function () : Object
                {
                    return {percentWidth:100, percentHeight:100, doubleClickEnabled:true, liveDragging:true, resizeToContent:true, styleName:"invisibleDivider", childDescriptors:[new UIComponentDescriptor({type:HBox, id:"m_UITibiaRootContainer", propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, percentHeight:100, minHeight:450, styleName:"rootContainer", childDescriptors:[new UIComponentDescriptor({type:SideBarWidget, id:"m_UISideBarA", propertiesFactory:function () : Object
                        {
                            return {percentHeight:100, styleWithBorder:"sideBarLeftWithBorder"};
                        }// end function
                        }), new UIComponentDescriptor({type:SideBarWidget, id:"m_UISideBarB", propertiesFactory:function () : Object
                        {
                            return {percentHeight:100};
                        }// end function
                        }), new UIComponentDescriptor({type:ToggleBar, id:"m_UISideBarToggleLeft", propertiesFactory:function () : Object
                        {
                            return {percentHeight:100, styleName:"sideBarToggleLeft", location:_Tibia_Array1_i()};
                        }// end function
                        }), new UIComponentDescriptor({type:CustomDividedBox, id:"m_UICenterColumn", events:{dividerRelease:"__m_UICenterColumn_dividerRelease"}, propertiesFactory:function () : Object
                        {
                            return {percentWidth:100, percentHeight:100, doubleClickEnabled:true, liveDragging:true, resizeToContent:true, styleName:"rootContainer", childDescriptors:[new UIComponentDescriptor({type:GridContainer, id:"m_UIGameWindow", events:{resize:"__m_UIGameWindow_resize"}, propertiesFactory:function () : Object
                            {
                                return {percentWidth:100, percentHeight:100, center:_Tibia_GameWindowContainer1_i(), top:_Tibia_StatusWidget1_i()};
                            }// end function
                            }), new UIComponentDescriptor({type:ChatWidget, id:"m_UIChatWidget", propertiesFactory:function () : Object
                            {
                                return {percentWidth:100, percentHeight:0};
                            }// end function
                            })]};
                        }// end function
                        }), new UIComponentDescriptor({type:ToggleBar, id:"m_UISideBarToggleRight", propertiesFactory:function () : Object
                        {
                            return {percentHeight:100, styleName:"sideBarToggleRight", location:_Tibia_Array2_i()};
                        }// end function
                        }), new UIComponentDescriptor({type:SideBarWidget, id:"m_UISideBarC", propertiesFactory:function () : Object
                        {
                            return {percentHeight:100};
                        }// end function
                        }), new UIComponentDescriptor({type:SideBarWidget, id:"m_UISideBarD", propertiesFactory:function () : Object
                        {
                            return {percentHeight:100, styleWithBorder:"sideBarRightWithBorder"};
                        }// end function
                        })]};
                    }// end function
                    }), new UIComponentDescriptor({type:HBox, id:"m_UIBottomContainer", propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, height:0};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:InputHandler, id:"m_UIInputHandler", propertiesFactory:function () : Object
                {
                    return {width:0, height:0, x:-10, y:-10};
                }// end function
                })]};
            }// end function
            });
            this.m_ConnectionLostDialog = new ConnectionLostWidget();
            this.m_TutorialData = new Object();
            this.m_FailedConnectionRescheduler = new FailedConnectionRescheduler();
            this._embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_382995454 = Tibia__embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_382995454;
            this._embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_799933556 = Tibia__embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_799933556;
            this._embed_css_images_Arrow_HotkeyToggle_BG_png_624147030 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
            this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_331481802 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_331481802;
            this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_536182326 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_536182326;
            this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1598990274 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1598990274;
            this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785;
            this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415;
            this._embed_css_images_Arrow_ScrollHotkeys_over_png_594657599 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_594657599;
            this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939;
            this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115;
            this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1012163085 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1012163085;
            this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1817970777 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1817970777;
            this._embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
            this._embed_css_images_Arrow_ScrollTabs_idle_png_2072068688 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
            this._embed_css_images_Arrow_ScrollTabs_over_png_1724638544 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
            this._embed_css_images_Arrow_ScrollTabs_pressed_png_233294932 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
            this._embed_css_images_Arrow_WidgetToggle_BG_png_1707327292 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
            this._embed_css_images_Arrow_WidgetToggle_idle_png_1489600823 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
            this._embed_css_images_Arrow_WidgetToggle_over_png_68165687 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_68165687;
            this._embed_css_images_Arrow_WidgetToggle_pressed_png_603472387 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
            this._embed_css_images_BG_BarsXP_default_endpiece_png_1606415382 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
            this._embed_css_images_BG_BarsXP_default_tileable_png_1611106463 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
            this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673;
            this._embed_css_images_BG_Bars_compact_enpiece_png_1794070574 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1794070574;
            this._embed_css_images_BG_Bars_compact_tileable_png_1510304069 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1510304069;
            this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
            this._embed_css_images_BG_Bars_default_enpiece_png_195008000 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_195008000;
            this._embed_css_images_BG_Bars_default_tileable_png_411547495 = Tibia__embed_css_images_BG_Bars_default_tileable_png_411547495;
            this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153;
            this._embed_css_images_BG_Bars_fat_enpiece_png_430241160 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_430241160;
            this._embed_css_images_BG_Bars_fat_tileable_png_2059592705 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_2059592705;
            this._embed_css_images_BG_BohemianTileable_ChatConsole_png_2063060441 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_2063060441;
            this._embed_css_images_BG_BohemianTileable_Game_png_477087436 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_477087436;
            this._embed_css_images_BG_BohemianTileable_png_1633084633 = Tibia__embed_css_images_BG_BohemianTileable_png_1633084633;
            this._embed_css_images_BG_ChatTab_Tabdrop_png_472094208 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_472094208;
            this._embed_css_images_BG_ChatTab_tileable_png_1624887026 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1624887026;
            this._embed_css_images_BG_Combat_ExpertOff_png_1001256734 = Tibia__embed_css_images_BG_Combat_ExpertOff_png_1001256734;
            this._embed_css_images_BG_Combat_ExpertOn_png_1586084142 = Tibia__embed_css_images_BG_Combat_ExpertOn_png_1586084142;
            this._embed_css_images_BG_Stone2_Tileable_png_2077472744 = Tibia__embed_css_images_BG_Stone2_Tileable_png_2077472744;
            this._embed_css_images_BG_Widget_Menu_png_1047900232 = Tibia__embed_css_images_BG_Widget_Menu_png_1047900232;
            this._embed_css_images_BarsHealth_compact_GreenFull_png_220598049 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_220598049;
            this._embed_css_images_BarsHealth_compact_GreenLow_png_1297750638 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_1297750638;
            this._embed_css_images_BarsHealth_compact_Mana_png_1911706548 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1911706548;
            this._embed_css_images_BarsHealth_compact_RedFull_png_1716395667 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1716395667;
            this._embed_css_images_BarsHealth_compact_RedLow2_png_660179048 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_660179048;
            this._embed_css_images_BarsHealth_compact_RedLow_png_695116672 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_695116672;
            this._embed_css_images_BarsHealth_compact_Yellow_png_1621758843 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1621758843;
            this._embed_css_images_BarsHealth_default_GreenFull_png_734293341 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_734293341;
            this._embed_css_images_BarsHealth_default_GreenLow_png_1548787312 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1548787312;
            this._embed_css_images_BarsHealth_default_Mana_png_1612234378 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1612234378;
            this._embed_css_images_BarsHealth_default_RedFull_png_468004747 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_468004747;
            this._embed_css_images_BarsHealth_default_RedLow2_png_1313758662 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1313758662;
            this._embed_css_images_BarsHealth_default_RedLow_png_1517088146 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1517088146;
            this._embed_css_images_BarsHealth_default_Yellow_png_397166041 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_397166041;
            this._embed_css_images_BarsHealth_fat_GreenFull_png_1004610075 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_1004610075;
            this._embed_css_images_BarsHealth_fat_GreenLow_png_560143288 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_560143288;
            this._embed_css_images_BarsHealth_fat_Mana_png_1996703790 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1996703790;
            this._embed_css_images_BarsHealth_fat_RedFull_png_1001083219 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1001083219;
            this._embed_css_images_BarsHealth_fat_RedLow2_png_2111643698 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_2111643698;
            this._embed_css_images_BarsHealth_fat_RedLow_png_767405462 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_767405462;
            this._embed_css_images_BarsHealth_fat_Yellow_png_1059668033 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1059668033;
            this._embed_css_images_BarsXP_default__png_715141111 = Tibia__embed_css_images_BarsXP_default__png_715141111;
            this._embed_css_images_BarsXP_default_improved_png_944734739 = Tibia__embed_css_images_BarsXP_default_improved_png_944734739;
            this._embed_css_images_Bars_ProgressMarker_png_1430413740 = Tibia__embed_css_images_Bars_ProgressMarker_png_1430413740;
            this._embed_css_images_Border02_WidgetSidebar_png_524401277 = Tibia__embed_css_images_Border02_WidgetSidebar_png_524401277;
            this._embed_css_images_Border02_WidgetSidebar_slim_png_420836441 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_420836441;
            this._embed_css_images_Border02_corners_png_1814375145 = Tibia__embed_css_images_Border02_corners_png_1814375145;
            this._embed_css_images_Border02_png_653295686 = Tibia__embed_css_images_Border02_png_653295686;
            this._embed_css_images_Border_Widget_corner_png_764128473 = Tibia__embed_css_images_Border_Widget_corner_png_764128473;
            this._embed_css_images_Border_Widget_png_668780695 = Tibia__embed_css_images_Border_Widget_png_668780695;
            this._embed_css_images_Button_ChatTabIgnore_idle_png_1042862317 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_1042862317;
            this._embed_css_images_Button_ChatTabIgnore_over_png_757185043 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_757185043;
            this._embed_css_images_Button_ChatTabIgnore_pressed_png_449883375 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_449883375;
            this._embed_css_images_Button_ChatTabNew_idle_png_1801992145 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1801992145;
            this._embed_css_images_Button_ChatTabNew_over_png_540129489 = Tibia__embed_css_images_Button_ChatTabNew_over_png_540129489;
            this._embed_css_images_Button_ChatTabNew_pressed_png_1719858715 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1719858715;
            this._embed_css_images_Button_ChatTab_Close_idle_png_596973064 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_596973064;
            this._embed_css_images_Button_ChatTab_Close_over_png_2020181768 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_2020181768;
            this._embed_css_images_Button_ChatTab_Close_pressed_png_1103699684 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1103699684;
            this._embed_css_images_Button_Close_disabled_png_1265071570 = Tibia__embed_css_images_Button_Close_disabled_png_1265071570;
            this._embed_css_images_Button_Close_idle_png_880644746 = Tibia__embed_css_images_Button_Close_idle_png_880644746;
            this._embed_css_images_Button_Close_over_png_1224962954 = Tibia__embed_css_images_Button_Close_over_png_1224962954;
            this._embed_css_images_Button_Close_pressed_png_1029688314 = Tibia__embed_css_images_Button_Close_pressed_png_1029688314;
            this._embed_css_images_Button_Combat_Stop_idle_png_1424042235 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1424042235;
            this._embed_css_images_Button_Combat_Stop_over_png_375093765 = Tibia__embed_css_images_Button_Combat_Stop_over_png_375093765;
            this._embed_css_images_Button_Combat_Stop_pressed_png_1196904143 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1196904143;
            this._embed_css_images_Button_ContainerUp_idle_png_346363474 = Tibia__embed_css_images_Button_ContainerUp_idle_png_346363474;
            this._embed_css_images_Button_ContainerUp_over_png_941742 = Tibia__embed_css_images_Button_ContainerUp_over_png_941742;
            this._embed_css_images_Button_ContainerUp_pressed_png_567833978 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_567833978;
            this._embed_css_images_Button_GetPremium_tileable_end_idle_png_1719225244 = Tibia__embed_css_images_Button_GetPremium_tileable_end_idle_png_1719225244;
            this._embed_css_images_Button_GetPremium_tileable_end_over_png_1386203804 = Tibia__embed_css_images_Button_GetPremium_tileable_end_over_png_1386203804;
            this._embed_css_images_Button_GetPremium_tileable_end_pressed_png_1620609808 = Tibia__embed_css_images_Button_GetPremium_tileable_end_pressed_png_1620609808;
            this._embed_css_images_Button_GetPremium_tileable_idle_png_1922106008 = Tibia__embed_css_images_Button_GetPremium_tileable_idle_png_1922106008;
            this._embed_css_images_Button_GetPremium_tileable_over_png_121930648 = Tibia__embed_css_images_Button_GetPremium_tileable_over_png_121930648;
            this._embed_css_images_Button_GetPremium_tileable_pressed_png_68377076 = Tibia__embed_css_images_Button_GetPremium_tileable_pressed_png_68377076;
            this._embed_css_images_Button_Gold_tileable_end_idle_png_1097174497 = Tibia__embed_css_images_Button_Gold_tileable_end_idle_png_1097174497;
            this._embed_css_images_Button_Gold_tileable_end_over_png_894104289 = Tibia__embed_css_images_Button_Gold_tileable_end_over_png_894104289;
            this._embed_css_images_Button_Gold_tileable_end_pressed_png_1615409205 = Tibia__embed_css_images_Button_Gold_tileable_end_pressed_png_1615409205;
            this._embed_css_images_Button_Gold_tileable_idle_png_579625621 = Tibia__embed_css_images_Button_Gold_tileable_idle_png_579625621;
            this._embed_css_images_Button_Gold_tileable_over_png_1989275541 = Tibia__embed_css_images_Button_Gold_tileable_over_png_1989275541;
            this._embed_css_images_Button_Gold_tileable_pressed_png_365071001 = Tibia__embed_css_images_Button_Gold_tileable_pressed_png_365071001;
            this._embed_css_images_Button_Highlight_tileable_end_idle_png_141598323 = Tibia__embed_css_images_Button_Highlight_tileable_end_idle_png_141598323;
            this._embed_css_images_Button_Highlight_tileable_end_over_png_391435917 = Tibia__embed_css_images_Button_Highlight_tileable_end_over_png_391435917;
            this._embed_css_images_Button_Highlight_tileable_end_pressed_png_401542369 = Tibia__embed_css_images_Button_Highlight_tileable_end_pressed_png_401542369;
            this._embed_css_images_Button_Highlight_tileable_idle_png_1625405537 = Tibia__embed_css_images_Button_Highlight_tileable_idle_png_1625405537;
            this._embed_css_images_Button_Highlight_tileable_over_png_345315681 = Tibia__embed_css_images_Button_Highlight_tileable_over_png_345315681;
            this._embed_css_images_Button_Highlight_tileable_pressed_png_848137525 = Tibia__embed_css_images_Button_Highlight_tileable_pressed_png_848137525;
            this._embed_css_images_Button_LockHotkeys_Locked_idle_png_887674463 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_887674463;
            this._embed_css_images_Button_LockHotkeys_Locked_over_png_553743711 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_553743711;
            this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_124439502 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_124439502;
            this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_454831310 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_454831310;
            this._embed_css_images_Button_MaximizePremium_idle_png_1413812249 = Tibia__embed_css_images_Button_MaximizePremium_idle_png_1413812249;
            this._embed_css_images_Button_MaximizePremium_over_png_200837401 = Tibia__embed_css_images_Button_MaximizePremium_over_png_200837401;
            this._embed_css_images_Button_Maximize_idle_png_481005166 = Tibia__embed_css_images_Button_Maximize_idle_png_481005166;
            this._embed_css_images_Button_Maximize_over_png_1318781074 = Tibia__embed_css_images_Button_Maximize_over_png_1318781074;
            this._embed_css_images_Button_Maximize_pressed_png_878790694 = Tibia__embed_css_images_Button_Maximize_pressed_png_878790694;
            this._embed_css_images_Button_Minimize_idle_png_1856333664 = Tibia__embed_css_images_Button_Minimize_idle_png_1856333664;
            this._embed_css_images_Button_Minimize_over_png_2097489824 = Tibia__embed_css_images_Button_Minimize_over_png_2097489824;
            this._embed_css_images_Button_Minimize_pressed_png_1954633012 = Tibia__embed_css_images_Button_Minimize_pressed_png_1954633012;
            this._embed_css_images_Button_Standard_tileable_disabled_png_981449860 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_981449860;
            this._embed_css_images_Button_Standard_tileable_end_disabled_png_1886138848 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1886138848;
            this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_461534559 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_461534559;
            this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_739972599 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_739972599;
            this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1675031287 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1675031287;
            this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_571868347 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_571868347;
            this._embed_css_images_Button_Standard_tileable_end_idle_png_1252448280 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1252448280;
            this._embed_css_images_Button_Standard_tileable_end_over_png_1241269528 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1241269528;
            this._embed_css_images_Button_Standard_tileable_end_pressed_png_365075596 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_365075596;
            this._embed_css_images_Button_Standard_tileable_gold_idle_png_1668393027 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1668393027;
            this._embed_css_images_Button_Standard_tileable_gold_over_png_130746045 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_130746045;
            this._embed_css_images_Button_Standard_tileable_gold_pressed_png_743255753 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_743255753;
            this._embed_css_images_Button_Standard_tileable_idle_png_81709028 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_81709028;
            this._embed_css_images_Button_Standard_tileable_over_png_268131044 = Tibia__embed_css_images_Button_Standard_tileable_over_png_268131044;
            this._embed_css_images_Button_Standard_tileable_pressed_png_2061718888 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_2061718888;
            this._embed_css_images_BuySellTab_active_png_860073354 = Tibia__embed_css_images_BuySellTab_active_png_860073354;
            this._embed_css_images_BuySellTab_idle_png_1611782140 = Tibia__embed_css_images_BuySellTab_idle_png_1611782140;
            this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
            this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
            this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
            this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
            this._embed_css_images_ChatTab_tileable_idle_png_688152709 = Tibia__embed_css_images_ChatTab_tileable_idle_png_688152709;
            this._embed_css_images_ChatTab_tileable_png_1415808930 = Tibia__embed_css_images_ChatTab_tileable_png_1415808930;
            this._embed_css_images_ChatWindow_Mover_png_1661714110 = Tibia__embed_css_images_ChatWindow_Mover_png_1661714110;
            this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_504631023 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_504631023;
            this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1842737870 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1842737870;
            this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1095386428 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1095386428;
            this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1921465284 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1921465284;
            this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_818989716 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_818989716;
            this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1808018121 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1808018121;
            this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1864732663 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1864732663;
            this._embed_css_images_Icons_BattleList_HideNPCs_over_png_977404663 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_977404663;
            this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1758613678 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1758613678;
            this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1553385195 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1553385195;
            this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_17040615 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_17040615;
            this._embed_css_images_Icons_BattleList_HidePlayers_over_png_887453159 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_887453159;
            this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_401045620 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_401045620;
            this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1938199697 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1938199697;
            this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_1237957567 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_1237957567;
            this._embed_css_images_Icons_BattleList_HideSkulled_over_png_704659135 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_704659135;
            this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_941597865 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_941597865;
            this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1900393862 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1900393862;
            this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_126080788 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_126080788;
            this._embed_css_images_Icons_BattleList_PartyMembers_over_png_221750764 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_221750764;
            this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636131991 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636131991;
            this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_823465367 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_823465367;
            this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1525887613 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1525887613;
            this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_290537603 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_290537603;
            this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1835625099 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1835625099;
            this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883572083 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883572083;
            this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_648576020 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_648576020;
            this._embed_css_images_Icons_CombatControls_DoveOff_over_png_966925036 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_966925036;
            this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_1998398050 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_1998398050;
            this._embed_css_images_Icons_CombatControls_DoveOn_over_png_1667993954 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_1667993954;
            this._embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_152924109 = Tibia__embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_152924109;
            this._embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_2088825037 = Tibia__embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_2088825037;
            this._embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_625811990 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_625811990;
            this._embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1091888606 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1091888606;
            this._embed_css_images_Icons_CombatControls_ExpertMode_over_png_749704414 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_over_png_749704414;
            this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_915659237 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_915659237;
            this._embed_css_images_Icons_CombatControls_MediumOff_over_png_883471643 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_883471643;
            this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1401422619 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1401422619;
            this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1612481051 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1612481051;
            this._embed_css_images_Icons_CombatControls_Mounted_idle_png_1208800333 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_1208800333;
            this._embed_css_images_Icons_CombatControls_Mounted_over_png_323447629 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_323447629;
            this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_322604605 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_322604605;
            this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1582640445 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1582640445;
            this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_36388793 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_36388793;
            this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1849311559 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1849311559;
            this._embed_css_images_Icons_CombatControls_PvPOff_active_png_192388584 = Tibia__embed_css_images_Icons_CombatControls_PvPOff_active_png_192388584;
            this._embed_css_images_Icons_CombatControls_PvPOff_idle_png_1711575894 = Tibia__embed_css_images_Icons_CombatControls_PvPOff_idle_png_1711575894;
            this._embed_css_images_Icons_CombatControls_PvPOn_active_png_1071084502 = Tibia__embed_css_images_Icons_CombatControls_PvPOn_active_png_1071084502;
            this._embed_css_images_Icons_CombatControls_PvPOn_idle_png_252644152 = Tibia__embed_css_images_Icons_CombatControls_PvPOn_idle_png_252644152;
            this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1415932517 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1415932517;
            this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_1068232037 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_1068232037;
            this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_667468207 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_667468207;
            this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_1081889455 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_1081889455;
            this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1424152862 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1424152862;
            this._embed_css_images_Icons_CombatControls_StandOff_over_png_145107486 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_145107486;
            this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1478391534 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1478391534;
            this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1825691630 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1825691630;
            this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_542673852 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_542673852;
            this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1421479100 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1421479100;
            this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1632903030 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1632903030;
            this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1964355702 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1964355702;
            this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_707321527 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_707321527;
            this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_971915191 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_971915191;
            this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_640104851 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_640104851;
            this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_981288301 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_981288301;
            this._embed_css_images_Icons_Conditions_Bleeding_png_719748952 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_719748952;
            this._embed_css_images_Icons_Conditions_Burning_png_1686487037 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1686487037;
            this._embed_css_images_Icons_Conditions_Cursed_png_629458754 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_629458754;
            this._embed_css_images_Icons_Conditions_Dazzled_png_1739263772 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1739263772;
            this._embed_css_images_Icons_Conditions_Drowning_png_265936470 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_265936470;
            this._embed_css_images_Icons_Conditions_Drunk_png_23604170 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_23604170;
            this._embed_css_images_Icons_Conditions_Electrified_png_1645251154 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1645251154;
            this._embed_css_images_Icons_Conditions_Freezing_png_2037155332 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_2037155332;
            this._embed_css_images_Icons_Conditions_Haste_png_380779077 = Tibia__embed_css_images_Icons_Conditions_Haste_png_380779077;
            this._embed_css_images_Icons_Conditions_Hungry_png_220632303 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_220632303;
            this._embed_css_images_Icons_Conditions_Logoutblock_png_821848109 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_821848109;
            this._embed_css_images_Icons_Conditions_MagicShield_png_51896356 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_51896356;
            this._embed_css_images_Icons_Conditions_PZ_png_1992640810 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1992640810;
            this._embed_css_images_Icons_Conditions_PZlock_png_1628388119 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1628388119;
            this._embed_css_images_Icons_Conditions_Poisoned_png_1941243675 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1941243675;
            this._embed_css_images_Icons_Conditions_Slowed_png_613969280 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_613969280;
            this._embed_css_images_Icons_Conditions_Strenghtened_png_1096277941 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1096277941;
            this._embed_css_images_Icons_IngameShop_12x12_No_png_754863577 = Tibia__embed_css_images_Icons_IngameShop_12x12_No_png_754863577;
            this._embed_css_images_Icons_IngameShop_12x12_Yes_png_409063775 = Tibia__embed_css_images_Icons_IngameShop_12x12_Yes_png_409063775;
            this._embed_css_images_Icons_Inventory_StoreInbox_png_1908239703 = Tibia__embed_css_images_Icons_Inventory_StoreInbox_png_1908239703;
            this._embed_css_images_Icons_Inventory_Store_png_1554221163 = Tibia__embed_css_images_Icons_Inventory_Store_png_1554221163;
            this._embed_css_images_Icons_ProgressBars_AxeFighting_png_865218367 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_865218367;
            this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1329550823 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1329550823;
            this._embed_css_images_Icons_ProgressBars_CompactStyle_png_2100731363 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_2100731363;
            this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1682326431 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1682326431;
            this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_846497374 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_846497374;
            this._embed_css_images_Icons_ProgressBars_Fishing_png_157830983 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_157830983;
            this._embed_css_images_Icons_ProgressBars_FistFighting_png_946071051 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_946071051;
            this._embed_css_images_Icons_ProgressBars_LargeStyle_png_876439723 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_876439723;
            this._embed_css_images_Icons_ProgressBars_MagicLevel_png_886932366 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_886932366;
            this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_905733223 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_905733223;
            this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1579884353 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1579884353;
            this._embed_css_images_Icons_ProgressBars_ProgressOn_png_512828469 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_512828469;
            this._embed_css_images_Icons_ProgressBars_Shielding_png_940600668 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_940600668;
            this._embed_css_images_Icons_ProgressBars_SwordFighting_png_924761898 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_924761898;
            this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1723628123 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1723628123;
            this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_998762331 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_998762331;
            this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1357302191 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1357302191;
            this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_820025018 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_820025018;
            this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_546707386 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_546707386;
            this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_2110866166 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_2110866166;
            this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1186738992 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1186738992;
            this._embed_css_images_Icons_WidgetHeaders_Combat_png_724053726 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_724053726;
            this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_155670682 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_155670682;
            this._embed_css_images_Icons_WidgetHeaders_GetPremium_png_582604369 = Tibia__embed_css_images_Icons_WidgetHeaders_GetPremium_png_582604369;
            this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1541911384 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1541911384;
            this._embed_css_images_Icons_WidgetHeaders_Minimap_png_2033096949 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_2033096949;
            this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1502561270 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1502561270;
            this._embed_css_images_Icons_WidgetHeaders_Skull_png_318007965 = Tibia__embed_css_images_Icons_WidgetHeaders_Skull_png_318007965;
            this._embed_css_images_Icons_WidgetHeaders_Spells_png_583290679 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_583290679;
            this._embed_css_images_Icons_WidgetHeaders_Trades_png_759837731 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_759837731;
            this._embed_css_images_Icons_WidgetHeaders_VipList_png_375643883 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_375643883;
            this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_248709373 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_248709373;
            this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_660047056 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_660047056;
            this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_535957073 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_535957073;
            this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767895794 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767895794;
            this._embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_398765199 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_398765199;
            this._embed_css_images_Icons_WidgetMenu_Blessings_active_png_1822781778 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_active_png_1822781778;
            this._embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1664555364 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1664555364;
            this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1061435765 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1061435765;
            this._embed_css_images_Icons_WidgetMenu_Combat_active_png_390746770 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_390746770;
            this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1398862963 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1398862963;
            this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1464650688 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1464650688;
            this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1214578473 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1214578473;
            this._embed_css_images_Icons_WidgetMenu_Containers_active_png_510613324 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_510613324;
            this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1260694341 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1260694341;
            this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1805314658 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1805314658;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_437906913 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_437906913;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_818508452 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_818508452;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1930213085 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1930213085;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1962358646 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1962358646;
            this._embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_72820468 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_72820468;
            this._embed_css_images_Icons_WidgetMenu_GetPremium_active_png_94620137 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_active_png_94620137;
            this._embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1772931177 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1772931177;
            this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_877580159 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_877580159;
            this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_245174782 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_245174782;
            this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_814210095 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_814210095;
            this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1924166356 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1924166356;
            this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_351247284 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_351247284;
            this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_739130423 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_739130423;
            this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979642586 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979642586;
            this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_622418263 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_622418263;
            this._embed_css_images_Icons_WidgetMenu_Skull_active_over_png_759314308 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_active_over_png_759314308;
            this._embed_css_images_Icons_WidgetMenu_Skull_active_png_1940183455 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_active_png_1940183455;
            this._embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_411052018 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_411052018;
            this._embed_css_images_Icons_WidgetMenu_Skull_idle_png_1425419057 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_idle_png_1425419057;
            this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_852280450 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_852280450;
            this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1471954475 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1471954475;
            this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_898351276 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_898351276;
            this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_851799561 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_851799561;
            this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_661855834 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_661855834;
            this._embed_css_images_Icons_WidgetMenu_VipList_active_png_784118109 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_784118109;
            this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1345701772 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1345701772;
            this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_436343953 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_436343953;
            this._embed_css_images_Inventory_png_553308346 = Tibia__embed_css_images_Inventory_png_553308346;
            this._embed_css_images_Minimap_Center_active_png_1335260772 = Tibia__embed_css_images_Minimap_Center_active_png_1335260772;
            this._embed_css_images_Minimap_Center_idle_png_2072960978 = Tibia__embed_css_images_Minimap_Center_idle_png_2072960978;
            this._embed_css_images_Minimap_Center_over_png_472159534 = Tibia__embed_css_images_Minimap_Center_over_png_472159534;
            this._embed_css_images_Minimap_ZoomIn_idle_png_271390787 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_271390787;
            this._embed_css_images_Minimap_ZoomIn_over_png_1551341379 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1551341379;
            this._embed_css_images_Minimap_ZoomIn_pressed_png_1091121313 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1091121313;
            this._embed_css_images_Minimap_ZoomOut_idle_png_1686759142 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1686759142;
            this._embed_css_images_Minimap_ZoomOut_over_png_112502810 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_112502810;
            this._embed_css_images_Minimap_ZoomOut_pressed_png_1302018254 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_1302018254;
            this._embed_css_images_Minimap_png_3417015 = Tibia__embed_css_images_Minimap_png_3417015;
            this._embed_css_images_Scrollbar_Arrow_down_idle_png_368252608 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_368252608;
            this._embed_css_images_Scrollbar_Arrow_down_over_png_1631401408 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1631401408;
            this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1581698428 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1581698428;
            this._embed_css_images_Scrollbar_Arrow_up_idle_png_719956101 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_719956101;
            this._embed_css_images_Scrollbar_Arrow_up_over_png_1067260293 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_1067260293;
            this._embed_css_images_Scrollbar_Arrow_up_pressed_png_167339657 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_167339657;
            this._embed_css_images_Scrollbar_Handler_png_150592189 = Tibia__embed_css_images_Scrollbar_Handler_png_150592189;
            this._embed_css_images_Scrollbar_tileable_png_1485067795 = Tibia__embed_css_images_Scrollbar_tileable_png_1485067795;
            this._embed_css_images_Slot_Hotkey_Cooldown_png_1214707955 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1214707955;
            this._embed_css_images_Slot_InventoryAmmo_png_1347869915 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1347869915;
            this._embed_css_images_Slot_InventoryAmmo_protected_png_235989040 = Tibia__embed_css_images_Slot_InventoryAmmo_protected_png_235989040;
            this._embed_css_images_Slot_InventoryArmor_png_1976141778 = Tibia__embed_css_images_Slot_InventoryArmor_png_1976141778;
            this._embed_css_images_Slot_InventoryArmor_protected_png_793628133 = Tibia__embed_css_images_Slot_InventoryArmor_protected_png_793628133;
            this._embed_css_images_Slot_InventoryBackpack_png_1143422153 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1143422153;
            this._embed_css_images_Slot_InventoryBackpack_protected_png_336111998 = Tibia__embed_css_images_Slot_InventoryBackpack_protected_png_336111998;
            this._embed_css_images_Slot_InventoryBoots_png_1925185108 = Tibia__embed_css_images_Slot_InventoryBoots_png_1925185108;
            this._embed_css_images_Slot_InventoryBoots_protected_png_810833177 = Tibia__embed_css_images_Slot_InventoryBoots_protected_png_810833177;
            this._embed_css_images_Slot_InventoryHead_png_1095562647 = Tibia__embed_css_images_Slot_InventoryHead_png_1095562647;
            this._embed_css_images_Slot_InventoryHead_protected_png_893284254 = Tibia__embed_css_images_Slot_InventoryHead_protected_png_893284254;
            this._embed_css_images_Slot_InventoryLegs_png_1771204248 = Tibia__embed_css_images_Slot_InventoryLegs_png_1771204248;
            this._embed_css_images_Slot_InventoryLegs_protected_png_720943931 = Tibia__embed_css_images_Slot_InventoryLegs_protected_png_720943931;
            this._embed_css_images_Slot_InventoryNecklace_png_1810394141 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1810394141;
            this._embed_css_images_Slot_InventoryNecklace_protected_png_1321263128 = Tibia__embed_css_images_Slot_InventoryNecklace_protected_png_1321263128;
            this._embed_css_images_Slot_InventoryRing_png_670392057 = Tibia__embed_css_images_Slot_InventoryRing_png_670392057;
            this._embed_css_images_Slot_InventoryRing_protected_png_817340434 = Tibia__embed_css_images_Slot_InventoryRing_protected_png_817340434;
            this._embed_css_images_Slot_InventoryShield_png_608340556 = Tibia__embed_css_images_Slot_InventoryShield_png_608340556;
            this._embed_css_images_Slot_InventoryShield_protected_png_1679014625 = Tibia__embed_css_images_Slot_InventoryShield_protected_png_1679014625;
            this._embed_css_images_Slot_InventoryWeapon_png_2107549357 = Tibia__embed_css_images_Slot_InventoryWeapon_png_2107549357;
            this._embed_css_images_Slot_InventoryWeapon_protected_png_1820724014 = Tibia__embed_css_images_Slot_InventoryWeapon_protected_png_1820724014;
            this._embed_css_images_Slot_Statusicon_highlighted_png_1406275102 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1406275102;
            this._embed_css_images_Slot_Statusicon_png_1343906902 = Tibia__embed_css_images_Slot_Statusicon_png_1343906902;
            this._embed_css_images_UnjustifiedPoints_png_1243898267 = Tibia__embed_css_images_UnjustifiedPoints_png_1243898267;
            this._embed_css_images_Widget_Footer_tileable_end01_png_772758022 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_772758022;
            this._embed_css_images_Widget_Footer_tileable_end02_png_765792891 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_765792891;
            this._embed_css_images_Widget_Footer_tileable_png_2100911011 = Tibia__embed_css_images_Widget_Footer_tileable_png_2100911011;
            this._embed_css_images_Widget_HeaderBG_png_532450703 = Tibia__embed_css_images_Widget_HeaderBG_png_532450703;
            this._embed_css_images_slot_Hotkey_disabled_png_196057824 = Tibia__embed_css_images_slot_Hotkey_disabled_png_196057824;
            this._embed_css_images_slot_Hotkey_highlighted_png_2001599143 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_2001599143;
            this._embed_css_images_slot_Hotkey_png_884797115 = Tibia__embed_css_images_slot_Hotkey_png_884797115;
            this._embed_css_images_slot_Hotkey_protected_png_872375520 = Tibia__embed_css_images_slot_Hotkey_protected_png_872375520;
            this._embed_css_images_slot_container_disabled_png_1480414781 = Tibia__embed_css_images_slot_container_disabled_png_1480414781;
            this._embed_css_images_slot_container_highlighted_png_1493388964 = Tibia__embed_css_images_slot_container_highlighted_png_1493388964;
            this._embed_css_images_slot_container_png_2109452872 = Tibia__embed_css_images_slot_container_png_2109452872;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            .mx_internal::_Tibia_StylesInit();
            this.layout = "absolute";
            this.addEventListener("activate", this.___Tibia_Application1_activate);
            this.addEventListener("applicationComplete", this.___Tibia_Application1_applicationComplete);
            this.addEventListener("deactivate", this.___Tibia_Application1_deactivate);
            this.addEventListener("preinitialize", this.___Tibia_Application1_preinitialize);
            return;
        }// end function

        public function set m_UIChatWidget(param1:ChatWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._883427326m_UIChatWidget;
            if (_loc_2 !== param1)
            {
                this._883427326m_UIChatWidget = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIChatWidget", _loc_2, param1));
            }
            return;
        }// end function

        public function get m_UIChatWidget() : ChatWidget
        {
            return this._883427326m_UIChatWidget;
        }// end function

        private function _Tibia_VActionBarWidget1_i() : VActionBarWidget
        {
            var _loc_1:* = new VActionBarWidget();
            this.m_UIActionBarLeft = _loc_1;
            _loc_1.styleName = "actionBarLeft";
            _loc_1.id = "m_UIActionBarLeft";
            BindingManager.executeBindings(this, "m_UIActionBarLeft", this.m_UIActionBarLeft);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function onCloseLogoutCharacter(event:CloseEvent) : void
        {
            if (event.detail == PopUpBase.BUTTON_YES)
            {
                this.m_ConnectionDataPending = -1;
                if (this.m_Communication != null)
                {
                    this.m_Communication.disconnect(false);
                }
            }
            return;
        }// end function

        protected function onActivation(event:Event) : void
        {
            if (event.type == Event.ACTIVATE)
            {
                this.isActive = true;
            }
            else
            {
                this.isActive = false;
                if (this.m_UIInputHandler != null)
                {
                    this.m_UIInputHandler.clearPressedKeys();
                }
            }
            return;
        }// end function

        public function setConnectionDataList(param1:Vector.<IConnectionData>, param2:uint) : void
        {
            if (param1 == null || param1.length < 1)
            {
                throw new ArgumentError("Tibia.setConnectionDataList: Invalid connection data list.");
            }
            if (param2 < 0 || param2 >= param1.length)
            {
                throw new ArgumentError("Tibia.setConnectionDataList: Invalid pending connection data.");
            }
            var _loc_3:* = this.m_ConnectionDataList;
            this.m_ConnectionDataList = param1;
            this.m_ConnectionDataCurrent = -1;
            this.m_ConnectionDataPending = param2;
            var _loc_4:* = s_GetConnection();
            if (s_GetConnection() != null && _loc_4.isConnected)
            {
                _loc_4.disconnect();
            }
            else if (IServerConnection is Sessiondump && this.m_GameClientReady)
            {
                this.loginCharacter();
            }
            return;
        }// end function

        public function setClientSize(param1:uint, param2:uint) : void
        {
            var _loc_3:* = Application.application.systemManager;
            if (_loc_3.hasOwnProperty("setActualSize"))
            {
                var _loc_4:* = _loc_3;
                _loc_4["setActualSize"](param1, param2);
            }
            return;
        }// end function

        private function isValidPreviewStateForClient(param1:uint) : Boolean
        {
            switch(param1)
            {
                case PREVIEW_STATE_REGULAR:
                {
                    return CLIENT_PREVIEW_STATE == PREVIEW_STATE_REGULAR || CLIENT_PREVIEW_STATE == PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE;
                }
                case PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:
                {
                    return CLIENT_PREVIEW_STATE == PREVIEW_STATE_REGULAR || CLIENT_PREVIEW_STATE == PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE;
                }
                case PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:
                {
                    return CLIENT_PREVIEW_STATE == PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE;
                }
                default:
                {
                    return false;
                    break;
                }
            }
        }// end function

        private function onConnectionConnecting(event:ConnectionEvent) : void
        {
            visible = false;
            if (event.data != null && this.m_Player.name == null)
            {
                this.m_Player.name = event.data as String;
            }
            this.m_ChannelsPending = this.m_ChatStorage.loadChannels();
            var _loc_2:* = new MessageWidget();
            _loc_2.buttonFlags = PopUpBase.BUTTON_CANCEL;
            _loc_2.keyboardFlags = PopUpBase.KEY_ESCAPE;
            _loc_2.message = resourceManager.getString(BUNDLE, "DLG_CONNECTING_TEXT", [event.message]);
            _loc_2.title = resourceManager.getString(BUNDLE, "DLG_CONNECTING_TITLE");
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onCloseLoginCharacter);
            _loc_2.show();
            return;
        }// end function

        public function saveLocalData() : void
        {
            if (!(this.m_Connection is Sessiondump))
            {
                this.m_MiniMapStorage.saveSectors(true);
            }
            return;
        }// end function

        private function onConnectionPending(event:ConnectionEvent) : void
        {
            var _loc_2:* = 0;
            if (this.m_ChannelsPending != null)
            {
                for each (_loc_2 in this.m_ChannelsPending)
                {
                    
                    if (_loc_2 == ChatStorage.PRIVATE_CHANNEL_ID)
                    {
                        this.m_Communication.sendCOPENCHANNEL();
                        continue;
                    }
                    this.m_Communication.sendCJOINCHANNEL(_loc_2);
                }
                this.m_ChannelsPending = null;
            }
            if (this.m_CharacterDeath)
            {
            }
            else
            {
                if (this.m_UIWorldMapWidget != null)
                {
                    this.m_UIWorldMapWidget.player = this.m_Player;
                }
                if (this.m_UIStatusWidget != null)
                {
                    this.m_UIStatusWidget.player = this.m_Player;
                }
                this.m_Communication.sendCENTERWORLD();
            }
            return;
        }// end function

        public function logoutCharacter() : void
        {
            if (this.m_Connection == null || !this.m_Connection.isConnected)
            {
                throw new Error("Tibia.logoutCharacter: Not connected.");
            }
            this.m_FailedConnectionRescheduler.reset();
            var _loc_1:* = new MessageWidget();
            _loc_1.buttonFlags = PopUpBase.BUTTON_YES | PopUpBase.BUTTON_NO;
            _loc_1.message = resourceManager.getString(BUNDLE, "DLG_LOGOUT_TEXT");
            _loc_1.title = resourceManager.getString(BUNDLE, "DLG_LOGOUT_TITLE");
            _loc_1.addEventListener(CloseEvent.CLOSE, this.onCloseLogoutCharacter);
            _loc_1.show();
            return;
        }// end function

        public function get isActive() : Boolean
        {
            return this.m_IsActive;
        }// end function

        public function get m_UIActionBarTop() : HActionBarWidget
        {
            return this._1423351586m_UIActionBarTop;
        }// end function

        protected function connect(param1:IConnectionData) : void
        {
            var _loc_3:* = null;
            if (param1 is AccountCharacter)
            {
                if (!(this.m_Connection is Connection))
                {
                    this.reset(true);
                    this.releaseConnection();
                }
                this.m_Connection = new Connection();
            }
            else if (param1 is SessiondumpConnectionData)
            {
                if (!(this.m_Connection is Sessiondump))
                {
                    this.reset(true);
                    this.releaseConnection();
                }
                _loc_3 = null;
                if (this.m_TutorialMode)
                {
                    _loc_3 = new SessiondumpControllerHints();
                }
                else
                {
                    _loc_3 = new SessiondumpControllerBase();
                }
                this.m_Connection = new Sessiondump(_loc_3);
            }
            this.m_Connection.addEventListener(ConnectionEvent.PENDING, this.onConnectionPending);
            this.m_Connection.addEventListener(ConnectionEvent.GAME, this.onConnectionGame);
            this.m_Connection.addEventListener(ConnectionEvent.CONNECTING, this.onConnectionConnecting);
            this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_LOST, this.onConnectionLost);
            this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_RECOVERED, this.onConnectionRecovered);
            this.m_Connection.addEventListener(ConnectionEvent.DEAD, this.onConnectionDeath);
            this.m_Connection.addEventListener(ConnectionEvent.DISCONNECTED, this.onConnectionDisconnected);
            this.m_Connection.addEventListener(ConnectionEvent.ERROR, this.onConnectionError);
            this.m_Connection.addEventListener(ConnectionEvent.LOGINADVICE, this.onConnectionLoginAdvice);
            this.m_Connection.addEventListener(ConnectionEvent.LOGINERROR, this.onConnectionLoginError);
            this.m_Connection.addEventListener(ConnectionEvent.LOGINWAIT, this.onConnectionLoginWait);
            var _loc_2:* = new ConnectionEvent(ConnectionEvent.CREATED);
            dispatchEvent(_loc_2);
            this.m_Connection.connect(param1);
            return;
        }// end function

        private function onUploadOptionsComplete(event:Event) : void
        {
            this.m_CurrentOptionsDirty = false;
            this.m_CurrentOptionsLastUpload = getTimer();
            this.m_CurrentOptionsUploading = false;
            this.m_CurrentOptionsUploadErrorDelay = 0;
            return;
        }// end function

        public function set m_UISideBarToggleRight(param1:ToggleBar) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._665607314m_UISideBarToggleRight;
            if (_loc_2 !== param1)
            {
                this._665607314m_UISideBarToggleRight = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UISideBarToggleRight", _loc_2, param1));
            }
            return;
        }// end function

        private function onCloseLoginWait(event:CloseEvent) : void
        {
            if (event.detail == TimeoutWaitWidget.TIMOUT_EXPIRED)
            {
                this.m_ConnectionDataPending = this.m_ConnectionDataCurrent;
            }
            else
            {
                this.m_ConnectionDataPending = -1;
                this.m_FailedConnectionRescheduler.reset();
            }
            if (this.m_Communication != null)
            {
                this.m_Communication.disconnect(false);
            }
            return;
        }// end function

        public function set m_UIWorldMapWidget(param1:WorldMapWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1314206572m_UIWorldMapWidget;
            if (_loc_2 !== param1)
            {
                this._1314206572m_UIWorldMapWidget = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIWorldMapWidget", _loc_2, param1));
            }
            return;
        }// end function

        private function _Tibia_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = BoxDirection.VERTICAL;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                m_UIOuterRootContainer.direction = param1;
                return;
            }// end function
            , "m_UIOuterRootContainer.direction");
            result[0] = binding;
            binding = new Binding(this, function () : int
            {
                return SideBarSet.LOCATION_A;
            }// end function
            , function (param1:int) : void
            {
                m_UISideBarA.location = param1;
                return;
            }// end function
            , "m_UISideBarA.location");
            result[1] = binding;
            binding = new Binding(this, function () : int
            {
                return SideBarSet.LOCATION_B;
            }// end function
            , function (param1:int) : void
            {
                m_UISideBarB.location = param1;
                return;
            }// end function
            , "m_UISideBarB.location");
            result[2] = binding;
            binding = new Binding(this, function ()
            {
                return SideBarSet.LOCATION_B;
            }// end function
            , function (param1) : void
            {
                _Tibia_Array1[0] = param1;
                return;
            }// end function
            , "_Tibia_Array1[0]");
            result[3] = binding;
            binding = new Binding(this, function ()
            {
                return SideBarSet.LOCATION_A;
            }// end function
            , function (param1) : void
            {
                _Tibia_Array1[1] = param1;
                return;
            }// end function
            , "_Tibia_Array1[1]");
            result[4] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = BoxDirection.VERTICAL;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                m_UICenterColumn.direction = param1;
                return;
            }// end function
            , "m_UICenterColumn.direction");
            result[5] = binding;
            binding = new Binding(this, function () : int
            {
                return ActionBarSet.LOCATION_TOP;
            }// end function
            , function (param1:int) : void
            {
                m_UIActionBarTop.location = param1;
                return;
            }// end function
            , "m_UIActionBarTop.location");
            result[6] = binding;
            binding = new Binding(this, function () : int
            {
                return ActionBarSet.LOCATION_BOTTOM;
            }// end function
            , function (param1:int) : void
            {
                m_UIActionBarBottom.location = param1;
                return;
            }// end function
            , "m_UIActionBarBottom.location");
            result[7] = binding;
            binding = new Binding(this, function () : int
            {
                return ActionBarSet.LOCATION_LEFT;
            }// end function
            , function (param1:int) : void
            {
                m_UIActionBarLeft.location = param1;
                return;
            }// end function
            , "m_UIActionBarLeft.location");
            result[8] = binding;
            binding = new Binding(this, function () : int
            {
                return ActionBarSet.LOCATION_RIGHT;
            }// end function
            , function (param1:int) : void
            {
                m_UIActionBarRight.location = param1;
                return;
            }// end function
            , "m_UIActionBarRight.location");
            result[9] = binding;
            binding = new Binding(this, function ()
            {
                return SideBarSet.LOCATION_C;
            }// end function
            , function (param1) : void
            {
                _Tibia_Array2[0] = param1;
                return;
            }// end function
            , "_Tibia_Array2[0]");
            result[10] = binding;
            binding = new Binding(this, function ()
            {
                return SideBarSet.LOCATION_D;
            }// end function
            , function (param1) : void
            {
                _Tibia_Array2[1] = param1;
                return;
            }// end function
            , "_Tibia_Array2[1]");
            result[11] = binding;
            binding = new Binding(this, function () : int
            {
                return SideBarSet.LOCATION_C;
            }// end function
            , function (param1:int) : void
            {
                m_UISideBarC.location = param1;
                return;
            }// end function
            , "m_UISideBarC.location");
            result[12] = binding;
            binding = new Binding(this, function () : int
            {
                return SideBarSet.LOCATION_D;
            }// end function
            , function (param1:int) : void
            {
                m_UISideBarD.location = param1;
                return;
            }// end function
            , "m_UISideBarD.location");
            result[13] = binding;
            return result;
        }// end function

        protected function onAppearancesLoadError(event:ErrorEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                if (this.m_AppearanceStorage != null)
                {
                    this.m_AppearanceStorage.removeEventListener(ErrorEvent.ERROR, this.onAppearancesLoadError);
                    this.m_AppearanceStorage.removeEventListener(Event.COMPLETE, this.onAppearancesLoadComplete);
                }
                _loc_2 = new GameEvent(GameEvent.ERROR, true, false);
                _loc_2.message = event.text;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function onCloseLoginCharacter(event:CloseEvent) : void
        {
            if (event.detail == PopUpBase.BUTTON_CANCEL)
            {
                this.m_ConnectionDataPending = -1;
                if (this.m_Communication != null)
                {
                    this.m_Communication.disconnect(false);
                }
            }
            return;
        }// end function

        protected function onAppearancesLoadComplete(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                if (this.m_AppearanceStorage != null)
                {
                    this.m_AppearanceStorage.removeEventListener(ErrorEvent.ERROR, this.onAppearancesLoadError);
                    this.m_AppearanceStorage.removeEventListener(Event.COMPLETE, this.onAppearancesLoadComplete);
                }
                this.loadOptions();
                this.loginCharacter();
                this.m_GameClientReady = true;
                _loc_2 = new GameEvent(GameEvent.READY, true, false);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function set isActive(param1:Boolean) : void
        {
            if (this.m_IsActive != param1)
            {
                this.m_IsActive = param1;
                if (this.m_IsActive == true)
                {
                    FocusNotifier.getInstance().hide();
                }
                else
                {
                    FocusNotifier.getInstance().show();
                }
            }
            return;
        }// end function

        public function get m_UITibiaRootContainer() : HBox
        {
            return this._1020379552m_UITibiaRootContainer;
        }// end function

        public function set m_UIActionBarTop(param1:HActionBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1423351586m_UIActionBarTop;
            if (_loc_2 !== param1)
            {
                this._1423351586m_UIActionBarTop = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIActionBarTop", _loc_2, param1));
            }
            return;
        }// end function

        public function loginCharacter() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            if (this.m_ConnectionDataList == null || this.m_ConnectionDataList.length < 1)
            {
                throw new ArgumentError("Tibia.loginCharacter: Invalid connection data list.");
            }
            if (this.m_ConnectionDataPending < 0 || this.m_ConnectionDataPending >= this.m_ConnectionDataList.length)
            {
                throw new ArgumentError("Tibia.loginCharacter: Invalid pending connection data.");
            }
            this.reset();
            this.m_ConnectionDataCurrent = this.m_ConnectionDataPending;
            this.m_ConnectionDataPending = -1;
            this.m_CharacterDeath = false;
            var _loc_1:* = null;
            _loc_1 = this.m_ConnectionDataList[this.m_ConnectionDataCurrent];
            if (_loc_1 is AccountCharacter)
            {
                _loc_2 = _loc_1 as AccountCharacter;
                if (_loc_2 == null)
                {
                    throw new Error("Tibia.loginCharacter: connection data must be account character.");
                }
                _loc_3 = !this.isValidPreviewStateForClient(_loc_2.worldPreviewState);
                if (_loc_3)
                {
                    this.reloadClient(_loc_2);
                    _loc_1 = null;
                }
                else
                {
                    _loc_1 = _loc_2;
                }
            }
            if (_loc_1 != null)
            {
                this.connect(_loc_1);
            }
            return;
        }// end function

        function _Tibia_StylesInit() : void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_Tibia_StylesInit_done)
            {
                return;
            }
            mx_internal::_Tibia_StylesInit_done = true;
            style = StyleManager.getStyleDeclaration(".sideBarLeftWithBorder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarLeftWithBorder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "right";
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420836441;
                this.paddingTop = 0;
                this.resizeCursorSkin = ResizeVerticalCursor;
                this.borderBackgroundAlpha = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderBackgroundColor = 0;
                this.verticalGap = 1;
                this.horizontalGap = 0;
                this.paddingLeft = 2;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("BattlelistWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("BattlelistWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.hidePlayerButtonStyle = "battlelistWidgetViewHidePlayer";
                this.hideNPCButtonStyle = "battlelistWidgetViewHideNPC";
                this.headerBoxStyle = "battlelistHeader";
                this.verticalGap = 0;
                this.paddingLeft = 0;
                this.listStyle = "battlelist";
                this.paddingRight = 0;
                this.hidePartyButtonStyle = "battlelistWidgetViewHideParty";
                this.hideNonSkulledButtonStyle = "battlelistWidgetViewHideNonSkulled";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_BattleList_png_1186738992;
                this.hideMonsterButtonStyle = "battlelistWidgetViewHideMonster";
                this.horizontalGap = 0;
                this.listBoxStyle = "battlelistContent";
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buyStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buyStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpLeftImage = _embed_css_images_Button_GetPremium_tileable_end_idle_png_1719225244;
                this.color = 16777215;
                this.defaultOverLeftImage = _embed_css_images_Button_GetPremium_tileable_end_over_png_1386203804;
                this.defaultOverCenterImage = _embed_css_images_Button_GetPremium_tileable_over_png_121930648;
                this.textRollOverColor = 16777215;
                this.defaultDownCenterImage = _embed_css_images_Button_GetPremium_tileable_pressed_png_68377076;
                this.defaultUpCenterImage = _embed_css_images_Button_GetPremium_tileable_idle_png_1922106008;
                this.disabledColor = 16777215;
                this.textSelectedColor = 16777215;
                this.defaultDownLeftImage = _embed_css_images_Button_GetPremium_tileable_end_pressed_png_1620609808;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotPremium");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotPremium", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "center";
                this.defaultUpMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1772931177;
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_72820468;
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_72820468;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_active_png_94620137;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetDefaultTab");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetDefaultTab", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.selectedDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
                this.selectedDownMask = "left center right";
                this.defaultOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
                this.selectedOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
                this.selectedOverMask = "left center right";
                this.defaultOverCenterImage = _embed_css_images_ChatTab_tileable_idle_png_688152709;
                this.selectedUpMask = "left center right";
                this.defaultUpCenterImage = _embed_css_images_ChatTab_tileable_idle_png_688152709;
                this.skin = BitmapButtonSkin;
                this.selectedOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
                this.selectedUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
                this.defaultOverMask = "left center right";
                this.defaultUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
                this.defaultOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
                this.selectedDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
                this.closeButtonStyle = "chatWidgetDefaultTabCloseButton";
                this.textAlign = "left";
                this.defaultTextColor = 13221291;
                this.highlightTextColor = 13120000;
                this.selectedTextColor = 15904590;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
                this.defaultUpMask = "left center right";
                this.paddingTop = 0;
                this.selectedUpCenterImage = _embed_css_images_ChatTab_tileable_png_1415808930;
                this.defaultDownMask = "left center right";
                this.selectedOverCenterImage = _embed_css_images_ChatTab_tileable_png_1415808930;
                this.selectedUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
                this.paddingLeft = 4;
                this.paddingRight = 4;
                this.closeButtonTop = 4;
                this.closeButtonRight = 4;
                this.defaultDownCenterImage = _embed_css_images_ChatTab_tileable_idle_png_688152709;
                this.defaultDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
                this.defaultDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
                this.selectedDownCenterImage = _embed_css_images_ChatTab_tileable_png_1415808930;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ToggleBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ToggleBar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_png_524401277;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SeparatorItem");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SeparatorItem", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.separatorAlpha = 1;
                this.separatorColor = 8089164;
                this.separatorWidth = 0.9;
                this.separatorHeight = 4;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarToggleRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarToggleRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left";
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "right";
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.selectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "right";
                this.defaultUpMask = "left";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "left";
                this.defaultDownMask = "left";
                this.defaultOverTopImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "left";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.selectedOverTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "left";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "right";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "right";
                this.selectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.toggleButtonStyle = "sideBarToggleRight";
                this.selectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.iconSelectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedUpBottomImage = "right";
                this.iconSelectedDownMask = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetScrollTop");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetScrollTop", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "top";
                this.defaultDownTopImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_594657599;
                this.defaultDisabledLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "top";
                this.defaultUpTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785;
                this.defaultUpMask = "top";
                this.paddingTop = 0;
                this.defaultDownMask = "top";
                this.defaultOverTopImage = "right";
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939;
                this.defaultDownLeftImage = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".optionsConfigurationWidgetRootContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".optionsConfigurationWidgetRootContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 2;
                this.borderColor = 8089164;
                this.backgroundColor = 2240055;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetRightTab");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetRightTab", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.selectedDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
                this.selectedDownMask = "left center right";
                this.defaultOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
                this.selectedOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
                this.selectedOverMask = "left center right";
                this.defaultOverCenterImage = _embed_css_images_ChatTab_tileable_idle_png_688152709;
                this.selectedUpMask = "left center right";
                this.defaultUpCenterImage = _embed_css_images_ChatTab_tileable_idle_png_688152709;
                this.skin = BitmapButtonSkin;
                this.selectedOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
                this.selectedUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1201288975;
                this.defaultOverMask = "left center right";
                this.defaultUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
                this.defaultOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
                this.selectedDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
                this.closeButtonStyle = "chatWidgetDefaultTabCloseButton";
                this.textAlign = "left";
                this.defaultTextColor = 13221291;
                this.highlightTextColor = 13120000;
                this.selectedTextColor = 15904590;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
                this.defaultUpMask = "left center right";
                this.paddingTop = 0;
                this.selectedUpCenterImage = _embed_css_images_ChatTab_tileable_png_1415808930;
                this.defaultDownMask = "left center right";
                this.selectedOverCenterImage = _embed_css_images_ChatTab_tileable_png_1415808930;
                this.selectedUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1662318034;
                this.paddingLeft = 4;
                this.paddingRight = 4;
                this.closeButtonTop = 4;
                this.closeButtonRight = 4;
                this.defaultDownCenterImage = _embed_css_images_ChatTab_tileable_idle_png_688152709;
                this.defaultDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1967849615;
                this.defaultDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_564861908;
                this.selectedDownCenterImage = _embed_css_images_ChatTab_tileable_png_1415808930;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CoinWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CoinWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.color = 16232264;
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".mouseControlOptionsList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".mouseControlOptionsList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.alternatingItemAlphas = [0.8, 0];
                this.horizontalGridLines = false;
                this.backgroundColor = "";
                this.horizontalGridLineColor = 8089164;
                this.rollOverColor = 2768716;
                this.iconColor = 13221291;
                this.verticalGridLines = true;
                this.textRollOverColor = 13221291;
                this.borderAlpha = 1;
                this.selectionColor = 658961;
                this.verticalGridLineColor = 8089164;
                this.backgroundAlpha = 0.8;
                this.disabledIconColor = 13221291;
                this.color = 13221291;
                this.alternatingItemColors = [1977654, 16711680];
                this.selectionDuration = 0;
                this.borderThickness = 1;
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buttonIngameShop");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buttonIngameShop", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.selectedUpLeftImage = _embed_css_images_Button_Highlight_tileable_end_idle_png_141598323;
                this.icon = _embed_css_images_Icons_Inventory_Store_png_1554221163;
                this.selectedUpCenterImage = _embed_css_images_Button_Highlight_tileable_idle_png_1625405537;
                this.selectedDownLeftImage = _embed_css_images_Button_Highlight_tileable_end_pressed_png_401542369;
                this.selectedOverCenterImage = _embed_css_images_Button_Highlight_tileable_over_png_345315681;
                this.selectedOverLeftImage = _embed_css_images_Button_Highlight_tileable_end_over_png_391435917;
                this.paddingLeft = 23;
                this.selectedDownCenterImage = _embed_css_images_Button_Highlight_tileable_pressed_png_848137525;
                this.paddingRight = 22;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("BodySlot");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("BodySlot", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 3;
                this.backgroundColor = 65280;
                this.backgroundOutAlpha = 1;
                this.backgroundImage = _embed_css_images_slot_Hotkey_png_884797115;
                this.backgroundOverAlpha = 1;
                this.emptyBackgroundOverAlpha = 1;
                this.backgroundAlpha = 1;
                this.paddingLeft = 3;
                this.paddingRight = 3;
                this.emptyBackgroundOutAlpha = 1;
                this.emptyBackgroundAlpha = 1;
                this.emptyBackgroundColor = 16711680;
                this.paddingBottom = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "right center";
                this.toggleButtonStyle = "actionBarWidgetToggleRight";
                this.scrollDownButtonStyle = "actionBarWidgetScrollTop";
                this.scrollUpButtonStyle = "actionBarWidgetScrollBottom";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotBlessing");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotBlessing", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "center";
                this.defaultUpMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1664555364;
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_398765199;
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_398765199;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_active_png_1822781778;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonDove");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonDove", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1998398050;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_DoveOn_over_png_1667993954;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_DoveOff_over_png_966925036;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_DoveOff_idle_png_648576020;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_DoveOff_over_png_966925036;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_DoveOn_over_png_1667993954;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("MouseControlOptions");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("MouseControlOptions", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.mouseControlOptionsListStyle = "mouseControlOptionsList";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcSummaryBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcSummaryBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatMana");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatMana", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_fat_tileable_png_2059592705;
                this.rightOrnamentMask = "none";
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.barDefault = _embed_css_images_BarsHealth_fat_Mana_png_1996703790;
                this.leftOrnamentMask = "left";
                this.backgroundRightImage = _embed_css_images_BG_Bars_fat_enpiece_png_430241160;
                this.leftOrnamentLeftImage = "right";
                this.barImages = "barDefault";
                this.backgroundMask = "center";
                this.paddingLeft = 3;
                this.paddingRight = 1;
                this.leftOrnamentOffset = -6;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153;
                this.rightOrnamentOffset = 6;
                this.barLimits = 0;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("OfferDisplayBlock");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("OfferDisplayBlock", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 13415802;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".selectOutfitTabContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".selectOutfitTabContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".nameFilterEditorList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".nameFilterEditorList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.alternatingItemAlphas = [0.8, 0];
                this.horizontalGridLines = false;
                this.backgroundColor = "";
                this.horizontalGridLineColor = 8089164;
                this.rollOverColor = 2768716;
                this.iconColor = 13221291;
                this.verticalGridLines = true;
                this.textRollOverColor = 13221291;
                this.borderAlpha = 1;
                this.selectionColor = 658961;
                this.verticalGridLineColor = 8089164;
                this.backgroundAlpha = 0.8;
                this.disabledIconColor = 13221291;
                this.color = 13221291;
                this.alternatingItemColors = [1977654, 16711680];
                this.selectionDuration = 0;
                this.borderThickness = 1;
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetViewToggle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetViewToggle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_820025018;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_over_png_546707386;
                this.defaultOverCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_998762331;
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1723628123;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1357302191;
                this.selectedDownCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_2110866166;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonNorth");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonNorth", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "top";
                this.defaultDownTopImage = "right";
                this.defaultDownMask = "top";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "top";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".expandedView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".expandedView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderCenterCenterImage = _embed_css_images_BG_Combat_ExpertOn_png_1586084142;
                this.borderFooterMask = "none";
                this.borderCenterMask = "all";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetLeftView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetLeftView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotBackBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotBackBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBackpack_protected_png_336111998;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("TransactionHistory");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TransactionHistory", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.alternatingItemAlphas = [0.8, 0];
                this.horizontalGridLines = false;
                this.backgroundColor = "";
                this.horizontalGridLineColor = 8089164;
                this.rollOverColor = 2768716;
                this.iconColor = 13221291;
                this.verticalGridLines = true;
                this.textRollOverColor = 13221291;
                this.borderAlpha = 1;
                this.selectionColor = 658961;
                this.verticalGridLineColor = 8089164;
                this.backgroundAlpha = 0.8;
                this.disabledIconColor = 13221291;
                this.color = 13221291;
                this.alternatingItemColors = [1977654, 16711680];
                this.selectionDuration = 0;
                this.borderThickness = 1;
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default__png_715141111;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopBold");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopBold", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".optionsConfigurationWidgetTabNavigator");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".optionsConfigurationWidgetTabNavigator", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 1;
                this.borderColor = 13415802;
                this.tabStyleName = "simpleTabNavigator";
                this.backgroundColor = 658961;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetAppearanceRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetAppearanceRenderer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.overlayHighlightImage = _embed_css_images_slot_container_highlighted_png_1493388964;
                this.overlayDisabledImage = _embed_css_images_slot_container_disabled_png_1480414781;
                this.paddingTop = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_2109452872;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetButtonOpen");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetButtonOpen", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ChatTabNew_over_png_540129489;
                this.defaultDownCenterImage = _embed_css_images_Button_ChatTabNew_pressed_png_1719858715;
                this.defaultUpCenterImage = _embed_css_images_Button_ChatTabNew_idle_png_1801992145;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferSale");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferSale", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 16232264;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buddylistContent");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buddylistContent", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".embeddedDialogButtonBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".embeddedDialogButtonBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.backgroundColor = 658961;
                this.horizontalAlign = "center";
                this.horizontalGap = 16;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.8;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonCenter");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonCenter", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Minimap_Center_over_png_472159534;
                this.defaultDownCenterImage = _embed_css_images_Minimap_Center_active_png_1335260772;
                this.defaultUpCenterImage = _embed_css_images_Minimap_Center_idle_png_2072960978;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotNeck");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotNeck", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryNecklace_png_1810394141;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".editMarkSelector");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".editMarkSelector", style, false);
            }
            style = StyleManager.getStyleDeclaration(".spellListWidgetTabBarBackground");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spellListWidgetTabBarBackground", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1624887026;
                this.horizontalAlign = "left";
                this.verticalAlign = "middle";
                this.paddingLeft = 2;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ScrollBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ScrollBar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upArrowUpSkin = _embed_css_images_Scrollbar_Arrow_up_idle_png_719956101;
                this.downArrowUpSkin = _embed_css_images_Scrollbar_Arrow_down_idle_png_368252608;
                this.upArrowOverSkin = _embed_css_images_Scrollbar_Arrow_up_over_png_1067260293;
                this.backgroundColor = 65280;
                this.trackSkin = _embed_css_images_Scrollbar_tileable_png_1485067795;
                this.downArrowDownSkin = _embed_css_images_Scrollbar_Arrow_down_pressed_png_1581698428;
                this.upArrowDownSkin = _embed_css_images_Scrollbar_Arrow_up_pressed_png_167339657;
                this.downArrowDisabledSkin = _embed_css_images_Scrollbar_Arrow_down_idle_png_368252608;
                this.upArrowDisabledSkin = _embed_css_images_Scrollbar_Arrow_up_idle_png_719956101;
                this.backgroundAlpha = 0;
                this.thumbSkin = _embed_css_images_Scrollbar_Handler_png_150592189;
                this.downArrowOverSkin = _embed_css_images_Scrollbar_Arrow_down_over_png_1631401408;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".tradeItemListStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".tradeItemListStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.paddingLeft = 3;
                this.paddingBottom = 2;
                this.paddingRight = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".nameFilterOptionsWhiteListEditor");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".nameFilterOptionsWhiteListEditor", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.nameFilterListStyle = "nameFilterEditorList";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonBalanced");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonBalanced", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1401422619;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_MediumOn_over_png_1612481051;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_MediumOff_over_png_883471643;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_MediumOff_idle_png_915659237;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_MediumOff_over_png_883471643;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_MediumOn_over_png_1612481051;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("DataGrid");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DataGrid", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.focusThickness = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".containerPageFooter");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".containerPageFooter", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.paddingTop = 2;
                this.backgroundColor = 1977654;
                this.errorColor = 16711680;
                this.disabledColor = 13221291;
                this.borderAlpha = 1;
                this.verticalGap = 1;
                this.backgroundAlpha = 0.5;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.color = 13221291;
                this.borderThickness = 1;
                this.horizontalGap = 4;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("GeneralButtonsWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("GeneralButtonsWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_155670682;
                this.borderFooterMask = "none";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTabBarScrollLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTabBarScrollLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "left";
                this.defaultDisabledMask = "left";
                this.defaultDownMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultDisabledBottomImage = "right";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("MarketWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("MarketWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.errorColor = 16711680;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFat");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFat", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.hitpointsOffsetY = -1;
                this.manaOffsetX = 2;
                this.manaOffsetY = -1;
                this.hitpointsStyle = "statusWidgetFatHitpoints";
                this.stateStyle = "statusWidgetFat";
                this.hitpointsOffsetX = -2;
                this.manaStyle = "statusWidgetFatMana";
                this.skillStyle = "statusWidgetFatSkill";
                this.verticalGap = 1;
                this.horizontalGap = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buddylistWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buddylistWidgetView", style, false);
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultBonusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultBonusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_944734739;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".embeddedDialogContentBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".embeddedDialogContentBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.horizontalAlign = "left";
                this.verticalAlign = "middle";
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("TextEditor");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextEditor", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 13221291;
                this.errorColor = 13221291;
                this.textRollOverColor = 13221291;
                this.disabledColor = 13221291;
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CustomSlider");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CustomSlider", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.increaseButtonStyle = "customSliderIncreaseButton";
                this.decreaseButtonStyle = "customSliderDecreaseButton";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("Header");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Header", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 2;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.borderThickness = 1;
                this.horizontalGap = 4;
                this.borderAlpha = 1;
                this.paddingBottom = 0;
                this.paddingLeft = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".premiumWidgetButtonBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".premiumWidgetButtonBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".nameFilterOptionsBlackListEditor");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".nameFilterOptionsBlackListEditor", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.nameFilterListStyle = "nameFilterEditorList";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("StatusWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("StatusWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "all";
                this.paddingTop = 0;
                this.verticalGap = 1;
                this.borderCenterImage = _embed_css_images_BG_Stone2_Tileable_png_2077472744;
                this.paddingLeft = 1;
                this.verticalBigGap = 10;
                this.paddingRight = 1;
                this.borderRightImage = _embed_css_images_Border02_png_653295686;
                this.horizontalBigGap = 10;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_1814375145;
                this.borderSkin = BitmapBorderSkin;
                this.horizontalGap = 1;
                this.paddingBottom = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultHitpoints");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultHitpoints", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_411547495;
                this.rightOrnamentMask = "right";
                this.barGreenFull = _embed_css_images_BarsHealth_default_GreenFull_png_734293341;
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.leftOrnamentMask = "none";
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_195008000;
                this.leftOrnamentLeftImage = "right";
                this.barGreenLow = _embed_css_images_BarsHealth_default_GreenLow_png_1548787312;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundMask = "center";
                this.paddingLeft = 1;
                this.paddingRight = 3;
                this.barRedFull = _embed_css_images_BarsHealth_default_RedFull_png_468004747;
                this.barRedLow2 = _embed_css_images_BarsHealth_default_RedLow2_png_1313758662;
                this.leftOrnamentOffset = -5;
                this.barYellow = _embed_css_images_BarsHealth_default_Yellow_png_397166041;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                this.rightOrnamentOffset = 5;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
                this.barRedLow = _embed_css_images_BarsHealth_default_RedLow_png_1517088146;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".selectOutfitPrev");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".selectOutfitPrev", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left";
                this.defaultUpMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultDownMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CombatControlWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CombatControlWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.buttonOffensiveStyle = "combatButtonOffensive";
                this.buttonMountStyle = "combatButtonMount";
                this.paddingTop = 0;
                this.buttonDoveStyle = "combatButtonDove";
                this.buttonSecureStyle = "combatButtonSecure";
                this.buttonYellowHandStyle = "combatButtonYellowHand";
                this.buttonStopStyle = "combatButtonStop";
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.buttonRedFistStyle = "combatButtonRedFist";
                this.buttonChaseStyle = "combatButtonChase";
                this.borderCenterCenterImage = _embed_css_images_BG_Combat_ExpertOff_png_1001256734;
                this.buttonExpertModeStyle = "combatButtonExpert";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Combat_png_724053726;
                this.buttonBalancedStyle = "combatButtonBalanced";
                this.buttonDefensiveStyle = "combatButtonDefensive";
                this.buttonWhiteHandStyle = "combatButtonWhiteHand";
                this.borderCenterMask = "all";
                this.borderFooterMask = "none";
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTabBarScrollRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTabBarScrollRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "right";
                this.defaultDisabledMask = "right";
                this.defaultDownMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ChannelView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ChannelView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.dividerThickness = 5;
                this.dividerBackgroundLeftImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420836441;
                this.dividerBackgroundMask = "left";
                this.dividerAffordance = 5;
                this.verticalGap = 0;
                this.horizontalGap = 5;
                this.nicklistStyle = "nicklist";
                this.messagesStyle = "messages";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotBack");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotBack", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBackpack_png_1143422153;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".containerPageRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".containerPageRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "right";
                this.defaultDisabledMask = "right";
                this.defaultDownMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".getCoinsStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".getCoinsStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_382995454;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetTabNavigator");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetTabNavigator", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 1;
                this.borderColor = 13415802;
                this.tabStyleName = "simpleTabNavigator";
                this.backgroundColor = 658961;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".outfitDialogOpenStoreButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".outfitDialogOpenStoreButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icons_Inventory_Store_png_1554221163;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".gameWindowLockButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".gameWindowLockButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = BitmapButtonIcon;
                this.iconDefaultDownMask = "center";
                this.iconDefaultOverCenterImage = _embed_css_images_Button_LockHotkeys_UnLocked_over_png_454831310;
                this.iconDefaultOverMask = "center";
                this.iconSelectedDownCenterImage = _embed_css_images_Button_LockHotkeys_Locked_over_png_553743711;
                this.skin = _embed_css_images_Slot_Statusicon_png_1343906902;
                this.iconSelectedUpMask = "center";
                this.iconDefaultUpCenterImage = _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_124439502;
                this.iconSelectedUpCenterImage = _embed_css_images_Button_LockHotkeys_Locked_idle_png_887674463;
                this.iconSelectedOverCenterImage = _embed_css_images_Button_LockHotkeys_Locked_over_png_553743711;
                this.iconDefaultUpMask = "center";
                this.iconDefaultDownCenterImage = _embed_css_images_Button_LockHotkeys_UnLocked_over_png_454831310;
                this.iconSelectedOverMask = "center";
                this.iconSelectedDownMask = "center";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTabBarScrollRightHighlight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTabBarScrollRightHighlight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "right";
                this.defaultUpMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1012163085;
                this.defaultDownMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1817970777;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("Tibia");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Tibia", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "center";
                this.borderSkin = BitmapBorderSkin;
                this.themeColor = 13221291;
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_png_1633084633;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".validationFeedbackError");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".validationFeedbackError", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 13120000;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotLeftHandBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotLeftHandBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryWeapon_protected_png_1820724014;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".embeddedDialogTitleBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".embeddedDialogTitleBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.backgroundColor = 658961;
                this.horizontalAlign = "center";
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.8;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTextField");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTextField", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 0;
                this.backgroundColor = 0;
                this.borderThickness = 1;
                this.backgroundAlpha = 0.33;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buddylist");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buddylist", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.itemBackgroundColors = [2768716, 16711680];
                this.paddingTop = 0;
                this.itemRendererStyle = "buddylistWidgetView";
                this.itemBackgroundAlphas = [0.5, 0];
                this.verticalGap = 2;
                this.horizontalGap = 0;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotHipBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotHipBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryAmmo_protected_png_235989040;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistWidgetViewHideNonSkulled");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistWidgetViewHideNonSkulled", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_active_png_1938199697;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_401045620;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_over_png_704659135;
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_idle_png_1237957567;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_over_png_704659135;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_401045620;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotRightHandBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotRightHandBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryShield_protected_png_1679014625;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ContainerSlot");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ContainerSlot", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 1;
                this.backgroundColor = 16711680;
                this.backgroundImage = _embed_css_images_slot_container_png_2109452872;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.backgroundAlpha = 1;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistWidgetViewHideParty");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistWidgetViewHideParty", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_active_png_1900393862;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_941597865;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_over_png_221750764;
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_idle_png_126080788;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_over_png_221750764;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_941597865;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopYesButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopYesButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icons_IngameShop_12x12_Yes_png_409063775;
                this.paddingTop = 2;
                this.paddingBottom = 2;
                this.paddingLeft = 8;
                this.paddingRight = 8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotRightHand");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotRightHand", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryShield_png_608340556;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatSkill");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatSkill", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.labelStyleName = ".statusWidgetSkillProgress";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetFatBonusSkillProgress";
                this.verticalAlign = "middle";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetFatSkillProgress";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("Button");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Button", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left center right";
                this.selectedDownLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_571868347;
                this.selectedDownMask = "left center right";
                this.defaultOverRightImage = "left";
                this.selectedOverMask = "left center right";
                this.selectedOverRightImage = "left";
                this.selectedUpMask = "left center right";
                this.defaultOverCenterImage = _embed_css_images_Button_Standard_tileable_over_png_268131044;
                this.textRollOverColor = 15904590;
                this.defaultUpCenterImage = _embed_css_images_Button_Standard_tileable_idle_png_81709028;
                this.selectedOverLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_over_png_1675031287;
                this.defaultDisabledLeftImage = _embed_css_images_Button_Standard_tileable_end_disabled_png_1886138848;
                this.skin = BitmapButtonSkin;
                this.selectedUpLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_idle_png_739972599;
                this.defaultOverMask = "left center right";
                this.defaultUpLeftImage = _embed_css_images_Button_Standard_tileable_end_idle_png_1252448280;
                this.defaultOverLeftImage = _embed_css_images_Button_Standard_tileable_end_over_png_1241269528;
                this.selectedDownRightImage = "left";
                this.selectedDisabledMask = "left center right";
                this.paddingBottom = 0;
                this.textSelectedColor = 13221291;
                this.defaultUpRightImage = "left";
                this.defaultDisabledRightImage = "left";
                this.defaultUpMask = "left center right";
                this.selectedDisabledRightImage = "left";
                this.defaultDisabledCenterImage = _embed_css_images_Button_Standard_tileable_disabled_png_981449860;
                this.paddingTop = 0;
                this.selectedUpCenterImage = _embed_css_images_Button_Standard_tileable_gold_idle_png_1668393027;
                this.selectedDisabledLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_461534559;
                this.defaultDownMask = "left center right";
                this.selectedOverCenterImage = _embed_css_images_Button_Standard_tileable_gold_over_png_130746045;
                this.focusThickness = 0;
                this.disabledColor = 15904590;
                this.selectedUpRightImage = "left";
                this.paddingLeft = 4;
                this.paddingRight = 4;
                this.color = 15904590;
                this.selectedDisabledCenterImage = _embed_css_images_Button_Standard_tileable_disabled_png_981449860;
                this.defaultDownCenterImage = _embed_css_images_Button_Standard_tileable_pressed_png_2061718888;
                this.defaultDownRightImage = "left";
                this.defaultDownLeftImage = _embed_css_images_Button_Standard_tileable_end_pressed_png_365075596;
                this.selectedDownCenterImage = _embed_css_images_Button_Standard_tileable_gold_pressed_png_743255753;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("MiniMapWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("MiniMapWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.buttonWestStyle = "miniMapButtonWest";
                this.paddingTop = 0;
                this.paddingLeft = 0;
                this.buttonSouthStyle = "miniMapButtonSouth";
                this.paddingRight = 0;
                this.buttonCenterStyle = "miniMapButtonCenter";
                this.buttonUpStyle = "miniMapButtonUp";
                this.borderCenterCenterImage = _embed_css_images_Minimap_png_3417015;
                this.buttonZoomInStyle = "miniMapButtonZoomIn";
                this.buttonDownStyle = "miniMapButtonDown";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Minimap_png_2033096949;
                this.buttonZoomOutStyle = "miniMapButtonZoomOut";
                this.borderCenterMask = "all";
                this.borderFooterMask = "none";
                this.buttonEastStyle = "miniMapButtonEast";
                this.paddingBottom = 0;
                this.buttonNorthStyle = "miniMapButtonNorth";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderGeneral");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderGeneral", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_818508452;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_437906913;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1930213085;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1962358646;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1930213085;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_437906913;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetSingleView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetSingleView", style, false);
            }
            style = StyleManager.getStyleDeclaration(".popUpFooterStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popUpFooterStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 1;
                this.borderColor = 8089164;
                this.backgroundColor = 658961;
                this.borderThickness = 1;
                this.horizontalAlign = "center";
                this.horizontalGap = 32;
                this.borderAlpha = 1;
                this.paddingLeft = 1;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".editMarkWidgetRootContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".editMarkWidgetRootContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistWidgetViewHideNPC");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistWidgetViewHideNPC", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_active_png_1808018121;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_818989716;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_over_png_977404663;
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1864732663;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_over_png_977404663;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_818989716;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotTorsoBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotTorsoBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryArmor_protected_png_793628133;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonDefensive");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonDefensive", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883572083;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1835625099;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_290537603;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1525887613;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_290537603;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1835625099;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".rootContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".rootContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.dividerBackgroundRightImage = _embed_css_images_Border02_png_653295686;
                this.dividerThickness = 7;
                this.dividerBackgroundTopRightImage = _embed_css_images_Border02_corners_png_1814375145;
                this.dividerBackgroundMask = "topLeft top topRight";
                this.dividerKnobMask = "top";
                this.dividerAffordance = 7;
                this.dividerKnobTopImage = _embed_css_images_ChatWindow_Mover_png_1661714110;
                this.dividerKnobAlignment = "top";
                this.verticalGap = 7;
                this.horizontalGap = 0;
                this.dividerBackgroundTopLeftImage = "topRight";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("NameFilterOptions");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("NameFilterOptions", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.blackListEditorStyle = "nameFilterOptionsWhiteListEditor";
                this.color = 13221291;
                this.errorColor = 13221291;
                this.textRollOverColor = 13221291;
                this.disabledColor = 13221291;
                this.textSelectedColor = 13221291;
                this.whiteListEditorStyle = "nameFilterOptionsBlackListEditor";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderTrade");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderTrade", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_active_png_1471954475;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_852280450;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_898351276;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_idle_png_851799561;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_898351276;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_852280450;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetScrollBottom");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetScrollBottom", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "bottom";
                this.defaultDownTopImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_594657599;
                this.defaultDisabledLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "bottom";
                this.defaultUpTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785;
                this.defaultUpMask = "bottom";
                this.paddingTop = 0;
                this.defaultDownMask = "bottom";
                this.defaultOverTopImage = "right";
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939;
                this.defaultDownLeftImage = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("MainContentPane");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("MainContentPane", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.paddingTop = 1;
                this.verticalGap = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("BuddylistWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("BuddylistWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_VipList_png_375643883;
                this.listBoxStyle = "buddylistContent";
                this.verticalGap = 0;
                this.horizontalGap = 0;
                this.listStyle = "buddylist";
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopCategoryBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopCategoryBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 13415802;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".spellListWidgetForm");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spellListWidgetForm", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "none";
                this.paddingTop = 0;
                this.errorColor = 16711680;
                this.textRollOverColor = 13221291;
                this.verticalGap = -2;
                this.disabledColor = 13221291;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.indicatorGap = 4;
                this.color = 13221291;
                this.borderThickness = 0;
                this.horizontalGap = 0;
                this.textSelectedColor = 13221291;
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("OutfitColourSelector");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("OutfitColourSelector", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.selectionAlpha = 1;
                this.pickerSize = 12;
                this.paddingTop = 0;
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.selectionColor = 13221291;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistWidgetViewHidePlayer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistWidgetViewHidePlayer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_png_1553385195;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1758613678;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_over_png_887453159;
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_idle_png_17040615;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_over_png_887453159;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1758613678;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcSummaryForm");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcSummaryForm", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 2;
                this.borderColor = 8089164;
                this.backgroundColor = 1977654;
                this.borderThickness = 1;
                this.verticalGap = 1;
                this.horizontalGap = 4;
                this.borderAlpha = 1;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ContextMenuBase");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ContextMenuBase", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.borderSkin = VectorBorderSkin;
                this.borderThickness = 1;
                this.verticalGap = 0;
                this.borderAlpha = 1;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.8;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CharacterNameChangeWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CharacterNameChangeWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.minimumButtonWidth = 60;
                this.buttonCancelStyle = "ingameShopNoButton";
                this.informationColor = 4286945;
                this.buttonNoStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallel", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.hitpointsOffsetY = -1;
                this.manaOffsetX = 0;
                this.manaOffsetY = 0;
                this.hitpointsStyle = "statusWidgetParallelHitpoints";
                this.stateStyle = "statusWidgetParallel";
                this.hitpointsOffsetX = 0;
                this.manaStyle = "statusWidgetParallelMana";
                this.skillStyle = "statusWidgetParallelSkill";
                this.verticalGap = 1;
                this.horizontalGap = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".premiumWidgetGridItem");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".premiumWidgetGridItem", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("TextItem");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextItem", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.textColor = 13221291;
                this.paddingTop = 0;
                this.rollOverColor = 2768716;
                this.textRollOverColor = 13221291;
                this.horizontalGap = 0;
                this.rollOverAlpha = 0.5;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetScrollLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetScrollLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left";
                this.defaultDownTopImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_594657599;
                this.defaultDisabledLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "left";
                this.defaultUpTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785;
                this.defaultUpMask = "left";
                this.paddingTop = 0;
                this.defaultDownMask = "left";
                this.defaultOverTopImage = "right";
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939;
                this.defaultDownLeftImage = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("UnjustPointsWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("UnjustPointsWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderCenterCenterImage = _embed_css_images_UnjustifiedPoints_png_1243898267;
                this.paddingTop = 0;
                this.color = 16777215;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Skull_png_318007965;
                this.borderFooterMask = "none";
                this.borderCenterMask = "all";
                this.verticalGap = 0;
                this.horizontalGap = 0;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "none";
                this.borderColor = "";
                this.paddingTop = 2;
                this.backgroundColor = "";
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.borderAlpha = 0;
                this.verticalGap = 2;
                this.backgroundAlpha = 0;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.borderThickness = 0;
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SafeTradeWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SafeTradeWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tradeFooterStyle = "tradeFooterStyle";
                this.color = 13221291;
                this.errorColor = 16711680;
                this.separatorColor = 8089164;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1502561270;
                this.disabledColor = 13221291;
                this.tradeItemSlotStyle = "";
                this.tradeItemListStyle = "tradeItemListStyle";
                this.tradeHeaderStyle = "tradeHeaderStyle";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("EditMarkWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("EditMarkWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.descriptionStyle = "editMarkDescription";
                this.markSelectorStyle = "editMarkSelector";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".containerWigdetViewUp");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".containerWigdetViewUp", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.defaultOverMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Button_ContainerUp_idle_png_346363474;
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ContainerUp_over_png_941742;
                this.defaultDownCenterImage = _embed_css_images_Button_ContainerUp_pressed_png_567833978;
                this.defaultUpCenterImage = _embed_css_images_Button_ContainerUp_idle_png_346363474;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SideBarHeader");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SideBarHeader", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left bottomLeft bottom bottomRight right center";
                this.paddingTop = 2;
                this.buttonContainerStyle = "sideBarHeaderContainer";
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.verticalGap = 2;
                this.buttonCombatStyle = "sideBarHeaderCombat";
                this.paddingLeft = 0;
                this.borderCenterImage = _embed_css_images_BG_Widget_Menu_png_1047900232;
                this.buttonBuddylistStyle = "sideBarHeaderBuddylist";
                this.paddingRight = 0;
                this.borderRightImage = _embed_css_images_Border02_png_653295686;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_1814375145;
                this.buttonBodyStyle = "sideBarHeaderBody";
                this.borderSkin = BitmapBorderSkin;
                this.buttonBattlelistStyle = "sideBarHeaderBattlelist";
                this.buttonTradeStyle = "sideBarHeaderTrade";
                this.buttonMinimapStyle = "sideBarHeaderMinimap";
                this.buttonUnjustPointsStyle = "sideBarUnjustPoints";
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.foldButtonStyleName = "sideBarHeaderFold";
                this.buttonGeneralStyle = "sideBarHeaderGeneral";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CategoryRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CategoryRenderer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddintTop = 0;
                this.verticalAlign = "middle";
                this.horizontalGap = 4;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".widgetViewClose");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".widgetViewClose", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.defaultOverMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Button_Close_disabled_png_1265071570;
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_Close_over_png_1224962954;
                this.defaultDownCenterImage = _embed_css_images_Button_Close_pressed_png_1029688314;
                this.defaultUpCenterImage = _embed_css_images_Button_Close_idle_png_880644746;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetToggleRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetToggleRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "right";
                this.borderLeft = 0;
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.borderRight = 0;
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "right";
                this.defaultUpMask = "left";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "left";
                this.defaultDownMask = "left";
                this.defaultOverTopImage = "right";
                this.borderBottom = 0;
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.borderTop = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "left";
                this.selectedOverTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "left";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "right";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "right";
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.iconSelectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.iconSelectedUpBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownMask = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ChatWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ChatWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left bottomLeft bottom bottomRight right center";
                this.paddingTop = 0;
                this.titleIgnoreButtonStyle = "chatWidgetButtonIgnore";
                this.titleRightHolderStyle = "chatWidgetRightHolder";
                this.titleBarStyle = "chatWidgetTitle";
                this.inputBarTextFieldStyle = "chatWidgetTextField";
                this.inputBarStyle = "chatWidgetInput";
                this.viewBarStyle = "chatWidgetView";
                this.titleOpenButtonStyle = "chatWidgetButtonOpen";
                this.verticalGap = 0;
                this.viewBarRightViewStyle = "chatWidgetRightView";
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_ChatConsole_png_2063060441;
                this.paddingLeft = 0;
                this.viewBarSingleViewStyle = "chatWidgetSingleView";
                this.paddingRight = 0;
                this.borderRightImage = _embed_css_images_Border02_png_653295686;
                this.titleTabBarStyle = "chatWidgetTabBar";
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_1814375145;
                this.titleRightTabStyle = "chatWidgetRightTab";
                this.borderSkin = BitmapBorderSkin;
                this.viewBarLeftViewStyle = "chatWidgetLeftView";
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetRightHolder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetRightHolder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "center";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.horizontalAlign = "center";
                this.verticalAlign = "bottom";
                this.verticalGap = 0;
                this.horizontalGap = 0;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.borderCenterImage = _embed_css_images_BG_ChatTab_Tabdrop_png_472094208;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("TextArea");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextArea", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.borderThickness = 1;
                this.focusThickness = 0;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".transferCoinsButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".transferCoinsButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_799933556;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("PurchaseConfirmationWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("PurchaseConfirmationWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.minimumButtonWidth = 60;
                this.buttonCancelStyle = "ingameShopNoButton";
                this.informationColor = 4286945;
                this.buttonNoStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CustomButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CustomButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left center right";
                this.selectedDownLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_571868347;
                this.selectedDownMask = "left center right";
                this.defaultOverRightImage = "left";
                this.selectedOverMask = "left center right";
                this.selectedOverRightImage = "left";
                this.selectedUpMask = "left center right";
                this.defaultOverCenterImage = _embed_css_images_Button_Standard_tileable_over_png_268131044;
                this.textRollOverColor = 15904590;
                this.defaultUpCenterImage = _embed_css_images_Button_Standard_tileable_idle_png_81709028;
                this.selectedOverLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_over_png_1675031287;
                this.defaultDisabledLeftImage = _embed_css_images_Button_Standard_tileable_end_disabled_png_1886138848;
                this.skin = BitmapButtonSkin;
                this.selectedUpLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_idle_png_739972599;
                this.defaultOverMask = "left center right";
                this.defaultUpLeftImage = _embed_css_images_Button_Standard_tileable_end_idle_png_1252448280;
                this.defaultOverLeftImage = _embed_css_images_Button_Standard_tileable_end_over_png_1241269528;
                this.selectedDownRightImage = "left";
                this.selectedDisabledMask = "left center right";
                this.paddingBottom = 0;
                this.textSelectedColor = 13221291;
                this.defaultUpRightImage = "left";
                this.defaultDisabledRightImage = "left";
                this.defaultUpMask = "left center right";
                this.selectedDisabledRightImage = "left";
                this.defaultDisabledCenterImage = _embed_css_images_Button_Standard_tileable_disabled_png_981449860;
                this.paddingTop = 0;
                this.selectedUpCenterImage = _embed_css_images_Button_Standard_tileable_gold_idle_png_1668393027;
                this.selectedDisabledLeftImage = _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_461534559;
                this.defaultDownMask = "left center right";
                this.selectedOverCenterImage = _embed_css_images_Button_Standard_tileable_gold_over_png_130746045;
                this.focusThickness = 0;
                this.disabledColor = 15904590;
                this.selectedUpRightImage = "left";
                this.paddingLeft = 4;
                this.paddingRight = 4;
                this.color = 15904590;
                this.selectedDisabledCenterImage = _embed_css_images_Button_Standard_tileable_disabled_png_981449860;
                this.defaultDownCenterImage = _embed_css_images_Button_Standard_tileable_pressed_png_2061718888;
                this.defaultDownRightImage = "left";
                this.defaultDownLeftImage = _embed_css_images_Button_Standard_tileable_end_pressed_png_365075596;
                this.selectedDownCenterImage = _embed_css_images_Button_Standard_tileable_gold_pressed_png_743255753;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SmoothList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SmoothList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderColor = 65280;
                this.backgroundColor = 65280;
                this.borderSkin = VectorBorderSkin;
                this.borderThickness = 0;
                this.borderAlpha = 0;
                this.backgroundAlpha = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonZoomIn");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonZoomIn", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Minimap_ZoomIn_over_png_1551341379;
                this.defaultDownCenterImage = _embed_css_images_Minimap_ZoomIn_pressed_png_1091121313;
                this.defaultUpCenterImage = _embed_css_images_Minimap_ZoomIn_idle_png_271390787;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonRedFist");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonRedFist", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_667468207;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_RedFistOn_over_png_1081889455;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1068232037;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1415932517;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1068232037;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_RedFistOn_over_png_1081889455;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactSkill");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactSkill", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.labelStyleName = ".statusWidgetSkillProgress";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetCompactBonusSkillProgress";
                this.verticalAlign = "middle";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetCompactSkillProgress";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferRendererBoxDisabled");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferRendererBoxDisabled", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 7630671;
                this.backgroundColor = 658961;
                this.borderSkin = VectorBorderSkin;
                this.borderThickness = 1;
                this.horizontalAlign = "center";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".hotkeyOptionsMappingList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".hotkeyOptionsMappingList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.alternatingItemAlphas = [0.8, 0];
                this.horizontalGridLines = false;
                this.backgroundColor = "";
                this.horizontalGridLineColor = 8089164;
                this.rollOverColor = 2768716;
                this.iconColor = 13221291;
                this.verticalGridLines = true;
                this.textRollOverColor = 13221291;
                this.borderAlpha = 1;
                this.selectionColor = 658961;
                this.verticalGridLineColor = 8089164;
                this.backgroundAlpha = 0.8;
                this.disabledIconColor = 13221291;
                this.color = 13221291;
                this.alternatingItemColors = [1977654, 16711680];
                this.selectionDuration = 0;
                this.borderThickness = 1;
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buttonStoreInbox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buttonStoreInbox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icons_Inventory_StoreInbox_png_1908239703;
                this.paddingLeft = 22;
                this.paddingRight = 22;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("List");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("List", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.alternatingItemAlphas = [0.8, 0.8];
                this.backgroundColor = "";
                this.rollOverColor = 2633265;
                this.textRollOverColor = 13221291;
                this.focusThickness = 0;
                this.selectionColor = 4936794;
                this.backgroundAlpha = 0.8;
                this.color = 13221291;
                this.alternatingItemColors = [658961, 658961];
                this.borderSkin = EmptySkin;
                this.selectionDuration = 0;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetInput");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetInput", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "bottom";
                this.paddingTop = 2;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1624887026;
                this.borderBottomImage = "top";
                this.horizontalAlign = "left";
                this.verticalAlign = "middle";
                this.verticalGap = 0;
                this.horizontalGap = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistWidgetViewHideMonster");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistWidgetViewHideMonster", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_active_png_1842737870;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_504631023;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_over_png_1921465284;
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1095386428;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_over_png_1921465284;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_504631023;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelHitpoints");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelHitpoints", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_411547495;
                this.rightOrnamentMask = "right";
                this.barGreenFull = _embed_css_images_BarsHealth_default_GreenFull_png_734293341;
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.leftOrnamentMask = "left";
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_195008000;
                this.leftOrnamentLeftImage = "right";
                this.barGreenLow = _embed_css_images_BarsHealth_default_GreenLow_png_1548787312;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundMask = "center";
                this.paddingLeft = 3;
                this.barRedFull = _embed_css_images_BarsHealth_default_RedFull_png_468004747;
                this.paddingRight = 3;
                this.barRedLow2 = _embed_css_images_BarsHealth_default_RedLow2_png_1313758662;
                this.leftOrnamentOffset = -5;
                this.barYellow = _embed_css_images_BarsHealth_default_Yellow_png_397166041;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                this.rightOrnamentOffset = 5;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
                this.barRedLow = _embed_css_images_BarsHealth_default_RedLow_png_1517088146;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".noBackground");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".noBackground", style, false);
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderBuddylist");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderBuddylist", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_active_png_784118109;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_661855834;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1345701772;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_idle_png_436343953;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1345701772;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_661855834;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelBonusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelBonusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_944734739;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("NicklistItemRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("NicklistItemRenderer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.inviteeTextColor = 16277600;
                this.subscriberTextColor = 6355040;
                this.pendingTextColor = 16753920;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("OutfitTypeSelector");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("OutfitTypeSelector", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.paddingTop = 2;
                this.backgroundColor = 2240055;
                this.horizontalAlign = "center";
                this.verticalAlign = "top";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingLeft = 2;
                this.prevButtonStyle = "selectOutfitPrev";
                this.paddingRight = 2;
                this.nameLabelStyle = "selectOutfitLabel";
                this.borderThickness = 1;
                this.nextButtonStyle = "selectOutfitNext";
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".getCoinConfirmation");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".getCoinConfirmation", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.minimumButtonWidth = 60;
                this.buttonCancelStyle = "ingameShopNoButton";
                this.informationColor = 4286945;
                this.buttonNoStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetAmountIncrease");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetAmountIncrease", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "right";
                this.defaultUpMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultDownMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistWidgetView", style, false);
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetToggleLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetToggleLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "left";
                this.borderLeft = 0;
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.borderRight = 0;
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "left";
                this.defaultUpMask = "right";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "right";
                this.defaultDownMask = "right";
                this.defaultOverTopImage = "right";
                this.borderBottom = 0;
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.borderTop = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "right";
                this.selectedOverTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "right";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "left";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "left";
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "left";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.iconSelectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.iconSelectedUpBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownMask = "left";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderMinimap");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderMinimap", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_active_png_739130423;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_351247284;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979642586;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_622418263;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979642586;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_351247284;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonStop");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonStop", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_Combat_Stop_over_png_375093765;
                this.defaultDownCenterImage = _embed_css_images_Button_Combat_Stop_pressed_png_1196904143;
                this.defaultUpCenterImage = _embed_css_images_Button_Combat_Stop_idle_png_1424042235;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopNoPadding");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopNoPadding", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default__png_715141111;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".hotkeyOptionsSetScrollLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".hotkeyOptionsSetScrollLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left";
                this.defaultUpMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultDownMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotLeftHand");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotLeftHand", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryWeapon_png_2107549357;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("PopUpBase");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("PopUpBase", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.backgroundColor = 658961;
                this.errorColor = 13221291;
                this.titleStyle = "popUpTitleStyle";
                this.footerStyle = "popUpFooterStyle";
                this.modalTransparencyColor = 1580578;
                this.cornerRadius = 0;
                this.borderBottom = 33;
                this.borderLeft = 3;
                this.borderAlpha = 1;
                this.disabledColor = 13221291;
                this.backgroundAlpha = 0.5;
                this.modalTransparency = 0.5;
                this.iconStyle = null;
                this.modalTransparencyBlur = 0;
                this.borderTop = 33;
                this.color = 13221291;
                this.modalTransparencyDuration = 0;
                this.headerStyle = "popUpHeaderStyle";
                this.borderThickness = 1;
                this.borderRight = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopCategoryDescription");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopCategoryDescription", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontSize = 9;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistHeader");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistHeader", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1624887026;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.verticalGap = 0;
                this.horizontalGap = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompact");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompact", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.hitpointsOffsetY = -1;
                this.manaOffsetX = 2;
                this.manaOffsetY = -1;
                this.hitpointsStyle = "statusWidgetCompactHitpoints";
                this.stateStyle = "statusWidgetCompact";
                this.hitpointsOffsetX = -2;
                this.manaStyle = "statusWidgetCompactMana";
                this.skillStyle = "statusWidgetCompactSkill";
                this.verticalGap = 1;
                this.horizontalGap = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("BodyContainerViewWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("BodyContainerViewWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.capacityFontSize = 9;
                this.bodySlotTorsoStyle = "bodySlotTorso";
                this.bodySlotRightHandBlessedStyle = "bodySlotRightHandBlessed";
                this.bodySlotNeckStyle = "bodySlotNeck";
                this.bodySlotPremiumStyle = "bodySlotPremium";
                this.bodySlotFingerBlessedStyle = "bodySlotFingerBlessed";
                this.bodySlotLeftHandBlessedStyle = "bodySlotLeftHandBlessed";
                this.buttonIngameShopStyle = "buttonIngameShop";
                this.capacityFontFamily = "Verdana";
                this.bodySlotLegsStyle = "bodySlotLegs";
                this.bodySlotBlessingStyle = "bodySlotBlessing";
                this.bodySlotHipBlessedStyle = "bodySlotHipBlessed";
                this.bodySlotFingerStyle = "bodySlotFinger";
                this.bodySlotFeetStyle = "bodySlotFeet";
                this.bodySlotLegsBlessedStyle = "bodySlotLegsBlessed";
                this.bodySlotFeetBlessedStyle = "bodySlotFeetBlessed";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Inventory_png_1541911384;
                this.capacityFontColor = 16777215;
                this.bodySlotNeckBlessedStyle = "bodySlotNeckBlessed";
                this.borderFooterMask = "none";
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.capacityFontStyle = "normal";
                this.paddingTop = 0;
                this.bodySlotBackBlessedStyle = "bodySlotBackBlessed";
                this.bodySlotBackStyle = "bodySlotBack";
                this.bodySlotHipStyle = "bodySlotHip";
                this.bodySlotTorsoBlessedStyle = "bodySlotTorsoBlessed";
                this.verticalGap = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.borderCenterCenterImage = _embed_css_images_Inventory_png_553308346;
                this.bodySlotRightHandStyle = "bodySlotRightHand";
                this.buttonStoreInboxStyle = "buttonStoreInbox";
                this.bodySlotHeadBlessedStyle = "bodySlotHeadBlessed";
                this.borderCenterMask = "all";
                this.bodySlotLeftHandStyle = "bodySlotLeftHand";
                this.capacityFontWeight = "bold";
                this.bodySlotHeadStyle = "bodySlotHead";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcAmountBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcAmountBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonEast");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonEast", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "right";
                this.defaultDownTopImage = "right";
                this.defaultDownMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "right";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotLegsBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotLegsBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryLegs_protected_png_720943931;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".containerPageLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".containerPageLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "left";
                this.defaultDisabledMask = "left";
                this.defaultDownMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultDisabledBottomImage = "right";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SelectOutfitWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SelectOutfitWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.outfitDialogOpenStoreButtonStyle = "outfitDialogOpenStoreButton";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelSkill");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelSkill", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.labelStyleName = ".statusWidgetSkillProgress";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetParallelBonusSkillProgress";
                this.verticalAlign = "middle";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetParallelSkillProgress";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderFold");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderFold", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "bottom";
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "bottom";
                this.defaultUpMask = "top";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "top";
                this.defaultDownMask = "top";
                this.defaultOverTopImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "top";
                this.selectedOverTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "top";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "bottom";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "bottom";
                this.selectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "bottom";
                this.defaultOverMask = "top";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.iconSelectedUpTopImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedUpBottomImage = "right";
                this.iconSelectedDownMask = "bottom";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.backgroundColor = "";
                this.rollOverColor = 2633265;
                this.textRollOverColor = 13221291;
                this.focusThickness = 0;
                this.selectionColor = 4936794;
                this.backgroundAlpha = 0.8;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.color = 13221291;
                this.alternatingItemColors = [1842980, 1842980];
                this.borderSkin = EmptySkin;
                this.selectionDuration = 0;
                this.selectionEasingFunction = "";
                this.paddingBottom = 2;
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelist");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelist", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.itemBackgroundColors = [2768716, 16711680];
                this.paddingTop = 0;
                this.itemRendererStyle = "battlelistWidgetView";
                this.itemBackgroundAlphas = [0.5, 0];
                this.itemVerticalGap = 0;
                this.itemHorizontalGap = 0;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetButtonIgnore");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetButtonIgnore", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ChatTabIgnore_over_png_757185043;
                this.defaultDownCenterImage = _embed_css_images_Button_ChatTabIgnore_pressed_png_449883375;
                this.defaultUpCenterImage = _embed_css_images_Button_ChatTabIgnore_idle_png_1042862317;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionConfigurationWidgetRootContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionConfigurationWidgetRootContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("WorldMapWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("WorldMapWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "center";
                this.borderSkin = BitmapBorderSkin;
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_Game_png_477087436;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetRootContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetRootContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 2240055;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonSouth");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonSouth", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "bottom";
                this.defaultDownTopImage = "right";
                this.defaultDownMask = "bottom";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "bottom";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcAmountSelector");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcAmountSelector", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 2;
                this.borderColor = 8089164;
                this.backgroundColor = 1977654;
                this.borderThickness = 1;
                this.verticalGap = 1;
                this.horizontalGap = 4;
                this.borderAlpha = 1;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetDefaultTabCloseButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetDefaultTabCloseButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ChatTab_Close_over_png_2020181768;
                this.defaultDownCenterImage = _embed_css_images_Button_ChatTab_Close_pressed_png_1103699684;
                this.defaultUpCenterImage = _embed_css_images_Button_ChatTab_Close_idle_png_596973064;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcTradeModeTabBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcTradeModeTabBar", style, false);
            }
            style = StyleManager.getStyleDeclaration(".spellListWidgetTabContent");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spellListWidgetTabContent", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".selectOutfitTabNavigator");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".selectOutfitTabNavigator", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 1;
                this.borderColor = 13415802;
                this.tabStyleName = "simpleTabNavigator";
                this.backgroundColor = 658961;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".selectOutfitLabel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".selectOutfitLabel", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.borderThickness = 1;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonUp");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonUp", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "top";
                this.defaultDownTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1598990274;
                this.defaultOverMask = "top";
                this.defaultUpBottomImage = "top";
                this.defaultUpTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_331481802;
                this.defaultDownMask = "top";
                this.defaultOverBottomImage = "top";
                this.defaultDownBottomImage = "top";
                this.defaultOverTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_536182326;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetIcons");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetIcons", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.iconStyleParallel = _embed_css_images_Icons_ProgressBars_ParallelStyle_png_905733223;
                this.iconStateSlow = _embed_css_images_Icons_Conditions_Slowed_png_613969280;
                this.iconStateFighting = _embed_css_images_Icons_Conditions_Logoutblock_png_821848109;
                this.iconStyleDefault = _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1682326431;
                this.iconStateStrengthened = _embed_css_images_Icons_Conditions_Strenghtened_png_1096277941;
                this.iconStateManaShield = _embed_css_images_Icons_Conditions_MagicShield_png_51896356;
                this.iconSkillFightClub = _embed_css_images_Icons_ProgressBars_ClubFighting_png_1329550823;
                this.iconStateBurning = _embed_css_images_Icons_Conditions_Burning_png_1686487037;
                this.iconStatePZBlock = _embed_css_images_Icons_Conditions_PZlock_png_1628388119;
                this.iconStateCursed = _embed_css_images_Icons_Conditions_Cursed_png_629458754;
                this.iconProgressOff = _embed_css_images_Icons_ProgressBars_ProgressOff_png_1579884353;
                this.iconStateFreezing = _embed_css_images_Icons_Conditions_Freezing_png_2037155332;
                this.iconSkillFightShield = _embed_css_images_Icons_ProgressBars_Shielding_png_940600668;
                this.iconSkillFightFist = _embed_css_images_Icons_ProgressBars_FistFighting_png_946071051;
                this.iconSkillMagLevel = _embed_css_images_Icons_ProgressBars_MagicLevel_png_886932366;
                this.iconStateDrunk = _embed_css_images_Icons_Conditions_Drunk_png_23604170;
                this.iconProgressOn = _embed_css_images_Icons_ProgressBars_ProgressOn_png_512828469;
                this.iconStateBleeding = _embed_css_images_Icons_Conditions_Bleeding_png_719748952;
                this.iconSkillFightAxe = _embed_css_images_Icons_ProgressBars_AxeFighting_png_865218367;
                this.iconStatePoisoned = _embed_css_images_Icons_Conditions_Poisoned_png_1941243675;
                this.iconStyleCompact = _embed_css_images_Icons_ProgressBars_CompactStyle_png_2100731363;
                this.iconStyleLarge = _embed_css_images_Icons_ProgressBars_LargeStyle_png_876439723;
                this.iconStateElectrified = _embed_css_images_Icons_Conditions_Electrified_png_1645251154;
                this.iconStateHungry = _embed_css_images_Icons_Conditions_Hungry_png_220632303;
                this.iconStateDrowning = _embed_css_images_Icons_Conditions_Drowning_png_265936470;
                this.iconSkillFightDistance = _embed_css_images_Icons_ProgressBars_DistanceFighting_png_846497374;
                this.iconStateFast = _embed_css_images_Icons_Conditions_Haste_png_380779077;
                this.iconStatePZEntered = _embed_css_images_Icons_Conditions_PZ_png_1992640810;
                this.iconSkillFightSword = _embed_css_images_Icons_ProgressBars_SwordFighting_png_924761898;
                this.iconStateDazzled = _embed_css_images_Icons_Conditions_Dazzled_png_1739263772;
                this.iconSkillFishing = _embed_css_images_Icons_ProgressBars_Fishing_png_157830983;
                this.iconSkillLevel = _embed_css_images_Icons_ProgressBars_ProgressOn_png_512828469;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("Sidebar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Sidebar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.paddingTop = 0;
                this.verticalGap = 2;
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonYellowHand");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonYellowHand", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_640104851;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_981288301;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_971915191;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_707321527;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_971915191;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_981288301;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".spellListWidgetTabBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spellListWidgetTabBar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tabStyleName = "spellListWidgetTab";
                this.tabWidth = 40;
                this.tabHeight = 23;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotFeetBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotFeetBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBoots_protected_png_810833177;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("TextInput");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextInput", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.borderThickness = 1;
                this.focusThickness = 0;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactBonusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactBonusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_944734739;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonOffensive");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonOffensive", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_36388793;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1849311559;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1582640445;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_322604605;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1582640445;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1849311559;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcCommitBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcCommitBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotFeet");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotFeet", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBoots_png_1925185108;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopHistoryCredits");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopHistoryCredits", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.borderSkin = EmptySkin;
                this.horizontalAlign = "right";
                this.verticalAlign = "middle";
                this.verticalGap = 0;
                this.paddingBottom = 0;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".embeddedDialogTitle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".embeddedDialogTitle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.fontSize = 11;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".withBackground");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".withBackground", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.highlightSkin = _embed_css_images_Slot_Statusicon_highlighted_png_1406275102;
                this.backgroundSkin = _embed_css_images_Slot_Statusicon_png_1343906902;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopCreditBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopCreditBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 13415802;
                this.paddingTop = 2;
                this.backgroundColor = 658961;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.borderAlpha = 1;
                this.verticalGap = 2;
                this.paddingLeft = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 2;
                this.borderThickness = 1;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("GridContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("GridContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalGap = 0;
                this.horizontalGap = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ActionButtonToolTip");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ActionButtonToolTip", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderColor = 13415802;
                this.color = 13221291;
                this.backgroundColor = 658961;
                this.borderSkin = VectorBorderSkin;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultMana");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultMana", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_411547495;
                this.rightOrnamentMask = "none";
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.barDefault = _embed_css_images_BarsHealth_default_Mana_png_1612234378;
                this.leftOrnamentMask = "left";
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_195008000;
                this.leftOrnamentLeftImage = "right";
                this.barImages = "barDefault";
                this.backgroundMask = "center";
                this.paddingLeft = 3;
                this.paddingRight = 1;
                this.leftOrnamentOffset = -5;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                this.rightOrnamentOffset = 5;
                this.barLimits = 0;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_active_png_510613324;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1214578473;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1260694341;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1805314658;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1260694341;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1214578473;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTabBarScrollLeftHighlight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTabBarScrollLeftHighlight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left";
                this.defaultUpMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1012163085;
                this.defaultDownMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1817970777;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1406544115;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.dividerThickness = 5;
                this.dividerBackgroundLeftImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420836441;
                this.dividerBackgroundMask = "left";
                this.dividerAffordance = 5;
                this.verticalGap = 0;
                this.horizontalGap = 5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotTorso");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotTorso", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryArmor_png_1976141778;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ComboBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ComboBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 13221291;
                this.borderThickness = 1;
                this.iconColor = 13221291;
                this.highlightAlphas = [0, 0];
                this.focusThickness = 0;
                this.fillColors = [4937051, 2501679];
                this.borderAlpha = 1;
                this.fillAlphas = [1, 1];
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("EmbeddedDialog");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("EmbeddedDialog", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.backgroundColor = 658961;
                this.contentBoxStyle = "embeddedDialogContentBox";
                this.titleStyle = "embeddedDialogTitle";
                this.titleBoxStyle = "embeddedDialogTitleBox";
                this.horizontalAlign = "center";
                this.verticalAlign = "top";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                this.buttonStyle = "";
                this.borderThickness = 1;
                this.textStyle = "embeddedDialogText";
                this.buttonBoxStyle = "embeddedDialogButtonBox";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonDown");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonDown", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "bottom";
                this.defaultDownTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1598990274;
                this.defaultOverMask = "bottom";
                this.defaultUpBottomImage = "top";
                this.defaultUpTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_331481802;
                this.defaultDownMask = "bottom";
                this.defaultOverBottomImage = "top";
                this.defaultDownBottomImage = "top";
                this.defaultOverTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_536182326;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarUnjustPoints");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarUnjustPoints", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_active_png_1940183455;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_759314308;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_411052018;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_idle_png_1425419057;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_411052018;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_759314308;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonZoomOut");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonZoomOut", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultOverMask = "center";
                this.defaultDownMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Minimap_ZoomOut_over_png_112502810;
                this.defaultDownCenterImage = _embed_css_images_Minimap_ZoomOut_pressed_png_1302018254;
                this.defaultUpCenterImage = _embed_css_images_Minimap_ZoomOut_idle_png_1686759142;
                this.skin = BitmapButtonSkin;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".messageOptionsMessageModeList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".messageOptionsMessageModeList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.alternatingItemAlphas = [0.8, 0];
                this.horizontalGridLines = false;
                this.backgroundColor = "";
                this.horizontalGridLineColor = 8089164;
                this.rollOverColor = 2768716;
                this.iconColor = 13221291;
                this.verticalGridLines = true;
                this.textRollOverColor = 13221291;
                this.borderAlpha = 1;
                this.selectionColor = 658961;
                this.verticalGridLineColor = 8089164;
                this.backgroundAlpha = 0.8;
                this.disabledIconColor = 13221291;
                this.color = 13221291;
                this.alternatingItemColors = [1977654, 16711680];
                this.selectionDuration = 0;
                this.borderThickness = 1;
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".getCoinsGoldStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".getCoinsGoldStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "left center right";
                this.icon = _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_382995454;
                this.defaultDownMask = "left center right";
                this.defaultOverRightImage = "left";
                this.defaultOverCenterImage = _embed_css_images_Button_Gold_tileable_over_png_1989275541;
                this.textRollOverColor = 16777215;
                this.defaultUpCenterImage = _embed_css_images_Button_Gold_tileable_idle_png_579625621;
                this.disabledColor = 16777215;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "left center right";
                this.defaultUpLeftImage = _embed_css_images_Button_Gold_tileable_end_idle_png_1097174497;
                this.color = 16777215;
                this.defaultOverLeftImage = _embed_css_images_Button_Gold_tileable_end_over_png_894104289;
                this.defaultDownCenterImage = _embed_css_images_Button_Gold_tileable_pressed_png_365071001;
                this.textSelectedColor = 16777215;
                this.defaultDownLeftImage = _embed_css_images_Button_Gold_tileable_end_pressed_png_1615409205;
                this.defaultDownRightImage = "left";
                this.defaultUpRightImage = "left";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("WidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("WidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderCenterTopRightImage = _embed_css_images_Border_Widget_corner_png_764128473;
                this.headerHeight = 19;
                this.headerLeft = 39;
                this.titleFontSize = 11;
                this.iconWidth = 23;
                this.borderFooterBottomImage = _embed_css_images_Widget_Footer_tileable_png_2100911011;
                this.borderFooterBottomLeftImage = _embed_css_images_Widget_Footer_tileable_end01_png_772758022;
                this.borderHeaderTop = 22;
                this.borderCenterBackgroundAlpha = 0.5;
                this.borderFooterMask = "bottomLeft bottom bottomRight";
                this.horizontalGap = 2;
                this.paddingTop = 2;
                this.footerVerticalAlign = "top";
                this.headerPaddingBottom = 0;
                this.paddingLeft = 2;
                this.footerLeft = 0;
                this.borderHeaderMask = "top";
                this.iconLeft = 2;
                this.footerPaddingBottom = 0;
                this.borderSkin = WidgetViewSkin;
                this.footerHeight = 10;
                this.footerHorizontalAlign = "left";
                this.headerWidth = 141;
                this.headerHorizontalGap = 1;
                this.borderHeaderTopImage = _embed_css_images_Widget_HeaderBG_png_532450703;
                this.borderFooterBottomRightImage = _embed_css_images_Widget_Footer_tileable_end02_png_765792891;
                this.iconTop = 2;
                this.closeButtonStyle = "widgetViewClose";
                this.iconHeight = 19;
                this.paddingBottom = 2;
                this.borderCenterRightImage = _embed_css_images_Border_Widget_png_668780695;
                this.borderCenterBackgroundColor = 1977654;
                this.headerTop = 2;
                this.footerPaddingTop = 0;
                this.footerPaddingRight = 0;
                this.collapseButtonStyle = "widgetViewCollapse";
                this.verticalGap = 2;
                this.headerPaddingLeft = 0;
                this.paddingRight = 2;
                this.headerHorizontalAlign = "center";
                this.headerPaddingRight = 0;
                this.headerPaddingTop = 0;
                this.headerVerticalAlign = "middle";
                this.footerWidth = 184;
                this.footerTop = 0;
                this.titleFontColor = 13221291;
                this.titleFontWeight = "normal";
                this.borderCenterMask = "all";
                this.footerPaddingLeft = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("HRule");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("HRule", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.strokeColor = 8089164;
                this.strokeWidth = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatBonusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatBonusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_944734739;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".popUpHeaderStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popUpHeaderStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 2;
                this.borderColor = 8089164;
                this.backgroundColor = 658961;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.backgroundAlpha = 0.5;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonMount");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonMount", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_Mounted_idle_png_1208800333;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_Mounted_over_png_323447629;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_Unmounted_over_png_1825691630;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1478391534;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_Unmounted_over_png_1825691630;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_Mounted_over_png_323447629;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTitle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTitle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1624887026;
                this.borderBottomImage = "top";
                this.horizontalAlign = "left";
                this.verticalAlign = "middle";
                this.verticalGap = 0;
                this.horizontalGap = 0;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetScrollRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetScrollRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "right";
                this.defaultDownTopImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_594657599;
                this.defaultDisabledLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "right";
                this.defaultUpTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1854948415;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_790429785;
                this.defaultUpMask = "right";
                this.paddingTop = 0;
                this.defaultDownMask = "right";
                this.defaultOverTopImage = "right";
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584211939;
                this.defaultDownLeftImage = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("OfferDetails");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("OfferDetails", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "normal";
                this.paddingTop = 6;
                this.verticalGap = 6;
                this.paddingBottom = 6;
                this.paddingLeft = 6;
                this.paddingRight = 6;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferRendererBoxEnabled");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferRendererBoxEnabled", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 7630671;
                this.backgroundColor = 1842980;
                this.borderSkin = VectorBorderSkin;
                this.borderThickness = 1;
                this.horizontalAlign = "center";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopNoButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopNoButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icons_IngameShop_12x12_No_png_754863577;
                this.paddingTop = 2;
                this.paddingBottom = 2;
                this.paddingLeft = 8;
                this.paddingRight = 8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultSkill");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultSkill", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.labelStyleName = ".statusWidgetSkillProgress";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetDefaultBonusSkillProgress";
                this.verticalAlign = "middle";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetDefaultSkillProgress";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("DividedBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DividedBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalDividerCursor = ResizeVerticalCursor;
                this.horizontalDividerCursor = ResizeHorizontalCursor;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferNew");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferNew", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 5046016;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonSecure");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonSecure", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_PvPOn_idle_png_252644152;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_PvPOn_active_png_1071084502;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_PvPOff_active_png_192388584;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_PvPOff_idle_png_1711575894;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_PvPOff_active_png_192388584;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_PvPOn_active_png_1071084502;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcObjectSelector");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcObjectSelector", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.infoBorderStyle = "solid";
                this.backgroundColor = "";
                this.slotHorizontalAlign = "center";
                this.backgroundAlpha = 0.5;
                this.infoBorderColor = 8089164;
                this.horizontalGap = 0;
                this.slotVerticalGap = 2;
                this.paddingBottom = 0;
                this.paddingTop = 0;
                this.alternatingItemAlphas = [0.5, 0.5];
                this.infoBorderAlpha = 1;
                this.slotHorizontalGap = 2;
                this.slotVerticalAlign = "middle";
                this.rollOverColor = "";
                this.selectionColor = "";
                this.verticalGap = 0;
                this.infoBackgroundAlpha = 0.5;
                this.paddingLeft = 0;
                this.slotPaddingRight = 0;
                this.slotPaddingBottom = 0;
                this.paddingRight = 0;
                this.slotPaddingLeft = 5;
                this.slotPaddingTop = 0;
                this.alternatingItemColors = [2768716, 1977654];
                this.infoBackgroundColor = 1977654;
                this.infoBorderThickness = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarTop");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarTop", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left topLeft top topRight right center";
                this.toggleButtonStyle = "actionBarWidgetToggleTop";
                this.scrollDownButtonStyle = "actionBarWidgetScrollLeft";
                this.scrollUpButtonStyle = "actionBarWidgetScrollRight";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("NPCTradeWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("NPCTradeWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.objectSelectorStyle = "npcObjectSelector";
                this.amountSelectorStyle = "npcAmountSelector";
                this.paddingTop = 0;
                this.tradeModeTabStyle = "npcTradeModeTab";
                this.errorColor = 16711680;
                this.tradeModeTabHeight = 23;
                this.summaryBoxStyle = "npcSummaryBox";
                this.tradeModeTabWidth = 40;
                this.tradeModeBoxStyle = "npcTradeModeBox";
                this.amountBoxStyle = "npcAmountBox";
                this.disabledColor = 13221291;
                this.tradeModeLayoutButtonStyle = "npcTradeButtonLayout";
                this.paddingLeft = 0;
                this.summaryFormStyle = "npcSummaryForm";
                this.paddingRight = 0;
                this.color = 13221291;
                this.objectBoxStyle = "npcObjectBox";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Trades_png_759837731;
                this.commitBoxStyle = "npcCommitBox";
                this.paddingBottom = 0;
                this.tradeModeTabBarStyle = "npcTradeModeTabBar";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetRightView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetRightView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarRightWithBorder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarRightWithBorder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left";
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420836441;
                this.paddingTop = 0;
                this.resizeCursorSkin = ResizeVerticalCursor;
                this.borderBackgroundAlpha = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderBackgroundColor = 0;
                this.verticalGap = 1;
                this.horizontalGap = 0;
                this.paddingLeft = 2;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default__png_715141111;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".nicklist");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".nicklist", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.itemVerticalGap = 0;
                this.itemHorizontalGap = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".simpleTabNavigator");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".simpleTabNavigator", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.defaultBorderAlpha = 1;
                this.selectedBackgroundColor = 658961;
                this.paddingLeft = 0;
                this.skin = VectorTabSkin;
                this.paddingRight = 0;
                this.defaultBackgroundColor = 2240055;
                this.defaultBackgroundAlpha = 0.5;
                this.defaultBorderThickness = 1;
                this.defaultBorderColor = 8089164;
                this.defaultTextColor = 15904590;
                this.selectedBorderColor = 13415802;
                this.selectedBorderThickness = 1;
                this.selectedTextColor = 13221291;
                this.paddingBottom = 0;
                this.selectedBorderAlpha = 1;
                this.selectedBackgroundAlpha = 0.5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetAmountDecrease");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetAmountDecrease", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left";
                this.defaultUpMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultDownMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonExpert");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonExpert", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_625811990;
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_152924109;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_2088825037;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_over_png_749704414;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1091888606;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_over_png_749704414;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_2088825037;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ObjectEditor");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ObjectEditor", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 13221291;
                this.errorColor = 13221291;
                this.textRollOverColor = 13221291;
                this.disabledColor = 13221291;
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetTabContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetTabContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotFingerBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotFingerBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryRing_protected_png_817340434;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarToggleLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarToggleLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "right";
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "left";
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.selectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "left";
                this.defaultUpMask = "right";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "right";
                this.defaultDownMask = "right";
                this.defaultOverTopImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.selectedOverTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "right";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "left";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "left";
                this.selectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "left";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.toggleButtonStyle = "sideBarToggleLeft";
                this.selectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.iconSelectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_1707327292;
                this.iconSelectedUpBottomImage = "right";
                this.iconSelectedDownMask = "left";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelMana");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelMana", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_411547495;
                this.rightOrnamentMask = "right";
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.barDefault = _embed_css_images_BarsHealth_default_Mana_png_1612234378;
                this.leftOrnamentMask = "left";
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_195008000;
                this.leftOrnamentLeftImage = "right";
                this.barImages = "barDefault";
                this.backgroundMask = "center";
                this.paddingLeft = 3;
                this.paddingRight = 3;
                this.leftOrnamentOffset = -5;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                this.rightOrnamentOffset = 5;
                this.barLimits = 0;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2098246457;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("FocusNotifier");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("FocusNotifier", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.modalTransparency = 0.5;
                this.fontWeight = "bold";
                this.modalTransparencyBlur = 0;
                this.color = 13120000;
                this.modalTransparencyDuration = 0;
                this.modalTransparencyColor = 1580578;
                this.fontSize = 18;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.overlayHighlightImage = _embed_css_images_slot_Hotkey_highlighted_png_2001599143;
                this.overlayDisabledImage = _embed_css_images_slot_Hotkey_disabled_png_196057824;
                this.paddingTop = 3;
                this.overlayCooldownImage = _embed_css_images_Slot_Hotkey_Cooldown_png_1214707955;
                this.backgroundImage = _embed_css_images_slot_Hotkey_png_884797115;
                this.overlayLabelColor = 16777215;
                this.backgroundLabelColor = 14277081;
                this.paddingLeft = 3;
                this.paddingBottom = 3;
                this.paddingRight = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".spellListWidgetViewToggle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spellListWidgetViewToggle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_820025018;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_over_png_546707386;
                this.defaultOverCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_998762331;
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1723628123;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1357302191;
                this.selectedDownCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_2110866166;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefault");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefault", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.hitpointsOffsetY = -1;
                this.manaOffsetX = 2;
                this.manaOffsetY = -1;
                this.hitpointsStyle = "statusWidgetDefaultHitpoints";
                this.stateStyle = "statusWidgetDefault";
                this.hitpointsOffsetX = -2;
                this.manaStyle = "statusWidgetDefaultMana";
                this.skillStyle = "statusWidgetDefaultSkill";
                this.verticalGap = 1;
                this.horizontalGap = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("MessageOptions");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("MessageOptions", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.messageModeListStyle = "messageOptionsMessageModeList";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcTradeModeBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcTradeModeBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1624887026;
                this.horizontalAlign = "left";
                this.verticalAlign = "middle";
                this.paddingLeft = 2;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".offerDarkBorder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".offerDarkBorder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 7630671;
                this.paddingTop = 2;
                this.backgroundColor = 658961;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.borderAlpha = 1;
                this.verticalGap = 2;
                this.backgroundAlpha = 0.5;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.borderThickness = 1;
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("GameWindowContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("GameWindowContainer", style, false);
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatHitpoints");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatHitpoints", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_fat_tileable_png_2059592705;
                this.rightOrnamentMask = "right";
                this.barGreenFull = _embed_css_images_BarsHealth_fat_GreenFull_png_1004610075;
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.leftOrnamentMask = "none";
                this.backgroundRightImage = _embed_css_images_BG_Bars_fat_enpiece_png_430241160;
                this.leftOrnamentLeftImage = "right";
                this.barGreenLow = _embed_css_images_BarsHealth_fat_GreenLow_png_560143288;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundMask = "center";
                this.paddingLeft = 1;
                this.paddingRight = 3;
                this.barRedFull = _embed_css_images_BarsHealth_fat_RedFull_png_1001083219;
                this.barRedLow2 = _embed_css_images_BarsHealth_fat_RedLow2_png_2111643698;
                this.leftOrnamentOffset = -6;
                this.barYellow = _embed_css_images_BarsHealth_fat_Yellow_png_1059668033;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153;
                this.rightOrnamentOffset = 6;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
                this.barRedLow = _embed_css_images_BarsHealth_fat_RedLow_png_767405462;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1203443153;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetFilter");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetFilter", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "none";
                this.borderColor = "";
                this.paddingTop = 2;
                this.backgroundColor = "";
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.borderAlpha = 0;
                this.verticalGap = 2;
                this.backgroundAlpha = 0;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.borderThickness = 0;
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarLeft");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarLeft", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left center";
                this.toggleButtonStyle = "actionBarWidgetToggleLeft";
                this.scrollDownButtonStyle = "actionBarWidgetScrollTop";
                this.scrollUpButtonStyle = "actionBarWidgetScrollBottom";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ToolTip");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ToolTip", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderColor = 13415802;
                this.color = 13221291;
                this.backgroundColor = 658961;
                this.borderSkin = VectorBorderSkin;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetToggleTop");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetToggleTop", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "top";
                this.borderLeft = 0;
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.borderRight = 0;
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "top";
                this.defaultUpMask = "bottom";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "bottom";
                this.defaultDownMask = "bottom";
                this.defaultOverTopImage = "right";
                this.borderBottom = 0;
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.borderTop = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "bottom";
                this.selectedOverTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "bottom";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "top";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "top";
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "top";
                this.defaultOverMask = "bottom";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.iconSelectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.iconSelectedUpBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownMask = "top";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".spellListWidgetTab");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spellListWidgetTab", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.paddingTop = 0;
                this.selectedUpCenterImage = _embed_css_images_BuySellTab_active_png_860073354;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_BuySellTab_active_png_860073354;
                this.defaultOverCenterImage = _embed_css_images_BuySellTab_idle_png_1611782140;
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_BuySellTab_idle_png_1611782140;
                this.paddingLeft = 2;
                this.skin = BitmapButtonSkin;
                this.paddingRight = 2;
                this.defaultOverMask = "center";
                this.textAlign = "center";
                this.defaultDownCenterImage = _embed_css_images_BuySellTab_idle_png_1611782140;
                this.defaultTextColor = 15904590;
                this.selectedTextColor = 15904590;
                this.paddingBottom = 0;
                this.selectedDownCenterImage = _embed_css_images_BuySellTab_active_png_860073354;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SpellTileRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SpellTileRenderer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                this.verticalGap = 0;
                this.horizontalGap = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotHeadBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotHeadBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryHead_protected_png_893284254;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".customSliderIncreaseButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".customSliderIncreaseButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "right";
                this.defaultUpMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.defaultDownMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultDownLeftImage = "right";
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".selectOutfitNext");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".selectOutfitNext", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "right";
                this.defaultUpMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultDownMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".hotkeyOptionsSetScrollRight");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".hotkeyOptionsSetScrollRight", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "right";
                this.defaultUpMask = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultDownMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.paddingTop = 0;
                this.borderColor = 13415802;
                this.backgroundColor = 1842980;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcTradeWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcTradeWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.overlayHighlightImage = _embed_css_images_slot_container_highlighted_png_1493388964;
                this.overlayDisabledImage = _embed_css_images_slot_container_disabled_png_1480414781;
                this.paddingTop = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_2109452872;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".miniMapButtonWest");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".miniMapButtonWest", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "left";
                this.defaultDownTopImage = "right";
                this.defaultDownMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.defaultOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "left";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".invisibleDivider");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".invisibleDivider", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.dividerThickness = 0;
                this.dividerAffordance = 0;
                this.verticalGap = 0;
                this.horizontalGap = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactMana");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactMana", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_compact_tileable_png_1510304069;
                this.rightOrnamentMask = "none";
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.barDefault = _embed_css_images_BarsHealth_compact_Mana_png_1911706548;
                this.leftOrnamentMask = "left";
                this.backgroundRightImage = _embed_css_images_BG_Bars_compact_enpiece_png_1794070574;
                this.leftOrnamentLeftImage = "right";
                this.barImages = "barDefault";
                this.backgroundMask = "center";
                this.paddingLeft = 3;
                this.paddingRight = 1;
                this.leftOrnamentOffset = -6;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673;
                this.rightOrnamentOffset = 6;
                this.barLimits = 0;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".embeddedDialogText");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".embeddedDialogText", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "normal";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SideBarWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SideBarWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "none";
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420836441;
                this.paddingTop = 0;
                this.resizeCursorSkin = ResizeVerticalCursor;
                this.borderBackgroundAlpha = 0;
                this.borderSkin = BitmapBorderSkin;
                this.borderBackgroundColor = 0;
                this.verticalGap = 1;
                this.horizontalGap = 0;
                this.paddingLeft = 2;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".popUpTitleStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popUpTitleStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.color = 13221291;
                this.fontSize = 12;
                this.paddingRight = 8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderBody");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderBody", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_active_png_245174782;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_877580159;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_814210095;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1924166356;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_814210095;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_877580159;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".customSliderDecreaseButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".customSliderDecreaseButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "left";
                this.defaultUpMask = "left";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_68165687;
                this.defaultDownMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultOverMask = "left";
                this.defaultUpLeftImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_603472387;
                this.defaultDownLeftImage = "right";
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_1489600823;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonChase");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonChase", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636131991;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_823465367;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_StandOff_over_png_145107486;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_StandOff_idle_png_1424152862;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_StandOff_over_png_145107486;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_823465367;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".validationFeedbackValid");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".validationFeedbackValid", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SpellIconRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SpellIconRenderer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 1;
                this.overlayUnavailableImage = _embed_css_images_slot_container_disabled_png_1480414781;
                this.backgroundImage = _embed_css_images_slot_container_png_2109452872;
                this.overlaySelectedImage = _embed_css_images_slot_container_highlighted_png_1493388964;
                this.paddingLeft = 1;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".storeConfirmation");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".storeConfirmation", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.paddingTop = 2;
                this.color = 13684944;
                this.textAlign = "center";
                this.fontStyle = "normal";
                this.fontFamily = "Verdana";
                this.fontSize = 9;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTabBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTabBar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.scrollRightButtonHighlightStyle = "chatWidgetTabBarScrollRightHighlight";
                this.scrollLeftButtonStyle = "chatWidgetTabBarScrollLeft";
                this.scrollLeftButtonHighlightStyle = "chatWidgetTabBarScrollLeftHighlight";
                this.navItemStyle = "chatWidgetDefaultTab";
                this.dropDownButtonStyle = "chatWidgetTabBarDropDown";
                this.scrollRightButtonStyle = "chatWidgetTabBarScrollRight";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1611106463;
                this.paddingTop = 3;
                this.tickMask = "center";
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1606415382;
                this.barDefault = _embed_css_images_BarsXP_default__png_715141111;
                this.backgroundRightImage = "left";
                this.backgroundMask = "left center right";
                this.barImages = "barDefault";
                this.paddingLeft = -5;
                this.paddingRight = -5;
                this.barLimits = 0;
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1430413740;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".marketWidgetOffers");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".marketWidgetOffers", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 8089164;
                this.alternatingItemAlphas = [0.8, 0];
                this.horizontalGridLines = false;
                this.backgroundColor = "";
                this.horizontalGridLineColor = 8089164;
                this.rollOverColor = 2768716;
                this.iconColor = 13221291;
                this.verticalGridLines = true;
                this.textRollOverColor = 13221291;
                this.borderAlpha = 1;
                this.selectionColor = 658961;
                this.verticalGridLineColor = 8089164;
                this.backgroundAlpha = 0.8;
                this.disabledIconColor = 13221291;
                this.color = 13221291;
                this.alternatingItemColors = [1977654, 16711680];
                this.selectionDuration = 0;
                this.borderThickness = 1;
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("PremiumWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("PremiumWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 13221291;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_GetPremium_png_582604369;
                this.borderFooterMask = "none";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotHead");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotHead", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryHead_png_1095562647;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CustomList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CustomList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.alternatingItemAlphas = [0.8, 0.8];
                this.backgroundColor = "";
                this.rollOverColor = 2633265;
                this.textRollOverColor = 13221291;
                this.focusThickness = 0;
                this.selectionColor = 4936794;
                this.backgroundAlpha = 0.8;
                this.color = 13221291;
                this.alternatingItemColors = [658961, 658961];
                this.borderSkin = EmptySkin;
                this.selectionDuration = 0;
                this.selectionEasingFunction = "";
                this.textSelectedColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderCombat");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderCombat", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_active_png_390746770;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1061435765;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1398862963;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1464650688;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1398862963;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1061435765;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarWidgetToggleBottom");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarWidgetToggleBottom", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDownTopImage = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.iconDefaultOverBottomImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpMask = "bottom";
                this.borderLeft = 0;
                this.selectedOverLeftImage = "right";
                this.skin = BitmapButtonSkin;
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultUpTopImage = "right";
                this.iconDefaultDownTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultDownBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.iconSelectedOverBottomImage = "right";
                this.borderRight = 0;
                this.iconDefaultOverLeftImage = "right";
                this.iconSelectedOverMask = "bottom";
                this.defaultUpMask = "top";
                this.paddingTop = 0;
                this.iconDefaultOverMask = "top";
                this.defaultDownMask = "top";
                this.defaultOverTopImage = "right";
                this.borderBottom = 0;
                this.iconSelectedDownTopImage = "right";
                this.selectedDownBottomImage = "right";
                this.paddingLeft = 0;
                this.borderTop = 0;
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "top";
                this.selectedOverTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconDefaultDownMask = "top";
                this.selectedUpBottomImage = "right";
                this.selectedDownLeftImage = "right";
                this.iconDefaultDownLeftImage = "right";
                this.selectedDownMask = "bottom";
                this.selectedDownTopImage = "right";
                this.selectedOverMask = "bottom";
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownBottomImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedUpMask = "bottom";
                this.defaultOverMask = "top";
                this.defaultUpLeftImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.paddingBottom = 0;
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.icon = BitmapButtonIcon;
                this.iconDefaultUpTopImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconDefaultUpBottomImage = "right";
                this.paddingRight = 0;
                this.defaultUpBottomImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                this.iconSelectedUpTopImage = "right";
                this.iconSelectedUpLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.iconSelectedOverLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.iconSelectedUpBottomImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_624147030;
                this.iconSelectedDownMask = "bottom";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("CheckBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CheckBox", style, false);
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetTabBarDropDown");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetTabBarDropDown", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "bottom";
                this.defaultDisabledMask = "bottom";
                this.defaultDownMask = "bottom";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1724638544;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledLeftImage = "right";
                this.defaultUpBottom = 11;
                this.defaultOverMask = "bottom";
                this.defaultDisabledBottomImage = "right";
                this.defaultUpBottomImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverBottom = 11;
                this.defaultDisabledBottom = 11;
                this.defaultOverLeftImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultOverBottomImage = "right";
                this.defaultDownBottom = 11;
                this.defaultDownLeftImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_233294932;
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_1139001352;
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2072068688;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".optionsConfigurationWidgetTabContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".optionsConfigurationWidgetTabContainer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "bold";
                this.fontColor = 16777215;
                this.fontStyle = "normal";
                this.fontFamily = "Verdana";
                this.fontSize = 10;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ActionBarWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ActionBarWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderRightImage = _embed_css_images_Border02_png_653295686;
                this.paddingTop = 2;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_1814375145;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 2;
                this.horizontalGap = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_Game_png_477087436;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("Container");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Container", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.focusThickness = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcObjectBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcObjectBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".popupDialogHeaderFooter");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popupDialogHeaderFooter", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 7630671;
                this.paddingTop = 2;
                this.backgroundColor = 658961;
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.borderAlpha = 1;
                this.verticalGap = 2;
                this.backgroundAlpha = 0.5;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.borderThickness = 1;
                this.horizontalGap = 15;
                this.paddingBottom = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcTradeButtonLayout");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcTradeButtonLayout", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_820025018;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_over_png_546707386;
                this.defaultOverCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_998762331;
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1723628123;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1357302191;
                this.selectedDownCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_2110866166;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".battlelistContent");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".battlelistContent", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 2;
                this.paddingLeft = 2;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".expandButtonPremiumTriggered");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".expandButtonPremiumTriggered", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.selectedUpCenterImage = _embed_css_images_Button_MaximizePremium_idle_png_1413812249;
                this.selectedDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Button_MaximizePremium_over_png_200837401;
                this.selectedUpMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Button_Maximize_pressed_png_878790694;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopCategories");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopCategories", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.alternatingItemColors = [1842980, 2174521];
                this.paddintTop = 0;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".actionBarBottom");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".actionBarBottom", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderMask = "left bottomLeft bottom bottomRight right center";
                this.toggleButtonStyle = "actionBarWidgetToggleBottom";
                this.scrollDownButtonStyle = "actionBarWidgetScrollLeft";
                this.scrollUpButtonStyle = "actionBarWidgetScrollRight";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotLegs");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotLegs", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryLegs_png_1771204248;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("Text");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Text", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "solid";
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.borderThickness = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ContainerViewWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ContainerViewWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.pageLeftButtonStyle = "containerPageLeft";
                this.slotVerticalAlign = "middle";
                this.slotHorizontalGap = 2;
                this.pageRightButtonStyle = "containerPageRight";
                this.slotHorizontalAlign = "center";
                this.verticalGap = 2;
                this.pageFooterStyle = "containerPageFooter";
                this.slotPaddingBottom = 0;
                this.slotPaddingRight = 0;
                this.paddingRight = 1;
                this.slotPaddingLeft = 5;
                this.slotPaddingTop = 0;
                this.upButtonStyle = "containerWigdetViewUp";
                this.horizontalGap = 2;
                this.slotVerticalGap = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".sideBarHeaderBattlelist");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarHeaderBattlelist", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_active_png_660047056;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_248709373;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_535957073;
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767895794;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_535957073;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_248709373;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".npcTradeModeTab");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".npcTradeModeTab", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.paddingTop = 0;
                this.selectedUpCenterImage = _embed_css_images_BuySellTab_active_png_860073354;
                this.selectedDownMask = "center";
                this.errorColor = 15904590;
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_BuySellTab_active_png_860073354;
                this.defaultOverCenterImage = _embed_css_images_BuySellTab_idle_png_1611782140;
                this.selectedUpMask = "center";
                this.textRollOverColor = 15904590;
                this.defaultUpCenterImage = _embed_css_images_BuySellTab_idle_png_1611782140;
                this.disabledColor = 15904590;
                this.paddingLeft = 4;
                this.skin = BitmapButtonSkin;
                this.paddingRight = 4;
                this.defaultOverMask = "center";
                this.color = 15904590;
                this.textAlign = "center";
                this.defaultDownCenterImage = _embed_css_images_BuySellTab_idle_png_1611782140;
                this.paddingBottom = 0;
                this.textSelectedColor = 15904590;
                this.selectedDownCenterImage = _embed_css_images_BuySellTab_active_png_860073354;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("DragManager");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DragManager", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.copyCursor = DragCopyCursor;
                this.moveCursor = DragMoveCursor;
                this.rejectCursor = DragNoneCursor;
                this.linkCursor = DragLinkCursor;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ingameShopOfferLastChance");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ingameShopOfferLastChance", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 38143;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactHitpoints");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactHitpoints", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundCenterImage = _embed_css_images_BG_Bars_compact_tileable_png_1510304069;
                this.rightOrnamentMask = "right";
                this.barGreenFull = _embed_css_images_BarsHealth_compact_GreenFull_png_220598049;
                this.paddingTop = 1;
                this.backgroundLeftImage = "right";
                this.leftOrnamentMask = "none";
                this.backgroundRightImage = _embed_css_images_BG_Bars_compact_enpiece_png_1794070574;
                this.leftOrnamentLeftImage = "right";
                this.barGreenLow = _embed_css_images_BarsHealth_compact_GreenLow_png_1297750638;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundMask = "center";
                this.paddingLeft = 1;
                this.paddingRight = 3;
                this.barRedFull = _embed_css_images_BarsHealth_compact_RedFull_png_1716395667;
                this.barRedLow2 = _embed_css_images_BarsHealth_compact_RedLow2_png_660179048;
                this.leftOrnamentOffset = -6;
                this.barYellow = _embed_css_images_BarsHealth_compact_Yellow_png_1621758843;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673;
                this.rightOrnamentOffset = 6;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
                this.barRedLow = _embed_css_images_BarsHealth_compact_RedLow_png_695116672;
                this.paddingBottom = 3;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_787561673;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".combatButtonWhiteHand");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".combatButtonWhiteHand", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.defaultDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1632903030;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1964355702;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1421479100;
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_542673852;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1421479100;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1964355702;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotFinger");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotFinger", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryRing_png_670392057;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ShopReponseWidget");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ShopReponseWidget", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.minimumButtonWidth = 60;
                this.buttonCancelStyle = "ingameShopNoButton";
                this.informationColor = 4286945;
                this.buttonNoStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("SpellListWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SpellListWidgetView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Spells_png_583290679;
                this.verticalGap = 0;
                this.horizontalGap = 0;
                this.paddingLeft = 0;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".widgetViewCollapse");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".widgetViewCollapse", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultDisabledMask = "center";
                this.defaultUpMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Button_Minimize_idle_png_1856333664;
                this.selectedUpCenterImage = _embed_css_images_Button_Maximize_idle_png_481005166;
                this.selectedDownMask = "center";
                this.defaultDownMask = "center";
                this.selectedOverMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Button_Maximize_over_png_1318781074;
                this.selectedUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_Minimize_over_png_2097489824;
                this.defaultUpCenterImage = _embed_css_images_Button_Minimize_idle_png_1856333664;
                this.skin = BitmapButtonSkin;
                this.defaultOverMask = "center";
                this.selectedDisabledCenterImage = _embed_css_images_Button_Maximize_idle_png_481005166;
                this.defaultDownCenterImage = _embed_css_images_Button_Minimize_pressed_png_1954633012;
                this.selectedDisabledMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Button_Maximize_pressed_png_878790694;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("HotkeyOptions");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("HotkeyOptions", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.setScrollLeftStyle = "hotkeyOptionsSetScrollLeft";
                this.setTextInputStyle = "hotkeyOptionsSetTextInput";
                this.mappingListStyle = "hotkeyOptionsMappingList";
                this.setScrollRightStyle = "hotkeyOptionsSetScrollRight";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotHip");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotHip", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryAmmo_png_1347869915;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".bodySlotNeckBlessed");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".bodySlotNeckBlessed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_872375520;
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryNecklace_protected_png_1321263128;
                return;
            }// end function
            ;
            }
            var _loc_2:* = StyleManager;
            _loc_2.mx_internal::initProtoChainRoots();
            return;
        }// end function

        protected function onGameWindowResize(event:ResizeEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null && !this.m_ForceDisableGameWindowSizeCalc)
            {
                _loc_2 = this.m_UIGameWindow.height;
                _loc_3 = this.m_UIChatWidget.height;
                if (this.options.generalUIGameWindowHeight > 0.01 && this.options.generalUIGameWindowHeight < 99.99)
                {
                    this.options.generalUIGameWindowHeight = _loc_2 * 100 / (_loc_2 + _loc_3);
                }
            }
            this.m_ForceDisableGameWindowSizeCalc = false;
            return;
        }// end function

        public function get m_UIActionBarLeft() : VActionBarWidget
        {
            return this._1174474338m_UIActionBarLeft;
        }// end function

        private function _Tibia_Array1_i() : Array
        {
            var _loc_1:* = [undefined, undefined];
            this._Tibia_Array1 = _loc_1;
            BindingManager.executeBindings(this, "_Tibia_Array1", this._Tibia_Array1);
            return _loc_1;
        }// end function

        public function setSessionKey(param1:String) : void
        {
            this.m_SessionKey = param1;
            return;
        }// end function

        protected function onPreinitialise(event:FlexEvent) : void
        {
            this.m_AppearanceStorage = ApperanceStorageFactory.s_CreateAppearanceStorage();
            this.m_AppearanceStorage.addEventListener(Event.COMPLETE, this.onAppearancesLoadComplete);
            this.m_AppearanceStorage.addEventListener(ErrorEvent.ERROR, this.onAppearancesLoadError);
            this.addEventListener(ConnectionEvent.CREATED, this.onConnectionCreated);
            this.m_ChatStorage = new ChatStorage();
            this.m_ChannelsPending = new Vector.<int>;
            this.m_ContainerStorage = new ContainerStorage();
            this.m_MiniMapStorage = new MiniMapStorage();
            this.m_SpellStorage = new SpellStorage();
            this.m_WorldMapStorage = new WorldMapStorage();
            this.m_UIEffectsManager = new UIEffectsManager();
            this.m_SeconaryTimer = new Timer(50);
            this.m_SeconaryTimer.addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            this.m_SeconaryTimer.start();
            return;
        }// end function

        public function __m_UICenterColumn_dividerRelease(event:DividerEvent) : void
        {
            this.onDividerRelease(event);
            return;
        }// end function

        public function get m_UIActionBarBottom() : HActionBarWidget
        {
            return this._629924354m_UIActionBarBottom;
        }// end function

        public function initializeGameClient(param1:Boolean, param2:Object = null) : void
        {
            this.m_TutorialMode = param1;
            this.m_TutorialData = param2;
            if (this.m_TutorialMode)
            {
                this.m_GameActionFactory = new SessiondumpHintsGameActionFactory();
            }
            else
            {
                this.m_GameActionFactory = new GameActionFactory();
            }
            s_InternalTibiaTimerFactor = 1;
            return;
        }// end function

        public function __m_UIGameWindow_resize(event:ResizeEvent) : void
        {
            this.onGameWindowResize(event);
            return;
        }// end function

        protected function onApplicationComplete(event:FlexEvent) : void
        {
            ToolTipManager.showDelay = 750;
            ToolTipManager.scrubDelay = 0;
            stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 100;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.showDefaultContextMenu = false;
            if (this.m_UICenterColumn != null && this.m_UICenterColumn.numDividers > 0 && this.m_UICenterColumn.getDividerAt(0) != null)
            {
                this.m_UICenterColumn.getDividerAt(0).doubleClickEnabled = true;
                this.m_UICenterColumn.getDividerAt(0).addEventListener(MouseEvent.DOUBLE_CLICK, this.onGameWindowAutofit);
            }
            if (this.isActive == false)
            {
                FocusNotifier.getInstance().captureMouse = true;
                FocusNotifier.getInstance().show();
            }
            return;
        }// end function

        public function ___Tibia_Application1_deactivate(event:Event) : void
        {
            this.onActivation(event);
            return;
        }// end function

        private function updateCombatTactics() : void
        {
            if (this.m_Communication != null && this.m_Communication.isGameRunning && this.m_Options != null)
            {
                this.m_Communication.sendCSETTACTICS(this.m_Options.combatAttackMode, this.m_Options.combatChaseMode, this.m_Options.combatSecureMode, this.m_Options.combatPVPMode);
            }
            return;
        }// end function

        public function ___Tibia_Application1_applicationComplete(event:FlexEvent) : void
        {
            this.onApplicationComplete(event);
            return;
        }// end function

        protected function reloadClient(param1:AccountCharacter = null, param2:String = null) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = null;
            if (param2 != null && param2.length > 0)
            {
                _loc_3 = new URLRequest(param2);
            }
            else
            {
                _loc_3 = new URLRequest(URLHelper.s_GetBrowserCurrentUrl());
            }
            if (param1 != null)
            {
                _loc_4 = URLHelper.s_GetBrowserCurrentBaseUrl();
                if (param2 != null)
                {
                    _loc_4 = param2;
                }
                _loc_5 = URLHelper.s_GetBrowserCurrentQuerystring();
                _loc_6 = new URLVariables(_loc_5);
                _loc_3 = new URLRequest(_loc_4);
                _loc_6.name = param1.name;
                _loc_3.data = _loc_6;
            }
            navigateToURL(_loc_3, "_self");
            return;
        }// end function

        private function updateGameWindowSize() : void
        {
            var _loc_1:* = NaN;
            if (this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null)
            {
                _loc_1 = this.options.generalUIGameWindowHeight;
                if (Math.abs(this.m_UIGameWindow.percentHeight - _loc_1) > 0.01)
                {
                    this.m_ForceDisableGameWindowSizeCalc = true;
                }
                this.m_UIGameWindow.percentHeight = _loc_1;
                this.m_UIChatWidget.percentHeight = 100 - _loc_1;
            }
            return;
        }// end function

        private function loadOptions() : void
        {
            if (this.options == null)
            {
                this.options = new OptionsStorage(this.m_DefaultOptionsAsset == null ? (null) : (this.m_DefaultOptionsAsset.xml), this.m_CurrentOptionsAsset == null ? (null) : (this.m_CurrentOptionsAsset.xml));
            }
            return;
        }// end function

        private function onConnectionLoginWait(event:ConnectionEvent) : void
        {
            visible = false;
            this.saveLocalData();
            this.saveOptions();
            var _loc_2:* = new LoginWaitWidget();
            _loc_2.message = event.message;
            _loc_2.timeout = Number(event.data);
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onCloseLoginWait);
            _loc_2.show();
            return;
        }// end function

        private function onConnectionLost(event:ConnectionEvent) : void
        {
            this.saveLocalData();
            this.saveOptions();
            this.m_ConnectionLostDialog = new ConnectionLostWidget();
            this.m_ConnectionLostDialog.timeout = Number(60 * 1000);
            this.m_ConnectionLostDialog.addEventListener(CloseEvent.CLOSE, this.onCloseConnectionLostDialog);
            this.m_ConnectionLostDialog.show();
            return;
        }// end function

        protected function onGameWindowAutofit(event:MouseEvent) : void
        {
            this.autofitGameWindow();
            return;
        }// end function

        private function setCurrentOptionsFromAssets(param1:IAssetProvider) : void
        {
            if (this.m_CurrentOptionsAsset != null)
            {
                this.m_CurrentOptionsAsset.removeEventListener(Event.COMPLETE, this.onUploadOptionsComplete);
                this.m_CurrentOptionsAsset.removeEventListener(ErrorEvent.ERROR, this.onUploadOptionsError);
                this.m_CurrentOptionsAsset.removeEventListener(IOErrorEvent.IO_ERROR, this.onUploadOptionsError);
                this.m_CurrentOptionsAsset.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onUploadOptionsError);
            }
            this.m_CurrentOptionsAsset = this.m_AssetProvider.getCurrentOptions();
            this.m_CurrentOptionsDirty = false;
            this.m_CurrentOptionsLastUpload = 0;
            this.m_CurrentOptionsUploading = false;
            if (this.m_CurrentOptionsAsset != null)
            {
                this.m_CurrentOptionsAsset.addEventListener(Event.COMPLETE, this.onUploadOptionsComplete);
                this.m_CurrentOptionsAsset.addEventListener(ErrorEvent.ERROR, this.onUploadOptionsError);
                this.m_CurrentOptionsAsset.addEventListener(IOErrorEvent.IO_ERROR, this.onUploadOptionsError);
                this.m_CurrentOptionsAsset.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onUploadOptionsError);
                param1.removeAsset(this.m_CurrentOptionsAsset);
            }
            return;
        }// end function

        public function set m_UIActionBarLeft(param1:VActionBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1174474338m_UIActionBarLeft;
            if (_loc_2 !== param1)
            {
                this._1174474338m_UIActionBarLeft = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIActionBarLeft", _loc_2, param1));
            }
            return;
        }// end function

        public function set m_UITibiaRootContainer(param1:HBox) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1020379552m_UITibiaRootContainer;
            if (_loc_2 !== param1)
            {
                this._1020379552m_UITibiaRootContainer = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UITibiaRootContainer", _loc_2, param1));
            }
            return;
        }// end function

        private function _Tibia_HActionBarWidget2_i() : HActionBarWidget
        {
            var _loc_1:* = new HActionBarWidget();
            this.m_UIActionBarBottom = _loc_1;
            _loc_1.styleName = "actionBarBottom";
            _loc_1.id = "m_UIActionBarBottom";
            BindingManager.executeBindings(this, "m_UIActionBarBottom", this.m_UIActionBarBottom);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get m_UIOuterRootContainer() : DividedBox
        {
            return this._1568861366m_UIOuterRootContainer;
        }// end function

        private function onConnectionLoginAdvice(event:ConnectionEvent) : void
        {
            visible = false;
            var _loc_2:* = new MessageWidget();
            _loc_2.buttonFlags = PopUpBase.BUTTON_OKAY;
            _loc_2.keyboardFlags = PopUpBase.KEY_ENTER;
            _loc_2.message = resourceManager.getString(BUNDLE, "DLG_LOGINADVICE_TEXT", [event.message]);
            _loc_2.priority = PopUpBase.DEFAULT_PRIORITY + 1;
            _loc_2.title = resourceManager.getString(BUNDLE, "DLG_LOGINADVICE_TITLE");
            _loc_2.show();
            return;
        }// end function

        public function get m_UIActionBarRight() : VActionBarWidget
        {
            return this._2043305115m_UIActionBarRight;
        }// end function

        private function onConnectionRecovered(event:ConnectionEvent) : void
        {
            this.m_ConnectionLostDialog.hide();
            return;
        }// end function

        override public function initialize() : void
        {
            var target:Tibia;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Tibia_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_TibiaWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = (i + 1);
            }
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
            return;
        }// end function

        protected function transferToLiveServer(param1:String) : void
        {
            var _loc_4:* = null;
            if (!this.m_TutorialMode)
            {
                throw new IllegalOperationError("Tibia.transferToLiveServer: Must be in tutorial mode");
            }
            var _loc_2:* = -1;
            var _loc_3:* = 0;
            while (_loc_3 < (this.m_ConnectionDataList.length - 1))
            {
                
                _loc_4 = this.m_ConnectionDataList[_loc_3] as AccountCharacter;
                if (_loc_4 != null && _loc_4.name == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
                _loc_3++;
            }
            if (_loc_2 > -1)
            {
                this.initializeGameClient(false);
                this.setConnectionDataList(this.m_ConnectionDataList, _loc_2);
                this.loginCharacter();
                this.setCurrentOptionsFromAssets(this.m_AssetProvider);
                this.m_DefaultOptionsAsset = this.m_AssetProvider.getDefaultOptions();
                if (this.m_DefaultOptionsAsset != null)
                {
                    this.m_AssetProvider.removeAsset(this.m_DefaultOptionsAsset);
                }
                this.options = null;
                this.loadOptions();
            }
            else
            {
                throw new ArgumentError("No ConnectionData found for character " + param1);
            }
            return;
        }// end function

        private function _Tibia_VActionBarWidget2_i() : VActionBarWidget
        {
            var _loc_1:* = new VActionBarWidget();
            this.m_UIActionBarRight = _loc_1;
            _loc_1.styleName = "actionBarRight";
            _loc_1.id = "m_UIActionBarRight";
            BindingManager.executeBindings(this, "m_UIActionBarRight", this.m_UIActionBarRight);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Tibia_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = BoxDirection.VERTICAL;
            _loc_1 = SideBarSet.LOCATION_A;
            _loc_1 = SideBarSet.LOCATION_B;
            _loc_1 = SideBarSet.LOCATION_B;
            _loc_1 = SideBarSet.LOCATION_A;
            _loc_1 = BoxDirection.VERTICAL;
            _loc_1 = ActionBarSet.LOCATION_TOP;
            _loc_1 = ActionBarSet.LOCATION_BOTTOM;
            _loc_1 = ActionBarSet.LOCATION_LEFT;
            _loc_1 = ActionBarSet.LOCATION_RIGHT;
            _loc_1 = SideBarSet.LOCATION_C;
            _loc_1 = SideBarSet.LOCATION_D;
            _loc_1 = SideBarSet.LOCATION_C;
            _loc_1 = SideBarSet.LOCATION_D;
            return;
        }// end function

        private function onCloseConnectionLostDialog(event:CloseEvent) : void
        {
            if (event.detail == PopUpBase.BUTTON_ABORT || event.detail == TimeoutWaitWidget.TIMOUT_EXPIRED)
            {
                this.m_ConnectionDataPending = -1;
                this.m_Communication.disconnect(true);
            }
            return;
        }// end function

        public function set m_UIActionBarBottom(param1:HActionBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._629924354m_UIActionBarBottom;
            if (_loc_2 !== param1)
            {
                this._629924354m_UIActionBarBottom = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIActionBarBottom", _loc_2, param1));
            }
            return;
        }// end function

        public function ___Tibia_Application1_activate(event:Event) : void
        {
            this.onActivation(event);
            return;
        }// end function

        public function autofitGameWindow() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            if (this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null && this.m_UIWorldMapWidget)
            {
                _loc_1 = this.m_UIGameWindow.height + this.m_UIChatWidget.height;
                _loc_2 = this.m_UIGameWindow.width;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = null;
                _loc_6 = null;
                var _loc_8:* = this.m_UIGameWindow;
                _loc_5 = this.m_UIGameWindow;
                if (_loc_8 != null)
                {
                    var _loc_8:* = _loc_5.top;
                    _loc_6 = _loc_5.top;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_3 = _loc_3 + _loc_6.getExplicitOrMeasuredHeight();
                    }
                    var _loc_8:* = _loc_5.bottom;
                    _loc_6 = _loc_5.bottom;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_3 = _loc_3 + _loc_6.getExplicitOrMeasuredHeight();
                    }
                    var _loc_8:* = _loc_5.left;
                    _loc_6 = _loc_5.left;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_4 = _loc_4 + _loc_6.getExplicitOrMeasuredWidth();
                    }
                    var _loc_8:* = _loc_5.right;
                    _loc_6 = _loc_5.right;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_4 = _loc_4 + _loc_6.getExplicitOrMeasuredWidth();
                    }
                }
                var _loc_8:* = _loc_5.center as GridContainer;
                _loc_5 = _loc_5.center as GridContainer;
                if (_loc_8 != null)
                {
                    var _loc_8:* = _loc_5.top;
                    _loc_6 = _loc_5.top;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_3 = _loc_3 + _loc_6.getExplicitOrMeasuredHeight();
                    }
                    var _loc_8:* = _loc_5.bottom;
                    _loc_6 = _loc_5.bottom;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_3 = _loc_3 + _loc_6.getExplicitOrMeasuredHeight();
                    }
                    var _loc_8:* = _loc_5.left;
                    _loc_6 = _loc_5.left;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_4 = _loc_4 + _loc_6.getExplicitOrMeasuredWidth();
                    }
                    var _loc_8:* = _loc_5.right;
                    _loc_6 = _loc_5.right;
                    if (_loc_8 != null && _loc_6.includeInLayout)
                    {
                        _loc_4 = _loc_4 + _loc_6.getExplicitOrMeasuredWidth();
                    }
                }
                _loc_7 = this.m_UIWorldMapWidget.calculateOptimalSize(_loc_2 - _loc_4, _loc_1 - _loc_3).height + _loc_3;
                this.options.generalUIGameWindowHeight = _loc_7 * 100 / _loc_1;
            }
            return;
        }// end function

        public function set m_UIBottomContainer(param1:HBox) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._967396880m_UIBottomContainer;
            if (_loc_2 !== param1)
            {
                this._967396880m_UIBottomContainer = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIBottomContainer", _loc_2, param1));
            }
            return;
        }// end function

        private function onOptionsChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "generalUIGameWindowHeight" || event.property == "*")
            {
                this.updateGameWindowSize();
            }
            if (event.property == "*")
            {
                this.updateCombatTactics();
            }
            this.m_CurrentOptionsDirty = true;
            return;
        }// end function

        public function set m_UIWorldMapWindow(param1:GameWindowContainer) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1313911232m_UIWorldMapWindow;
            if (_loc_2 !== param1)
            {
                this._1313911232m_UIWorldMapWindow = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIWorldMapWindow", _loc_2, param1));
            }
            return;
        }// end function

        public function get m_UISideBarToggleRight() : ToggleBar
        {
            return this._665607314m_UISideBarToggleRight;
        }// end function

        public function set m_UISideBarA(param1:SideBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._64278965m_UISideBarA;
            if (_loc_2 !== param1)
            {
                this._64278965m_UISideBarA = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UISideBarA", _loc_2, param1));
            }
            return;
        }// end function

        public function set m_UISideBarC(param1:SideBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._64278963m_UISideBarC;
            if (_loc_2 !== param1)
            {
                this._64278963m_UISideBarC = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UISideBarC", _loc_2, param1));
            }
            return;
        }// end function

        public function set m_UISideBarD(param1:SideBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._64278962m_UISideBarD;
            if (_loc_2 !== param1)
            {
                this._64278962m_UISideBarD = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UISideBarD", _loc_2, param1));
            }
            return;
        }// end function

        public function set m_UISideBarB(param1:SideBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._64278964m_UISideBarB;
            if (_loc_2 !== param1)
            {
                this._64278964m_UISideBarB = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UISideBarB", _loc_2, param1));
            }
            return;
        }// end function

        public function get m_UIWorldMapWidget() : WorldMapWidget
        {
            return this._1314206572m_UIWorldMapWidget;
        }// end function

        private function onCloseChangeCharacter(event:CloseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.currentTarget is CharacterSelectionWidget && event.detail == PopUpBase.BUTTON_OKAY && CharacterSelectionWidget(event.currentTarget).selectedCharacterIndex != -1)
            {
                this.m_ConnectionDataPending = CharacterSelectionWidget(event.currentTarget).selectedCharacterIndex;
                if (this.m_ConnectionDataPending >= 0 && this.m_ConnectionDataPending < this.m_ConnectionDataList.length)
                {
                    _loc_2 = this.m_ConnectionDataList[this.m_ConnectionDataPending] as AccountCharacter;
                }
            }
            if (event.detail != PopUpBase.BUTTON_OKAY && event.currentTarget is CharacterSelectionWidget && (this.m_Connection == null || !this.m_Connection.isConnected))
            {
                _loc_4 = new GameEvent(GameEvent.CLOSE, true, false);
                dispatchEvent(_loc_4);
            }
            else if (event.detail == PopUpBase.BUTTON_OKAY && event.currentTarget is CharacterSelectionWidget && _loc_2 != null && !this.isValidPreviewStateForClient(_loc_2.worldPreviewState))
            {
                event.preventDefault();
                _loc_3 = new EmbeddedDialog();
                _loc_3.name = "ConfirmClientChange";
                _loc_3.buttonFlags = PopUpBase.BUTTON_YES | PopUpBase.BUTTON_NO;
                _loc_3.text = resourceManager.getString(BUNDLE, "DLG_CLIENT_CHANGE_TEXT");
                _loc_3.title = resourceManager.getString(BUNDLE, "DLG_CLIENT_CHANGE_TITLE");
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onCloseChangeCharacter);
                CharacterSelectionWidget(event.currentTarget).embeddedDialog = _loc_3;
            }
            else if ((event.detail == PopUpBase.BUTTON_YES || event.detail == PopUpBase.BUTTON_OKAY) && (event.currentTarget is CharacterSelectionWidget || event.currentTarget is EmbeddedDialog && EmbeddedDialog(event.currentTarget).name == "ConfirmClientChange") && this.m_ConnectionDataPending != -1)
            {
                if (event.currentTarget as EmbeddedDialog != null)
                {
                    ((event.currentTarget as EmbeddedDialog).parent as PopUpBase).hide(false);
                }
                if (this.m_Connection != null && this.m_Connection.isConnected)
                {
                    this.m_Communication.disconnect(false);
                }
                else if (this.m_Connection == null || !this.m_Connection.isConnected)
                {
                    this.loginCharacter();
                }
            }
            else if (event.currentTarget is CharacterSelectionWidget && event.detail == PopUpBase.BUTTON_OKAY)
            {
                event.preventDefault();
                _loc_3 = new EmbeddedDialog();
                _loc_3.name = "NoCharacterSelected";
                _loc_3.buttonFlags = PopUpBase.BUTTON_OKAY;
                _loc_3.text = resourceManager.getString(BUNDLE, "DLG_CHANGE_CHARACTER_NO_SELECTION_TEXT");
                _loc_3.title = resourceManager.getString(BUNDLE, "DLG_CHANGE_CHARACTER_NO_SELECTION_TITLE");
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onCloseChangeCharacter);
                CharacterSelectionWidget(event.currentTarget).embeddedDialog = _loc_3;
            }
            return;
        }// end function

        private function onConnectionDisconnected(event:ConnectionEvent) : void
        {
            visible = false;
            this.saveLocalData();
            this.saveOptions();
            if (this.m_TutorialMode)
            {
                this.transferToLiveServer(this.m_TutorialData["player-name"]);
            }
            else if (this.m_ConnectionDataPending == -1)
            {
                this.changeCharacter();
            }
            else
            {
                this.loginCharacter();
            }
            return;
        }// end function

        public function get isRunning() : Boolean
        {
            return this.m_Connection != null && this.m_Connection.isGameRunning || this.m_CurrentOptionsUploading;
        }// end function

        public function get currentConnection() : Object
        {
            return this.m_Connection;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                    this.m_Options.unload();
                }
                this.m_Options = param1;
                this.m_ChatStorage.options = this.m_Options;
                if (this.m_CreatureStorage != null)
                {
                    this.m_CreatureStorage.options = this.m_Options;
                }
                this.m_WorldMapStorage.options = this.m_Options;
                this.m_UIActionBarBottom.options = this.m_Options;
                this.m_UIActionBarLeft.options = this.m_Options;
                this.m_UIActionBarRight.options = this.m_Options;
                this.m_UIActionBarTop.options = this.m_Options;
                this.m_UIChatWidget.options = this.m_Options;
                this.m_UIInputHandler.options = this.m_Options;
                this.m_UISideBarA.options = this.m_Options;
                this.m_UISideBarB.options = this.m_Options;
                this.m_UISideBarC.options = this.m_Options;
                this.m_UISideBarD.options = this.m_Options;
                this.m_UISideBarToggleLeft.options = this.m_Options;
                this.m_UISideBarToggleRight.options = this.m_Options;
                this.m_UIStatusWidget.options = this.m_Options;
                this.m_UIWorldMapWidget.options = this.m_Options;
                this.m_UIWorldMapWindow.options = this.m_Options;
                this.updateCombatTactics();
                this.updateGameWindowSize();
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_CurrentOptionsDirty = true;
            }
            return;
        }// end function

        public function reset(param1:Boolean = true) : void
        {
            var _loc_2:* = 0;
            if (this.m_ChatStorage != null)
            {
                this.m_ChatStorage.reset();
            }
            if (this.m_ContainerStorage != null)
            {
                this.m_ContainerStorage.reset();
            }
            if (this.m_CreatureStorage != null)
            {
                this.m_CreatureStorage.reset(param1);
            }
            if (this.m_Player != null && param1 == true)
            {
                this.m_Player.reset();
            }
            if (this.m_SpellStorage != null)
            {
                this.m_SpellStorage.reset();
            }
            if (this.m_WorldMapStorage != null)
            {
                this.m_WorldMapStorage.reset();
            }
            if (this.m_Options != null)
            {
                this.m_Options.combatPVPMode = OptionsStorage.COMBAT_PVP_MODE_DOVE;
                this.m_Options.combatSecureMode = OptionsStorage.COMBAT_SECURE_ON;
            }
            if (this.m_UIActionBarBottom != null)
            {
                this.m_UIActionBarBottom.containerStorage = this.m_ContainerStorage;
            }
            if (this.m_UIActionBarLeft != null)
            {
                this.m_UIActionBarLeft.containerStorage = this.m_ContainerStorage;
            }
            if (this.m_UIActionBarRight != null)
            {
                this.m_UIActionBarRight.containerStorage = this.m_ContainerStorage;
            }
            if (this.m_UIActionBarTop != null)
            {
                this.m_UIActionBarTop.containerStorage = this.m_ContainerStorage;
            }
            if (this.m_UIChatWidget != null)
            {
                this.m_UIChatWidget.chatStorage = this.m_ChatStorage;
                this.m_UIChatWidget.leftChannel = this.m_ChatStorage.getChannel(ChatStorage.LOCAL_CHANNEL_ID);
                this.m_UIChatWidget.rightChannel = null;
            }
            if (this.m_UIStatusWidget != null)
            {
                this.m_UIStatusWidget.player = this.m_Player;
            }
            if (this.m_UIWorldMapWidget != null)
            {
                this.m_UIWorldMapWidget.reset();
            }
            if (this.options != null)
            {
                _loc_2 = 0;
                for each (_loc_2 in this.options.getSideBarSetIDs())
                {
                    
                    this.options.getSideBarSet(_loc_2).closeVolatileWidgets();
                }
                for each (_loc_2 in this.options.getBuddySetIDs())
                {
                    
                    this.options.getBuddySet(_loc_2).clearBuddies();
                }
            }
            CursorManager.getInstance().removeAllCursors();
            if (ContextMenuBase.getCurrent() != null)
            {
                ContextMenuBase.getCurrent().hide();
            }
            PopUpQueue.getInstance().hideByPriority(PopUpBase.DEFAULT_PRIORITY);
            return;
        }// end function

        public function changeCharacter() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = new ArrayCollection();
            for each (_loc_2 in this.m_ConnectionDataList)
            {
                
                if (_loc_2 is AccountCharacter)
                {
                    _loc_1.addItem(_loc_2);
                }
            }
            this.m_FailedConnectionRescheduler.reset();
            if (_loc_1.length > 0)
            {
                _loc_3 = new CharacterSelectionWidget();
                _loc_3.characters = _loc_1;
                _loc_3.selectedCharacterIndex = this.m_ConnectionDataCurrent;
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onCloseChangeCharacter);
                _loc_3.show();
            }
            else
            {
                this.m_ConnectionDataPending = 0;
                this.loginCharacter();
            }
            return;
        }// end function

        public function set m_UIGameWindow(param1:GridContainer) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1404294856m_UIGameWindow;
            if (_loc_2 !== param1)
            {
                this._1404294856m_UIGameWindow = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIGameWindow", _loc_2, param1));
            }
            return;
        }// end function

        private function _Tibia_Array2_i() : Array
        {
            var _loc_1:* = [undefined, undefined];
            this._Tibia_Array2 = _loc_1;
            BindingManager.executeBindings(this, "_Tibia_Array2", this._Tibia_Array2);
            return _loc_1;
        }// end function

        public function set m_UICenterColumn(param1:CustomDividedBox) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1356021457m_UICenterColumn;
            if (_loc_2 !== param1)
            {
                this._1356021457m_UICenterColumn = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UICenterColumn", _loc_2, param1));
            }
            return;
        }// end function

        public function set m_UISideBarToggleLeft(param1:ToggleBar) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._2056921391m_UISideBarToggleLeft;
            if (_loc_2 !== param1)
            {
                this._2056921391m_UISideBarToggleLeft = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UISideBarToggleLeft", _loc_2, param1));
            }
            return;
        }// end function

        public function set m_UIInputHandler(param1:InputHandler) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._748017946m_UIInputHandler;
            if (_loc_2 !== param1)
            {
                this._748017946m_UIInputHandler = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIInputHandler", _loc_2, param1));
            }
            return;
        }// end function

        private function onConnectionError(event:ConnectionEvent) : void
        {
            if (event.errorType == ERR_COULD_NOT_CONNECT && this.m_FailedConnectionRescheduler.shouldAttemptReconnect())
            {
                this.onConnectionLoginWait(this.m_FailedConnectionRescheduler.buildEventForReconnectionAndIncreaseRetries());
                return;
            }
            this.m_FailedConnectionRescheduler.reset();
            visible = false;
            this.saveLocalData();
            this.saveOptions();
            SessiondumpMouseShield.getInstance().hide();
            var _loc_2:* = new MessageWidget();
            _loc_2.buttonFlags = PopUpBase.BUTTON_OKAY;
            _loc_2.keyboardFlags = PopUpBase.KEY_ENTER;
            _loc_2.message = resourceManager.getString(BUNDLE, "DLG_ERROR_TEXT_GENERAL", [event.message]);
            _loc_2.title = resourceManager.getString(BUNDLE, "DLG_ERROR_TITLE");
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onCloseError);
            _loc_2.show();
            return;
        }// end function

        private function onSecondaryTimer(event:TimerEvent) : void
        {
            var _loc_2:* = s_GetTibiaTimer();
            if (_loc_2 > this.m_CurrentOptionsLastUpload + this.m_CurrentOptionsUploadErrorDelay + OPTIONS_SAVE_INTERVAL)
            {
                this.saveOptions();
            }
            this.m_SecondaryTimestamp = _loc_2;
            return;
        }// end function

        private function onConnectionCreated(event:ConnectionEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this.s_GetConnection();
            if (_loc_2 is Connection)
            {
                if (this.m_CreatureStorage == null || this.m_CreatureStorage is CreatureStorage == false)
                {
                    this.m_CreatureStorage = new CreatureStorage();
                }
                SessiondumpMouseShield.getInstance().hide();
            }
            else if (_loc_2 is Sessiondump)
            {
                _loc_3 = _loc_2 as Sessiondump;
                if (this.m_CreatureStorage == null || this.m_CreatureStorage is SessiondumpCreatureStorage == false)
                {
                    this.m_CreatureStorage = new SessiondumpCreatureStorage();
                }
                SessiondumpMouseShield.getInstance().show();
            }
            this.m_Player = this.m_CreatureStorage.player;
            if (s_TutorialData != null)
            {
                this.m_Player.name = s_TutorialData["player-name"] as String;
            }
            this.m_PremiumManager = new PremiumManager(this.m_Player);
            this.m_UIStatusWidget.player = this.m_Player;
            this.m_UIWorldMapWidget.creatureStorage = this.m_CreatureStorage;
            this.m_UIWorldMapWidget.player = this.m_Player;
            this.m_UIWorldMapWidget.worldMapStorage = this.m_WorldMapStorage;
            this.m_Communication = new Communication(this.m_Connection, this.m_AppearanceStorage, this.m_ChatStorage, this.m_ContainerStorage, this.m_CreatureStorage, this.m_MiniMapStorage, this.m_Player, this.m_SpellStorage, this.m_WorldMapStorage);
            return;
        }// end function

        public function get m_UIBottomContainer() : HBox
        {
            return this._967396880m_UIBottomContainer;
        }// end function

        private function onConnectionLoginError(event:ConnectionEvent) : void
        {
            visible = false;
            this.saveLocalData();
            this.saveOptions();
            var _loc_2:* = new MessageWidget();
            _loc_2.buttonFlags = PopUpBase.BUTTON_OKAY;
            _loc_2.keyboardFlags = PopUpBase.KEY_ENTER;
            _loc_2.message = resourceManager.getString(BUNDLE, "DLG_LOGINERROR_TEXT", [event.message]);
            _loc_2.title = resourceManager.getString(BUNDLE, "DLG_LOGINERROR_TITLE");
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onCloseError);
            _loc_2.show();
            return;
        }// end function

        private function _Tibia_StatusWidget1_i() : StatusWidget
        {
            var _loc_1:* = new StatusWidget();
            this.m_UIStatusWidget = _loc_1;
            _loc_1.id = "m_UIStatusWidget";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function onCloseError(event:CloseEvent) : void
        {
            var _loc_2:* = new GameEvent(GameEvent.CLOSE, true, false);
            dispatchEvent(_loc_2);
            return;
        }// end function

        protected function releaseConnection() : void
        {
            if (this.m_Connection != null)
            {
                this.m_Connection.removeEventListener(ConnectionEvent.PENDING, this.onConnectionPending);
                this.m_Connection.removeEventListener(ConnectionEvent.GAME, this.onConnectionGame);
                this.m_Connection.removeEventListener(ConnectionEvent.CONNECTING, this.onConnectionConnecting);
                this.m_Connection.removeEventListener(ConnectionEvent.CONNECTION_LOST, this.onConnectionLost);
                this.m_Connection.removeEventListener(ConnectionEvent.CONNECTION_RECOVERED, this.onConnectionRecovered);
                this.m_Connection.removeEventListener(ConnectionEvent.DEAD, this.onConnectionDeath);
                this.m_Connection.removeEventListener(ConnectionEvent.DISCONNECTED, this.onConnectionDisconnected);
                this.m_Connection.removeEventListener(ConnectionEvent.ERROR, this.onConnectionError);
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINADVICE, this.onConnectionLoginAdvice);
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINERROR, this.onConnectionLoginError);
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINWAIT, this.onConnectionLoginWait);
                this.m_Connection.disconnect(false);
                this.m_Connection = null;
            }
            return;
        }// end function

        public function get m_UISideBarA() : SideBarWidget
        {
            return this._64278965m_UISideBarA;
        }// end function

        public function get m_UISideBarB() : SideBarWidget
        {
            return this._64278964m_UISideBarB;
        }// end function

        public function get m_UISideBarC() : SideBarWidget
        {
            return this._64278963m_UISideBarC;
        }// end function

        private function onConnectionDeath(event:ConnectionEvent) : void
        {
            visible = true;
            this.m_CharacterDeath = true;
            var _loc_2:* = event.data is Object ? (event.data as Object) : ({type:ConnectionEvent.DEATH_REGULAR, fairFightFactor:0});
            var _loc_3:* = new DeathMessageWidget();
            _loc_3.title = resourceManager.getString(BUNDLE, "DLG_DEAD_TITLE");
            if (_loc_2.type == ConnectionEvent.DEATH_UNFAIR)
            {
                _loc_3.message = resourceManager.getString(BUNDLE, "DLG_DEAD_TEXT_UNFAIR", [100 - _loc_2.fairFightFactor]);
            }
            else if (_loc_2.type == ConnectionEvent.DEATH_BLESSED)
            {
                _loc_3.message = resourceManager.getString(BUNDLE, "DLG_DEAD_TEXT_BLESSED");
            }
            else if (_loc_2.type == ConnectionEvent.DEATH_NOPENALTY)
            {
                _loc_3.message = resourceManager.getString(BUNDLE, "DLG_DEAD_TEXT_NOPENALTY");
            }
            else
            {
                _loc_3.message = resourceManager.getString(BUNDLE, "DLG_DEAD_TEXT_FAIR");
            }
            _loc_3.addEventListener(CloseEvent.CLOSE, this.onCloseDeath);
            _loc_3.show();
            return;
        }// end function

        public function get m_UIWorldMapWindow() : GameWindowContainer
        {
            return this._1313911232m_UIWorldMapWindow;
        }// end function

        public function get m_UISideBarD() : SideBarWidget
        {
            return this._64278962m_UISideBarD;
        }// end function

        public function saveOptions() : void
        {
            if (this.m_Options != null)
            {
                this.m_ChatStorage.saveChannels();
                if (this.m_CurrentOptionsAsset != null && !this.m_CurrentOptionsUploading && this.m_CurrentOptionsDirty)
                {
                    this.m_CurrentOptionsAsset.upload(this.options.marshall(), this.m_SessionKey);
                    this.m_CurrentOptionsUploading = true;
                }
            }
            return;
        }// end function

        protected function onDividerRelease(event:DividerEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null)
            {
                _loc_2 = this.m_UIGameWindow.height;
                _loc_3 = this.m_UIChatWidget.height;
                if (!isNaN(this.m_UIChatWidget.minHeight) && Math.abs(_loc_3 - this.m_UIChatWidget.minHeight) < 0.01)
                {
                    this.options.generalUIGameWindowHeight = 100;
                }
                else if (!isNaN(this.m_UIGameWindow.minHeight) && Math.abs(_loc_2 - this.m_UIGameWindow.minHeight) < 0.01)
                {
                    this.options.generalUIGameWindowHeight = 0;
                }
                else
                {
                    this.options.generalUIGameWindowHeight = _loc_2 * 100 / (_loc_2 + _loc_3);
                }
            }
            return;
        }// end function

        public function ___Tibia_Application1_preinitialize(event:FlexEvent) : void
        {
            this.onPreinitialise(event);
            return;
        }// end function

        public function set m_UIOuterRootContainer(param1:DividedBox) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._1568861366m_UIOuterRootContainer;
            if (_loc_2 !== param1)
            {
                this._1568861366m_UIOuterRootContainer = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIOuterRootContainer", _loc_2, param1));
            }
            return;
        }// end function

        private function _Tibia_GameWindowContainer1_i() : GameWindowContainer
        {
            var _loc_1:* = new GameWindowContainer();
            this.m_UIWorldMapWindow = _loc_1;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.center = this._Tibia_WorldMapWidget1_i();
            _loc_1.top = this._Tibia_HActionBarWidget1_i();
            _loc_1.bottom = this._Tibia_HActionBarWidget2_i();
            _loc_1.left = this._Tibia_VActionBarWidget1_i();
            _loc_1.right = this._Tibia_VActionBarWidget2_i();
            _loc_1.id = "m_UIWorldMapWindow";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function onCloseDeath(event:CloseEvent) : void
        {
            if (event.detail == PopUpBase.BUTTON_OKAY || event.detail == DeathMessageWidget.EXTRA_BUTTON_STORE)
            {
                if (this.m_Communication != null)
                {
                    this.m_Communication.sendCENTERWORLD();
                    if (event.detail == DeathMessageWidget.EXTRA_BUTTON_STORE)
                    {
                        IngameShopManager.getInstance().openShopWindow(true, IngameShopProduct.SERVICE_TYPE_BLESSINGS, true);
                    }
                }
            }
            else
            {
                this.m_ConnectionDataPending = -1;
                if (this.m_Communication != null)
                {
                    this.m_Communication.disconnect(false);
                }
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function get m_UIGameWindow() : GridContainer
        {
            return this._1404294856m_UIGameWindow;
        }// end function

        public function set m_UIActionBarRight(param1:VActionBarWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._2043305115m_UIActionBarRight;
            if (_loc_2 !== param1)
            {
                this._2043305115m_UIActionBarRight = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIActionBarRight", _loc_2, param1));
            }
            return;
        }// end function

        public function get m_UICenterColumn() : CustomDividedBox
        {
            return this._1356021457m_UICenterColumn;
        }// end function

        public function get m_UISideBarToggleLeft() : ToggleBar
        {
            return this._2056921391m_UISideBarToggleLeft;
        }// end function

        public function get m_UIInputHandler() : InputHandler
        {
            return this._748017946m_UIInputHandler;
        }// end function

        private function onUploadOptionsError(event:ErrorEvent) : void
        {
            this.m_CurrentOptionsUploading = false;
            if (event.errorID == -1)
            {
                this.m_CurrentOptionsUploadErrorDelay = 1000 * 60 * 60 * 24 * 365;
            }
            else
            {
                this.m_CurrentOptionsUploadErrorDelay = this.m_CurrentOptionsUploadErrorDelay == 0 ? (2000) : (this.m_CurrentOptionsUploadErrorDelay * 2);
            }
            return;
        }// end function

        private function _Tibia_WorldMapWidget1_i() : WorldMapWidget
        {
            var _loc_1:* = new WorldMapWidget();
            this.m_UIWorldMapWidget = _loc_1;
            _loc_1.id = "m_UIWorldMapWidget";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function unload() : void
        {
            if (this.m_AppearanceStorage != null)
            {
                this.m_AppearanceStorage.removeEventListener(Event.COMPLETE, this.onAppearancesLoadComplete);
                this.m_AppearanceStorage.removeEventListener(ErrorEvent.ERROR, this.onAppearancesLoadError);
                this.m_AppearanceStorage.reset();
            }
            if (this.m_ChatStorage != null)
            {
                this.m_ChatStorage.reset();
            }
            if (this.m_ContainerStorage != null)
            {
                this.m_ContainerStorage.reset();
            }
            if (this.m_CreatureStorage != null)
            {
                this.m_CreatureStorage.reset();
            }
            if (this.m_MiniMapStorage != null)
            {
                this.m_MiniMapStorage.reset();
            }
            if (this.m_Player != null)
            {
                this.m_Player.reset();
            }
            if (this.m_SpellStorage != null)
            {
                this.m_SpellStorage.reset();
            }
            if (this.m_WorldMapStorage != null)
            {
                this.m_WorldMapStorage.reset();
            }
            this.releaseConnection();
            if (this.m_SeconaryTimer != null)
            {
                this.m_SeconaryTimer.stop();
            }
            if (this.m_UIInputHandler != null)
            {
                this.m_UIInputHandler.dispose();
            }
            CursorManager.getInstance().removeAllCursors();
            if (ContextMenuBase.getCurrent() != null)
            {
                ContextMenuBase.getCurrent().hide();
            }
            FocusNotifier.getInstance().hide();
            PopUpQueue.getInstance().hideByPriority(int.MAX_VALUE);
            return;
        }// end function

        public function set m_UIStatusWidget(param1:StatusWidget) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._228925540m_UIStatusWidget;
            if (_loc_2 !== param1)
            {
                this._228925540m_UIStatusWidget = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "m_UIStatusWidget", _loc_2, param1));
            }
            return;
        }// end function

        private function _Tibia_HActionBarWidget1_i() : HActionBarWidget
        {
            var _loc_1:* = new HActionBarWidget();
            this.m_UIActionBarTop = _loc_1;
            _loc_1.styleName = "actionBarTop";
            _loc_1.id = "m_UIActionBarTop";
            BindingManager.executeBindings(this, "m_UIActionBarTop", this.m_UIActionBarTop);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get m_UIStatusWidget() : StatusWidget
        {
            return this._228925540m_UIStatusWidget;
        }// end function

        private function onConnectionGame(event:ConnectionEvent) : void
        {
            if (this.m_ChatStorage != null)
            {
                this.m_ChatStorage.resetChannelActivationTimeout();
            }
            PopUpQueue.getInstance().hideByPriority(PopUpBase.DEFAULT_PRIORITY);
            if (ContextMenuBase.getCurrent() != null)
            {
                ContextMenuBase.getCurrent().hide();
            }
            visible = true;
            this.updateCombatTactics();
            this.m_CharacterDeath = false;
            return;
        }// end function

        public function setAssetProvider(param1:IAssetProvider) : void
        {
            if (param1 == null)
            {
                throw new Error("Tibia.setAssetProvider: asset provider must not be null.");
            }
            this.m_AssetProvider = param1;
            var _loc_2:* = this.m_TutorialMode ? (this.m_AssetProvider.getDefaultOptionsTutorial()) : (this.m_AssetProvider.getDefaultOptions());
            this.m_DefaultOptionsAsset = _loc_2;
            if (_loc_2 != null)
            {
                param1.removeAsset(_loc_2);
            }
            if (!this.m_TutorialMode)
            {
                this.setCurrentOptionsFromAssets(param1);
            }
            this.m_AppearanceStorage.setAssetProvider(param1);
            return;
        }// end function

        public static function s_GetAppearanceStorage() : AppearanceStorage
        {
            return (application as ).m_AppearanceStorage;
        }// end function

        public static function s_GetInstance() : Tibia
        {
            return application as ;
        }// end function

        public static function s_GetChatStorage() : ChatStorage
        {
            return (application as ).m_ChatStorage;
        }// end function

        public static function s_GetSecondaryTimer() : Timer
        {
            return (application as ).m_SeconaryTimer;
        }// end function

        public static function get s_GameActionFactory() : GameActionFactory
        {
            return (application as ).m_GameActionFactory;
        }// end function

        public static function s_GetMiniMapStorage() : MiniMapStorage
        {
            return (application as ).m_MiniMapStorage;
        }// end function

        public static function s_SetOptions(param1:OptionsStorage) : void
        {
            var _loc_2:* = application as ;
            if (_loc_2 != null)
            {
                _loc_2.options = param1;
            }
            return;
        }// end function

        public static function s_GetContainerStorage() : ContainerStorage
        {
            return (application as ).m_ContainerStorage;
        }// end function

        public static function s_GetStatusWidget() : StatusWidget
        {
            return (application as ).m_UIStatusWidget;
        }// end function

        public static function s_GetPremiumManager() : PremiumManager
        {
            return (application as ).m_PremiumManager;
        }// end function

        public static function s_GetUIEffectsManager() : UIEffectsManager
        {
            return (application as ).m_UIEffectsManager;
        }// end function

        public static function s_GetCreatureStorage() : CreatureStorage
        {
            return (application as ).m_CreatureStorage;
        }// end function

        public static function set s_TibiaTimerFactor(param1:Number) : void
        {
            if (!isNaN(param1))
            {
                s_LastTibiaFactorChangeTibiaTimestamp = s_GetTibiaTimer();
                s_LastTibiaFactorChangeRealTimestamp = getTimer();
                s_InternalTibiaTimerFactor = param1;
            }
            return;
        }// end function

        public static function set s_GameActionFactory(param1:GameActionFactory) : void
        {
            (application as ).m_GameActionFactory = param1;
            return;
        }// end function

        public static function s_GetFrameFlash() : Boolean
        {
            return (int(Tibia.s_FrameTibiaTimestamp / 300) & 1) != 0;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            Tibia._watcherSetupUtil = param1;
            return;
        }// end function

        public static function get s_TutorialMode() : Boolean
        {
            return (application as ).m_TutorialMode;
        }// end function

        public static function get s_TutorialData() : Object
        {
            return (application as ).m_TutorialData;
        }// end function

        public static function s_GetCommunication() : Communication
        {
            return (application as ).m_Communication;
        }// end function

        public static function s_GetInputHandler() : InputHandler
        {
            return (application as ).m_UIInputHandler;
        }// end function

        public static function s_GetAssetProvider() : IAssetProvider
        {
            return (application as ).m_AssetProvider;
        }// end function

        public static function get s_TibiaTimerFactor() : Number
        {
            return s_InternalTibiaTimerFactor;
        }// end function

        public static function s_GetSpellStorage() : SpellStorage
        {
            return (application as ).m_SpellStorage;
        }// end function

        public static function s_GetOptions() : OptionsStorage
        {
            return (application as ).m_Options;
        }// end function

        public static function s_GetChatWidget() : ChatWidget
        {
            return (application as ).m_UIChatWidget;
        }// end function

        public static function s_GetWorldMapStorage() : WorldMapStorage
        {
            return (application as ).m_WorldMapStorage;
        }// end function

        public static function s_GetConnection() : IServerConnection
        {
            return (application as ).m_Connection;
        }// end function

        public static function s_GetPlayer() : Player
        {
            return (application as ).m_Player;
        }// end function

        public static function s_GetTibiaTimer() : int
        {
            if (s_LastTibiaFactorChangeRealTimestamp == 0)
            {
                s_LastTibiaFactorChangeRealTimestamp = getTimer();
                s_LastTibiaFactorChangeTibiaTimestamp = s_LastTibiaTimestamp;
            }
            var _loc_1:* = getTimer() - s_LastTibiaFactorChangeRealTimestamp;
            s_LastTibiaTimestamp = s_LastTibiaFactorChangeTibiaTimestamp + _loc_1 * s_InternalTibiaTimerFactor;
            return s_LastTibiaTimestamp;
        }// end function

        public static function s_GetSessionKey() : String
        {
            return (application as ).m_SessionKey;
        }// end function

    }
}

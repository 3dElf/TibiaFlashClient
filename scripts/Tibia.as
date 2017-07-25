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
        private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789:Class;
        private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1517554948:Class;
        protected var m_CurrentOptionsAsset:OptionsAsset = null;
        private var _embed_css_images_custombutton_Button_Border_tileable_tl_over_png_1203653996:Class;
        private var _embed_css_images_slot_Hotkey_protected_png_803702344:Class;
        private var _embed_css_____assets_images_imbuing_imbuing_icon_imbue_disabled_png_2110185778:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_428456803:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_917250191:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_443456403:Class;
        private var _embed_css_images_BarsHealth_compact_Yellow_png_824185175:Class;
        private var _embed_css_images_Icons_WidgetMenu_Prey_active_over_png_21306593:Class;
        private var _embed_css_images_ChatTab_tileable_png_883140798:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Skull_png_1181631553:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_450488793:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bc_disabled_png_97198997:Class;
        private var _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672:Class;
        private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_1093080407:Class;
        private var _embed_css_images_Slot_InventoryShield_png_125978696:Class;
        var _bindingsByDestination:Object;
        private var _embed_css_images_custombutton_Button_Border_tileable_tc_over_png_1569901787:Class;
        private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
        private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1779777081:Class;
        private var _embed_css____images_prey_prey_bonus_reroll_png_1391458109:Class;
        private var _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_mc_idle_png_144725306:Class;
        protected var m_ContainerStorage:ContainerStorage = null;
        protected var m_CurrentOptionsUploadErrorDelay:int = 0;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bc_pressed_png_969488782:Class;
        private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_539137698:Class;
        private var _1020379552m_UITibiaRootContainer:HBox;
        private var _embed_css_images_Slot_Hotkey_Cooldown_png_1017067163:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_228803293:Class;
        protected var m_IsActive:Boolean = false;
        private var _embed_css_images_Minimap_ZoomOut_over_png_353204682:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_tc_idle_png_1335630595:Class;
        private var _embed_css_images_Scrollbar_Arrow_down_idle_png_91820120:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_744247435:Class;
        private var _embed_css_images_Icons_CombatControls_PvPOn_idle_png_325504288:Class;
        private var _embed_css_images_Slot_Statusicon_highlighted_png_1332900150:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_2144032898:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1236418872:Class;
        private var _embed_css_images_Icons_Conditions_MagicShield_png_557850584:Class;
        private var _embed_css_images_Minimap_Center_idle_png_2012166886:Class;
        private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_370747169:Class;
        private var _embed_css_images_Icons_IngameShop_12x12_Yes_png_415896407:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1338322061:Class;
        private var _embed_css_images_BarsHealth_default_GreenFull_png_539233669:Class;
        protected var m_Options:OptionsStorage = null;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_13628752:Class;
        protected var m_CurrentOptionsLastUpload:int = -2.14748e+009;
        private var _embed_css____images_prey_prey_unlock_temporarily_png_1205226112:Class;
        private var _embed_css_images_BarsXP_default__png_162149957:Class;
        private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154048530:Class;
        private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1063594900:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517102410:Class;
        private var m_TutorialMode:Boolean = false;
        private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1911407069:Class;
        private var _embed_css_images_Slot_InventoryHead_protected_png_1088319362:Class;
        private var _embed_css_images_BarsHealth_default_RedLow_png_1323495386:Class;
        private var _embed_css_images_Icons_Conditions_PZ_png_2094848430:Class;
        private var _embed_css_images_Button_ChatTab_Close_over_png_1945347312:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_613329023:Class;
        private var _embed_css_images_BG_Stone2_Tileable_png_2089033964:Class;
        private var _embed_css_images_Border_Widget_corner_png_30247409:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1435348302:Class;
        private var _1174474338m_UIActionBarLeft:VActionBarWidget;
        private var _embed_css_images_custombutton_Button_Border_tileable_tl_pressed_png_1978729388:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_329965451:Class;
        private var m_FailedConnectionRescheduler:FailedConnectionRescheduler;
        private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1666844766:Class;
        protected var m_CurrentOptionsDirty:Boolean = false;
        private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_327192750:Class;
        private var _embed_css_images_Button_Combat_Stop_idle_png_2028013783:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1971662251:Class;
        private var _embed_css_images_Border_Widget_png_123662323:Class;
        private var _embed_css_images_BG_BarsProgress_compact_tileable_png_1434705776:Class;
        private var _embed_css_images_Button_ChatTab_Close_pressed_png_1705582336:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_387529648:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Trades_png_17953531:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_bc_pressed_png_829106133:Class;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1920390846:Class;
        private var _embed_css_images_Button_Close_disabled_png_585602746:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1392106579:Class;
        private var _embed_css____images_prey_prey_list_reroll_png_1451613866:Class;
        private var _embed_css_images_Button_Maximize_idle_png_960737362:Class;
        private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_314099262:Class;
        private var _embed_css_images_Slot_InventoryLegs_png_2114818196:Class;
        private var _embed_css_images_BarsHealth_compact_GreenLow_png_1230640774:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bc_disabled_png_2000142426:Class;
        private var _embed_css____images_prey_prey_unlock_permanently_png_2084364847:Class;
        private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_784879159:Class;
        private var m_GameClientReady:Boolean = false;
        private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1260863432:Class;
        private var _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_616733832:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_ml_idle_png_1658654332:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_2145118177:Class;
        private var _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432:Class;
        private var _embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_idle_png_546154478:Class;
        private var _embed_css_images_BG_ChatTab_Tabdrop_png_344159956:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bl_idle_png_2093052983:Class;
        private var _embed_css_____assets_images_imbuing_imbuing_icon_useprotection_active_png_532986814:Class;
        private var _embed_css_images_Icons_Inventory_Store_png_1162053375:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_283159200:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1337920135:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_bc_pressed_png_1314073167:Class;
        private var _embed_css_images_Slot_InventoryNecklace_protected_png_1799961580:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_793986337:Class;
        private var _embed_css_images_BarsProgress_compact_orange_png_198580350:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1392963547:Class;
        private var _embed_css_images_Icons_Conditions_Slowed_png_77123048:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1439642702:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertMode_idle_png_754231034:Class;
        private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1482270485:Class;
        private var _embed_css_images_Minimap_png_667670405:Class;
        private var _embed_css_images_Button_ChatTabNew_pressed_png_923606007:Class;
        private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_788781616:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_over_png_585745991:Class;
        private var _embed_css_images_Button_MaximizePremium_over_png_267955669:Class;
        private var _embed_css_images_Icons_Conditions_Hungry_png_758019275:Class;
        private var m_ConnectionEstablishedAndPacketReceived:Boolean = false;
        private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1806477361:Class;
        private var _embed_css_images_Widget_Footer_tileable_png_2102878075:Class;
        private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1093895878:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Combat_png_375287802:Class;
        private var _embed_css_images_Scrollbar_Arrow_up_over_png_860191089:Class;
        private var _embed_css_images_Slot_Statusicon_png_1415858734:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_bl_idle_png_866059770:Class;
        private var _embed_css_images_BarsXP_default_improved_png_1481613863:Class;
        private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_583051058:Class;
        private var _embed_css_images_Icons_WidgetMenu_Prey_active_png_2078269124:Class;
        private var _embed_css_images_BarsHealth_compact_RedLow_png_432309528:Class;
        private var _1404294856m_UIGameWindow:GridContainer;
        private var _embed_css_images_Button_MaximizePremium_idle_png_1480797397:Class;
        private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1137251407:Class;
        protected var m_Connection:IServerConnection = null;
        var _bindingsBeginWithWord:Object;
        private var _embed_css____images_prey_prey_list_reroll_reactivate_png_1235856493:Class;
        private var _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002:Class;
        private var _embed_css_images_Icons_Conditions_Dazzled_png_1747135488:Class;
        private var _embed_css_images_Border02_WidgetSidebar_slim_png_420837653:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1660751461:Class;
        private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1801889674:Class;
        private var _64278965m_UISideBarA:SideBarWidget;
        private var _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_626524886:Class;
        private var _embed_css_images_Button_ChatTab_Close_idle_png_1074740208:Class;
        private var _embed_css_images_Scrollbar_Arrow_up_idle_png_18741135:Class;
        private var _embed_css_images_BG_Bars_compact_tileable_png_1504529517:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_tc_idle_png_1034633179:Class;
        private var _embed_css_images_Arrow_WidgetToggle_idle_png_952187387:Class;
        private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1075890131:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_tc_pressed_png_1605574371:Class;
        private var _embed_css_images_Icons_CombatControls_PvPOn_active_png_806196142:Class;
        private var _embed_css_images_Icons_ProgressBars_Shielding_png_599280960:Class;
        private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1396972083:Class;
        protected var m_ConnectionDataPending:int = -1;
        private var _embed_css_images_custombutton_Button_Border_tileable_ml_over_png_427887893:Class;
        private var _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_675712135:Class;
        private var _embed_css_images_Icons_Conditions_Freezing_png_1444773940:Class;
        private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1530197035:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1405466304:Class;
        private var _embed_css_images_Icons_CombatControls_PvPOff_active_png_470312516:Class;
        private var _embed_css_images_Icons_Conditions_Strenghtened_png_695721049:Class;
        private var _embed_css_images_slot_Hotkey_disabled_png_804094220:Class;
        private var _embed_css_images_Icons_WidgetMenu_GetPremium_active_png_377762303:Class;
        private var _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260:Class;
        private var _embed_css_images_Slot_InventoryWeapon_protected_png_2025859402:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_234622227:Class;
        private var _embed_css_images_Arrow_ScrollTabs_over_png_1323680872:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tl_pressed_png_1833730757:Class;
        private var _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_423192446:Class;
        private var _embed_css_____assets_images_imbuing_imbuing_slot_empty_png_768110180:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_273763964:Class;
        private var _embed_css_images_BG_BohemianTileable_png_1422729109:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1241884053:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tl_idle_png_1688019237:Class;
        private var _embed_css_images_Slot_InventoryRing_protected_png_143630382:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_ml_idle_png_1245218325:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429:Class;
        protected var m_WorldMapStorage:WorldMapStorage = null;
        private var _embed_css_images_custombutton_Button_Gold_tileable_bl_pressed_png_1601544042:Class;
        private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1799831422:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bc_over_png_46790494:Class;
        private var _embed_css_images_Button_Close_pressed_png_1495633374:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tc_over_png_1962565460:Class;
        private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_1017681455:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bc_pressed_png_1996698541:Class;
        private var _embed_css_images_Icons_ProgressBars_FistFighting_png_744761447:Class;
        protected var m_SpellStorage:SpellStorage = null;
        private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1205967224:Class;
        private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1456372718:Class;
        private var _1568861366m_UIOuterRootContainer:DividedBox;
        private var _embed_css_images_BarsHealth_default_RedFull_png_471797811:Class;
        private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1589130474:Class;
        private var _embed_css_images_Scrollbar_Handler_png_760479401:Class;
        private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_412469896:Class;
        protected var m_CharacterDeath:Boolean = false;
        private var _embed_css_____assets_images_imbuing_imbuing_icon_remove_active_png_857913398:Class;
        private var _embed_css_images_Icons_Conditions_Logoutblock_png_358377557:Class;
        private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_177601341:Class;
        private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_468614837:Class;
        private var _embed_css_images_BG_ChatTab_tileable_png_1482271674:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bc_over_png_718071091:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_523657045:Class;
        private var _embed_css_images_ChatWindow_Mover_png_2100462174:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730481697:Class;
        protected var m_SecondaryTimestamp:int = 0;
        private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1235819155:Class;
        private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1165139419:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_506655126:Class;
        private var _embed_css_images_BarsHealth_default_Yellow_png_338291605:Class;
        private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_933660722:Class;
        private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1523904949:Class;
        private var _embed_css_images_BarsHealth_compact_GreenFull_png_658108631:Class;
        private var _embed_css_images_Slot_InventoryNecklace_png_1808156997:Class;
        private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_47374454:Class;
        private var _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267:Class;
        private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_79143632:Class;
        private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1144518310:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bl_over_png_1316684489:Class;
        private var _embed_css_images_Button_ChatTabIgnore_pressed_png_922258679:Class;
        private var _embed_css_images_slot_container_highlighted_png_1302039720:Class;
        private var _embed_css_images_Scrollbar_tileable_png_1885091563:Class;
        private var _embed_css_images_Button_Combat_Stop_pressed_png_1195446471:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_tc_pressed_png_491469499:Class;
        private var _embed_css_images_Slot_InventoryLegs_protected_png_516995939:Class;
        private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_893524756:Class;
        protected var m_PremiumManager:PremiumManager = null;
        private var _embed_css_images_custombutton_Button_Gold_tileable_bl_over_png_866883846:Class;
        private var _embed_css_images_UnjustifiedPoints_png_1782736303:Class;
        private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_271327590:Class;
        private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793:Class;
        private var _embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1978490031:Class;
        private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_2100887615:Class;
        private var _64278964m_UISideBarB:SideBarWidget;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_bc_idle_png_1480530699:Class;
        private var _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_618087100:Class;
        private var _embed_css_images_Widget_Footer_tileable_end01_png_99047970:Class;
        private var _embed_css_images_Minimap_ZoomIn_pressed_png_1013656729:Class;
        private var _embed_css_images_Button_ContainerUp_idle_png_883766938:Class;
        private var _embed_css_images_Icons_WidgetHeaders_GetPremium_png_376682585:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_ml_over_png_1626598931:Class;
        private var _embed_css_images_Minimap_Center_over_png_279361510:Class;
        private var _embed_css_images_BuySellTab_active_png_1722132850:Class;
        private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bc_idle_png_713449011:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_tl_idle_png_460698220:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_tc_over_png_701648527:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bl_idle_png_1479317574:Class;
        private var _embed_css_images_Icons_Conditions_Drunk_png_45733786:Class;
        private var _embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1732180796:Class;
        private var _embed_css_images_Slot_InventoryArmor_png_1841074918:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_bl_idle_png_299642002:Class;
        private var _embed_css_images_Widget_Footer_tileable_end02_png_100995747:Class;
        private var _embed_css____images_prey_prey_bonus_reroll_disabled_png_192280102:Class;
        private var _embed_css_images_Border02_corners_png_2023953407:Class;
        private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1201440323:Class;
        private var _embed_css_images_Icons_Conditions_Burning_png_1677566757:Class;
        private var _embed_css_images_Slot_InventoryBoots_protected_png_674517205:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_ml_pressed_png_236721532:Class;
        var _bindings:Array;
        private var _embed_css_images_BarsHealth_fat_GreenFull_png_1012481779:Class;
        private var _embed_css_images_slot_container_png_1996786444:Class;
        private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1784655247:Class;
        private var _embed_css_images_Inventory_png_381497758:Class;
        private var _embed_css_images_BarsHealth_fat_GreenLow_png_23264160:Class;
        private var _embed_css_images_custombutton_Button_IngameShopBuy_tileable_over_png_1828072166:Class;
        private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907:Class;
        private var _embed_css_images_BarsHealth_compact_RedLow2_png_673302076:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_ml_pressed_png_1124837519:Class;
        private var _embed_css_images_Widget_HeaderBG_png_730116019:Class;
        private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1550321475:Class;
        private var _embed_css_____assets_images_imbuing_imbuing_icon_remove_disabled_png_1334606270:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bc_idle_png_1913227682:Class;
        private var _embed_css_images_Minimap_ZoomIn_idle_png_480998871:Class;
        private var _embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_920566008:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tc_pressed_png_1408096916:Class;
        private var _embed_css_images_Slot_InventoryArmor_protected_png_919089929:Class;
        private var _embed_css____images_prey_prey_confirm_monster_selection_disabled_png_1811398472:Class;
        private var _2056921391m_UISideBarToggleLeft:ToggleBar;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_1080426003:Class;
        private var _embed_css_images_Slot_InventoryBoots_png_1061018524:Class;
        private var _embed_css_images_BarsHealth_fat_Yellow_png_917594525:Class;
        private var _embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_pressed_png_493785154:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_tc_pressed_png_1001206657:Class;
        private var _embed_css_images_Minimap_ZoomOut_idle_png_2125846326:Class;
        private var _embed_css_images_BarsHealth_compact_RedFull_png_1785716075:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683:Class;
        private var _embed_css_images_BG_BarsXP_default_tileable_png_1802488215:Class;
        protected var m_AssetProvider:IAssetProvider = null;
        private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_1083507847:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_bc_over_png_1545885173:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1991267500:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tc_disabled_png_369402996:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_bc_over_png_1582917375:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bl_disabled_png_1996451214:Class;
        private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_138520421:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_tl_over_png_1790083580:Class;
        private var _embed_css_images_Button_ChatTabIgnore_idle_png_1319268057:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_tl_idle_png_919535868:Class;
        private var _embed_css_images_Icons_WidgetMenu_Prey_idle_png_924058986:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_tl_pressed_png_2061438852:Class;
        protected var m_DefaultOptionsAsset:OptionsAsset = null;
        private var _embed_css_images_Icons_Conditions_Drowning_png_542106670:Class;
        private var _embed_css_images_Icons_WidgetMenu_Prey_idle_over_png_459157651:Class;
        private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759328973:Class;
        private var _embed_css_images_Button_ChatTabNew_over_png_541842649:Class;
        private var _embed_css_images_Icons_CombatControls_Mounted_over_png_526740337:Class;
        private var _embed_css_images_Button_ContainerUp_pressed_png_571520662:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_ml_disabled_png_846678076:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1428562487:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_tc_idle_png_354340239:Class;
        private var _embed_css_images_Icons_Conditions_Bleeding_png_526934384:Class;
        private var _embed_css_images_BG_BarsProgress_compact_endpiece_png_1370317653:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Prey_png_2056699772:Class;
        private var _embed_css____images_prey_prey_list_reroll_small_reactivate_disabled_png_1943789254:Class;
        private var _embed_css_images_Button_ChatTabIgnore_over_png_503059495:Class;
        private var _embed_css_images_Icons_IngameShop_12x12_No_png_115059819:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_tl_disabled_png_929049956:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1337425916:Class;
        private var _embed_css_images_Icons_Conditions_Haste_png_378019693:Class;
        private var m_ForceDisableGameWindowSizeCalc:Boolean = false;
        private var _64278963m_UISideBarC:SideBarWidget;
        private var _embed_css_images_Button_Close_over_png_1824069490:Class;
        private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1728022323:Class;
        private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1324480721:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tc_idle_png_700367956:Class;
        private var _embed_css____images_prey_prey_confirm_monster_selection_png_1917808293:Class;
        protected var m_CreatureStorage:CreatureStorage = null;
        private var _embed_css_images_Icons_WidgetMenu_Skull_idle_png_1224099597:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_bl_pressed_png_1673065226:Class;
        private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_349575074:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_ml_pressed_png_1339953035:Class;
        private var _embed_css_images_Slot_InventoryHead_png_1231852719:Class;
        private var _embed_css_images_Icons_Conditions_Electrified_png_1245219382:Class;
        private var _embed_css_images_Slot_InventoryAmmo_png_675331507:Class;
        private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_2130554773:Class;
        private var _embed_css_images_BarsHealth_fat_Mana_png_1830736570:Class;
        private var _embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_over_png_1892300526:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645:Class;
        private var _embed_css_images_Button_ChatTabNew_idle_png_1804753881:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_ml_idle_png_1406639853:Class;
        private var _1356021457m_UICenterColumn:CustomDividedBox;
        private var _embed_css_images_BarsXP_default_zero_png_1390467341:Class;
        private var _embed_css_images_Border02_png_248151906:Class;
        private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787:Class;
        private var _embed_css_____assets_images_imbuing_imbuing_icon_useprotection_disabled_png_494797810:Class;
        private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_294457563:Class;
        private var _embed_css_images_Slot_InventoryShield_protected_png_1742050537:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1088011342:Class;
        protected var m_UIEffectsManager:UIEffectsManager = null;
        private var _embed_css_images_custombutton_Button_Gold_tileable_bc_idle_png_1388109823:Class;
        private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528:Class;
        protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_tc_over_png_279471101:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939:Class;
        private var _embed_css_images_Scrollbar_Arrow_down_over_png_1360238424:Class;
        private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_2021231179:Class;
        private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1148616102:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_ml_pressed_png_1710390195:Class;
        private var _228925540m_UIStatusWidget:StatusWidget;
        private var _embed_css_images_Icons_WidgetMenu_Skull_active_png_1811862907:Class;
        private var _967396880m_UIBottomContainer:HBox;
        private var _embed_css_images_Slot_InventoryBackpack_protected_png_278754206:Class;
        private var _embed_css_images_Border02_WidgetSidebar_png_584799829:Class;
        private var _embed_css_images_Button_Maximize_over_png_853065390:Class;
        private var _2043305115m_UIActionBarRight:VActionBarWidget;
        private var _embed_css_images_Button_PurchaseComplete_over_png_1670828928:Class;
        private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_582119269:Class;
        private var _embed_css_images_Button_Minimize_over_png_1857747508:Class;
        private var _embed_css_images_Minimap_ZoomIn_over_png_1744305367:Class;
        private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1138143095:Class;
        private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925:Class;
        protected var m_AppearanceStorage:AppearanceStorage = null;
        private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tl_over_png_424714789:Class;
        private var _embed_css_images_Slot_InventoryBackpack_png_1145397297:Class;
        private var _embed_css____images_prey_prey_list_reroll_reactivate_disabled_png_204334064:Class;
        private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_562446159:Class;
        private var _embed_css_images_Button_Close_idle_png_1491572338:Class;
        private var _embed_css_images_Button_Minimize_idle_png_996649268:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_tl_idle_png_1066808312:Class;
        private var _629924354m_UIActionBarBottom:HActionBarWidget;
        public var _Tibia_Array1:Array;
        public var _Tibia_Array2:Array;
        private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_165887905:Class;
        private var _embed_css_images_BG_Bars_fat_enpiece_png_285397664:Class;
        private var _embed_css_images_Button_Combat_Stop_over_png_222586327:Class;
        protected var m_ConnectionDataCurrent:int = -1;
        private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_332190833:Class;
        private var _embed_css_images_BG_Bars_default_enpiece_png_341854824:Class;
        private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1681910211:Class;
        private var _embed_css_images_BarsHealth_default_RedLow2_png_1319540706:Class;
        private var _embed_css_images_slot_container_disabled_png_2017818209:Class;
        private var _embed_css_____assets_images_imbuing_imbuing_icon_imbue_active_png_2078825278:Class;
        private var _embed_css_images_Arrow_WidgetToggle_over_png_468729605:Class;
        private var _embed_css_images_BarsHealth_default_GreenLow_png_1615903576:Class;
        private var _embed_css_images_BG_Bars_fat_tileable_png_1719993865:Class;
        private var _embed_css_images_Icon_NoPremium_png_619567132:Class;
        private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_634503524:Class;
        private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_634011235:Class;
        private var _748017946m_UIInputHandler:InputHandler;
        private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_390355041:Class;
        private var _embed_css_images_BG_Widget_Menu_png_1523929844:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_ml_over_png_158167172:Class;
        private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_369785836:Class;
        private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2114894105:Class;
        private var _1423351586m_UIActionBarTop:HActionBarWidget;
        private var _embed_css_images_Icons_CombatControls_PvPOff_idle_png_1518483442:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Spells_png_653028639:Class;
        private var _embed_css_images_Icons_Inventory_StoreInbox_png_1901440063:Class;
        private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_44831157:Class;
        private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_230798747:Class;
        private var _64278962m_UISideBarD:SideBarWidget;
        private var _embed_css_images_custombutton_Button_Border_tileable_bl_over_png_269609286:Class;
        private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1990651256:Class;
        private var _embed_css_images_BarsHealth_fat_RedLow_png_630566510:Class;
        private var _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878:Class;
        private var _embed_css_images_custombutton_Button_IngameShopBuy_tileable_idle_png_130764314:Class;
        private var _embed_css_images_custombutton_Button_IngameShopBuy_tileable_pressed_png_1350701846:Class;
        private var _embed_css_images_custombutton_Button_Border_tileable_tc_disabled_png_744772701:Class;
        protected var m_TutorialData:Object;
        private var _embed_css_images_Button_Maximize_pressed_png_1415129086:Class;
        private var _embed_css____images_prey_prey_list_reroll_small_reactivate_png_1299157975:Class;
        protected var m_EnableFocusNotifier:Boolean = true;
        protected var m_CurrentOptionsUploading:Boolean = false;
        private var _embed_css_images_ChatTab_tileable_idle_png_627868017:Class;
        private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_814885792:Class;
        private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_726197318:Class;
        private var _embed_css_images_Icons_Conditions_PZlock_png_2127619469:Class;
        private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1100929387:Class;
        private var _embed_css_images_BuySellTab_idle_png_1415167540:Class;
        protected var m_ChatStorage:ChatStorage = null;
        protected var m_Player:Player = null;
        private var _embed_css_images_custombutton_Button_Border_tileable_ml_disabled_png_1201650483:Class;
        private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1544269709:Class;
        private var _embed_css_images_Button_Minimize_pressed_png_1803996148:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_ml_over_png_1301417569:Class;
        protected var m_SessionKey:String = null;
        private var _embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_123367643:Class;
        private var _embed_css_images_BG_BohemianTileable_Game_png_821519408:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_239928278:Class;
        private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_616546202:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_bl_over_png_505981842:Class;
        private var _embed_css_images_Icon_Premium_png_299837787:Class;
        private var _embed_css_images_Bars_ProgressMarker_png_1220674660:Class;
        private var _embed_css_images_Minimap_Center_active_png_1997427884:Class;
        private var _embed_css_images_Icons_Conditions_Cursed_png_90499082:Class;
        private var _embed_css_images_BG_Combat_ExpertOn_png_1994504722:Class;
        private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1945447166:Class;
        private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
        private var _665607314m_UISideBarToggleRight:ToggleBar;
        protected var m_SeconaryTimer:Timer = null;
        private var _embed_css____images_prey_prey_list_reroll_disabled_png_1005632601:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_tl_over_png_1949119752:Class;
        private var _embed_css____images_prey_prey_list_reroll_small_disabled_png_600614801:Class;
        private var _embed_css_images_BarsHealth_default_Mana_png_2142805618:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_tl_disabled_png_1116270317:Class;
        private var _embed_css_images_custombutton_Button_Highlight_tileable_bl_pressed_png_564600482:Class;
        private var _embed_css_images_BarsXP_default_malus_png_1223952997:Class;
        protected var m_Communication:Communication = null;
        private var _embed_css_images_BG_Bars_default_tileable_png_402625151:Class;
        protected var m_MiniMapStorage:MiniMapStorage = null;
        private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_274255324:Class;
        private var _embed_css_images_Button_PurchaseComplete_pressed_png_296592240:Class;
        private var _embed_css____images_prey_prey_list_reroll_small_png_860092972:Class;
        private var _embed_css_images_Icons_ProgressBars_Fishing_png_159411631:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_894372018:Class;
        private var _embed_css_images_Button_PurchaseComplete_idle_png_1219313536:Class;
        private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_779396374:Class;
        private var _883427326m_UIChatWidget:ChatWidget;
        private var _embed_css_images_custombutton_Button_Gold_tileable_ml_idle_png_2119528289:Class;
        private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_9825491:Class;
        var _watchers:Array;
        private var _embed_css_images_Icons_WidgetHeaders_VipList_png_570669695:Class;
        private var _embed_css_images_Minimap_ZoomOut_pressed_png_834344966:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_tl_pressed_png_96476760:Class;
        private var m_GameActionFactory:GameActionFactory = null;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bl_pressed_png_1258615591:Class;
        protected var m_ChannelsPending:Vector.<int> = null;
        private var _embed_css_images_Slot_InventoryRing_png_534601697:Class;
        private var _embed_css_images_Button_ContainerUp_over_png_533315994:Class;
        private var m_ConnectionLostDialog:ConnectionLostWidget;
        private var _embed_css_images_Slot_InventoryAmmo_protected_png_437721124:Class;
        private var _embed_css_images_Button_LockHotkeys_Locked_over_png_208376919:Class;
        private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_931245694:Class;
        private var _embed_css_images_Icons_CombatControls_StandOff_over_png_549332482:Class;
        private var _embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558016314:Class;
        private var _embed_css_images_BarsHealth_fat_RedFull_png_663565691:Class;
        private var _embed_css_images_BarsHealth_compact_Mana_png_1849035652:Class;
        private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_848728905:Class;
        private var _embed_css_images_BG_Combat_ExpertOff_png_793516502:Class;
        private var _embed_css_images_custombutton_Button_Standard_tileable_bl_disabled_png_953976447:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_mc_over_png_387132358:Class;
        private var _embed_css_images_BarsHealth_fat_RedLow2_png_2105859306:Class;
        private var _embed_css_images_slot_Hotkey_png_1006833303:Class;
        private var _embed_css_images_Icons_CombatControls_ExpertMode_over_png_420435450:Class;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _embed_css_images_Slot_InventoryWeapon_png_1721833083:Class;
        private var _embed_css_images_Icons_Conditions_Poisoned_png_1540003537:Class;
        private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_2033089433:Class;
        private var _embed_css_images_BG_Bars_compact_enpiece_png_1259288550:Class;
        private var _embed_css_images_custombutton_Button_Gold_tileable_mc_pressed_png_1792782474:Class;
        private var _embed_css_images_slot_Hotkey_highlighted_png_1467341187:Class;
        static const CONNECTION_STATE_GAME:int = 4;
        private static const SHAREDOBJECT_NAME:String = "options";
        static const CONNECTION_STATE_PENDING:int = 3;
        public static const BUGGY_FLASH_PLAYER_VERSION:String = "21,0,0,182";
        public static const PROTOCOL_VERSION:int = 1140;
        public static var s_FrameTibiaTimestamp:Number = 0;
        public static var s_FrameRealTimestamp:Number = 0;
        static const ERR_INVALID_SIZE:int = 1;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        public static const MAX_SESSION_KEY_LENGTH:int = 30;
        public static const CLIENT_TYPE:uint = 3;
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        static const PACKETLENGTH_SIZE:int = 2;
        private static var s_LastTibiaFactorChangeRealTimestamp:int = 0;
        public static const CLIENT_VERSION:uint = 2483;
        public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
        static const PAYLOADLENGTH_POS:int = 6;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        private static const OPTIONS_SAVE_INTERVAL:int = 1.8e+006;
        public static const PREVIEW_STATE_REGULAR:uint = 0;
        static const ERR_INVALID_CHECKSUM:int = 2;
        static const PAYLOADDATA_POSITION:int = 8;
        static const HEADER_SIZE:int = 6;
        static const ERR_INTERNAL:int = 0;
        static const SEQUENCE_NUMBER_POS:int = 2;
        static var _Tibia_StylesInit_done:Boolean = false;
        static const HEADER_POS:int = 0;
        static const ERR_INVALID_MESSAGE:int = 3;
        public static var s_TibiaLoginTimestamp:Number = 0;
        private static const BUNDLE:String = "Tibia";
        public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
        static const ERR_INVALID_STATE:int = 4;
        static const PAYLOADLENGTH_SIZE:int = 2;
        private static var s_InternalTibiaTimerFactor:Number = 1;
        public static const CLIENT_PREVIEW_STATE:uint = 0;
        static const SEQUENCE_NUMBER_SIZE:int = 4;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
        private static var s_LastTibiaTimestamp:int = 0;
        static const PACKETLENGTH_POS:int = 0;
        static const ERR_CONNECTION_LOST:int = 6;
        static const PAYLOAD_POS:int = 6;

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
            this._embed_css_____assets_images_imbuing_imbuing_icon_imbue_active_png_2078825278 = Tibia__embed_css_____assets_images_imbuing_imbuing_icon_imbue_active_png_2078825278;
            this._embed_css_____assets_images_imbuing_imbuing_icon_imbue_disabled_png_2110185778 = Tibia__embed_css_____assets_images_imbuing_imbuing_icon_imbue_disabled_png_2110185778;
            this._embed_css_____assets_images_imbuing_imbuing_icon_remove_active_png_857913398 = Tibia__embed_css_____assets_images_imbuing_imbuing_icon_remove_active_png_857913398;
            this._embed_css_____assets_images_imbuing_imbuing_icon_remove_disabled_png_1334606270 = Tibia__embed_css_____assets_images_imbuing_imbuing_icon_remove_disabled_png_1334606270;
            this._embed_css_____assets_images_imbuing_imbuing_icon_useprotection_active_png_532986814 = Tibia__embed_css_____assets_images_imbuing_imbuing_icon_useprotection_active_png_532986814;
            this._embed_css_____assets_images_imbuing_imbuing_icon_useprotection_disabled_png_494797810 = Tibia__embed_css_____assets_images_imbuing_imbuing_icon_useprotection_disabled_png_494797810;
            this._embed_css_____assets_images_imbuing_imbuing_slot_empty_png_768110180 = Tibia__embed_css_____assets_images_imbuing_imbuing_slot_empty_png_768110180;
            this._embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_423192446 = Tibia__embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_423192446;
            this._embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_920566008 = Tibia__embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_920566008;
            this._embed_css____images_prey_prey_bonus_reroll_disabled_png_192280102 = Tibia__embed_css____images_prey_prey_bonus_reroll_disabled_png_192280102;
            this._embed_css____images_prey_prey_bonus_reroll_png_1391458109 = Tibia__embed_css____images_prey_prey_bonus_reroll_png_1391458109;
            this._embed_css____images_prey_prey_confirm_monster_selection_disabled_png_1811398472 = Tibia__embed_css____images_prey_prey_confirm_monster_selection_disabled_png_1811398472;
            this._embed_css____images_prey_prey_confirm_monster_selection_png_1917808293 = Tibia__embed_css____images_prey_prey_confirm_monster_selection_png_1917808293;
            this._embed_css____images_prey_prey_list_reroll_disabled_png_1005632601 = Tibia__embed_css____images_prey_prey_list_reroll_disabled_png_1005632601;
            this._embed_css____images_prey_prey_list_reroll_png_1451613866 = Tibia__embed_css____images_prey_prey_list_reroll_png_1451613866;
            this._embed_css____images_prey_prey_list_reroll_reactivate_disabled_png_204334064 = Tibia__embed_css____images_prey_prey_list_reroll_reactivate_disabled_png_204334064;
            this._embed_css____images_prey_prey_list_reroll_reactivate_png_1235856493 = Tibia__embed_css____images_prey_prey_list_reroll_reactivate_png_1235856493;
            this._embed_css____images_prey_prey_list_reroll_small_disabled_png_600614801 = Tibia__embed_css____images_prey_prey_list_reroll_small_disabled_png_600614801;
            this._embed_css____images_prey_prey_list_reroll_small_png_860092972 = Tibia__embed_css____images_prey_prey_list_reroll_small_png_860092972;
            this._embed_css____images_prey_prey_list_reroll_small_reactivate_disabled_png_1943789254 = Tibia__embed_css____images_prey_prey_list_reroll_small_reactivate_disabled_png_1943789254;
            this._embed_css____images_prey_prey_list_reroll_small_reactivate_png_1299157975 = Tibia__embed_css____images_prey_prey_list_reroll_small_reactivate_png_1299157975;
            this._embed_css____images_prey_prey_unlock_permanently_png_2084364847 = Tibia__embed_css____images_prey_prey_unlock_permanently_png_2084364847;
            this._embed_css____images_prey_prey_unlock_temporarily_png_1205226112 = Tibia__embed_css____images_prey_prey_unlock_temporarily_png_1205226112;
            this._embed_css_images_Arrow_HotkeyToggle_BG_png_162240878 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
            this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_271327590 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_271327590;
            this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_616546202 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_616546202;
            this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1801889674 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1801889674;
            this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793;
            this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023;
            this._embed_css_images_Arrow_ScrollHotkeys_over_png_585745991 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_585745991;
            this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487;
            this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907;
            this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_468614837 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_468614837;
            this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1482270485 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1482270485;
            this._embed_css_images_Arrow_ScrollTabs_disabled_png_879110432 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
            this._embed_css_images_Arrow_ScrollTabs_idle_png_2086059672 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
            this._embed_css_images_Arrow_ScrollTabs_over_png_1323680872 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
            this._embed_css_images_Arrow_ScrollTabs_pressed_png_225438040 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
            this._embed_css_images_Arrow_WidgetToggle_BG_png_2128357260 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
            this._embed_css_images_Arrow_WidgetToggle_idle_png_952187387 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
            this._embed_css_images_Arrow_WidgetToggle_over_png_468729605 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_468729605;
            this._embed_css_images_Arrow_WidgetToggle_pressed_png_948994267 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
            this._embed_css_images_BG_BarsProgress_compact_endpiece_png_1370317653 = Tibia__embed_css_images_BG_BarsProgress_compact_endpiece_png_1370317653;
            this._embed_css_images_BG_BarsProgress_compact_tileable_png_1434705776 = Tibia__embed_css_images_BG_BarsProgress_compact_tileable_png_1434705776;
            this._embed_css_images_BG_BarsXP_default_endpiece_png_1805006002 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
            this._embed_css_images_BG_BarsXP_default_tileable_png_1802488215 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
            this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789;
            this._embed_css_images_BG_Bars_compact_enpiece_png_1259288550 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1259288550;
            this._embed_css_images_BG_Bars_compact_tileable_png_1504529517 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1504529517;
            this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
            this._embed_css_images_BG_Bars_default_enpiece_png_341854824 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_341854824;
            this._embed_css_images_BG_Bars_default_tileable_png_402625151 = Tibia__embed_css_images_BG_Bars_default_tileable_png_402625151;
            this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925;
            this._embed_css_images_BG_Bars_fat_enpiece_png_285397664 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_285397664;
            this._embed_css_images_BG_Bars_fat_tileable_png_1719993865 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1719993865;
            this._embed_css_images_BG_BohemianTileable_ChatConsole_png_2130554773 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_2130554773;
            this._embed_css_images_BG_BohemianTileable_Game_png_821519408 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_821519408;
            this._embed_css_images_BG_BohemianTileable_png_1422729109 = Tibia__embed_css_images_BG_BohemianTileable_png_1422729109;
            this._embed_css_images_BG_ChatTab_Tabdrop_png_344159956 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_344159956;
            this._embed_css_images_BG_ChatTab_tileable_png_1482271674 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1482271674;
            this._embed_css_images_BG_Combat_ExpertOff_png_793516502 = Tibia__embed_css_images_BG_Combat_ExpertOff_png_793516502;
            this._embed_css_images_BG_Combat_ExpertOn_png_1994504722 = Tibia__embed_css_images_BG_Combat_ExpertOn_png_1994504722;
            this._embed_css_images_BG_Stone2_Tileable_png_2089033964 = Tibia__embed_css_images_BG_Stone2_Tileable_png_2089033964;
            this._embed_css_images_BG_Widget_Menu_png_1523929844 = Tibia__embed_css_images_BG_Widget_Menu_png_1523929844;
            this._embed_css_images_BarsHealth_compact_GreenFull_png_658108631 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_658108631;
            this._embed_css_images_BarsHealth_compact_GreenLow_png_1230640774 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_1230640774;
            this._embed_css_images_BarsHealth_compact_Mana_png_1849035652 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1849035652;
            this._embed_css_images_BarsHealth_compact_RedFull_png_1785716075 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1785716075;
            this._embed_css_images_BarsHealth_compact_RedLow2_png_673302076 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_673302076;
            this._embed_css_images_BarsHealth_compact_RedLow_png_432309528 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_432309528;
            this._embed_css_images_BarsHealth_compact_Yellow_png_824185175 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_824185175;
            this._embed_css_images_BarsHealth_default_GreenFull_png_539233669 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_539233669;
            this._embed_css_images_BarsHealth_default_GreenLow_png_1615903576 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1615903576;
            this._embed_css_images_BarsHealth_default_Mana_png_2142805618 = Tibia__embed_css_images_BarsHealth_default_Mana_png_2142805618;
            this._embed_css_images_BarsHealth_default_RedFull_png_471797811 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_471797811;
            this._embed_css_images_BarsHealth_default_RedLow2_png_1319540706 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1319540706;
            this._embed_css_images_BarsHealth_default_RedLow_png_1323495386 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1323495386;
            this._embed_css_images_BarsHealth_default_Yellow_png_338291605 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_338291605;
            this._embed_css_images_BarsHealth_fat_GreenFull_png_1012481779 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_1012481779;
            this._embed_css_images_BarsHealth_fat_GreenLow_png_23264160 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_23264160;
            this._embed_css_images_BarsHealth_fat_Mana_png_1830736570 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1830736570;
            this._embed_css_images_BarsHealth_fat_RedFull_png_663565691 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_663565691;
            this._embed_css_images_BarsHealth_fat_RedLow2_png_2105859306 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_2105859306;
            this._embed_css_images_BarsHealth_fat_RedLow_png_630566510 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_630566510;
            this._embed_css_images_BarsHealth_fat_Yellow_png_917594525 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_917594525;
            this._embed_css_images_BarsProgress_compact_orange_png_198580350 = Tibia__embed_css_images_BarsProgress_compact_orange_png_198580350;
            this._embed_css_images_BarsXP_default__png_162149957 = Tibia__embed_css_images_BarsXP_default__png_162149957;
            this._embed_css_images_BarsXP_default_improved_png_1481613863 = Tibia__embed_css_images_BarsXP_default_improved_png_1481613863;
            this._embed_css_images_BarsXP_default_malus_png_1223952997 = Tibia__embed_css_images_BarsXP_default_malus_png_1223952997;
            this._embed_css_images_BarsXP_default_zero_png_1390467341 = Tibia__embed_css_images_BarsXP_default_zero_png_1390467341;
            this._embed_css_images_Bars_ProgressMarker_png_1220674660 = Tibia__embed_css_images_Bars_ProgressMarker_png_1220674660;
            this._embed_css_images_Border02_WidgetSidebar_png_584799829 = Tibia__embed_css_images_Border02_WidgetSidebar_png_584799829;
            this._embed_css_images_Border02_WidgetSidebar_slim_png_420837653 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_420837653;
            this._embed_css_images_Border02_corners_png_2023953407 = Tibia__embed_css_images_Border02_corners_png_2023953407;
            this._embed_css_images_Border02_png_248151906 = Tibia__embed_css_images_Border02_png_248151906;
            this._embed_css_images_Border_Widget_corner_png_30247409 = Tibia__embed_css_images_Border_Widget_corner_png_30247409;
            this._embed_css_images_Border_Widget_png_123662323 = Tibia__embed_css_images_Border_Widget_png_123662323;
            this._embed_css_images_Button_ChatTabIgnore_idle_png_1319268057 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_1319268057;
            this._embed_css_images_Button_ChatTabIgnore_over_png_503059495 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_503059495;
            this._embed_css_images_Button_ChatTabIgnore_pressed_png_922258679 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_922258679;
            this._embed_css_images_Button_ChatTabNew_idle_png_1804753881 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1804753881;
            this._embed_css_images_Button_ChatTabNew_over_png_541842649 = Tibia__embed_css_images_Button_ChatTabNew_over_png_541842649;
            this._embed_css_images_Button_ChatTabNew_pressed_png_923606007 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_923606007;
            this._embed_css_images_Button_ChatTab_Close_idle_png_1074740208 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1074740208;
            this._embed_css_images_Button_ChatTab_Close_over_png_1945347312 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1945347312;
            this._embed_css_images_Button_ChatTab_Close_pressed_png_1705582336 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1705582336;
            this._embed_css_images_Button_Close_disabled_png_585602746 = Tibia__embed_css_images_Button_Close_disabled_png_585602746;
            this._embed_css_images_Button_Close_idle_png_1491572338 = Tibia__embed_css_images_Button_Close_idle_png_1491572338;
            this._embed_css_images_Button_Close_over_png_1824069490 = Tibia__embed_css_images_Button_Close_over_png_1824069490;
            this._embed_css_images_Button_Close_pressed_png_1495633374 = Tibia__embed_css_images_Button_Close_pressed_png_1495633374;
            this._embed_css_images_Button_Combat_Stop_idle_png_2028013783 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_2028013783;
            this._embed_css_images_Button_Combat_Stop_over_png_222586327 = Tibia__embed_css_images_Button_Combat_Stop_over_png_222586327;
            this._embed_css_images_Button_Combat_Stop_pressed_png_1195446471 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1195446471;
            this._embed_css_images_Button_ContainerUp_idle_png_883766938 = Tibia__embed_css_images_Button_ContainerUp_idle_png_883766938;
            this._embed_css_images_Button_ContainerUp_over_png_533315994 = Tibia__embed_css_images_Button_ContainerUp_over_png_533315994;
            this._embed_css_images_Button_ContainerUp_pressed_png_571520662 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_571520662;
            this._embed_css_images_Button_LockHotkeys_Locked_idle_png_1093080407 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_1093080407;
            this._embed_css_images_Button_LockHotkeys_Locked_over_png_208376919 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_208376919;
            this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_583051058 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_583051058;
            this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_933660722 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_933660722;
            this._embed_css_images_Button_MaximizePremium_idle_png_1480797397 = Tibia__embed_css_images_Button_MaximizePremium_idle_png_1480797397;
            this._embed_css_images_Button_MaximizePremium_over_png_267955669 = Tibia__embed_css_images_Button_MaximizePremium_over_png_267955669;
            this._embed_css_images_Button_Maximize_idle_png_960737362 = Tibia__embed_css_images_Button_Maximize_idle_png_960737362;
            this._embed_css_images_Button_Maximize_over_png_853065390 = Tibia__embed_css_images_Button_Maximize_over_png_853065390;
            this._embed_css_images_Button_Maximize_pressed_png_1415129086 = Tibia__embed_css_images_Button_Maximize_pressed_png_1415129086;
            this._embed_css_images_Button_Minimize_idle_png_996649268 = Tibia__embed_css_images_Button_Minimize_idle_png_996649268;
            this._embed_css_images_Button_Minimize_over_png_1857747508 = Tibia__embed_css_images_Button_Minimize_over_png_1857747508;
            this._embed_css_images_Button_Minimize_pressed_png_1803996148 = Tibia__embed_css_images_Button_Minimize_pressed_png_1803996148;
            this._embed_css_images_Button_PurchaseComplete_idle_png_1219313536 = Tibia__embed_css_images_Button_PurchaseComplete_idle_png_1219313536;
            this._embed_css_images_Button_PurchaseComplete_over_png_1670828928 = Tibia__embed_css_images_Button_PurchaseComplete_over_png_1670828928;
            this._embed_css_images_Button_PurchaseComplete_pressed_png_296592240 = Tibia__embed_css_images_Button_PurchaseComplete_pressed_png_296592240;
            this._embed_css_images_BuySellTab_active_png_1722132850 = Tibia__embed_css_images_BuySellTab_active_png_1722132850;
            this._embed_css_images_BuySellTab_idle_png_1415167540 = Tibia__embed_css_images_BuySellTab_idle_png_1415167540;
            this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
            this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
            this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
            this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
            this._embed_css_images_ChatTab_tileable_idle_png_627868017 = Tibia__embed_css_images_ChatTab_tileable_idle_png_627868017;
            this._embed_css_images_ChatTab_tileable_png_883140798 = Tibia__embed_css_images_ChatTab_tileable_png_883140798;
            this._embed_css_images_ChatWindow_Mover_png_2100462174 = Tibia__embed_css_images_ChatWindow_Mover_png_2100462174;
            this._embed_css_images_Icon_NoPremium_png_619567132 = Tibia__embed_css_images_Icon_NoPremium_png_619567132;
            this._embed_css_images_Icon_Premium_png_299837787 = Tibia__embed_css_images_Icon_Premium_png_299837787;
            this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_234622227 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_234622227;
            this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1589130474 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1589130474;
            this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1236418872 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1236418872;
            this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1260863432 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1260863432;
            this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_274255324 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_274255324;
            this._embed_css_images_Icons_BattleList_HideNPCs_active_png_2145118177 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_2145118177;
            this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1784655247 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1784655247;
            this._embed_css_images_Icons_BattleList_HideNPCs_over_png_917250191 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_917250191;
            this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058;
            this._embed_css_images_Icons_BattleList_HidePlayers_active_png_613329023 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_613329023;
            this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_177601341 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_177601341;
            this._embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683;
            this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1205967224 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1205967224;
            this._embed_css_images_Icons_BattleList_HideSkulled_active_png_2021231179 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_2021231179;
            this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_428456803 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_428456803;
            this._embed_css_images_Icons_BattleList_HideSkulled_over_png_634011235 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_634011235;
            this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_138520421 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_138520421;
            this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1666844766 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1666844766;
            this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_788781616 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_788781616;
            this._embed_css_images_Icons_BattleList_PartyMembers_over_png_79143632 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_79143632;
            this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1165139419 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1165139419;
            this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_294457563 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_294457563;
            this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1971662251 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1971662251;
            this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_523657045 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_523657045;
            this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2114894105 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2114894105;
            this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1337920135 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1337920135;
            this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_369785836 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_369785836;
            this._embed_css_images_Icons_CombatControls_DoveOff_over_png_893524756 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_893524756;
            this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_1799831422 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_1799831422;
            this._embed_css_images_Icons_CombatControls_DoveOn_over_png_931245694 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_931245694;
            this._embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_123367643 = Tibia__embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_123367643;
            this._embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1392963547 = Tibia__embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1392963547;
            this._embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_894372018 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_894372018;
            this._embed_css_images_Icons_CombatControls_ExpertMode_idle_png_754231034 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_idle_png_754231034;
            this._embed_css_images_Icons_CombatControls_ExpertMode_over_png_420435450 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_over_png_420435450;
            this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_1324480721 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_1324480721;
            this._embed_css_images_Icons_CombatControls_MediumOff_over_png_1017681455 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_1017681455;
            this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1550321475 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1550321475;
            this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1201440323 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1201440323;
            this._embed_css_images_Icons_CombatControls_Mounted_idle_png_332190833 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_332190833;
            this._embed_css_images_Icons_CombatControls_Mounted_over_png_526740337 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_526740337;
            this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_582119269 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_582119269;
            this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1660751461 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1660751461;
            this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_228803293 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_228803293;
            this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1911407069 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1911407069;
            this._embed_css_images_Icons_CombatControls_PvPOff_active_png_470312516 = Tibia__embed_css_images_Icons_CombatControls_PvPOff_active_png_470312516;
            this._embed_css_images_Icons_CombatControls_PvPOff_idle_png_1518483442 = Tibia__embed_css_images_Icons_CombatControls_PvPOff_idle_png_1518483442;
            this._embed_css_images_Icons_CombatControls_PvPOn_active_png_806196142 = Tibia__embed_css_images_Icons_CombatControls_PvPOn_active_png_806196142;
            this._embed_css_images_Icons_CombatControls_PvPOn_idle_png_325504288 = Tibia__embed_css_images_Icons_CombatControls_PvPOn_idle_png_325504288;
            this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1338322061 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1338322061;
            this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_1544269709 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_1544269709;
            this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_329965451 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_329965451;
            this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_744247435 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_744247435;
            this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1945447166 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1945447166;
            this._embed_css_images_Icons_CombatControls_StandOff_over_png_549332482 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_549332482;
            this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1148616102 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1148616102;
            this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1144518310 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1144518310;
            this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_283159200 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_283159200;
            this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_814885792 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_814885792;
            this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1088011342 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1088011342;
            this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1435348302 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1435348302;
            this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1235819155 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1235819155;
            this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_443456403 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_443456403;
            this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1100929387 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1100929387;
            this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1241884053 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1241884053;
            this._embed_css_images_Icons_Conditions_Bleeding_png_526934384 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_526934384;
            this._embed_css_images_Icons_Conditions_Burning_png_1677566757 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1677566757;
            this._embed_css_images_Icons_Conditions_Cursed_png_90499082 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_90499082;
            this._embed_css_images_Icons_Conditions_Dazzled_png_1747135488 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1747135488;
            this._embed_css_images_Icons_Conditions_Drowning_png_542106670 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_542106670;
            this._embed_css_images_Icons_Conditions_Drunk_png_45733786 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_45733786;
            this._embed_css_images_Icons_Conditions_Electrified_png_1245219382 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1245219382;
            this._embed_css_images_Icons_Conditions_Freezing_png_1444773940 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1444773940;
            this._embed_css_images_Icons_Conditions_Haste_png_378019693 = Tibia__embed_css_images_Icons_Conditions_Haste_png_378019693;
            this._embed_css_images_Icons_Conditions_Hungry_png_758019275 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_758019275;
            this._embed_css_images_Icons_Conditions_Logoutblock_png_358377557 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_358377557;
            this._embed_css_images_Icons_Conditions_MagicShield_png_557850584 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_557850584;
            this._embed_css_images_Icons_Conditions_PZ_png_2094848430 = Tibia__embed_css_images_Icons_Conditions_PZ_png_2094848430;
            this._embed_css_images_Icons_Conditions_PZlock_png_2127619469 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_2127619469;
            this._embed_css_images_Icons_Conditions_Poisoned_png_1540003537 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1540003537;
            this._embed_css_images_Icons_Conditions_Slowed_png_77123048 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_77123048;
            this._embed_css_images_Icons_Conditions_Strenghtened_png_695721049 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_695721049;
            this._embed_css_images_Icons_IngameShop_12x12_No_png_115059819 = Tibia__embed_css_images_Icons_IngameShop_12x12_No_png_115059819;
            this._embed_css_images_Icons_IngameShop_12x12_Yes_png_415896407 = Tibia__embed_css_images_Icons_IngameShop_12x12_Yes_png_415896407;
            this._embed_css_images_Icons_Inventory_StoreInbox_png_1901440063 = Tibia__embed_css_images_Icons_Inventory_StoreInbox_png_1901440063;
            this._embed_css_images_Icons_Inventory_Store_png_1162053375 = Tibia__embed_css_images_Icons_Inventory_Store_png_1162053375;
            this._embed_css_images_Icons_ProgressBars_AxeFighting_png_784879159 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_784879159;
            this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1530197035 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1530197035;
            this._embed_css_images_Icons_ProgressBars_CompactStyle_png_2100887615 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_2100887615;
            this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1681910211 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1681910211;
            this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_779396374 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_779396374;
            this._embed_css_images_Icons_ProgressBars_Fishing_png_159411631 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_159411631;
            this._embed_css_images_Icons_ProgressBars_FistFighting_png_744761447 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_744761447;
            this._embed_css_images_Icons_ProgressBars_LargeStyle_png_1083507847 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_1083507847;
            this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1093895878 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1093895878;
            this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_562446159 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_562446159;
            this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1779777081 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1779777081;
            this._embed_css_images_Icons_ProgressBars_ProgressOn_png_370747169 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_370747169;
            this._embed_css_images_Icons_ProgressBars_Shielding_png_599280960 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_599280960;
            this._embed_css_images_Icons_ProgressBars_SwordFighting_png_726197318 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_726197318;
            this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1396972083 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1396972083;
            this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1728022323 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1728022323;
            this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1075890131 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1075890131;
            this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_539137698 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_539137698;
            this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_349575074 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_349575074;
            this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1456372718 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1456372718;
            this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1517554948 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1517554948;
            this._embed_css_images_Icons_WidgetHeaders_Combat_png_375287802 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_375287802;
            this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_314099262 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_314099262;
            this._embed_css_images_Icons_WidgetHeaders_GetPremium_png_376682585 = Tibia__embed_css_images_Icons_WidgetHeaders_GetPremium_png_376682585;
            this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1405466304 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1405466304;
            this._embed_css_images_Icons_WidgetHeaders_Minimap_png_2033089433 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_2033089433;
            this._embed_css_images_Icons_WidgetHeaders_Prey_png_2056699772 = Tibia__embed_css_images_Icons_WidgetHeaders_Prey_png_2056699772;
            this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154048530 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154048530;
            this._embed_css_images_Icons_WidgetHeaders_Skull_png_1181631553 = Tibia__embed_css_images_Icons_WidgetHeaders_Skull_png_1181631553;
            this._embed_css_images_Icons_WidgetHeaders_Spells_png_653028639 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_653028639;
            this._embed_css_images_Icons_WidgetHeaders_Trades_png_17953531 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_17953531;
            this._embed_css_images_Icons_WidgetHeaders_VipList_png_570669695 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_570669695;
            this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_793986337 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_793986337;
            this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_1337425916 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_1337425916;
            this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_9825491 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_9825491;
            this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_239928278 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_239928278;
            this._embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_675712135 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_675712135;
            this._embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558016314 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558016314;
            this._embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1732180796 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1732180796;
            this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_390355041 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_390355041;
            this._embed_css_images_Icons_WidgetMenu_Combat_active_png_327192750 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_327192750;
            this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1137251407 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1137251407;
            this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1063594900 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1063594900;
            this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759328973 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759328973;
            this._embed_css_images_Icons_WidgetMenu_Containers_active_png_387529648 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_387529648;
            this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1806477361 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1806477361;
            this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_2144032898 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_2144032898;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_450488793 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_450488793;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_273763964 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_273763964;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1523904949 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1523904949;
            this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1439642702 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1439642702;
            this._embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_618087100 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_618087100;
            this._embed_css_images_Icons_WidgetMenu_GetPremium_active_png_377762303 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_active_png_377762303;
            this._embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1978490031 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1978490031;
            this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1138143095 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1138143095;
            this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_506655126 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_506655126;
            this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1428562487 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1428562487;
            this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1991267500 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1991267500;
            this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_13628752 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_13628752;
            this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_1080426003 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_1080426003;
            this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1920390846 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1920390846;
            this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_230798747 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_230798747;
            this._embed_css_images_Icons_WidgetMenu_Prey_active_over_png_21306593 = Tibia__embed_css_images_Icons_WidgetMenu_Prey_active_over_png_21306593;
            this._embed_css_images_Icons_WidgetMenu_Prey_active_png_2078269124 = Tibia__embed_css_images_Icons_WidgetMenu_Prey_active_png_2078269124;
            this._embed_css_images_Icons_WidgetMenu_Prey_idle_over_png_459157651 = Tibia__embed_css_images_Icons_WidgetMenu_Prey_idle_over_png_459157651;
            this._embed_css_images_Icons_WidgetMenu_Prey_idle_png_924058986 = Tibia__embed_css_images_Icons_WidgetMenu_Prey_idle_png_924058986;
            this._embed_css_images_Icons_WidgetMenu_Skull_active_over_png_616733832 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_active_over_png_616733832;
            this._embed_css_images_Icons_WidgetMenu_Skull_active_png_1811862907 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_active_png_1811862907;
            this._embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_626524886 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_626524886;
            this._embed_css_images_Icons_WidgetMenu_Skull_idle_png_1224099597 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_idle_png_1224099597;
            this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517102410 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517102410;
            this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1392106579 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1392106579;
            this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_634503524 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_634503524;
            this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730481697 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730481697;
            this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_47374454 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_47374454;
            this._embed_css_images_Icons_WidgetMenu_VipList_active_png_848728905 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_848728905;
            this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_412469896 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_412469896;
            this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_44831157 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_44831157;
            this._embed_css_images_Inventory_png_381497758 = Tibia__embed_css_images_Inventory_png_381497758;
            this._embed_css_images_Minimap_Center_active_png_1997427884 = Tibia__embed_css_images_Minimap_Center_active_png_1997427884;
            this._embed_css_images_Minimap_Center_idle_png_2012166886 = Tibia__embed_css_images_Minimap_Center_idle_png_2012166886;
            this._embed_css_images_Minimap_Center_over_png_279361510 = Tibia__embed_css_images_Minimap_Center_over_png_279361510;
            this._embed_css_images_Minimap_ZoomIn_idle_png_480998871 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_480998871;
            this._embed_css_images_Minimap_ZoomIn_over_png_1744305367 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1744305367;
            this._embed_css_images_Minimap_ZoomIn_pressed_png_1013656729 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1013656729;
            this._embed_css_images_Minimap_ZoomOut_idle_png_2125846326 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_2125846326;
            this._embed_css_images_Minimap_ZoomOut_over_png_353204682 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_353204682;
            this._embed_css_images_Minimap_ZoomOut_pressed_png_834344966 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_834344966;
            this._embed_css_images_Minimap_png_667670405 = Tibia__embed_css_images_Minimap_png_667670405;
            this._embed_css_images_Scrollbar_Arrow_down_idle_png_91820120 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_91820120;
            this._embed_css_images_Scrollbar_Arrow_down_over_png_1360238424 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1360238424;
            this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1990651256 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1990651256;
            this._embed_css_images_Scrollbar_Arrow_up_idle_png_18741135 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_18741135;
            this._embed_css_images_Scrollbar_Arrow_up_over_png_860191089 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_860191089;
            this._embed_css_images_Scrollbar_Arrow_up_pressed_png_165887905 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_165887905;
            this._embed_css_images_Scrollbar_Handler_png_760479401 = Tibia__embed_css_images_Scrollbar_Handler_png_760479401;
            this._embed_css_images_Scrollbar_tileable_png_1885091563 = Tibia__embed_css_images_Scrollbar_tileable_png_1885091563;
            this._embed_css_images_Slot_Hotkey_Cooldown_png_1017067163 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1017067163;
            this._embed_css_images_Slot_InventoryAmmo_png_675331507 = Tibia__embed_css_images_Slot_InventoryAmmo_png_675331507;
            this._embed_css_images_Slot_InventoryAmmo_protected_png_437721124 = Tibia__embed_css_images_Slot_InventoryAmmo_protected_png_437721124;
            this._embed_css_images_Slot_InventoryArmor_png_1841074918 = Tibia__embed_css_images_Slot_InventoryArmor_png_1841074918;
            this._embed_css_images_Slot_InventoryArmor_protected_png_919089929 = Tibia__embed_css_images_Slot_InventoryArmor_protected_png_919089929;
            this._embed_css_images_Slot_InventoryBackpack_png_1145397297 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1145397297;
            this._embed_css_images_Slot_InventoryBackpack_protected_png_278754206 = Tibia__embed_css_images_Slot_InventoryBackpack_protected_png_278754206;
            this._embed_css_images_Slot_InventoryBoots_png_1061018524 = Tibia__embed_css_images_Slot_InventoryBoots_png_1061018524;
            this._embed_css_images_Slot_InventoryBoots_protected_png_674517205 = Tibia__embed_css_images_Slot_InventoryBoots_protected_png_674517205;
            this._embed_css_images_Slot_InventoryHead_png_1231852719 = Tibia__embed_css_images_Slot_InventoryHead_png_1231852719;
            this._embed_css_images_Slot_InventoryHead_protected_png_1088319362 = Tibia__embed_css_images_Slot_InventoryHead_protected_png_1088319362;
            this._embed_css_images_Slot_InventoryLegs_png_2114818196 = Tibia__embed_css_images_Slot_InventoryLegs_png_2114818196;
            this._embed_css_images_Slot_InventoryLegs_protected_png_516995939 = Tibia__embed_css_images_Slot_InventoryLegs_protected_png_516995939;
            this._embed_css_images_Slot_InventoryNecklace_png_1808156997 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1808156997;
            this._embed_css_images_Slot_InventoryNecklace_protected_png_1799961580 = Tibia__embed_css_images_Slot_InventoryNecklace_protected_png_1799961580;
            this._embed_css_images_Slot_InventoryRing_png_534601697 = Tibia__embed_css_images_Slot_InventoryRing_png_534601697;
            this._embed_css_images_Slot_InventoryRing_protected_png_143630382 = Tibia__embed_css_images_Slot_InventoryRing_protected_png_143630382;
            this._embed_css_images_Slot_InventoryShield_png_125978696 = Tibia__embed_css_images_Slot_InventoryShield_png_125978696;
            this._embed_css_images_Slot_InventoryShield_protected_png_1742050537 = Tibia__embed_css_images_Slot_InventoryShield_protected_png_1742050537;
            this._embed_css_images_Slot_InventoryWeapon_png_1721833083 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1721833083;
            this._embed_css_images_Slot_InventoryWeapon_protected_png_2025859402 = Tibia__embed_css_images_Slot_InventoryWeapon_protected_png_2025859402;
            this._embed_css_images_Slot_Statusicon_highlighted_png_1332900150 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1332900150;
            this._embed_css_images_Slot_Statusicon_png_1415858734 = Tibia__embed_css_images_Slot_Statusicon_png_1415858734;
            this._embed_css_images_UnjustifiedPoints_png_1782736303 = Tibia__embed_css_images_UnjustifiedPoints_png_1782736303;
            this._embed_css_images_Widget_Footer_tileable_end01_png_99047970 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_99047970;
            this._embed_css_images_Widget_Footer_tileable_end02_png_100995747 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_100995747;
            this._embed_css_images_Widget_Footer_tileable_png_2102878075 = Tibia__embed_css_images_Widget_Footer_tileable_png_2102878075;
            this._embed_css_images_Widget_HeaderBG_png_730116019 = Tibia__embed_css_images_Widget_HeaderBG_png_730116019;
            this._embed_css_images_custombutton_Button_Border_tileable_bc_disabled_png_97198997 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bc_disabled_png_97198997;
            this._embed_css_images_custombutton_Button_Border_tileable_bc_idle_png_713449011 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bc_idle_png_713449011;
            this._embed_css_images_custombutton_Button_Border_tileable_bc_over_png_718071091 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bc_over_png_718071091;
            this._embed_css_images_custombutton_Button_Border_tileable_bc_pressed_png_1996698541 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bc_pressed_png_1996698541;
            this._embed_css_images_custombutton_Button_Border_tileable_bl_disabled_png_1996451214 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bl_disabled_png_1996451214;
            this._embed_css_images_custombutton_Button_Border_tileable_bl_idle_png_1479317574 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bl_idle_png_1479317574;
            this._embed_css_images_custombutton_Button_Border_tileable_bl_over_png_269609286 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bl_over_png_269609286;
            this._embed_css_images_custombutton_Button_Border_tileable_bl_pressed_png_1673065226 = Tibia__embed_css_images_custombutton_Button_Border_tileable_bl_pressed_png_1673065226;
            this._embed_css_images_custombutton_Button_Border_tileable_ml_disabled_png_1201650483 = Tibia__embed_css_images_custombutton_Button_Border_tileable_ml_disabled_png_1201650483;
            this._embed_css_images_custombutton_Button_Border_tileable_ml_idle_png_1245218325 = Tibia__embed_css_images_custombutton_Button_Border_tileable_ml_idle_png_1245218325;
            this._embed_css_images_custombutton_Button_Border_tileable_ml_over_png_427887893 = Tibia__embed_css_images_custombutton_Button_Border_tileable_ml_over_png_427887893;
            this._embed_css_images_custombutton_Button_Border_tileable_ml_pressed_png_1339953035 = Tibia__embed_css_images_custombutton_Button_Border_tileable_ml_pressed_png_1339953035;
            this._embed_css_images_custombutton_Button_Border_tileable_tc_disabled_png_744772701 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tc_disabled_png_744772701;
            this._embed_css_images_custombutton_Button_Border_tileable_tc_idle_png_1034633179 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tc_idle_png_1034633179;
            this._embed_css_images_custombutton_Button_Border_tileable_tc_over_png_1569901787 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tc_over_png_1569901787;
            this._embed_css_images_custombutton_Button_Border_tileable_tc_pressed_png_491469499 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tc_pressed_png_491469499;
            this._embed_css_images_custombutton_Button_Border_tileable_tl_disabled_png_929049956 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tl_disabled_png_929049956;
            this._embed_css_images_custombutton_Button_Border_tileable_tl_idle_png_460698220 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tl_idle_png_460698220;
            this._embed_css_images_custombutton_Button_Border_tileable_tl_over_png_1203653996 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tl_over_png_1203653996;
            this._embed_css_images_custombutton_Button_Border_tileable_tl_pressed_png_1978729388 = Tibia__embed_css_images_custombutton_Button_Border_tileable_tl_pressed_png_1978729388;
            this._embed_css_images_custombutton_Button_Gold_tileable_bc_idle_png_1388109823 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_bc_idle_png_1388109823;
            this._embed_css_images_custombutton_Button_Gold_tileable_bc_over_png_1582917375 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_bc_over_png_1582917375;
            this._embed_css_images_custombutton_Button_Gold_tileable_bc_pressed_png_1314073167 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_bc_pressed_png_1314073167;
            this._embed_css_images_custombutton_Button_Gold_tileable_bl_idle_png_866059770 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_bl_idle_png_866059770;
            this._embed_css_images_custombutton_Button_Gold_tileable_bl_over_png_866883846 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_bl_over_png_866883846;
            this._embed_css_images_custombutton_Button_Gold_tileable_bl_pressed_png_1601544042 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_bl_pressed_png_1601544042;
            this._embed_css_images_custombutton_Button_Gold_tileable_mc_idle_png_144725306 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_mc_idle_png_144725306;
            this._embed_css_images_custombutton_Button_Gold_tileable_mc_over_png_387132358 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_mc_over_png_387132358;
            this._embed_css_images_custombutton_Button_Gold_tileable_mc_pressed_png_1792782474 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_mc_pressed_png_1792782474;
            this._embed_css_images_custombutton_Button_Gold_tileable_ml_idle_png_2119528289 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_ml_idle_png_2119528289;
            this._embed_css_images_custombutton_Button_Gold_tileable_ml_over_png_1301417569 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_ml_over_png_1301417569;
            this._embed_css_images_custombutton_Button_Gold_tileable_ml_pressed_png_1124837519 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_ml_pressed_png_1124837519;
            this._embed_css_images_custombutton_Button_Gold_tileable_tc_idle_png_354340239 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_tc_idle_png_354340239;
            this._embed_css_images_custombutton_Button_Gold_tileable_tc_over_png_701648527 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_tc_over_png_701648527;
            this._embed_css_images_custombutton_Button_Gold_tileable_tc_pressed_png_1001206657 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_tc_pressed_png_1001206657;
            this._embed_css_images_custombutton_Button_Gold_tileable_tl_idle_png_1066808312 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_tl_idle_png_1066808312;
            this._embed_css_images_custombutton_Button_Gold_tileable_tl_over_png_1949119752 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_tl_over_png_1949119752;
            this._embed_css_images_custombutton_Button_Gold_tileable_tl_pressed_png_96476760 = Tibia__embed_css_images_custombutton_Button_Gold_tileable_tl_pressed_png_96476760;
            this._embed_css_images_custombutton_Button_Highlight_tileable_bc_idle_png_1480530699 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_bc_idle_png_1480530699;
            this._embed_css_images_custombutton_Button_Highlight_tileable_bc_over_png_1545885173 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_bc_over_png_1545885173;
            this._embed_css_images_custombutton_Button_Highlight_tileable_bc_pressed_png_829106133 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_bc_pressed_png_829106133;
            this._embed_css_images_custombutton_Button_Highlight_tileable_bl_idle_png_299642002 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_bl_idle_png_299642002;
            this._embed_css_images_custombutton_Button_Highlight_tileable_bl_over_png_505981842 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_bl_over_png_505981842;
            this._embed_css_images_custombutton_Button_Highlight_tileable_bl_pressed_png_564600482 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_bl_pressed_png_564600482;
            this._embed_css_images_custombutton_Button_Highlight_tileable_ml_idle_png_1406639853 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_ml_idle_png_1406639853;
            this._embed_css_images_custombutton_Button_Highlight_tileable_ml_over_png_1626598931 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_ml_over_png_1626598931;
            this._embed_css_images_custombutton_Button_Highlight_tileable_ml_pressed_png_1710390195 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_ml_pressed_png_1710390195;
            this._embed_css_images_custombutton_Button_Highlight_tileable_tc_idle_png_1335630595 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_tc_idle_png_1335630595;
            this._embed_css_images_custombutton_Button_Highlight_tileable_tc_over_png_279471101 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_tc_over_png_279471101;
            this._embed_css_images_custombutton_Button_Highlight_tileable_tc_pressed_png_1605574371 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_tc_pressed_png_1605574371;
            this._embed_css_images_custombutton_Button_Highlight_tileable_tl_idle_png_919535868 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_tl_idle_png_919535868;
            this._embed_css_images_custombutton_Button_Highlight_tileable_tl_over_png_1790083580 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_tl_over_png_1790083580;
            this._embed_css_images_custombutton_Button_Highlight_tileable_tl_pressed_png_2061438852 = Tibia__embed_css_images_custombutton_Button_Highlight_tileable_tl_pressed_png_2061438852;
            this._embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_idle_png_546154478 = Tibia__embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_idle_png_546154478;
            this._embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_over_png_1892300526 = Tibia__embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_over_png_1892300526;
            this._embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_pressed_png_493785154 = Tibia__embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_pressed_png_493785154;
            this._embed_css_images_custombutton_Button_IngameShopBuy_tileable_idle_png_130764314 = Tibia__embed_css_images_custombutton_Button_IngameShopBuy_tileable_idle_png_130764314;
            this._embed_css_images_custombutton_Button_IngameShopBuy_tileable_over_png_1828072166 = Tibia__embed_css_images_custombutton_Button_IngameShopBuy_tileable_over_png_1828072166;
            this._embed_css_images_custombutton_Button_IngameShopBuy_tileable_pressed_png_1350701846 = Tibia__embed_css_images_custombutton_Button_IngameShopBuy_tileable_pressed_png_1350701846;
            this._embed_css_images_custombutton_Button_Standard_tileable_bc_disabled_png_2000142426 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bc_disabled_png_2000142426;
            this._embed_css_images_custombutton_Button_Standard_tileable_bc_idle_png_1913227682 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bc_idle_png_1913227682;
            this._embed_css_images_custombutton_Button_Standard_tileable_bc_over_png_46790494 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bc_over_png_46790494;
            this._embed_css_images_custombutton_Button_Standard_tileable_bc_pressed_png_969488782 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bc_pressed_png_969488782;
            this._embed_css_images_custombutton_Button_Standard_tileable_bl_disabled_png_953976447 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bl_disabled_png_953976447;
            this._embed_css_images_custombutton_Button_Standard_tileable_bl_idle_png_2093052983 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bl_idle_png_2093052983;
            this._embed_css_images_custombutton_Button_Standard_tileable_bl_over_png_1316684489 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bl_over_png_1316684489;
            this._embed_css_images_custombutton_Button_Standard_tileable_bl_pressed_png_1258615591 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_bl_pressed_png_1258615591;
            this._embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429;
            this._embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501;
            this._embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939;
            this._embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645;
            this._embed_css_images_custombutton_Button_Standard_tileable_ml_disabled_png_846678076 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_ml_disabled_png_846678076;
            this._embed_css_images_custombutton_Button_Standard_tileable_ml_idle_png_1658654332 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_ml_idle_png_1658654332;
            this._embed_css_images_custombutton_Button_Standard_tileable_ml_over_png_158167172 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_ml_over_png_158167172;
            this._embed_css_images_custombutton_Button_Standard_tileable_ml_pressed_png_236721532 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_ml_pressed_png_236721532;
            this._embed_css_images_custombutton_Button_Standard_tileable_tc_disabled_png_369402996 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tc_disabled_png_369402996;
            this._embed_css_images_custombutton_Button_Standard_tileable_tc_idle_png_700367956 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tc_idle_png_700367956;
            this._embed_css_images_custombutton_Button_Standard_tileable_tc_over_png_1962565460 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tc_over_png_1962565460;
            this._embed_css_images_custombutton_Button_Standard_tileable_tc_pressed_png_1408096916 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tc_pressed_png_1408096916;
            this._embed_css_images_custombutton_Button_Standard_tileable_tl_disabled_png_1116270317 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tl_disabled_png_1116270317;
            this._embed_css_images_custombutton_Button_Standard_tileable_tl_idle_png_1688019237 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tl_idle_png_1688019237;
            this._embed_css_images_custombutton_Button_Standard_tileable_tl_over_png_424714789 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tl_over_png_424714789;
            this._embed_css_images_custombutton_Button_Standard_tileable_tl_pressed_png_1833730757 = Tibia__embed_css_images_custombutton_Button_Standard_tileable_tl_pressed_png_1833730757;
            this._embed_css_images_slot_Hotkey_disabled_png_804094220 = Tibia__embed_css_images_slot_Hotkey_disabled_png_804094220;
            this._embed_css_images_slot_Hotkey_highlighted_png_1467341187 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_1467341187;
            this._embed_css_images_slot_Hotkey_png_1006833303 = Tibia__embed_css_images_slot_Hotkey_png_1006833303;
            this._embed_css_images_slot_Hotkey_protected_png_803702344 = Tibia__embed_css_images_slot_Hotkey_protected_png_803702344;
            this._embed_css_images_slot_container_disabled_png_2017818209 = Tibia__embed_css_images_slot_container_disabled_png_2017818209;
            this._embed_css_images_slot_container_highlighted_png_1302039720 = Tibia__embed_css_images_slot_container_highlighted_png_1302039720;
            this._embed_css_images_slot_container_png_1996786444 = Tibia__embed_css_images_slot_container_png_1996786444;
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

        public function get m_UIChatWidget() : ChatWidget
        {
            return this._883427326m_UIChatWidget;
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

        public function saveLocalData() : void
        {
            if (!(this.m_Connection is Sessiondump))
            {
                this.m_MiniMapStorage.saveSectors(true);
            }
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
            this.m_ConnectionEstablishedAndPacketReceived = false;
            this.m_Connection.addEventListener(ConnectionEvent.PENDING, this.onConnectionPending);
            this.m_Connection.addEventListener(ConnectionEvent.GAME, this.onConnectionGame);
            this.m_Connection.addEventListener(ConnectionEvent.CONNECTING, this.onConnectionConnecting);
            this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_LOST, this.onConnectionLost);
            this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_RECOVERED, this.onConnectionRecovered);
            this.m_Connection.addEventListener(ConnectionEvent.DEAD, this.onConnectionDeath);
            this.m_Connection.addEventListener(ConnectionEvent.DISCONNECTED, this.onConnectionDisconnected);
            this.m_Connection.addEventListener(ConnectionEvent.ERROR, this.onConnectionError);
            this.m_Connection.addEventListener(ConnectionEvent.LOGINCHALLENGE, this.onConnectionLoginChallenge);
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
                if (this.m_EnableFocusNotifier)
                {
                    if (this.m_IsActive == true)
                    {
                        FocusNotifier.getInstance().hide();
                    }
                    else
                    {
                        FocusNotifier.getInstance().show();
                    }
                }
            }
            return;
        }// end function

        public function get m_UIActionBarLeft() : VActionBarWidget
        {
            return this._1174474338m_UIActionBarLeft;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.horizontalGap = 0;
                this.rollOverColor = 2768716;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                this.rollOverAlpha = 0.5;
                this.textRollOverColor = 13221291;
                this.paddingTop = 0;
                this.textColor = 13221291;
                this.paddingLeft = 0;
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
                this.horizontalGridLineColor = 8089164;
                this.backgroundColor = "";
                this.borderColor = 8089164;
                this.selectionDuration = 0;
                this.alternatingItemColors = [1977654, 16711680];
                this.color = 13221291;
                this.selectionColor = 658961;
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.selectionEasingFunction = "";
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.borderThickness = 1;
                this.alternatingItemAlphas = [0.8, 0];
                this.rollOverColor = 2768716;
                this.verticalGridLines = true;
                this.verticalGridLineColor = 8089164;
                this.iconColor = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.horizontalGridLines = false;
                this.borderStyle = "solid";
                this.disabledIconColor = 13221291;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 1842980;
                this.paddingBottom = 0;
                this.paddingRight = 0;
                this.borderAlpha = 1;
                this.paddingTop = 0;
                this.borderStyle = "solid";
                this.paddingLeft = 0;
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
                this.selectedDownMask = "center";
                this.textAlign = "center";
                this.paddingRight = 2;
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_BuySellTab_idle_png_1415167540;
                this.paddingBottom = 0;
                this.selectedTextColor = 15904590;
                this.selectedOverCenterImage = _embed_css_images_BuySellTab_active_png_1722132850;
                this.defaultOverCenterImage = _embed_css_images_BuySellTab_idle_png_1415167540;
                this.selectedOverMask = "center";
                this.defaultTextColor = 15904590;
                this.defaultDownCenterImage = _embed_css_images_BuySellTab_idle_png_1415167540;
                this.selectedDownCenterImage = _embed_css_images_BuySellTab_active_png_1722132850;
                this.paddingTop = 0;
                this.paddingLeft = 2;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_BuySellTab_active_png_1722132850;
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
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownMask = "top";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultOverTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "top";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryRing_png_534601697;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("PreyView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("PreyView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.borderStyle = "solid";
                this.verticalGap = 2;
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
                this.defaultDisabledRightImage = "left";
                this.defaultDisabledBottomRightImage = "bottomLeft";
                this.paddingRight = 4;
                this.selectedOverTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_over_png_1569901787;
                this.selectedDisabledBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_disabled_png_97198997;
                this.selectedDownLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_pressed_png_1339953035;
                this.selectedOverLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_over_png_427887893;
                this.defaultOverBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_over_png_1316684489;
                this.defaultDisabledTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_disabled_png_369402996;
                this.defaultDownTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_pressed_png_1408096916;
                this.selectedOverBottomRightImage = "bottomLeft";
                this.defaultUpCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501;
                this.paddingBottom = 0;
                this.selectedDownTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_pressed_png_1978729388;
                this.textSelectedColor = 13221291;
                this.defaultDownCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645;
                this.selectedDownCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645;
                this.defaultDisabledTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_disabled_png_1116270317;
                this.selectedUpBottomRightImage = "bottomLeft";
                this.height = 22;
                this.defaultUpTopRightImage = "topLeft";
                this.selectedUpTopRightImage = "topLeft";
                this.selectedUpCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501;
                this.selectedDisabledTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_disabled_png_744772701;
                this.selectedDownMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDisabledTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_disabled_png_929049956;
                this.selectedOverTopRightImage = "topLeft";
                this.defaultOverLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_over_png_158167172;
                this.defaultDownMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedUpTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_idle_png_1034633179;
                this.selectedUpMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDownBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_pressed_png_1996698541;
                this.selectedDisabledBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_disabled_png_1996451214;
                this.selectedOverTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_over_png_1203653996;
                this.focusThickness = 0;
                this.defaultDownBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_pressed_png_1258615591;
                this.selectedDownBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_pressed_png_1673065226;
                this.defaultDownLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_pressed_png_236721532;
                this.defaultOverRightImage = "left";
                this.defaultOverCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939;
                this.defaultDisabledTopRightImage = "topLeft";
                this.selectedDownTopRightImage = "topLeft";
                this.selectedOverRightImage = "left";
                this.selectedUpRightImage = "left";
                this.textRollOverColor = 15904590;
                this.defaultUpLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_idle_png_1658654332;
                this.paddingLeft = 4;
                this.selectedOverBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_over_png_269609286;
                this.color = 15904590;
                this.defaultDisabledBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_disabled_png_953976447;
                this.selectedUpLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_idle_png_1245218325;
                this.skin = StyleSizedBitmapButtonSkin;
                this.defaultOverBottomRightImage = "bottomLeft";
                this.defaultOverBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_over_png_46790494;
                this.defaultDisabledLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_disabled_png_846678076;
                this.selectedUpBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_idle_png_1479317574;
                this.defaultDownBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_pressed_png_969488782;
                this.defaultUpRightImage = "left";
                this.defaultOverTopRightImage = "topLeft";
                this.defaultDownTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_pressed_png_1833730757;
                this.defaultDownRightImage = "left";
                this.defaultUpBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_idle_png_1913227682;
                this.selectedDisabledLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_disabled_png_1201650483;
                this.defaultUpTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_idle_png_700367956;
                this.selectedDisabledTopRightImage = "topLeft";
                this.defaultOverTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_over_png_1962565460;
                this.selectedDownRightImage = "left";
                this.selectedOverMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.paddingTop = 0;
                this.selectedUpTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_idle_png_460698220;
                this.defaultDisabledBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_disabled_png_2000142426;
                this.defaultOverMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDisabledRightImage = "left";
                this.selectedUpBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_idle_png_713449011;
                this.selectedDownBottomRightImage = "bottomLeft";
                this.defaultUpMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDisabledCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429;
                this.defaultUpBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_idle_png_2093052983;
                this.defaultDisabledCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429;
                this.defaultDisabledMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedOverBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_over_png_718071091;
                this.disabledColor = 15904590;
                this.defaultDownTopRightImage = "topLeft";
                this.defaultUpTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_idle_png_1688019237;
                this.defaultUpBottomRightImage = "bottomLeft";
                this.selectedDownTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_pressed_png_491469499;
                this.selectedOverCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939;
                this.width = 1;
                this.defaultDownBottomRightImage = "bottomLeft";
                this.selectedDisabledBottomRightImage = "bottomLeft";
                this.defaultOverTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_over_png_424714789;
                this.selectedDisabledMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.backgroundColor = 2240055;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.barImages = "barDefault";
                this.backgroundRightImage = _embed_css_images_BG_Bars_fat_enpiece_png_285397664;
                this.paddingRight = 1;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "left";
                this.rightOrnamentMask = "none";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_fat_tileable_png_1719993865;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barDefault = _embed_css_images_BarsHealth_fat_Mana_png_1830736570;
                this.leftOrnamentOffset = -6;
                this.rightOrnamentOffset = 6;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925;
                this.paddingLeft = 3;
                this.barLimits = 0;
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
                this.barImages = "barDefault";
                this.backgroundRightImage = _embed_css_images_BG_Bars_compact_enpiece_png_1259288550;
                this.paddingRight = 1;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "left";
                this.rightOrnamentMask = "none";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_compact_tileable_png_1504529517;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barDefault = _embed_css_images_BarsHealth_compact_Mana_png_1849035652;
                this.leftOrnamentOffset = -6;
                this.rightOrnamentOffset = 6;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789;
                this.paddingLeft = 3;
                this.barLimits = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatZeroSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatZeroSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_zero_png_1390467341;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
                return;
            }// end function
            ;
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.backgroundColor = 658961;
                this.horizontalGap = 32;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingRight = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 1;
                this.borderStyle = "solid";
                this.paddingLeft = 1;
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
                this.borderThickness = 1;
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.focusThickness = 0;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.borderStyle = "solid";
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
                this.progressBarMalusStyleName = "statusWidgetCompactMalusSkillProgress";
                this.verticalAlign = "middle";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetCompactBonusSkillProgress";
                this.progressBarZeroStyleName = "statusWidgetCompactZeroSkillProgress";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetCompactSkillProgress";
                this.labelStyleName = ".statusWidgetSkillProgress";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".slotsBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".slotsBox", style, false);
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
            style = StyleManager.getStyleDeclaration("GameWindowContainer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("GameWindowContainer", style, false);
            }
            style = StyleManager.getStyleDeclaration(".chatWidgetSingleView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chatWidgetSingleView", style, false);
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
                this.iconDefaultUpMask = "center";
                this.iconSelectedUpCenterImage = _embed_css_images_Button_LockHotkeys_Locked_idle_png_1093080407;
                this.iconSelectedUpMask = "center";
                this.icon = BitmapButtonIcon;
                this.skin = _embed_css_images_Slot_Statusicon_png_1415858734;
                this.iconDefaultUpCenterImage = _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_583051058;
                this.iconSelectedOverCenterImage = _embed_css_images_Button_LockHotkeys_Locked_over_png_208376919;
                this.iconDefaultDownMask = "center";
                this.iconDefaultDownCenterImage = _embed_css_images_Button_LockHotkeys_UnLocked_over_png_933660722;
                this.iconSelectedDownMask = "center";
                this.iconDefaultOverCenterImage = _embed_css_images_Button_LockHotkeys_UnLocked_over_png_933660722;
                this.iconSelectedDownCenterImage = _embed_css_images_Button_LockHotkeys_Locked_over_png_208376919;
                this.iconDefaultOverMask = "center";
                this.iconSelectedOverMask = "center";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".basePrice");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".basePrice", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 7829367;
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
                this.verticalAlign = "middle";
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.horizontalAlign = "left";
                this.paddingRight = 0;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1482271674;
                this.borderMask = "top";
                this.borderBottomImage = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 0;
                this.paddingLeft = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".withBorder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".withBorder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.verticalBigGap = 10;
                this.paddingRight = 1;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_2023953407;
                this.verticalGap = 1;
                this.horizontalBigGap = 10;
                this.horizontalGap = 1;
                this.paddingBottom = 1;
                this.borderRightImage = _embed_css_images_Border02_png_248151906;
                this.borderMask = "all";
                this.paddingTop = 0;
                this.paddingLeft = 1;
                this.borderCenterImage = _embed_css_images_BG_Stone2_Tileable_png_2089033964;
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
                this.borderThickness = 1;
                this.borderColor = 13221291;
                this.focusThickness = 0;
                this.highlightAlphas = [0, 0];
                this.iconColor = 13221291;
                this.borderAlpha = 1;
                this.fillColors = [4937051, 2501679];
                this.borderStyle = "solid";
                this.fillAlphas = [1, 1];
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_StandOff_idle_png_1945447166;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_294457563;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_StandOff_over_png_549332482;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_StandOff_over_png_549332482;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_294457563;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1165139419;
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
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.horizontalAlign = "left";
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1482271674;
                this.borderMask = "bottom";
                this.borderBottomImage = "top";
                this.paddingTop = 2;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 0;
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "left";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "left";
                this.defaultDownTopImage = "right";
                this.borderLeft = 0;
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.borderBottom = 0;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "right";
                this.iconSelectedUpMask = "right";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultDownMask = "left";
                this.selectedUpMask = "right";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.borderRight = 0;
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.borderTop = 0;
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.selectedOverMask = "right";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "left";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "left";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "left";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
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
                this.paddingBottom = 2;
                this.paddingRight = 8;
                this.icon = _embed_css_images_Icons_IngameShop_12x12_Yes_png_415896407;
                this.paddingTop = 2;
                this.paddingLeft = 8;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_230798747;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_13628752;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1920390846;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1920390846;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_13628752;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Minimap_active_png_1080426003;
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
                this.defaultUpCenterImage = _embed_css_images_Button_Close_idle_png_1491572338;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_Close_over_png_1824069490;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledCenterImage = _embed_css_images_Button_Close_disabled_png_585602746;
                this.defaultDisabledMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Button_Close_pressed_png_1495633374;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.horizontalGridLineColor = 8089164;
                this.backgroundColor = "";
                this.borderColor = 8089164;
                this.selectionDuration = 0;
                this.alternatingItemColors = [1977654, 16711680];
                this.color = 13221291;
                this.selectionColor = 658961;
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.selectionEasingFunction = "";
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.borderThickness = 1;
                this.alternatingItemAlphas = [0.8, 0];
                this.rollOverColor = 2768716;
                this.verticalGridLines = true;
                this.verticalGridLineColor = 8089164;
                this.iconColor = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.horizontalGridLines = false;
                this.borderStyle = "solid";
                this.disabledIconColor = 13221291;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryArmor_protected_png_919089929;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.horizontalGap = 4;
                this.paddingBottom = 0;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.verticalAlign = "middle";
                this.backgroundColor = "";
                this.borderColor = "";
                this.paddingRight = 2;
                this.backgroundAlpha = 0;
                this.borderAlpha = 0;
                this.verticalGap = 2;
                this.borderThickness = 0;
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingTop = 2;
                this.borderStyle = "none";
                this.paddingLeft = 2;
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
                this.verticalAlign = "middle";
                this.borderColor = 7630671;
                this.backgroundColor = 658961;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.verticalGap = 2;
                this.borderThickness = 1;
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultOverTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "left";
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
                this.backgroundColor = 658961;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingRight = 2;
                this.backgroundAlpha = 0.8;
                this.paddingTop = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".premiumOnlyNoPremium");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".premiumOnlyNoPremium", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icon_NoPremium_png_619567132;
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
                this.buttonUpStyle = "miniMapButtonUp";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Minimap_png_2033089433;
                this.borderCenterMask = "all";
                this.buttonCenterStyle = "miniMapButtonCenter";
                this.borderFooterMask = "none";
                this.paddingRight = 0;
                this.buttonZoomOutStyle = "miniMapButtonZoomOut";
                this.borderCenterCenterImage = _embed_css_images_Minimap_png_667670405;
                this.paddingBottom = 0;
                this.buttonNorthStyle = "miniMapButtonNorth";
                this.buttonSouthStyle = "miniMapButtonSouth";
                this.buttonZoomInStyle = "miniMapButtonZoomIn";
                this.buttonDownStyle = "miniMapButtonDown";
                this.paddingTop = 0;
                this.paddingLeft = 0;
                this.buttonEastStyle = "miniMapButtonEast";
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
                this.backgroundSkin = _embed_css_images_Slot_Statusicon_png_1415858734;
                this.highlightSkin = _embed_css_images_Slot_Statusicon_highlighted_png_1332900150;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyRerollBonusButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyRerollBonusButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css____images_prey_prey_bonus_reroll_png_1391458109;
                this.disabledIcon = _embed_css____images_prey_prey_bonus_reroll_disabled_png_192280102;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryLegs_png_2114818196;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1482270485;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_468614837;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "right";
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
                this.scrollRightButtonStyle = "chatWidgetTabBarScrollRight";
                this.dropDownButtonStyle = "chatWidgetTabBarDropDown";
                this.scrollLeftButtonStyle = "chatWidgetTabBarScrollLeft";
                this.scrollRightButtonHighlightStyle = "chatWidgetTabBarScrollRightHighlight";
                this.navItemStyle = "chatWidgetDefaultTab";
                this.scrollLeftButtonHighlightStyle = "chatWidgetTabBarScrollLeftHighlight";
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
                this.linkCursor = DragLinkCursor;
                this.rejectCursor = DragNoneCursor;
                this.copyCursor = DragCopyCursor;
                this.moveCursor = DragMoveCursor;
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
                this.defaultUpCenterImage = _embed_css_images_Button_ChatTab_Close_idle_png_1074740208;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ChatTab_Close_over_png_1945347312;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Button_ChatTab_Close_pressed_png_1705582336;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.defaultUpCenterImage = _embed_css_images_Minimap_ZoomOut_idle_png_2125846326;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Minimap_ZoomOut_over_png_353204682;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Minimap_ZoomOut_pressed_png_834344966;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonCancelStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.informationColor = 4286945;
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonNoStyle = "ingameShopNoButton";
                this.minimumButtonWidth = 60;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
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
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.verticalGap = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".applyImbuementButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".applyImbuementButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_____assets_images_imbuing_imbuing_icon_imbue_active_png_2078825278;
                this.disabledIcon = _embed_css_____assets_images_imbuing_imbuing_icon_imbue_disabled_png_2110185778;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.backgroundColor = 1977654;
                this.horizontalGap = 4;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.verticalGap = 1;
                this.paddingLeft = 2;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryShield_protected_png_1742050537;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.verticalGap = 2;
                this.paddingLeft = 2;
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
                this.fontFamily = "Verdana";
                this.color = 13684944;
                this.textAlign = "center";
                this.fontSize = 9;
                this.paddingTop = 2;
                this.fontStyle = "normal";
                this.fontWeight = "bold";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1784655247;
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_274255324;
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_over_png_917250191;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_over_png_917250191;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_274255324;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HideNPCs_active_png_2145118177;
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
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_png_584799829;
                this.verticalGap = 1;
                this.borderSkin = BitmapBorderSkin;
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
                this.verticalAlign = "middle";
                this.backgroundColor = "";
                this.borderColor = "";
                this.paddingRight = 2;
                this.backgroundAlpha = 0;
                this.borderAlpha = 0;
                this.verticalGap = 2;
                this.borderThickness = 0;
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingTop = 2;
                this.borderStyle = "none";
                this.paddingLeft = 2;
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
                this.defaultUpMask = "left center right";
                this.color = 16777215;
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = _embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_over_png_1892300526;
                this.defaultDownMask = "left center right";
                this.disabledColor = 16777215;
                this.defaultUpRightImage = "left";
                this.defaultUpCenterImage = _embed_css_images_custombutton_Button_IngameShopBuy_tileable_idle_png_130764314;
                this.defaultDownRightImage = "left";
                this.defaultDownLeftImage = _embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_pressed_png_493785154;
                this.defaultOverRightImage = "left";
                this.defaultOverCenterImage = _embed_css_images_custombutton_Button_IngameShopBuy_tileable_over_png_1828072166;
                this.textSelectedColor = 16777215;
                this.textRollOverColor = 16777215;
                this.defaultDownCenterImage = _embed_css_images_custombutton_Button_IngameShopBuy_tileable_pressed_png_1350701846;
                this.defaultUpLeftImage = _embed_css_images_custombutton_Button_IngameShopBuy_tileable_end_idle_png_546154478;
                this.defaultOverMask = "left center right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyRerollListButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyRerollListButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingBottom = 20;
                this.icon = _embed_css____images_prey_prey_list_reroll_png_1451613866;
                this.disabledIcon = _embed_css____images_prey_prey_list_reroll_disabled_png_1005632601;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.separatorColor = 8089164;
                this.tradeHeaderStyle = "tradeHeaderStyle";
                this.errorColor = 16711680;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154048530;
                this.color = 13221291;
                this.tradeFooterStyle = "tradeFooterStyle";
                this.tradeItemListStyle = "tradeItemListStyle";
                this.disabledColor = 13221291;
                this.tradeItemSlotStyle = "";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preySelectPreyMonsterButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preySelectPreyMonsterButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css____images_prey_prey_confirm_monster_selection_png_1917808293;
                this.disabledIcon = _embed_css____images_prey_prey_confirm_monster_selection_disabled_png_1811398472;
                return;
            }// end function
            ;
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "right";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "right";
                this.defaultDownTopImage = "right";
                this.borderLeft = 0;
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "left";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.borderBottom = 0;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "left";
                this.iconSelectedUpMask = "left";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultDownMask = "right";
                this.selectedUpMask = "left";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.borderRight = 0;
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "left";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.borderTop = 0;
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.selectedOverMask = "left";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "right";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "right";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "right";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".purchaseCompletedStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".purchaseCompletedStyle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpCenterImage = _embed_css_images_Button_PurchaseComplete_idle_png_1219313536;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_PurchaseComplete_over_png_1670828928;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Button_PurchaseComplete_pressed_png_296592240;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793;
                this.paddingRight = 0;
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.paddingBottom = 0;
                this.defaultOverTopImage = "right";
                this.paddingTop = 0;
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "right";
                this.defaultUpMask = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDownMask = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_585745991;
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
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
                this.horizontalGap = 2;
                this.paddingBottom = 0;
                this.pickerSize = 12;
                this.selectionColor = 13221291;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.verticalGap = 2;
                this.paddingLeft = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".imbuingDuration");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".imbuingDuration", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundLeftImage = _embed_css_images_BG_BarsProgress_compact_endpiece_png_1370317653;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.paddingBottom = 2;
                this.barDefault = _embed_css_images_BarsProgress_compact_orange_png_198580350;
                this.backgroundMask = "left center right";
                this.labelHorizontalAlign = "center";
                this.paddingTop = 2;
                this.backgroundCenterImage = _embed_css_images_BG_BarsProgress_compact_tileable_png_1434705776;
                this.barLimits = 0;
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
                this.borderThickness = 1;
                this.borderColor = 7630671;
                this.backgroundColor = 658961;
                this.horizontalAlign = "center";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.borderSkin = VectorBorderSkin;
                this.borderStyle = "solid";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryNecklace_png_1808156997;
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
                this.verticalAlign = "middle";
                this.paddingBottom = 0;
                this.horizontalAlign = "left";
                this.paddingRight = 2;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1482271674;
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.paddingLeft = 2;
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
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_GetPremium_png_376682585;
                this.color = 13221291;
                this.borderFooterMask = "none";
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
                this.dividerBackgroundRightImage = _embed_css_images_Border02_png_248151906;
                this.dividerKnobAlignment = "top";
                this.dividerBackgroundTopRightImage = _embed_css_images_Border02_corners_png_2023953407;
                this.horizontalGap = 0;
                this.dividerThickness = 7;
                this.dividerBackgroundMask = "topLeft top topRight";
                this.dividerAffordance = 7;
                this.dividerKnobMask = "top";
                this.verticalGap = 7;
                this.dividerBackgroundTopLeftImage = "topRight";
                this.dividerKnobTopImage = _embed_css_images_ChatWindow_Mover_png_2100462174;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryAmmo_png_675331507;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.color = 13221291;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                this.borderSkin = VectorBorderSkin;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1148616102;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_Mounted_over_png_526740337;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_Unmounted_over_png_1144518310;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_Unmounted_over_png_1144518310;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_Mounted_over_png_526740337;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_Mounted_idle_png_332190833;
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
                this.barImages = "barDefault";
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_341854824;
                this.paddingRight = 3;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "left";
                this.rightOrnamentMask = "right";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_402625151;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barDefault = _embed_css_images_BarsHealth_default_Mana_png_2142805618;
                this.leftOrnamentOffset = -5;
                this.rightOrnamentOffset = 5;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.paddingLeft = 3;
                this.barLimits = 0;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryAmmo_protected_png_437721124;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.borderThickness = 1;
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.focusThickness = 0;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.borderStyle = "solid";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBackpack_png_1145397297;
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
                this.overlaySelectedImage = _embed_css_images_slot_container_highlighted_png_1302039720;
                this.paddingBottom = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_1996786444;
                this.paddingRight = 1;
                this.overlayUnavailableImage = _embed_css_images_slot_container_disabled_png_2017818209;
                this.paddingTop = 1;
                this.paddingLeft = 1;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBackpack_protected_png_278754206;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default__png_162149957;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_239928278;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_793986337;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_9825491;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_9825491;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_793986337;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1337425916;
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
                this.horizontalGap = 0;
                this.listStyle = "buddylist";
                this.paddingBottom = 0;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_VipList_png_570669695;
                this.paddingRight = 0;
                this.listBoxStyle = "buddylistContent";
                this.paddingTop = 0;
                this.verticalGap = 0;
                this.paddingLeft = 0;
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
                this.paddintTop = 0;
                this.alternatingItemColors = [1842980, 2174521];
                this.paddingRight = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".removeImbuementButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".removeImbuementButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_____assets_images_imbuing_imbuing_icon_remove_active_png_857913398;
                this.disabledIcon = _embed_css_____assets_images_imbuing_imbuing_icon_remove_disabled_png_1334606270;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1396972083;
                this.selectedOverCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_over_png_349575074;
                this.defaultOverCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1728022323;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1075890131;
                this.selectedDownCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1456372718;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_539137698;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyRerollListButtonSmall");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyRerollListButtonSmall", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingRight = 75;
                this.icon = _embed_css____images_prey_prey_list_reroll_small_png_860092972;
                this.disabledIcon = _embed_css____images_prey_prey_list_reroll_small_disabled_png_600614801;
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
                this.modalTransparencyColor = 1580578;
                this.color = 13120000;
                this.modalTransparencyBlur = 0;
                this.modalTransparencyDuration = 0;
                this.modalTransparency = 0.5;
                this.fontSize = 18;
                this.fontWeight = "bold";
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
                this.fontSize = 11;
                this.fontWeight = "bold";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1396972083;
                this.selectedOverCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_over_png_349575074;
                this.defaultOverCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1728022323;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1075890131;
                this.selectedDownCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1456372718;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_539137698;
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
                this.verticalAlign = "middle";
                this.paddintTop = 0;
                this.horizontalGap = 4;
                this.paddingRight = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".astralSourceBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".astralSourceBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 7630671;
                this.backgroundColor = 1842980;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "right";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "right";
                this.defaultDownTopImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "left";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "left";
                this.iconSelectedUpMask = "left";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultDownMask = "right";
                this.selectedUpMask = "left";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.selectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "left";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.toggleButtonStyle = "sideBarToggleLeft";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.selectedOverMask = "left";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "right";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "right";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "right";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.borderMask = "right";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "left";
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
                this.themeColor = 13221291;
                this.borderMask = "center";
                this.borderSkin = BitmapBorderSkin;
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_png_1422729109;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "right";
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
                this.backgroundColor = "";
                this.selectionDuration = 0;
                this.alternatingItemColors = [658961, 658961];
                this.color = 13221291;
                this.selectionColor = 4936794;
                this.backgroundAlpha = 0.8;
                this.selectionEasingFunction = "";
                this.borderSkin = EmptySkin;
                this.alternatingItemAlphas = [0.8, 0.8];
                this.rollOverColor = 2633265;
                this.focusThickness = 0;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".notEnoughCurrency");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".notEnoughCurrency", style, false);
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
                this.defaultUpCenterImage = _embed_css_images_Minimap_Center_idle_png_2012166886;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Minimap_Center_over_png_279361510;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Minimap_Center_active_png_1997427884;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                this.paddingTop = 2;
                this.borderSkin = VectorBorderSkin;
                this.verticalGap = 0;
                this.paddingLeft = 2;
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
                this.slotPaddingTop = 0;
                this.slotVerticalGap = 2;
                this.paddingRight = 1;
                this.verticalGap = 2;
                this.slotHorizontalGap = 2;
                this.slotPaddingRight = 0;
                this.pageRightButtonStyle = "containerPageRight";
                this.horizontalGap = 2;
                this.pageFooterStyle = "containerPageFooter";
                this.slotPaddingBottom = 0;
                this.upButtonStyle = "containerWigdetViewUp";
                this.slotVerticalAlign = "middle";
                this.pageLeftButtonStyle = "containerPageLeft";
                this.slotPaddingLeft = 5;
                this.slotHorizontalAlign = "center";
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
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownMask = "bottom";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultOverTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "bottom";
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
                this.overlayHighlightImage = _embed_css_images_slot_container_highlighted_png_1302039720;
                this.paddingBottom = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_1996786444;
                this.paddingRight = 1;
                this.overlayDisabledImage = _embed_css_images_slot_container_disabled_png_2017818209;
                this.paddingTop = 1;
                this.paddingLeft = 1;
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
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.paddingBottom = 0;
                this.horizontalAlign = "center";
                this.paddingRight = 2;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1482271674;
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 0;
                this.paddingLeft = 2;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793;
                this.paddingRight = 0;
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.paddingBottom = 0;
                this.defaultOverTopImage = "right";
                this.paddingTop = 0;
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "left";
                this.defaultUpMask = "left";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDownMask = "left";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_585745991;
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
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
                this.borderThickness = 1;
                this.verticalAlign = "middle";
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.horizontalAlign = "center";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.borderStyle = "solid";
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_1481613863;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.headerBoxStyle = "battlelistHeader";
                this.hideNPCButtonStyle = "battlelistWidgetViewHideNPC";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_BattleList_png_1517554948;
                this.paddingRight = 0;
                this.listBoxStyle = "battlelistContent";
                this.verticalGap = 0;
                this.hidePartyButtonStyle = "battlelistWidgetViewHideParty";
                this.hideMonsterButtonStyle = "battlelistWidgetViewHideMonster";
                this.horizontalGap = 0;
                this.listStyle = "battlelist";
                this.paddingBottom = 0;
                this.paddingTop = 0;
                this.hidePlayerButtonStyle = "battlelistWidgetViewHidePlayer";
                this.paddingLeft = 0;
                this.hideNonSkulledButtonStyle = "battlelistWidgetViewHideNonSkulled";
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
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonCancelStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.informationColor = 4286945;
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonNoStyle = "ingameShopNoButton";
                this.minimumButtonWidth = 60;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
                return;
            }// end function
            ;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.verticalAlign = "bottom";
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.horizontalAlign = "center";
                this.paddingRight = 0;
                this.borderMask = "center";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 0;
                this.paddingLeft = 0;
                this.borderCenterImage = _embed_css_images_BG_ChatTab_Tabdrop_png_344159956;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.tabStyleName = "simpleTabNavigator";
                this.paddingTop = 1;
                this.borderStyle = "solid";
                this.paddingLeft = 1;
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
                this.errorColor = 15904590;
                this.defaultUpMask = "center";
                this.selectedDownMask = "center";
                this.color = 15904590;
                this.textAlign = "center";
                this.paddingRight = 4;
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.disabledColor = 15904590;
                this.defaultUpCenterImage = _embed_css_images_BuySellTab_idle_png_1415167540;
                this.paddingBottom = 0;
                this.selectedOverCenterImage = _embed_css_images_BuySellTab_active_png_1722132850;
                this.defaultOverCenterImage = _embed_css_images_BuySellTab_idle_png_1415167540;
                this.selectedOverMask = "center";
                this.textSelectedColor = 15904590;
                this.textRollOverColor = 15904590;
                this.defaultDownCenterImage = _embed_css_images_BuySellTab_idle_png_1415167540;
                this.selectedDownCenterImage = _embed_css_images_BuySellTab_active_png_1722132850;
                this.paddingTop = 0;
                this.paddingLeft = 4;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_BuySellTab_active_png_1722132850;
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
                this.borderThickness = 0;
                this.borderColor = 65280;
                this.backgroundColor = 65280;
                this.borderAlpha = 0;
                this.backgroundAlpha = 0;
                this.borderSkin = VectorBorderSkin;
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
                this.defaultUpCenterImage = _embed_css_images_Button_ContainerUp_idle_png_883766938;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ContainerUp_over_png_533315994;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledCenterImage = _embed_css_images_Button_ContainerUp_idle_png_883766938;
                this.defaultDisabledMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Button_ContainerUp_pressed_png_571520662;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "right";
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.tabStyleName = "simpleTabNavigator";
                this.paddingTop = 1;
                this.borderStyle = "solid";
                this.paddingLeft = 1;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1324480721;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_MediumOn_over_png_1201440323;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_MediumOff_over_png_1017681455;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_MediumOff_over_png_1017681455;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_MediumOn_over_png_1201440323;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1550321475;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
            style = StyleManager.getStyleDeclaration(".buddylistWidgetView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buddylistWidgetView", style, false);
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
                this.paddingBottom = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.verticalGap = 2;
                this.paddingLeft = 0;
                this.fontWeight = "bold";
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
                this.capacityFontColor = 16777215;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Inventory_png_1405466304;
                this.capacityFontFamily = "Verdana";
                this.borderCenterMask = "all";
                this.paddingRight = 0;
                this.borderCenterCenterImage = _embed_css_images_Inventory_png_381497758;
                this.bodySlotFeetStyle = "bodySlotFeet";
                this.bodySlotLeftHandBlessedStyle = "bodySlotLeftHandBlessed";
                this.bodySlotLegsBlessedStyle = "bodySlotLegsBlessed";
                this.verticalGap = 0;
                this.bodySlotTorsoBlessedStyle = "bodySlotTorsoBlessed";
                this.bodySlotLegsStyle = "bodySlotLegs";
                this.bodySlotLeftHandStyle = "bodySlotLeftHand";
                this.paddingBottom = 0;
                this.capacityFontStyle = "normal";
                this.bodySlotFeetBlessedStyle = "bodySlotFeetBlessed";
                this.paddingTop = 0;
                this.bodySlotFingerBlessedStyle = "bodySlotFingerBlessed";
                this.bodySlotRightHandBlessedStyle = "bodySlotRightHandBlessed";
                this.capacityFontWeight = "bold";
                this.bodySlotBackStyle = "bodySlotBack";
                this.bodySlotHipStyle = "bodySlotHip";
                this.bodySlotRightHandStyle = "bodySlotRightHand";
                this.buttonStoreInboxStyle = "buttonStoreInbox";
                this.borderFooterMask = "none";
                this.bodySlotTorsoStyle = "bodySlotTorso";
                this.bodySlotHipBlessedStyle = "bodySlotHipBlessed";
                this.bodySlotPremiumStyle = "bodySlotPremium";
                this.bodySlotFingerStyle = "bodySlotFinger";
                this.horizontalGap = 0;
                this.capacityFontSize = 9;
                this.bodySlotBlessingStyle = "bodySlotBlessing";
                this.bodySlotNeckStyle = "bodySlotNeck";
                this.bodySlotBackBlessedStyle = "bodySlotBackBlessed";
                this.bodySlotHeadBlessedStyle = "bodySlotHeadBlessed";
                this.bodySlotNeckBlessedStyle = "bodySlotNeckBlessed";
                this.paddingLeft = 0;
                this.bodySlotHeadStyle = "bodySlotHead";
                this.buttonIngameShopStyle = "buttonIngameShop";
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
                this.toggleButtonStyle = "actionBarWidgetToggleBottom";
                this.scrollUpButtonStyle = "actionBarWidgetScrollRight";
                this.scrollDownButtonStyle = "actionBarWidgetScrollLeft";
                this.borderMask = "left bottomLeft bottom bottomRight right center";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1063594900;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_390355041;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1137251407;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1137251407;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_390355041;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Combat_active_png_327192750;
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
                this.progressBarMalusStyleName = "statusWidgetFatMalusSkillProgress";
                this.verticalAlign = "middle";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetFatBonusSkillProgress";
                this.progressBarZeroStyleName = "statusWidgetFatZeroSkillProgress";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetFatSkillProgress";
                this.labelStyleName = ".statusWidgetSkillProgress";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".astralSourceLabel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".astralSourceLabel", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.textAlign = "center";
                this.fontWeight = "bold";
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
            style = StyleManager.getStyleDeclaration(".baseCurrency");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".baseCurrency", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 7829367;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_idle_png_177601341;
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058;
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_png_613329023;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".buttonDialogOpenStoreButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".buttonDialogOpenStoreButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icons_Inventory_Store_png_1162053375;
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
                this.defaultUpCenterImage = _embed_css_images_Minimap_ZoomIn_idle_png_480998871;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Minimap_ZoomIn_over_png_1744305367;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Minimap_ZoomIn_pressed_png_1013656729;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793;
                this.paddingRight = 0;
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.paddingBottom = 0;
                this.defaultOverTopImage = "right";
                this.paddingTop = 0;
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "top";
                this.defaultUpMask = "top";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "top";
                this.defaultDownMask = "top";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_585745991;
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_idle_png_1224099597;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_616733832;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_626524886;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_626524886;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_616733832;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Skull_active_png_1811862907;
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
                this.selectedOverBottomLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_bl_over_png_505981842;
                this.selectedUpLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_ml_idle_png_1406639853;
                this.paddingRight = 22;
                this.icon = _embed_css_images_Icons_Inventory_Store_png_1162053375;
                this.selectedOverTopImage = _embed_css_images_custombutton_Button_Highlight_tileable_tc_over_png_279471101;
                this.selectedDownLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_ml_pressed_png_1710390195;
                this.selectedOverLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_ml_over_png_1626598931;
                this.selectedUpBottomLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_bl_idle_png_299642002;
                this.selectedOverBottomRightImage = "bottomLeft";
                this.selectedDownRightImage = "left";
                this.selectedOverMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDownTopLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_tl_pressed_png_2061438852;
                this.selectedDownCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645;
                this.selectedUpTopLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_tl_idle_png_919535868;
                this.selectedUpBottomRightImage = "bottomLeft";
                this.selectedUpTopRightImage = "topLeft";
                this.selectedUpCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501;
                this.selectedUpBottomImage = _embed_css_images_custombutton_Button_Highlight_tileable_bc_idle_png_1480530699;
                this.selectedDownBottomRightImage = "bottomLeft";
                this.selectedDownMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedOverTopRightImage = "topLeft";
                this.selectedOverBottomImage = _embed_css_images_custombutton_Button_Highlight_tileable_bc_over_png_1545885173;
                this.selectedUpTopImage = _embed_css_images_custombutton_Button_Highlight_tileable_tc_idle_png_1335630595;
                this.selectedUpMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDownBottomImage = _embed_css_images_custombutton_Button_Highlight_tileable_bc_pressed_png_829106133;
                this.selectedDownTopImage = _embed_css_images_custombutton_Button_Highlight_tileable_tc_pressed_png_1605574371;
                this.selectedOverTopLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_tl_over_png_1790083580;
                this.selectedDownBottomLeftImage = _embed_css_images_custombutton_Button_Highlight_tileable_bl_pressed_png_564600482;
                this.selectedOverCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939;
                this.selectedDownTopRightImage = "topLeft";
                this.selectedOverRightImage = "left";
                this.selectedUpRightImage = "left";
                this.paddingLeft = 23;
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
                this.paddingBottom = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingLeft = 0;
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default__png_162149957;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.verticalAlign = "middle";
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.verticalGap = 2;
                this.borderThickness = 1;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.defaultUpBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultUpLeftImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "right";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_idle_png_788781616;
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_138520421;
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_over_png_79143632;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_over_png_79143632;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_138520421;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_PartyMembers_active_png_1666844766;
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
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Spells_png_653028639;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.verticalGap = 0;
                this.paddingLeft = 0;
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
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.borderRightImage = _embed_css_images_Border02_png_248151906;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_2023953407;
                this.verticalGap = 2;
                this.paddingLeft = 2;
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_Game_png_821519408;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyRerollListButtonReactivate");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyRerollListButtonReactivate", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css____images_prey_prey_list_reroll_reactivate_png_1235856493;
                this.disabledIcon = _embed_css____images_prey_prey_list_reroll_reactivate_disabled_png_204334064;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyDurationProgressSidebar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyDurationProgressSidebar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_malus_png_1223952997;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.color = 13221291;
                this.paddingRight = 8;
                this.fontSize = 12;
                this.fontWeight = "bold";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("TibiaCurrencyView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TibiaCurrencyView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.color = 16232264;
                this.horizontalAlign = "right";
                this.paddingRight = 4;
                this.paddingTop = 0;
                this.paddingLeft = 4;
                this.fontWeight = "bold";
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
                this.defaultUpCenterImage = _embed_css_images_Button_ChatTabIgnore_idle_png_1319268057;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ChatTabIgnore_over_png_503059495;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Button_ChatTabIgnore_pressed_png_922258679;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
            style = StyleManager.getStyleDeclaration(".preyPaddedBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyPaddedBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingBottom = 5;
                this.paddingRight = 5;
                this.paddingTop = 5;
                this.paddingLeft = 5;
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
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultOverTopImage = "right";
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "right";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730481697;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517102410;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_634503524;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_634503524;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517102410;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Trades_active_png_1392106579;
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
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_Game_png_821519408;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "left";
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
                this.horizontalGridLineColor = 8089164;
                this.backgroundColor = "";
                this.borderColor = 8089164;
                this.selectionDuration = 0;
                this.alternatingItemColors = [1977654, 16711680];
                this.color = 13221291;
                this.selectionColor = 658961;
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.selectionEasingFunction = "";
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.borderThickness = 1;
                this.alternatingItemAlphas = [0.8, 0];
                this.rollOverColor = 2768716;
                this.verticalGridLines = true;
                this.verticalGridLineColor = 8089164;
                this.iconColor = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.horizontalGridLines = false;
                this.borderStyle = "solid";
                this.disabledIconColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".itemBorder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".itemBorder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 7630671;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1396972083;
                this.selectedOverCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_over_png_349575074;
                this.defaultOverCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1728022323;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1075890131;
                this.selectedDownCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1456372718;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_539137698;
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
                this.horizontalGap = 5;
                this.dividerBackgroundMask = "left";
                this.dividerBackgroundLeftImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420837653;
                this.dividerAffordance = 5;
                this.verticalGap = 0;
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
                this.borderThickness = 1;
                this.backgroundColor = 2240055;
                this.borderColor = 13415802;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                this.backgroundAlpha = 0.5;
                this.borderAlpha = 1;
                this.paddingTop = 1;
                this.borderStyle = "solid";
                this.paddingLeft = 1;
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
                this.borderThickness = 1;
                this.borderColor = 0;
                this.backgroundColor = 0;
                this.backgroundAlpha = 0.33;
                this.borderStyle = "solid";
                return;
            }// end function
            ;
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
                this.barRedLow = _embed_css_images_BarsHealth_fat_RedLow_png_630566510;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundRightImage = _embed_css_images_BG_Bars_fat_enpiece_png_285397664;
                this.barRedFull = _embed_css_images_BarsHealth_fat_RedFull_png_663565691;
                this.barGreenFull = _embed_css_images_BarsHealth_fat_GreenFull_png_1012481779;
                this.paddingRight = 3;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "none";
                this.barYellow = _embed_css_images_BarsHealth_fat_Yellow_png_917594525;
                this.barGreenLow = _embed_css_images_BarsHealth_fat_GreenLow_png_23264160;
                this.rightOrnamentMask = "right";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_fat_tileable_png_1719993865;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barRedLow2 = _embed_css_images_BarsHealth_fat_RedLow2_png_2105859306;
                this.leftOrnamentOffset = -6;
                this.rightOrnamentOffset = 6;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1076170925;
                this.paddingLeft = 1;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_791544907;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1482270485;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_468614837;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "left";
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
                this.defaultDownTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1801889674;
                this.defaultUpBottomImage = "top";
                this.defaultUpTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_271327590;
                this.defaultUpMask = "top";
                this.skin = BitmapButtonSkin;
                this.defaultOverTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_616546202;
                this.defaultOverBottomImage = "top";
                this.defaultDownMask = "top";
                this.defaultDownBottomImage = "top";
                this.defaultOverMask = "top";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryRing_protected_png_143630382;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.tabHeight = 23;
                this.tabStyleName = "spellListWidgetTab";
                this.tabWidth = 40;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryWeapon_protected_png_2025859402;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.horizontalGap = 0;
                this.verticalGap = 0;
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
                this.iconProgressOff = _embed_css_images_Icons_ProgressBars_ProgressOff_png_1779777081;
                this.iconStatePoisoned = _embed_css_images_Icons_Conditions_Poisoned_png_1540003537;
                this.iconSkillFightAxe = _embed_css_images_Icons_ProgressBars_AxeFighting_png_784879159;
                this.iconStateDrowning = _embed_css_images_Icons_Conditions_Drowning_png_542106670;
                this.iconStateElectrified = _embed_css_images_Icons_Conditions_Electrified_png_1245219382;
                this.iconStateStrengthened = _embed_css_images_Icons_Conditions_Strenghtened_png_695721049;
                this.iconSkillFightDistance = _embed_css_images_Icons_ProgressBars_DistanceFighting_png_779396374;
                this.iconStateBleeding = _embed_css_images_Icons_Conditions_Bleeding_png_526934384;
                this.iconStateFast = _embed_css_images_Icons_Conditions_Haste_png_378019693;
                this.iconSkillFightClub = _embed_css_images_Icons_ProgressBars_ClubFighting_png_1530197035;
                this.iconStatePZEntered = _embed_css_images_Icons_Conditions_PZ_png_2094848430;
                this.iconStateCursed = _embed_css_images_Icons_Conditions_Cursed_png_90499082;
                this.iconStateDrunk = _embed_css_images_Icons_Conditions_Drunk_png_45733786;
                this.iconSkillFightShield = _embed_css_images_Icons_ProgressBars_Shielding_png_599280960;
                this.iconStateDazzled = _embed_css_images_Icons_Conditions_Dazzled_png_1747135488;
                this.iconSkillFightSword = _embed_css_images_Icons_ProgressBars_SwordFighting_png_726197318;
                this.iconStyleParallel = _embed_css_images_Icons_ProgressBars_ParallelStyle_png_562446159;
                this.iconSkillFightFist = _embed_css_images_Icons_ProgressBars_FistFighting_png_744761447;
                this.iconStyleCompact = _embed_css_images_Icons_ProgressBars_CompactStyle_png_2100887615;
                this.iconStyleLarge = _embed_css_images_Icons_ProgressBars_LargeStyle_png_1083507847;
                this.iconStateHungry = _embed_css_images_Icons_Conditions_Hungry_png_758019275;
                this.iconProgressOn = _embed_css_images_Icons_ProgressBars_ProgressOn_png_370747169;
                this.iconSkillMagLevel = _embed_css_images_Icons_ProgressBars_MagicLevel_png_1093895878;
                this.iconSkillFishing = _embed_css_images_Icons_ProgressBars_Fishing_png_159411631;
                this.iconStateFighting = _embed_css_images_Icons_Conditions_Logoutblock_png_358377557;
                this.iconStateFreezing = _embed_css_images_Icons_Conditions_Freezing_png_1444773940;
                this.iconStatePZBlock = _embed_css_images_Icons_Conditions_PZlock_png_2127619469;
                this.iconSkillLevel = _embed_css_images_Icons_ProgressBars_ProgressOn_png_370747169;
                this.iconStateBurning = _embed_css_images_Icons_Conditions_Burning_png_1677566757;
                this.iconStateManaShield = _embed_css_images_Icons_Conditions_MagicShield_png_557850584;
                this.iconStyleDefault = _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1681910211;
                this.iconStateSlow = _embed_css_images_Icons_Conditions_Slowed_png_77123048;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("PreySidebarView");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("PreySidebarView", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Prey_png_2056699772;
                this.color = 16777215;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.verticalGap = 0;
                this.paddingLeft = 0;
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
                this.verticalAlign = "middle";
                this.paddingBottom = 2;
                this.horizontalAlign = "left";
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ItemInformationPane");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ItemInformationPane", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundColor = 658961;
                this.paddingBottom = 4;
                this.paddingRight = 4;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 4;
                this.paddingLeft = 4;
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
                this.defaultDownTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1801889674;
                this.defaultUpBottomImage = "top";
                this.defaultUpTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_271327590;
                this.defaultUpMask = "bottom";
                this.skin = BitmapButtonSkin;
                this.defaultOverTopImage = _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_616546202;
                this.defaultOverBottomImage = "top";
                this.defaultDownMask = "bottom";
                this.defaultDownBottomImage = "top";
                this.defaultOverMask = "bottom";
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
                this.backgroundColor = "";
                this.selectionDuration = 0;
                this.alternatingItemColors = [1842980, 1842980];
                this.color = 13221291;
                this.selectionColor = 4936794;
                this.paddingRight = 2;
                this.backgroundAlpha = 0.8;
                this.selectionEasingFunction = "";
                this.borderSkin = EmptySkin;
                this.rollOverColor = 2633265;
                this.paddingBottom = 2;
                this.focusThickness = 0;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.borderBackgroundColor = 0;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.resizeCursorSkin = ResizeVerticalCursor;
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420837653;
                this.paddingRight = 2;
                this.borderBackgroundAlpha = 0;
                this.borderMask = "none";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 1;
                this.paddingLeft = 2;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "left";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".successRateBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".successRateBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.horizontalAlign = "right";
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
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_active_png_377762303;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_618087100;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_1978490031;
                this.defaultDisabledMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_618087100;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.horizontalGap = 1;
                this.hitpointsOffsetX = -2;
                this.manaOffsetY = -1;
                this.manaOffsetX = 2;
                this.stateStyle = "statusWidgetDefault";
                this.skillStyle = "statusWidgetDefaultSkill";
                this.manaStyle = "statusWidgetDefaultMana";
                this.hitpointsStyle = "statusWidgetDefaultHitpoints";
                this.hitpointsOffsetY = -1;
                this.verticalGap = 1;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_idle_png_428456803;
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1205967224;
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_over_png_634011235;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_over_png_634011235;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1205967224;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HideSkulled_active_png_2021231179;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryArmor_png_1841074918;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelZeroSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelZeroSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_zero_png_1390467341;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.verticalAlign = "top";
                this.borderColor = 8089164;
                this.backgroundColor = 2240055;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.nameLabelStyle = "selectOutfitLabel";
                this.borderThickness = 1;
                this.paddingBottom = 2;
                this.prevButtonStyle = "selectOutfitPrev";
                this.horizontalAlign = "center";
                this.nextButtonStyle = "selectOutfitNext";
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.buttonSecureStyle = "combatButtonSecure";
                this.buttonExpertModeStyle = "combatButtonExpert";
                this.buttonWhiteHandStyle = "combatButtonWhiteHand";
                this.buttonDefensiveStyle = "combatButtonDefensive";
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Combat_png_375287802;
                this.borderCenterMask = "all";
                this.borderFooterMask = "none";
                this.paddingRight = 0;
                this.buttonDoveStyle = "combatButtonDove";
                this.borderCenterCenterImage = _embed_css_images_BG_Combat_ExpertOff_png_793516502;
                this.buttonRedFistStyle = "combatButtonRedFist";
                this.paddingBottom = 0;
                this.buttonMountStyle = "combatButtonMount";
                this.buttonStopStyle = "combatButtonStop";
                this.paddingTop = 0;
                this.buttonOffensiveStyle = "combatButtonOffensive";
                this.buttonChaseStyle = "combatButtonChase";
                this.buttonBalancedStyle = "combatButtonBalanced";
                this.paddingLeft = 0;
                this.buttonYellowHandStyle = "combatButtonYellowHand";
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
                this.barRedLow = _embed_css_images_BarsHealth_default_RedLow_png_1323495386;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_341854824;
                this.barRedFull = _embed_css_images_BarsHealth_default_RedFull_png_471797811;
                this.barGreenFull = _embed_css_images_BarsHealth_default_GreenFull_png_539233669;
                this.paddingRight = 3;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "none";
                this.barYellow = _embed_css_images_BarsHealth_default_Yellow_png_338291605;
                this.barGreenLow = _embed_css_images_BarsHealth_default_GreenLow_png_1615903576;
                this.rightOrnamentMask = "right";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_402625151;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barRedLow2 = _embed_css_images_BarsHealth_default_RedLow2_png_1319540706;
                this.leftOrnamentOffset = -5;
                this.rightOrnamentOffset = 5;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.paddingLeft = 1;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
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
                this.separatorColor = 8089164;
                this.separatorWidth = 0.9;
                this.separatorAlpha = 1;
                this.separatorHeight = 4;
                return;
            }// end function
            ;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_idle_png_44831157;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_47374454;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_412469896;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_412469896;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_47374454;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_VipList_active_png_848728905;
                return;
            }// end function
            ;
            }
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
                this.borderBackgroundColor = 0;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.resizeCursorSkin = ResizeVerticalCursor;
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420837653;
                this.paddingRight = 2;
                this.borderBackgroundAlpha = 0;
                this.borderMask = "right";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 1;
                this.paddingLeft = 2;
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
                this.paddingRight = 12;
                this.icon = _embed_css_images_Icons_Inventory_StoreInbox_png_1901440063;
                this.paddingLeft = 12;
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
                this.backgroundColor = 16711680;
                this.paddingBottom = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_1996786444;
                this.paddingRight = 1;
                this.backgroundAlpha = 1;
                this.paddingTop = 1;
                this.paddingLeft = 1;
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
                this.paddingBottom = 0;
                this.itemBackgroundColors = [2768716, 16711680];
                this.itemVerticalGap = 0;
                this.paddingRight = 2;
                this.itemRendererStyle = "battlelistWidgetView";
                this.itemBackgroundAlphas = [0.5, 0];
                this.paddingTop = 0;
                this.itemHorizontalGap = 0;
                this.paddingLeft = 0;
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
            style = StyleManager.getStyleDeclaration(".sideBarPrey");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sideBarPrey", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpMask = "center";
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Prey_idle_png_924058986;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Prey_active_over_png_21306593;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Prey_idle_over_png_459157651;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Prey_idle_over_png_459157651;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Prey_active_over_png_21306593;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Prey_active_png_2078269124;
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
                this.horizontalGap = 0;
                this.dividerAffordance = 0;
                this.verticalGap = 0;
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
                this.alternatingItemColors = [2768716, 1977654];
                this.slotVerticalGap = 2;
                this.paddingRight = 0;
                this.selectionColor = "";
                this.backgroundAlpha = 0.5;
                this.infoBorderColor = 8089164;
                this.verticalGap = 0;
                this.slotHorizontalGap = 2;
                this.infoBackgroundColor = 1977654;
                this.slotPaddingRight = 0;
                this.infoBorderThickness = 1;
                this.paddingBottom = 0;
                this.slotPaddingBottom = 0;
                this.paddingTop = 0;
                this.slotHorizontalAlign = "center";
                this.backgroundColor = "";
                this.slotPaddingTop = 0;
                this.infoBorderAlpha = 1;
                this.infoBackgroundAlpha = 0.5;
                this.horizontalGap = 0;
                this.alternatingItemAlphas = [0.5, 0.5];
                this.rollOverColor = "";
                this.slotVerticalAlign = "middle";
                this.slotPaddingLeft = 5;
                this.paddingLeft = 0;
                this.infoBorderStyle = "solid";
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
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonCancelStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.informationColor = 4286945;
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonNoStyle = "ingameShopNoButton";
                this.minimumButtonWidth = 60;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
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
                this.defaultUpCenterImage = _embed_css_images_Button_Combat_Stop_idle_png_2028013783;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_Combat_Stop_over_png_222586327;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Button_Combat_Stop_pressed_png_1195446471;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyMonsterList");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyMonsterList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderColor = 13415802;
                this.backgroundColor = "";
                this.selectionDuration = 0;
                this.alternatingItemColors = [1842980, 1842980];
                this.color = 13221291;
                this.selectionColor = 4936794;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                this.selectionEasingFunction = "";
                this.borderThickness = 1;
                this.rollOverColor = 2633265;
                this.paddingBottom = 2;
                this.focusThickness = 0;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".astralSourceImageWrapper");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".astralSourceImageWrapper", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                this.horizontalAlign = "center";
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
                this.color = 16777215;
                this.skin = BitmapButtonSkin;
                this.icon = _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_423192446;
                this.defaultOverBottomRightImage = "bottomLeft";
                this.defaultOverBottomImage = _embed_css_images_custombutton_Button_Gold_tileable_bc_over_png_1582917375;
                this.defaultOverBottomLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_bl_over_png_866883846;
                this.defaultDownBottomImage = _embed_css_images_custombutton_Button_Gold_tileable_bc_pressed_png_1314073167;
                this.defaultUpRightImage = "left";
                this.defaultDownTopImage = _embed_css_images_custombutton_Button_Gold_tileable_tc_pressed_png_1001206657;
                this.defaultOverTopRightImage = "topLeft";
                this.defaultDownTopLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_tl_pressed_png_96476760;
                this.defaultUpCenterImage = _embed_css_images_custombutton_Button_Gold_tileable_mc_idle_png_144725306;
                this.defaultDownRightImage = "left";
                this.defaultUpBottomImage = _embed_css_images_custombutton_Button_Gold_tileable_bc_idle_png_1388109823;
                this.defaultUpTopImage = _embed_css_images_custombutton_Button_Gold_tileable_tc_idle_png_354340239;
                this.defaultOverTopImage = _embed_css_images_custombutton_Button_Gold_tileable_tc_over_png_701648527;
                this.textSelectedColor = 16777215;
                this.defaultDownCenterImage = _embed_css_images_custombutton_Button_Gold_tileable_mc_pressed_png_1792782474;
                this.defaultUpTopRightImage = "topLeft";
                this.defaultOverMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.defaultUpMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.defaultUpBottomLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_bl_idle_png_866059770;
                this.defaultOverLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_ml_over_png_1301417569;
                this.defaultDownMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.disabledColor = 16777215;
                this.defaultDownTopRightImage = "topLeft";
                this.defaultUpTopLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_tl_idle_png_1066808312;
                this.defaultUpBottomRightImage = "bottomLeft";
                this.defaultDownBottomLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_bl_pressed_png_1601544042;
                this.defaultDownLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_ml_pressed_png_1124837519;
                this.defaultOverRightImage = "left";
                this.defaultOverCenterImage = _embed_css_images_custombutton_Button_Gold_tileable_mc_over_png_387132358;
                this.defaultDownBottomRightImage = "bottomLeft";
                this.textRollOverColor = 16777215;
                this.defaultUpLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_ml_idle_png_2119528289;
                this.defaultOverTopLeftImage = _embed_css_images_custombutton_Button_Gold_tileable_tl_over_png_1949119752;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".purchaseBonusRerollsButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".purchaseBonusRerollsButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css____images_prey_prey_unlock_permanently_png_2084364847;
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.backgroundColor = 658961;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.errorColor = 13221291;
                this.color = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.disabledColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetParallelMalusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetParallelMalusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_malus_png_1223952997;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "right";
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
            style = StyleManager.getStyleDeclaration(".hintBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".hintBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.paddingBottom = 4;
                this.paddingRight = 4;
                this.borderAlpha = 1;
                this.paddingTop = 4;
                this.borderStyle = "solid";
                this.paddingLeft = 4;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultMalusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultMalusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_malus_png_1223952997;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.borderThickness = 1;
                this.borderColor = 7630671;
                this.backgroundColor = 1842980;
                this.horizontalAlign = "center";
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                this.borderSkin = VectorBorderSkin;
                this.borderStyle = "solid";
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
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_314099262;
                this.borderFooterMask = "none";
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_1481613863;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1971662251;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2114894105;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_523657045;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_523657045;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2114894105;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1337920135;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".astralSourcesArrowBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".astralSourcesArrowBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                this.horizontalAlign = "center";
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "left";
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
                this.horizontalGridLineColor = 8089164;
                this.backgroundColor = "";
                this.borderColor = 8089164;
                this.selectionDuration = 0;
                this.alternatingItemColors = [1977654, 16711680];
                this.color = 13221291;
                this.selectionColor = 658961;
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.selectionEasingFunction = "";
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.borderThickness = 1;
                this.alternatingItemAlphas = [0.8, 0];
                this.rollOverColor = 2768716;
                this.verticalGridLines = true;
                this.verticalGridLineColor = 8089164;
                this.iconColor = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.horizontalGridLines = false;
                this.borderStyle = "solid";
                this.disabledIconColor = 13221291;
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
                this.backgroundColor = "";
                this.selectionDuration = 0;
                this.alternatingItemColors = [658961, 658961];
                this.color = 13221291;
                this.selectionColor = 4936794;
                this.backgroundAlpha = 0.8;
                this.selectionEasingFunction = "";
                this.borderSkin = EmptySkin;
                this.alternatingItemAlphas = [0.8, 0.8];
                this.rollOverColor = 2633265;
                this.focusThickness = 0;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyRerollListButtonReactivateSmall");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyRerollListButtonReactivateSmall", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingRight = 75;
                this.icon = _embed_css____images_prey_prey_list_reroll_small_reactivate_png_1299157975;
                this.disabledIcon = _embed_css____images_prey_prey_list_reroll_small_reactivate_disabled_png_1943789254;
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
                this.setTextInputStyle = "hotkeyOptionsSetTextInput";
                this.setScrollLeftStyle = "hotkeyOptionsSetScrollLeft";
                this.setScrollRightStyle = "hotkeyOptionsSetScrollRight";
                this.mappingListStyle = "hotkeyOptionsMappingList";
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
            style = StyleManager.getStyleDeclaration(".sectionBorder");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".sectionBorder", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryWeapon_png_1721833083;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1236418872;
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_234622227;
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_over_png_1260863432;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_over_png_1260863432;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_234622227;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HideMonsters_active_png_1589130474;
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
                this.errorColor = 16711680;
                this.color = 13221291;
                this.paddingRight = 0;
                this.verticalGap = -2;
                this.disabledColor = 13221291;
                this.indicatorGap = 4;
                this.borderThickness = 0;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.paddingTop = 0;
                this.borderStyle = "none";
                this.paddingLeft = 0;
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
                this.closeButtonTop = 4;
                this.selectedUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
                this.paddingRight = 4;
                this.skin = BitmapButtonSkin;
                this.selectedDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
                this.selectedOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
                this.defaultUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
                this.defaultUpCenterImage = _embed_css_images_ChatTab_tileable_idle_png_627868017;
                this.defaultDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
                this.paddingBottom = 0;
                this.selectedTextColor = 15904590;
                this.closeButtonRight = 4;
                this.selectedDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
                this.selectedOverMask = "left center right";
                this.defaultDownCenterImage = _embed_css_images_ChatTab_tileable_idle_png_627868017;
                this.selectedDownCenterImage = _embed_css_images_ChatTab_tileable_png_883140798;
                this.paddingTop = 0;
                this.defaultOverMask = "left center right";
                this.selectedUpCenterImage = _embed_css_images_ChatTab_tileable_png_883140798;
                this.defaultUpMask = "left center right";
                this.selectedDownMask = "left center right";
                this.textAlign = "left";
                this.defaultOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
                this.highlightTextColor = 13120000;
                this.defaultDownMask = "left center right";
                this.selectedUpMask = "left center right";
                this.defaultDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
                this.defaultOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
                this.selectedOverCenterImage = _embed_css_images_ChatTab_tileable_png_883140798;
                this.defaultOverCenterImage = _embed_css_images_ChatTab_tileable_idle_png_627868017;
                this.selectedOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
                this.selectedUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
                this.defaultTextColor = 13221291;
                this.defaultUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
                this.paddingLeft = 4;
                this.closeButtonStyle = "chatWidgetDefaultTabCloseButton";
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
                this.horizontalGap = 0;
                this.verticalGap = 0;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryShield_png_125978696;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollHotkeys_disabled_png_59047793;
                this.paddingRight = 0;
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDisabledTopImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollHotkeys_idle_png_1863838023;
                this.defaultDownTopImage = "right";
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1584202487;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.paddingBottom = 0;
                this.defaultOverTopImage = "right";
                this.paddingTop = 0;
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "bottom";
                this.defaultUpMask = "bottom";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "bottom";
                this.defaultDownMask = "bottom";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollHotkeys_over_png_585745991;
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
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
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.paddingLeft = 2;
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
                this.horizontalGap = 1;
                this.hitpointsOffsetX = -2;
                this.manaOffsetY = -1;
                this.manaOffsetX = 2;
                this.stateStyle = "statusWidgetCompact";
                this.skillStyle = "statusWidgetCompactSkill";
                this.manaStyle = "statusWidgetCompactMana";
                this.hitpointsStyle = "statusWidgetCompactHitpoints";
                this.hitpointsOffsetY = -1;
                this.verticalGap = 1;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDisabledCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_894372018;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_idle_png_754231034;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1392963547;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_over_png_420435450;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_ExpertMode_over_png_420435450;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1392963547;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_123367643;
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
                this.selectedDownMask = "center";
                this.selectedOverCenterImage = _embed_css_images_Button_MaximizePremium_over_png_267955669;
                this.selectedOverMask = "center";
                this.selectedDownCenterImage = _embed_css_images_Button_Maximize_pressed_png_1415129086;
                this.selectedUpMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Button_MaximizePremium_idle_png_1480797397;
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
                this.horizontalGridLineColor = 8089164;
                this.backgroundColor = "";
                this.borderColor = 8089164;
                this.selectionDuration = 0;
                this.alternatingItemColors = [1977654, 16711680];
                this.color = 13221291;
                this.selectionColor = 658961;
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.selectionEasingFunction = "";
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.borderThickness = 1;
                this.alternatingItemAlphas = [0.8, 0];
                this.rollOverColor = 2768716;
                this.verticalGridLines = true;
                this.verticalGridLineColor = 8089164;
                this.iconColor = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.horizontalGridLines = false;
                this.borderStyle = "solid";
                this.disabledIconColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".successRateBelowTwentyPercent");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".successRateBelowTwentyPercent", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 13120000;
                this.textAlign = "right";
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
                this.overlayCooldownImage = _embed_css_images_Slot_Hotkey_Cooldown_png_1017067163;
                this.overlayHighlightImage = _embed_css_images_slot_Hotkey_highlighted_png_1467341187;
                this.backgroundLabelColor = 14277081;
                this.paddingBottom = 3;
                this.overlayLabelColor = 16777215;
                this.backgroundImage = _embed_css_images_slot_Hotkey_png_1006833303;
                this.paddingRight = 3;
                this.overlayDisabledImage = _embed_css_images_slot_Hotkey_disabled_png_804094220;
                this.paddingTop = 3;
                this.paddingLeft = 3;
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
                this.icon = _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_423192446;
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
                this.paddingBottom = 2;
                this.paddingRight = 8;
                this.icon = _embed_css_images_Icons_IngameShop_12x12_No_png_115059819;
                this.paddingTop = 2;
                this.paddingLeft = 8;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".successRateHundredPercent");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".successRateHundredPercent", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 4500773;
                this.textAlign = "right";
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
                this.borderThickness = 1;
                this.borderColor = 0;
                this.backgroundColor = 2240055;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.borderStyle = "solid";
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
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558016314;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_675712135;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1732180796;
                this.defaultDisabledMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_675712135;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.horizontalGap = 1;
                this.hitpointsOffsetX = 0;
                this.manaOffsetY = 0;
                this.manaOffsetX = 0;
                this.stateStyle = "statusWidgetParallel";
                this.skillStyle = "statusWidgetParallelSkill";
                this.manaStyle = "statusWidgetParallelMana";
                this.hitpointsStyle = "statusWidgetParallelHitpoints";
                this.hitpointsOffsetY = -1;
                this.verticalGap = 1;
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
                this.verticalAlign = "top";
                this.backgroundColor = 658961;
                this.borderColor = 8089164;
                this.buttonStyle = "";
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.buttonBoxStyle = "embeddedDialogButtonBox";
                this.borderThickness = 1;
                this.contentBoxStyle = "embeddedDialogContentBox";
                this.horizontalAlign = "center";
                this.titleBoxStyle = "embeddedDialogTitleBox";
                this.titleStyle = "embeddedDialogTitle";
                this.textStyle = "embeddedDialogText";
                this.borderStyle = "solid";
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
                this.errorColor = 13221291;
                this.color = 13221291;
                this.whiteListEditorStyle = "nameFilterOptionsBlackListEditor";
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.blackListEditorStyle = "nameFilterOptionsWhiteListEditor";
                this.disabledColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".protectionCharmButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".protectionCharmButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_____assets_images_imbuing_imbuing_icon_useprotection_active_png_532986814;
                this.disabledIcon = _embed_css_____assets_images_imbuing_imbuing_icon_useprotection_disabled_png_494797810;
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.backgroundColor = 1977654;
                this.horizontalGap = 4;
                this.paddingBottom = 2;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.verticalGap = 1;
                this.paddingLeft = 2;
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "top";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "top";
                this.defaultDownTopImage = "right";
                this.borderLeft = 0;
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "bottom";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.borderBottom = 0;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "bottom";
                this.iconSelectedUpMask = "bottom";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultDownMask = "top";
                this.selectedUpMask = "bottom";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.borderRight = 0;
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "bottom";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.borderTop = 0;
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.selectedOverMask = "bottom";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "top";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "top";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "top";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
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
                this.errorColor = 13221291;
                this.color = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.disabledColor = 13221291;
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
                this.toggleButtonStyle = "actionBarWidgetToggleLeft";
                this.scrollUpButtonStyle = "actionBarWidgetScrollBottom";
                this.scrollDownButtonStyle = "actionBarWidgetScrollTop";
                this.borderMask = "left center";
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
                this.verticalAlign = "middle";
                this.buttonGeneralStyle = "sideBarHeaderGeneral";
                this.buttonTradeStyle = "sideBarHeaderTrade";
                this.paddingRight = 0;
                this.buttonMinimapStyle = "sideBarHeaderMinimap";
                this.buttonContainerStyle = "sideBarHeaderContainer";
                this.buttonCombatStyle = "sideBarHeaderCombat";
                this.verticalGap = 2;
                this.borderSkin = BitmapBorderSkin;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_2023953407;
                this.buttonBuddylistStyle = "sideBarHeaderBuddylist";
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.borderRightImage = _embed_css_images_Border02_png_248151906;
                this.buttonBodyStyle = "sideBarHeaderBody";
                this.buttonUnjustPointsStyle = "sideBarUnjustPoints";
                this.borderMask = "left bottomLeft bottom bottomRight right center";
                this.paddingTop = 2;
                this.buttonPreyStyle = "sideBarPrey";
                this.paddingLeft = 0;
                this.buttonBattlelistStyle = "sideBarHeaderBattlelist";
                this.borderCenterImage = _embed_css_images_BG_Widget_Menu_png_1523929844;
                this.foldButtonStyleName = "sideBarHeaderFold";
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
                this.horizontalGridLineColor = 8089164;
                this.backgroundColor = "";
                this.borderColor = 8089164;
                this.selectionDuration = 0;
                this.alternatingItemColors = [1977654, 16711680];
                this.color = 13221291;
                this.selectionColor = 658961;
                this.backgroundAlpha = 0.8;
                this.borderAlpha = 1;
                this.selectionEasingFunction = "";
                this.headerSeparatorSkin = VectorDataGridHeaderSeparatorSkin;
                this.headerBackgroundSkin = VectorDataGridHeaderBackgroundSkin;
                this.borderThickness = 1;
                this.alternatingItemAlphas = [0.8, 0];
                this.rollOverColor = 2768716;
                this.verticalGridLines = true;
                this.verticalGridLineColor = 8089164;
                this.iconColor = 13221291;
                this.textSelectedColor = 13221291;
                this.textRollOverColor = 13221291;
                this.horizontalGridLines = false;
                this.borderStyle = "solid";
                this.disabledIconColor = 13221291;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".imbuingItemAppearanceRenderer");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".imbuingItemAppearanceRenderer", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.overlayHighlightImage = _embed_css_images_slot_container_highlighted_png_1302039720;
                this.paddingBottom = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_1996786444;
                this.paddingRight = 1;
                this.overlayDisabledImage = _embed_css_images_slot_container_disabled_png_2017818209;
                this.paddingTop = 1;
                this.paddingLeft = 1;
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
                this.strokeWidth = 1;
                this.strokeColor = 8089164;
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "bottom";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "bottom";
                this.defaultDownTopImage = "right";
                this.borderLeft = 0;
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "top";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.borderBottom = 0;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "top";
                this.iconSelectedUpMask = "top";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultDownMask = "bottom";
                this.selectedUpMask = "top";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.borderRight = 0;
                this.selectedOverRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "top";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.borderTop = 0;
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_HotkeyToggle_BG_png_162240878;
                this.selectedOverMask = "top";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "bottom";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "bottom";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "bottom";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "top";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "top";
                this.defaultDownTopImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "bottom";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "bottom";
                this.iconSelectedUpMask = "bottom";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultDownMask = "top";
                this.selectedUpMask = "bottom";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.selectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "bottom";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.selectedOverMask = "bottom";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "top";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "top";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "top";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".hovered");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".hovered", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundColor = 2633265;
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
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingRight = 2;
                this.paddingTop = 2;
                this.verticalGap = 2;
                this.paddingLeft = 2;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_PvPOff_idle_png_1518483442;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_PvPOn_active_png_806196142;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_PvPOff_active_png_470312516;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_PvPOff_active_png_470312516;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_PvPOn_active_png_806196142;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_PvPOn_idle_png_325504288;
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
                this.barRedLow = _embed_css_images_BarsHealth_compact_RedLow_png_432309528;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundRightImage = _embed_css_images_BG_Bars_compact_enpiece_png_1259288550;
                this.barRedFull = _embed_css_images_BarsHealth_compact_RedFull_png_1785716075;
                this.barGreenFull = _embed_css_images_BarsHealth_compact_GreenFull_png_658108631;
                this.paddingRight = 3;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "none";
                this.barYellow = _embed_css_images_BarsHealth_compact_Yellow_png_824185175;
                this.barGreenLow = _embed_css_images_BarsHealth_compact_GreenLow_png_1230640774;
                this.rightOrnamentMask = "right";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_compact_tileable_png_1504529517;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barRedLow2 = _embed_css_images_BarsHealth_compact_RedLow2_png_673302076;
                this.leftOrnamentOffset = -6;
                this.rightOrnamentOffset = 6;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_985111789;
                this.paddingLeft = 1;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryHead_png_1231852719;
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
                this.closeButtonTop = 4;
                this.selectedUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
                this.paddingRight = 4;
                this.skin = BitmapButtonSkin;
                this.selectedDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
                this.selectedOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_png_520247787;
                this.defaultUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
                this.defaultUpCenterImage = _embed_css_images_ChatTab_tileable_idle_png_627868017;
                this.defaultDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
                this.paddingBottom = 0;
                this.selectedTextColor = 15904590;
                this.closeButtonRight = 4;
                this.selectedDownRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
                this.selectedOverMask = "left center right";
                this.defaultDownCenterImage = _embed_css_images_ChatTab_tileable_idle_png_627868017;
                this.selectedDownCenterImage = _embed_css_images_ChatTab_tileable_png_883140798;
                this.paddingTop = 0;
                this.defaultOverMask = "left center right";
                this.selectedUpCenterImage = _embed_css_images_ChatTab_tileable_png_883140798;
                this.defaultUpMask = "left center right";
                this.selectedDownMask = "left center right";
                this.textAlign = "left";
                this.defaultOverLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
                this.highlightTextColor = 13120000;
                this.defaultDownMask = "left center right";
                this.selectedUpMask = "left center right";
                this.defaultDownLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
                this.defaultOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_2102059443;
                this.selectedOverCenterImage = _embed_css_images_ChatTab_tileable_png_883140798;
                this.defaultOverCenterImage = _embed_css_images_ChatTab_tileable_idle_png_627868017;
                this.selectedOverRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
                this.selectedUpRightImage = _embed_css_images_ChatTab_tileable_EndpieceRound_png_1457444790;
                this.defaultTextColor = 13221291;
                this.defaultUpLeftImage = _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969613528;
                this.paddingLeft = 4;
                this.closeButtonStyle = "chatWidgetDefaultTabCloseButton";
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
                this.borderBackgroundColor = 0;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.resizeCursorSkin = ResizeVerticalCursor;
                this.borderRightImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420837653;
                this.paddingRight = 2;
                this.borderBackgroundAlpha = 0;
                this.borderMask = "left";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.verticalGap = 1;
                this.paddingLeft = 2;
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
                this.backgroundColor = 658961;
                this.borderColor = 8089164;
                this.errorColor = 13221291;
                this.color = 13221291;
                this.footerStyle = "popUpFooterStyle";
                this.backgroundAlpha = 0.5;
                this.borderAlpha = 1;
                this.disabledColor = 13221291;
                this.borderTop = 33;
                this.iconStyle = null;
                this.cornerRadius = 0;
                this.headerStyle = "popUpHeaderStyle";
                this.borderThickness = 1;
                this.borderLeft = 3;
                this.modalTransparencyColor = 1580578;
                this.modalTransparencyBlur = 0;
                this.borderRight = 3;
                this.modalTransparencyDuration = 0;
                this.modalTransparency = 0.5;
                this.titleStyle = "popUpTitleStyle";
                this.borderStyle = "solid";
                this.borderBottom = 33;
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
                this.overlayHighlightImage = _embed_css_images_slot_container_highlighted_png_1302039720;
                this.paddingBottom = 1;
                this.backgroundImage = _embed_css_images_slot_container_png_1996786444;
                this.paddingRight = 1;
                this.overlayDisabledImage = _embed_css_images_slot_container_disabled_png_2017818209;
                this.paddingTop = 1;
                this.paddingLeft = 1;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".imbuingSlot");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".imbuingSlot", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.defaultUpCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_idle_png_177601341;
                this.selectedOverCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058;
                this.defaultOverCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683;
                this.icon = _embed_css_____assets_images_imbuing_imbuing_slot_empty_png_768110180;
                this.defaultDownCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_over_png_622687683;
                this.selectedDownCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1490023058;
                this.selectedUpCenterImage = _embed_css_images_Icons_BattleList_HidePlayers_active_png_613329023;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1338322061;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_RedFistOn_over_png_744247435;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1544269709;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1544269709;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_RedFistOn_over_png_744247435;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_329965451;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyTitle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyTitle", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.textAlign = "center";
                this.fontWeight = "bold";
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default__png_162149957;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".progressBarBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".progressBarBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                this.horizontalAlign = "center";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".itemAndSlotBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".itemAndSlotBox", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.verticalAlign = "middle";
                this.paddingLeft = 4;
                return;
            }// end function
            ;
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_1481613863;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetFatMalusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetFatMalusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_malus_png_1223952997;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.verticalAlign = "middle";
                this.borderColor = 7630671;
                this.backgroundColor = 658961;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.verticalGap = 2;
                this.borderThickness = 1;
                this.horizontalGap = 15;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".selected");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".selected", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundColor = 4936794;
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryHead_protected_png_1088319362;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".border");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".border", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderThickness = 1;
                this.borderColor = 7630671;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.decreaseButtonStyle = "customSliderDecreaseButton";
                this.increaseButtonStyle = "customSliderIncreaseButton";
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "right";
                this.skin = BitmapButtonSkin;
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "right";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultOverMask = "right";
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
                this.defaultUpCenterImage = _embed_css_images_Button_ChatTabNew_idle_png_1804753881;
                this.defaultUpMask = "center";
                this.defaultOverCenterImage = _embed_css_images_Button_ChatTabNew_over_png_541842649;
                this.skin = BitmapButtonSkin;
                this.defaultDownCenterImage = _embed_css_images_Button_ChatTabNew_pressed_png_923606007;
                this.defaultDownMask = "center";
                this.defaultOverMask = "center";
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_improved_png_1481613863;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1439642702;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_450488793;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1523904949;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1523904949;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_450488793;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_273763964;
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
                this.borderCenterBackgroundColor = 1977654;
                this.headerVerticalAlign = "middle";
                this.paddingRight = 2;
                this.borderFooterBottomImage = _embed_css_images_Widget_Footer_tileable_png_2102878075;
                this.borderSkin = WidgetViewSkin;
                this.titleFontColor = 13221291;
                this.paddingBottom = 2;
                this.titleFontSize = 11;
                this.footerPaddingTop = 0;
                this.footerHorizontalAlign = "left";
                this.iconLeft = 2;
                this.footerPaddingBottom = 0;
                this.borderFooterMask = "bottomLeft bottom bottomRight";
                this.headerWidth = 141;
                this.borderHeaderTop = 22;
                this.headerPaddingBottom = 0;
                this.borderCenterRightImage = _embed_css_images_Border_Widget_png_123662323;
                this.iconTop = 2;
                this.footerVerticalAlign = "top";
                this.borderCenterBackgroundAlpha = 0.5;
                this.paddingLeft = 2;
                this.headerTop = 2;
                this.iconHeight = 19;
                this.borderCenterMask = "all";
                this.borderFooterBottomLeftImage = _embed_css_images_Widget_Footer_tileable_end01_png_99047970;
                this.footerTop = 0;
                this.verticalGap = 2;
                this.headerPaddingRight = 0;
                this.borderFooterBottomRightImage = _embed_css_images_Widget_Footer_tileable_end02_png_100995747;
                this.footerPaddingLeft = 0;
                this.headerPaddingTop = 0;
                this.paddingTop = 2;
                this.borderCenterTopRightImage = _embed_css_images_Border_Widget_corner_png_30247409;
                this.headerHorizontalAlign = "center";
                this.borderHeaderTopImage = _embed_css_images_Widget_HeaderBG_png_730116019;
                this.borderHeaderMask = "top";
                this.iconWidth = 23;
                this.footerHeight = 10;
                this.titleFontWeight = "normal";
                this.footerPaddingRight = 0;
                this.footerLeft = 0;
                this.collapseButtonStyle = "widgetViewCollapse";
                this.headerLeft = 39;
                this.footerWidth = 184;
                this.horizontalGap = 2;
                this.headerHorizontalGap = 1;
                this.headerPaddingLeft = 0;
                this.headerHeight = 19;
                this.closeButtonStyle = "widgetViewClose";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBoots_protected_png_674517205;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".premiumOnlyPremium");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".premiumOnlyPremium", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css_images_Icon_Premium_png_299837787;
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
                this.iconDefaultOverTopImage = "right";
                this.iconDefaultUpMask = "left";
                this.paddingRight = 0;
                this.selectedOverTopImage = "right";
                this.selectedDownLeftImage = "right";
                this.selectedOverLeftImage = "right";
                this.iconDefaultDownMask = "left";
                this.defaultDownTopImage = "right";
                this.iconDefaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.paddingBottom = 0;
                this.iconDefaultOverBottomImage = "right";
                this.iconSelectedDownMask = "right";
                this.iconDefaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.iconSelectedUpLeftImage = "right";
                this.iconSelectedDownTopImage = "right";
                this.selectedDownMask = "right";
                this.iconSelectedUpMask = "right";
                this.iconDefaultDownTopImage = "right";
                this.iconSelectedUpTopImage = "right";
                this.defaultOverLeftImage = "right";
                this.selectedUpTopImage = "right";
                this.iconSelectedDownBottomImage = "right";
                this.iconSelectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultDownMask = "left";
                this.selectedUpMask = "right";
                this.selectedDownBottomImage = "right";
                this.iconSelectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.iconDefaultUpTopImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.selectedOverRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.iconDefaultUpLeftImage = "right";
                this.selectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.iconDefaultOverLeftImage = "right";
                this.defaultUpLeftImage = "right";
                this.paddingLeft = 0;
                this.iconDefaultUpBottomImage = "right";
                this.iconSelectedOverMask = "right";
                this.iconSelectedDownLeftImage = "right";
                this.iconSelectedOverLeftImage = "right";
                this.selectedUpLeftImage = "right";
                this.iconSelectedOverTopImage = "right";
                this.skin = BitmapButtonSkin;
                this.icon = BitmapButtonIcon;
                this.defaultOverBottomImage = "right";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.toggleButtonStyle = "sideBarToggleRight";
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.defaultUpBottomImage = "right";
                this.defaultUpTopImage = "right";
                this.iconSelectedUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultOverTopImage = "right";
                this.selectedDownRightImage = _embed_css_images_Arrow_WidgetToggle_BG_png_2128357260;
                this.selectedOverMask = "right";
                this.iconDefaultDownLeftImage = "right";
                this.iconDefaultOverMask = "left";
                this.paddingTop = 0;
                this.iconSelectedUpBottomImage = "right";
                this.defaultOverMask = "left";
                this.selectedUpBottomImage = "right";
                this.defaultUpMask = "left";
                this.iconSelectedOverBottomImage = "right";
                this.selectedOverBottomImage = "right";
                this.selectedDownTopImage = "right";
                this.borderMask = "left";
                this.iconDefaultDownBottomImage = "right";
                this.iconDefaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
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
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Skull_png_1181631553;
                this.color = 16777215;
                this.borderCenterMask = "all";
                this.paddingRight = 0;
                this.borderFooterMask = "none";
                this.borderCenterCenterImage = _embed_css_images_UnjustifiedPoints_png_1782736303;
                this.paddingTop = 0;
                this.verticalGap = 0;
                this.paddingLeft = 0;
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
                this.horizontalGap = 1;
                this.hitpointsOffsetX = -2;
                this.manaOffsetY = -1;
                this.manaOffsetX = 2;
                this.stateStyle = "statusWidgetFat";
                this.skillStyle = "statusWidgetFatSkill";
                this.manaStyle = "statusWidgetFatMana";
                this.hitpointsStyle = "statusWidgetFatHitpoints";
                this.hitpointsOffsetY = -1;
                this.verticalGap = 1;
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
                this.amountBoxStyle = "npcAmountBox";
                this.errorColor = 16711680;
                this.iconImage = _embed_css_images_Icons_WidgetHeaders_Trades_png_17953531;
                this.color = 13221291;
                this.paddingRight = 0;
                this.summaryFormStyle = "npcSummaryForm";
                this.tradeModeTabStyle = "npcTradeModeTab";
                this.disabledColor = 13221291;
                this.objectSelectorStyle = "npcObjectSelector";
                this.tradeModeTabBarStyle = "npcTradeModeTabBar";
                this.tradeModeBoxStyle = "npcTradeModeBox";
                this.summaryBoxStyle = "npcSummaryBox";
                this.paddingBottom = 0;
                this.amountSelectorStyle = "npcAmountSelector";
                this.tradeModeTabHeight = 23;
                this.commitBoxStyle = "npcCommitBox";
                this.objectBoxStyle = "npcObjectBox";
                this.tradeModeTabWidth = 40;
                this.tradeModeLayoutButtonStyle = "npcTradeButtonLayout";
                this.paddingTop = 0;
                this.paddingLeft = 0;
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
                this.horizontalGap = 2;
                this.paddingBottom = 2;
                this.paddingRight = 3;
                this.paddingTop = 2;
                this.verticalGap = 2;
                this.paddingLeft = 3;
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
                this.backgroundColor = 65280;
                this.emptyBackgroundColor = 16711680;
                this.backgroundImage = _embed_css_images_slot_Hotkey_png_1006833303;
                this.paddingRight = 3;
                this.backgroundAlpha = 1;
                this.backgroundOverAlpha = 1;
                this.emptyBackgroundAlpha = 1;
                this.backgroundOutAlpha = 1;
                this.paddingBottom = 3;
                this.emptyBackgroundOutAlpha = 1;
                this.emptyBackgroundOverAlpha = 1;
                this.paddingTop = 3;
                this.paddingLeft = 3;
                return;
            }// end function
            ;
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
                this.verticalAlign = "middle";
                this.paddingBottom = 0;
                this.horizontalAlign = "left";
                this.paddingRight = 2;
                this.borderTopImage = _embed_css_images_BG_ChatTab_tileable_png_1482271674;
                this.borderMask = "top";
                this.paddingTop = 0;
                this.borderSkin = BitmapBorderSkin;
                this.paddingLeft = 2;
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
                this.fontFamily = "Verdana";
                this.fontSize = 10;
                this.fontStyle = "normal";
                this.fontColor = 16777215;
                this.fontWeight = "bold";
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
                this.paddingTop = 1;
                this.verticalGap = 2;
                this.fontWeight = "bold";
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.buttonYesStyle = "ingameShopYesButton";
                this.buttonCancelStyle = "ingameShopNoButton";
                this.errorColor = 16711680;
                this.informationColor = 4286945;
                this.successColor = 65280;
                this.buttonOkayStyle = "ingameShopYesButton";
                this.buttonNoStyle = "ingameShopNoButton";
                this.minimumButtonWidth = 60;
                this.titleBoxStyle = "popupDialogHeaderFooter";
                this.buttonBoxStyle = "popupDialogHeaderFooter";
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
                this.progressBarMalusStyleName = "statusWidgetParallelMalusSkillProgress";
                this.verticalAlign = "middle";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetParallelBonusSkillProgress";
                this.progressBarZeroStyleName = "statusWidgetParallelZeroSkillProgress";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetParallelSkillProgress";
                this.labelStyleName = ".statusWidgetSkillProgress";
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
                this.thumbSkin = _embed_css_images_Scrollbar_Handler_png_760479401;
                this.backgroundColor = 65280;
                this.upArrowDownSkin = _embed_css_images_Scrollbar_Arrow_up_pressed_png_165887905;
                this.trackSkin = _embed_css_images_Scrollbar_tileable_png_1885091563;
                this.downArrowDownSkin = _embed_css_images_Scrollbar_Arrow_down_pressed_png_1990651256;
                this.upArrowDisabledSkin = _embed_css_images_Scrollbar_Arrow_up_idle_png_18741135;
                this.upArrowUpSkin = _embed_css_images_Scrollbar_Arrow_up_idle_png_18741135;
                this.backgroundAlpha = 0;
                this.downArrowDisabledSkin = _embed_css_images_Scrollbar_Arrow_down_idle_png_91820120;
                this.upArrowOverSkin = _embed_css_images_Scrollbar_Arrow_up_over_png_860191089;
                this.downArrowUpSkin = _embed_css_images_Scrollbar_Arrow_down_idle_png_91820120;
                this.downArrowOverSkin = _embed_css_images_Scrollbar_Arrow_down_over_png_1360238424;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactZeroSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactZeroSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_zero_png_1390467341;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.paddingBottom = 1;
                this.paddingRight = 1;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.tabStyleName = "simpleTabNavigator";
                this.paddingTop = 1;
                this.borderStyle = "solid";
                this.paddingLeft = 1;
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
                this.icon = _embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_920566008;
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
                this.backgroundColor = 658961;
                this.horizontalGap = 16;
                this.paddingBottom = 2;
                this.horizontalAlign = "center";
                this.paddingRight = 2;
                this.backgroundAlpha = 0.8;
                this.paddingTop = 2;
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".astralSourceLabelAmountMissing");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".astralSourceLabelAmountMissing", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundColor = 1842980;
                this.color = 13120000;
                this.textAlign = "center";
                this.fontWeight = "bold";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_idle_png_2144032898;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759328973;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1806477361;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1806477361;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759328973;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Containers_active_png_387529648;
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
                this.borderColor = 8089164;
                this.backgroundColor = 1977654;
                this.errorColor = 16711680;
                this.color = 13221291;
                this.paddingRight = 2;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.5;
                this.verticalGap = 1;
                this.disabledColor = 13221291;
                this.borderThickness = 1;
                this.horizontalGap = 4;
                this.paddingBottom = 2;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
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
                this.titleRightTabStyle = "chatWidgetRightTab";
                this.titleBarStyle = "chatWidgetTitle";
                this.titleTabBarStyle = "chatWidgetTabBar";
                this.inputBarTextFieldStyle = "chatWidgetTextField";
                this.inputBarStyle = "chatWidgetInput";
                this.paddingRight = 0;
                this.titleRightHolderStyle = "chatWidgetRightHolder";
                this.titleIgnoreButtonStyle = "chatWidgetButtonIgnore";
                this.borderSkin = BitmapBorderSkin;
                this.borderTopRightImage = _embed_css_images_Border02_corners_png_2023953407;
                this.verticalGap = 0;
                this.viewBarSingleViewStyle = "chatWidgetSingleView";
                this.viewBarStyle = "chatWidgetView";
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.titleOpenButtonStyle = "chatWidgetButtonOpen";
                this.viewBarRightViewStyle = "chatWidgetRightView";
                this.borderRightImage = _embed_css_images_Border02_png_248151906;
                this.borderMask = "left bottomLeft bottom bottomRight right center";
                this.paddingTop = 0;
                this.viewBarLeftViewStyle = "chatWidgetLeftView";
                this.paddingLeft = 0;
                this.borderCenterImage = _embed_css_images_BG_BohemianTileable_ChatConsole_png_2130554773;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetDefaultZeroSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetDefaultZeroSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_zero_png_1390467341;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.verticalAlign = "middle";
                this.paddingBottom = 0;
                this.horizontalAlign = "right";
                this.paddingRight = 2;
                this.paddingTop = 0;
                this.verticalGap = 0;
                this.borderSkin = EmptySkin;
                this.paddingLeft = 2;
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
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.color = 16232264;
                this.fontWeight = "bold";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryBoots_png_1061018524;
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
                this.toggleButtonStyle = "actionBarWidgetToggleTop";
                this.scrollUpButtonStyle = "actionBarWidgetScrollRight";
                this.scrollDownButtonStyle = "actionBarWidgetScrollLeft";
                this.borderMask = "left topLeft top topRight right center";
                return;
            }// end function
            ;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "bottom";
                this.defaultDisabledBottom = 11;
                this.defaultDownBottom = 11;
                this.skin = BitmapButtonSkin;
                this.defaultUpBottom = 11;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "bottom";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "bottom";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultOverBottom = 11;
                this.defaultUpLeftImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "bottom";
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
                this.borderThickness = 1;
                this.borderColor = 8089164;
                this.borderAlpha = 1;
                this.borderStyle = "solid";
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryLegs_protected_png_516995939;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1235819155;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1241884053;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_443456403;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_443456403;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1241884053;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1100929387;
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
                this.subscriberTextColor = 6355040;
                this.pendingTextColor = 16753920;
                this.inviteeTextColor = 16277600;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyUnlockTemporarilyButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyUnlockTemporarilyButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css____images_prey_prey_unlock_temporarily_png_1205226112;
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
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default__png_162149957;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_WidgetToggle_idle_png_952187387;
                this.defaultDownRightImage = _embed_css_images_Arrow_WidgetToggle_pressed_png_948994267;
                this.defaultUpBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_WidgetToggle_over_png_468729605;
                this.defaultUpLeftImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "left";
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
                this.defaultDisabledRightImage = "left";
                this.defaultDisabledBottomRightImage = "bottomLeft";
                this.paddingRight = 4;
                this.selectedOverTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_over_png_1569901787;
                this.selectedDisabledBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_disabled_png_97198997;
                this.selectedDownLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_pressed_png_1339953035;
                this.selectedOverLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_over_png_427887893;
                this.defaultOverBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_over_png_1316684489;
                this.defaultDisabledTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_disabled_png_369402996;
                this.defaultDownTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_pressed_png_1408096916;
                this.selectedOverBottomRightImage = "bottomLeft";
                this.defaultUpCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501;
                this.paddingBottom = 0;
                this.selectedDownTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_pressed_png_1978729388;
                this.textSelectedColor = 13221291;
                this.defaultDownCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645;
                this.selectedDownCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_pressed_png_253647645;
                this.defaultDisabledTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_disabled_png_1116270317;
                this.selectedUpBottomRightImage = "bottomLeft";
                this.height = 22;
                this.defaultUpTopRightImage = "topLeft";
                this.selectedUpTopRightImage = "topLeft";
                this.selectedUpCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_idle_png_863893501;
                this.selectedDisabledTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_disabled_png_744772701;
                this.selectedDownMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDisabledTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_disabled_png_929049956;
                this.selectedOverTopRightImage = "topLeft";
                this.defaultOverLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_over_png_158167172;
                this.defaultDownMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedUpTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_idle_png_1034633179;
                this.selectedUpMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDownBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_pressed_png_1996698541;
                this.selectedDisabledBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_disabled_png_1996451214;
                this.selectedOverTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_over_png_1203653996;
                this.focusThickness = 0;
                this.defaultDownBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_pressed_png_1258615591;
                this.selectedDownBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_pressed_png_1673065226;
                this.defaultDownLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_pressed_png_236721532;
                this.defaultOverRightImage = "left";
                this.defaultOverCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939;
                this.defaultDisabledTopRightImage = "topLeft";
                this.selectedDownTopRightImage = "topLeft";
                this.selectedOverRightImage = "left";
                this.selectedUpRightImage = "left";
                this.textRollOverColor = 15904590;
                this.defaultUpLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_idle_png_1658654332;
                this.paddingLeft = 4;
                this.selectedOverBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_over_png_269609286;
                this.color = 15904590;
                this.defaultDisabledBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_disabled_png_953976447;
                this.selectedUpLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_idle_png_1245218325;
                this.skin = StyleSizedBitmapButtonSkin;
                this.defaultOverBottomRightImage = "bottomLeft";
                this.defaultOverBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_over_png_46790494;
                this.defaultDisabledLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_ml_disabled_png_846678076;
                this.selectedUpBottomLeftImage = _embed_css_images_custombutton_Button_Border_tileable_bl_idle_png_1479317574;
                this.defaultDownBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_pressed_png_969488782;
                this.defaultUpRightImage = "left";
                this.defaultOverTopRightImage = "topLeft";
                this.defaultDownTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_pressed_png_1833730757;
                this.defaultDownRightImage = "left";
                this.defaultUpBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_idle_png_1913227682;
                this.selectedDisabledLeftImage = _embed_css_images_custombutton_Button_Border_tileable_ml_disabled_png_1201650483;
                this.defaultUpTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_idle_png_700367956;
                this.selectedDisabledTopRightImage = "topLeft";
                this.defaultOverTopImage = _embed_css_images_custombutton_Button_Standard_tileable_tc_over_png_1962565460;
                this.selectedDownRightImage = "left";
                this.selectedOverMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.paddingTop = 0;
                this.selectedUpTopLeftImage = _embed_css_images_custombutton_Button_Border_tileable_tl_idle_png_460698220;
                this.defaultDisabledBottomImage = _embed_css_images_custombutton_Button_Standard_tileable_bc_disabled_png_2000142426;
                this.defaultOverMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDisabledRightImage = "left";
                this.selectedUpBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_idle_png_713449011;
                this.selectedDownBottomRightImage = "bottomLeft";
                this.defaultUpMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedDisabledCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429;
                this.defaultUpBottomLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_bl_idle_png_2093052983;
                this.defaultDisabledCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_disabled_png_1660613429;
                this.defaultDisabledMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
                this.selectedOverBottomImage = _embed_css_images_custombutton_Button_Border_tileable_bc_over_png_718071091;
                this.disabledColor = 15904590;
                this.defaultDownTopRightImage = "topLeft";
                this.defaultUpTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_idle_png_1688019237;
                this.defaultUpBottomRightImage = "bottomLeft";
                this.selectedDownTopImage = _embed_css_images_custombutton_Button_Border_tileable_tc_pressed_png_491469499;
                this.selectedOverCenterImage = _embed_css_images_custombutton_Button_Standard_tileable_mc_over_png_4423939;
                this.width = 1;
                this.defaultDownBottomRightImage = "bottomLeft";
                this.selectedDisabledBottomRightImage = "bottomLeft";
                this.defaultOverTopLeftImage = _embed_css_images_custombutton_Button_Standard_tileable_tl_over_png_424714789;
                this.selectedDisabledMask = "topLeft top topRight left center right bottomLeft bottom bottomRight";
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_582119269;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1911407069;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1660751461;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1660751461;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1911407069;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_228803293;
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
                this.toggleButtonStyle = "actionBarWidgetToggleRight";
                this.scrollUpButtonStyle = "actionBarWidgetScrollBottom";
                this.scrollDownButtonStyle = "actionBarWidgetScrollTop";
                this.borderMask = "right center";
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
                this.defaultUpMask = "center";
                this.selectedDownMask = "center";
                this.selectedDisabledCenterImage = _embed_css_images_Button_Maximize_idle_png_960737362;
                this.skin = BitmapButtonSkin;
                this.defaultDisabledCenterImage = _embed_css_images_Button_Minimize_idle_png_996649268;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Button_Minimize_idle_png_996649268;
                this.selectedOverCenterImage = _embed_css_images_Button_Maximize_over_png_853065390;
                this.defaultOverCenterImage = _embed_css_images_Button_Minimize_over_png_1857747508;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Button_Minimize_pressed_png_1803996148;
                this.selectedDownCenterImage = _embed_css_images_Button_Maximize_pressed_png_1415129086;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Button_Maximize_idle_png_960737362;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1991267500;
                this.selectedOverCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1138143095;
                this.defaultOverCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1428562487;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1428562487;
                this.selectedDownCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1138143095;
                this.defaultOverMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_WidgetMenu_Inventory_active_png_506655126;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_DoveOff_idle_png_369785836;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_DoveOn_over_png_931245694;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_DoveOff_over_png_893524756;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_DoveOff_over_png_893524756;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_DoveOn_over_png_931245694;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1799831422;
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
                this.borderThickness = 1;
                this.borderColor = 13415802;
                this.backgroundColor = 658961;
                this.color = 13221291;
                this.borderAlpha = 1;
                this.backgroundAlpha = 0.8;
                this.borderSkin = VectorBorderSkin;
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
                this.progressBarMalusStyleName = "statusWidgetDefaultMalusSkillProgress";
                this.verticalAlign = "middle";
                this.iconStyleName = "";
                this.progressBarBonusStyleName = "statusWidgetDefaultBonusSkillProgress";
                this.progressBarZeroStyleName = "statusWidgetDefaultZeroSkillProgress";
                this.horizontalGap = 0;
                this.progressBarStyleName = "statusWidgetDefaultSkillProgress";
                this.labelStyleName = ".statusWidgetSkillProgress";
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
                this.barRedLow = _embed_css_images_BarsHealth_default_RedLow_png_1323495386;
                this.barImages = ["barRedLow2", "barRedLow", "barRedFull", "barYellow", "barGreenLow", "barGreenFull"];
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_341854824;
                this.barRedFull = _embed_css_images_BarsHealth_default_RedFull_png_471797811;
                this.barGreenFull = _embed_css_images_BarsHealth_default_GreenFull_png_539233669;
                this.paddingRight = 3;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "left";
                this.barYellow = _embed_css_images_BarsHealth_default_Yellow_png_338291605;
                this.barGreenLow = _embed_css_images_BarsHealth_default_GreenLow_png_1615903576;
                this.rightOrnamentMask = "right";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_402625151;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barRedLow2 = _embed_css_images_BarsHealth_default_RedLow2_png_1319540706;
                this.leftOrnamentOffset = -5;
                this.rightOrnamentOffset = 5;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.paddingLeft = 3;
                this.barLimits = [0, 0.04, 0.1, 0.3, 0.6, 0.95];
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
                this.defaultDisabledRightImage = _embed_css_images_Arrow_ScrollTabs_disabled_png_879110432;
                this.defaultUpMask = "left";
                this.skin = BitmapButtonSkin;
                this.defaultOverBottomImage = "right";
                this.defaultOverLeftImage = "right";
                this.defaultDisabledMask = "left";
                this.defaultDisabledLeftImage = "right";
                this.defaultDownMask = "left";
                this.defaultDownBottomImage = "right";
                this.defaultUpRightImage = _embed_css_images_Arrow_ScrollTabs_idle_png_2086059672;
                this.defaultDownRightImage = _embed_css_images_Arrow_ScrollTabs_pressed_png_225438040;
                this.defaultUpBottomImage = "right";
                this.defaultDownLeftImage = "right";
                this.defaultOverRightImage = _embed_css_images_Arrow_ScrollTabs_over_png_1323680872;
                this.defaultUpLeftImage = "right";
                this.defaultDisabledBottomImage = "right";
                this.defaultOverMask = "left";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration("ImbuementInformationPane");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ImbuementInformationPane", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundColor = 658961;
                this.paddingBottom = 4;
                this.paddingRight = 4;
                this.backgroundAlpha = 0.5;
                this.paddingTop = 4;
                this.paddingLeft = 4;
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
                this.selectedBorderColor = 13415802;
                this.selectedBackgroundAlpha = 0.5;
                this.paddingRight = 0;
                this.skin = VectorTabSkin;
                this.selectedBorderAlpha = 1;
                this.selectedBackgroundColor = 658961;
                this.defaultBackgroundColor = 2240055;
                this.defaultBorderColor = 8089164;
                this.paddingBottom = 0;
                this.defaultBackgroundAlpha = 0.5;
                this.selectedTextColor = 13221291;
                this.defaultBorderAlpha = 1;
                this.selectedBorderThickness = 1;
                this.defaultTextColor = 15904590;
                this.paddingTop = 0;
                this.defaultBorderThickness = 1;
                this.paddingLeft = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".successRate");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".successRate", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.textAlign = "right";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".headerLabel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".headerLabel", style, false);
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
                this.emptyBackgroundImage = _embed_css_images_Slot_InventoryNecklace_protected_png_1799961580;
                this.backgroundImage = _embed_css_images_slot_Hotkey_protected_png_803702344;
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
                this.horizontalGap = 5;
                this.dividerBackgroundMask = "left";
                this.dividerBackgroundLeftImage = _embed_css_images_Border02_WidgetSidebar_slim_png_420837653;
                this.messagesStyle = "messages";
                this.dividerAffordance = 5;
                this.verticalGap = 0;
                this.nicklistStyle = "nicklist";
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
                this.color = 44562;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".preyDuration");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyDuration", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.backgroundLeftImage = _embed_css_images_BG_BarsProgress_compact_endpiece_png_1370317653;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.paddingBottom = 2;
                this.barDefault = _embed_css_images_BarsProgress_compact_orange_png_198580350;
                this.backgroundMask = "left center right";
                this.paddingTop = 2;
                this.labelHorizontalAlign = "center";
                this.backgroundCenterImage = _embed_css_images_BG_BarsProgress_compact_tileable_png_1434705776;
                this.barLimits = 0;
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
                this.selectedDownMask = "center";
                this.skin = BitmapButtonSkin;
                this.defaultDisabledMask = "center";
                this.defaultDownMask = "center";
                this.selectedUpMask = "center";
                this.defaultUpCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_283159200;
                this.selectedOverCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1435348302;
                this.defaultOverCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_814885792;
                this.selectedOverMask = "center";
                this.defaultDownCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_814885792;
                this.selectedDownCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1435348302;
                this.defaultOverMask = "center";
                this.selectedDisabledMask = "center";
                this.selectedUpCenterImage = _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1088011342;
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
                this.paddingBottom = 6;
                this.paddingRight = 6;
                this.paddingTop = 6;
                this.verticalGap = 6;
                this.paddingLeft = 6;
                this.fontWeight = "normal";
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
                this.outfitDialogOpenStoreButtonStyle = "buttonDialogOpenStoreButton";
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
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.itemBackgroundColors = [2768716, 16711680];
                this.paddingRight = 2;
                this.itemRendererStyle = "buddylistWidgetView";
                this.itemBackgroundAlphas = [0.5, 0];
                this.paddingTop = 0;
                this.verticalGap = 2;
                this.paddingLeft = 0;
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
                this.barImages = "barDefault";
                this.backgroundRightImage = _embed_css_images_BG_Bars_default_enpiece_png_341854824;
                this.paddingRight = 1;
                this.backgroundMask = "center";
                this.leftOrnamentMask = "left";
                this.rightOrnamentMask = "none";
                this.backgroundCenterImage = _embed_css_images_BG_Bars_default_tileable_png_402625151;
                this.rightOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.backgroundLeftImage = "right";
                this.leftOrnamentLeftImage = "right";
                this.paddingBottom = 3;
                this.barDefault = _embed_css_images_BarsHealth_default_Mana_png_2142805618;
                this.leftOrnamentOffset = -5;
                this.rightOrnamentOffset = 5;
                this.paddingTop = 1;
                this.leftOrnamentRightImage = _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1901253493;
                this.paddingLeft = 3;
                this.barLimits = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".statusWidgetCompactMalusSkillProgress");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusWidgetCompactMalusSkillProgress", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.tickCenterImage = _embed_css_images_Bars_ProgressMarker_png_1220674660;
                this.backgroundRightImage = "left";
                this.barImages = "barDefault";
                this.tickMask = "center";
                this.paddingRight = -5;
                this.backgroundMask = "left center right";
                this.backgroundCenterImage = _embed_css_images_BG_BarsXP_default_tileable_png_1802488215;
                this.backgroundLeftImage = _embed_css_images_BG_BarsXP_default_endpiece_png_1805006002;
                this.barDefault = _embed_css_images_BarsXP_default_malus_png_1223952997;
                this.paddingBottom = 4;
                this.tickOffset = 3;
                this.paddingTop = 3;
                this.paddingLeft = -5;
                this.barLimits = 0;
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
                this.borderCenterMask = "all";
                this.borderFooterMask = "none";
                this.borderCenterCenterImage = _embed_css_images_BG_Combat_ExpertOn_png_1994504722;
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
            style = StyleManager.getStyleDeclaration(".preyUnlockPermanentlyButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".preyUnlockPermanentlyButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.icon = _embed_css____images_prey_prey_unlock_permanently_png_2084364847;
                return;
            }// end function
            ;
            }
            var _loc_2:* = StyleManager;
            _loc_2.mx_internal::initProtoChainRoots();
            return;
        }// end function

        public function get m_UITibiaRootContainer() : HBox
        {
            return this._1020379552m_UITibiaRootContainer;
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

        private function _Tibia_Array1_i() : Array
        {
            var _loc_1:* = [undefined, undefined];
            this._Tibia_Array1 = _loc_1;
            BindingManager.executeBindings(this, "_Tibia_Array1", this._Tibia_Array1);
            return _loc_1;
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

        public function get m_UIActionBarBottom() : HActionBarWidget
        {
            return this._629924354m_UIActionBarBottom;
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
            if (this.m_EnableFocusNotifier && this.isActive == false)
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

        public function get isFocusNotifierEnabled() : Boolean
        {
            return this.m_EnableFocusNotifier;
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

        private function onConnectionRecovered(event:ConnectionEvent) : void
        {
            this.m_ConnectionLostDialog.hide();
            return;
        }// end function

        public function get m_UIActionBarRight() : VActionBarWidget
        {
            return this._2043305115m_UIActionBarRight;
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

        public function get m_UIWorldMapWidget() : WorldMapWidget
        {
            return this._1314206572m_UIWorldMapWidget;
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
            if (!this.m_ConnectionEstablishedAndPacketReceived && this.m_FailedConnectionRescheduler.shouldAttemptReconnect())
            {
                this.onConnectionLoginWait(this.m_FailedConnectionRescheduler.buildEventForReconnectionAndIncreaseRetries());
                return;
            }
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
                this.m_ConnectionEstablishedAndPacketReceived = true;
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

        public function set isFocusNotifierEnabled(param1:Boolean) : void
        {
            if (param1 != this.m_EnableFocusNotifier)
            {
                this.m_EnableFocusNotifier = param1;
                if (!this.m_EnableFocusNotifier)
                {
                    FocusNotifier.getInstance().hide();
                }
            }
            return;
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

        public function get m_UIWorldMapWindow() : GameWindowContainer
        {
            return this._1313911232m_UIWorldMapWindow;
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
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINCHALLENGE, this.onConnectionLoginChallenge);
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINADVICE, this.onConnectionLoginAdvice);
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINERROR, this.onConnectionLoginError);
                this.m_Connection.removeEventListener(ConnectionEvent.LOGINWAIT, this.onConnectionLoginWait);
                this.m_Connection.disconnect(false);
                this.m_Connection = null;
                this.m_ConnectionEstablishedAndPacketReceived = false;
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

        public function get m_UISideBarD() : SideBarWidget
        {
            return this._64278962m_UISideBarD;
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

        private function onConnectionLoginChallenge(event:ConnectionEvent) : void
        {
            this.m_ConnectionEstablishedAndPacketReceived = true;
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

        public function get m_UIGameWindow() : GridContainer
        {
            return this._1404294856m_UIGameWindow;
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

        public static function s_GetCreatureStorage() : CreatureStorage
        {
            return (application as ).m_CreatureStorage;
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

        public static function s_GetPlayer() : Player
        {
            return (application as ).m_Player;
        }// end function

    }
}

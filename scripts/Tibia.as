package
{
   import mx.core.Application;
   import mx.binding.IBindingClient;
   import tibia.game.IGameClient;
   import mx.binding.IWatcherSetupUtil;
   import tibia.network.Communication;
   import tibia.input.InputHandler;
   import tibia.appearances.AppearanceStorage;
   import loader.asset.IAssetProvider;
   import tibia.chat.ChatStorage;
   import tibia.minimap.MiniMapStorage;
   import tibia.options.OptionsStorage;
   import tibia.container.ContainerStorage;
   import tibia.chat.ChatWidget;
   import tibia.input.gameaction.GameActionFactory;
   import tibia.magic.SpellStorage;
   import tibia.creatures.StatusWidget;
   import tibia.worldmap.WorldMapStorage;
   import tibia.network.IServerConnection;
   import tibia.help.UIEffectsManager;
   import tibia.creatures.Player;
   import tibia.creatures.CreatureStorage;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import tibia.actionbar.VActionBarWidget;
   import mx.binding.BindingManager;
   import tibia.options.OptionsAsset;
   import mx.events.CloseEvent;
   import tibia.game.PopUpBase;
   import tibia.worldmap.WorldMapWidget;
   import flash.events.Event;
   import tibia.network.IConnectionData;
   import tibia.sessiondump.Sessiondump;
   import mx.containers.HBox;
   import tibia.network.ConnectionEvent;
   import tibia.game.MessageWidget;
   import tibia.actionbar.HActionBarWidget;
   import tibia.sessiondump.controller.SessiondumpControllerBase;
   import tibia.game.AccountCharacter;
   import tibia.network.Connection;
   import tibia.sessiondump.SessiondumpConnectionData;
   import tibia.sessiondump.controller.SessiondumpControllerHints;
   import tibia.game.TimeoutWaitWidget;
   import tibia.sidebar.ToggleBar;
   import mx.binding.Binding;
   import mx.containers.BoxDirection;
   import tibia.sidebar.SideBarSet;
   import tibia.actionbar.ActionBarSet;
   import flash.events.ErrorEvent;
   import tibia.game.GameEvent;
   import tibia.game.FocusNotifier;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import tibia.cursors.ResizeVerticalCursor;
   import shared.skins.BitmapBorderSkin;
   import shared.skins.BitmapButtonSkin;
   import shared.skins.BitmapButtonIcon;
   import shared.skins.VectorDataGridHeaderSeparatorSkin;
   import shared.skins.VectorDataGridHeaderBackgroundSkin;
   import shared.skins.VectorBorderSkin;
   import shared.skins.EmptySkin;
   import tibia.sidebar.sideBarWidgetClasses.WidgetViewSkin;
   import tibia.cursors.ResizeHorizontalCursor;
   import shared.skins.VectorTabSkin;
   import tibia.cursors.DragCopyCursor;
   import tibia.cursors.DragMoveCursor;
   import tibia.cursors.DragNoneCursor;
   import tibia.cursors.DragLinkCursor;
   import mx.events.ResizeEvent;
   import tibia.controls.GridContainer;
   import mx.events.FlexEvent;
   import build.ApperanceStorageFactory;
   import flash.utils.*;
   import flash.events.TimerEvent;
   import mx.events.DividerEvent;
   import tibia.sessiondump.hints.gameaction.SessiondumpHintsGameActionFactory;
   import tibia.sidebar.SideBarWidget;
   import mx.managers.ToolTipManager;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import flash.net.URLRequest;
   import shared.utility.URLHelper;
   import flash.net.navigateToURL;
   import tibia.game.LoginWaitWidget;
   import tibia.game.ConnectionLostWidget;
   import mx.containers.DividedBox;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.errors.IllegalOperationError;
   import mx.core.IUIComponent;
   import tibia.controls.GameWindowContainer;
   import shared.controls.EmbeddedDialog;
   import tibia.game.CharacterSelectionWidget;
   import mx.managers.CursorManager;
   import tibia.game.ContextMenuBase;
   import tibia.game.PopUpQueue;
   import mx.collections.ArrayCollection;
   import shared.controls.CustomDividedBox;
   import tibia.sessiondump.controller.SessiondumpMouseShield;
   import tibia.sessiondump.SessiondumpCreatureStorage;
   import mx.core.UIComponentDescriptor;
   
   use namespace mx_internal;
   
   public class Tibia extends Application implements IBindingClient, IGameClient
   {
      
      private static const BUNDLE:String = "Tibia";
      
      private static const SHAREDOBJECT_NAME:String = "options";
      
      public static var s_TibiaLoginTimestamp:Number = 0;
      
      public static var s_FrameTibiaTimestamp:Number = 0;
      
      public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
      
      public static var s_FrameRealTimestamp:Number = 0;
      
      public static const CLIENT_PREVIEW_STATE:uint = 0;
      
      private static var s_InternalTibiaTimerFactor:Number = 1;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const MAX_SESSION_KEY_LENGTH:int = 30;
      
      private static var s_LastTibiaFactorChangeRealTimestamp:int = 0;
      
      public static const CLIENT_TYPE:uint = 3;
      
      public static const CLIENT_VERSION:uint = 1639;
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
      
      private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
      
      public static const PREVIEW_STATE_REGULAR:uint = 0;
      
      private static var s_LastTibiaTimestamp:int = 0;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Border02_WidgetSidebar_png_450459769:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1078184797:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1162575680:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1340418748:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_1562453487:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_667864756:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_454486650:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_1203189548:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1885589980:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_725903914:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1223008966:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1526437001:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1790678924:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_173292649:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      protected var m_CurrentOptionsUploadErrorDelay:int = 0;
      
      private var _1020379552m_UITibiaRootContainer:HBox;
      
      protected var m_IsActive:Boolean = false;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_668800425:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_801101738:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1699047529:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1200651725:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1429291016:Class;
      
      private var _embed_css_images_Inventory_png_316871002:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1271084003:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1671781766:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1447936623:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1365458539:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_346527371:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_108506189:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_135782122:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1409112361:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_1003611869:Class;
      
      private var m_TutorialMode:Boolean = false;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_592307791:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1617145235:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_2103603813:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1812672504:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_300738046:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1189848396:Class;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_3138509:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1684838793:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1612310559:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1549712567:Class;
      
      private var _embed_css_images_Minimap_png_814069837:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883031407:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_713587817:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_1248449947:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_33747:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_1880218047:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_340332232:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_716268777:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_640211384:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_636126986:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1713303168:Class;
      
      private var _embed_css_images_BG_Combat_png_919817016:Class;
      
      private var m_GameClientReady:Boolean = false;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1160772545:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1742993955:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_595043396:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1409321227:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636533651:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_345531871:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1993434623:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1126661056:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_1086399223:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_674012337:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_124685307:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_2131167606:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_833357120:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_891158331:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1127889587:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_288129660:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_497744859:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_413165316:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_825215016:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1064630238:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Scrollbar_tileable_png_1683633647:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_8645003:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_2125783755:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_828805395:Class;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_1627219103:Class;
      
      protected var m_Connection:IServerConnection = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1046225724:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_893737611:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_1224962720:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_381817315:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1060068386:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_2073705665:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1852654047:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_262803073:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_383859744:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_217718721:Class;
      
      protected var m_ConnectionDataPending:int = -1;
      
      private var _embed_css_images_Button_Minimize_over_png_1654856540:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_914297759:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_922875448:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_2125664097:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1863726688:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_289721166:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_1094882491:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_360734875:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_598506393:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1682915131:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_896247472:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1632350288:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_742270436:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1538737364:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1966161674:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1583677838:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1732161192:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_822949523:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_86384979:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_839114951:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1251978973:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1808091017:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_886581912:Class;
      
      private var _embed_css_images_BarsXP_default__png_639110899:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_1208242539:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Button_Maximize_pressed_png_1486965818:Class;
      
      private var _1568861366m_UIOuterRootContainer:DividedBox;
      
      private var _embed_css_images_Minimap_Center_idle_png_2073478622:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_740757197:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_1537286732:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_2033521506:Class;
      
      protected var m_CharacterDeath:Boolean = false;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1197742135:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1412346243:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_27356575:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2096148797:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1671311057:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_248536441:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_904141071:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_640064867:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Border02_png_183648090:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1582217690:Class;
      
      private var _embed_css_images_slot_Hotkey_highlighted_png_1536030283:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1335640639:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_882214800:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_278937824:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_361550692:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1753954938:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759697413:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1798779603:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1633418890:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1764860287:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1854643098:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_667539824:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_1318955612:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_466532130:Class;
      
      private var _embed_css_images_Border02_corners_png_1873071613:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_787421096:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1522337533:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_1321323654:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1339938828:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_426482370:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_2068698686:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_1017885002:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_193136938:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1259804131:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_885975952:Class;
      
      private var _embed_css_images_slot_container_png_2063755284:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_2007873148:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_1155688785:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Border_Widget_png_454896827:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_830803466:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1677894318:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_300188399:Class;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_1216489215:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_173858596:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_659063096:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1491604591:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1074895586:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_584383358:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1776971380:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1528661303:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_2108084854:Class;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_657599811:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_292416878:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1580563200:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_533009199:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1973652958:Class;
      
      protected var m_AssetProvider:IAssetProvider = null;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1656132313:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_2129817718:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_1615829797:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_457469291:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_881996426:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1407250695:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1927946395:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_2072473373:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_390096308:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_290519671:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_1255902700:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_1050425438:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1990411926:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1147857557:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Button_Close_over_png_1292056750:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_164081250:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_314856227:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_110968856:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_677852663:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_215505751:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_1298431913:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_584172107:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_277550655:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_307875147:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2065223801:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_425344202:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1281235426:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1566543590:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_870966957:Class;
      
      private var m_ForceDisableGameWindowSizeCalc:Boolean = false;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_795307171:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_474740429:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1601318650:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_468219125:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1616580725:Class;
      
      private var _embed_css_images_slot_Hotkey_png_404927663:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1646013740:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_857245793:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1687820544:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_1135408825:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Slot_Statusicon_png_1336149226:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1429758896:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1193962089:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1620805250:Class;
      
      protected var m_UIEffectsManager:UIEffectsManager = null;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_989831592:Class;
      
      protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_331843001:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1588158565:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1170005871:Class;
      
      private var _embed_css_images_Button_Close_idle_png_947763118:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1026515466:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1854234174:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_719575887:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_376072689:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_670523093:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_35872917:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2115393665:Class;
      
      private var _embed_css_images_slot_Hotkey_disabled_png_739205092:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _967396880m_UIBottomContainer:HBox;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_732340512:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1850729803:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1790439362:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1925708880:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_1268061015:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_415238650:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1051006991:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_268696923:Class;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_1932067081:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_262817616:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_1632567261:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1657345623:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_137065980:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1540463935:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_913406746:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_235830491:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_332618015:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_375144786:Class;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1453264669:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_485117951:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_236786906:Class;
      
      protected var m_ConnectionDataCurrent:int = -1;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1280663698:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1195764398:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1854931051:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_166056235:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_878332984:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_522741672:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_946080979:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_1302187306:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_795951013:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_620098782:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_450602897:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_809530334:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_551236802:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_598278734:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_481410398:Class;
      
      protected var m_TutorialData:Object;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1241955900:Class;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_762926419:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_16165272:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_881433907:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_141172846:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_95656626:Class;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_183025502:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1607385550:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1996778564:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1678416122:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_1226136413:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_782417334:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1563675646:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_425784419:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1504635230:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_78213987:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_498144444:Class;
      
      protected var m_Communication:Communication = null;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2100407432:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_2091235994:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_959874247:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_336957514:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_2039041338:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_622966088:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_574894445:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_1623566113:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_1353219444:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_872325229:Class;
      
      private var m_GameActionFactory:GameActionFactory = null;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_911288153:Class;
      
      protected var m_ChannelsPending:Vector.<int> = null;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_509090480:Class;
      
      private var m_ConnectionLostDialog:ConnectionLostWidget;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_929288841:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1685346260:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1809456517:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_83356974:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_1348672094:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_233015533:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_768138192:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_131623556:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function Tibia()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":DividedBox,
                  "id":"m_UIOuterRootContainer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "doubleClickEnabled":true,
                        "liveDragging":true,
                        "resizeToContent":true,
                        "styleName":"invisibleDivider",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"m_UITibiaRootContainer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "minHeight":450,
                                 "styleName":"rootContainer",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":SideBarWidget,
                                    "id":"m_UISideBarA",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "styleWithBorder":"sideBarLeftWithBorder"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":SideBarWidget,
                                    "id":"m_UISideBarB",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentHeight":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ToggleBar,
                                    "id":"m_UISideBarToggleLeft",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "styleName":"sideBarToggleLeft",
                                          "location":_Tibia_Array1_i()
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":CustomDividedBox,
                                    "id":"m_UICenterColumn",
                                    "events":{"dividerRelease":"__m_UICenterColumn_dividerRelease"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "doubleClickEnabled":true,
                                          "liveDragging":true,
                                          "resizeToContent":true,
                                          "styleName":"rootContainer",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":GridContainer,
                                             "id":"m_UIGameWindow",
                                             "events":{"resize":"__m_UIGameWindow_resize"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "percentHeight":100,
                                                   "center":_Tibia_GameWindowContainer1_i(),
                                                   "top":_Tibia_StatusWidget1_i()
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ChatWidget,
                                             "id":"m_UIChatWidget",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "percentHeight":0
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ToggleBar,
                                    "id":"m_UISideBarToggleRight",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "styleName":"sideBarToggleRight",
                                          "location":_Tibia_Array2_i()
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":SideBarWidget,
                                    "id":"m_UISideBarC",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentHeight":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":SideBarWidget,
                                    "id":"m_UISideBarD",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "styleWithBorder":"sideBarRightWithBorder"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"m_UIBottomContainer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":0
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":InputHandler,
                  "id":"m_UIInputHandler",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":0,
                        "height":0,
                        "x":-10,
                        "y":-10
                     };
                  }
               })]};
            }
         });
         this.m_ConnectionLostDialog = new ConnectionLostWidget();
         this.m_TutorialData = new Object();
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_95656626 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_95656626;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_141172846 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_141172846;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1280663698 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1280663698;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1607385550 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1607385550;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_872325229 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_872325229;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1850729803 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1850729803;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_584172107 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_584172107;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1852654047 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1852654047;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_592307791 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_592307791;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_674012337 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_674012337;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1078184797 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1078184797;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_742270436 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_742270436;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_1537286732 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_1537286732;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1189848396 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1189848396;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_509090480 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_509090480;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1162575680 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1162575680;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_881433907 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_881433907;
         this._embed_css_images_Arrow_WidgetToggle_over_png_3138509 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_3138509;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_345531871 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_345531871;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_801101738 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_801101738;
         this._embed_css_images_BG_BarsXP_default_tileable_png_795307171 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_795307171;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_795951013 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_795951013;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1060068386 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1060068386;
         this._embed_css_images_BG_Bars_compact_tileable_png_1699047529 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1699047529;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_2096148797 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_2096148797;
         this._embed_css_images_BG_Bars_default_enpiece_png_413165316 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_413165316;
         this._embed_css_images_BG_Bars_default_tileable_png_346527371 = Tibia__embed_css_images_BG_Bars_default_tileable_png_346527371;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1616580725 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1616580725;
         this._embed_css_images_BG_Bars_fat_enpiece_png_361550692 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_361550692;
         this._embed_css_images_BG_Bars_fat_tileable_png_1522337533 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1522337533;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1251978973 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1251978973;
         this._embed_css_images_BG_BohemianTileable_Game_png_825215016 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_825215016;
         this._embed_css_images_BG_BohemianTileable_png_1632567261 = Tibia__embed_css_images_BG_BohemianTileable_png_1632567261;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_137065980 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_137065980;
         this._embed_css_images_BG_ChatTab_tileable_png_1563675646 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1563675646;
         this._embed_css_images_BG_Combat_png_919817016 = Tibia__embed_css_images_BG_Combat_png_919817016;
         this._embed_css_images_BG_Stone2_Tileable_png_1339938828 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1339938828;
         this._embed_css_images_BG_Widget_Menu_png_1255902700 = Tibia__embed_css_images_BG_Widget_Menu_png_1255902700;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_381817315 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_381817315;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_425344202 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_425344202;
         this._embed_css_images_BarsHealth_compact_Mana_png_1632350288 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1632350288;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1447936623 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1447936623;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_595043396 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_595043396;
         this._embed_css_images_BarsHealth_compact_RedLow_png_288129660 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_288129660;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1491604591 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1491604591;
         this._embed_css_images_BarsHealth_default_GreenFull_png_262803073 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_262803073;
         this._embed_css_images_BarsHealth_default_GreenLow_png_1353219444 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1353219444;
         this._embed_css_images_BarsHealth_default_Mana_png_1677894318 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1677894318;
         this._embed_css_images_BarsHealth_default_RedFull_png_533009199 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_533009199;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1582217690 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1582217690;
         this._embed_css_images_BarsHealth_default_RedLow_png_2033521506 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_2033521506;
         this._embed_css_images_BarsHealth_default_Yellow_png_1003611869 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_1003611869;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_1086399223 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_1086399223;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_173858596 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_173858596;
         this._embed_css_images_BarsHealth_fat_Mana_png_2108084854 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_2108084854;
         this._embed_css_images_BarsHealth_fat_RedFull_png_1268061015 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1268061015;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1854234174 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1854234174;
         this._embed_css_images_BarsHealth_fat_RedLow_png_1302187306 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_1302187306;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1588158565 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1588158565;
         this._embed_css_images_BarsXP_default__png_639110899 = Tibia__embed_css_images_BarsXP_default__png_639110899;
         this._embed_css_images_Bars_ProgressMarker_png_1429758896 = Tibia__embed_css_images_Bars_ProgressMarker_png_1429758896;
         this._embed_css_images_Border02_WidgetSidebar_png_450459769 = Tibia__embed_css_images_Border02_WidgetSidebar_png_450459769;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_1226136413 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_1226136413;
         this._embed_css_images_Border02_corners_png_1873071613 = Tibia__embed_css_images_Border02_corners_png_1873071613;
         this._embed_css_images_Border02_png_183648090 = Tibia__embed_css_images_Border02_png_183648090;
         this._embed_css_images_Border_Widget_corner_png_233015533 = Tibia__embed_css_images_Border_Widget_corner_png_233015533;
         this._embed_css_images_Border_Widget_png_454896827 = Tibia__embed_css_images_Border_Widget_png_454896827;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_376072689 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_376072689;
         this._embed_css_images_Button_ChatTabIgnore_over_png_904141071 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_904141071;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_124685307 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_124685307;
         this._embed_css_images_Button_ChatTabNew_idle_png_1200651725 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1200651725;
         this._embed_css_images_Button_ChatTabNew_over_png_474740429 = Tibia__embed_css_images_Button_ChatTabNew_over_png_474740429;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1051006991 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1051006991;
         this._embed_css_images_Button_ChatTab_Close_idle_png_1203189548 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1203189548;
         this._embed_css_images_Button_ChatTab_Close_over_png_1685346260 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1685346260;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1429291016 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1429291016;
         this._embed_css_images_Button_Close_idle_png_947763118 = Tibia__embed_css_images_Button_Close_idle_png_947763118;
         this._embed_css_images_Button_Close_over_png_1292056750 = Tibia__embed_css_images_Button_Close_over_png_1292056750;
         this._embed_css_images_Button_Close_pressed_png_1566543590 = Tibia__embed_css_images_Button_Close_pressed_png_1566543590;
         this._embed_css_images_Button_Combat_Stop_idle_png_1562453487 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1562453487;
         this._embed_css_images_Button_Combat_Stop_over_png_300188399 = Tibia__embed_css_images_Button_Combat_Stop_over_png_300188399;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1798779603 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1798779603;
         this._embed_css_images_Button_ContainerUp_idle_png_1348672094 = Tibia__embed_css_images_Button_ContainerUp_idle_png_1348672094;
         this._embed_css_images_Button_ContainerUp_over_png_481410398 = Tibia__embed_css_images_Button_ContainerUp_over_png_481410398;
         this._embed_css_images_Button_ContainerUp_pressed_png_164081250 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_164081250;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_425784419 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_425784419;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_78213987 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_78213987;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_193136938 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_193136938;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_725903914 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_725903914;
         this._embed_css_images_Button_Maximize_idle_png_1017885002 = Tibia__embed_css_images_Button_Maximize_idle_png_1017885002;
         this._embed_css_images_Button_Maximize_over_png_782417334 = Tibia__embed_css_images_Button_Maximize_over_png_782417334;
         this._embed_css_images_Button_Maximize_pressed_png_1486965818 = Tibia__embed_css_images_Button_Maximize_pressed_png_1486965818;
         this._embed_css_images_Button_Minimize_idle_png_1318955612 = Tibia__embed_css_images_Button_Minimize_idle_png_1318955612;
         this._embed_css_images_Button_Minimize_over_png_1654856540 = Tibia__embed_css_images_Button_Minimize_over_png_1654856540;
         this._embed_css_images_Button_Minimize_pressed_png_1732161192 = Tibia__embed_css_images_Button_Minimize_pressed_png_1732161192;
         this._embed_css_images_Button_Standard_tileable_disabled_png_989831592 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_989831592;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1885589980 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1885589980;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_1208242539 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_1208242539;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1271084003 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1271084003;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_2072473373 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_2072473373;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_173292649 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_173292649;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1241955900 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1241955900;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1046225724 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1046225724;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_110968856 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_110968856;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1612310559 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1612310559;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_332618015 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_332618015;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_740757197 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_740757197;
         this._embed_css_images_Button_Standard_tileable_idle_png_383859744 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_383859744;
         this._embed_css_images_Button_Standard_tileable_over_png_732340512 = Tibia__embed_css_images_Button_Standard_tileable_over_png_732340512;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1790678924 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1790678924;
         this._embed_css_images_BuySellTab_active_png_1195764398 = Tibia__embed_css_images_BuySellTab_active_png_1195764398;
         this._embed_css_images_BuySellTab_idle_png_1687820544 = Tibia__embed_css_images_BuySellTab_idle_png_1687820544;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_768138192 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_768138192;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1127889587 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1127889587;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1365458539 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1365458539;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1064630238 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1064630238;
         this._embed_css_images_ChatTab_tileable_idle_png_1298431913 = Tibia__embed_css_images_ChatTab_tileable_idle_png_1298431913;
         this._embed_css_images_ChatTab_tileable_png_1223008966 = Tibia__embed_css_images_ChatTab_tileable_png_1223008966;
         this._embed_css_images_ChatWindow_Mover_png_1854643098 = Tibia__embed_css_images_ChatWindow_Mover_png_1854643098;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_307875147 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_307875147;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1790439362 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1790439362;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_833357120 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_833357120;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1126661056 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1126661056;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_885975952 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_885975952;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1742993955 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1742993955;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_2103603813 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_2103603813;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1927946395 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1927946395;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_881996426 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_881996426;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_959874247 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_959874247;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_8645003 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_8645003;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_893737611 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_893737611;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_667539824 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_667539824;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1617145235 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1617145235;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_1248449947 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_1248449947;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_360734875 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_360734875;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_870966957 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_870966957;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_2091235994 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_2091235994;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_922875448 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_922875448;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_659063096 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_659063096;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_830803466 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_830803466;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_636126986 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_636126986;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_1050425438 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_1050425438;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_183025502 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_183025502;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636533651 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_636533651;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_822949523 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_822949523;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2065223801 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2065223801;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_248536441 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_248536441;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2115393665 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2115393665;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883031407 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1883031407;
         this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_640211384 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_640211384;
         this._embed_css_images_Icons_CombatControls_DoveOff_over_png_622966088 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_622966088;
         this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_1671781766 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_1671781766;
         this._embed_css_images_Icons_CombatControls_DoveOn_over_png_1321323654 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_1321323654;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_1526437001 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_1526437001;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_290519671 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_290519671;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_2073705665 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_2073705665;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1335640639 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1335640639;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_1135408825 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_1135408825;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_331843001 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_331843001;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_857245793 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_857245793;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_2125664097 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_2125664097;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_35872917 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_35872917;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1854931051 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1854931051;
         this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1808091017 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1808091017;
         this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_929288841 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_929288841;
         this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_33747 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_33747;
         this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_946080979 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_946080979;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1678416122 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1678416122;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_415238650 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_415238650;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1281235426 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1281235426;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1074895586 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1074895586;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_16165272 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_16165272;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_886581912 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_886581912;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1633418890 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1633418890;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_2129817718 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_2129817718;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_497744859 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_497744859;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_235830491 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_235830491;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1170005871 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1170005871;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_450602897 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_450602897;
         this._embed_css_images_Icons_Conditions_Bleeding_png_390096308 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_390096308;
         this._embed_css_images_Icons_Conditions_Burning_png_1623566113 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1623566113;
         this._embed_css_images_Icons_Conditions_Cursed_png_289721166 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_289721166;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1812672504 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1812672504;
         this._embed_css_images_Icons_Conditions_Drowning_png_135782122 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_135782122;
         this._embed_css_images_Icons_Conditions_Drunk_png_292416878 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_292416878;
         this._embed_css_images_Icons_Conditions_Electrified_png_1504635230 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1504635230;
         this._embed_css_images_Icons_Conditions_Freezing_png_1580563200 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1580563200;
         this._embed_css_images_Icons_Conditions_Haste_png_713587817 = Tibia__embed_css_images_Icons_Conditions_Haste_png_713587817;
         this._embed_css_images_Icons_Conditions_Hungry_png_828805395 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_828805395;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_1155688785 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_1155688785;
         this._embed_css_images_Icons_Conditions_MagicShield_png_278937824 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_278937824;
         this._embed_css_images_Icons_Conditions_PZ_png_1990411926 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1990411926;
         this._embed_css_images_Icons_Conditions_PZlock_png_1682915131 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1682915131;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1684838793 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1684838793;
         this._embed_css_images_Icons_Conditions_Slowed_png_131623556 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_131623556;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1160772545 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1160772545;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_667864756 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_667864756;
         this._embed_css_images_Icons_PremmyPurse_active_png_1671311057 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1671311057;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_657599811 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_657599811;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1259804131 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1259804131;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_1932067081 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_1932067081;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1809456517 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1809456517;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_375144786 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_375144786;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_108506189 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_108506189;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_1216489215 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_1216489215;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_1627219103 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_1627219103;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1620805250 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1620805250;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_86384979 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_86384979;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_2125783755 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_2125783755;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_911288153 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_911288153;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_878332984 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_878332984;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_598278734 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_598278734;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1197742135 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1197742135;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1528661303 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1528661303;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1409321227 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1409321227;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_809530334 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_809530334;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_620098782 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_620098782;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1966161674 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1966161674;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1646013740 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1646013740;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_83356974 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_83356974;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_454486650 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_454486650;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_2007873148 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_2007873148;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1993434623 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1993434623;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1026515466 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1026515466;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_314856227 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_314856227;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_485117951 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_485117951;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_839114951 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_839114951;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_716268777 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_716268777;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_1538737364 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_1538737364;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_468219125 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_468219125;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_300738046 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_300738046;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_598506393 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_598506393;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_336957514 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_336957514;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1407250695 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1407250695;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1340418748 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1340418748;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759697413 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1759697413;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_787421096 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_787421096;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1193962089 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1193962089;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1753954938 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1753954938;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_166056235 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_166056235;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_340332232 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_340332232;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1656132313 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1656132313;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_2131167606 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_2131167606;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1412346243 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1412346243;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_236786906 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_236786906;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_891158331 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_891158331;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2100407432 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2100407432;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_522741672 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_522741672;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_268696923 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_268696923;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_2039041338 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_2039041338;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_762926419 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_762926419;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1583677838 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1583677838;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_719575887 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_719575887;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_896247472 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_896247472;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1453264669 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1453264669;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_584383358 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_584383358;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_27356575 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_27356575;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_882214800 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_882214800;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_574894445 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_574894445;
         this._embed_css_images_Inventory_png_316871002 = Tibia__embed_css_images_Inventory_png_316871002;
         this._embed_css_images_Minimap_Center_active_png_1863726688 = Tibia__embed_css_images_Minimap_Center_active_png_1863726688;
         this._embed_css_images_Minimap_Center_idle_png_2073478622 = Tibia__embed_css_images_Minimap_Center_idle_png_2073478622;
         this._embed_css_images_Minimap_Center_over_png_466532130 = Tibia__embed_css_images_Minimap_Center_over_png_466532130;
         this._embed_css_images_Minimap_ZoomIn_idle_png_277550655 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_277550655;
         this._embed_css_images_Minimap_ZoomIn_over_png_1540463935 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1540463935;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1147857557 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1147857557;
         this._embed_css_images_Minimap_ZoomOut_idle_png_2068698686 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_2068698686;
         this._embed_css_images_Minimap_ZoomOut_over_png_426482370 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_426482370;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_551236802 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_551236802;
         this._embed_css_images_Minimap_png_814069837 = Tibia__embed_css_images_Minimap_png_814069837;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_498144444 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_498144444;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1996778564 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1996778564;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1713303168 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1713303168;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_215505751 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_215505751;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_668800425 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_668800425;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_640064867 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_640064867;
         this._embed_css_images_Scrollbar_Handler_png_217718721 = Tibia__embed_css_images_Scrollbar_Handler_png_217718721;
         this._embed_css_images_Scrollbar_tileable_png_1683633647 = Tibia__embed_css_images_Scrollbar_tileable_png_1683633647;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_677852663 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_677852663;
         this._embed_css_images_Slot_InventoryAmmo_png_1549712567 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1549712567;
         this._embed_css_images_Slot_InventoryArmor_png_1973652958 = Tibia__embed_css_images_Slot_InventoryArmor_png_1973652958;
         this._embed_css_images_Slot_InventoryBackpack_png_1615829797 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1615829797;
         this._embed_css_images_Slot_InventoryBoots_png_1925708880 = Tibia__embed_css_images_Slot_InventoryBoots_png_1925708880;
         this._embed_css_images_Slot_InventoryHead_png_1094882491 = Tibia__embed_css_images_Slot_InventoryHead_png_1094882491;
         this._embed_css_images_Slot_InventoryLegs_png_1776971380 = Tibia__embed_css_images_Slot_InventoryLegs_png_1776971380;
         this._embed_css_images_Slot_InventoryNecklace_png_1880218047 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1880218047;
         this._embed_css_images_Slot_InventoryRing_png_670523093 = Tibia__embed_css_images_Slot_InventoryRing_png_670523093;
         this._embed_css_images_Slot_InventoryShield_png_262817616 = Tibia__embed_css_images_Slot_InventoryShield_png_262817616;
         this._embed_css_images_Slot_InventoryWeapon_png_1657345623 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1657345623;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1601318650 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1601318650;
         this._embed_css_images_Slot_Statusicon_png_1336149226 = Tibia__embed_css_images_Slot_Statusicon_png_1336149226;
         this._embed_css_images_Widget_Footer_tileable_end01_png_913406746 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_913406746;
         this._embed_css_images_Widget_Footer_tileable_end02_png_914297759 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_914297759;
         this._embed_css_images_Widget_Footer_tileable_png_1764860287 = Tibia__embed_css_images_Widget_Footer_tileable_png_1764860287;
         this._embed_css_images_Widget_HeaderBG_png_457469291 = Tibia__embed_css_images_Widget_HeaderBG_png_457469291;
         this._embed_css_images_slot_Hotkey_disabled_png_739205092 = Tibia__embed_css_images_slot_Hotkey_disabled_png_739205092;
         this._embed_css_images_slot_Hotkey_highlighted_png_1536030283 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_1536030283;
         this._embed_css_images_slot_Hotkey_png_404927663 = Tibia__embed_css_images_slot_Hotkey_png_404927663;
         this._embed_css_images_slot_container_disabled_png_1409112361 = Tibia__embed_css_images_slot_container_disabled_png_1409112361;
         this._embed_css_images_slot_container_highlighted_png_1224962720 = Tibia__embed_css_images_slot_container_highlighted_png_1224962720;
         this._embed_css_images_slot_container_png_2063755284 = Tibia__embed_css_images_slot_container_png_2063755284;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         mx_internal::_Tibia_StylesInit();
         this.layout = "absolute";
         this.addEventListener("activate",this.___Tibia_Application1_activate);
         this.addEventListener("applicationComplete",this.___Tibia_Application1_applicationComplete);
         this.addEventListener("deactivate",this.___Tibia_Application1_deactivate);
         this.addEventListener("preinitialize",this.___Tibia_Application1_preinitialize);
      }
      
      public static function s_GetFrameFlash() : Boolean
      {
         return (int(Tibia.s_FrameTibiaTimestamp / 300) & 1) != 0;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Tibia._watcherSetupUtil = param1;
      }
      
      public static function get s_TutorialMode() : Boolean
      {
         return (application as Tibia).m_TutorialMode;
      }
      
      public static function s_GetInstance() : Tibia
      {
         return application as Tibia;
      }
      
      public static function get s_TutorialData() : Object
      {
         return (application as Tibia).m_TutorialData;
      }
      
      public static function s_GetCommunication() : Communication
      {
         return (application as Tibia).m_Communication;
      }
      
      public static function s_GetInputHandler() : InputHandler
      {
         return (application as Tibia).m_UIInputHandler;
      }
      
      public static function s_GetAppearanceStorage() : AppearanceStorage
      {
         return (application as Tibia).m_AppearanceStorage;
      }
      
      public static function s_GetAssetProvider() : IAssetProvider
      {
         return (application as Tibia).m_AssetProvider;
      }
      
      public static function s_GetChatStorage() : ChatStorage
      {
         return (application as Tibia).m_ChatStorage;
      }
      
      public static function s_GetSecondaryTimer() : Timer
      {
         return (application as Tibia).m_SeconaryTimer;
      }
      
      public static function s_GetMiniMapStorage() : MiniMapStorage
      {
         return (application as Tibia).m_MiniMapStorage;
      }
      
      public static function get s_TibiaTimerFactor() : Number
      {
         return s_InternalTibiaTimerFactor;
      }
      
      public static function s_SetOptions(param1:OptionsStorage) : void
      {
         var _loc2_:Tibia = application as Tibia;
         if(_loc2_ != null)
         {
            _loc2_.options = param1;
         }
      }
      
      public static function s_GetContainerStorage() : ContainerStorage
      {
         return (application as Tibia).m_ContainerStorage;
      }
      
      public static function s_GetChatWidget() : ChatWidget
      {
         return (application as Tibia).m_UIChatWidget;
      }
      
      public static function get s_GameActionFactory() : GameActionFactory
      {
         return (application as Tibia).m_GameActionFactory;
      }
      
      public static function s_GetOptions() : OptionsStorage
      {
         return (application as Tibia).m_Options;
      }
      
      public static function s_GetSpellStorage() : SpellStorage
      {
         return (application as Tibia).m_SpellStorage;
      }
      
      public static function s_GetStatusWidget() : StatusWidget
      {
         return (application as Tibia).m_UIStatusWidget;
      }
      
      public static function s_GetWorldMapStorage() : WorldMapStorage
      {
         return (application as Tibia).m_WorldMapStorage;
      }
      
      public static function s_GetConnection() : IServerConnection
      {
         return (application as Tibia).m_Connection;
      }
      
      public static function s_GetUIEffectsManager() : UIEffectsManager
      {
         return (application as Tibia).m_UIEffectsManager;
      }
      
      public static function s_GetTibiaTimer() : int
      {
         if(s_LastTibiaFactorChangeRealTimestamp == 0)
         {
            s_LastTibiaFactorChangeRealTimestamp = getTimer();
            s_LastTibiaFactorChangeTibiaTimestamp = s_LastTibiaTimestamp;
         }
         var _loc1_:uint = getTimer() - s_LastTibiaFactorChangeRealTimestamp;
         s_LastTibiaTimestamp = s_LastTibiaFactorChangeTibiaTimestamp + _loc1_ * s_InternalTibiaTimerFactor;
         return s_LastTibiaTimestamp;
      }
      
      public static function s_GetPlayer() : Player
      {
         return (application as Tibia).m_Player;
      }
      
      public static function s_GetCreatureStorage() : CreatureStorage
      {
         return (application as Tibia).m_CreatureStorage;
      }
      
      public static function set s_GameActionFactory(param1:GameActionFactory) : void
      {
         (application as Tibia).m_GameActionFactory = param1;
      }
      
      public static function set s_TibiaTimerFactor(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            s_LastTibiaFactorChangeTibiaTimestamp = s_GetTibiaTimer();
            s_LastTibiaFactorChangeRealTimestamp = getTimer();
            s_InternalTibiaTimerFactor = param1;
         }
      }
      
      public static function s_GetSessionKey() : String
      {
         return (application as Tibia).m_SessionKey;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIChatWidget() : ChatWidget
      {
         return this._883427326m_UIChatWidget;
      }
      
      public function set m_UIChatWidget(param1:ChatWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._883427326m_UIChatWidget;
         if(_loc2_ !== param1)
         {
            this._883427326m_UIChatWidget = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIChatWidget",_loc2_,param1));
         }
      }
      
      private function _Tibia_VActionBarWidget1_i() : VActionBarWidget
      {
         var _loc1_:VActionBarWidget = new VActionBarWidget();
         this.m_UIActionBarLeft = _loc1_;
         _loc1_.styleName = "actionBarLeft";
         _loc1_.id = "m_UIActionBarLeft";
         BindingManager.executeBindings(this,"m_UIActionBarLeft",this.m_UIActionBarLeft);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function onCloseLogoutCharacter(param1:CloseEvent) : void
      {
         if(param1.detail == PopUpBase.BUTTON_YES)
         {
            this.m_ConnectionDataPending = -1;
            if(this.m_Communication != null)
            {
               this.m_Communication.disconnect(false);
            }
         }
      }
      
      protected function onActivation(param1:Event) : void
      {
         if(param1.type == Event.ACTIVATE)
         {
            this.isActive = true;
         }
         else
         {
            this.isActive = false;
            if(this.m_UIInputHandler != null)
            {
               this.m_UIInputHandler.clearPressedKeys();
            }
         }
      }
      
      public function setConnectionDataList(param1:Vector.<IConnectionData>, param2:uint) : void
      {
         if(param1 == null || param1.length < 1)
         {
            throw new ArgumentError("Tibia.setConnectionDataList: Invalid connection data list.");
         }
         if(param2 < 0 || param2 >= param1.length)
         {
            throw new ArgumentError("Tibia.setConnectionDataList: Invalid pending connection data.");
         }
         var _loc3_:Vector.<IConnectionData> = this.m_ConnectionDataList;
         this.m_ConnectionDataList = param1;
         this.m_ConnectionDataCurrent = -1;
         this.m_ConnectionDataPending = param2;
         var _loc4_:IServerConnection = s_GetConnection();
         if(_loc4_ != null && Boolean(_loc4_.isConnected))
         {
            _loc4_.disconnect();
         }
         else if(IServerConnection is Sessiondump && Boolean(this.m_GameClientReady))
         {
            this.loginCharacter();
         }
      }
      
      public function setClientSize(param1:uint, param2:uint) : void
      {
         var _loc3_:Object = Application.application.systemManager;
         if(_loc3_.hasOwnProperty("setActualSize"))
         {
            _loc3_["setActualSize"](param1,param2);
         }
      }
      
      private function isValidPreviewStateForClient(param1:uint) : Boolean
      {
         switch(param1)
         {
            case PREVIEW_STATE_REGULAR:
               return CLIENT_PREVIEW_STATE == PREVIEW_STATE_REGULAR || CLIENT_PREVIEW_STATE == PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE;
            case PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:
               return CLIENT_PREVIEW_STATE == PREVIEW_STATE_REGULAR || CLIENT_PREVIEW_STATE == PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE;
            case PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:
               return CLIENT_PREVIEW_STATE == PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE;
            default:
               return false;
         }
      }
      
      private function onConnectionConnecting(param1:ConnectionEvent) : void
      {
         visible = false;
         this.m_Player.name = param1.data as String;
         this.m_ChannelsPending = this.m_ChatStorage.loadChannels();
         var _loc2_:MessageWidget = new MessageWidget();
         _loc2_.buttonFlags = PopUpBase.BUTTON_CANCEL;
         _loc2_.keyboardFlags = PopUpBase.KEY_ESCAPE;
         _loc2_.message = resourceManager.getString(BUNDLE,"DLG_CONNECTING_TEXT",[param1.message]);
         _loc2_.title = resourceManager.getString(BUNDLE,"DLG_CONNECTING_TITLE");
         _loc2_.addEventListener(CloseEvent.CLOSE,this.onCloseLoginCharacter);
         _loc2_.show();
      }
      
      public function saveLocalData() : void
      {
         if(!(this.m_Connection is Sessiondump))
         {
            this.m_MiniMapStorage.saveSectors(true);
         }
      }
      
      private function onConnectionPending(param1:ConnectionEvent) : void
      {
         var _loc2_:int = 0;
         if(this.m_ChannelsPending != null)
         {
            for each(_loc2_ in this.m_ChannelsPending)
            {
               if(_loc2_ == ChatStorage.PRIVATE_CHANNEL_ID)
               {
                  this.m_Communication.sendCOPENCHANNEL();
               }
               else
               {
                  this.m_Communication.sendCJOINCHANNEL(_loc2_);
               }
            }
            this.m_ChannelsPending = null;
         }
         if(!this.m_CharacterDeath)
         {
            if(this.m_UIWorldMapWidget != null)
            {
               this.m_UIWorldMapWidget.player = this.m_Player;
            }
            if(this.m_UIStatusWidget != null)
            {
               this.m_UIStatusWidget.player = this.m_Player;
            }
            this.m_Communication.sendCENTERWORLD();
         }
      }
      
      public function logoutCharacter() : void
      {
         if(this.m_Connection == null || !this.m_Connection.isConnected)
         {
            throw new Error("Tibia.logoutCharacter: Not connected.");
         }
         var _loc1_:MessageWidget = new MessageWidget();
         _loc1_.buttonFlags = PopUpBase.BUTTON_YES | PopUpBase.BUTTON_NO;
         _loc1_.message = resourceManager.getString(BUNDLE,"DLG_LOGOUT_TEXT");
         _loc1_.title = resourceManager.getString(BUNDLE,"DLG_LOGOUT_TITLE");
         _loc1_.addEventListener(CloseEvent.CLOSE,this.onCloseLogoutCharacter);
         _loc1_.show();
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarTop() : HActionBarWidget
      {
         return this._1423351586m_UIActionBarTop;
      }
      
      protected function connect(param1:IConnectionData) : void
      {
         var _loc3_:SessiondumpControllerBase = null;
         if(param1 is AccountCharacter)
         {
            if(!(this.m_Connection is Connection))
            {
               this.reset(true);
               this.releaseConnection();
            }
            this.m_Connection = new Connection();
         }
         else if(param1 is SessiondumpConnectionData)
         {
            if(!(this.m_Connection is Sessiondump))
            {
               this.reset(true);
               this.releaseConnection();
            }
            _loc3_ = null;
            if(this.m_TutorialMode)
            {
               _loc3_ = new SessiondumpControllerHints();
            }
            else
            {
               _loc3_ = new SessiondumpControllerBase();
            }
            this.m_Connection = new Sessiondump(_loc3_);
         }
         this.m_Connection.addEventListener(ConnectionEvent.PENDING,this.onConnectionPending);
         this.m_Connection.addEventListener(ConnectionEvent.GAME,this.onConnectionGame);
         this.m_Connection.addEventListener(ConnectionEvent.CONNECTING,this.onConnectionConnecting);
         this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_LOST,this.onConnectionLost);
         this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_RECOVERED,this.onConnectionRecovered);
         this.m_Connection.addEventListener(ConnectionEvent.DEAD,this.onConnectionDeath);
         this.m_Connection.addEventListener(ConnectionEvent.DISCONNECTED,this.onConnectionDisconnected);
         this.m_Connection.addEventListener(ConnectionEvent.ERROR,this.onConnectionError);
         this.m_Connection.addEventListener(ConnectionEvent.LOGINADVICE,this.onConnectionLoginAdvice);
         this.m_Connection.addEventListener(ConnectionEvent.LOGINERROR,this.onConnectionLoginError);
         this.m_Connection.addEventListener(ConnectionEvent.LOGINWAIT,this.onConnectionLoginWait);
         var _loc2_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.CREATED);
         dispatchEvent(_loc2_);
         this.m_Connection.connect(param1);
      }
      
      private function onUploadOptionsComplete(param1:Event) : void
      {
         this.m_CurrentOptionsDirty = false;
         this.m_CurrentOptionsLastUpload = getTimer();
         this.m_CurrentOptionsUploading = false;
         this.m_CurrentOptionsUploadErrorDelay = 0;
      }
      
      private function onCloseLoginWait(param1:CloseEvent) : void
      {
         if(param1.detail == TimeoutWaitWidget.TIMOUT_EXPIRED)
         {
            this.m_ConnectionDataPending = this.m_ConnectionDataCurrent;
         }
         else
         {
            this.m_ConnectionDataPending = -1;
         }
         if(this.m_Communication != null)
         {
            this.m_Communication.disconnect(false);
         }
      }
      
      public function set m_UISideBarToggleRight(param1:ToggleBar) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._665607314m_UISideBarToggleRight;
         if(_loc2_ !== param1)
         {
            this._665607314m_UISideBarToggleRight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UISideBarToggleRight",_loc2_,param1));
         }
      }
      
      public function set m_UIWorldMapWidget(param1:WorldMapWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1314206572m_UIWorldMapWidget;
         if(_loc2_ !== param1)
         {
            this._1314206572m_UIWorldMapWidget = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIWorldMapWidget",_loc2_,param1));
         }
      }
      
      private function _Tibia_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = BoxDirection.VERTICAL;
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            m_UIOuterRootContainer.direction = param1;
         },"m_UIOuterRootContainer.direction");
         result[0] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_A;
         },function(param1:int):void
         {
            m_UISideBarA.location = param1;
         },"m_UISideBarA.location");
         result[1] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_B;
         },function(param1:int):void
         {
            m_UISideBarB.location = param1;
         },"m_UISideBarB.location");
         result[2] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_B;
         },function(param1:*):void
         {
            _Tibia_Array1[0] = param1;
         },"_Tibia_Array1[0]");
         result[3] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_A;
         },function(param1:*):void
         {
            _Tibia_Array1[1] = param1;
         },"_Tibia_Array1[1]");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = BoxDirection.VERTICAL;
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            m_UICenterColumn.direction = param1;
         },"m_UICenterColumn.direction");
         result[5] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_TOP;
         },function(param1:int):void
         {
            m_UIActionBarTop.location = param1;
         },"m_UIActionBarTop.location");
         result[6] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_BOTTOM;
         },function(param1:int):void
         {
            m_UIActionBarBottom.location = param1;
         },"m_UIActionBarBottom.location");
         result[7] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_LEFT;
         },function(param1:int):void
         {
            m_UIActionBarLeft.location = param1;
         },"m_UIActionBarLeft.location");
         result[8] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_RIGHT;
         },function(param1:int):void
         {
            m_UIActionBarRight.location = param1;
         },"m_UIActionBarRight.location");
         result[9] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_C;
         },function(param1:*):void
         {
            _Tibia_Array2[0] = param1;
         },"_Tibia_Array2[0]");
         result[10] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_D;
         },function(param1:*):void
         {
            _Tibia_Array2[1] = param1;
         },"_Tibia_Array2[1]");
         result[11] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_C;
         },function(param1:int):void
         {
            m_UISideBarC.location = param1;
         },"m_UISideBarC.location");
         result[12] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_D;
         },function(param1:int):void
         {
            m_UISideBarD.location = param1;
         },"m_UISideBarD.location");
         result[13] = binding;
         return result;
      }
      
      protected function onAppearancesLoadError(param1:ErrorEvent) : void
      {
         var _loc2_:GameEvent = null;
         if(param1 != null)
         {
            if(this.m_AppearanceStorage != null)
            {
               this.m_AppearanceStorage.removeEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
               this.m_AppearanceStorage.removeEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
            }
            _loc2_ = new GameEvent(GameEvent.ERROR,true,false);
            _loc2_.message = param1.text;
            dispatchEvent(_loc2_);
         }
      }
      
      private function onCloseLoginCharacter(param1:CloseEvent) : void
      {
         if(param1.detail == PopUpBase.BUTTON_CANCEL)
         {
            this.m_ConnectionDataPending = -1;
            if(this.m_Communication != null)
            {
               this.m_Communication.disconnect(false);
            }
         }
      }
      
      protected function onAppearancesLoadComplete(param1:Event) : void
      {
         var _loc2_:GameEvent = null;
         if(param1 != null)
         {
            if(this.m_AppearanceStorage != null)
            {
               this.m_AppearanceStorage.removeEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
               this.m_AppearanceStorage.removeEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
            }
            this.loadOptions();
            this.loginCharacter();
            this.m_GameClientReady = true;
            _loc2_ = new GameEvent(GameEvent.READY,true,false);
            dispatchEvent(_loc2_);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarLeft() : VActionBarWidget
      {
         return this._1174474338m_UIActionBarLeft;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(this.m_IsActive != param1)
         {
            this.m_IsActive = param1;
            if(this.m_IsActive == true)
            {
               FocusNotifier.getInstance().hide();
            }
            else
            {
               FocusNotifier.getInstance().show();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UITibiaRootContainer() : HBox
      {
         return this._1020379552m_UITibiaRootContainer;
      }
      
      public function set m_UIActionBarTop(param1:HActionBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1423351586m_UIActionBarTop;
         if(_loc2_ !== param1)
         {
            this._1423351586m_UIActionBarTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIActionBarTop",_loc2_,param1));
         }
      }
      
      public function loginCharacter() : void
      {
         var _loc2_:AccountCharacter = null;
         var _loc3_:* = false;
         if(this.m_ConnectionDataList == null || this.m_ConnectionDataList.length < 1)
         {
            throw new ArgumentError("Tibia.loginCharacter: Invalid connection data list.");
         }
         if(this.m_ConnectionDataPending < 0 || this.m_ConnectionDataPending >= this.m_ConnectionDataList.length)
         {
            throw new ArgumentError("Tibia.loginCharacter: Invalid pending connection data.");
         }
         this.reset();
         this.m_ConnectionDataCurrent = this.m_ConnectionDataPending;
         this.m_ConnectionDataPending = -1;
         this.m_CharacterDeath = false;
         var _loc1_:IConnectionData = null;
         _loc1_ = this.m_ConnectionDataList[this.m_ConnectionDataCurrent];
         if(_loc1_ is AccountCharacter)
         {
            _loc2_ = _loc1_ as AccountCharacter;
            if(_loc2_ == null)
            {
               throw new Error("Tibia.loginCharacter: connection data must be account character.");
            }
            _loc3_ = !this.isValidPreviewStateForClient(_loc2_.worldPreviewState);
            if(_loc3_)
            {
               this.reloadClient(_loc2_);
               _loc1_ = null;
            }
            else
            {
               _loc1_ = _loc2_;
            }
         }
         if(_loc1_ != null)
         {
            this.connect(_loc1_);
         }
      }
      
      mx_internal function _Tibia_StylesInit() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ExecutionException (java.lang.StackOverflowError)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function onGameWindowResize(param1:ResizeEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null && !this.m_ForceDisableGameWindowSizeCalc)
         {
            _loc2_ = this.m_UIGameWindow.height;
            _loc3_ = this.m_UIChatWidget.height;
            if(this.options.generalUIGameWindowHeight > 0.01 && this.options.generalUIGameWindowHeight < 99.99)
            {
               this.options.generalUIGameWindowHeight = _loc2_ * 100 / (_loc2_ + _loc3_);
            }
         }
         this.m_ForceDisableGameWindowSizeCalc = false;
      }
      
      private function _Tibia_Array1_i() : Array
      {
         var _loc1_:Array = [undefined,undefined];
         this._Tibia_Array1 = _loc1_;
         BindingManager.executeBindings(this,"_Tibia_Array1",this._Tibia_Array1);
         return _loc1_;
      }
      
      public function setSessionKey(param1:String) : void
      {
         this.m_SessionKey = param1;
      }
      
      protected function onPreinitialise(param1:FlexEvent) : void
      {
         this.m_AppearanceStorage = ApperanceStorageFactory.s_CreateAppearanceStorage();
         this.m_AppearanceStorage.addEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
         this.m_AppearanceStorage.addEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
         this.addEventListener(ConnectionEvent.CREATED,this.onConnectionCreated);
         this.m_ChatStorage = new ChatStorage();
         this.m_ChannelsPending = new Vector.<int>();
         this.m_ContainerStorage = new ContainerStorage();
         this.m_MiniMapStorage = new MiniMapStorage();
         this.m_SpellStorage = new SpellStorage();
         this.m_WorldMapStorage = new WorldMapStorage();
         this.m_UIEffectsManager = new UIEffectsManager();
         this.m_SeconaryTimer = new Timer(50);
         this.m_SeconaryTimer.addEventListener(TimerEvent.TIMER,this.onSecondaryTimer);
         this.m_SeconaryTimer.start();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarBottom() : HActionBarWidget
      {
         return this._629924354m_UIActionBarBottom;
      }
      
      public function __m_UICenterColumn_dividerRelease(param1:DividerEvent) : void
      {
         this.onDividerRelease(param1);
      }
      
      public function initializeGameClient(param1:Boolean, param2:Object = null) : void
      {
         this.m_TutorialMode = param1;
         this.m_TutorialData = param2;
         if(this.m_TutorialMode)
         {
            this.m_GameActionFactory = new SessiondumpHintsGameActionFactory();
         }
         else
         {
            this.m_GameActionFactory = new GameActionFactory();
         }
         s_InternalTibiaTimerFactor = 1;
      }
      
      public function __m_UIGameWindow_resize(param1:ResizeEvent) : void
      {
         this.onGameWindowResize(param1);
      }
      
      protected function onApplicationComplete(param1:FlexEvent) : void
      {
         ToolTipManager.showDelay = 750;
         ToolTipManager.scrubDelay = 0;
         stage.align = StageAlign.TOP_LEFT;
         stage.frameRate = 100;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.showDefaultContextMenu = false;
         if(this.m_UICenterColumn != null && this.m_UICenterColumn.numDividers > 0 && this.m_UICenterColumn.getDividerAt(0) != null)
         {
            this.m_UICenterColumn.getDividerAt(0).doubleClickEnabled = true;
            this.m_UICenterColumn.getDividerAt(0).addEventListener(MouseEvent.DOUBLE_CLICK,this.onGameWindowAutofit);
         }
         if(this.isActive == false)
         {
            FocusNotifier.getInstance().captureMouse = true;
            FocusNotifier.getInstance().show();
         }
      }
      
      public function ___Tibia_Application1_deactivate(param1:Event) : void
      {
         this.onActivation(param1);
      }
      
      private function updateCombatTactics() : void
      {
         if(this.m_Communication != null && Boolean(this.m_Communication.isGameRunning) && this.m_Options != null)
         {
            this.m_Communication.sendCSETTACTICS(this.m_Options.combatAttackMode,this.m_Options.combatChaseMode,this.m_Options.combatSecureMode,this.m_Options.combatPVPMode);
         }
      }
      
      public function ___Tibia_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete(param1);
      }
      
      protected function reloadClient(param1:AccountCharacter = null, param2:String = null) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:URLVariables = null;
         var _loc3_:URLRequest = null;
         if(param2 != null && param2.length > 0)
         {
            _loc3_ = new URLRequest(param2);
         }
         else
         {
            _loc3_ = new URLRequest(URLHelper.s_GetBrowserCurrentUrl());
         }
         if(param1 != null)
         {
            _loc4_ = URLHelper.s_GetBrowserCurrentBaseUrl();
            if(param2 != null)
            {
               _loc4_ = param2;
            }
            _loc5_ = URLHelper.s_GetBrowserCurrentQuerystring();
            _loc6_ = new URLVariables(_loc5_);
            _loc3_ = new URLRequest(_loc4_);
            _loc6_.name = param1.name;
            _loc3_.data = _loc6_;
         }
         navigateToURL(_loc3_,"_self");
      }
      
      private function updateGameWindowSize() : void
      {
         var _loc1_:Number = NaN;
         if(this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null)
         {
            _loc1_ = this.options.generalUIGameWindowHeight;
            if(Math.abs(this.m_UIGameWindow.percentHeight - _loc1_) > 0.01)
            {
               this.m_ForceDisableGameWindowSizeCalc = true;
            }
            this.m_UIGameWindow.percentHeight = _loc1_;
            this.m_UIChatWidget.percentHeight = 100 - _loc1_;
         }
      }
      
      private function loadOptions() : void
      {
         if(this.options == null)
         {
            this.options = new OptionsStorage(this.m_DefaultOptionsAsset == null?null:this.m_DefaultOptionsAsset.xml,this.m_CurrentOptionsAsset == null?null:this.m_CurrentOptionsAsset.xml);
         }
      }
      
      private function onConnectionLoginWait(param1:ConnectionEvent) : void
      {
         visible = false;
         this.saveLocalData();
         this.saveOptions();
         var _loc2_:LoginWaitWidget = new LoginWaitWidget();
         _loc2_.message = param1.message;
         _loc2_.timeout = Number(param1.data);
         _loc2_.addEventListener(CloseEvent.CLOSE,this.onCloseLoginWait);
         _loc2_.show();
      }
      
      private function onConnectionLost(param1:ConnectionEvent) : void
      {
         this.saveLocalData();
         this.saveOptions();
         this.m_ConnectionLostDialog = new ConnectionLostWidget();
         this.m_ConnectionLostDialog.timeout = Number(60 * 1000);
         this.m_ConnectionLostDialog.addEventListener(CloseEvent.CLOSE,this.onCloseConnectionLostDialog);
         this.m_ConnectionLostDialog.show();
      }
      
      protected function onGameWindowAutofit(param1:MouseEvent) : void
      {
         this.autofitGameWindow();
      }
      
      private function setCurrentOptionsFromAssets(param1:IAssetProvider) : void
      {
         if(this.m_CurrentOptionsAsset != null)
         {
            this.m_CurrentOptionsAsset.removeEventListener(Event.COMPLETE,this.onUploadOptionsComplete);
            this.m_CurrentOptionsAsset.removeEventListener(ErrorEvent.ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(IOErrorEvent.IO_ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadOptionsError);
         }
         this.m_CurrentOptionsAsset = this.m_AssetProvider.getCurrentOptions();
         this.m_CurrentOptionsDirty = false;
         this.m_CurrentOptionsLastUpload = 0;
         this.m_CurrentOptionsUploading = false;
         if(this.m_CurrentOptionsAsset != null)
         {
            this.m_CurrentOptionsAsset.addEventListener(Event.COMPLETE,this.onUploadOptionsComplete);
            this.m_CurrentOptionsAsset.addEventListener(ErrorEvent.ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.addEventListener(IOErrorEvent.IO_ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadOptionsError);
            param1.removeAsset(this.m_CurrentOptionsAsset);
         }
      }
      
      public function set m_UIActionBarLeft(param1:VActionBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1174474338m_UIActionBarLeft;
         if(_loc2_ !== param1)
         {
            this._1174474338m_UIActionBarLeft = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIActionBarLeft",_loc2_,param1));
         }
      }
      
      public function set m_UITibiaRootContainer(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1020379552m_UITibiaRootContainer;
         if(_loc2_ !== param1)
         {
            this._1020379552m_UITibiaRootContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UITibiaRootContainer",_loc2_,param1));
         }
      }
      
      private function _Tibia_HActionBarWidget2_i() : HActionBarWidget
      {
         var _loc1_:HActionBarWidget = new HActionBarWidget();
         this.m_UIActionBarBottom = _loc1_;
         _loc1_.styleName = "actionBarBottom";
         _loc1_.id = "m_UIActionBarBottom";
         BindingManager.executeBindings(this,"m_UIActionBarBottom",this.m_UIActionBarBottom);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIOuterRootContainer() : DividedBox
      {
         return this._1568861366m_UIOuterRootContainer;
      }
      
      private function onConnectionLoginAdvice(param1:ConnectionEvent) : void
      {
         visible = false;
         var _loc2_:MessageWidget = new MessageWidget();
         _loc2_.buttonFlags = PopUpBase.BUTTON_OKAY;
         _loc2_.keyboardFlags = PopUpBase.KEY_ENTER;
         _loc2_.message = resourceManager.getString(BUNDLE,"DLG_LOGINADVICE_TEXT",[param1.message]);
         _loc2_.priority = PopUpBase.DEFAULT_PRIORITY + 1;
         _loc2_.title = resourceManager.getString(BUNDLE,"DLG_LOGINADVICE_TITLE");
         _loc2_.show();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarRight() : VActionBarWidget
      {
         return this._2043305115m_UIActionBarRight;
      }
      
      private function onConnectionRecovered(param1:ConnectionEvent) : void
      {
         this.m_ConnectionLostDialog.hide();
      }
      
      override public function initialize() : void
      {
         var target:Tibia = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._Tibia_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_TibiaWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      protected function transferToLiveServer(param1:String) : void
      {
         var _loc4_:AccountCharacter = null;
         if(!this.m_TutorialMode)
         {
            throw new IllegalOperationError("Tibia.transferToLiveServer: Must be in tutorial mode");
         }
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_ConnectionDataList.length - 1)
         {
            _loc4_ = this.m_ConnectionDataList[_loc3_] as AccountCharacter;
            if(_loc4_ != null && _loc4_.name == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ > -1)
         {
            this.initializeGameClient(false);
            this.setConnectionDataList(this.m_ConnectionDataList,_loc2_);
            this.loginCharacter();
            this.setCurrentOptionsFromAssets(this.m_AssetProvider);
            this.m_DefaultOptionsAsset = this.m_AssetProvider.getDefaultOptions();
            if(this.m_DefaultOptionsAsset != null)
            {
               this.m_AssetProvider.removeAsset(this.m_DefaultOptionsAsset);
            }
            this.options = null;
            this.loadOptions();
            return;
         }
         throw new ArgumentError("No ConnectionData found for character " + param1);
      }
      
      private function _Tibia_VActionBarWidget2_i() : VActionBarWidget
      {
         var _loc1_:VActionBarWidget = new VActionBarWidget();
         this.m_UIActionBarRight = _loc1_;
         _loc1_.styleName = "actionBarRight";
         _loc1_.id = "m_UIActionBarRight";
         BindingManager.executeBindings(this,"m_UIActionBarRight",this.m_UIActionBarRight);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _Tibia_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = BoxDirection.VERTICAL;
         _loc1_ = SideBarSet.LOCATION_A;
         _loc1_ = SideBarSet.LOCATION_B;
         _loc1_ = SideBarSet.LOCATION_B;
         _loc1_ = SideBarSet.LOCATION_A;
         _loc1_ = BoxDirection.VERTICAL;
         _loc1_ = ActionBarSet.LOCATION_TOP;
         _loc1_ = ActionBarSet.LOCATION_BOTTOM;
         _loc1_ = ActionBarSet.LOCATION_LEFT;
         _loc1_ = ActionBarSet.LOCATION_RIGHT;
         _loc1_ = SideBarSet.LOCATION_C;
         _loc1_ = SideBarSet.LOCATION_D;
         _loc1_ = SideBarSet.LOCATION_C;
         _loc1_ = SideBarSet.LOCATION_D;
      }
      
      private function onCloseConnectionLostDialog(param1:CloseEvent) : void
      {
         if(param1.detail == PopUpBase.BUTTON_ABORT || param1.detail == TimeoutWaitWidget.TIMOUT_EXPIRED)
         {
            this.m_ConnectionDataPending = -1;
            this.m_Communication.disconnect(true);
         }
      }
      
      public function set m_UIActionBarBottom(param1:HActionBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._629924354m_UIActionBarBottom;
         if(_loc2_ !== param1)
         {
            this._629924354m_UIActionBarBottom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIActionBarBottom",_loc2_,param1));
         }
      }
      
      public function ___Tibia_Application1_activate(param1:Event) : void
      {
         this.onActivation(param1);
      }
      
      public function autofitGameWindow() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:GridContainer = null;
         var _loc6_:IUIComponent = null;
         var _loc7_:Number = NaN;
         if(this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null && Boolean(this.m_UIWorldMapWidget))
         {
            _loc1_ = this.m_UIGameWindow.height + this.m_UIChatWidget.height;
            _loc2_ = this.m_UIGameWindow.width;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = null;
            _loc6_ = null;
            if((_loc5_ = this.m_UIGameWindow) != null)
            {
               if((_loc6_ = _loc5_.top) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc3_ = _loc3_ + _loc6_.getExplicitOrMeasuredHeight();
               }
               if((_loc6_ = _loc5_.bottom) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc3_ = _loc3_ + _loc6_.getExplicitOrMeasuredHeight();
               }
               if((_loc6_ = _loc5_.left) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc4_ = _loc4_ + _loc6_.getExplicitOrMeasuredWidth();
               }
               if((_loc6_ = _loc5_.right) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc4_ = _loc4_ + _loc6_.getExplicitOrMeasuredWidth();
               }
            }
            if((_loc5_ = this.m_UIGameWindow.center as GridContainer) != null)
            {
               if((_loc6_ = _loc5_.top) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc3_ = _loc3_ + _loc6_.getExplicitOrMeasuredHeight();
               }
               if((_loc6_ = _loc5_.bottom) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc3_ = _loc3_ + _loc6_.getExplicitOrMeasuredHeight();
               }
               if((_loc6_ = _loc5_.left) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc4_ = _loc4_ + _loc6_.getExplicitOrMeasuredWidth();
               }
               if((_loc6_ = _loc5_.right) != null && Boolean(_loc6_.includeInLayout))
               {
                  _loc4_ = _loc4_ + _loc6_.getExplicitOrMeasuredWidth();
               }
            }
            _loc7_ = this.m_UIWorldMapWidget.calculateOptimalSize(_loc2_ - _loc4_,_loc1_ - _loc3_).height + _loc3_;
            this.options.generalUIGameWindowHeight = _loc7_ * 100 / _loc1_;
         }
      }
      
      public function set m_UIBottomContainer(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._967396880m_UIBottomContainer;
         if(_loc2_ !== param1)
         {
            this._967396880m_UIBottomContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIBottomContainer",_loc2_,param1));
         }
      }
      
      private function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "generalUIGameWindowHeight" || param1.property == "*")
         {
            this.updateCombatTactics();
            this.updateGameWindowSize();
         }
         this.m_CurrentOptionsDirty = true;
      }
      
      public function set m_UIWorldMapWindow(param1:GameWindowContainer) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1313911232m_UIWorldMapWindow;
         if(_loc2_ !== param1)
         {
            this._1313911232m_UIWorldMapWindow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIWorldMapWindow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWidget() : WorldMapWidget
      {
         return this._1314206572m_UIWorldMapWidget;
      }
      
      public function set m_UISideBarA(param1:SideBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._64278965m_UISideBarA;
         if(_loc2_ !== param1)
         {
            this._64278965m_UISideBarA = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UISideBarA",_loc2_,param1));
         }
      }
      
      public function set m_UISideBarD(param1:SideBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._64278962m_UISideBarD;
         if(_loc2_ !== param1)
         {
            this._64278962m_UISideBarD = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UISideBarD",_loc2_,param1));
         }
      }
      
      public function set m_UISideBarC(param1:SideBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._64278963m_UISideBarC;
         if(_loc2_ !== param1)
         {
            this._64278963m_UISideBarC = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UISideBarC",_loc2_,param1));
         }
      }
      
      public function set m_UISideBarB(param1:SideBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._64278964m_UISideBarB;
         if(_loc2_ !== param1)
         {
            this._64278964m_UISideBarB = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UISideBarB",_loc2_,param1));
         }
      }
      
      private function onCloseChangeCharacter(param1:CloseEvent) : void
      {
         var _loc4_:GameEvent = null;
         var _loc2_:AccountCharacter = null;
         var _loc3_:EmbeddedDialog = null;
         if(param1.currentTarget is CharacterSelectionWidget && param1.detail == PopUpBase.BUTTON_OKAY && CharacterSelectionWidget(param1.currentTarget).selectedCharacterIndex != -1)
         {
            this.m_ConnectionDataPending = CharacterSelectionWidget(param1.currentTarget).selectedCharacterIndex;
            if(this.m_ConnectionDataPending >= 0 && this.m_ConnectionDataPending < this.m_ConnectionDataList.length)
            {
               _loc2_ = this.m_ConnectionDataList[this.m_ConnectionDataPending] as AccountCharacter;
            }
         }
         if(param1.detail != PopUpBase.BUTTON_OKAY && param1.currentTarget is CharacterSelectionWidget && (this.m_Connection == null || !this.m_Connection.isConnected))
         {
            _loc4_ = new GameEvent(GameEvent.CLOSE,true,false);
            dispatchEvent(_loc4_);
         }
         else if(param1.detail == PopUpBase.BUTTON_OKAY && param1.currentTarget is CharacterSelectionWidget && _loc2_ != null && !this.isValidPreviewStateForClient(_loc2_.worldPreviewState))
         {
            param1.preventDefault();
            _loc3_ = new EmbeddedDialog();
            _loc3_.name = "ConfirmClientChange";
            _loc3_.buttonFlags = PopUpBase.BUTTON_YES | PopUpBase.BUTTON_NO;
            _loc3_.text = resourceManager.getString(BUNDLE,"DLG_CLIENT_CHANGE_TEXT");
            _loc3_.title = resourceManager.getString(BUNDLE,"DLG_CLIENT_CHANGE_TITLE");
            _loc3_.addEventListener(CloseEvent.CLOSE,this.onCloseChangeCharacter);
            CharacterSelectionWidget(param1.currentTarget).embeddedDialog = _loc3_;
         }
         else if((param1.detail == PopUpBase.BUTTON_YES || param1.detail == PopUpBase.BUTTON_OKAY) && (param1.currentTarget is CharacterSelectionWidget || param1.currentTarget is EmbeddedDialog && EmbeddedDialog(param1.currentTarget).name == "ConfirmClientChange") && this.m_ConnectionDataPending != -1)
         {
            if(param1.currentTarget as EmbeddedDialog != null)
            {
               ((param1.currentTarget as EmbeddedDialog).parent as PopUpBase).hide(false);
            }
            if(this.m_Connection != null && Boolean(this.m_Connection.isConnected))
            {
               this.m_Communication.disconnect(false);
            }
            else if(this.m_Connection == null || !this.m_Connection.isConnected)
            {
               this.loginCharacter();
            }
         }
         else if(param1.currentTarget is CharacterSelectionWidget && param1.detail == PopUpBase.BUTTON_OKAY)
         {
            param1.preventDefault();
            _loc3_ = new EmbeddedDialog();
            _loc3_.name = "NoCharacterSelected";
            _loc3_.buttonFlags = PopUpBase.BUTTON_OKAY;
            _loc3_.text = resourceManager.getString(BUNDLE,"DLG_CHANGE_CHARACTER_NO_SELECTION_TEXT");
            _loc3_.title = resourceManager.getString(BUNDLE,"DLG_CHANGE_CHARACTER_NO_SELECTION_TITLE");
            _loc3_.addEventListener(CloseEvent.CLOSE,this.onCloseChangeCharacter);
            CharacterSelectionWidget(param1.currentTarget).embeddedDialog = _loc3_;
         }
      }
      
      private function onConnectionDisconnected(param1:ConnectionEvent) : void
      {
         visible = false;
         this.saveLocalData();
         this.saveOptions();
         if(this.m_TutorialMode)
         {
            this.transferToLiveServer(this.m_TutorialData["player-name"]);
         }
         else if(this.m_ConnectionDataPending == -1)
         {
            this.changeCharacter();
         }
         else
         {
            this.loginCharacter();
         }
      }
      
      public function get isRunning() : Boolean
      {
         return this.m_Connection != null && Boolean(this.m_Connection.isGameRunning) || Boolean(this.m_CurrentOptionsUploading);
      }
      
      public function get currentConnection() : Object
      {
         return this.m_Connection;
      }
      
      public function set options(param1:OptionsStorage) : void
      {
         if(this.m_Options != param1)
         {
            if(this.m_Options != null)
            {
               this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
               this.m_Options.unload();
            }
            this.m_Options = param1;
            this.m_ChatStorage.options = this.m_Options;
            if(this.m_CreatureStorage != null)
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
            if(this.m_Options != null)
            {
               this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
            this.m_CurrentOptionsDirty = true;
         }
      }
      
      public function reset(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         if(this.m_ChatStorage != null)
         {
            this.m_ChatStorage.reset();
         }
         if(this.m_ContainerStorage != null)
         {
            this.m_ContainerStorage.reset();
         }
         if(this.m_CreatureStorage != null)
         {
            this.m_CreatureStorage.reset(param1);
         }
         if(this.m_Player != null && param1 == true)
         {
            this.m_Player.reset();
         }
         if(this.m_SpellStorage != null)
         {
            this.m_SpellStorage.reset();
         }
         if(this.m_WorldMapStorage != null)
         {
            this.m_WorldMapStorage.reset();
         }
         if(this.m_Options != null)
         {
            this.m_Options.combatPVPMode = OptionsStorage.COMBAT_PVP_MODE_DOVE;
         }
         if(this.m_UIActionBarBottom != null)
         {
            this.m_UIActionBarBottom.containerStorage = this.m_ContainerStorage;
         }
         if(this.m_UIActionBarLeft != null)
         {
            this.m_UIActionBarLeft.containerStorage = this.m_ContainerStorage;
         }
         if(this.m_UIActionBarRight != null)
         {
            this.m_UIActionBarRight.containerStorage = this.m_ContainerStorage;
         }
         if(this.m_UIActionBarTop != null)
         {
            this.m_UIActionBarTop.containerStorage = this.m_ContainerStorage;
         }
         if(this.m_UIChatWidget != null)
         {
            this.m_UIChatWidget.chatStorage = this.m_ChatStorage;
            this.m_UIChatWidget.leftChannel = this.m_ChatStorage.getChannel(ChatStorage.LOCAL_CHANNEL_ID);
            this.m_UIChatWidget.rightChannel = null;
         }
         if(this.m_UIStatusWidget != null)
         {
            this.m_UIStatusWidget.player = this.m_Player;
         }
         if(this.m_UIWorldMapWidget != null)
         {
            this.m_UIWorldMapWidget.reset();
         }
         if(this.options != null)
         {
            _loc2_ = 0;
            for each(_loc2_ in this.options.getSideBarSetIDs())
            {
               this.options.getSideBarSet(_loc2_).closeVolatileWidgets();
            }
            for each(_loc2_ in this.options.getBuddySetIDs())
            {
               this.options.getBuddySet(_loc2_).clearBuddies();
            }
         }
         CursorManager.getInstance().removeAllCursors();
         if(ContextMenuBase.getCurrent() != null)
         {
            ContextMenuBase.getCurrent().hide();
         }
         PopUpQueue.getInstance().hideByPriority(PopUpBase.DEFAULT_PRIORITY);
      }
      
      public function changeCharacter() : void
      {
         var _loc2_:IConnectionData = null;
         var _loc3_:CharacterSelectionWidget = null;
         var _loc1_:ArrayCollection = new ArrayCollection();
         for each(_loc2_ in this.m_ConnectionDataList)
         {
            if(_loc2_ is AccountCharacter)
            {
               _loc1_.addItem(_loc2_);
            }
         }
         if(_loc1_.length > 0)
         {
            _loc3_ = new CharacterSelectionWidget();
            _loc3_.characters = _loc1_;
            _loc3_.selectedCharacterIndex = this.m_ConnectionDataCurrent;
            _loc3_.addEventListener(CloseEvent.CLOSE,this.onCloseChangeCharacter);
            _loc3_.show();
         }
         else
         {
            this.m_ConnectionDataPending = 0;
            this.loginCharacter();
         }
      }
      
      public function set m_UIGameWindow(param1:GridContainer) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1404294856m_UIGameWindow;
         if(_loc2_ !== param1)
         {
            this._1404294856m_UIGameWindow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIGameWindow",_loc2_,param1));
         }
      }
      
      private function _Tibia_Array2_i() : Array
      {
         var _loc1_:Array = [undefined,undefined];
         this._Tibia_Array2 = _loc1_;
         BindingManager.executeBindings(this,"_Tibia_Array2",this._Tibia_Array2);
         return _loc1_;
      }
      
      public function set m_UICenterColumn(param1:CustomDividedBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1356021457m_UICenterColumn;
         if(_loc2_ !== param1)
         {
            this._1356021457m_UICenterColumn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UICenterColumn",_loc2_,param1));
         }
      }
      
      public function set m_UISideBarToggleLeft(param1:ToggleBar) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2056921391m_UISideBarToggleLeft;
         if(_loc2_ !== param1)
         {
            this._2056921391m_UISideBarToggleLeft = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UISideBarToggleLeft",_loc2_,param1));
         }
      }
      
      public function set m_UIInputHandler(param1:InputHandler) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._748017946m_UIInputHandler;
         if(_loc2_ !== param1)
         {
            this._748017946m_UIInputHandler = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIInputHandler",_loc2_,param1));
         }
      }
      
      private function onConnectionError(param1:ConnectionEvent) : void
      {
         visible = false;
         this.saveLocalData();
         this.saveOptions();
         SessiondumpMouseShield.getInstance().hide();
         var _loc2_:MessageWidget = new MessageWidget();
         _loc2_.buttonFlags = PopUpBase.BUTTON_OKAY;
         _loc2_.keyboardFlags = PopUpBase.KEY_ENTER;
         _loc2_.message = resourceManager.getString(BUNDLE,"DLG_ERROR_TEXT_GENERAL",[param1.message]);
         _loc2_.title = resourceManager.getString(BUNDLE,"DLG_ERROR_TITLE");
         _loc2_.addEventListener(CloseEvent.CLOSE,this.onCloseError);
         _loc2_.show();
      }
      
      private function onSecondaryTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = s_GetTibiaTimer();
         if(_loc2_ > this.m_CurrentOptionsLastUpload + this.m_CurrentOptionsUploadErrorDelay + OPTIONS_SAVE_INTERVAL)
         {
            this.saveOptions();
         }
         this.m_SecondaryTimestamp = _loc2_;
      }
      
      private function onConnectionCreated(param1:ConnectionEvent) : void
      {
         var _loc3_:Sessiondump = null;
         var _loc2_:IServerConnection = Tibia.s_GetConnection();
         if(_loc2_ is Connection)
         {
            if(this.m_CreatureStorage == null || this.m_CreatureStorage is CreatureStorage == false)
            {
               this.m_CreatureStorage = new CreatureStorage();
            }
            SessiondumpMouseShield.getInstance().hide();
         }
         else if(_loc2_ is Sessiondump)
         {
            _loc3_ = _loc2_ as Sessiondump;
            if(this.m_CreatureStorage == null || this.m_CreatureStorage is SessiondumpCreatureStorage == false)
            {
               this.m_CreatureStorage = new SessiondumpCreatureStorage();
            }
            SessiondumpMouseShield.getInstance().show();
         }
         this.m_Player = this.m_CreatureStorage.player;
         if(s_TutorialData != null)
         {
            this.m_Player.name = s_TutorialData["player-name"] as String;
         }
         this.m_UIStatusWidget.player = this.m_Player;
         this.m_UIWorldMapWidget.creatureStorage = this.m_CreatureStorage;
         this.m_UIWorldMapWidget.player = this.m_Player;
         this.m_UIWorldMapWidget.worldMapStorage = this.m_WorldMapStorage;
         this.m_Communication = new Communication(this.m_Connection,this.m_AppearanceStorage,this.m_ChatStorage,this.m_ContainerStorage,this.m_CreatureStorage,this.m_MiniMapStorage,this.m_Player,this.m_SpellStorage,this.m_WorldMapStorage);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIBottomContainer() : HBox
      {
         return this._967396880m_UIBottomContainer;
      }
      
      private function onConnectionLoginError(param1:ConnectionEvent) : void
      {
         visible = false;
         this.saveLocalData();
         this.saveOptions();
         var _loc2_:MessageWidget = new MessageWidget();
         _loc2_.buttonFlags = PopUpBase.BUTTON_OKAY;
         _loc2_.keyboardFlags = PopUpBase.KEY_ENTER;
         _loc2_.message = resourceManager.getString(BUNDLE,"DLG_LOGINERROR_TEXT",[param1.message]);
         _loc2_.title = resourceManager.getString(BUNDLE,"DLG_LOGINERROR_TITLE");
         _loc2_.addEventListener(CloseEvent.CLOSE,this.onCloseError);
         _loc2_.show();
      }
      
      private function _Tibia_StatusWidget1_i() : StatusWidget
      {
         var _loc1_:StatusWidget = new StatusWidget();
         this.m_UIStatusWidget = _loc1_;
         _loc1_.id = "m_UIStatusWidget";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function onCloseError(param1:CloseEvent) : void
      {
         var _loc2_:GameEvent = new GameEvent(GameEvent.CLOSE,true,false);
         dispatchEvent(_loc2_);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
      }
      
      protected function releaseConnection() : void
      {
         if(this.m_Connection != null)
         {
            this.m_Connection.removeEventListener(ConnectionEvent.PENDING,this.onConnectionPending);
            this.m_Connection.removeEventListener(ConnectionEvent.GAME,this.onConnectionGame);
            this.m_Connection.removeEventListener(ConnectionEvent.CONNECTING,this.onConnectionConnecting);
            this.m_Connection.removeEventListener(ConnectionEvent.CONNECTION_LOST,this.onConnectionLost);
            this.m_Connection.removeEventListener(ConnectionEvent.CONNECTION_RECOVERED,this.onConnectionRecovered);
            this.m_Connection.removeEventListener(ConnectionEvent.DEAD,this.onConnectionDeath);
            this.m_Connection.removeEventListener(ConnectionEvent.DISCONNECTED,this.onConnectionDisconnected);
            this.m_Connection.removeEventListener(ConnectionEvent.ERROR,this.onConnectionError);
            this.m_Connection.removeEventListener(ConnectionEvent.LOGINADVICE,this.onConnectionLoginAdvice);
            this.m_Connection.removeEventListener(ConnectionEvent.LOGINERROR,this.onConnectionLoginError);
            this.m_Connection.removeEventListener(ConnectionEvent.LOGINWAIT,this.onConnectionLoginWait);
            this.m_Connection.disconnect(false);
            this.m_Connection = null;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarB() : SideBarWidget
      {
         return this._64278964m_UISideBarB;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarD() : SideBarWidget
      {
         return this._64278962m_UISideBarD;
      }
      
      private function onConnectionDeath(param1:ConnectionEvent) : void
      {
         visible = true;
         this.m_CharacterDeath = true;
         var _loc2_:Number = param1.data is Number?Number(Number(param1.data)):Number(100);
         var _loc3_:MessageWidget = new MessageWidget();
         _loc3_.title = resourceManager.getString(BUNDLE,"DLG_DEAD_TITLE");
         if(_loc2_ < 100)
         {
            _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_UNFAIR",[_loc2_]);
         }
         else
         {
            _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_FAIR");
         }
         _loc3_.addEventListener(CloseEvent.CLOSE,this.onCloseDeath);
         _loc3_.show();
      }
      
      public function saveOptions() : void
      {
         if(this.m_Options != null)
         {
            this.m_ChatStorage.saveChannels();
            if(this.m_CurrentOptionsAsset != null && !this.m_CurrentOptionsUploading && Boolean(this.m_CurrentOptionsDirty))
            {
               this.m_CurrentOptionsAsset.upload(this.options.marshall(),this.m_SessionKey);
               this.m_CurrentOptionsUploading = true;
            }
         }
      }
      
      protected function onDividerRelease(param1:DividerEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null)
         {
            _loc2_ = this.m_UIGameWindow.height;
            _loc3_ = this.m_UIChatWidget.height;
            if(!isNaN(this.m_UIChatWidget.minHeight) && Math.abs(_loc3_ - this.m_UIChatWidget.minHeight) < 0.01)
            {
               this.options.generalUIGameWindowHeight = 100;
            }
            else if(!isNaN(this.m_UIGameWindow.minHeight) && Math.abs(_loc2_ - this.m_UIGameWindow.minHeight) < 0.01)
            {
               this.options.generalUIGameWindowHeight = 0;
            }
            else
            {
               this.options.generalUIGameWindowHeight = _loc2_ * 100 / (_loc2_ + _loc3_);
            }
         }
      }
      
      public function ___Tibia_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialise(param1);
      }
      
      private function _Tibia_GameWindowContainer1_i() : GameWindowContainer
      {
         var _loc1_:GameWindowContainer = new GameWindowContainer();
         this.m_UIWorldMapWindow = _loc1_;
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.center = this._Tibia_WorldMapWidget1_i();
         _loc1_.top = this._Tibia_HActionBarWidget1_i();
         _loc1_.bottom = this._Tibia_HActionBarWidget2_i();
         _loc1_.left = this._Tibia_VActionBarWidget1_i();
         _loc1_.right = this._Tibia_VActionBarWidget2_i();
         _loc1_.id = "m_UIWorldMapWindow";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function onCloseDeath(param1:CloseEvent) : void
      {
         if(param1.detail == PopUpBase.BUTTON_OKAY)
         {
            if(this.m_Communication != null)
            {
               this.m_Communication.sendCENTERWORLD();
            }
         }
         else
         {
            this.m_ConnectionDataPending = -1;
            if(this.m_Communication != null)
            {
               this.m_Communication.disconnect(false);
            }
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      public function set m_UIOuterRootContainer(param1:DividedBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1568861366m_UIOuterRootContainer;
         if(_loc2_ !== param1)
         {
            this._1568861366m_UIOuterRootContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIOuterRootContainer",_loc2_,param1));
         }
      }
      
      public function set m_UIActionBarRight(param1:VActionBarWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2043305115m_UIActionBarRight;
         if(_loc2_ !== param1)
         {
            this._2043305115m_UIActionBarRight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIActionBarRight",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UICenterColumn() : CustomDividedBox
      {
         return this._1356021457m_UICenterColumn;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIInputHandler() : InputHandler
      {
         return this._748017946m_UIInputHandler;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
      }
      
      private function onUploadOptionsError(param1:ErrorEvent) : void
      {
         this.m_CurrentOptionsUploading = false;
         if(param1.errorID == -1)
         {
            this.m_CurrentOptionsUploadErrorDelay = 1000 * 60 * 60 * 24 * 365;
         }
         else
         {
            this.m_CurrentOptionsUploadErrorDelay = this.m_CurrentOptionsUploadErrorDelay == 0?2000:int(this.m_CurrentOptionsUploadErrorDelay * 2);
         }
      }
      
      private function _Tibia_WorldMapWidget1_i() : WorldMapWidget
      {
         var _loc1_:WorldMapWidget = new WorldMapWidget();
         this.m_UIWorldMapWidget = _loc1_;
         _loc1_.id = "m_UIWorldMapWidget";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIGameWindow() : GridContainer
      {
         return this._1404294856m_UIGameWindow;
      }
      
      public function unload() : void
      {
         if(this.m_AppearanceStorage != null)
         {
            this.m_AppearanceStorage.removeEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
            this.m_AppearanceStorage.removeEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
            this.m_AppearanceStorage.reset();
         }
         if(this.m_ChatStorage != null)
         {
            this.m_ChatStorage.reset();
         }
         if(this.m_ContainerStorage != null)
         {
            this.m_ContainerStorage.reset();
         }
         if(this.m_CreatureStorage != null)
         {
            this.m_CreatureStorage.reset();
         }
         if(this.m_MiniMapStorage != null)
         {
            this.m_MiniMapStorage.reset();
         }
         if(this.m_Player != null)
         {
            this.m_Player.reset();
         }
         if(this.m_SpellStorage != null)
         {
            this.m_SpellStorage.reset();
         }
         if(this.m_WorldMapStorage != null)
         {
            this.m_WorldMapStorage.reset();
         }
         this.releaseConnection();
         if(this.m_SeconaryTimer != null)
         {
            this.m_SeconaryTimer.stop();
         }
         if(this.m_UIInputHandler != null)
         {
            this.m_UIInputHandler.dispose();
         }
         CursorManager.getInstance().removeAllCursors();
         if(ContextMenuBase.getCurrent() != null)
         {
            ContextMenuBase.getCurrent().hide();
         }
         FocusNotifier.getInstance().hide();
         PopUpQueue.getInstance().hideByPriority(int.MAX_VALUE);
      }
      
      public function set m_UIStatusWidget(param1:StatusWidget) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._228925540m_UIStatusWidget;
         if(_loc2_ !== param1)
         {
            this._228925540m_UIStatusWidget = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIStatusWidget",_loc2_,param1));
         }
      }
      
      private function _Tibia_HActionBarWidget1_i() : HActionBarWidget
      {
         var _loc1_:HActionBarWidget = new HActionBarWidget();
         this.m_UIActionBarTop = _loc1_;
         _loc1_.styleName = "actionBarTop";
         _loc1_.id = "m_UIActionBarTop";
         BindingManager.executeBindings(this,"m_UIActionBarTop",this.m_UIActionBarTop);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIStatusWidget() : StatusWidget
      {
         return this._228925540m_UIStatusWidget;
      }
      
      private function onConnectionGame(param1:ConnectionEvent) : void
      {
         PopUpQueue.getInstance().hideByPriority(PopUpBase.DEFAULT_PRIORITY);
         if(ContextMenuBase.getCurrent() != null)
         {
            ContextMenuBase.getCurrent().hide();
         }
         visible = true;
         this.updateCombatTactics();
         this.m_CharacterDeath = false;
      }
      
      public function setAssetProvider(param1:IAssetProvider) : void
      {
         if(param1 == null)
         {
            throw new Error("Tibia.setAssetProvider: asset provider must not be null.");
         }
         this.m_AssetProvider = param1;
         var _loc2_:OptionsAsset = !!this.m_TutorialMode?this.m_AssetProvider.getDefaultOptionsTutorial():this.m_AssetProvider.getDefaultOptions();
         this.m_DefaultOptionsAsset = _loc2_;
         if(_loc2_ != null)
         {
            param1.removeAsset(_loc2_);
         }
         if(!this.m_TutorialMode)
         {
            this.setCurrentOptionsFromAssets(param1);
         }
         this.m_AppearanceStorage.setAssetProvider(param1);
      }
   }
}

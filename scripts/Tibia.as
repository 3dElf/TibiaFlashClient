package
{
   import mx.core.Application;
   import mx.binding.IBindingClient;
   import tibia.game.IGameClient;
   import tibia.network.Communication;
   import mx.binding.IWatcherSetupUtil;
   import tibia.input.InputHandler;
   import tibia.appearances.AppearanceStorage;
   import tibia.chat.ChatStorage;
   import tibia.minimap.MiniMapStorage;
   import tibia.options.OptionsStorage;
   import tibia.container.ContainerStorage;
   import tibia.chat.ChatWidget;
   import tibia.magic.SpellStorage;
   import tibia.creatures.StatusWidget;
   import tibia.worldmap.WorldMapStorage;
   import tibia.network.IServerConnection;
   import tibia.creatures.Player;
   import tibia.creatures.CreatureStorage;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import tibia.actionbar.VActionBarWidget;
   import mx.binding.BindingManager;
   import tibia.game.OptionsAsset;
   import mx.events.CloseEvent;
   import tibia.game.PopUpBase;
   import tibia.worldmap.WorldMapWidget;
   import flash.events.Event;
   import tibia.network.IConnectionData;
   import tibia.network.ConnectionEvent;
   import tibia.game.MessageWidget;
   import build.BuildConstants;
   import tibia.actionbar.HActionBarWidget;
   import tibia.game.TimeoutWaitWidget;
   import tibia.sidebar.ToggleBar;
   import mx.binding.Binding;
   import tibia.sidebar.SideBarSet;
   import mx.containers.BoxDirection;
   import tibia.actionbar.ActionBarSet;
   import flash.events.ErrorEvent;
   import tibia.game.GameEvent;
   import tibia.game.FocusNotifier;
   import tibia.game.AccountCharacter;
   import flash.net.URLVariables;
   import flash.net.URLRequest;
   import shared.utility.URLHelper;
   import flash.net.navigateToURL;
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
   import flash.utils.*;
   import build.CreatureStorageFactory;
   import build.ConnectionFactory;
   import flash.events.TimerEvent;
   import tibia.sidebar.SideBarWidget;
   import mx.managers.ToolTipManager;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.MouseEvent;
   import tibia.game.LoginWaitWidget;
   import tibia.game.ConnectionLostWidget;
   import mx.containers.HBox;
   import mx.core.IUIComponent;
   import tibia.controls.GameWindowContainer;
   import loader.asset.IAssetProvider;
   import shared.controls.EmbeddedDialog;
   import tibia.game.CharacterSelectionWidget;
   import mx.managers.CursorManager;
   import tibia.game.ContextMenuBase;
   import tibia.game.PopUpQueue;
   import mx.collections.ArrayCollection;
   import shared.controls.CustomDividedBox;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import mx.core.UIComponentDescriptor;
   
   use namespace mx_internal;
   
   public class Tibia extends Application implements IBindingClient, IGameClient
   {
      
      private static const BUNDLE:String = "Tibia";
      
      private static const SHAREDOBJECT_NAME:String = "options";
      
      public static var s_FrameTibiaTimestamp:Number = 0;
      
      public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
      
      public static var s_FrameRealTimestamp:Number = 0;
      
      private static var s_InternalTibiaTimerFactor:Number = 1;
      
      public static const CLIENT_PREVIEW_STATE:uint = 0;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const MAX_SESSION_KEY_LENGTH:int = 30;
      
      private static var s_LastTibiaFactorChangeRealTimestamp:int = 0;
      
      public static const CLIENT_TYPE:uint = 3;
      
      public static const CLIENT_VERSION:uint = 1468;
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
      
      private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
      
      public static const PREVIEW_STATE_REGULAR:uint = 0;
      
      private static var s_LastTibiaTimestamp:int = 0;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1941869929:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1326449295:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1898230390:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_2078117321:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1667821835:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_368901263:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_856081774:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1792397681:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_911866029:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1459484654:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_848966728:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_524265165:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1830045226:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1648684670:Class;
      
      protected var m_IsActive:Boolean = false;
      
      private var _embed_css_images_Scrollbar_Handler_png_891018213:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_459456471:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1406719523:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_952609698:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1031126173:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_210678551:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1080095093:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_971617703:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_1142451972:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1140364387:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1662081516:Class;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_291957830:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_970151295:Class;
      
      private var _embed_css_images_Border02_png_21872994:Class;
      
      private var _embed_css_images_Border02_corners_png_2076493629:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1221587654:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_1810926881:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1678239231:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_160381318:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1330029230:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_285870511:Class;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1919702416:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_54879669:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1661474424:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_2089090273:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1801431543:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1480490498:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1020722807:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_565818060:Class;
      
      private var _embed_css_images_slot_Hotkey_highlighted_png_1949042577:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1380373332:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_2011765570:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_211523648:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_939628956:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_142529859:Class;
      
      private var m_GameClientReady:Boolean = false;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_272073824:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_948898416:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1827665666:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1470729347:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_2032922812:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1954603383:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1925646454:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_463706348:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1545689379:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1750047771:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_531638255:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1220175056:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_383168283:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_942462645:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_944887840:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1508131644:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_678160931:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_2028264419:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1486086026:Class;
      
      protected var m_Connection:IServerConnection = null;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_978333350:Class;
      
      private var _embed_css_images_Button_Close_idle_png_1620964302:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1175466128:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_244459892:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1711700530:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_570649517:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_251231604:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_6358336:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1846977530:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_1173464784:Class;
      
      protected var m_ConnectionDataPending:int = -1;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_917141944:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1518394940:Class;
      
      private var _embed_css_images_slot_Hotkey_disabled_png_254237256:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1488047070:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1911356949:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_564097247:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1315180238:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_591055681:Class;
      
      private var _embed_css_images_Inventory_png_545057958:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_422824490:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_294370979:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1186952157:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_14687412:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1663759795:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_262950001:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_557390300:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1952019032:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_797726091:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_498924963:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1397018072:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1886094892:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_542250861:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1644954075:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_876168762:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1937331123:Class;
      
      protected var m_CharacterDeath:Boolean = false;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_681407729:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1057773629:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_471904023:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_937674724:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_849132130:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_2101651168:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_32998850:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Minimap_png_198039137:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_6921022:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_571031646:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_513037701:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_2013578955:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1586970625:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_476461055:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_969068565:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_374677324:Class;
      
      private var _embed_css_images_BarsXP_default__png_845164511:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1853049409:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_703168369:Class;
      
      private var _embed_css_images_Border_Widget_png_69275937:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1686471946:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1523287385:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1591440752:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_1497573139:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_474575307:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1086493566:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_888182355:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_286061156:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_760128604:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1844161577:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1533164815:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_389327805:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_1526548216:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1481439149:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_589626669:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_1906001928:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1277825225:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1840333518:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_1396875386:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1183603230:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_1399042506:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_419679878:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_667344946:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1557571747:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_729952867:Class;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_1220225987:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_1334774996:Class;
      
      private var _embed_css_images_BG_Combat_png_1660110136:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_4033695:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_1049826522:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_321198029:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_2147346417:Class;
      
      private var _embed_css_images_Button_Close_over_png_1419867342:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_378690601:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1719140751:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_953948618:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1867906544:Class;
      
      protected var m_AssetProvider:IAssetProvider = null;
      
      private var _embed_css_images_Minimap_Center_over_png_273455170:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_173384104:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_302966269:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1700667483:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1973873255:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_1258890796:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1302911615:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_632212014:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_698488136:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_742527635:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1541242670:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1325340282:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_109310569:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1003314872:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_302269331:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_459297146:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_521050777:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_70124063:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_927312172:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1036199962:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1732643505:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1260648887:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_134173551:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_115447882:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1741103818:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_112019812:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_407349441:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2110360739:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_116005868:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_2073233738:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1667918733:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_38154934:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1192662649:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1453735159:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_999626028:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_340021463:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1158661860:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_1422851953:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_486349015:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_289813363:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_438976679:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_965795967:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_518553524:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_2105188774:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_1331532624:Class;
      
      protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1061681968:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1843295042:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1466259493:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1277785288:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_206980607:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_863969557:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_1138850591:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_898465170:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1279580009:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_468835562:Class;
      
      private var _embed_css_images_Slot_Statusicon_png_1750754282:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_Slot_InventoryShield_png_669657636:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1230751138:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_1366374114:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_141819438:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_2029422537:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_428483789:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_114161412:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_210043163:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_792618239:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_1162636614:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_1150218209:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1521355371:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_813044862:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_481631515:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_519696053:Class;
      
      protected var m_ConnectionDataCurrent:int = -1;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1140067578:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1684895030:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1756788701:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1786205762:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1597329999:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_1246124415:Class;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_1389321733:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1620755662:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1704670620:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_885699451:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_842826994:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1708693506:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_656682214:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_447709035:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_114945475:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1992257243:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_2146944575:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_663450167:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_612395940:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_314432318:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1299361873:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_1145543653:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_888817201:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_941318071:Class;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_427192706:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1311455612:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_391948264:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_28049037:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1933837858:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_347580772:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1600517500:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_633312831:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1430354784:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_318987245:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_293190379:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_1153268399:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_png_518101401:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_347090975:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1814144753:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_348854334:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1687829603:Class;
      
      protected var m_Communication:Communication = null;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_274222564:Class;
      
      private var _embed_css_images_slot_container_png_1920756400:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_392211430:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1592801728:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1620394079:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1324558011:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_818978708:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_146113780:Class;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1804113517:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1634715614:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_2100402847:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_206751937:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_972688215:Class;
      
      private var _embed_css_images_slot_Hotkey_png_601551571:Class;
      
      protected var m_ChannelsPending:Vector.<int> = null;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1170807868:Class;
      
      private var m_ConnectionLostDialog:ConnectionLostWidget;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_743203601:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_42971950:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_1199213943:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_2094184810:Class;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_396922403:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1675971780:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_321932777:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_188192732:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1950361479:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1372856084:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1923649398:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1249739377:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_182241058:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_1212121857:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function Tibia()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "id":"m_UIRootContainer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_898465170 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_898465170;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_141819438 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_141819438;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1541242670 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1541242670;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1330029230 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1330029230;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_589626669 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_589626669;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1521355371 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1521355371;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_447709035 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_447709035;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1324558011 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1324558011;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_531638255 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_531638255;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_743203601 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_743203601;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1814144753 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1814144753;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_937674724 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_937674724;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_1258890796 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_1258890796;
         this._embed_css_images_Arrow_ScrollTabs_over_png_927312172 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_927312172;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_114161412 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_114161412;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1430354784 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1430354784;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_1138850591 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_1138850591;
         this._embed_css_images_Arrow_WidgetToggle_over_png_70124063 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_70124063;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_206980607 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_206980607;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1459484654 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1459484654;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1470729347 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1470729347;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1586970625 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1586970625;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1786205762 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1786205762;
         this._embed_css_images_BG_Bars_compact_tileable_png_1844161577 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1844161577;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1299361873 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1299361873;
         this._embed_css_images_BG_Bars_default_enpiece_png_188192732 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_188192732;
         this._embed_css_images_BG_Bars_default_tileable_png_474575307 = Tibia__embed_css_images_BG_Bars_default_tileable_png_474575307;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1279580009 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1279580009;
         this._embed_css_images_BG_Bars_fat_enpiece_png_286061156 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_286061156;
         this._embed_css_images_BG_Bars_fat_tileable_png_2028264419 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_2028264419;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1792397681 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1792397681;
         this._embed_css_images_BG_BohemianTileable_Game_png_146113780 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_146113780;
         this._embed_css_images_BG_BohemianTileable_png_1422851953 = Tibia__embed_css_images_BG_BohemianTileable_png_1422851953;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_391948264 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_391948264;
         this._embed_css_images_BG_ChatTab_tileable_png_1488047070 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1488047070;
         this._embed_css_images_BG_Combat_png_1660110136 = Tibia__embed_css_images_BG_Combat_png_1660110136;
         this._embed_css_images_BG_Stone2_Tileable_png_1867906544 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1867906544;
         this._embed_css_images_BG_Widget_Menu_png_1331532624 = Tibia__embed_css_images_BG_Widget_Menu_png_1331532624;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_114945475 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_114945475;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_953948618 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_953948618;
         this._embed_css_images_BarsHealth_compact_Mana_png_1919702416 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1919702416;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1326449295 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1326449295;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_272073824 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_272073824;
         this._embed_css_images_BarsHealth_compact_RedLow_png_760128604 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_760128604;
         this._embed_css_images_BarsHealth_compact_Yellow_png_742527635 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_742527635;
         this._embed_css_images_BarsHealth_default_GreenFull_png_4033695 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_4033695;
         this._embed_css_images_BarsHealth_default_GreenLow_png_818978708 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_818978708;
         this._embed_css_images_BarsHealth_default_Mana_png_1620755662 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1620755662;
         this._embed_css_images_BarsHealth_default_RedFull_png_134173551 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_134173551;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1183603230 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1183603230;
         this._embed_css_images_BarsHealth_default_RedLow_png_1648684670 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1648684670;
         this._embed_css_images_BarsHealth_default_Yellow_png_262950001 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_262950001;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_941318071 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_941318071;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_557390300 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_557390300;
         this._embed_css_images_BarsHealth_fat_Mana_png_1898230390 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1898230390;
         this._embed_css_images_BarsHealth_fat_RedFull_png_663450167 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_663450167;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_2105188774 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_2105188774;
         this._embed_css_images_BarsHealth_fat_RedLow_png_422824490 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_422824490;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1523287385 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1523287385;
         this._embed_css_images_BarsXP_default__png_845164511 = Tibia__embed_css_images_BarsXP_default__png_845164511;
         this._embed_css_images_Bars_ProgressMarker_png_1220175056 = Tibia__embed_css_images_Bars_ProgressMarker_png_1220175056;
         this._embed_css_images_Border02_WidgetSidebar_png_518101401 = Tibia__embed_css_images_Border02_WidgetSidebar_png_518101401;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_681407729 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_681407729;
         this._embed_css_images_Border02_corners_png_2076493629 = Tibia__embed_css_images_Border02_corners_png_2076493629;
         this._embed_css_images_Border02_png_21872994 = Tibia__embed_css_images_Border02_png_21872994;
         this._embed_css_images_Border_Widget_corner_png_570649517 = Tibia__embed_css_images_Border_Widget_corner_png_570649517;
         this._embed_css_images_Border_Widget_png_69275937 = Tibia__embed_css_images_Border_Widget_png_69275937;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_969068565 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_969068565;
         this._embed_css_images_Button_ChatTabIgnore_over_png_293190379 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_293190379;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_383168283 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_383168283;
         this._embed_css_images_Button_ChatTabNew_idle_png_1804113517 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1804113517;
         this._embed_css_images_Button_ChatTabNew_over_png_542250861 = Tibia__embed_css_images_Button_ChatTabNew_over_png_542250861;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1663759795 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1663759795;
         this._embed_css_images_Button_ChatTab_Close_idle_png_999626028 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_999626028;
         this._embed_css_images_Button_ChatTab_Close_over_png_1886094892 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1886094892;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1170807868 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1170807868;
         this._embed_css_images_Button_Close_idle_png_1620964302 = Tibia__embed_css_images_Button_Close_idle_png_1620964302;
         this._embed_css_images_Button_Close_over_png_1419867342 = Tibia__embed_css_images_Button_Close_over_png_1419867342;
         this._embed_css_images_Button_Close_pressed_png_952609698 = Tibia__embed_css_images_Button_Close_pressed_png_952609698;
         this._embed_css_images_Button_Combat_Stop_idle_png_1497573139 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1497573139;
         this._embed_css_images_Button_Combat_Stop_over_png_318987245 = Tibia__embed_css_images_Button_Combat_Stop_over_png_318987245;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1937331123 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1937331123;
         this._embed_css_images_Button_ContainerUp_idle_png_348854334 = Tibia__embed_css_images_Button_ContainerUp_idle_png_348854334;
         this._embed_css_images_Button_ContainerUp_over_png_6921022 = Tibia__embed_css_images_Button_ContainerUp_over_png_6921022;
         this._embed_css_images_Button_ContainerUp_pressed_png_427192706 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_427192706;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_142529859 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_142529859;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_389327805 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_389327805;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_392211430 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_392211430;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_656682214 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_656682214;
         this._embed_css_images_Button_Maximize_idle_png_419679878 = Tibia__embed_css_images_Button_Maximize_idle_png_419679878;
         this._embed_css_images_Button_Maximize_over_png_1396875386 = Tibia__embed_css_images_Button_Maximize_over_png_1396875386;
         this._embed_css_images_Button_Maximize_pressed_png_876168762 = Tibia__embed_css_images_Button_Maximize_pressed_png_876168762;
         this._embed_css_images_Button_Minimize_idle_png_1526548216 = Tibia__embed_css_images_Button_Minimize_idle_png_1526548216;
         this._embed_css_images_Button_Minimize_over_png_1906001928 = Tibia__embed_css_images_Button_Minimize_over_png_1906001928;
         this._embed_css_images_Button_Minimize_pressed_png_1952019032 = Tibia__embed_css_images_Button_Minimize_pressed_png_1952019032;
         this._embed_css_images_Button_Standard_tileable_disabled_png_173384104 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_173384104;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_2032922812 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_2032922812;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_797726091 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_797726091;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1545689379 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1545689379;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1406719523 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1406719523;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_28049037 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_28049037;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1518394940 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1518394940;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1508131644 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1508131644;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_374677324 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_374677324;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_2146944575 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_2146944575;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_206751937 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_206751937;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_1150218209 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_1150218209;
         this._embed_css_images_Button_Standard_tileable_idle_png_6358336 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_6358336;
         this._embed_css_images_Button_Standard_tileable_over_png_211523648 = Tibia__embed_css_images_Button_Standard_tileable_over_png_211523648;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1591440752 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1591440752;
         this._embed_css_images_BuySellTab_active_png_1315180238 = Tibia__embed_css_images_BuySellTab_active_png_1315180238;
         this._embed_css_images_BuySellTab_idle_png_944887840 = Tibia__embed_css_images_BuySellTab_idle_png_944887840;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1311455612 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1311455612;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1260648887 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1260648887;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1954603383 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1954603383;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1325340282 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1325340282;
         this._embed_css_images_ChatTab_tileable_idle_png_428483789 = Tibia__embed_css_images_ChatTab_tileable_idle_png_428483789;
         this._embed_css_images_ChatTab_tileable_png_1686471946 = Tibia__embed_css_images_ChatTab_tileable_png_1686471946;
         this._embed_css_images_ChatWindow_Mover_png_1830045226 = Tibia__embed_css_images_ChatWindow_Mover_png_1830045226;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_972688215 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_972688215;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_978333350 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_978333350;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1372856084 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1372856084;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1662081516 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1662081516;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_948898416 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_948898416;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1687829603 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1687829603;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1992257243 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1992257243;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1644954075 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1644954075;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1221587654 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1221587654;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1557571747 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1557571747;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_285870511 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_285870511;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_1153268399 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_1153268399;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_939628956 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_939628956;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1941869929 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1941869929;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_971617703 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_971617703;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_438976679 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_438976679;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_407349441 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_407349441;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1933837858 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1933837858;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_463706348 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_463706348;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_116005868 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_116005868;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_291957830 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_291957830;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_1162636614 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_1162636614;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_314432318 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_314432318;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_32998850 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_32998850;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1302911615 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1302911615;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_970151295 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_970151295;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1973873255 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1973873255;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_521050777 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_521050777;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2110360739 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_2110360739;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_2013578955 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_2013578955;
         this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_917141944 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_917141944;
         this._embed_css_images_Icons_CombatControls_DoveOff_over_png_698488136 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_698488136;
         this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_1741103818 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_1741103818;
         this._embed_css_images_Icons_CombatControls_DoveOn_over_png_1399042506 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_1399042506;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_911866029 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_911866029;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_888182355 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_888182355;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1678239231 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1678239231;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_792618239 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_792618239;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_942462645 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_942462645;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_54879669 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_54879669;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_591055681 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_591055681;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1853049409 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1853049409;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_703168369 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_703168369;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1719140751 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1719140751;
         this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_2078117321 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_2078117321;
         this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_1277825225 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_1277825225;
         this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_459456471 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_459456471;
         this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_340021463 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_340021463;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_2073233738 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_2073233738;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_115447882 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_115447882;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1480490498 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1480490498;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1827665666 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1827665666;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_274222564 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_274222564;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1158661860 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1158661860;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1486086026 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1486086026;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1923649398 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1923649398;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_965795967 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_965795967;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_1246124415 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_1246124415;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_368901263 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_368901263;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1249739377 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1249739377;
         this._embed_css_images_Icons_Conditions_Bleeding_png_518553524 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_518553524;
         this._embed_css_images_Icons_Conditions_Burning_png_1212121857 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1212121857;
         this._embed_css_images_Icons_Conditions_Cursed_png_632212014 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_632212014;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1675971780 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1675971780;
         this._embed_css_images_Icons_Conditions_Drowning_png_468835562 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_468835562;
         this._embed_css_images_Icons_Conditions_Drunk_png_42971950 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_42971950;
         this._embed_css_images_Icons_Conditions_Electrified_png_1846977530 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1846977530;
         this._embed_css_images_Icons_Conditions_Freezing_png_2101651168 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_2101651168;
         this._embed_css_images_Icons_Conditions_Haste_png_378690601 = Tibia__embed_css_images_Icons_Conditions_Haste_png_378690601;
         this._embed_css_images_Icons_Conditions_Hungry_png_210678551 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_210678551;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_888817201 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_888817201;
         this._embed_css_images_Icons_Conditions_MagicShield_png_14687412 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_14687412;
         this._embed_css_images_Icons_Conditions_PZ_png_2094184810 = Tibia__embed_css_images_Icons_Conditions_PZ_png_2094184810;
         this._embed_css_images_Icons_Conditions_PZlock_png_1620394079 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1620394079;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1481439149 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1481439149;
         this._embed_css_images_Icons_Conditions_Slowed_png_612395940 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_612395940;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1031126173 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1031126173;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_1334774996 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_1334774996;
         this._embed_css_images_Icons_PremmyPurse_active_png_1732643505 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1732643505;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_396922403 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_396922403;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1597329999 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1597329999;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_1389321733 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_1389321733;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1950361479 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1950361479;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_842826994 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_842826994;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_289813363 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_289813363;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_678160931 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_678160931;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_1220225987 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_1220225987;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1230751138 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1230751138;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_302269331 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_302269331;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1911356949 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1911356949;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_302966269 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_302966269;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_1142451972 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_1142451972;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_667344946 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_667344946;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1453735159 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1453735159;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1801431543 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1801431543;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_471904023 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_471904023;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1086493566 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1086493566;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_813044862 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_813044862;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1711700530 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1711700530;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_848966728 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_848966728;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_38154934 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_38154934;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_160381318 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_160381318;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1600517500 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1600517500;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1756788701 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1756788701;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1840333518 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1840333518;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_729952867 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_729952867;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_347090975 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_347090975;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_294370979 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_294370979;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_210043163 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_210043163;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_1003314872 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_1003314872;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_321932777 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_321932777;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1036199962 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1036199962;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1057773629 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1057773629;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_459297146 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_459297146;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1667821835 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1667821835;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1397018072 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1397018072;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_2089090273 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_2089090273;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_251231604 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_251231604;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1667918733 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1667918733;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1684895030 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1684895030;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_519696053 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_519696053;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1277785288 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1277785288;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1192662649 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1192662649;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1925646454 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1925646454;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1140364387 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1140364387;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_1049826522 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_1049826522;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1700667483 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1700667483;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1661474424 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1661474424;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_244459892 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_244459892;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_476461055 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_476461055;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1708693506 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1708693506;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_633312831 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_633312831;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_856081774 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_856081774;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1533164815 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1533164815;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_1173464784 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_1173464784;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1186952157 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1186952157;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_849132130 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_849132130;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_513037701 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_513037701;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_347580772 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_347580772;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_109310569 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_109310569;
         this._embed_css_images_Inventory_png_545057958 = Tibia__embed_css_images_Inventory_png_545057958;
         this._embed_css_images_Minimap_Center_active_png_1592801728 = Tibia__embed_css_images_Minimap_Center_active_png_1592801728;
         this._embed_css_images_Minimap_Center_idle_png_2011765570 = Tibia__embed_css_images_Minimap_Center_idle_png_2011765570;
         this._embed_css_images_Minimap_Center_over_png_273455170 = Tibia__embed_css_images_Minimap_Center_over_png_273455170;
         this._embed_css_images_Minimap_ZoomIn_idle_png_481631515 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_481631515;
         this._embed_css_images_Minimap_ZoomIn_over_png_1750047771 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1750047771;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1080095093 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1080095093;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1634715614 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1634715614;
         this._embed_css_images_Minimap_ZoomOut_over_png_182241058 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_182241058;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_1366374114 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_1366374114;
         this._embed_css_images_Minimap_png_198039137 = Tibia__embed_css_images_Minimap_png_198039137;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_112019812 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_112019812;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1704670620 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1704670620;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1380373332 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1380373332;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_524265165 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_524265165;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_321198029 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_321198029;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_498924963 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_498924963;
         this._embed_css_images_Scrollbar_Handler_png_891018213 = Tibia__embed_css_images_Scrollbar_Handler_png_891018213;
         this._embed_css_images_Scrollbar_tileable_png_2147346417 = Tibia__embed_css_images_Scrollbar_tileable_png_2147346417;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_486349015 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_486349015;
         this._embed_css_images_Slot_InventoryAmmo_png_1020722807 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1020722807;
         this._embed_css_images_Slot_InventoryArmor_png_1843295042 = Tibia__embed_css_images_Slot_InventoryArmor_png_1843295042;
         this._embed_css_images_Slot_InventoryBackpack_png_1145543653 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1145543653;
         this._embed_css_images_Slot_InventoryBoots_png_1061681968 = Tibia__embed_css_images_Slot_InventoryBoots_png_1061681968;
         this._embed_css_images_Slot_InventoryHead_png_885699451 = Tibia__embed_css_images_Slot_InventoryHead_png_885699451;
         this._embed_css_images_Slot_InventoryLegs_png_1175466128 = Tibia__embed_css_images_Slot_InventoryLegs_png_1175466128;
         this._embed_css_images_Slot_InventoryNecklace_png_1810926881 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1810926881;
         this._embed_css_images_Slot_InventoryRing_png_863969557 = Tibia__embed_css_images_Slot_InventoryRing_png_863969557;
         this._embed_css_images_Slot_InventoryShield_png_669657636 = Tibia__embed_css_images_Slot_InventoryShield_png_669657636;
         this._embed_css_images_Slot_InventoryWeapon_png_2029422537 = Tibia__embed_css_images_Slot_InventoryWeapon_png_2029422537;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1140067578 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1140067578;
         this._embed_css_images_Slot_Statusicon_png_1750754282 = Tibia__embed_css_images_Slot_Statusicon_png_1750754282;
         this._embed_css_images_Widget_Footer_tileable_end01_png_571031646 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_571031646;
         this._embed_css_images_Widget_Footer_tileable_end02_png_564097247 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_564097247;
         this._embed_css_images_Widget_Footer_tileable_png_2100402847 = Tibia__embed_css_images_Widget_Footer_tileable_png_2100402847;
         this._embed_css_images_Widget_HeaderBG_png_1199213943 = Tibia__embed_css_images_Widget_HeaderBG_png_1199213943;
         this._embed_css_images_slot_Hotkey_disabled_png_254237256 = Tibia__embed_css_images_slot_Hotkey_disabled_png_254237256;
         this._embed_css_images_slot_Hotkey_highlighted_png_1949042577 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_1949042577;
         this._embed_css_images_slot_Hotkey_png_601551571 = Tibia__embed_css_images_slot_Hotkey_png_601551571;
         this._embed_css_images_slot_container_disabled_png_1466259493 = Tibia__embed_css_images_slot_container_disabled_png_1466259493;
         this._embed_css_images_slot_container_highlighted_png_565818060 = Tibia__embed_css_images_slot_container_highlighted_png_565818060;
         this._embed_css_images_slot_container_png_1920756400 = Tibia__embed_css_images_slot_container_png_1920756400;
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
      
      public static function s_GetCommunication() : Communication
      {
         return (application as Tibia).m_Communication;
      }
      
      public static function s_GetFrameFlash() : Boolean
      {
         return (int(Tibia.s_FrameTibiaTimestamp / 300) & 1) != 0;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Tibia._watcherSetupUtil = param1;
      }
      
      public static function s_GetInputHandler() : InputHandler
      {
         return (application as Tibia).m_UIInputHandler;
      }
      
      public static function s_GetAppearanceStorage() : AppearanceStorage
      {
         return (application as Tibia).m_AppearanceStorage;
      }
      
      public static function s_GetInstance() : Tibia
      {
         return application as Tibia;
      }
      
      public static function s_GetChatStorage() : ChatStorage
      {
         return (application as Tibia).m_ChatStorage;
      }
      
      public static function get s_TibiaTimerFactor() : Number
      {
         return s_InternalTibiaTimerFactor;
      }
      
      public static function s_GetMiniMapStorage() : MiniMapStorage
      {
         return (application as Tibia).m_MiniMapStorage;
      }
      
      public static function s_GetSecondaryTimer() : Timer
      {
         return (application as Tibia).m_SeconaryTimer;
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
      
      public static function set s_TibiaTimerFactor(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            s_LastTibiaFactorChangeTibiaTimestamp = s_GetTibiaTimer();
            s_LastTibiaFactorChangeRealTimestamp = getTimer();
            s_InternalTibiaTimerFactor = param1;
         }
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIChatWidget() : ChatWidget
      {
         return this._883427326m_UIChatWidget;
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
         else if(false && Boolean(this.m_GameClientReady))
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
         if(BuildConstants.MINI_MAP_STORAGE_SAVE_SECTORS)
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
      
      private function onUploadOptionsComplete(param1:Event) : void
      {
         this.m_CurrentOptionsDirty = false;
         this.m_CurrentOptionsLastUpload = getTimer();
         this.m_CurrentOptionsUploading = false;
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
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_A;
         },function(param1:int):void
         {
            m_UISideBarA.location = param1;
         },"m_UISideBarA.location");
         result[0] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_B;
         },function(param1:int):void
         {
            m_UISideBarB.location = param1;
         },"m_UISideBarB.location");
         result[1] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_B;
         },function(param1:*):void
         {
            _Tibia_Array1[0] = param1;
         },"_Tibia_Array1[0]");
         result[2] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_A;
         },function(param1:*):void
         {
            _Tibia_Array1[1] = param1;
         },"_Tibia_Array1[1]");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = BoxDirection.VERTICAL;
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            m_UICenterColumn.direction = param1;
         },"m_UICenterColumn.direction");
         result[4] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_TOP;
         },function(param1:int):void
         {
            m_UIActionBarTop.location = param1;
         },"m_UIActionBarTop.location");
         result[5] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_BOTTOM;
         },function(param1:int):void
         {
            m_UIActionBarBottom.location = param1;
         },"m_UIActionBarBottom.location");
         result[6] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_LEFT;
         },function(param1:int):void
         {
            m_UIActionBarLeft.location = param1;
         },"m_UIActionBarLeft.location");
         result[7] = binding;
         binding = new Binding(this,function():int
         {
            return ActionBarSet.LOCATION_RIGHT;
         },function(param1:int):void
         {
            m_UIActionBarRight.location = param1;
         },"m_UIActionBarRight.location");
         result[8] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_C;
         },function(param1:*):void
         {
            _Tibia_Array2[0] = param1;
         },"_Tibia_Array2[0]");
         result[9] = binding;
         binding = new Binding(this,function():*
         {
            return SideBarSet.LOCATION_D;
         },function(param1:*):void
         {
            _Tibia_Array2[1] = param1;
         },"_Tibia_Array2[1]");
         result[10] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_C;
         },function(param1:int):void
         {
            m_UISideBarC.location = param1;
         },"m_UISideBarC.location");
         result[11] = binding;
         binding = new Binding(this,function():int
         {
            return SideBarSet.LOCATION_D;
         },function(param1:int):void
         {
            m_UISideBarD.location = param1;
         },"m_UISideBarD.location");
         result[12] = binding;
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
            if(!BuildConstants.FOCUS_NOTIFIER_SHOW_ALWAYS && this.m_IsActive == true)
            {
               FocusNotifier.getInstance().hide();
            }
            else
            {
               FocusNotifier.getInstance().show();
            }
         }
      }
      
      public function loginCharacter() : void
      {
         var _loc2_:AccountCharacter = null;
         var _loc3_:* = false;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:URLVariables = null;
         var _loc7_:URLRequest = null;
         if(this.m_Connection == null)
         {
            throw new Error("Tibia.loginCharacter: Invalid state.");
         }
         if(this.m_Connection.isConnected)
         {
            throw new Error("Tibia.loginCharacter: Already connected.");
         }
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
         _loc2_ = this.m_ConnectionDataList[this.m_ConnectionDataCurrent] as AccountCharacter;
         if(_loc2_ == null)
         {
            throw new Error("Tibia.loginCharacter: connection data must be account character.");
         }
         _loc3_ = !this.isValidPreviewStateForClient(_loc2_.worldPreviewState);
         if(_loc3_)
         {
            _loc4_ = URLHelper.s_GetBrowserCurrentBaseUrl();
            _loc5_ = URLHelper.s_GetBrowserCurrentQuerystring();
            _loc6_ = new URLVariables(_loc5_);
            _loc7_ = new URLRequest(_loc4_);
            _loc6_.name = _loc2_.name;
            _loc7_.data = _loc6_;
            navigateToURL(_loc7_,"_self");
            _loc1_ = null;
         }
         else
         {
            _loc1_ = _loc2_;
         }
         if(_loc1_ != null)
         {
            this.m_Connection.connect(_loc1_);
         }
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
         if(this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null)
         {
            _loc2_ = this.m_UIGameWindow.height;
            _loc3_ = this.m_UIChatWidget.height;
            if(!isNaN(this.m_UIGameWindow.minHeight) && Math.abs(_loc2_ - this.m_UIGameWindow.minHeight) < 0.01)
            {
               this.options.generalUIGameWindowHeight = 0;
            }
            else if(!isNaN(this.m_UIChatWidget.minHeight) && Math.abs(_loc3_ - this.m_UIChatWidget.minHeight) < 0.01)
            {
               this.options.generalUIGameWindowHeight = 100;
            }
            else
            {
               this.options.generalUIGameWindowHeight = _loc2_ * 100 / (_loc2_ + _loc3_);
            }
         }
      }
      
      private function _Tibia_Array1_i() : Array
      {
         var _loc1_:Array = [undefined,undefined];
         this._Tibia_Array1 = _loc1_;
         BindingManager.executeBindings(this,"_Tibia_Array1",this._Tibia_Array1);
         return _loc1_;
      }
      
      protected function onPreinitialise(param1:FlexEvent) : void
      {
         this.m_AppearanceStorage = new AppearanceStorage();
         this.m_AppearanceStorage.addEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
         this.m_AppearanceStorage.addEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
         this.m_ChatStorage = new ChatStorage();
         this.m_ChannelsPending = new Vector.<int>();
         this.m_ContainerStorage = new ContainerStorage();
         this.m_CreatureStorage = CreatureStorageFactory.s_CreateCreatureStorage();
         this.m_MiniMapStorage = new MiniMapStorage();
         this.m_Player = this.m_CreatureStorage.player;
         this.m_SpellStorage = new SpellStorage();
         this.m_WorldMapStorage = new WorldMapStorage();
         this.m_Connection = ConnectionFactory.s_CreateServerConnection();
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
         this.m_Communication = new Communication(this.m_Connection,this.m_AppearanceStorage,this.m_ChatStorage,this.m_ContainerStorage,this.m_CreatureStorage,this.m_MiniMapStorage,this.m_Player,this.m_SpellStorage,this.m_WorldMapStorage);
         this.m_SeconaryTimer = new Timer(50);
         this.m_SeconaryTimer.addEventListener(TimerEvent.TIMER,this.onSecondaryTimer);
         this.m_SeconaryTimer.start();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarBottom() : HActionBarWidget
      {
         return this._629924354m_UIActionBarBottom;
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
         if(this.isActive == false || Boolean(BuildConstants.FOCUS_NOTIFIER_SHOW_ALWAYS))
         {
            FocusNotifier.getInstance().captureMouse = true;
            FocusNotifier.getInstance().show();
         }
         if(this.m_UICenterColumn != null && this.m_UICenterColumn.numDividers > 0 && this.m_UICenterColumn.getDividerAt(0) != null)
         {
            this.m_UICenterColumn.getDividerAt(0).doubleClickEnabled = true;
            this.m_UICenterColumn.getDividerAt(0).addEventListener(MouseEvent.DOUBLE_CLICK,this.onGameWindowAutofit);
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
      
      private function updateGameWindowSize() : void
      {
         var _loc1_:Number = NaN;
         if(this.options != null && this.m_UIGameWindow != null && this.m_UIChatWidget != null)
         {
            _loc1_ = this.options.generalUIGameWindowHeight;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIRootContainer() : HBox
      {
         return this._1494180935m_UIRootContainer;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWidget() : WorldMapWidget
      {
         return this._1314206572m_UIWorldMapWidget;
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
            else if(!this.m_Connection.isConnected)
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
         if(this.m_ConnectionDataPending == -1)
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
            this.m_CreatureStorage.options = this.m_Options;
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
            this.m_UIWorldMapWidget.creatureStorage = this.m_CreatureStorage;
            this.m_UIWorldMapWidget.player = this.m_Player;
            this.m_UIWorldMapWidget.worldMapStorage = this.m_WorldMapStorage;
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
         var _loc1_:CharacterSelectionWidget = null;
         var _loc2_:ArrayCollection = null;
         var _loc3_:AccountCharacter = null;
         if(BuildConstants.ENABLE_CHARACTER_CHANGE_DIALOG)
         {
            _loc1_ = new CharacterSelectionWidget();
            _loc2_ = new ArrayCollection();
            for each(_loc3_ in this.m_ConnectionDataList)
            {
               _loc2_.addItem(_loc3_);
            }
            _loc1_.characters = _loc2_;
            _loc1_.selectedCharacterIndex = this.m_ConnectionDataCurrent;
            _loc1_.addEventListener(CloseEvent.CLOSE,this.onCloseChangeCharacter);
            _loc1_.show();
         }
      }
      
      private function _Tibia_Array2_i() : Array
      {
         var _loc1_:Array = [undefined,undefined];
         this._Tibia_Array2 = _loc1_;
         BindingManager.executeBindings(this,"_Tibia_Array2",this._Tibia_Array2);
         return _loc1_;
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
         if(_loc2_ > this.m_SecondaryTimestamp && this.m_Connection != null)
         {
            this.m_Connection.readCommunicationData();
         }
         if(_loc2_ > this.m_CurrentOptionsLastUpload + OPTIONS_SAVE_INTERVAL)
         {
            this.saveOptions();
         }
         this.m_SecondaryTimestamp = _loc2_;
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
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarD() : SideBarWidget
      {
         return this._64278962m_UISideBarD;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarB() : SideBarWidget
      {
         return this._64278964m_UISideBarB;
      }
      
      public function saveOptions() : void
      {
         if(this.m_Options != null)
         {
            this.m_ChatStorage.saveChannels();
            if(this.m_CurrentOptionsAsset != null && !this.m_CurrentOptionsUploading && Boolean(this.m_CurrentOptionsDirty))
            {
               this.m_CurrentOptionsAsset.upload(this.options.marshall());
               this.m_CurrentOptionsUploading = true;
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
      public function get m_UIGameWindow() : GridContainer
      {
         return this._1404294856m_UIGameWindow;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UICenterColumn() : CustomDividedBox
      {
         return this._1356021457m_UICenterColumn;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIInputHandler() : InputHandler
      {
         return this._748017946m_UIInputHandler;
      }
      
      private function onUploadOptionsError(param1:ErrorEvent) : void
      {
         this.m_CurrentOptionsUploading = false;
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
            this.m_Connection.disconnect();
         }
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
      
      public function set m_UIRootContainer(param1:HBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1494180935m_UIRootContainer;
         if(_loc2_ !== param1)
         {
            this._1494180935m_UIRootContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"m_UIRootContainer",_loc2_,param1));
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIStatusWidget() : StatusWidget
      {
         return this._228925540m_UIStatusWidget;
      }
      
      public function setAssetProvider(param1:IAssetProvider) : void
      {
         if(param1 == null)
         {
            throw new Error("Tibia.setAssetProvider: asset provider must not be null.");
         }
         this.m_AssetProvider = param1;
         var _loc2_:OptionsAsset = this.m_AssetProvider.getCurrentOptions();
         var _loc3_:OptionsAsset = this.m_AssetProvider.getDefaultOptions();
         if(this.m_CurrentOptionsAsset != null)
         {
            this.m_CurrentOptionsAsset.removeEventListener(Event.COMPLETE,this.onUploadOptionsComplete);
            this.m_CurrentOptionsAsset.removeEventListener(ErrorEvent.ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(IOErrorEvent.IO_ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadOptionsError);
         }
         this.m_CurrentOptionsAsset = _loc2_;
         this.m_CurrentOptionsDirty = false;
         this.m_CurrentOptionsLastUpload = 0;
         this.m_CurrentOptionsUploading = false;
         if(this.m_CurrentOptionsAsset != null)
         {
            this.m_CurrentOptionsAsset.addEventListener(Event.COMPLETE,this.onUploadOptionsComplete);
            this.m_CurrentOptionsAsset.addEventListener(ErrorEvent.ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.addEventListener(IOErrorEvent.IO_ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadOptionsError);
         }
         this.m_DefaultOptionsAsset = _loc3_;
         if(_loc2_ != null)
         {
            param1.removeAsset(_loc2_);
         }
         if(_loc3_ != null)
         {
            param1.removeAsset(_loc3_);
         }
         this.m_AppearanceStorage.setAssetProvider(param1);
      }
   }
}

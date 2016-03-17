package
{
   import mx.core.Application;
   import mx.binding.IBindingClient;
   import tibia.game.IGameClient;
   import tibia.appearances.AppearanceStorage;
   import mx.binding.IWatcherSetupUtil;
   import tibia.chat.ChatStorage;
   import tibia.input.gameaction.GameActionFactory;
   import tibia.minimap.MiniMapStorage;
   import tibia.options.OptionsStorage;
   import tibia.container.ContainerStorage;
   import tibia.creatures.StatusWidget;
   import tibia.premium.PremiumManager;
   import tibia.help.UIEffectsManager;
   import tibia.creatures.CreatureStorage;
   import tibia.network.Communication;
   import tibia.input.InputHandler;
   import mx.core.mx_internal;
   import loader.asset.IAssetProvider;
   import tibia.magic.SpellStorage;
   import tibia.chat.ChatWidget;
   import tibia.worldmap.WorldMapStorage;
   import tibia.network.IServerConnection;
   import tibia.creatures.Player;
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
   import tibia.network.FailedConnectionRescheduler;
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
      
      protected static const CONNECTION_STATE_GAME:int = 4;
      
      private static const SHAREDOBJECT_NAME:String = "options";
      
      protected static const CONNECTION_STATE_PENDING:int = 3;
      
      public static const PROTOCOL_VERSION:int = 1091;
      
      public static var s_FrameTibiaTimestamp:Number = 0;
      
      public static var s_FrameRealTimestamp:Number = 0;
      
      protected static const ERR_INVALID_SIZE:int = 1;
      
      protected static const ERR_COULD_NOT_CONNECT:int = 5;
      
      public static const MAX_SESSION_KEY_LENGTH:int = 30;
      
      public static const CLIENT_TYPE:uint = 3;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      protected static const PACKETLENGTH_SIZE:int = 2;
      
      private static var s_LastTibiaFactorChangeRealTimestamp:int = 0;
      
      protected static const CHECKSUM_POS:int = PACKETLENGTH_POS + PACKETLENGTH_SIZE;
      
      public static const CLIENT_VERSION:uint = 2203;
      
      public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
      
      protected static const PAYLOADLENGTH_POS:int = PAYLOAD_POS;
      
      protected static const CONNECTION_STATE_DISCONNECTED:int = 0;
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      public static const PREVIEW_STATE_REGULAR:uint = 0;
      
      protected static const ERR_INVALID_CHECKSUM:int = 2;
      
      protected static const HEADER_SIZE:int = PACKETLENGTH_SIZE + CHECKSUM_SIZE;
      
      protected static const ERR_INTERNAL:int = 0;
      
      protected static const CHECKSUM_SIZE:int = 4;
      
      protected static const PAYLOADDATA_POSITION:int = PAYLOADLENGTH_POS + PAYLOADLENGTH_SIZE;
      
      protected static const HEADER_POS:int = 0;
      
      protected static const ERR_INVALID_MESSAGE:int = 3;
      
      public static var s_TibiaLoginTimestamp:Number = 0;
      
      private static const BUNDLE:String = "Tibia";
      
      public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
      
      protected static const ERR_INVALID_STATE:int = 4;
      
      protected static const PAYLOADLENGTH_SIZE:int = 2;
      
      private static var s_InternalTibiaTimerFactor:Number = 1;
      
      public static const CLIENT_PREVIEW_STATE:uint = 0;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
      
      protected static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
      
      protected static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
      
      private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
      
      private static var s_LastTibiaTimestamp:int = 0;
      
      protected static const PACKETLENGTH_POS:int = HEADER_POS;
      
      protected static const PAYLOAD_POS:int = HEADER_POS + HEADER_SIZE;
      
      protected static const ERR_CONNECTION_LOST:int = 6;
       
      private var _embed_css_images_slot_Hotkey_disabled_png_328047912:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_180221809:Class;
      
      private var _embed_css_images_Button_GetPremium_tileable_end_over_png_2033857384:Class;
      
      private var _embed_css_images_Button_Close_over_png_1555772078:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1842064905:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_2081422907:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_348754982:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1847805050:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1549639647:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1731523737:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1312436456:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_896048031:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_18902020:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_437277666:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1718952155:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_943851089:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1762842826:Class;
      
      private var _embed_css_images_Slot_InventoryHead_protected_png_1756647254:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      protected var m_CurrentOptionsUploadErrorDelay:int = 0;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_2053408836:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1201940191:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_633486023:Class;
      
      private var _1020379552m_UITibiaRootContainer:HBox;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_789175116:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_1363473335:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_2126204321:Class;
      
      protected var m_IsActive:Boolean = false;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1028210460:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_940168892:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1148656791:Class;
      
      private var _embed_css_images_Slot_InventoryRing_protected_png_741195866:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_315113812:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_2127136515:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_Button_Close_idle_png_1558559150:Class;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_Icons_CombatControls_PvPOn_idle_png_390385212:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1937434026:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_466285535:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_11105221:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_1314817106:Class;
      
      private var m_TutorialMode:Boolean = false;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_685226079:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_1530215436:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_2002726077:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969080732:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1131374307:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Skull_idle_png_1089874473:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1474513380:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_427931591:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1648869265:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_1935403729:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var m_FailedConnectionRescheduler:FailedConnectionRescheduler;
      
      private var _embed_css_images_Widget_HeaderBG_png_1327672983:Class;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_103810994:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_2116885211:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1680294178:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_246375563:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_2129322287:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1350805226:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_675494494:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_892999400:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_874458703:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_433538397:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_1162617517:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_1323900748:Class;
      
      private var _embed_css_images_slot_Hotkey_highlighted_png_1672730191:Class;
      
      private var m_GameClientReady:Boolean = false;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_876447073:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1683512546:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_1053002922:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_350098398:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1962541744:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_344972638:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_675902635:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_740590596:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_327074322:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_848068831:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_387398292:Class;
      
      private var _embed_css_images_Button_GetPremium_tileable_idle_png_1525597340:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1172642223:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_499913609:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_797157964:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_81764788:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1769214032:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1848782256:Class;
      
      private var _embed_css_images_Icons_CombatControls_PvPOff_idle_png_2101053938:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_687412418:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1622749496:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_slot_container_png_1964890160:Class;
      
      private var _embed_css_images_UnjustifiedPoints_png_1986798067:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1008781239:Class;
      
      private var _embed_css_images_Border02_png_527466878:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1388577979:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1566890454:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1524107147:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1877338279:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Skull_png_978732197:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_717078664:Class;
      
      protected var m_Connection:IServerConnection = null;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_827986955:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Skull_active_over_png_627743436:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_499187900:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_943826593:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_293621907:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_520972117:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1958257769:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_549987542:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1527789016:Class;
      
      private var _embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1360315414:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GetPremium_png_171562253:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_941180119:Class;
      
      private var _embed_css_images_Icons_CombatControls_PvPOn_active_png_806719434:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_protected_png_2079855514:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_264917978:Class;
      
      protected var m_ConnectionDataPending:int = -1;
      
      private var _embed_css_images_Icons_WidgetMenu_GetPremium_active_png_310128867:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_223143292:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_protected_png_145597569:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1104031878:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1156330204:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1464742752:Class;
      
      private var _embed_css_images_BG_Combat_ExpertOff_png_1603672082:Class;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_185739523:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_241047062:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_356757261:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_890479746:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_744570175:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_633980080:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_283858430:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1539779576:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1359953454:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_290593642:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_260737221:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_650470737:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_872860755:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_280323568:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1188845591:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _1568861366m_UIOuterRootContainer:DividedBox;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1905766250:Class;
      
      private var _embed_css_images_slot_Hotkey_protected_png_273131492:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_72272784:Class;
      
      protected var m_CharacterDeath:Boolean = false;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1185332478:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1950670337:Class;
      
      private var _embed_css_images_Button_Gold_tileable_over_png_1825960515:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_protected_png_468579857:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_331667541:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_397261887:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_png_455300793:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_933931629:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_711990793:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Button_Gold_tileable_end_over_png_895554521:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_424865980:Class;
      
      private var _embed_css_images_Slot_InventoryShield_protected_png_1351342493:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1903769194:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_1336650665:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_481434309:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_2087824638:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_538612446:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_988339228:Class;
      
      private var _embed_css_images_Button_MaximizePremium_over_png_671123473:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1945977898:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_746194961:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1133892302:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_2011993741:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_879956648:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1768914879:Class;
      
      protected var m_PremiumManager:PremiumManager = null;
      
      private var _embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_1248642279:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_36232660:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_940561890:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1830624963:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1459481774:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_77113056:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_793504721:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_703297458:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1001272989:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_415252500:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_546778138:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1392893264:Class;
      
      private var _embed_css_images_Icons_IngameShop_12x12_Yes_png_818524323:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_2011290243:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_705413059:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_protected_png_789064941:Class;
      
      private var _embed_css_images_Inventory_png_52752698:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1279799667:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_423911731:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_886566148:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_454035092:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1878285044:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1719503291:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_81869280:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1472473604:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_532658428:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1091428029:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_876869471:Class;
      
      private var _embed_css_images_Icons_CombatControls_ExpertMode_over_png_1012488982:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1793955830:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1196375074:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_213221908:Class;
      
      private var _embed_css_images_Minimap_png_785473:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_48118726:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_270641536:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_914547418:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1499527831:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_1163251850:Class;
      
      private var _embed_css_images_Button_GetPremium_tileable_end_pressed_png_2133153192:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2064716473:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_879954339:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_protected_png_512395256:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1153970022:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_1331972614:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_509275642:Class;
      
      protected var m_AssetProvider:IAssetProvider = null;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1336877592:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1261412108:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1334865731:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_411654051:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_191894857:Class;
      
      private var _embed_css_images_BarsXP_default__png_788541695:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_464177414:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_254456619:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Button_Gold_tileable_end_pressed_png_1935068423:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1069877355:Class;
      
      private var _embed_css_images_Button_Gold_tileable_pressed_png_432493875:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1531299863:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_398195534:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_85726699:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_936013338:Class;
      
      private var _embed_css_images_BG_Combat_ExpertOn_png_1657403366:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_68025270:Class;
      
      private var _embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_1163346894:Class;
      
      private var _embed_css_images_Button_GetPremium_tileable_over_png_245646748:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1712565123:Class;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_2129207077:Class;
      
      private var _embed_css_images_BarsXP_default_improved_png_1273996555:Class;
      
      private var m_ForceDisableGameWindowSizeCalc:Boolean = false;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_BuySellTab_idle_png_1010423552:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_152196415:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1197366039:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_1042231999:Class;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_549726467:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_367163416:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_2081524447:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1103691743:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1201010896:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_411919428:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1858137652:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_913526320:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1562895614:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1339651651:Class;
      
      private var _embed_css_images_Button_Close_disabled_png_1118288086:Class;
      
      private var _embed_css_images_Button_GetPremium_tileable_end_idle_png_1520127384:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_924507458:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      protected var m_UIEffectsManager:UIEffectsManager = null;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_1000775821:Class;
      
      private var _embed_css_images_Icons_CombatControls_PvPOff_active_png_467699456:Class;
      
      protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_623212943:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_428106483:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1094240707:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_1049197118:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_217141926:Class;
      
      private var _embed_css_images_Button_MaximizePremium_idle_png_1875046639:Class;
      
      private var _embed_css_images_Border02_corners_png_1673325085:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_267963012:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_797275565:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_2134979987:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_47184100:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_208023479:Class;
      
      private var _967396880m_UIBottomContainer:HBox;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_1330451863:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_2109550690:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Skull_active_png_1606318759:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1020534378:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_957247991:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_protected_png_119582134:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1282219839:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_855234445:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_435817719:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1952490392:Class;
      
      private var _embed_css_images_Icons_IngameShop_12x12_No_png_94139345:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1742148591:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_745897038:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1262632815:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_606887153:Class;
      
      protected var m_ConnectionDataCurrent:int = -1;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_863153825:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_274945336:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1482936695:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_1360884817:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_1602584837:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_2126670914:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1368844826:Class;
      
      private var _embed_css_images_Button_Gold_tileable_end_idle_png_1085124313:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_187785477:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_448791725:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1812298053:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1134628971:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1206896143:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_57887198:Class;
      
      private var _embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1673572087:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_201146697:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_984588449:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1235894772:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_424851315:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_1868150783:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_1529140760:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_IngameShop_over_png_1642732481:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_protected_png_1661656368:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1900728113:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1619533435:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1383055279:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1274741422:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_432180981:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1268192410:Class;
      
      private var _embed_css_images_Button_Gold_tileable_idle_png_1582727357:Class;
      
      protected var m_TutorialData:Object;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Button_Close_pressed_png_897436098:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_1723688216:Class;
      
      private var _embed_css_images_Border_Widget_png_211481153:Class;
      
      private var _embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_387592183:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1796121550:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1644395072:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1718017678:Class;
      
      private var _embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_741393817:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1921285842:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1683957929:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_IngameShop_active_png_1595134287:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1467056953:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1126898707:Class;
      
      private var _embed_css_images_Slot_Statusicon_png_1541563210:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1780390178:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1638734069:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_508822163:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_187902844:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_422360539:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1656561664:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558541654:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_26416799:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_921990245:Class;
      
      protected var m_Communication:Communication = null;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_775702812:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_9462687:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1159793621:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_872199881:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_153545550:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_222222499:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_944807540:Class;
      
      private var _embed_css_images_slot_Hotkey_png_481997235:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_742018340:Class;
      
      private var m_GameActionFactory:GameActionFactory = null;
      
      protected var m_ChannelsPending:Vector.<int> = null;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_140374463:Class;
      
      private var m_ConnectionLostDialog:ConnectionLostWidget;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_2027039652:Class;
      
      private var _embed_css_images_Button_GetPremium_tileable_pressed_png_325362004:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1658851537:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_638240058:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_242655161:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1061097149:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1400708522:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_505191107:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_462550413:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_787239043:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_473898549:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1453021264:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1202355341:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_899379052:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_296304785:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_483339713:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_10219229:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_2067593741:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1855903266:Class;
      
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
         this.m_FailedConnectionRescheduler = new FailedConnectionRescheduler();
         this._embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_741393817 = Tibia__embed_css_____assets_images_ingameshop_Icons_IngameShop_12x12_TibiaCoin_png_741393817;
         this._embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_1248642279 = Tibia__embed_css_____assets_images_ingameshop_Icons_IngameShop_32x14_TransferCoins_png_1248642279;
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_703297458 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_703297458;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_398195534 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_398195534;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_745897038 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_745897038;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1796121550 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1796121550;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_1000775821 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_1000775821;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1524107147 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1524107147;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_246375563 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_246375563;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1718952155 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1718952155;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1206896143 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1206896143;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_606887153 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_606887153;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_943851089 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_943851089;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_1472473604 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1472473604;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_1323900748 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_1323900748;
         this._embed_css_images_Arrow_ScrollTabs_over_png_797157964 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_797157964;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_47184100 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_47184100;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1644395072 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1644395072;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_744570175 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_744570175;
         this._embed_css_images_Arrow_WidgetToggle_over_png_397261887 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_397261887;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_9462687 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_9462687;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1133892302 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1133892302;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1131374307 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1131374307;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_984588449 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_984588449;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1196375074 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1196375074;
         this._embed_css_images_BG_Bars_compact_tileable_png_1842064905 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1842064905;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1900728113 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1900728113;
         this._embed_css_images_BG_Bars_default_enpiece_png_532658428 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_532658428;
         this._embed_css_images_BG_Bars_default_tileable_png_675902635 = Tibia__embed_css_images_BG_Bars_default_tileable_png_675902635;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_872199881 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_872199881;
         this._embed_css_images_BG_Bars_fat_enpiece_png_187902844 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_187902844;
         this._embed_css_images_BG_Bars_fat_tileable_png_1830624963 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1830624963;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1658851537 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1658851537;
         this._embed_css_images_BG_BohemianTileable_Game_png_213221908 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_213221908;
         this._embed_css_images_BG_BohemianTileable_png_2129322287 = Tibia__embed_css_images_BG_BohemianTileable_png_2129322287;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_274945336 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_274945336;
         this._embed_css_images_BG_ChatTab_tileable_png_2087824638 = Tibia__embed_css_images_BG_ChatTab_tileable_png_2087824638;
         this._embed_css_images_BG_Combat_ExpertOff_png_1603672082 = Tibia__embed_css_images_BG_Combat_ExpertOff_png_1603672082;
         this._embed_css_images_BG_Combat_ExpertOn_png_1657403366 = Tibia__embed_css_images_BG_Combat_ExpertOn_png_1657403366;
         this._embed_css_images_BG_Stone2_Tileable_png_1201010896 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1201010896;
         this._embed_css_images_BG_Widget_Menu_png_913526320 = Tibia__embed_css_images_BG_Widget_Menu_png_913526320;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_10219229 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_10219229;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_290593642 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_290593642;
         this._embed_css_images_BarsHealth_compact_Mana_png_1769214032 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1769214032;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1383055279 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1383055279;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_270641536 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_270641536;
         this._embed_css_images_BarsHealth_compact_RedLow_png_223143292 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_223143292;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1279799667 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1279799667;
         this._embed_css_images_BarsHealth_default_GreenFull_png_140374463 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_140374463;
         this._embed_css_images_BarsHealth_default_GreenLow_png_944807540 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_944807540;
         this._embed_css_images_BarsHealth_default_Mana_png_1274741422 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1274741422;
         this._embed_css_images_BarsHealth_default_RedFull_png_874458703 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_874458703;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1185332478 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1185332478;
         this._embed_css_images_BarsHealth_default_RedLow_png_2109550690 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_2109550690;
         this._embed_css_images_BarsHealth_default_Yellow_png_793504721 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_793504721;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_941180119 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_941180119;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_499187900 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_499187900;
         this._embed_css_images_BarsHealth_fat_Mana_png_1566890454 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1566890454;
         this._embed_css_images_BarsHealth_fat_RedFull_png_1330451863 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1330451863;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1847805050 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1847805050;
         this._embed_css_images_BarsHealth_fat_RedLow_png_1163251850 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_1163251850;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1467056953 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1467056953;
         this._embed_css_images_BarsXP_default__png_788541695 = Tibia__embed_css_images_BarsXP_default__png_788541695;
         this._embed_css_images_BarsXP_default_improved_png_1273996555 = Tibia__embed_css_images_BarsXP_default_improved_png_1273996555;
         this._embed_css_images_Bars_ProgressMarker_png_1962541744 = Tibia__embed_css_images_Bars_ProgressMarker_png_1962541744;
         this._embed_css_images_Border02_WidgetSidebar_png_455300793 = Tibia__embed_css_images_Border02_WidgetSidebar_png_455300793;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_1360884817 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_1360884817;
         this._embed_css_images_Border02_corners_png_1673325085 = Tibia__embed_css_images_Border02_corners_png_1673325085;
         this._embed_css_images_Border02_png_527466878 = Tibia__embed_css_images_Border02_png_527466878;
         this._embed_css_images_Border_Widget_corner_png_356757261 = Tibia__embed_css_images_Border_Widget_corner_png_356757261;
         this._embed_css_images_Border_Widget_png_211481153 = Tibia__embed_css_images_Border_Widget_png_211481153;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_432180981 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_432180981;
         this._embed_css_images_Button_ChatTabIgnore_over_png_827986955 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_827986955;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_11105221 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_11105221;
         this._embed_css_images_Button_ChatTabNew_idle_png_1202355341 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1202355341;
         this._embed_css_images_Button_ChatTabNew_over_png_462550413 = Tibia__embed_css_images_Button_ChatTabNew_over_png_462550413;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1126898707 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1126898707;
         this._embed_css_images_Button_ChatTab_Close_idle_png_1530215436 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1530215436;
         this._embed_css_images_Button_ChatTab_Close_over_png_1878285044 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1878285044;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1028210460 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1028210460;
         this._embed_css_images_Button_Close_disabled_png_1118288086 = Tibia__embed_css_images_Button_Close_disabled_png_1118288086;
         this._embed_css_images_Button_Close_idle_png_1558559150 = Tibia__embed_css_images_Button_Close_idle_png_1558559150;
         this._embed_css_images_Button_Close_over_png_1555772078 = Tibia__embed_css_images_Button_Close_over_png_1555772078;
         this._embed_css_images_Button_Close_pressed_png_897436098 = Tibia__embed_css_images_Button_Close_pressed_png_897436098;
         this._embed_css_images_Button_Combat_Stop_idle_png_2067593741 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_2067593741;
         this._embed_css_images_Button_Combat_Stop_over_png_428106483 = Tibia__embed_css_images_Button_Combat_Stop_over_png_428106483;
         this._embed_css_images_Button_Combat_Stop_pressed_png_2134979987 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_2134979987;
         this._embed_css_images_Button_ContainerUp_idle_png_675494494 = Tibia__embed_css_images_Button_ContainerUp_idle_png_675494494;
         this._embed_css_images_Button_ContainerUp_over_png_344972638 = Tibia__embed_css_images_Button_ContainerUp_over_png_344972638;
         this._embed_css_images_Button_ContainerUp_pressed_png_437277666 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_437277666;
         this._embed_css_images_Button_GetPremium_tileable_end_idle_png_1520127384 = Tibia__embed_css_images_Button_GetPremium_tileable_end_idle_png_1520127384;
         this._embed_css_images_Button_GetPremium_tileable_end_over_png_2033857384 = Tibia__embed_css_images_Button_GetPremium_tileable_end_over_png_2033857384;
         this._embed_css_images_Button_GetPremium_tileable_end_pressed_png_2133153192 = Tibia__embed_css_images_Button_GetPremium_tileable_end_pressed_png_2133153192;
         this._embed_css_images_Button_GetPremium_tileable_idle_png_1525597340 = Tibia__embed_css_images_Button_GetPremium_tileable_idle_png_1525597340;
         this._embed_css_images_Button_GetPremium_tileable_over_png_245646748 = Tibia__embed_css_images_Button_GetPremium_tileable_over_png_245646748;
         this._embed_css_images_Button_GetPremium_tileable_pressed_png_325362004 = Tibia__embed_css_images_Button_GetPremium_tileable_pressed_png_325362004;
         this._embed_css_images_Button_Gold_tileable_end_idle_png_1085124313 = Tibia__embed_css_images_Button_Gold_tileable_end_idle_png_1085124313;
         this._embed_css_images_Button_Gold_tileable_end_over_png_895554521 = Tibia__embed_css_images_Button_Gold_tileable_end_over_png_895554521;
         this._embed_css_images_Button_Gold_tileable_end_pressed_png_1935068423 = Tibia__embed_css_images_Button_Gold_tileable_end_pressed_png_1935068423;
         this._embed_css_images_Button_Gold_tileable_idle_png_1582727357 = Tibia__embed_css_images_Button_Gold_tileable_idle_png_1582727357;
         this._embed_css_images_Button_Gold_tileable_over_png_1825960515 = Tibia__embed_css_images_Button_Gold_tileable_over_png_1825960515;
         this._embed_css_images_Button_Gold_tileable_pressed_png_432493875 = Tibia__embed_css_images_Button_Gold_tileable_pressed_png_432493875;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_222222499 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_222222499;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_411654051 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_411654051;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_464177414 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_464177414;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_1331972614 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_1331972614;
         this._embed_css_images_Button_MaximizePremium_idle_png_1875046639 = Tibia__embed_css_images_Button_MaximizePremium_idle_png_1875046639;
         this._embed_css_images_Button_MaximizePremium_over_png_671123473 = Tibia__embed_css_images_Button_MaximizePremium_over_png_671123473;
         this._embed_css_images_Button_Maximize_idle_png_348754982 = Tibia__embed_css_images_Button_Maximize_idle_png_348754982;
         this._embed_css_images_Button_Maximize_over_png_914547418 = Tibia__embed_css_images_Button_Maximize_over_png_914547418;
         this._embed_css_images_Button_Maximize_pressed_png_546778138 = Tibia__embed_css_images_Button_Maximize_pressed_png_546778138;
         this._embed_css_images_Button_Minimize_idle_png_1723688216 = Tibia__embed_css_images_Button_Minimize_idle_png_1723688216;
         this._embed_css_images_Button_Minimize_over_png_1529140760 = Tibia__embed_css_images_Button_Minimize_over_png_1529140760;
         this._embed_css_images_Button_Minimize_pressed_png_1622749496 = Tibia__embed_css_images_Button_Minimize_pressed_png_1622749496;
         this._embed_css_images_Button_Standard_tileable_disabled_png_717078664 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_717078664;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1156330204 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1156330204;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_254456619 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_254456619;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1339651651 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1339651651;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_2002726077 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_2002726077;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_508822163 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_508822163;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_988339228 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_988339228;
         this._embed_css_images_Button_Standard_tileable_end_over_png_775702812 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_775702812;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_36232660 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_36232660;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_2081524447 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_2081524447;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_466285535 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_466285535;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_483339713 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_483339713;
         this._embed_css_images_Button_Standard_tileable_idle_png_77113056 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_77113056;
         this._embed_css_images_Button_Standard_tileable_over_png_81869280 = Tibia__embed_css_images_Button_Standard_tileable_over_png_81869280;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1453021264 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1453021264;
         this._embed_css_images_BuySellTab_active_png_1459481774 = Tibia__embed_css_images_BuySellTab_active_png_1459481774;
         this._embed_css_images_BuySellTab_idle_png_1010423552 = Tibia__embed_css_images_BuySellTab_idle_png_1010423552;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969080732 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_969080732;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1188845591 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1188845591;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1499527831 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1499527831;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1268192410 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1268192410;
         this._embed_css_images_ChatTab_tileable_idle_png_1162617517 = Tibia__embed_css_images_ChatTab_tileable_idle_png_1162617517;
         this._embed_css_images_ChatTab_tileable_png_1350805226 = Tibia__embed_css_images_ChatTab_tileable_png_1350805226;
         this._embed_css_images_ChatWindow_Mover_png_1793955830 = Tibia__embed_css_images_ChatWindow_Mover_png_1793955830;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_435817719 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_435817719;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1104031878 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1104031878;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1235894772 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1235894772;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1261412108 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1261412108;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_72272784 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_72272784;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_2011290243 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_2011290243;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1719503291 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1719503291;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1388577979 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1388577979;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1153970022 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1153970022;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1094240707 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1094240707;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_180221809 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_180221809;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_623212943 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_623212943;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_940168892 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_940168892;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1482936695 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1482936695;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_427931591 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_427931591;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_633486023 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_633486023;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_943826593 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_943826593;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_2126670914 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_2126670914;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_789175116 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_789175116;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_81764788 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_81764788;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_896048031 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_896048031;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_26416799 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_26416799;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2064716473 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2064716473;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_242655161 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_242655161;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1712565123 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1712565123;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1069877355 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1069877355;
         this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_367163416 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_367163416;
         this._embed_css_images_Icons_CombatControls_DoveOff_over_png_892999400 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_892999400;
         this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_1400708522 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_1400708522;
         this._embed_css_images_Icons_CombatControls_DoveOn_over_png_1053002922 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_1053002922;
         this._embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_387592183 = Tibia__embed_css_images_Icons_CombatControls_ExpertModeOn_idle_png_387592183;
         this._embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1673572087 = Tibia__embed_css_images_Icons_CombatControls_ExpertModeOn_over_png_1673572087;
         this._embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_1163346894 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_disabled_png_1163346894;
         this._embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1360315414 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_idle_png_1360315414;
         this._embed_css_images_Icons_CombatControls_ExpertMode_over_png_1012488982 = Tibia__embed_css_images_Icons_CombatControls_ExpertMode_over_png_1012488982;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_855234445 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_855234445;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_424851315 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_424851315;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1549639647 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1549639647;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1201940191 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1201940191;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_331667541 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_331667541;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_520972117 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_520972117;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_863153825 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_863153825;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_2126204321 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_2126204321;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_296304785 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_296304785;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1648869265 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1648869265;
         this._embed_css_images_Icons_CombatControls_PvPOff_active_png_467699456 = Tibia__embed_css_images_Icons_CombatControls_PvPOff_active_png_467699456;
         this._embed_css_images_Icons_CombatControls_PvPOff_idle_png_2101053938 = Tibia__embed_css_images_Icons_CombatControls_PvPOff_idle_png_2101053938;
         this._embed_css_images_Icons_CombatControls_PvPOn_active_png_806719434 = Tibia__embed_css_images_Icons_CombatControls_PvPOn_active_png_806719434;
         this._embed_css_images_Icons_CombatControls_PvPOn_idle_png_390385212 = Tibia__embed_css_images_Icons_CombatControls_PvPOn_idle_png_390385212;
         this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1683957929 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1683957929;
         this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_1336650665 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_1336650665;
         this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_201146697 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_201146697;
         this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_208023479 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_208023479;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1945977898 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1945977898;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_549987542 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_549987542;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1683512546 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1683512546;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_940561890 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_940561890;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_18902020 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_18902020;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_886566148 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_886566148;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1020534378 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1020534378;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1905766250 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1905766250;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1103691743 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1103691743;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_848068831 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_848068831;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1172642223 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1172642223;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_650470737 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_650470737;
         this._embed_css_images_Icons_Conditions_Bleeding_png_315113812 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_315113812;
         this._embed_css_images_Icons_Conditions_Burning_png_876447073 = Tibia__embed_css_images_Icons_Conditions_Burning_png_876447073;
         this._embed_css_images_Icons_Conditions_Cursed_png_153545550 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_153545550;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1474513380 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1474513380;
         this._embed_css_images_Icons_Conditions_Drowning_png_68025270 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_68025270;
         this._embed_css_images_Icons_Conditions_Drunk_png_103810994 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_103810994;
         this._embed_css_images_Icons_Conditions_Electrified_png_1368844826 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1368844826;
         this._embed_css_images_Icons_Conditions_Freezing_png_1656561664 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1656561664;
         this._embed_css_images_Icons_Conditions_Haste_png_711990793 = Tibia__embed_css_images_Icons_Conditions_Haste_png_711990793;
         this._embed_css_images_Icons_Conditions_Hungry_png_957247991 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_957247991;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_746194961 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_746194961;
         this._embed_css_images_Icons_Conditions_MagicShield_png_415252500 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_415252500;
         this._embed_css_images_Icons_Conditions_PZ_png_1762842826 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1762842826;
         this._embed_css_images_Icons_Conditions_PZlock_png_1282219839 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1282219839;
         this._embed_css_images_Icons_Conditions_Poisoned_png_2011993741 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_2011993741;
         this._embed_css_images_Icons_Conditions_Slowed_png_267963012 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_267963012;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1091428029 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1091428029;
         this._embed_css_images_Icons_IngameShop_12x12_No_png_94139345 = Tibia__embed_css_images_Icons_IngameShop_12x12_No_png_94139345;
         this._embed_css_images_Icons_IngameShop_12x12_Yes_png_818524323 = Tibia__embed_css_images_Icons_IngameShop_12x12_Yes_png_818524323;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_185739523 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_185739523;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1742148591 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1742148591;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_2129207077 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_2129207077;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1877338279 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1877338279;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_1314817106 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_1314817106;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_293621907 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_293621907;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_549726467 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_549726467;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_879954339 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_879954339;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_890479746 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_890479746;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_423911731 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_423911731;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1638734069 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1638734069;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_433538397 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_433538397;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_742018340 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_742018340;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_327074322 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_327074322;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1197366039 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1197366039;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1531299863 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1531299863;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1008781239 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1008781239;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_538612446 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_538612446;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_350098398 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_350098398;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1921285842 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1921285842;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1312436456 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1312436456;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_241047062 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_241047062;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_217141926 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_217141926;
         this._embed_css_images_Icons_WidgetHeaders_GetPremium_png_171562253 = Tibia__embed_css_images_Icons_WidgetHeaders_GetPremium_png_171562253;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_2027039652 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_2027039652;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_2127136515 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_2127136515;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1359953454 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1359953454;
         this._embed_css_images_Icons_WidgetHeaders_Skull_png_978732197 = Tibia__embed_css_images_Icons_WidgetHeaders_Skull_png_978732197;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_787239043 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_787239043;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_152196415 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_152196415;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_705413059 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_705413059;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_187785477 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_187785477;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_1336877592 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_1336877592;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_191894857 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_191894857;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_638240058 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_638240058;
         this._embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_872860755 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_active_over_png_872860755;
         this._embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558541654 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_active_png_1558541654;
         this._embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1952490392 = Tibia__embed_css_images_Icons_WidgetMenu_Blessings_idle_png_1952490392;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1001272989 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1001272989;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_264917978 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_264917978;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1134628971 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1134628971;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1539779576 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1539779576;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1950670337 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1950670337;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_387398292 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_387398292;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_933931629 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_933931629;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1937434026 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1937434026;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_85726699 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_85726699;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_879956648 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_879956648;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1731523737 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1731523737;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1903769194 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1903769194;
         this._embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_280323568 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_active_over_png_280323568;
         this._embed_css_images_Icons_WidgetMenu_GetPremium_active_png_310128867 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_active_png_310128867;
         this._embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_2116885211 = Tibia__embed_css_images_Icons_WidgetMenu_GetPremium_idle_png_2116885211;
         this._embed_css_images_Icons_WidgetMenu_IngameShop_active_png_1595134287 = Tibia__embed_css_images_Icons_WidgetMenu_IngameShop_active_png_1595134287;
         this._embed_css_images_Icons_WidgetMenu_IngameShop_over_png_1642732481 = Tibia__embed_css_images_Icons_WidgetMenu_IngameShop_over_png_1642732481;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1334865731 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1334865731;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_509275642 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_509275642;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1619533435 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1619533435;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1527789016 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1527789016;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_454035092 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_454035092;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_876869471 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_876869471;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1855903266 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1855903266;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_685226079 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_685226079;
         this._embed_css_images_Icons_WidgetMenu_Skull_active_over_png_627743436 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_active_over_png_627743436;
         this._embed_css_images_Icons_WidgetMenu_Skull_active_png_1606318759 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_active_png_1606318759;
         this._embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_48118726 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_idle_over_png_48118726;
         this._embed_css_images_Icons_WidgetMenu_Skull_idle_png_1089874473 = Tibia__embed_css_images_Icons_WidgetMenu_Skull_idle_png_1089874473;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1718017678 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1718017678;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1262632815 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1262632815;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_633980080 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_633980080;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1061097149 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1061097149;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_924507458 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_924507458;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_921990245 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_921990245;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_411919428 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_411919428;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_499913609 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_499913609;
         this._embed_css_images_Inventory_png_52752698 = Tibia__embed_css_images_Inventory_png_52752698;
         this._embed_css_images_Minimap_Center_active_png_1464742752 = Tibia__embed_css_images_Minimap_Center_active_png_1464742752;
         this._embed_css_images_Minimap_Center_idle_png_1680294178 = Tibia__embed_css_images_Minimap_Center_idle_png_1680294178;
         this._embed_css_images_Minimap_Center_over_png_57887198 = Tibia__embed_css_images_Minimap_Center_over_png_57887198;
         this._embed_css_images_Minimap_ZoomIn_idle_png_260737221 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_260737221;
         this._embed_css_images_Minimap_ZoomIn_over_png_2081422907 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_2081422907;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1159793621 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1159793621;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1562895614 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1562895614;
         this._embed_css_images_Minimap_ZoomOut_over_png_283858430 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_283858430;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_687412418 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_687412418;
         this._embed_css_images_Minimap_png_785473 = Tibia__embed_css_images_Minimap_png_785473;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_424865980 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_424865980;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_2053408836 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_2053408836;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1858137652 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1858137652;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_448791725 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_448791725;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_797275565 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_797275565;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_505191107 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_505191107;
         this._embed_css_images_Scrollbar_Handler_png_481434309 = Tibia__embed_css_images_Scrollbar_Handler_png_481434309;
         this._embed_css_images_Scrollbar_tileable_png_1935403729 = Tibia__embed_css_images_Scrollbar_tileable_png_1935403729;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_1363473335 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1363473335;
         this._embed_css_images_Slot_InventoryAmmo_png_1148656791 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1148656791;
         this._embed_css_images_Slot_InventoryAmmo_protected_png_512395256 = Tibia__embed_css_images_Slot_InventoryAmmo_protected_png_512395256;
         this._embed_css_images_Slot_InventoryArmor_png_1780390178 = Tibia__embed_css_images_Slot_InventoryArmor_png_1780390178;
         this._embed_css_images_Slot_InventoryArmor_protected_png_789064941 = Tibia__embed_css_images_Slot_InventoryArmor_protected_png_789064941;
         this._embed_css_images_Slot_InventoryBackpack_png_1602584837 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1602584837;
         this._embed_css_images_Slot_InventoryBackpack_protected_png_119582134 = Tibia__embed_css_images_Slot_InventoryBackpack_protected_png_119582134;
         this._embed_css_images_Slot_InventoryBoots_png_1392893264 = Tibia__embed_css_images_Slot_InventoryBoots_png_1392893264;
         this._embed_css_images_Slot_InventoryBoots_protected_png_468579857 = Tibia__embed_css_images_Slot_InventoryBoots_protected_png_468579857;
         this._embed_css_images_Slot_InventoryHead_png_422360539 = Tibia__embed_css_images_Slot_InventoryHead_png_422360539;
         this._embed_css_images_Slot_InventoryHead_protected_png_1756647254 = Tibia__embed_css_images_Slot_InventoryHead_protected_png_1756647254;
         this._embed_css_images_Slot_InventoryLegs_png_1848782256 = Tibia__embed_css_images_Slot_InventoryLegs_png_1848782256;
         this._embed_css_images_Slot_InventoryLegs_protected_png_145597569 = Tibia__embed_css_images_Slot_InventoryLegs_protected_png_145597569;
         this._embed_css_images_Slot_InventoryNecklace_png_1868150783 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1868150783;
         this._embed_css_images_Slot_InventoryNecklace_protected_png_1661656368 = Tibia__embed_css_images_Slot_InventoryNecklace_protected_png_1661656368;
         this._embed_css_images_Slot_InventoryRing_png_473898549 = Tibia__embed_css_images_Slot_InventoryRing_png_473898549;
         this._embed_css_images_Slot_InventoryRing_protected_png_741195866 = Tibia__embed_css_images_Slot_InventoryRing_protected_png_741195866;
         this._embed_css_images_Slot_InventoryShield_png_740590596 = Tibia__embed_css_images_Slot_InventoryShield_png_740590596;
         this._embed_css_images_Slot_InventoryShield_protected_png_1351342493 = Tibia__embed_css_images_Slot_InventoryShield_protected_png_1351342493;
         this._embed_css_images_Slot_InventoryWeapon_png_1958257769 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1958257769;
         this._embed_css_images_Slot_InventoryWeapon_protected_png_2079855514 = Tibia__embed_css_images_Slot_InventoryWeapon_protected_png_2079855514;
         this._embed_css_images_Slot_Statusicon_highlighted_png_936013338 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_936013338;
         this._embed_css_images_Slot_Statusicon_png_1541563210 = Tibia__embed_css_images_Slot_Statusicon_png_1541563210;
         this._embed_css_images_UnjustifiedPoints_png_1986798067 = Tibia__embed_css_images_UnjustifiedPoints_png_1986798067;
         this._embed_css_images_Widget_Footer_tileable_end01_png_1049197118 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_1049197118;
         this._embed_css_images_Widget_Footer_tileable_end02_png_1042231999 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_1042231999;
         this._embed_css_images_Widget_Footer_tileable_png_1768914879 = Tibia__embed_css_images_Widget_Footer_tileable_png_1768914879;
         this._embed_css_images_Widget_HeaderBG_png_1327672983 = Tibia__embed_css_images_Widget_HeaderBG_png_1327672983;
         this._embed_css_images_slot_Hotkey_disabled_png_328047912 = Tibia__embed_css_images_slot_Hotkey_disabled_png_328047912;
         this._embed_css_images_slot_Hotkey_highlighted_png_1672730191 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_1672730191;
         this._embed_css_images_slot_Hotkey_png_481997235 = Tibia__embed_css_images_slot_Hotkey_png_481997235;
         this._embed_css_images_slot_Hotkey_protected_png_273131492 = Tibia__embed_css_images_slot_Hotkey_protected_png_273131492;
         this._embed_css_images_slot_container_disabled_png_1812298053 = Tibia__embed_css_images_slot_container_disabled_png_1812298053;
         this._embed_css_images_slot_container_highlighted_png_899379052 = Tibia__embed_css_images_slot_container_highlighted_png_899379052;
         this._embed_css_images_slot_container_png_1964890160 = Tibia__embed_css_images_slot_container_png_1964890160;
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
      
      public static function s_GetSecondaryTimer() : Timer
      {
         return (application as Tibia).m_SeconaryTimer;
      }
      
      public static function get s_GameActionFactory() : GameActionFactory
      {
         return (application as Tibia).m_GameActionFactory;
      }
      
      public static function s_GetMiniMapStorage() : MiniMapStorage
      {
         return (application as Tibia).m_MiniMapStorage;
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
      
      public static function s_GetStatusWidget() : StatusWidget
      {
         return (application as Tibia).m_UIStatusWidget;
      }
      
      public static function s_GetPremiumManager() : PremiumManager
      {
         return (application as Tibia).m_PremiumManager;
      }
      
      public static function s_GetUIEffectsManager() : UIEffectsManager
      {
         return (application as Tibia).m_UIEffectsManager;
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
      
      public static function set s_GameActionFactory(param1:GameActionFactory) : void
      {
         (application as Tibia).m_GameActionFactory = param1;
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
      
      public static function s_GetAssetProvider() : IAssetProvider
      {
         return (application as Tibia).m_AssetProvider;
      }
      
      public static function get s_TibiaTimerFactor() : Number
      {
         return s_InternalTibiaTimerFactor;
      }
      
      public static function s_GetSpellStorage() : SpellStorage
      {
         return (application as Tibia).m_SpellStorage;
      }
      
      public static function s_GetOptions() : OptionsStorage
      {
         return (application as Tibia).m_Options;
      }
      
      public static function s_GetChatWidget() : ChatWidget
      {
         return (application as Tibia).m_UIChatWidget;
      }
      
      public static function s_GetWorldMapStorage() : WorldMapStorage
      {
         return (application as Tibia).m_WorldMapStorage;
      }
      
      public static function s_GetConnection() : IServerConnection
      {
         return (application as Tibia).m_Connection;
      }
      
      public static function s_GetPlayer() : Player
      {
         return (application as Tibia).m_Player;
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
      
      public static function s_GetSessionKey() : String
      {
         return (application as Tibia).m_SessionKey;
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
         if(param1.data != null && this.m_Player.name == null)
         {
            this.m_Player.name = param1.data as String;
         }
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
         this.m_FailedConnectionRescheduler.reset();
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
            this.m_FailedConnectionRescheduler.reset();
         }
         if(this.m_Communication != null)
         {
            this.m_Communication.disconnect(false);
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
            this.updateGameWindowSize();
         }
         if(param1.property == "*")
         {
            this.updateCombatTactics();
         }
         this.m_CurrentOptionsDirty = true;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
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
            this.m_Options.combatSecureMode = OptionsStorage.COMBAT_SECURE_ON;
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
         this.m_FailedConnectionRescheduler.reset();
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
      
      private function onConnectionError(param1:ConnectionEvent) : void
      {
         if(param1.errorType == ERR_COULD_NOT_CONNECT && Boolean(this.m_FailedConnectionRescheduler.shouldAttemptReconnect()))
         {
            this.onConnectionLoginWait(this.m_FailedConnectionRescheduler.buildEventForReconnectionAndIncreaseRetries());
            return;
         }
         this.m_FailedConnectionRescheduler.reset();
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
         this.m_PremiumManager = new PremiumManager(this.m_Player);
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
      public function get m_UISideBarD() : SideBarWidget
      {
         return this._64278962m_UISideBarD;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarB() : SideBarWidget
      {
         return this._64278964m_UISideBarB;
      }
      
      private function onConnectionDeath(param1:ConnectionEvent) : void
      {
         visible = true;
         this.m_CharacterDeath = true;
         var _loc2_:Object = param1.data is Object?param1.data as Object:{
            "type":ConnectionEvent.DEATH_REGULAR,
            "fairFightFactor":0
         };
         var _loc3_:MessageWidget = new MessageWidget();
         _loc3_.title = resourceManager.getString(BUNDLE,"DLG_DEAD_TITLE");
         if(_loc2_.type == ConnectionEvent.DEATH_UNFAIR)
         {
            _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_UNFAIR",[100 - _loc2_.fairFightFactor]);
         }
         else if(_loc2_.type == ConnectionEvent.DEATH_BLESSED)
         {
            _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_BLESSED");
         }
         else if(_loc2_.type == ConnectionEvent.DEATH_NOPENALTY)
         {
            _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_NOPENALTY");
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIInputHandler() : InputHandler
      {
         return this._748017946m_UIInputHandler;
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
         if(this.m_ChatStorage != null)
         {
            this.m_ChatStorage.resetChannelActivationTimeout();
         }
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

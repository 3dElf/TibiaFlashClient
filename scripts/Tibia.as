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
   import mx.events.CloseEvent;
   import tibia.game.PopUpBase;
   import tibia.game.TimeoutWaitWidget;
   import tibia.actionbar.HActionBarWidget;
   import mx.events.PropertyChangeEvent;
   import tibia.actionbar.VActionBarWidget;
   import mx.binding.BindingManager;
   import flash.events.Event;
   import tibia.game.OptionsAsset;
   import tibia.controls.GridContainer;
   import mx.core.IUIComponent;
   import tibia.worldmap.WorldMapWidget;
   import tibia.game.FocusNotifier;
   import tibia.sidebar.ToggleBar;
   import tibia.network.IConnectionData;
   import tibia.controls.GameWindowContainer;
   import tibia.sidebar.SideBarWidget;
   import tibia.network.ConnectionEvent;
   import tibia.game.MessageWidget;
   import tibia.game.GameEvent;
   import shared.controls.EmbeddedDialog;
   import tibia.game.AccountCharacter;
   import tibia.game.CharacterSelectionWidget;
   import mx.managers.CursorManager;
   import tibia.game.ContextMenuBase;
   import tibia.game.PopUpQueue;
   import mx.binding.Binding;
   import tibia.sidebar.SideBarSet;
   import mx.containers.BoxDirection;
   import tibia.actionbar.ActionBarSet;
   import mx.collections.ArrayCollection;
   import flash.events.ErrorEvent;
   import shared.controls.CustomDividedBox;
   import tibia.game.Asset;
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
   import flash.events.TimerEvent;
   import mx.events.FlexEvent;
   import flash.utils.*;
   import tibia.network.ConnectionFactory;
   import mx.managers.ToolTipManager;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.MouseEvent;
   import tibia.game.LoginWaitWidget;
   import tibia.game.ConnectionLostWidget;
   import mx.containers.HBox;
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
      
      public static const CLIENT_VERSION:uint = 1196;
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
      
      private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
      
      public static const PREVIEW_STATE_REGULAR:uint = 0;
      
      private static var s_LastTibiaTimestamp:int = 0;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_723798246:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1130951435:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_1295866705:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_307077011:Class;
      
      private var _embed_css_images_Border02_corners_png_2091070659:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_592282805:Class;
      
      private var _embed_css_images_Button_Close_over_png_962295214:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_493043676:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1524993499:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_248986996:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1994195005:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_208996641:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_1009927889:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1732566926:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_220970162:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_388618220:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1331947340:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_1314457693:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1687804259:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_602215023:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_816240035:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_893993678:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1462318231:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1781387088:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_278787806:Class;
      
      private var _embed_css_images_Inventory_png_417647526:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_925976153:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_927932088:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_530358560:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_539846980:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_2005825632:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1359355259:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_359097671:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_600088877:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_992267956:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_1253290800:Class;
      
      private var _embed_css_images_BarsXP_default__png_113248767:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_165171426:Class;
      
      protected var m_IsActive:Boolean = false;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_809067447:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_133536508:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_711602537:Class;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_2102312955:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_298230396:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_500217276:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1197805533:Class;
      
      private var _embed_css_images_Minimap_png_533076801:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_178228365:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1785389579:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1648802334:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_875165837:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1689006044:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_2094447540:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1270407598:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_195822002:Class;
      
      private var _embed_css_images_slot_Hotkey_highlighted_png_1668158799:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1590715713:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_876445518:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1385908897:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1132084239:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1552080641:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_163443947:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1644584498:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1647736189:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_132620705:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_1355447668:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1466441296:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_278301060:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1092119235:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1598828282:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_642061279:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_945405154:Class;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_402978229:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_868234990:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_392811964:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_424300607:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1863062018:Class;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_755632131:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1057290003:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_1471353495:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_857454221:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_110943810:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_8536340:Class;
      
      private var _embed_css_images_Slot_Statusicon_png_1140468202:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_1148734468:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_658998155:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_744343268:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_125440547:Class;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_953377955:Class;
      
      private var _embed_css_images_Border_Widget_png_593414335:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1995098948:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1684871478:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var m_GameClientReady:Boolean = false;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_973349948:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_873425891:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_1208955073:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_2065644301:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_231830406:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_743202289:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_759468667:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_443845378:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_533370411:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_1053586275:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_267413151:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_330598376:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1374936820:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1406240223:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1717623042:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_56646380:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_392068788:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1489507443:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1346426403:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1648738991:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_392349670:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1674770829:Class;
      
      protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_6557505:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1958255101:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1056390561:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1724082326:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1539257583:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1355942910:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_826511277:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1847369862:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_659737505:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_543235959:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_843750750:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1883998218:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1714159835:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_744550613:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_732958697:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_332529246:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_609585396:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_616387727:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_1152662730:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Slot_InventoryRing_png_939344149:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1663450615:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1618448472:Class;
      
      private var _embed_css_images_slot_Hotkey_disabled_png_527400520:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1512611999:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1815853605:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1664853934:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1383597707:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_606172619:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1036174394:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1411721944:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_2031424354:Class;
      
      protected var m_Connection:IServerConnection = null;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_913005969:Class;
      
      private var _embed_css_images_Border02_png_856703646:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_2135094520:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_512955098:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_16878826:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1285142299:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_719797280:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_801383423:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_5060635:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_462015405:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_157623374:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_882665745:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_530577916:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_751001151:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_621727888:Class;
      
      protected var m_ConnectionDataCurrent:int = -1;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_173351500:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_978245529:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_99983449:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1777920282:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_351087686:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_1190927966:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1313853830:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1717807070:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_2039107760:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_598721807:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_1745867519:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1457975092:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_481981918:Class;
      
      protected var m_ConnectionDataPending:int = -1;
      
      private var _embed_css_images_Widget_HeaderBG_png_1004171383:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_640121694:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_403692863:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1835708977:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_660543386:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_619472301:Class;
      
      private var _embed_css_images_BG_Combat_png_1259005496:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_528589952:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1653578252:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_906213867:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1699753670:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_543255354:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_1221301126:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1688078727:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Button_Minimize_idle_png_1253936120:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_525533669:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_1752971311:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1976280873:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_2121789393:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1476644759:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_2119451328:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_578872186:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_712352680:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1938105803:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_365430300:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_png_853768633:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1659216631:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1475120493:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_118367003:Class;
      
      private var _embed_css_images_Button_Close_idle_png_1686475950:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_313162537:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Minimap_Center_over_png_738628898:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1866907854:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1866230562:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1535856836:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_1308517202:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_167490135:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_946016617:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_1035656130:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_100950163:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_859591557:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_740216087:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_2067614026:Class;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_570736035:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_959238167:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_927218359:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_930699555:Class;
      
      private var _embed_css_images_slot_container_png_2029892912:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1677081570:Class;
      
      protected var m_CharacterDeath:Boolean = false;
      
      private var _embed_css_images_BuySellTab_idle_png_1148329472:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1678670036:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_807790177:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_539562440:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_524824067:Class;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_BG_BohemianTileable_png_1898896849:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_123197514:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1850140534:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1794257992:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_792540333:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_837542083:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_625816479:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1685424002:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1578326784:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1454446009:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1982338168:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_897537375:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1809571280:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1669178623:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1192065826:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1021570385:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_679836510:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_161805668:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1156005948:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_986617245:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1294917183:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_759649463:Class;
      
      protected var m_Communication:Communication = null;
      
      private var _embed_css_images_slot_container_highlighted_png_1157853804:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_177341812:Class;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_373870869:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_2137683853:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1719713596:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1951418500:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1792758096:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_1235397958:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1489181815:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_230806695:Class;
      
      private var _embed_css_images_slot_Hotkey_png_132444339:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1199076419:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_667337490:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1367407260:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_1209472556:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_622177066:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_1481472997:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1769957538:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1868501651:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_50352250:Class;
      
      protected var m_ChannelsPending:Vector.<int> = null;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_381193019:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1794326971:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_422631539:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1864789393:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1806622686:Class;
      
      private var m_ConnectionLostDialog:ConnectionLostWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_1082908255:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_251008113:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_630300592:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_424034803:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1965703466:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2046303087:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1728145290:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_142073578:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1889026480:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1362099133:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_51686237:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_311432014:Class;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_220970162 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_220970162;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_195822002 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_195822002;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_876445518 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_876445518;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1866907854 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1866907854;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_600088877 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_600088877;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1383597707 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1383597707;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_658998155 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_658998155;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1794326971 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1794326971;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_598721807 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_598721807;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_743202289 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_743202289;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1021570385 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1021570385;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_744343268 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_744343268;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_2094447540 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2094447540;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1331947340 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1331947340;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_365430300 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_365430300;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_2119451328 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_2119451328;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_751001151 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_751001151;
         this._embed_css_images_Arrow_WidgetToggle_over_png_403692863 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_403692863;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_267413151 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_267413151;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_868234990 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_868234990;
         this._embed_css_images_BG_BarsXP_default_tileable_png_873425891 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_873425891;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1056390561 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1056390561;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1192065826 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1192065826;
         this._embed_css_images_BG_Bars_compact_tileable_png_1976280873 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1976280873;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1835708977 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1835708977;
         this._embed_css_images_BG_Bars_default_enpiece_png_530577916 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_530577916;
         this._embed_css_images_BG_Bars_default_tileable_png_606172619 = Tibia__embed_css_images_BG_Bars_default_tileable_png_606172619;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_946016617 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_946016617;
         this._embed_css_images_BG_Bars_fat_enpiece_png_161805668 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_161805668;
         this._embed_css_images_BG_Bars_fat_tileable_png_1994195005 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1994195005;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_2121789393 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_2121789393;
         this._embed_css_images_BG_BohemianTileable_Game_png_609585396 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_609585396;
         this._embed_css_images_BG_BohemianTileable_png_1898896849 = Tibia__embed_css_images_BG_BohemianTileable_png_1898896849;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_330598376 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_330598376;
         this._embed_css_images_BG_ChatTab_tileable_png_1863062018 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1863062018;
         this._embed_css_images_BG_Combat_png_1259005496 = Tibia__embed_css_images_BG_Combat_png_1259005496;
         this._embed_css_images_BG_Stone2_Tileable_png_1809571280 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1809571280;
         this._embed_css_images_BG_Widget_Menu_png_1253290800 = Tibia__embed_css_images_BG_Widget_Menu_png_1253290800;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_125440547 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_125440547;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_1152662730 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_1152662730;
         this._embed_css_images_BarsHealth_compact_Mana_png_1781387088 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1781387088;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1648738991 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1648738991;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_528589952 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_528589952;
         this._embed_css_images_BarsHealth_compact_RedLow_png_298230396 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_298230396;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1489507443 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1489507443;
         this._embed_css_images_BarsHealth_default_GreenFull_png_6557505 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_6557505;
         this._embed_css_images_BarsHealth_default_GreenLow_png_1355447668 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1355447668;
         this._embed_css_images_BarsHealth_default_Mana_png_1270407598 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1270407598;
         this._embed_css_images_BarsHealth_default_RedFull_png_602215023 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_602215023;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1648802334 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1648802334;
         this._embed_css_images_BarsHealth_default_RedLow_png_2031424354 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_2031424354;
         this._embed_css_images_BarsHealth_default_Yellow_png_1009927889 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_1009927889;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_809067447 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_809067447;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_493043676 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_493043676;
         this._embed_css_images_BarsHealth_fat_Mana_png_1728145290 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1728145290;
         this._embed_css_images_BarsHealth_fat_RedFull_png_1471353495 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1471353495;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1847369862 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1847369862;
         this._embed_css_images_BarsHealth_fat_RedLow_png_622177066 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_622177066;
         this._embed_css_images_BarsHealth_fat_Yellow_png_925976153 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_925976153;
         this._embed_css_images_BarsXP_default__png_113248767 = Tibia__embed_css_images_BarsXP_default__png_113248767;
         this._embed_css_images_Bars_ProgressMarker_png_1889026480 = Tibia__embed_css_images_Bars_ProgressMarker_png_1889026480;
         this._embed_css_images_Border02_WidgetSidebar_png_853768633 = Tibia__embed_css_images_Border02_WidgetSidebar_png_853768633;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_1295866705 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_1295866705;
         this._embed_css_images_Border02_corners_png_2091070659 = Tibia__embed_css_images_Border02_corners_png_2091070659;
         this._embed_css_images_Border02_png_856703646 = Tibia__embed_css_images_Border02_png_856703646;
         this._embed_css_images_Border_Widget_corner_png_826511277 = Tibia__embed_css_images_Border_Widget_corner_png_826511277;
         this._embed_css_images_Border_Widget_png_593414335 = Tibia__embed_css_images_Border_Widget_png_593414335;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_373870869 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_373870869;
         this._embed_css_images_Button_ChatTabIgnore_over_png_906213867 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_906213867;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_381193019 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_381193019;
         this._embed_css_images_Button_ChatTabNew_idle_png_2137683853 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_2137683853;
         this._embed_css_images_Button_ChatTabNew_over_png_875165837 = Tibia__embed_css_images_Button_ChatTabNew_over_png_875165837;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1057290003 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1057290003;
         this._embed_css_images_Button_ChatTab_Close_idle_png_1209472556 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1209472556;
         this._embed_css_images_Button_ChatTab_Close_over_png_1678670036 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1678670036;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1156005948 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1156005948;
         this._embed_css_images_Button_Close_idle_png_1686475950 = Tibia__embed_css_images_Button_Close_idle_png_1686475950;
         this._embed_css_images_Button_Close_over_png_962295214 = Tibia__embed_css_images_Button_Close_over_png_962295214;
         this._embed_css_images_Button_Close_pressed_png_1769957538 = Tibia__embed_css_images_Button_Close_pressed_png_1769957538;
         this._embed_css_images_Button_Combat_Stop_idle_png_2065644301 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_2065644301;
         this._embed_css_images_Button_Combat_Stop_over_png_424034803 = Tibia__embed_css_images_Button_Combat_Stop_over_png_424034803;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1868501651 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1868501651;
         this._embed_css_images_Button_ContainerUp_idle_png_679836510 = Tibia__embed_css_images_Button_ContainerUp_idle_png_679836510;
         this._embed_css_images_Button_ContainerUp_over_png_332529246 = Tibia__embed_css_images_Button_ContainerUp_over_png_332529246;
         this._embed_css_images_Button_ContainerUp_pressed_png_165171426 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_165171426;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_816240035 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_816240035;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_51686237 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_51686237;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_392349670 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_392349670;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_723798246 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_723798246;
         this._embed_css_images_Button_Maximize_idle_png_1221301126 = Tibia__embed_css_images_Button_Maximize_idle_png_1221301126;
         this._embed_css_images_Button_Maximize_over_png_578872186 = Tibia__embed_css_images_Button_Maximize_over_png_578872186;
         this._embed_css_images_Button_Maximize_pressed_png_543255354 = Tibia__embed_css_images_Button_Maximize_pressed_png_543255354;
         this._embed_css_images_Button_Minimize_idle_png_1253936120 = Tibia__embed_css_images_Button_Minimize_idle_png_1253936120;
         this._embed_css_images_Button_Minimize_over_png_2135094520 = Tibia__embed_css_images_Button_Minimize_over_png_2135094520;
         this._embed_css_images_Button_Minimize_pressed_png_1618448472 = Tibia__embed_css_images_Button_Minimize_pressed_png_1618448472;
         this._embed_css_images_Button_Standard_tileable_disabled_png_712352680 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_712352680;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1689006044 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1689006044;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_533370411 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_533370411;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_930699555 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_930699555;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1346426403 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1346426403;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_307077011 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_307077011;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1719713596 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1719713596;
         this._embed_css_images_Button_Standard_tileable_end_over_png_973349948 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_973349948;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_173351500 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_173351500;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1406240223 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1406240223;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_208996641 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_208996641;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_1208955073 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_1208955073;
         this._embed_css_images_Button_Standard_tileable_idle_png_719797280 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_719797280;
         this._embed_css_images_Button_Standard_tileable_over_png_530358560 = Tibia__embed_css_images_Button_Standard_tileable_over_png_530358560;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1792758096 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1792758096;
         this._embed_css_images_BuySellTab_active_png_1664853934 = Tibia__embed_css_images_BuySellTab_active_png_1664853934;
         this._embed_css_images_BuySellTab_idle_png_1148329472 = Tibia__embed_css_images_BuySellTab_idle_png_1148329472;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1367407260 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1367407260;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_927218359 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_927218359;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1489181815 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1489181815;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_660543386 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_660543386;
         this._embed_css_images_ChatTab_tileable_idle_png_619472301 = Tibia__embed_css_images_ChatTab_tileable_idle_png_619472301;
         this._embed_css_images_ChatTab_tileable_png_1883998218 = Tibia__embed_css_images_ChatTab_tileable_png_1883998218;
         this._embed_css_images_ChatWindow_Mover_png_1965703466 = Tibia__embed_css_images_ChatWindow_Mover_png_1965703466;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_167490135 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_167490135;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1313853830 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1313853830;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1374936820 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1374936820;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1653578252 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1653578252;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_621727888 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_621727888;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1687804259 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1687804259;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1524993499 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1524993499;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1714159835 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1714159835;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1699753670 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1699753670;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1092119235 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1092119235;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_251008113 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_251008113;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_616387727 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_616387727;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_392811964 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_392811964;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1476644759 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1476644759;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_230806695 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_230806695;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_99983449 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_99983449;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_132620705 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_132620705;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1866230562 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1866230562;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_388618220 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_388618220;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_56646380 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_56646380;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_351087686 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_351087686;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_1235397958 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_1235397958;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_1190927966 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_1190927966;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_843750750 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_843750750;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1512611999 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1512611999;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_625816479 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_625816479;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1454446009 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1454446009;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_359097671 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_359097671;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1647736189 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1647736189;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1938105803 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1938105803;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_857454221 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_857454221;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_422631539 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_422631539;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1669178623 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1669178623;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_801383423 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_801383423;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_402978229 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_402978229;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_592282805 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_592282805;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_659737505 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_659737505;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1385908897 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1385908897;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_913005969 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_913005969;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2046303087 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2046303087;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_2067614026 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_2067614026;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_123197514 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_123197514;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1677081570 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1677081570;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_945405154 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_945405154;
         this._embed_css_images_Icons_Conditions_Bleeding_png_392068788 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_392068788;
         this._embed_css_images_Icons_Conditions_Burning_png_807790177 = Tibia__embed_css_images_Icons_Conditions_Burning_png_807790177;
         this._embed_css_images_Icons_Conditions_Cursed_png_157623374 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_157623374;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1535856836 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1535856836;
         this._embed_css_images_Icons_Conditions_Drowning_png_142073578 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_142073578;
         this._embed_css_images_Icons_Conditions_Drunk_png_311432014 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_311432014;
         this._embed_css_images_Icons_Conditions_Electrified_png_1777920282 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1777920282;
         this._embed_css_images_Icons_Conditions_Freezing_png_1578326784 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1578326784;
         this._embed_css_images_Icons_Conditions_Haste_png_313162537 = Tibia__embed_css_images_Icons_Conditions_Haste_png_313162537;
         this._embed_css_images_Icons_Conditions_Hungry_png_959238167 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_959238167;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_882665745 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_882665745;
         this._embed_css_images_Icons_Conditions_MagicShield_png_8536340 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_8536340;
         this._embed_css_images_Icons_Conditions_PZ_png_1724082326 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1724082326;
         this._embed_css_images_Icons_Conditions_PZlock_png_1294917183 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1294917183;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1674770829 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1674770829;
         this._embed_css_images_Icons_Conditions_Slowed_png_278301060 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_278301060;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1362099133 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1362099133;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_992267956 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_992267956;
         this._embed_css_images_Icons_PremmyPurse_active_png_1864789393 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1864789393;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_524824067 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_524824067;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1539257583 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1539257583;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_2102312955 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_2102312955;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1688078727 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1688078727;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_1308517202 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_1308517202;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_178228365 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_178228365;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_755632131 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_755632131;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_953377955 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_953377955;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1685424002 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1685424002;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_100950163 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_100950163;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1785389579 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1785389579;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_1314457693 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_1314457693;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_1148734468 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_1148734468;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_667337490 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_667337490;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1663450615 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1663450615;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1659216631 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1659216631;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_740216087 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_740216087;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_481981918 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_481981918;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_278787806 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_278787806;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1644584498 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1644584498;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1794257992 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1794257992;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_16878826 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_16878826;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_231830406 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_231830406;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1951418500 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1951418500;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1958255101 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1958255101;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_893993678 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_893993678;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_1053586275 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_1053586275;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_424300607 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_424300607;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_837542083 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_837542083;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_525533669 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_525533669;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_927932088 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_927932088;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_732958697 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_732958697;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1036174394 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1036174394;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_986617245 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_986617245;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_50352250 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_50352250;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1130951435 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1130951435;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1411721944 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1411721944;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1552080641 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1552080641;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_248986996 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_248986996;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1475120493 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1475120493;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1684871478 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1684871478;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_163443947 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_163443947;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_539562440 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_539562440;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_978245529 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_978245529;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1850140534 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1850140534;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1199076419 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1199076419;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_512955098 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_512955098;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1359355259 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1359355259;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1982338168 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1982338168;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_177341812 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_177341812;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_1082908255 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_1082908255;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1717623042 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1717623042;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_897537375 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_897537375;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1732566926 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1732566926;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1132084239 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1132084239;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_630300592 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_630300592;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1197805533 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1197805533;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_110943810 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_110943810;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_859591557 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_859591557;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_539846980 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_539846980;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_711602537 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_711602537;
         this._embed_css_images_Inventory_png_417647526 = Tibia__embed_css_images_Inventory_png_417647526;
         this._embed_css_images_Minimap_Center_active_png_2005825632 = Tibia__embed_css_images_Minimap_Center_active_png_2005825632;
         this._embed_css_images_Minimap_Center_idle_png_1806622686 = Tibia__embed_css_images_Minimap_Center_idle_png_1806622686;
         this._embed_css_images_Minimap_Center_over_png_738628898 = Tibia__embed_css_images_Minimap_Center_over_png_738628898;
         this._embed_css_images_Minimap_ZoomIn_idle_png_5060635 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_5060635;
         this._embed_css_images_Minimap_ZoomIn_over_png_1285142299 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1285142299;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_744550613 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_744550613;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1355942910 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1355942910;
         this._embed_css_images_Minimap_ZoomOut_over_png_443845378 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_443845378;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_1035656130 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_1035656130;
         this._embed_css_images_Minimap_png_533076801 = Tibia__embed_css_images_Minimap_png_533076801;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_500217276 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_500217276;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1995098948 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1995098948;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1457975092 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1457975092;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_462015405 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_462015405;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_792540333 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_792540333;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_570736035 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_570736035;
         this._embed_css_images_Scrollbar_Handler_png_118367003 = Tibia__embed_css_images_Scrollbar_Handler_png_118367003;
         this._embed_css_images_Scrollbar_tileable_png_1752971311 = Tibia__embed_css_images_Scrollbar_tileable_png_1752971311;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_759649463 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_759649463;
         this._embed_css_images_Slot_InventoryAmmo_png_543235959 = Tibia__embed_css_images_Slot_InventoryAmmo_png_543235959;
         this._embed_css_images_Slot_InventoryArmor_png_1717807070 = Tibia__embed_css_images_Slot_InventoryArmor_png_1717807070;
         this._embed_css_images_Slot_InventoryBackpack_png_1481472997 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1481472997;
         this._embed_css_images_Slot_InventoryBoots_png_1466441296 = Tibia__embed_css_images_Slot_InventoryBoots_png_1466441296;
         this._embed_css_images_Slot_InventoryHead_png_759468667 = Tibia__embed_css_images_Slot_InventoryHead_png_759468667;
         this._embed_css_images_Slot_InventoryLegs_png_2039107760 = Tibia__embed_css_images_Slot_InventoryLegs_png_2039107760;
         this._embed_css_images_Slot_InventoryNecklace_png_1745867519 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1745867519;
         this._embed_css_images_Slot_InventoryRing_png_939344149 = Tibia__embed_css_images_Slot_InventoryRing_png_939344149;
         this._embed_css_images_Slot_InventoryShield_png_133536508 = Tibia__embed_css_images_Slot_InventoryShield_png_133536508;
         this._embed_css_images_Slot_InventoryWeapon_png_1462318231 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1462318231;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1598828282 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1598828282;
         this._embed_css_images_Slot_Statusicon_png_1140468202 = Tibia__embed_css_images_Slot_Statusicon_png_1140468202;
         this._embed_css_images_Widget_Footer_tileable_end01_png_640121694 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_640121694;
         this._embed_css_images_Widget_Footer_tileable_end02_png_642061279 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_642061279;
         this._embed_css_images_Widget_Footer_tileable_png_1590715713 = Tibia__embed_css_images_Widget_Footer_tileable_png_1590715713;
         this._embed_css_images_Widget_HeaderBG_png_1004171383 = Tibia__embed_css_images_Widget_HeaderBG_png_1004171383;
         this._embed_css_images_slot_Hotkey_disabled_png_527400520 = Tibia__embed_css_images_slot_Hotkey_disabled_png_527400520;
         this._embed_css_images_slot_Hotkey_highlighted_png_1668158799 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_1668158799;
         this._embed_css_images_slot_Hotkey_png_132444339 = Tibia__embed_css_images_slot_Hotkey_png_132444339;
         this._embed_css_images_slot_container_disabled_png_1815853605 = Tibia__embed_css_images_slot_container_disabled_png_1815853605;
         this._embed_css_images_slot_container_highlighted_png_1157853804 = Tibia__embed_css_images_slot_container_highlighted_png_1157853804;
         this._embed_css_images_slot_container_png_2029892912 = Tibia__embed_css_images_slot_container_png_2029892912;
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
      
      private function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "generalUIGameWindowHeight" || param1.property == "*")
         {
            this.updateCombatTactics();
            this.updateGameWindowSize();
         }
         this.m_CurrentOptionsDirty = true;
      }
      
      protected function onActivation(param1:Event) : void
      {
         if(param1.type == Event.ACTIVATE)
         {
            if(false == false)
            {
               FocusNotifier.getInstance().hide();
            }
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
         if(false == false)
         {
            this.m_MiniMapStorage.saveSectors(true);
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
      
      private function onCloseChangeCharacter(param1:CloseEvent) : void
      {
         var _loc3_:GameEvent = null;
         var _loc4_:EmbeddedDialog = null;
         var _loc2_:AccountCharacter = null;
         if(param1.currentTarget is CharacterSelectionWidget && param1.detail == PopUpBase.BUTTON_OKAY)
         {
            this.m_ConnectionDataPending = CharacterSelectionWidget(param1.currentTarget).selectedCharacterIndex;
            _loc2_ = this.m_ConnectionDataList[this.m_ConnectionDataPending] as AccountCharacter;
         }
         if(param1.detail != PopUpBase.BUTTON_OKAY && param1.currentTarget is CharacterSelectionWidget && (this.m_Connection == null || !this.m_Connection.isConnected))
         {
            _loc3_ = new GameEvent(GameEvent.CLOSE,true,false);
            dispatchEvent(_loc3_);
         }
         else if(param1.detail == PopUpBase.BUTTON_OKAY && param1.currentTarget is CharacterSelectionWidget && _loc2_ != null && !this.isValidPreviewStateForClient(_loc2_.worldPreviewState))
         {
            param1.preventDefault();
            _loc4_ = new EmbeddedDialog();
            _loc4_.name = "ConfirmClientChange";
            _loc4_.buttonFlags = PopUpBase.BUTTON_YES | PopUpBase.BUTTON_NO;
            _loc4_.text = resourceManager.getString(BUNDLE,"DLG_CLIENT_CHANGE_TEXT");
            _loc4_.title = resourceManager.getString(BUNDLE,"DLG_CLIENT_CHANGE_TITLE");
            _loc4_.addEventListener(CloseEvent.CLOSE,this.onCloseChangeCharacter);
            CharacterSelectionWidget(param1.currentTarget).embeddedDialog = _loc4_;
         }
         else if((param1.detail == PopUpBase.BUTTON_YES || param1.detail == PopUpBase.BUTTON_OKAY) && (param1.currentTarget is CharacterSelectionWidget || param1.currentTarget is EmbeddedDialog))
         {
            if(param1.currentTarget as EmbeddedDialog != null)
            {
               ((param1.currentTarget as EmbeddedDialog).parent as PopUpBase).hide(false);
            }
            if(this.m_Connection != null && Boolean(this.m_Connection.isConnected))
            {
               this.m_Connection.disconnect();
            }
            else if(!this.m_Connection.isConnected)
            {
               this.loginCharacter();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
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
      
      private function onUploadOptionsComplete(param1:Event) : void
      {
         this.m_CurrentOptionsDirty = false;
         this.m_CurrentOptionsLastUpload = getTimer();
         this.m_CurrentOptionsUploading = false;
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
      
      public function get isRunning() : Boolean
      {
         return this.m_Connection != null && Boolean(this.m_Connection.isGameRunning) || Boolean(this.m_CurrentOptionsUploading);
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
         }
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
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
            _loc1_ = 0;
            for each(_loc1_ in this.options.getSideBarSetIDs())
            {
               this.options.getSideBarSet(_loc1_).closeVolatileWidgets();
            }
            for each(_loc1_ in this.options.getBuddySetIDs())
            {
               this.options.getBuddySet(_loc1_).clearBuddies();
            }
         }
         CursorManager.getInstance().removeAllCursors();
         if(ContextMenuBase.getCurrent() != null)
         {
            ContextMenuBase.getCurrent().hide();
         }
         PopUpQueue.getInstance().hideByPriority(PopUpBase.DEFAULT_PRIORITY);
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
      
      public function changeCharacter() : void
      {
         var _loc3_:AccountCharacter = null;
         var _loc1_:CharacterSelectionWidget = new CharacterSelectionWidget();
         var _loc2_:ArrayCollection = new ArrayCollection();
         for each(_loc3_ in this.m_ConnectionDataList)
         {
            _loc2_.addItem(_loc3_);
         }
         _loc1_.characters = _loc2_;
         _loc1_.selectedCharacterIndex = this.m_ConnectionDataCurrent;
         _loc1_.addEventListener(CloseEvent.CLOSE,this.onCloseChangeCharacter);
         _loc1_.show();
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
      
      public function setContent(param1:Vector.<Asset>) : void
      {
         if(this.m_AppearanceStorage == null)
         {
            throw new Error("Tibia.setContent: Invalid state.");
         }
         if(param1 == null)
         {
            throw new ArgumentError("Tibia.setContent: Invalid content.");
         }
         this.m_AppearanceStorage.setContent(param1);
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarLeft() : VActionBarWidget
      {
         return this._1174474338m_UIActionBarLeft;
      }
      
      protected function onPreinitialise(param1:FlexEvent) : void
      {
         this.m_AppearanceStorage = new AppearanceStorage();
         this.m_AppearanceStorage.addEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
         this.m_AppearanceStorage.addEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
         this.m_ChatStorage = new ChatStorage();
         this.m_ChannelsPending = new Vector.<int>();
         this.m_ContainerStorage = new ContainerStorage();
         this.m_CreatureStorage = new CreatureStorage();
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
      
      public function __m_UIGameWindow_resize(param1:ResizeEvent) : void
      {
         this.onGameWindowResize(param1);
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
      
      protected function onApplicationComplete(param1:FlexEvent) : void
      {
         ToolTipManager.showDelay = 750;
         ToolTipManager.scrubDelay = 0;
         stage.align = StageAlign.TOP_LEFT;
         stage.frameRate = 100;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.showDefaultContextMenu = false;
         if(this.isActive == false || false)
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
      
      public function ___Tibia_Application1_deactivate(param1:Event) : void
      {
         this.onActivation(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
      }
      
      private function updateCombatTactics() : void
      {
         if(this.m_Communication != null && Boolean(this.m_Communication.isGameRunning) && this.m_Options != null)
         {
            this.m_Communication.sendCSETTACTICS(this.m_Options.combatAttackMode,this.m_Options.combatChaseMode,this.m_Options.combatSecureMode);
         }
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
      }
      
      public function ___Tibia_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete(param1);
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
      
      [Bindable(event="propertyChange")]
      public function get m_UICenterColumn() : CustomDividedBox
      {
         return this._1356021457m_UICenterColumn;
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
      
      private function onConnectionLost(param1:ConnectionEvent) : void
      {
         this.saveLocalData();
         this.saveOptions();
         this.m_ConnectionLostDialog = new ConnectionLostWidget();
         this.m_ConnectionLostDialog.timeout = Number(60 * 1000);
         this.m_ConnectionLostDialog.addEventListener(CloseEvent.CLOSE,this.onCloseConnectionLostDialog);
         this.m_ConnectionLostDialog.show();
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
      
      protected function onGameWindowAutofit(param1:MouseEvent) : void
      {
         this.autofitGameWindow();
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIGameWindow() : GridContainer
      {
         return this._1404294856m_UIGameWindow;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarB() : SideBarWidget
      {
         return this._64278964m_UISideBarB;
      }
      
      private function onConnectionRecovered(param1:ConnectionEvent) : void
      {
         this.m_ConnectionLostDialog.hide();
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
      
      public function setOptions(param1:OptionsAsset, param2:OptionsAsset) : void
      {
         if(this.m_CurrentOptionsAsset != null)
         {
            this.m_CurrentOptionsAsset.removeEventListener(Event.COMPLETE,this.onUploadOptionsComplete);
            this.m_CurrentOptionsAsset.removeEventListener(ErrorEvent.ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(IOErrorEvent.IO_ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadOptionsError);
         }
         this.m_CurrentOptionsAsset = param1;
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
         this.m_DefaultOptionsAsset = param2;
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
   }
}

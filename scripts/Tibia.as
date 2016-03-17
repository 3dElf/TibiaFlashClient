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
   import tibia.game.FocusNotifier;
   import tibia.network.IConnectionData;
   import tibia.network.ConnectionEvent;
   import tibia.game.MessageWidget;
   import tibia.actionbar.HActionBarWidget;
   import tibia.game.TimeoutWaitWidget;
   import tibia.sidebar.ToggleBar;
   import mx.binding.Binding;
   import tibia.sidebar.SideBarSet;
   import mx.containers.BoxDirection;
   import tibia.actionbar.ActionBarSet;
   import flash.events.ErrorEvent;
   import tibia.game.GameEvent;
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
   import tibia.network.ConnectionFactory;
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
      
      public static const CLIENT_VERSION:uint = 1404;
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
      
      private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
      
      public static const PREVIEW_STATE_REGULAR:uint = 0;
      
      private static var s_LastTibiaTimestamp:int = 0;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1857357311:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1191442963:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_2012688527:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_954459878:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_301356766:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1188945492:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_574279422:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_502744633:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1695571713:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_266891861:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_926059007:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_Scrollbar_tileable_png_1484535251:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_2070767127:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1514857951:Class;
      
      protected var m_IsActive:Boolean = false;
      
      private var _embed_css_images_Button_Close_idle_png_1218836874:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2028276291:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_849233240:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1528255203:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1546217951:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1113828490:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_246844262:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_1292179891:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1281608928:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_535588893:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_1422630963:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_227932024:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1771204180:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_405475236:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1701257512:Class;
      
      private var _embed_css_images_slot_Hotkey_disabled_png_994917156:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1996454291:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_452312320:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_409591214:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_86849538:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_1987376657:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1377456108:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_431200598:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_992643145:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_1667484838:Class;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_935789070:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1429348608:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1714080914:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_2078005292:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_211474599:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_180526418:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1348517275:Class;
      
      private var m_GameClientReady:Boolean = false;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_1273433520:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_605006672:Class;
      
      private var _embed_css_images_slot_Hotkey_png_146592943:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1220914118:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_490634991:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1989961286:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_609039619:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_1017829655:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1528117550:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_358153400:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_58280658:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1146743901:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_982391891:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_138959196:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1679698075:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_260180361:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1097710785:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_482845357:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_801197927:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_509844711:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_302692372:Class;
      
      protected var m_Connection:IServerConnection = null;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1767216064:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_145315999:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1432093558:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_2104666118:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_Button_Minimize_over_png_1583134748:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_1048976978:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1921195902:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_1102125518:Class;
      
      private var _embed_css_images_slot_Hotkey_highlighted_png_2071319371:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1458084888:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1404044595:Class;
      
      protected var m_ConnectionDataPending:int = -1;
      
      private var _embed_css_images_Border02_png_456293754:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_356784399:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1983273089:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1468961855:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_348408429:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_906529265:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1051811840:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_490294368:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1919873437:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1210365909:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_515177278:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_68537130:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_193278283:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_1127940310:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1565724477:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_225324206:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1789485381:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Border02_WidgetSidebar_png_249805245:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1067895292:Class;
      
      protected var m_CharacterDeath:Boolean = false;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_455510538:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_1497487084:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_930638717:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1010616943:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1694038902:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_814560594:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_30841963:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_922897783:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Bars_ProgressMarker_png_2128477780:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1535104458:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1144110062:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1453157047:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1780250670:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1725788361:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1742944567:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1396443373:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_304991513:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_468838109:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_610216230:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_1212117159:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_123799818:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1103299902:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_674758486:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1831820003:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_231099783:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1338023818:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1167129563:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_32443200:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_459454495:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_783570017:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_670916409:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_13561492:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_1127971465:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_1051938572:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_2079223005:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_906379559:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_348049024:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1012243282:Class;
      
      private var _embed_css_images_Minimap_png_799283533:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1737794982:Class;
      
      private var _embed_css_images_Border_Widget_png_600256443:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1686359923:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_668415752:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_938167768:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_442933175:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_1276731611:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1022867196:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_288371299:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1686066740:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_333720080:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_608069082:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_255100865:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_539431885:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1064231874:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_273922193:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1799563562:Class;
      
      private var _embed_css_images_Inventory_png_84216506:Class;
      
      protected var m_AssetProvider:IAssetProvider = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_177830792:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_1028429015:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1577674970:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1232635934:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_488364481:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_1029749151:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_613968615:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1535784849:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_988029035:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_2137606601:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_1087787706:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1103035475:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1240312325:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_535174963:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_303194441:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_365528236:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1539700056:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1589975055:Class;
      
      private var _embed_css_images_BarsXP_default__png_775287027:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_948317875:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_646986501:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_603613976:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_373718235:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_379592024:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_2127895292:Class;
      
      private var _embed_css_images_Slot_Statusicon_png_1736713046:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1730126619:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_2124402909:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_115157624:Class;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_1217604511:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_70795182:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_2128087935:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1786236546:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1695517814:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_131489987:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_962986095:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_1413841213:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_1416814704:Class;
      
      protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1143236059:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_449870525:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_712925790:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_796201886:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1674526766:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_272709604:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_391026041:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517215874:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_83428580:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_947289549:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1782319384:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_667719769:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_464116400:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1734731145:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1277352378:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1769920466:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_1085244936:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_948450415:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_584578288:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_2141274448:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_694251050:Class;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_948562175:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1320911533:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1759296703:Class;
      
      protected var m_ConnectionDataCurrent:int = -1;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1656023677:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_481662557:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1294933802:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1980997418:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_28240362:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_955272042:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_819578872:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_553787936:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1699469372:Class;
      
      private var _embed_css_images_Button_Close_over_png_1484485258:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_714322155:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1872350211:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_627021395:Class;
      
      private var _embed_css_images_Border02_corners_png_1952110039:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_698199702:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1749251401:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_2139509006:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_926460463:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_442335108:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_730569304:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_2061080748:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_2075240456:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_354760843:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_896166634:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_115616801:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1804027557:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_218968467:Class;
      
      private var _embed_css_images_slot_container_png_2097535244:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_54985369:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_822903424:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_560056203:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_896460354:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_694452361:Class;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1228129678:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_1268077203:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_2011162331:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_648276767:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_1025807859:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_1130679947:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1318827497:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1399078427:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_170031803:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1350580974:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_2081920831:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1348677857:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_877476873:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_893155438:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1279184043:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_935448997:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_113774866:Class;
      
      private var _embed_css_images_BG_Combat_png_1063995284:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_447476365:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_96302267:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_1074018139:Class;
      
      protected var m_Communication:Communication = null;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_6251085:Class;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_2093916375:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_1823278301:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1122622903:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_849969279:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_2110386868:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_1795639068:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1393972580:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1986056256:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1242322938:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1027817616:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1261396244:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_495581115:Class;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1902626562:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_2009546150:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1990727124:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1363221643:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1540639774:Class;
      
      protected var m_ChannelsPending:Vector.<int> = null;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_94854202:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1362435131:Class;
      
      private var m_ConnectionLostDialog:ConnectionLostWidget;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_569425555:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1318019493:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_662397961:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_472086076:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_487999224:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1836049045:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1268655624:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1619319301:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1888154842:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_109002808:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1793967184:Class;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_431200598 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_431200598;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_409591214 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_409591214;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1012243282 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1012243282;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1064231874 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1064231874;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_54985369 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_54985369;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_2128087935 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_2128087935;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_849969279 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_849969279;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1514857951 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1514857951;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1404044595 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1404044595;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_947289549 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_947289549;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1146743901 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1146743901;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_1268655624 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1268655624;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_2141274448 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2141274448;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1793967184 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1793967184;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_584578288 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_584578288;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1699469372 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1699469372;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_1422630963 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_1422630963;
         this._embed_css_images_Arrow_WidgetToggle_over_png_535174963 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_535174963;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_131489987 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_131489987;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1535104458 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1535104458;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1546217951 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1546217951;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1318019493 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1318019493;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1528117550 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1528117550;
         this._embed_css_images_BG_Bars_compact_tileable_png_1240312325 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1240312325;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1565724477 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1565724477;
         this._embed_css_images_BG_Bars_default_enpiece_png_452312320 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_452312320;
         this._embed_css_images_BG_Bars_default_tileable_png_1212117159 = Tibia__embed_css_images_BG_Bars_default_tileable_png_1212117159;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1210365909 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1210365909;
         this._embed_css_images_BG_Bars_fat_enpiece_png_115157624 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_115157624;
         this._embed_css_images_BG_Bars_fat_tileable_png_1759296703 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1759296703;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_2124402909 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_2124402909;
         this._embed_css_images_BG_BohemianTileable_Game_png_1085244936 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_1085244936;
         this._embed_css_images_BG_BohemianTileable_png_1823278301 = Tibia__embed_css_images_BG_BohemianTileable_png_1823278301;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_472086076 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_472086076;
         this._embed_css_images_BG_ChatTab_tileable_png_2139509006 = Tibia__embed_css_images_BG_ChatTab_tileable_png_2139509006;
         this._embed_css_images_BG_Combat_png_1063995284 = Tibia__embed_css_images_BG_Combat_png_1063995284;
         this._embed_css_images_BG_Stone2_Tileable_png_2078005292 = Tibia__embed_css_images_BG_Stone2_Tileable_png_2078005292;
         this._embed_css_images_BG_Widget_Menu_png_1051938572 = Tibia__embed_css_images_BG_Widget_Menu_png_1051938572;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_648276767 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_648276767;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_893155438 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_893155438;
         this._embed_css_images_BarsHealth_compact_Mana_png_2110386868 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_2110386868;
         this._embed_css_images_BarsHealth_compact_RedFull_png_982391891 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_982391891;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_138959196 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_138959196;
         this._embed_css_images_BarsHealth_compact_RedLow_png_822903424 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_822903424;
         this._embed_css_images_BarsHealth_compact_Yellow_png_948450415 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_948450415;
         this._embed_css_images_BarsHealth_default_GreenFull_png_535588893 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_535588893;
         this._embed_css_images_BarsHealth_default_GreenLow_png_1416814704 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1416814704;
         this._embed_css_images_BarsHealth_default_Mana_png_1338023818 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1338023818;
         this._embed_css_images_BarsHealth_default_RedFull_png_193278283 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_193278283;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1242322938 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1242322938;
         this._embed_css_images_BarsHealth_default_RedLow_png_1714080914 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1714080914;
         this._embed_css_images_BarsHealth_default_Yellow_png_468838109 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_468838109;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_1276731611 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_1276731611;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_358153400 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_358153400;
         this._embed_css_images_BarsHealth_fat_Mana_png_1769920466 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1769920466;
         this._embed_css_images_BarsHealth_fat_RedFull_png_1268077203 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1268077203;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1921195902 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1921195902;
         this._embed_css_images_BarsHealth_fat_RedLow_png_698199702 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_698199702;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1789485381 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1789485381;
         this._embed_css_images_BarsXP_default__png_775287027 = Tibia__embed_css_images_BarsXP_default__png_775287027;
         this._embed_css_images_Bars_ProgressMarker_png_2128477780 = Tibia__embed_css_images_Bars_ProgressMarker_png_2128477780;
         this._embed_css_images_Border02_WidgetSidebar_png_249805245 = Tibia__embed_css_images_Border02_WidgetSidebar_png_249805245;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_481662557 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_481662557;
         this._embed_css_images_Border02_corners_png_1952110039 = Tibia__embed_css_images_Border02_corners_png_1952110039;
         this._embed_css_images_Border02_png_456293754 = Tibia__embed_css_images_Border02_png_456293754;
         this._embed_css_images_Border_Widget_corner_png_304991513 = Tibia__embed_css_images_Border_Widget_corner_png_304991513;
         this._embed_css_images_Border_Widget_png_600256443 = Tibia__embed_css_images_Border_Widget_png_600256443;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_906529265 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_906529265;
         this._embed_css_images_Button_ChatTabIgnore_over_png_356784399 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_356784399;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_926460463 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_926460463;
         this._embed_css_images_Button_ChatTabNew_idle_png_1535784849 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1535784849;
         this._embed_css_images_Button_ChatTabNew_over_png_273922193 = Tibia__embed_css_images_Button_ChatTabNew_over_png_273922193;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1589975055 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1589975055;
         this._embed_css_images_Button_ChatTab_Close_idle_png_668415752 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_668415752;
         this._embed_css_images_Button_ChatTab_Close_over_png_2075240456 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_2075240456;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1701257512 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1701257512;
         this._embed_css_images_Button_Close_idle_png_1218836874 = Tibia__embed_css_images_Button_Close_idle_png_1218836874;
         this._embed_css_images_Button_Close_over_png_1484485258 = Tibia__embed_css_images_Button_Close_over_png_1484485258;
         this._embed_css_images_Button_Close_pressed_png_1220914118 = Tibia__embed_css_images_Button_Close_pressed_png_1220914118;
         this._embed_css_images_Button_Combat_Stop_idle_png_1987376657 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1987376657;
         this._embed_css_images_Button_Combat_Stop_over_png_490634991 = Tibia__embed_css_images_Button_Combat_Stop_over_png_490634991;
         this._embed_css_images_Button_Combat_Stop_pressed_png_2012688527 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_2012688527;
         this._embed_css_images_Button_ContainerUp_idle_png_814560594 = Tibia__embed_css_images_Button_ContainerUp_idle_png_814560594;
         this._embed_css_images_Button_ContainerUp_over_png_70795182 = Tibia__embed_css_images_Button_ContainerUp_over_png_70795182;
         this._embed_css_images_Button_ContainerUp_pressed_png_301356766 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_301356766;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_1029749151 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_1029749151;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_145315999 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_145315999;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_123799818 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_123799818;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_455510538 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_455510538;
         this._embed_css_images_Button_Maximize_idle_png_694251050 = Tibia__embed_css_images_Button_Maximize_idle_png_694251050;
         this._embed_css_images_Button_Maximize_over_png_1127940310 = Tibia__embed_css_images_Button_Maximize_over_png_1127940310;
         this._embed_css_images_Button_Maximize_pressed_png_610216230 = Tibia__embed_css_images_Button_Maximize_pressed_png_610216230;
         this._embed_css_images_Button_Minimize_idle_png_1795639068 = Tibia__embed_css_images_Button_Minimize_idle_png_1795639068;
         this._embed_css_images_Button_Minimize_over_png_1583134748 = Tibia__embed_css_images_Button_Minimize_over_png_1583134748;
         this._embed_css_images_Button_Minimize_pressed_png_1686066740 = Tibia__embed_css_images_Button_Minimize_pressed_png_1686066740;
         this._embed_css_images_Button_Standard_tileable_disabled_png_442335108 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_442335108;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1281608928 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1281608928;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_459454495 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_459454495;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1742944567 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1742944567;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_2137606601 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_2137606601;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_303194441 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_303194441;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1458084888 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1458084888;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1782319384 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1782319384;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_109002808 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_109002808;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1872350211 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1872350211;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_609039619 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_609039619;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_539431885 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_539431885;
         this._embed_css_images_Button_Standard_tileable_idle_png_83428580 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_83428580;
         this._embed_css_images_Button_Standard_tileable_over_png_272709604 = Tibia__embed_css_images_Button_Standard_tileable_over_png_272709604;
         this._embed_css_images_Button_Standard_tileable_pressed_png_2061080748 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_2061080748;
         this._embed_css_images_BuySellTab_active_png_1113828490 = Tibia__embed_css_images_BuySellTab_active_png_1113828490;
         this._embed_css_images_BuySellTab_idle_png_1022867196 = Tibia__embed_css_images_BuySellTab_idle_png_1022867196;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1027817616 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1027817616;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1191442963 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1191442963;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1363221643 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1363221643;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_796201886 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_796201886;
         this._embed_css_images_ChatTab_tileable_idle_png_694452361 = Tibia__embed_css_images_ChatTab_tileable_idle_png_694452361;
         this._embed_css_images_ChatTab_tileable_png_954459878 = Tibia__embed_css_images_ChatTab_tileable_png_954459878;
         this._embed_css_images_ChatWindow_Mover_png_2104666118 = Tibia__embed_css_images_ChatWindow_Mover_png_2104666118;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_714322155 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_714322155;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1786236546 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1786236546;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1429348608 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1429348608;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1051811840 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1051811840;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_13561492 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_13561492;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1734731145 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1734731145;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1453157047 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1453157047;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1122622903 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1122622903;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_955272042 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_955272042;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_613968615 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_613968615;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_560056203 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_560056203;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_354760843 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_354760843;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_464116400 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_464116400;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1686359923 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1686359923;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_495581115 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_495581115;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_170031803 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_170031803;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_482845357 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_482845357;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1989961286 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1989961286;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_730569304 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_730569304;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_379592024 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_379592024;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_28240362 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_28240362;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_896166634 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_896166634;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_1048976978 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_1048976978;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_180526418 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_180526418;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_569425555 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_569425555;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_218968467 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_218968467;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2028276291 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2028276291;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_449870525 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_449870525;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1983273089 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1983273089;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1010616943 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1010616943;
         this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_302692372 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_302692372;
         this._embed_css_images_Icons_CombatControls_DoveOff_over_png_1497487084 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_1497487084;
         this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_2009546150 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_2009546150;
         this._embed_css_images_Icons_CombatControls_DoveOn_over_png_1667484838 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_1667484838;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_1318827497 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_1318827497;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_1017829655 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_1017829655;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_2011162331 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_2011162331;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1143236059 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1143236059;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_667719769 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_667719769;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_211474599 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_211474599;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_930638717 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_930638717;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1656023677 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1656023677;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_30841963 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_30841963;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1836049045 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1836049045;
         this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1804027557 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1804027557;
         this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_935448997 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_935448997;
         this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_6251085 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_6251085;
         this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_948317875 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_948317875;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1888154842 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1888154842;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_608069082 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_608069082;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1350580974 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1350580974;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1144110062 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1144110062;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_487999224 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_487999224;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_819578872 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_819578872;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1432093558 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1432093558;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1695517814 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1695517814;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1167129563 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_1167129563;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_373718235 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_373718235;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1103035475 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_1103035475;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1320911533 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1320911533;
         this._embed_css_images_Icons_Conditions_Bleeding_png_849233240 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_849233240;
         this._embed_css_images_Icons_Conditions_Burning_png_1413841213 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1413841213;
         this._embed_css_images_Icons_Conditions_Cursed_png_896460354 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_896460354;
         this._embed_css_images_Icons_Conditions_Dazzled_png_938167768 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_938167768;
         this._embed_css_images_Icons_Conditions_Drowning_png_674758486 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_674758486;
         this._embed_css_images_Icons_Conditions_Drunk_png_225324206 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_225324206;
         this._embed_css_images_Icons_Conditions_Electrified_png_1232635934 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1232635934;
         this._embed_css_images_Icons_Conditions_Freezing_png_2127895292 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_2127895292;
         this._embed_css_images_Icons_Conditions_Haste_png_646986501 = Tibia__embed_css_images_Icons_Conditions_Haste_png_646986501;
         this._embed_css_images_Icons_Conditions_Hungry_png_1025807859 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_1025807859;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_348408429 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_348408429;
         this._embed_css_images_Icons_Conditions_MagicShield_png_553787936 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_553787936;
         this._embed_css_images_Icons_Conditions_PZ_png_1799563562 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1799563562;
         this._embed_css_images_Icons_Conditions_PZlock_png_1362435131 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1362435131;
         this._embed_css_images_Icons_Conditions_Poisoned_png_2070767127 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_2070767127;
         this._embed_css_images_Icons_Conditions_Slowed_png_348049024 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_348049024;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1097710785 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1097710785;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_1273433520 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_1273433520;
         this._embed_css_images_Icons_PremmyPurse_active_png_1396443373 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1396443373;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_926059007 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_926059007;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1528255203 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1528255203;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_2093916375 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_2093916375;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1679698075 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1679698075;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_712925790 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_712925790;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_231099783 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_231099783;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_948562175 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_948562175;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_1217604511 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_1217604511;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1228129678 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1228129678;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_906379559 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_906379559;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1857357311 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1857357311;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_502744633 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_502744633;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_603613976 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_603613976;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_935789070 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_935789070;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1399078427 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1399078427;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1730126619 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1730126619;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1279184043 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1279184043;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1277352378 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1277352378;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_1087787706 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_1087787706;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1980997418 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1980997418;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1377456108 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1377456108;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_113774866 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_113774866;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_246844262 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_246844262;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1539700056 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1539700056;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1695571713 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1695571713;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1294933802 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1294933802;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_922897783 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_922897783;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_288371299 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_288371299;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_509844711 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_509844711;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_662397961 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_662397961;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_1261396244 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_1261396244;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_266891861 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_266891861;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1103299902 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_1103299902;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_391026041 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_391026041;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_68537130 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_68537130;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_801197927 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_801197927;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1067895292 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1067895292;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1619319301 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1619319301;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_177830792 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_177830792;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_992643145 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_992643145;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1737794982 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1737794982;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_115616801 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_115616801;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_405475236 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_405475236;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1919873437 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1919873437;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1694038902 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1694038902;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1468961855 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1468961855;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_574279422 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_574279422;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_962986095 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_962986095;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1990727124 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1990727124;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_227932024 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_227932024;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_1074018139 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_1074018139;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1577674970 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1577674970;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_627021395 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_627021395;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517215874 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1517215874;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_988029035 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_988029035;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_365528236 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_365528236;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1725788361 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1725788361;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_515177278 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_515177278;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_783570017 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_783570017;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_605006672 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_605006672;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_447476365 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_447476365;
         this._embed_css_images_Inventory_png_84216506 = Tibia__embed_css_images_Inventory_png_84216506;
         this._embed_css_images_Minimap_Center_active_png_1393972580 = Tibia__embed_css_images_Minimap_Center_active_png_1393972580;
         this._embed_css_images_Minimap_Center_idle_png_1674526766 = Tibia__embed_css_images_Minimap_Center_idle_png_1674526766;
         this._embed_css_images_Minimap_Center_over_png_58280658 = Tibia__embed_css_images_Minimap_Center_over_png_58280658;
         this._embed_css_images_Minimap_ZoomIn_idle_png_255100865 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_255100865;
         this._embed_css_images_Minimap_ZoomIn_over_png_2081920831 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_2081920831;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1348677857 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1348677857;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1902626562 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1902626562;
         this._embed_css_images_Minimap_ZoomOut_over_png_86849538 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_86849538;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_1102125518 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_1102125518;
         this._embed_css_images_Minimap_png_799283533 = Tibia__embed_css_images_Minimap_png_799283533;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_32443200 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_32443200;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1767216064 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1767216064;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1986056256 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1986056256;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_260180361 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_260180361;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_1127971465 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_1127971465;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_442933175 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_442933175;
         this._embed_css_images_Scrollbar_Handler_png_488364481 = Tibia__embed_css_images_Scrollbar_Handler_png_488364481;
         this._embed_css_images_Scrollbar_tileable_png_1484535251 = Tibia__embed_css_images_Scrollbar_tileable_png_1484535251;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_1292179891 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1292179891;
         this._embed_css_images_Slot_InventoryAmmo_png_1348517275 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1348517275;
         this._embed_css_images_Slot_InventoryArmor_png_1780250670 = Tibia__embed_css_images_Slot_InventoryArmor_png_1780250670;
         this._embed_css_images_Slot_InventoryBackpack_png_877476873 = Tibia__embed_css_images_Slot_InventoryBackpack_png_877476873;
         this._embed_css_images_Slot_InventoryBoots_png_1188945492 = Tibia__embed_css_images_Slot_InventoryBoots_png_1188945492;
         this._embed_css_images_Slot_InventoryHead_png_1028429015 = Tibia__embed_css_images_Slot_InventoryHead_png_1028429015;
         this._embed_css_images_Slot_InventoryLegs_png_1771204180 = Tibia__embed_css_images_Slot_InventoryLegs_png_1771204180;
         this._embed_css_images_Slot_InventoryNecklace_png_2079223005 = Tibia__embed_css_images_Slot_InventoryNecklace_png_2079223005;
         this._embed_css_images_Slot_InventoryRing_png_670916409 = Tibia__embed_css_images_Slot_InventoryRing_png_670916409;
         this._embed_css_images_Slot_InventoryShield_png_333720080 = Tibia__embed_css_images_Slot_InventoryShield_png_333720080;
         this._embed_css_images_Slot_InventoryWeapon_png_1996454291 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1996454291;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1540639774 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1540639774;
         this._embed_css_images_Slot_Statusicon_png_1736713046 = Tibia__embed_css_images_Slot_Statusicon_png_1736713046;
         this._embed_css_images_Widget_Footer_tileable_end01_png_94854202 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_94854202;
         this._embed_css_images_Widget_Footer_tileable_end02_png_96302267 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_96302267;
         this._embed_css_images_Widget_Footer_tileable_png_1831820003 = Tibia__embed_css_images_Widget_Footer_tileable_png_1831820003;
         this._embed_css_images_Widget_HeaderBG_png_1130679947 = Tibia__embed_css_images_Widget_HeaderBG_png_1130679947;
         this._embed_css_images_slot_Hotkey_disabled_png_994917156 = Tibia__embed_css_images_slot_Hotkey_disabled_png_994917156;
         this._embed_css_images_slot_Hotkey_highlighted_png_2071319371 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_2071319371;
         this._embed_css_images_slot_Hotkey_png_146592943 = Tibia__embed_css_images_slot_Hotkey_png_146592943;
         this._embed_css_images_slot_container_disabled_png_1749251401 = Tibia__embed_css_images_slot_container_disabled_png_1749251401;
         this._embed_css_images_slot_container_highlighted_png_490294368 = Tibia__embed_css_images_slot_container_highlighted_png_490294368;
         this._embed_css_images_slot_container_png_2097535244 = Tibia__embed_css_images_slot_container_png_2097535244;
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
            if(false == false)
            {
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
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
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
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
      public function get m_UISideBarD() : SideBarWidget
      {
         return this._64278962m_UISideBarD;
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

package
{
   import mx.core.Application;
   import mx.binding.IBindingClient;
   import tibia.game.IGameClient;
   import tibia.minimap.MiniMapStorage;
   import tibia.options.OptionsStorage;
   import tibia.container.ContainerStorage;
   import tibia.chat.ChatStorage;
   import tibia.chat.ChatWidget;
   import tibia.creatures.StatusWidget;
   import tibia.worldmap.WorldMapStorage;
   import tibia.network.Connection;
   import mx.binding.IWatcherSetupUtil;
   import tibia.creatures.Player;
   import tibia.appearances.AppearanceStorage;
   import tibia.creatures.CreatureStorage;
   import mx.core.mx_internal;
   import tibia.input.InputHandler;
   import flash.utils.Timer;
   import tibia.magic.SpellStorage;
   import tibia.actionbar.HActionBarWidget;
   import mx.events.PropertyChangeEvent;
   import tibia.actionbar.VActionBarWidget;
   import mx.binding.BindingManager;
   import flash.events.Event;
   import tibia.controls.GridContainer;
   import mx.core.IUIComponent;
   import tibia.worldmap.WorldMapWidget;
   import tibia.game.FocusNotifier;
   import tibia.sidebar.ToggleBar;
   import tibia.sidebar.SideBarWidget;
   import tibia.controls.GameWindowContainer;
   import tibia.game.MessageWidget;
   import tibia.game.PopUpBase;
   import mx.events.CloseEvent;
   import tibia.network.ConnectionEvent;
   import tibia.game.ContextMenuBase;
   import mx.managers.CursorManager;
   import mx.binding.Binding;
   import tibia.sidebar.SideBarSet;
   import mx.containers.BoxDirection;
   import tibia.actionbar.ActionBarSet;
   import tibia.game.CharacterSelectionWidget;
   import flash.events.ErrorEvent;
   import tibia.game.GameEvent;
   import shared.controls.CustomDividedBox;
   import tibia.game.Asset;
   import tibia.game.AccountCharacter;
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
   import flash.utils.getTimer;
   import mx.events.FlexEvent;
   import mx.managers.ToolTipManager;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import shared.utility.SharedObjectManager;
   import tibia.game.LoginWaitWidget;
   import mx.containers.HBox;
   import flash.utils.getDefinitionByName;
   import mx.core.UIComponentDescriptor;
   
   use namespace mx_internal;
   
   public class Tibia extends Application implements IBindingClient, IGameClient
   {
      
      private static const BUNDLE:String = "Tibia";
      
      private static const SHAREDOBJECT_NAME:String = "options";
      
      public static var s_FrameTimestamp:Number = 0;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const MAX_SESSION_KEY_LENGTH:int = 30;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Icons_Conditions_Freezing_png_1857240596:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1657023358:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_121014764:Class;
      
      private var _embed_css_images_Border_Widget_png_725429971:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_989664209:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_350656267:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_361555734:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_634100366:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_108380253:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1592239603:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1599985652:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_748249779:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_1538750171:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1262822250:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1722521826:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1329871019:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_221612016:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_2125911273:Class;
      
      private var _embed_css_images_Border_png_316279808:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_18200976:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1945286065:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Button_Minimize_idle_png_1595894772:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_122547685:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_BG_Widget_Menu_png_922465108:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1797142771:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_71263836:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_224055704:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_526044997:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_862041240:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1395545804:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_659008209:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1539050304:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_864324703:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_683759295:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_420172155:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1336388215:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1795577708:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_792516214:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_899512195:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_585570740:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_309080949:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_2105316678:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_254247527:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1715524184:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_157106118:Class;
      
      private var _embed_css_images_BG_Combat_png_1454180908:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1327708855:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_1101448792:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_2045488740:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1330040532:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_956589365:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_534951815:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1552072914:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_923663499:Class;
      
      private var _embed_css_images_BarsXP_default__png_25825573:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_395105681:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_2052503262:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1298596594:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_95559777:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_2021049018:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_1008814654:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_2141570851:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_1684865653:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1659332391:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_635396688:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2036728445:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1489563001:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_225542507:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_1544126235:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_239969135:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1479670295:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_135562473:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1146163388:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_39318536:Class;
      
      private var _embed_css_images_Border_corners_png_1824711937:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1116501954:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1057640337:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1389655108:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_286375876:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_2080586818:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1711529812:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1511556342:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1778213462:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_2080009056:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_864113951:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_855064764:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1758106818:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1423957335:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_124918649:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_583998320:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_1041084081:Class;
      
      private var m_UncommittedOptions:Boolean = false;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1042399695:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_544127558:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1522365153:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_145874153:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_110401161:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_2037739672:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_2086927199:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1289272435:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1265668183:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_476222850:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1787608846:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_562618232:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_724359760:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_417657819:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_1131888417:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_545286312:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_499717762:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_811923309:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_255302360:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_967623978:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_678067608:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_606401253:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_844447927:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1466658752:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1711333216:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1875288234:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_2068390440:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1803797800:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_1600878139:Class;
      
      private var _embed_css_images_BuySellTab_active_png_855484370:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2099703403:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_799972373:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_2002547573:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_853061655:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1008189242:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Slot_Statusicon_png_1279010030:Class;
      
      private var _embed_css_images_slot_Hotkey_Disabled_png_360860076:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_522380142:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_600138897:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_981746784:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_29286303:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_359700342:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_51715414:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_320994032:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_921497717:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1937976210:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Border_WidgetSidebar_png_166756439:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_184770537:Class;
      
      protected var m_Connection:Connection = null;
      
      private var _embed_css_images_Minimap_png_134470245:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_205224664:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1355130366:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_963853030:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_1138650098:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_858192945:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_389196310:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_618990162:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1994883048:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_1147402483:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_415964218:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_2126064262:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1224162643:Class;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_286660226:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1266086311:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1072239407:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1515717991:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_68263738:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_997058283:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1443384972:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1237787456:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_624784547:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1751797655:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_632925384:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_211255824:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1240986026:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1675226171:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_58718782:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_60932550:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1278661151:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1821561429:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1419647238:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1929384565:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_254479090:Class;
      
      private var _embed_css_images_Inventory_png_214085538:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1831026547:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_483462780:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_758184783:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1692203245:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_365447366:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_77921471:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_438570425:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1498897038:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1824004116:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_239711395:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1490552516:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1864882492:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_885383173:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Slot_container_png_595732916:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_slot_container_disabled_png_1534942081:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_1921307892:Class;
      
      private var _embed_css_images_slot_Hotkey_png_948220375:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1794461253:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_303231702:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_259388509:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_23253184:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_141339333:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_589011889:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1426588906:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_329411955:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_692655415:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1377932916:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_720749468:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1946720889:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_1265082353:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_494884667:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_2003588902:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_1812318709:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_747781062:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1480518599:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_236083245:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_764599931:Class;
      
      protected var m_CharacterList:Array = null;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_906452738:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_213364243:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1611746128:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1353190866:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1883330380:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_140736844:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1384623823:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_136846875:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1202335222:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_740190483:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_616732015:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1807500835:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_451144887:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_170492797:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_710687034:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_627176935:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_625089464:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1799545129:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1038876952:Class;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_687197486:Class;
      
      private var _embed_css_images_Button_Close_over_png_1220638162:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1427670431:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_636005657:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_81227410:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1356172136:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_756752000:Class;
      
      private var _embed_css_images_slot_hotkey_highlighted_png_1475848125:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1389845062:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_265056869:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_68713019:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_1504349010:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1826449662:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_11269515:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1768663341:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_166964819:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_slot_container_png_1973802324:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1483337144:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_350458935:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1390885691:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_412754670:Class;
      
      protected var m_CharacterCurrent:int = -1;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_991690035:Class;
      
      private var _embed_css_images_Button_Close_idle_png_887616722:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_46015120:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_200301:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1064803853:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_653163073:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_692879313:Class;
      
      protected var m_CharacterPending:int = -1;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1753467381:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1978763687:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1512464741:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_959315353:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1750178310:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_878192635:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_507531450:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1804689501:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_1294570386:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1917626490:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1324881426:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Border_WidgetSidebar_slim_png_83238029:Class;
      
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
                                 "styleWithBorder":"sideBarLeftWithBorder",
                                 "styleBorderSearchDirection":1
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":SideBarWidget,
                           "id":"m_UISideBarB",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "styleWithBorder":"sideBarLeftWithBorder",
                                 "styleBorderSearchDirection":1
                              };
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
                              return {
                                 "percentHeight":100,
                                 "styleWithBorder":"sideBarRightWithBorder",
                                 "styleBorderSearchDirection":-1
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":SideBarWidget,
                           "id":"m_UISideBarD",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "styleWithBorder":"sideBarRightWithBorder",
                                 "styleBorderSearchDirection":-1
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_634100366 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_634100366;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_60932550 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_60932550;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1008189242 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1008189242;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1875288234 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1875288234;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_858192945 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_858192945;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1515717991 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1515717991;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_254247527 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_254247527;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_844447927 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_844447927;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_997058283 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_997058283;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_799972373 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_799972373;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1753467381 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1753467381;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_1539050304 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1539050304;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_2068390440 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2068390440;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1803797800 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1803797800;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_39318536 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_39318536;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1711529812 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1711529812;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_1544126235 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_1544126235;
         this._embed_css_images_Arrow_WidgetToggle_over_png_136846875 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_136846875;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_878192635 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_878192635;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1324881426 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1324881426;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1336388215 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1336388215;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1064803853 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1064803853;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1389845062 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1389845062;
         this._embed_css_images_BG_Bars_compact_tileable_png_1768663341 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1768663341;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1821561429 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1821561429;
         this._embed_css_images_BG_Bars_default_enpiece_png_255302360 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_255302360;
         this._embed_css_images_BG_Bars_default_tileable_png_683759295 = Tibia__embed_css_images_BG_Bars_default_tileable_png_683759295;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_811923309 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_811923309;
         this._embed_css_images_BG_Bars_fat_enpiece_png_23253184 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_23253184;
         this._embed_css_images_BG_Bars_fat_tileable_png_1799545129 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1799545129;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1929384565 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1929384565;
         this._embed_css_images_BG_BohemianTileable_Game_png_221612016 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_221612016;
         this._embed_css_images_BG_BohemianTileable_png_1684865653 = Tibia__embed_css_images_BG_BohemianTileable_png_1684865653;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_121014764 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_121014764;
         this._embed_css_images_BG_ChatTab_tileable_png_2003588902 = Tibia__embed_css_images_BG_ChatTab_tileable_png_2003588902;
         this._embed_css_images_BG_Combat_png_1454180908 = Tibia__embed_css_images_BG_Combat_png_1454180908;
         this._embed_css_images_BG_Stone2_Tileable_png_1599985652 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1599985652;
         this._embed_css_images_BG_Widget_Menu_png_922465108 = Tibia__embed_css_images_BG_Widget_Menu_png_922465108;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_451144887 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_451144887;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_747781062 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_747781062;
         this._embed_css_images_BarsHealth_compact_Mana_png_2045488740 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_2045488740;
         this._embed_css_images_BarsHealth_compact_RedFull_png_923663499 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_923663499;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_71263836 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_71263836;
         this._embed_css_images_BarsHealth_compact_RedLow_png_1101448792 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_1101448792;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1751797655 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1751797655;
         this._embed_css_images_BarsHealth_default_GreenFull_png_265056869 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_265056869;
         this._embed_css_images_BarsHealth_default_GreenLow_png_678067608 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_678067608;
         this._embed_css_images_BarsHealth_default_Mana_png_1552072914 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1552072914;
         this._embed_css_images_BarsHealth_default_RedFull_png_200301 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_200301;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1116501954 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1116501954;
         this._embed_css_images_BarsHealth_default_RedLow_png_1917626490 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1917626490;
         this._embed_css_images_BarsHealth_default_Yellow_png_11269515 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_11269515;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_748249779 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_748249779;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_756752000 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_756752000;
         this._embed_css_images_BarsHealth_fat_Mana_png_2126064262 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_2126064262;
         this._embed_css_images_BarsHealth_fat_RedFull_png_1600878139 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1600878139;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1778213462 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1778213462;
         this._embed_css_images_BarsHealth_fat_RedLow_png_687197486 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_687197486;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1804689501 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1804689501;
         this._embed_css_images_BarsXP_default__png_25825573 = Tibia__embed_css_images_BarsXP_default__png_25825573;
         this._embed_css_images_Bars_ProgressMarker_png_1490552516 = Tibia__embed_css_images_Bars_ProgressMarker_png_1490552516;
         this._embed_css_images_Border_WidgetSidebar_png_166756439 = Tibia__embed_css_images_Border_WidgetSidebar_png_166756439;
         this._embed_css_images_Border_WidgetSidebar_slim_png_83238029 = Tibia__embed_css_images_Border_WidgetSidebar_slim_png_83238029;
         this._embed_css_images_Border_Widget_corner_png_1041084081 = Tibia__embed_css_images_Border_Widget_corner_png_1041084081;
         this._embed_css_images_Border_Widget_png_725429971 = Tibia__embed_css_images_Border_Widget_png_725429971;
         this._embed_css_images_Border_corners_png_1824711937 = Tibia__embed_css_images_Border_corners_png_1824711937;
         this._embed_css_images_Border_png_316279808 = Tibia__embed_css_images_Border_png_316279808;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_636005657 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_636005657;
         this._embed_css_images_Button_ChatTabIgnore_over_png_627176935 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_627176935;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_853061655 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_853061655;
         this._embed_css_images_Button_ChatTabNew_idle_png_1946720889 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1946720889;
         this._embed_css_images_Button_ChatTabNew_over_png_124918649 = Tibia__embed_css_images_Button_ChatTabNew_over_png_124918649;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1327708855 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1327708855;
         this._embed_css_images_Button_ChatTab_Close_idle_png_724359760 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_724359760;
         this._embed_css_images_Button_ChatTab_Close_over_png_1611746128 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1611746128;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1237787456 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1237787456;
         this._embed_css_images_Button_Close_idle_png_887616722 = Tibia__embed_css_images_Button_Close_idle_png_887616722;
         this._embed_css_images_Button_Close_over_png_1220638162 = Tibia__embed_css_images_Button_Close_over_png_1220638162;
         this._embed_css_images_Button_Close_pressed_png_1826449662 = Tibia__embed_css_images_Button_Close_pressed_png_1826449662;
         this._embed_css_images_Button_Combat_Stop_idle_png_2125911273 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_2125911273;
         this._embed_css_images_Button_Combat_Stop_over_png_184770537 = Tibia__embed_css_images_Button_Combat_Stop_over_png_184770537;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1266086311 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1266086311;
         this._embed_css_images_Button_ContainerUp_idle_png_415964218 = Tibia__embed_css_images_Button_ContainerUp_idle_png_415964218;
         this._embed_css_images_Button_ContainerUp_over_png_68263738 = Tibia__embed_css_images_Button_ContainerUp_over_png_68263738;
         this._embed_css_images_Button_ContainerUp_pressed_png_359700342 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_359700342;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_692655415 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_692655415;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_350458935 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_350458935;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_254479090 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_254479090;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_1138650098 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_1138650098;
         this._embed_css_images_Button_Maximize_idle_png_1294570386 = Tibia__embed_css_images_Button_Maximize_idle_png_1294570386;
         this._embed_css_images_Button_Maximize_over_png_522380142 = Tibia__embed_css_images_Button_Maximize_over_png_522380142;
         this._embed_css_images_Button_Maximize_pressed_png_1008814654 = Tibia__embed_css_images_Button_Maximize_pressed_png_1008814654;
         this._embed_css_images_Button_Minimize_idle_png_1595894772 = Tibia__embed_css_images_Button_Minimize_idle_png_1595894772;
         this._embed_css_images_Button_Minimize_over_png_1921307892 = Tibia__embed_css_images_Button_Minimize_over_png_1921307892;
         this._embed_css_images_Button_Minimize_pressed_png_1883330380 = Tibia__embed_css_images_Button_Minimize_pressed_png_1883330380;
         this._embed_css_images_Button_Standard_tileable_disabled_png_720749468 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_720749468;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1483337144 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1483337144;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_534951815 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_534951815;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_864113951 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_864113951;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1278661151 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1278661151;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_239969135 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_239969135;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1711333216 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1711333216;
         this._embed_css_images_Button_Standard_tileable_end_over_png_981746784 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_981746784;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_635396688 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_635396688;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1675226171 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1675226171;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_141339333 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_141339333;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_606401253 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_606401253;
         this._embed_css_images_Button_Standard_tileable_idle_png_585570740 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_585570740;
         this._embed_css_images_Button_Standard_tileable_over_png_140736844 = Tibia__embed_css_images_Button_Standard_tileable_over_png_140736844;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1377932916 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1377932916;
         this._embed_css_images_BuySellTab_active_png_855484370 = Tibia__embed_css_images_BuySellTab_active_png_855484370;
         this._embed_css_images_BuySellTab_idle_png_1824004116 = Tibia__embed_css_images_BuySellTab_idle_png_1824004116;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_562618232 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_562618232;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1329871019 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1329871019;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1831026547 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1831026547;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_792516214 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_792516214;
         this._embed_css_images_ChatTab_tileable_idle_png_692879313 = Tibia__embed_css_images_ChatTab_tileable_idle_png_692879313;
         this._embed_css_images_ChatTab_tileable_png_1355130366 = Tibia__embed_css_images_ChatTab_tileable_png_1355130366;
         this._embed_css_images_ChatWindow_Mover_png_1722521826 = Tibia__embed_css_images_ChatWindow_Mover_png_1722521826;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_166964819 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_166964819;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1240986026 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1240986026;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1038876952 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1038876952;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1994883048 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1994883048;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_483462780 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_483462780;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_2086927199 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_2086927199;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1384623823 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1384623823;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1042399695 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1042399695;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1353190866 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1353190866;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1427670431 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1427670431;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_259388509 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_259388509;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_624784547 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_624784547;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_862041240 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_862041240;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_2002547573 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_2002547573;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_239711395 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_239711395;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_108380253 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_108380253;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_68713019 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_68713019;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1657023358 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1657023358;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_320994032 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_320994032;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_211255824 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_211255824;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_618990162 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_618990162;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_1504349010 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_1504349010;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_710687034 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_710687034;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_157106118 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_157106118;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_764599931 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_764599931;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_420172155 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_420172155;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2099703403 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2099703403;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_225542507 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_225542507;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1978763687 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1978763687;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1480518599 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1480518599;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_589011889 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_589011889;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_758184783 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_758184783;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_2141570851 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_2141570851;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1807500835 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1807500835;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_395105681 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_395105681;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_600138897 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_600138897;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_526044997 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_526044997;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1794461253 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1794461253;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_170492797 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_170492797;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2036728445 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2036728445;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1758106818 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1758106818;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_58718782 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_58718782;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1419647238 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1419647238;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1750178310 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1750178310;
         this._embed_css_images_Icons_Conditions_Bleeding_png_46015120 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_46015120;
         this._embed_css_images_Icons_Conditions_Burning_png_885383173 = Tibia__embed_css_images_Icons_Conditions_Burning_png_885383173;
         this._embed_css_images_Icons_Conditions_Cursed_png_967623978 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_967623978;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1466658752 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1466658752;
         this._embed_css_images_Icons_Conditions_Drowning_png_412754670 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_412754670;
         this._embed_css_images_Icons_Conditions_Drunk_png_365447366 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_365447366;
         this._embed_css_images_Icons_Conditions_Electrified_png_1511556342 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1511556342;
         this._embed_css_images_Icons_Conditions_Freezing_png_1857240596 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1857240596;
         this._embed_css_images_Icons_Conditions_Haste_png_236083245 = Tibia__embed_css_images_Icons_Conditions_Haste_png_236083245;
         this._embed_css_images_Icons_Conditions_Hungry_png_350656267 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_350656267;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_956589365 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_956589365;
         this._embed_css_images_Icons_Conditions_MagicShield_png_625089464 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_625089464;
         this._embed_css_images_Icons_Conditions_PZ_png_1937976210 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1937976210;
         this._embed_css_images_Icons_Conditions_PZlock_png_1224162643 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1224162643;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1945286065 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1945286065;
         this._embed_css_images_Icons_Conditions_Slowed_png_545286312 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_545286312;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_959315353 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_959315353;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1797142771 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1797142771;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1592239603 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1592239603;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_740190483 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_740190483;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_476222850 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_476222850;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_286660226 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_286660226;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1787608846 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1787608846;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1389655108 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1389655108;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_507531450 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_507531450;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_499717762 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_499717762;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_2080009056 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_2080009056;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1659332391 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1659332391;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1298596594 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1298596594;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_864324703 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_864324703;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_122547685 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_122547685;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_95559777 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_95559777;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_77921471 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_77921471;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_855064764 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_855064764;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_213364243 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_213364243;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_361555734 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_361555734;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_653163073 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_653163073;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_81227410 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_81227410;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1072239407 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1072239407;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1330040532 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1330040532;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1692203245 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1692203245;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_583998320 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_583998320;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1057640337 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1057640337;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_2080586818 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_2080586818;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_438570425 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_438570425;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1146163388 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1146163388;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_921497717 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_921497717;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1498897038 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1498897038;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1265668183 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1265668183;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_303231702 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_303231702;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1423957335 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1423957335;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1795577708 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1795577708;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_18200976 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_18200976;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_1147402483 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_1147402483;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_2052503262 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_2052503262;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_494884667 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_494884667;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1262822250 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1262822250;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_991690035 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_991690035;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_286375876 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_286375876;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1522365153 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1522365153;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_51715414 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_51715414;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_110401161 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_110401161;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1356172136 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1356172136;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_309080949 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_309080949;
         this._embed_css_images_Inventory_png_214085538 = Tibia__embed_css_images_Inventory_png_214085538;
         this._embed_css_images_Minimap_Center_active_png_1395545804 = Tibia__embed_css_images_Minimap_Center_active_png_1395545804;
         this._embed_css_images_Minimap_Center_idle_png_2021049018 = Tibia__embed_css_images_Minimap_Center_idle_png_2021049018;
         this._embed_css_images_Minimap_Center_over_png_544127558 = Tibia__embed_css_images_Minimap_Center_over_png_544127558;
         this._embed_css_images_Minimap_ZoomIn_idle_png_135562473 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_135562473;
         this._embed_css_images_Minimap_ZoomIn_over_png_1479670295 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1479670295;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1489563001 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1489563001;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1426588906 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1426588906;
         this._embed_css_images_Minimap_ZoomOut_over_png_389196310 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_389196310;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_963853030 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_963853030;
         this._embed_css_images_Minimap_png_134470245 = Tibia__embed_css_images_Minimap_png_134470245;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_224055704 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_224055704;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_2037739672 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_2037739672;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1715524184 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1715524184;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_659008209 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_659008209;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_989664209 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_989664209;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_29286303 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_29286303;
         this._embed_css_images_Scrollbar_Handler_png_145874153 = Tibia__embed_css_images_Scrollbar_Handler_png_145874153;
         this._embed_css_images_Scrollbar_tileable_png_1812318709 = Tibia__embed_css_images_Scrollbar_tileable_png_1812318709;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_417657819 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_417657819;
         this._embed_css_images_Slot_InventoryAmmo_png_1289272435 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1289272435;
         this._embed_css_images_Slot_InventoryArmor_png_2105316678 = Tibia__embed_css_images_Slot_InventoryArmor_png_2105316678;
         this._embed_css_images_Slot_InventoryBackpack_png_1265082353 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1265082353;
         this._embed_css_images_Slot_InventoryBoots_png_1864882492 = Tibia__embed_css_images_Slot_InventoryBoots_png_1864882492;
         this._embed_css_images_Slot_InventoryHead_png_616732015 = Tibia__embed_css_images_Slot_InventoryHead_png_616732015;
         this._embed_css_images_Slot_InventoryLegs_png_1443384972 = Tibia__embed_css_images_Slot_InventoryLegs_png_1443384972;
         this._embed_css_images_Slot_InventoryNecklace_png_1538750171 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1538750171;
         this._embed_css_images_Slot_InventoryRing_png_1131888417 = Tibia__embed_css_images_Slot_InventoryRing_png_1131888417;
         this._embed_css_images_Slot_InventoryShield_png_205224664 = Tibia__embed_css_images_Slot_InventoryShield_png_205224664;
         this._embed_css_images_Slot_InventoryWeapon_png_1390885691 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1390885691;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1202335222 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1202335222;
         this._embed_css_images_Slot_Statusicon_png_1279010030 = Tibia__embed_css_images_Slot_Statusicon_png_1279010030;
         this._embed_css_images_Slot_container_png_595732916 = Tibia__embed_css_images_Slot_container_png_595732916;
         this._embed_css_images_Widget_Footer_tileable_end01_png_906452738 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_906452738;
         this._embed_css_images_Widget_Footer_tileable_end02_png_899512195 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_899512195;
         this._embed_css_images_Widget_Footer_tileable_png_1512464741 = Tibia__embed_css_images_Widget_Footer_tileable_png_1512464741;
         this._embed_css_images_Widget_HeaderBG_png_329411955 = Tibia__embed_css_images_Widget_HeaderBG_png_329411955;
         this._embed_css_images_slot_Hotkey_Disabled_png_360860076 = Tibia__embed_css_images_slot_Hotkey_Disabled_png_360860076;
         this._embed_css_images_slot_Hotkey_png_948220375 = Tibia__embed_css_images_slot_Hotkey_png_948220375;
         this._embed_css_images_slot_container_disabled_png_1534942081 = Tibia__embed_css_images_slot_container_disabled_png_1534942081;
         this._embed_css_images_slot_container_highlighted_png_632925384 = Tibia__embed_css_images_slot_container_highlighted_png_632925384;
         this._embed_css_images_slot_container_png_1973802324 = Tibia__embed_css_images_slot_container_png_1973802324;
         this._embed_css_images_slot_hotkey_highlighted_png_1475848125 = Tibia__embed_css_images_slot_hotkey_highlighted_png_1475848125;
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
      
      public static function s_GetFrameFlash() : Boolean
      {
         return (int(Tibia.s_FrameTimestamp / 300) & 1) != 0;
      }
      
      public static function s_GetChatStorage() : ChatStorage
      {
         return (application as Tibia).m_ChatStorage;
      }
      
      public static function s_GetOptions() : OptionsStorage
      {
         return (application as Tibia).m_Options;
      }
      
      public static function s_GetChatWidget() : ChatWidget
      {
         return (application as Tibia).m_UIChatWidget;
      }
      
      public static function s_GetInstance() : Tibia
      {
         return application as Tibia;
      }
      
      public static function s_GetStatusWidget() : StatusWidget
      {
         return (application as Tibia).m_UIStatusWidget;
      }
      
      public static function s_GetWorldMapStorage() : WorldMapStorage
      {
         return (application as Tibia).m_WorldMapStorage;
      }
      
      public static function s_GetConnection() : Connection
      {
         return (application as Tibia).m_Connection;
      }
      
      public static function s_GetPlayer() : Player
      {
         return (application as Tibia).m_Player;
      }
      
      public static function s_GetAppearanceStorage() : AppearanceStorage
      {
         return (application as Tibia).m_AppearanceStorage;
      }
      
      public static function s_GetCreatureStorage() : CreatureStorage
      {
         return (application as Tibia).m_CreatureStorage;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Tibia._watcherSetupUtil = param1;
      }
      
      public static function s_GetInputHandler() : InputHandler
      {
         return (application as Tibia).m_UIInputHandler;
      }
      
      public static function s_GetSecondaryTimer() : Timer
      {
         return (application as Tibia).m_SeconaryTimer;
      }
      
      public static function s_GetSpellStorage() : SpellStorage
      {
         return (application as Tibia).m_SpellStorage;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIChatWidget() : ChatWidget
      {
         return this._883427326m_UIChatWidget;
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
      
      private function updateClientSize() : void
      {
         if(stage != null)
         {
            width = stage.stageWidth;
            height = stage.stageHeight;
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
      
      protected function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "generalUIGameWindowHeight" || param1.property == "*")
         {
            this.updateCombatTactics();
            this.updateGameWindowSize();
         }
      }
      
      protected function onActivation(param1:Event) : void
      {
         if(param1 != null)
         {
            switch(param1.type)
            {
               case Event.ACTIVATE:
                  break;
               case Event.DEACTIVATE:
                  FocusNotifier.s_Show();
            }
         }
      }
      
      public function setCharacters(param1:String, param2:Array, param3:int) : void
      {
         if(param1 == null || param1.length < 1)
         {
            throw new ArgumentError("Tibia.setCharacters: Invalid session key.");
         }
         if(param2 == null || param2.length < 1)
         {
            throw new ArgumentError("Tibia.setCharacters: Invalid character list.");
         }
         if(param3 < 0 || param3 >= param2.length)
         {
            throw new ArgumentError("Tibia.setCharacters: Invalid pending character.");
         }
         this.m_SessionKey = param1;
         this.m_CharacterList = param2;
         this.m_CharacterCurrent = -1;
         this.m_CharacterPending = param3;
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
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
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
      
      public function saveLocalData() : void
      {
         this.m_ChatStorage.saveChannels();
         this.m_MiniMapStorage.saveSectors(true);
      }
      
      public function logoutCharacter() : void
      {
         if(this.m_Connection == null || !this.m_Connection.isConnected)
         {
            throw new Error("Tibia.logoutCharacter: Not connected.");
         }
         this.saveLocalData();
         this.saveOptions();
         var _loc1_:MessageWidget = new MessageWidget();
         _loc1_.buttonFlags = PopUpBase.BUTTON_YES | PopUpBase.BUTTON_NO;
         _loc1_.message = resourceManager.getString(BUNDLE,"DLG_LOGOUT_TEXT");
         _loc1_.title = resourceManager.getString(BUNDLE,"DLG_LOGOUT_TITLE");
         _loc1_.addEventListener(CloseEvent.CLOSE,this.onConfirmLogoutClose);
         _loc1_.show();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarTop() : HActionBarWidget
      {
         return this._1423351586m_UIActionBarTop;
      }
      
      public function invalidateOptions() : void
      {
         this.m_UncommittedOptions = true;
         invalidateProperties();
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
      
      protected function onConnectionDisconnected(param1:ConnectionEvent) : void
      {
         if(param1 != null)
         {
            visible = false;
            this.resetLocalData();
            this.resetOptions();
            if(this.m_CharacterPending == -1)
            {
               this.changeCharacter();
            }
            else
            {
               this.loginCharacter();
            }
         }
      }
      
      public function resetLocalData() : void
      {
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
         ContextMenuBase.s_HideInstance();
         CursorManager.getInstance().removeAllCursors();
         PopUpBase.s_HideInstance();
         this.invalidateOptions();
      }
      
      public function get isRunning() : Boolean
      {
         return this.m_Connection != null && Boolean(this.m_Connection.isGameRunning);
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
            this.m_UncommittedOptions = true;
            invalidateProperties();
            if(this.m_Options != null)
            {
               this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
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
      
      public function changeCharacter() : void
      {
         if(this.m_Connection != null && Boolean(this.m_Connection.isConnected))
         {
            this.saveLocalData();
            this.saveOptions();
         }
         var _loc1_:CharacterSelectionWidget = new CharacterSelectionWidget();
         _loc1_.characters = this.m_CharacterList;
         _loc1_.selectedCharacter = this.m_CharacterCurrent;
         _loc1_.addEventListener(CloseEvent.CLOSE,this.onConfirmChangeClose);
         _loc1_.show();
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
      
      protected function onConnectionConnected(param1:ConnectionEvent) : void
      {
         if(param1 != null)
         {
            visible = true;
            ContextMenuBase.s_HideInstance();
            PopUpBase.s_HideInstance();
            if(this.m_UIWorldMapWidget != null)
            {
               this.m_UIWorldMapWidget.player = this.m_Player;
            }
            if(this.m_UIStatusWidget != null)
            {
               this.m_UIStatusWidget.player = this.m_Player;
            }
            this.updateCombatTactics();
         }
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
      
      protected function onConfirmChangeClose(param1:CloseEvent) : void
      {
         var _loc2_:GameEvent = null;
         if(param1 != null && param1.currentTarget is CharacterSelectionWidget)
         {
            if(param1.detail == PopUpBase.BUTTON_OKAY && Boolean(this.m_Connection.isConnected))
            {
               this.m_CharacterPending = CharacterSelectionWidget(param1.currentTarget).selectedCharacter;
               if(this.m_Connection != null)
               {
                  this.m_Connection.disconnect(false);
               }
            }
            else if(param1.detail == PopUpBase.BUTTON_OKAY && !this.m_Connection.isConnected)
            {
               this.m_CharacterPending = CharacterSelectionWidget(param1.currentTarget).selectedCharacter;
               this.loginCharacter();
            }
            else if(!(param1.detail != PopUpBase.BUTTON_OKAY && Boolean(this.m_Connection.isConnected)))
            {
               if(param1.detail != PopUpBase.BUTTON_OKAY && !this.m_Connection.isConnected)
               {
                  _loc2_ = new GameEvent(GameEvent.CLOSE,true,false);
                  dispatchEvent(_loc2_);
               }
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
      
      protected function onCancelLogin(param1:CloseEvent) : void
      {
         if(param1 != null && param1.detail == PopUpBase.BUTTON_CANCEL)
         {
            this.m_CharacterPending = -1;
            if(this.m_Connection != null)
            {
               this.m_Connection.disconnect(false);
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
      
      public function setContent(param1:Vector.<Asset>) : void
      {
         if(this.m_AppearanceStorage == null)
         {
            throw new Error("Tibia.setContent: Invalid state.");
         }
         this.m_AppearanceStorage.setContent(param1);
      }
      
      public function loginCharacter() : void
      {
         if(this.m_Connection == null)
         {
            throw new Error("Tibia.loginCharacter: Invalid state.");
         }
         if(this.m_Connection.isConnected)
         {
            throw new Error("Tibia.loginCharacter: Already connected.");
         }
         if(this.m_SessionKey == null || this.m_SessionKey.length < 1)
         {
            throw new ArgumentError("Tibia.loginCharacter: Invalid session key.");
         }
         if(this.m_CharacterList == null || this.m_CharacterList.length < 1)
         {
            throw new ArgumentError("Tibia.loginCharacter: Invalid character list.");
         }
         if(this.m_CharacterPending < 0 || this.m_CharacterPending >= this.m_CharacterList.length)
         {
            throw new ArgumentError("Tibia.loginCharacter: Invalid pending character.");
         }
         this.resetLocalData();
         this.resetOptions();
         this.m_CharacterCurrent = this.m_CharacterPending;
         this.m_CharacterPending = -1;
         var _loc1_:AccountCharacter = AccountCharacter(this.m_CharacterList[this.m_CharacterCurrent]);
         this.m_Connection.connect(this.m_SessionKey,_loc1_.name,_loc1_.address,_loc1_.port);
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedOptions)
         {
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
            this.m_UncommittedOptions = false;
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
      
      protected function onSecondaryTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = getTimer();
         var _loc3_:int = _loc2_ - this.m_SecondaryTimestamp;
         if(_loc3_ > 0 && this.m_Connection != null)
         {
            this.m_Connection.readSocketData();
         }
         this.m_SecondaryTimestamp = _loc2_;
      }
      
      protected function onPreinitialise(param1:FlexEvent) : void
      {
         this.m_AppearanceStorage = new AppearanceStorage();
         this.m_AppearanceStorage.addEventListener(Event.COMPLETE,this.onAppearancesLoadComplete);
         this.m_AppearanceStorage.addEventListener(ErrorEvent.ERROR,this.onAppearancesLoadError);
         this.m_ChatStorage = new ChatStorage();
         this.m_ContainerStorage = new ContainerStorage();
         this.m_CreatureStorage = new CreatureStorage();
         this.m_MiniMapStorage = new MiniMapStorage();
         this.m_Player = this.m_CreatureStorage.player;
         this.m_SpellStorage = new SpellStorage();
         this.m_WorldMapStorage = new WorldMapStorage();
         this.m_Connection = new Connection(this.m_AppearanceStorage,this.m_ChatStorage,this.m_ContainerStorage,this.m_CreatureStorage,this.m_MiniMapStorage,this.m_Player,this.m_SpellStorage,this.m_WorldMapStorage);
         this.m_Connection.addEventListener(ConnectionEvent.ERROR,this.onConnectionEvent);
         this.m_Connection.addEventListener(ConnectionEvent.CONNECTING,this.onConnectionEvent);
         this.m_Connection.addEventListener(ConnectionEvent.LOGINERROR,this.onConnectionEvent);
         this.m_Connection.addEventListener(ConnectionEvent.LOGINADVICE,this.onConnectionEvent);
         this.m_Connection.addEventListener(ConnectionEvent.LOGINWAIT,this.onConnectionLoginWait);
         this.m_Connection.addEventListener(ConnectionEvent.CONNECTED,this.onConnectionConnected);
         this.m_Connection.addEventListener(ConnectionEvent.DEAD,this.onConnectionDeath);
         this.m_Connection.addEventListener(ConnectionEvent.DISCONNECTED,this.onConnectionDisconnected);
         this.m_Connection.addEventListener(ConnectionEvent.CONNECTION_LOST,this.onConnectionLost);
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
      }
      
      protected function onApplicationComplete(param1:FlexEvent) : void
      {
         var a_Event:FlexEvent = param1;
         ToolTipManager.showDelay = 750;
         ToolTipManager.scrubDelay = 0;
         stage.align = StageAlign.TOP_LEFT;
         stage.frameRate = 100;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.showDefaultContextMenu = false;
         stage.addEventListener(Event.RESIZE,function(param1:Event):void
         {
            updateClientSize();
         });
         FocusNotifier.s_Show();
         if(this.m_UICenterColumn != null && this.m_UICenterColumn.numDividers > 0 && this.m_UICenterColumn.getDividerAt(0) != null)
         {
            this.m_UICenterColumn.getDividerAt(0).doubleClickEnabled = true;
            this.m_UICenterColumn.getDividerAt(0).addEventListener(MouseEvent.DOUBLE_CLICK,this.onGameWindowAutofit);
         }
         this.updateClientSize();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarB() : SideBarWidget
      {
         return this._64278964m_UISideBarB;
      }
      
      private function resetOptions() : void
      {
         var _loc1_:int = 0;
         if(this.options != null)
         {
            _loc1_ = 0;
            for each(_loc1_ in this.options.getSideBarSetIDs())
            {
               this.options.getSideBarSet(_loc1_).closeVolatileWidgets();
            }
            for each(_loc1_ in this.options.getBuddySetIDs())
            {
               this.options.getBuddySet(_loc1_).markBuddiesOffline();
            }
            this.invalidateOptions();
            this.saveOptions();
         }
      }
      
      protected function onConnectionDeath(param1:ConnectionEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:MessageWidget = null;
         if(param1 != null)
         {
            visible = true;
            _loc2_ = param1.data is Number?Number(Number(param1.data)):Number(100);
            _loc3_ = new MessageWidget();
            _loc3_.title = resourceManager.getString(BUNDLE,"DLG_DEAD_TITLE");
            if(_loc2_ < 100)
            {
               _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_UNFAIR",[_loc2_]);
            }
            else
            {
               _loc3_.message = resourceManager.getString(BUNDLE,"DLG_DEAD_TEXT_FAIR");
            }
            _loc3_.addEventListener(CloseEvent.CLOSE,this.onConfirmDeathClose);
            _loc3_.show();
         }
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarD() : SideBarWidget
      {
         return this._64278962m_UISideBarD;
      }
      
      private function updateCombatTactics() : void
      {
         if(this.m_Connection != null && Boolean(this.m_Connection.isGameRunning) && this.m_Options != null)
         {
            this.m_Connection.sendCSETTACTICS(this.m_Options.combatAttackMode,this.m_Options.combatChaseMode,this.m_Options.combatSecureMode);
         }
      }
      
      private function saveOptions() : void
      {
         var _SharedObject:SharedObject = null;
         if(this.options != null && Boolean(SharedObjectManager.s_SharedObjectsAvailable()))
         {
            try
            {
               _SharedObject = SharedObjectManager.s_GetInstance().getLocal(SHAREDOBJECT_NAME,true,true);
               if(_SharedObject != null)
               {
                  _SharedObject.data._XML = this.options.marshall();
                  _SharedObject.flush();
               }
               return;
            }
            catch(_Error:Error)
            {
               return;
            }
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
      }
      
      public function ___Tibia_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete(param1);
      }
      
      public function ___Tibia_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialise(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarLeft() : VActionBarWidget
      {
         return this._1174474338m_UIActionBarLeft;
      }
      
      protected function onConnectionEvent(param1:ConnectionEvent) : void
      {
         var _loc2_:MessageWidget = null;
         if(param1 != null)
         {
            visible = false;
            _loc2_ = null;
            switch(param1.type)
            {
               case ConnectionEvent.ERROR:
                  this.resetLocalData();
                  this.resetOptions();
                  _loc2_ = new MessageWidget();
                  _loc2_.buttonFlags = PopUpBase.BUTTON_OKAY;
                  _loc2_.keyboardFlags = PopUpBase.KEY_ENTER;
                  _loc2_.message = resourceManager.getString(BUNDLE,"DLG_ERROR_TEXT_GENERAL",[param1.message]);
                  _loc2_.title = resourceManager.getString(BUNDLE,"DLG_ERROR_TITLE");
                  _loc2_.addEventListener(CloseEvent.CLOSE,this.onCloseErrorMessage);
                  break;
               case ConnectionEvent.CONNECTING:
                  _loc2_ = new MessageWidget();
                  _loc2_.buttonFlags = PopUpBase.BUTTON_CANCEL;
                  _loc2_.keyboardFlags = PopUpBase.KEY_ESCAPE;
                  _loc2_.message = resourceManager.getString(BUNDLE,"DLG_CONNECTING_TEXT",[param1.message]);
                  _loc2_.title = resourceManager.getString(BUNDLE,"DLG_CONNECTING_TITLE");
                  _loc2_.addEventListener(CloseEvent.CLOSE,this.onCancelLogin);
                  break;
               case ConnectionEvent.LOGINADVICE:
                  _loc2_ = new MessageWidget();
                  _loc2_.buttonFlags = PopUpBase.BUTTON_OKAY;
                  _loc2_.keyboardFlags = PopUpBase.KEY_ENTER;
                  _loc2_.message = resourceManager.getString(BUNDLE,"DLG_LOGINADVICE_TEXT",[param1.message]);
                  _loc2_.title = resourceManager.getString(BUNDLE,"DLG_LOGINADVICE_TITLE");
                  break;
               case ConnectionEvent.LOGINERROR:
                  this.resetLocalData();
                  this.resetOptions();
                  _loc2_ = new MessageWidget();
                  _loc2_.buttonFlags = PopUpBase.BUTTON_OKAY;
                  _loc2_.keyboardFlags = PopUpBase.KEY_ENTER;
                  _loc2_.message = resourceManager.getString(BUNDLE,"DLG_LOGINERROR_TEXT",[param1.message]);
                  _loc2_.title = resourceManager.getString(BUNDLE,"DLG_LOGINERROR_TITLE");
                  _loc2_.addEventListener(CloseEvent.CLOSE,this.onCloseErrorMessage);
            }
            if(_loc2_ != null)
            {
               _loc2_.show();
            }
         }
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
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      protected function onConfirmWaitClose(param1:CloseEvent) : void
      {
         if(param1 != null)
         {
            if(param1.detail == LoginWaitWidget.TIMOUT_EXPIRED)
            {
               this.m_CharacterPending = this.m_CharacterCurrent;
            }
            else
            {
               this.m_CharacterPending = -1;
            }
            if(this.m_Connection != null)
            {
               this.m_Connection.disconnect(false);
            }
         }
      }
      
      protected function onConfirmDeathClose(param1:CloseEvent) : void
      {
         if(param1 != null)
         {
            if(param1.detail == PopUpBase.BUTTON_OKAY)
            {
               this.m_CharacterPending = this.m_CharacterCurrent;
            }
            else
            {
               this.m_CharacterPending = -1;
            }
            if(this.m_Connection != null)
            {
               this.m_Connection.disconnect(false);
            }
         }
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
      
      protected function onCloseErrorMessage(param1:CloseEvent) : void
      {
         var _loc2_:GameEvent = null;
         if(param1 != null)
         {
            _loc2_ = new GameEvent(GameEvent.CLOSE,true,false);
            dispatchEvent(_loc2_);
         }
      }
      
      private function loadOptions() : void
      {
         var _SharedObject:SharedObject = null;
         var Options:OptionsStorage = new OptionsStorage();
         if(SharedObjectManager.s_SharedObjectsAvailable())
         {
            try
            {
               _SharedObject = SharedObjectManager.s_GetInstance().getLocal(SHAREDOBJECT_NAME,false,true);
               if(_SharedObject != null && _SharedObject.data._XML != null)
               {
                  Options.unmarshall(_SharedObject.data._XML);
               }
            }
            catch(_Error:Error)
            {
            }
         }
         this.options = Options;
      }
      
      protected function onConnectionLoginWait(param1:ConnectionEvent) : void
      {
         var _loc2_:LoginWaitWidget = null;
         if(param1 != null)
         {
            visible = false;
            _loc2_ = new LoginWaitWidget();
            _loc2_.message = param1.message;
            _loc2_.timeout = Number(param1.data);
            _loc2_.addEventListener(CloseEvent.CLOSE,this.onConfirmWaitClose);
            _loc2_.show();
         }
      }
      
      protected function onConnectionLost(param1:ConnectionEvent) : void
      {
         var a_Event:ConnectionEvent = param1;
         visible = false;
         this.resetLocalData();
         this.resetOptions();
         var Dialog:MessageWidget = new MessageWidget();
         Dialog.buttonFlags = PopUpBase.BUTTON_OKAY;
         Dialog.keyboardFlags = PopUpBase.KEY_ENTER;
         Dialog.message = resourceManager.getString(BUNDLE,"DLG_CONNECTIONLOST_TEXT");
         Dialog.title = resourceManager.getString(BUNDLE,"DLG_CONNECTIONLOST_TITLE");
         Dialog.addEventListener(CloseEvent.CLOSE,function(param1:CloseEvent):void
         {
            changeCharacter();
         });
         Dialog.show();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIGameWindow() : GridContainer
      {
         return this._1404294856m_UIGameWindow;
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
         this.saveOptions();
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
            this.m_Connection.removeEventListener(ConnectionEvent.ERROR,this.onConnectionEvent);
            this.m_Connection.removeEventListener(ConnectionEvent.CONNECTING,this.onConnectionEvent);
            this.m_Connection.removeEventListener(ConnectionEvent.LOGINERROR,this.onConnectionEvent);
            this.m_Connection.removeEventListener(ConnectionEvent.LOGINADVICE,this.onConnectionEvent);
            this.m_Connection.removeEventListener(ConnectionEvent.LOGINWAIT,this.onConnectionLoginWait);
            this.m_Connection.removeEventListener(ConnectionEvent.CONNECTED,this.onConnectionConnected);
            this.m_Connection.removeEventListener(ConnectionEvent.DEAD,this.onConnectionDeath);
            this.m_Connection.removeEventListener(ConnectionEvent.DISCONNECTED,this.onConnectionDisconnected);
            this.m_Connection.removeEventListener(ConnectionEvent.CONNECTION_LOST,this.onConnectionLost);
            this.m_Connection.disconnect(true);
         }
         if(this.m_SeconaryTimer != null)
         {
            this.m_SeconaryTimer.stop();
         }
         if(this.m_UIInputHandler != null)
         {
            this.m_UIInputHandler.dispose();
         }
         ContextMenuBase.s_HideInstance();
         CursorManager.getInstance().removeAllCursors();
         FocusNotifier.s_Hide();
         PopUpBase.s_HideInstance();
         this.invalidateOptions();
      }
      
      protected function onGameWindowAutofit(param1:MouseEvent) : void
      {
         this.autofitGameWindow();
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
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarRight() : VActionBarWidget
      {
         return this._2043305115m_UIActionBarRight;
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
      
      protected function onConfirmLogoutClose(param1:CloseEvent) : void
      {
         if(param1 != null && param1.detail == PopUpBase.BUTTON_YES)
         {
            this.m_CharacterPending = -1;
            if(this.m_Connection != null)
            {
               this.m_Connection.disconnect(false);
            }
         }
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

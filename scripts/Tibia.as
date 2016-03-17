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
   import tibia.controls.GameWindowContainer;
   import tibia.sidebar.SideBarWidget;
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
   import tibia.game.AccountCharacter;
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
       
      private var _embed_css_images_Button_Standard_tileable_idle_png_148808452:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_135113643:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_435475614:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2128139613:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_889041046:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_556408320:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1602963928:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1594705919:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_204060124:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_2035260131:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_968496943:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_855682314:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1925610710:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1462400689:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1983164961:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1042218520:Class;
      
      private var _embed_css_images_BarsXP_default__png_241183379:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1508388436:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1943076366:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_126597720:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1078128833:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1834415478:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_1555070544:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1726170977:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_993778665:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_1279624509:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1482200631:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_764599219:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_661732873:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1116746466:Class;
      
      private var _embed_css_images_Border_corners_png_2023918105:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_625984097:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_2076428681:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_225551779:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_690742924:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_826734975:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_539456679:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_665252171:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_2036110770:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1125769323:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_1152177139:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_56557209:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_392284041:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1813625055:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_40331586:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_210008846:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_555350945:Class;
      
      private var _embed_css_images_Border_png_181538536:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1326895293:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_939733351:Class;
      
      private var _embed_css_images_BG_Combat_png_1586817428:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_2023417226:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_420173491:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1399983422:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1748085256:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_893682313:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_836791249:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1462534626:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1070991667:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_1072346713:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1272191020:Class;
      
      private var _embed_css_images_Minimap_png_539883437:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_981234497:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_741828390:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1781665804:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1696240854:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_920655988:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_451967845:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1518709431:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_1933655920:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1724128695:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_34367658:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_2023021083:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_597318675:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_134882928:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_291820759:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1701183413:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_576851969:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_21219609:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_471764192:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_652103922:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_550320607:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_96149577:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_2092384957:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_ChatWindow_Mover_png_1900692486:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979643686:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_345112918:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1424151770:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_320730784:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1613137371:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_309972715:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_371818677:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_97650224:Class;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_1614898427:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_595892287:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_22904974:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_734911803:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_99565626:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_487004907:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1897987723:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1730770291:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_2052816092:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1407190747:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1198089029:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1069199829:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_363566523:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_841114392:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1583887316:Class;
      
      private var _embed_css_images_Border_Widget_png_195479963:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_568336571:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1619213349:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_557519456:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_921742799:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1070642207:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_458368136:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1887168658:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1612459016:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_497229744:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1723207357:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_606400045:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1923694624:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1604393271:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_2117694636:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_463562404:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1480517775:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_2079623590:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_657817844:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1551498460:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_4464014:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1124887113:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_898009120:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_664203966:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_369352423:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_930485706:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_510745480:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_119432024:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1860566099:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_803568649:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1733710724:Class;
      
      protected var m_Connection:Connection = null;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1842712928:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_896491306:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1591601723:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1501538246:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_741351619:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_2130446918:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_72684803:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_554650090:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_1224358542:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_936356287:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1990775840:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_556156111:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_873385372:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1797135675:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_1397569800:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_335590330:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1817678900:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_326246189:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_125036733:Class;
      
      private var _embed_css_images_Button_Close_over_png_1084429450:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_515541885:Class;
      
      private var _embed_css_images_Slot_container_png_1193405804:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_1866775356:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_63599830:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_34266056:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1077476539:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1705975080:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1475336024:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_950660970:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_885515405:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_737408945:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_580903300:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1411444975:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_399834937:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_2007337517:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1247522442:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_952857130:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1880265705:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_416353204:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_201769468:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Border_WidgetSidebar_slim_png_424951365:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_101019835:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_27651214:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1244703550:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_985483836:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_219788403:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_361444386:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_682898618:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_988615283:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1361069964:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1619266109:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_459904592:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_423180984:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1822456270:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_2048153102:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_171195209:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1093288160:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_235874402:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1531648495:Class;
      
      protected var m_CharacterList:Array = null;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_1902299087:Class;
      
      private var _embed_css_images_slot_container_disabled_png_2137241417:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1689317661:Class;
      
      private var _embed_css_images_slot_Hotkey_Disabled_png_700705636:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_822786839:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_621860910:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_2128098526:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_206995917:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1789184434:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1120798623:Class;
      
      private var _embed_css_images_Button_Close_idle_png_1285395338:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_BG_Widget_Menu_png_723226380:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1758298854:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1778808826:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1704315820:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_94983834:Class;
      
      private var _embed_css_images_slot_hotkey_highlighted_png_1532068469:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Inventory_png_609939642:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_847420630:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_185372023:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1794312829:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1062126242:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1623596047:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1375984156:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_2136773261:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_1204168202:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1615977166:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_601657483:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_898241123:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1170583141:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_920444702:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_509999218:Class;
      
      private var _embed_css_images_Border_WidgetSidebar_png_112355087:Class;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_1027937683:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1419676331:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_144943595:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_1438960362:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_358368877:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1684158031:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_925055113:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_222143144:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_2124635934:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_541284819:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_58623873:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_880106354:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_1009612658:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1492698343:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_405353892:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_537162781:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_389736568:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730505929:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Slot_Statusicon_png_1006897494:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1332718595:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_347046408:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_723993945:Class;
      
      protected var m_CharacterCurrent:int = -1;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1114994446:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_138823130:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_391218335:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1066125936:Class;
      
      private var _embed_css_images_slot_Hotkey_png_347779727:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_141032050:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_658239231:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1122909049:Class;
      
      protected var m_CharacterPending:int = -1;
      
      private var _embed_css_images_slot_container_png_1723492084:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_235008141:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1141885872:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_493160670:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_1025748096:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1483338496:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_659521477:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_2026805409:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_2144981795:Class;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_34367658 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_34367658;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_4464014 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_4464014;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_880106354 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_880106354;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1462534626 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1462534626;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_56557209 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_56557209;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1120798623 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1120798623;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_391218335 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_391218335;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1594705919 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1594705919;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1070991667 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1070991667;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_206995917 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_206995917;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1619266109 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1619266109;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_1612459016 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1612459016;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_1933655920 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_1933655920;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1066125936 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1066125936;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_97650224 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_97650224;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1375984156 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1375984156;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_541284819 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_541284819;
         this._embed_css_images_Arrow_WidgetToggle_over_png_326246189 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_326246189;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_741351619 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_741351619;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_930485706 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_930485706;
         this._embed_css_images_BG_BarsXP_default_tileable_png_936356287 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_936356287;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_659521477 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_659521477;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1114994446 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1114994446;
         this._embed_css_images_BG_Bars_compact_tileable_png_1170583141 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1170583141;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1689317661 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1689317661;
         this._embed_css_images_BG_Bars_default_enpiece_png_320730784 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_320730784;
         this._embed_css_images_BG_Bars_default_tileable_png_539456679 = Tibia__embed_css_images_BG_Bars_default_tileable_png_539456679;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1069199829 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1069199829;
         this._embed_css_images_BG_Bars_fat_enpiece_png_389736568 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_389736568;
         this._embed_css_images_BG_Bars_fat_tileable_png_1726170977 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1726170977;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1723207357 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1723207357;
         this._embed_css_images_BG_BohemianTileable_Game_png_347046408 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_347046408;
         this._embed_css_images_BG_BohemianTileable_png_2092384957 = Tibia__embed_css_images_BG_BohemianTileable_png_2092384957;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_204060124 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_204060124;
         this._embed_css_images_BG_ChatTab_tileable_png_1887168658 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1887168658;
         this._embed_css_images_BG_Combat_png_1586817428 = Tibia__embed_css_images_BG_Combat_png_1586817428;
         this._embed_css_images_BG_Stone2_Tileable_png_1272191020 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1272191020;
         this._embed_css_images_BG_Widget_Menu_png_723226380 = Tibia__embed_css_images_BG_Widget_Menu_png_723226380;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_658239231 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_658239231;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_1224358542 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_1224358542;
         this._embed_css_images_BarsHealth_compact_Mana_png_1704315820 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1704315820;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1860566099 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1860566099;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_463562404 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_463562404;
         this._embed_css_images_BarsHealth_compact_RedLow_png_898009120 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_898009120;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1684158031 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1684158031;
         this._embed_css_images_BarsHealth_default_GreenFull_png_537162781 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_537162781;
         this._embed_css_images_BarsHealth_default_GreenLow_png_1555070544 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1555070544;
         this._embed_css_images_BarsHealth_default_Mana_png_2023417226 = Tibia__embed_css_images_BarsHealth_default_Mana_png_2023417226;
         this._embed_css_images_BarsHealth_default_RedFull_png_665252171 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_665252171;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1778808826 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1778808826;
         this._embed_css_images_BarsHealth_default_RedLow_png_1789184434 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1789184434;
         this._embed_css_images_BarsHealth_default_Yellow_png_125036733 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_125036733;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_1614898427 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_1614898427;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_423180984 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_423180984;
         this._embed_css_images_BarsHealth_fat_Mana_png_2036110770 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_2036110770;
         this._embed_css_images_BarsHealth_fat_RedFull_png_988615283 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_988615283;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_2124635934 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_2124635934;
         this._embed_css_images_BarsHealth_fat_RedLow_png_889041046 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_889041046;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1198089029 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1198089029;
         this._embed_css_images_BarsXP_default__png_241183379 = Tibia__embed_css_images_BarsXP_default__png_241183379;
         this._embed_css_images_Bars_ProgressMarker_png_1361069964 = Tibia__embed_css_images_Bars_ProgressMarker_png_1361069964;
         this._embed_css_images_Border_WidgetSidebar_png_112355087 = Tibia__embed_css_images_Border_WidgetSidebar_png_112355087;
         this._embed_css_images_Border_WidgetSidebar_slim_png_424951365 = Tibia__embed_css_images_Border_WidgetSidebar_slim_png_424951365;
         this._embed_css_images_Border_Widget_corner_png_21219609 = Tibia__embed_css_images_Border_Widget_corner_png_21219609;
         this._embed_css_images_Border_Widget_png_195479963 = Tibia__embed_css_images_Border_Widget_png_195479963;
         this._embed_css_images_Border_corners_png_2023918105 = Tibia__embed_css_images_Border_corners_png_2023918105;
         this._embed_css_images_Border_png_181538536 = Tibia__embed_css_images_Border_png_181538536;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_836791249 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_836791249;
         this._embed_css_images_Button_ChatTabIgnore_over_png_968496943 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_968496943;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_921742799 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_921742799;
         this._embed_css_images_Button_ChatTabNew_idle_png_1462400689 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1462400689;
         this._embed_css_images_Button_ChatTabNew_over_png_737408945 = Tibia__embed_css_images_Button_ChatTabNew_over_png_737408945;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1531648495 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1531648495;
         this._embed_css_images_Button_ChatTab_Close_idle_png_1397569800 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1397569800;
         this._embed_css_images_Button_ChatTab_Close_over_png_1748085256 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1748085256;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1705975080 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1705975080;
         this._embed_css_images_Button_Close_idle_png_1285395338 = Tibia__embed_css_images_Button_Close_idle_png_1285395338;
         this._embed_css_images_Button_Close_over_png_1084429450 = Tibia__embed_css_images_Button_Close_over_png_1084429450;
         this._embed_css_images_Button_Close_pressed_png_1501538246 = Tibia__embed_css_images_Button_Close_pressed_png_1501538246;
         this._embed_css_images_Button_Combat_Stop_idle_png_1902299087 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1902299087;
         this._embed_css_images_Button_Combat_Stop_over_png_556156111 = Tibia__embed_css_images_Button_Combat_Stop_over_png_556156111;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1411444975 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1411444975;
         this._embed_css_images_Button_ContainerUp_idle_png_1009612658 = Tibia__embed_css_images_Button_ContainerUp_idle_png_1009612658;
         this._embed_css_images_Button_ContainerUp_over_png_141032050 = Tibia__embed_css_images_Button_ContainerUp_over_png_141032050;
         this._embed_css_images_Button_ContainerUp_pressed_png_40331586 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_40331586;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_826734975 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_826734975;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_58623873 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_58623873;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_855682314 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_855682314;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_1204168202 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_1204168202;
         this._embed_css_images_Button_Maximize_idle_png_952857130 = Tibia__embed_css_images_Button_Maximize_idle_png_952857130;
         this._embed_css_images_Button_Maximize_over_png_847420630 = Tibia__embed_css_images_Button_Maximize_over_png_847420630;
         this._embed_css_images_Button_Maximize_pressed_png_741828390 = Tibia__embed_css_images_Button_Maximize_pressed_png_741828390;
         this._embed_css_images_Button_Minimize_idle_png_985483836 = Tibia__embed_css_images_Button_Minimize_idle_png_985483836;
         this._embed_css_images_Button_Minimize_over_png_1866775356 = Tibia__embed_css_images_Button_Minimize_over_png_1866775356;
         this._embed_css_images_Button_Minimize_pressed_png_1817678900 = Tibia__embed_css_images_Button_Minimize_pressed_png_1817678900;
         this._embed_css_images_Button_Standard_tileable_disabled_png_580903300 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_580903300;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1483338496 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1483338496;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_595892287 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_595892287;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1604393271 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1604393271;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1482200631 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1482200631;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_171195209 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_171195209;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1042218520 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1042218520;
         this._embed_css_images_Button_Standard_tileable_end_over_png_841114392 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_841114392;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_34266056 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_34266056;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1332718595 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1332718595;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_72684803 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_72684803;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_606400045 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_606400045;
         this._embed_css_images_Button_Standard_tileable_idle_png_148808452 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_148808452;
         this._embed_css_images_Button_Standard_tileable_over_png_201769468 = Tibia__embed_css_images_Button_Standard_tileable_over_png_201769468;
         this._embed_css_images_Button_Standard_tileable_pressed_png_2117694636 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_2117694636;
         this._embed_css_images_BuySellTab_active_png_1247522442 = Tibia__embed_css_images_BuySellTab_active_png_1247522442;
         this._embed_css_images_BuySellTab_idle_png_1551498460 = Tibia__embed_css_images_BuySellTab_idle_png_1551498460;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_497229744 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_497229744;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_597318675 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_597318675;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1897987723 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1897987723;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_664203966 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_664203966;
         this._embed_css_images_ChatTab_tileable_idle_png_893682313 = Tibia__embed_css_images_ChatTab_tileable_idle_png_893682313;
         this._embed_css_images_ChatTab_tileable_png_1758298854 = Tibia__embed_css_images_ChatTab_tileable_png_1758298854;
         this._embed_css_images_ChatWindow_Mover_png_1900692486 = Tibia__embed_css_images_ChatWindow_Mover_png_1900692486;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_309972715 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_309972715;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1116746466 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1116746466;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1093288160 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1093288160;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1923694624 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1923694624;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_416353204 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_416353204;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_2076428681 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_2076428681;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1518709431 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1518709431;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1724128695 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1724128695;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_950660970 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_950660970;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1492698343 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1492698343;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_144943595 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_144943595;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_487004907 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_487004907;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_459904592 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_459904592;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_2136773261 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_2136773261;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_363566523 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_363566523;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_568336571 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_568336571;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_885515405 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_885515405;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_2130446918 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_2130446918;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_126597720 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_126597720;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_222143144 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_222143144;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_554650090 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_554650090;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_1438960362 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_1438960362;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_509999218 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_509999218;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_22904974 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_22904974;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_764599219 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_764599219;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_420173491 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_420173491;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2128139613 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_2128139613;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_225551779 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_225551779;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1983164961 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1983164961;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1480517775 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1480517775;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_993778665 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_993778665;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_822786839 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_822786839;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1407190747 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1407190747;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1613137371 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1613137371;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_1072346713 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_1072346713;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_723993945 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_723993945;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_515541885 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_515541885;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1794312829 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1794312829;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_371818677 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_371818677;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1701183413 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1701183413;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1424151770 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1424151770;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_138823130 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_138823130;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1822456270 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1822456270;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1615977166 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1615977166;
         this._embed_css_images_Icons_Conditions_Bleeding_png_119432024 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_119432024;
         this._embed_css_images_Icons_Conditions_Burning_png_1279624509 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1279624509;
         this._embed_css_images_Icons_Conditions_Cursed_png_235874402 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_235874402;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1602963928 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1602963928;
         this._embed_css_images_Icons_Conditions_Drowning_png_345112918 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_345112918;
         this._embed_css_images_Icons_Conditions_Drunk_png_27651214 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_27651214;
         this._embed_css_images_Icons_Conditions_Electrified_png_1244703550 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1244703550;
         this._embed_css_images_Icons_Conditions_Freezing_png_2052816092 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_2052816092;
         this._embed_css_images_Icons_Conditions_Haste_png_451967845 = Tibia__embed_css_images_Icons_Conditions_Haste_png_451967845;
         this._embed_css_images_Icons_Conditions_Hungry_png_1152177139 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_1152177139;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_358368877 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_358368877;
         this._embed_css_images_Icons_Conditions_MagicShield_png_556408320 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_556408320;
         this._embed_css_images_Icons_Conditions_PZ_png_1696240854 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1696240854;
         this._embed_css_images_Icons_Conditions_PZlock_png_2023021083 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_2023021083;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1880265705 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1880265705;
         this._embed_css_images_Icons_Conditions_Slowed_png_471764192 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_471764192;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_625984097 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_625984097;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1797135675 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1797135675;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1591601723 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1591601723;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1419676331 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1419676331;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_335590330 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_335590330;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_682898618 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_682898618;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1925610710 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1925610710;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1781665804 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1781665804;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_652103922 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_652103922;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_94983834 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_94983834;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1475336024 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1475336024;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_2026805409 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_2026805409;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_896491306 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_896491306;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_185372023 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_185372023;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_898241123 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_898241123;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_369352423 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_369352423;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_661732873 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_661732873;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_657817844 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_657817844;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_135113643 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_135113643;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_493160670 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_493160670;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1122909049 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1122909049;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_63599830 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_63599830;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_939733351 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_939733351;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_873385372 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_873385372;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1619213349 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1619213349;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_510745480 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_510745480;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1124887113 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1124887113;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_2079623590 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_2079623590;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_576851969 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_576851969;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_405353892 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_405353892;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1326895293 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1326895293;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1834415478 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1834415478;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1070642207 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1070642207;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_435475614 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_435475614;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1623596047 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1623596047;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1583887316 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1583887316;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_458368136 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_458368136;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_734911803 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_734911803;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979643686 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1979643686;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_219788403 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_219788403;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1062126242 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1062126242;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1125769323 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1125769323;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_690742924 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_690742924;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730505929 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1730505929;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_920444702 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_920444702;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_981234497 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_981234497;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1141885872 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1141885872;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_235008141 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_235008141;
         this._embed_css_images_Inventory_png_609939642 = Tibia__embed_css_images_Inventory_png_609939642;
         this._embed_css_images_Minimap_Center_active_png_1733710724 = Tibia__embed_css_images_Minimap_Center_active_png_1733710724;
         this._embed_css_images_Minimap_Center_idle_png_1943076366 = Tibia__embed_css_images_Minimap_Center_idle_png_1943076366;
         this._embed_css_images_Minimap_Center_over_png_210008846 = Tibia__embed_css_images_Minimap_Center_over_png_210008846;
         this._embed_css_images_Minimap_ZoomIn_idle_png_550320607 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_550320607;
         this._embed_css_images_Minimap_ZoomIn_over_png_1813625055 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1813625055;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1078128833 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1078128833;
         this._embed_css_images_Minimap_ZoomOut_idle_png_2128098526 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_2128098526;
         this._embed_css_images_Minimap_ZoomOut_over_png_361444386 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_361444386;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_621860910 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_621860910;
         this._embed_css_images_Minimap_png_539883437 = Tibia__embed_css_images_Minimap_png_539883437;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_557519456 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_557519456;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1842712928 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1842712928;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1990775840 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1990775840;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_392284041 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_392284041;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_925055113 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_925055113;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_96149577 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_96149577;
         this._embed_css_images_Scrollbar_Handler_png_555350945 = Tibia__embed_css_images_Scrollbar_Handler_png_555350945;
         this._embed_css_images_Scrollbar_tileable_png_2007337517 = Tibia__embed_css_images_Scrollbar_tileable_png_2007337517;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_1027937683 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1027937683;
         this._embed_css_images_Slot_InventoryAmmo_png_1077476539 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1077476539;
         this._embed_css_images_Slot_InventoryArmor_png_2048153102 = Tibia__embed_css_images_Slot_InventoryArmor_png_2048153102;
         this._embed_css_images_Slot_InventoryBackpack_png_803568649 = Tibia__embed_css_images_Slot_InventoryBackpack_png_803568649;
         this._embed_css_images_Slot_InventoryBoots_png_920655988 = Tibia__embed_css_images_Slot_InventoryBoots_png_920655988;
         this._embed_css_images_Slot_InventoryHead_png_291820759 = Tibia__embed_css_images_Slot_InventoryHead_png_291820759;
         this._embed_css_images_Slot_InventoryLegs_png_1508388436 = Tibia__embed_css_images_Slot_InventoryLegs_png_1508388436;
         this._embed_css_images_Slot_InventoryNecklace_png_2144981795 = Tibia__embed_css_images_Slot_InventoryNecklace_png_2144981795;
         this._embed_css_images_Slot_InventoryRing_png_399834937 = Tibia__embed_css_images_Slot_InventoryRing_png_399834937;
         this._embed_css_images_Slot_InventoryShield_png_134882928 = Tibia__embed_css_images_Slot_InventoryShield_png_134882928;
         this._embed_css_images_Slot_InventoryWeapon_png_1730770291 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1730770291;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1399983422 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1399983422;
         this._embed_css_images_Slot_Statusicon_png_1006897494 = Tibia__embed_css_images_Slot_Statusicon_png_1006897494;
         this._embed_css_images_Slot_container_png_1193405804 = Tibia__embed_css_images_Slot_container_png_1193405804;
         this._embed_css_images_Widget_Footer_tileable_end01_png_99565626 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_99565626;
         this._embed_css_images_Widget_Footer_tileable_end02_png_101019835 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_101019835;
         this._embed_css_images_Widget_Footer_tileable_png_2035260131 = Tibia__embed_css_images_Widget_Footer_tileable_png_2035260131;
         this._embed_css_images_Widget_HeaderBG_png_601657483 = Tibia__embed_css_images_Widget_HeaderBG_png_601657483;
         this._embed_css_images_slot_Hotkey_Disabled_png_700705636 = Tibia__embed_css_images_slot_Hotkey_Disabled_png_700705636;
         this._embed_css_images_slot_Hotkey_png_347779727 = Tibia__embed_css_images_slot_Hotkey_png_347779727;
         this._embed_css_images_slot_container_disabled_png_2137241417 = Tibia__embed_css_images_slot_container_disabled_png_2137241417;
         this._embed_css_images_slot_container_highlighted_png_1025748096 = Tibia__embed_css_images_slot_container_highlighted_png_1025748096;
         this._embed_css_images_slot_container_png_1723492084 = Tibia__embed_css_images_slot_container_png_1723492084;
         this._embed_css_images_slot_hotkey_highlighted_png_1532068469 = Tibia__embed_css_images_slot_hotkey_highlighted_png_1532068469;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIChatWidget() : ChatWidget
      {
         return this._883427326m_UIChatWidget;
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
      public function get m_UIWorldMapWidget() : WorldMapWidget
      {
         return this._1314206572m_UIWorldMapWidget;
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
      
      public function invalidateOptions() : void
      {
         this.m_UncommittedOptions = true;
         invalidateProperties();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarTop() : HActionBarWidget
      {
         return this._1423351586m_UIActionBarTop;
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
      
      private function _Tibia_Array2_i() : Array
      {
         var _loc1_:Array = [undefined,undefined];
         this._Tibia_Array2 = _loc1_;
         BindingManager.executeBindings(this,"_Tibia_Array2",this._Tibia_Array2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarLeft() : VActionBarWidget
      {
         return this._1174474338m_UIActionBarLeft;
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
      
      public function setContent(param1:Vector.<Asset>) : void
      {
         if(this.m_AppearanceStorage == null)
         {
            throw new Error("Tibia.setContent: Invalid state.");
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
      }
      
      public function ___Tibia_Application1_deactivate(param1:Event) : void
      {
         this.onActivation(param1);
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
      
      public function ___Tibia_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
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
      
      public function ___Tibia_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialise(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
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
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
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
      public function get m_UIInputHandler() : InputHandler
      {
         return this._748017946m_UIInputHandler;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIStatusWidget() : StatusWidget
      {
         return this._228925540m_UIStatusWidget;
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

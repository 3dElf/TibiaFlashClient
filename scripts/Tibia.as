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
       
      private var _embed_css_images_Slot_InventoryWeapon_png_1527207259:Class;
      
      private var _embed_css_images_slot_Hotkey_png_211611383:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1381241380:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1290363922:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1000595027:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_2115005804:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_222423235:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_499859160:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1623802195:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_296590702:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_752743330:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1969839328:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_425911798:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_73370994:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_666329820:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_739006055:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_520153298:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_151376169:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_1237871417:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_1002764401:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1517490293:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_71339464:Class;
      
      private var _embed_css_images_Button_Close_over_png_1692078962:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_323403345:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1271916107:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_476474355:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_918397116:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_702066838:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1341762219:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_831761230:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_1459448660:Class;
      
      private var _embed_css_images_Border_Widget_png_335866867:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_562489394:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1175311050:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_558795064:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1420946354:Class;
      
      private var _embed_css_images_Minimap_png_474331013:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1344499232:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1341237787:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1364739172:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1070346582:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1000842579:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_151746135:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_2110015596:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_2019236557:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1005985190:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1117165525:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_585524592:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_729767425:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_1124481946:Class;
      
      private var _embed_css_images_Slot_container_png_1398393684:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_309033599:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_2095366135:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_1158247026:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1810271124:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_624055718:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1909921966:Class;
      
      private var _embed_css_images_Inventory_png_54220158:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1409797015:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_669240608:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_657812724:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_817338022:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_1963141431:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_33242016:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1626179230:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_522625606:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_916986780:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_867602807:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_184535153:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_213369072:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_964093014:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_147342370:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1675744797:Class;
      
      private var _embed_css_images_slot_container_disabled_png_2007324257:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_1157080528:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_2085935731:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_1268062192:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_933434509:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_413238117:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_622462549:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_404386466:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_344484424:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_344798711:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1791607879:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_253207080:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_655198065:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1290797177:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1150665864:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1318288436:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_767711875:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1587391858:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1677644031:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_279413387:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1450088930:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1299180234:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1436912205:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_707409237:Class;
      
      private var m_UncommittedOptions:Boolean = false;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_959000217:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_637782225:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_40526129:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1416094019:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_1410477920:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_801256325:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_682430469:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_462552837:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_758175750:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1903257287:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_998389451:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1124061077:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1194808363:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_951419590:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1407657383:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1248958673:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_854113408:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_88731899:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_99559434:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_2034883700:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_2141536654:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1899228090:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_941718011:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_418443740:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_387640672:Class;
      
      private var _embed_css_images_slot_hotkey_highlighted_png_1938924189:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_784135638:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_921121793:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_2144976119:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_556332591:Class;
      
      private var _embed_css_images_Border_png_415757152:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_335822355:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_68385208:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_1543124203:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1880116544:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1249043223:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_1019385487:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1387480445:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1178347904:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_1318658849:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_2055643781:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_531384213:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_117554192:Class;
      
      private var _embed_css_images_slot_container_png_1518504204:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1931959752:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_775994010:Class;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_921186359:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_982757427:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1985762022:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_2140567312:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_23630671:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1604085827:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1503474552:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_11025348:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1875248577:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_873141914:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1225689215:Class;
      
      protected var m_Connection:Connection = null;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_805785695:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_106630582:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_663345881:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_2042925722:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_810081208:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_683734871:Class;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1261926374:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1154567772:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_804816603:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_556227011:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_531406005:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1130855288:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2057729164:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_1272737619:Class;
      
      private var _embed_css_images_BG_Combat_png_648742988:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_547452148:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_877665844:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_10813834:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1878181214:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_365649629:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_809194495:Class;
      
      private var _embed_css_images_BarsXP_default__png_375261627:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_1543364901:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_19092426:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_1099028355:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_730815953:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1398806194:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_547987866:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1128515592:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1694144910:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1665994164:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_893475227:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1212814775:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_399276006:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_2096029589:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_535107953:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1331098311:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_1173636374:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_19847903:Class;
      
      private var _embed_css_images_Border_corners_png_2089337953:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_2002639124:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_931433521:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_296329250:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_1523670977:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1382869978:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1749742289:Class;
      
      private var _embed_css_images_Button_Close_idle_png_1896321650:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_315622480:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1118692203:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1988031678:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1325680853:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_64297755:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_973783515:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_765731183:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_1099020231:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_780335319:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_1062418523:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1017077146:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_235331199:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1451387486:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_1973103532:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_177198248:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_298266787:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1861158218:Class;
      
      protected var m_CharacterList:Array = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_455381823:Class;
      
      private var _embed_css_images_slot_Hotkey_Disabled_png_494529356:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_760132907:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1296563255:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_399123302:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_137203955:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_791230420:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_601662676:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1393476490:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_2069345467:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_380431240:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1709565405:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_1080682567:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_89258761:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_939122702:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_321409754:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1158271000:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Slot_Statusicon_png_1610877454:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_581910765:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_1425631198:Class;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_940927079:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_1430440242:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_2007450888:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1000403023:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1388607585:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_519002448:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_380941097:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1766502261:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1521727426:Class;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_831153521:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1690159070:Class;
      
      private var _embed_css_images_Border_WidgetSidebar_slim_png_622616429:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_571818864:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_1405381074:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_116498503:Class;
      
      private var _embed_css_images_Icons_ProgressBarsProgressOff_png_792670886:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_1348534547:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1834208132:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1977802442:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1591562341:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1101669176:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_311478629:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_163358263:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_165148058:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Button_Maximize_over_png_1195572366:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_65335859:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1112154863:Class;
      
      protected var m_CharacterCurrent:int = -1;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_171501086:Class;
      
      private var _embed_css_images_Border_WidgetSidebar_png_570058551:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_657878775:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1423885267:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1796233388:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_1356436136:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1731999827:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_242880473:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1459589103:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_776608077:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1850105326:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1611725542:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_87373019:Class;
      
      protected var m_CharacterPending:int = -1;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1406163417:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_2107174024:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1415764770:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_566863204:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1928342343:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_1063571960:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_553448699:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_819578645:Class;
      
      mx_internal var _bindings:Array;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_296590702 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_296590702;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_399123302 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_399123302;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1017077146 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1017077146;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1393476490 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1393476490;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_323403345 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_323403345;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1928342343 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1928342343;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_116498503 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_116498503;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1249043223 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1249043223;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1271916107 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1271916107;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_531406005 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_531406005;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_819578645 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_819578645;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_669240608 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_669240608;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_2007450888 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2007450888;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1128515592 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1128515592;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_177198248 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_177198248;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_2034883700 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_2034883700;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_941718011 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_941718011;
         this._embed_css_images_Arrow_WidgetToggle_over_png_462552837 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_462552837;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_804816603 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_804816603;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1398806194 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1398806194;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1409797015 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1409797015;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_581910765 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_581910765;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1261926374 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1261926374;
         this._embed_css_images_BG_Bars_compact_tileable_png_1436912205 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1436912205;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1766502261 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1766502261;
         this._embed_css_images_BG_Bars_default_enpiece_png_344484424 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_344484424;
         this._embed_css_images_BG_Bars_default_tileable_png_805785695 = Tibia__embed_css_images_BG_Bars_default_tileable_png_805785695;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_933434509 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_933434509;
         this._embed_css_images_BG_Bars_fat_enpiece_png_387640672 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_387640672;
         this._embed_css_images_BG_Bars_fat_tileable_png_2095366135 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_2095366135;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1124061077 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1124061077;
         this._embed_css_images_BG_BohemianTileable_Game_png_1157080528 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_1157080528;
         this._embed_css_images_BG_BohemianTileable_png_2096029589 = Tibia__embed_css_images_BG_BohemianTileable_png_2096029589;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_547452148 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_547452148;
         this._embed_css_images_BG_ChatTab_tileable_png_1899228090 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1899228090;
         this._embed_css_images_BG_Combat_png_648742988 = Tibia__embed_css_images_BG_Combat_png_648742988;
         this._embed_css_images_BG_Stone2_Tileable_png_2002639124 = Tibia__embed_css_images_BG_Stone2_Tileable_png_2002639124;
         this._embed_css_images_BG_Widget_Menu_png_657812724 = Tibia__embed_css_images_BG_Widget_Menu_png_657812724;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_151376169 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_151376169;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_624055718 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_624055718;
         this._embed_css_images_BarsHealth_compact_Mana_png_1834208132 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1834208132;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1118692203 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1118692203;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_11025348 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_11025348;
         this._embed_css_images_BarsHealth_compact_RedLow_png_558795064 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_558795064;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1212814775 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1212814775;
         this._embed_css_images_BarsHealth_default_GreenFull_png_801256325 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_801256325;
         this._embed_css_images_BarsHealth_default_GreenLow_png_810081208 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_810081208;
         this._embed_css_images_BarsHealth_default_Mana_png_2141536654 = Tibia__embed_css_images_BarsHealth_default_Mana_png_2141536654;
         this._embed_css_images_BarsHealth_default_RedFull_png_65335859 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_65335859;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1450088930 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1450088930;
         this._embed_css_images_BarsHealth_default_RedLow_png_1382869978 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1382869978;
         this._embed_css_images_BarsHealth_default_Yellow_png_531384213 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_531384213;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_1348534547 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_1348534547;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_33242016 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_33242016;
         this._embed_css_images_BarsHealth_fat_Mana_png_2042925722 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_2042925722;
         this._embed_css_images_BarsHealth_fat_RedFull_png_1062418523 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_1062418523;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1977802442 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1977802442;
         this._embed_css_images_BarsHealth_fat_RedLow_png_831761230 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_831761230;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1387480445 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1387480445;
         this._embed_css_images_BarsXP_default__png_375261627 = Tibia__embed_css_images_BarsXP_default__png_375261627;
         this._embed_css_images_Bars_ProgressMarker_png_1364739172 = Tibia__embed_css_images_Bars_ProgressMarker_png_1364739172;
         this._embed_css_images_Border_WidgetSidebar_png_570058551 = Tibia__embed_css_images_Border_WidgetSidebar_png_570058551;
         this._embed_css_images_Border_WidgetSidebar_slim_png_622616429 = Tibia__embed_css_images_Border_WidgetSidebar_slim_png_622616429;
         this._embed_css_images_Border_Widget_corner_png_637782225 = Tibia__embed_css_images_Border_Widget_corner_png_637782225;
         this._embed_css_images_Border_Widget_png_335866867 = Tibia__embed_css_images_Border_Widget_png_335866867;
         this._embed_css_images_Border_corners_png_2089337953 = Tibia__embed_css_images_Border_corners_png_2089337953;
         this._embed_css_images_Border_png_415757152 = Tibia__embed_css_images_Border_png_415757152;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_1237871417 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_1237871417;
         this._embed_css_images_Button_ChatTabIgnore_over_png_1099020231 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_1099020231;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_657878775 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_657878775;
         this._embed_css_images_Button_ChatTabNew_idle_png_1406163417 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1406163417;
         this._embed_css_images_Button_ChatTabNew_over_png_663345881 = Tibia__embed_css_images_Button_ChatTabNew_over_png_663345881;
         this._embed_css_images_Button_ChatTabNew_pressed_png_780335319 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_780335319;
         this._embed_css_images_Button_ChatTab_Close_idle_png_1268062192 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1268062192;
         this._embed_css_images_Button_ChatTab_Close_over_png_2140567312 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_2140567312;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1969839328 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1969839328;
         this._embed_css_images_Button_Close_idle_png_1896321650 = Tibia__embed_css_images_Button_Close_idle_png_1896321650;
         this._embed_css_images_Button_Close_over_png_1692078962 = Tibia__embed_css_images_Button_Close_over_png_1692078962;
         this._embed_css_images_Button_Close_pressed_png_1690159070 = Tibia__embed_css_images_Button_Close_pressed_png_1690159070;
         this._embed_css_images_Button_Combat_Stop_idle_png_1963141431 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1963141431;
         this._embed_css_images_Button_Combat_Stop_over_png_163358263 = Tibia__embed_css_images_Button_Combat_Stop_over_png_163358263;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1331098311 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1331098311;
         this._embed_css_images_Button_ContainerUp_idle_png_873141914 = Tibia__embed_css_images_Button_ContainerUp_idle_png_873141914;
         this._embed_css_images_Button_ContainerUp_over_png_547987866 = Tibia__embed_css_images_Button_ContainerUp_over_png_547987866;
         this._embed_css_images_Button_ContainerUp_pressed_png_702066838 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_702066838;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_683734871 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_683734871;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_151746135 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_151746135;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_520153298 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_520153298;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_1405381074 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_1405381074;
         this._embed_css_images_Button_Maximize_idle_png_1158247026 = Tibia__embed_css_images_Button_Maximize_idle_png_1158247026;
         this._embed_css_images_Button_Maximize_over_png_1195572366 = Tibia__embed_css_images_Button_Maximize_over_png_1195572366;
         this._embed_css_images_Button_Maximize_pressed_png_1425631198 = Tibia__embed_css_images_Button_Maximize_pressed_png_1425631198;
         this._embed_css_images_Button_Minimize_idle_png_1459448660 = Tibia__embed_css_images_Button_Minimize_idle_png_1459448660;
         this._embed_css_images_Button_Minimize_over_png_1973103532 = Tibia__embed_css_images_Button_Minimize_over_png_1973103532;
         this._embed_css_images_Button_Minimize_pressed_png_1810271124 = Tibia__embed_css_images_Button_Minimize_pressed_png_1810271124;
         this._embed_css_images_Button_Standard_tileable_disabled_png_918397116 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_918397116;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1158271000 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1158271000;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_739006055 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_739006055;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_809194495 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_809194495;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1677644031 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1677644031;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_40526129 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_40526129;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_854113408 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_854113408;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1178347904 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1178347904;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_571818864 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_571818864;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1341237787 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1341237787;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_64297755 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_64297755;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_682430469 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_682430469;
         this._embed_css_images_Button_Standard_tileable_idle_png_791230420 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_791230420;
         this._embed_css_images_Button_Standard_tileable_over_png_601662676 = Tibia__embed_css_images_Button_Standard_tileable_over_png_601662676;
         this._embed_css_images_Button_Standard_tileable_pressed_png_2110015596 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_2110015596;
         this._embed_css_images_BuySellTab_active_png_1587391858 = Tibia__embed_css_images_BuySellTab_active_png_1587391858;
         this._embed_css_images_BuySellTab_idle_png_877665844 = Tibia__embed_css_images_BuySellTab_idle_png_877665844;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_499859160 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_499859160;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_998389451 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_998389451;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1623802195 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1623802195;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_784135638 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_784135638;
         this._embed_css_images_ChatTab_tileable_idle_png_831153521 = Tibia__embed_css_images_ChatTab_tileable_idle_png_831153521;
         this._embed_css_images_ChatTab_tileable_png_1626179230 = Tibia__embed_css_images_ChatTab_tileable_png_1626179230;
         this._embed_css_images_ChatWindow_Mover_png_1521727426 = Tibia__embed_css_images_ChatWindow_Mover_png_1521727426;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_982757427 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_982757427;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1175311050 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1175311050;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1101669176 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1101669176;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1931959752 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1931959752;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_418443740 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_418443740;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1875248577 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1875248577;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1459589103 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1459589103;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1112154863 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1112154863;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1420946354 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1420946354;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1225689215 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1225689215;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_222423235 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_222423235;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_556227011 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_556227011;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1130855288 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_1130855288;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1341762219 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1341762219;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_1099028355 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_1099028355;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_767711875 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_767711875;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_413238117 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_413238117;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1451387486 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1451387486;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_117554192 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_117554192;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_213369072 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_213369072;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_562489394 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_562489394;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_1430440242 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_1430440242;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_1124481946 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_1124481946;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_775994010 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_775994010;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_973783515 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_973783515;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_87373019 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_87373019;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1517490293 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1517490293;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_279413387 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_279413387;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1903257287 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1903257287;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1407657383 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1407657383;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_1248958673 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_1248958673;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_556332591 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_556332591;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1416094019 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1416094019;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1604085827 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1604085827;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_1002764401 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_1002764401;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_655198065 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_655198065;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_311478629 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_311478629;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1591562341 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1591562341;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_365649629 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_365649629;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1709565405 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1709565405;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1415764770 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1415764770;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_147342370 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_147342370;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1005985190 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1005985190;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_817338022 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_817338022;
         this._embed_css_images_Icons_Conditions_Bleeding_png_585524592 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_585524592;
         this._embed_css_images_Icons_Conditions_Burning_png_1543364901 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1543364901;
         this._embed_css_images_Icons_Conditions_Cursed_png_99559434 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_99559434;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1344499232 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1344499232;
         this._embed_css_images_Icons_Conditions_Drowning_png_939122702 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_939122702;
         this._embed_css_images_Icons_Conditions_Drunk_png_165148058 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_165148058;
         this._embed_css_images_Icons_Conditions_Electrified_png_964093014 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_964093014;
         this._embed_css_images_Icons_Conditions_Freezing_png_1318288436 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1318288436;
         this._embed_css_images_Icons_Conditions_Haste_png_776608077 = Tibia__embed_css_images_Icons_Conditions_Haste_png_776608077;
         this._embed_css_images_Icons_Conditions_Hungry_png_760132907 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_760132907;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_622462549 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_622462549;
         this._embed_css_images_Icons_Conditions_MagicShield_png_253207080 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_253207080;
         this._embed_css_images_Icons_Conditions_PZ_png_1694144910 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1694144910;
         this._embed_css_images_Icons_Conditions_PZlock_png_2085935731 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_2085935731;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1749742289 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1749742289;
         this._embed_css_images_Icons_Conditions_Slowed_png_71339464 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_71339464;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1290797177 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1290797177;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_1063571960 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_1063571960;
         this._embed_css_images_Icons_PremmyPurse_active_png_1325680853 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1325680853;
         this._embed_css_images_Icons_ProgressBarsProgressOff_png_792670886 = Tibia__embed_css_images_Icons_ProgressBarsProgressOff_png_792670886;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_921186359 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_921186359;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1194808363 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1194808363;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_1523670977 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_1523670977;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1675744797 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1675744797;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_1173636374 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_1173636374;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_23630671 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_23630671;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_1080682567 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_1080682567;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_940927079 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_940927079;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_951419590 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_951419590;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_765731183 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_765731183;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_1318658849 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_1318658849;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_1410477920 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_1410477920;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_522625606 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_522625606;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1731999827 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1731999827;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1000842579 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1000842579;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_476474355 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_476474355;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_404386466 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_404386466;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_752743330 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_752743330;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1850105326 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1850105326;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1381241380 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1381241380;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_321409754 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_321409754;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_171501086 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_171501086;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1880116544 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1880116544;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1791607879 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1791607879;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1290363922 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1290363922;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_455381823 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_455381823;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_88731899 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_88731899;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_309033599 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_309033599;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_19847903 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_19847903;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_666329820 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_666329820;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_137203955 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_137203955;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_425911798 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_425911798;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1388607585 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1388607585;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_73370994 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_73370994;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1000403023 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1000403023;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1665994164 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1665994164;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_2019236557 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_2019236557;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_519002448 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_519002448;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_931433521 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_931433521;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1878181214 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1878181214;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_242880473 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_242880473;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1154567772 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1154567772;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1117165525 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1117165525;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1909921966 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1909921966;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_867602807 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_867602807;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_106630582 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_106630582;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1296563255 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1296563255;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2057729164 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2057729164;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_315622480 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_315622480;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_335822355 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_335822355;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1988031678 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1988031678;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_893475227 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_893475227;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1861158218 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1861158218;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1000595027 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1000595027;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_566863204 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_566863204;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_921121793 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_921121793;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_10813834 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_10813834;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_380941097 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_380941097;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1150665864 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_1150665864;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_707409237 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_707409237;
         this._embed_css_images_Inventory_png_54220158 = Tibia__embed_css_images_Inventory_png_54220158;
         this._embed_css_images_Minimap_Center_active_png_1796233388 = Tibia__embed_css_images_Minimap_Center_active_png_1796233388;
         this._embed_css_images_Minimap_Center_idle_png_1611725542 = Tibia__embed_css_images_Minimap_Center_idle_png_1611725542;
         this._embed_css_images_Minimap_Center_over_png_399276006 = Tibia__embed_css_images_Minimap_Center_over_png_399276006;
         this._embed_css_images_Minimap_ZoomIn_idle_png_344798711 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_344798711;
         this._embed_css_images_Minimap_ZoomIn_over_png_2144976119 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_2144976119;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_959000217 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_959000217;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1299180234 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1299180234;
         this._embed_css_images_Minimap_ZoomOut_over_png_19092426 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_19092426;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_758175750 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_758175750;
         this._embed_css_images_Minimap_png_474331013 = Tibia__embed_css_images_Minimap_png_474331013;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_380431240 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_380431240;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1503474552 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1503474552;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_2107174024 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_2107174024;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_184535153 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_184535153;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_535107953 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_535107953;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_235331199 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_235331199;
         this._embed_css_images_Scrollbar_Handler_png_89258761 = Tibia__embed_css_images_Scrollbar_Handler_png_89258761;
         this._embed_css_images_Scrollbar_tileable_png_1543124203 = Tibia__embed_css_images_Scrollbar_tileable_png_1543124203;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_553448699 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_553448699;
         this._embed_css_images_Slot_InventoryAmmo_png_1423885267 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1423885267;
         this._embed_css_images_Slot_InventoryArmor_png_1985762022 = Tibia__embed_css_images_Slot_InventoryArmor_png_1985762022;
         this._embed_css_images_Slot_InventoryBackpack_png_730815953 = Tibia__embed_css_images_Slot_InventoryBackpack_png_730815953;
         this._embed_css_images_Slot_InventoryBoots_png_916986780 = Tibia__embed_css_images_Slot_InventoryBoots_png_916986780;
         this._embed_css_images_Slot_InventoryHead_png_1019385487 = Tibia__embed_css_images_Slot_InventoryHead_png_1019385487;
         this._embed_css_images_Slot_InventoryLegs_png_2115005804 = Tibia__embed_css_images_Slot_InventoryLegs_png_2115005804;
         this._embed_css_images_Slot_InventoryNecklace_png_2069345467 = Tibia__embed_css_images_Slot_InventoryNecklace_png_2069345467;
         this._embed_css_images_Slot_InventoryRing_png_729767425 = Tibia__embed_css_images_Slot_InventoryRing_png_729767425;
         this._embed_css_images_Slot_InventoryShield_png_68385208 = Tibia__embed_css_images_Slot_InventoryShield_png_68385208;
         this._embed_css_images_Slot_InventoryWeapon_png_1527207259 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1527207259;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1070346582 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1070346582;
         this._embed_css_images_Slot_Statusicon_png_1610877454 = Tibia__embed_css_images_Slot_Statusicon_png_1610877454;
         this._embed_css_images_Slot_container_png_1398393684 = Tibia__embed_css_images_Slot_container_png_1398393684;
         this._embed_css_images_Widget_Footer_tileable_end01_png_296329250 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_296329250;
         this._embed_css_images_Widget_Footer_tileable_end02_png_298266787 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_298266787;
         this._embed_css_images_Widget_Footer_tileable_png_2055643781 = Tibia__embed_css_images_Widget_Footer_tileable_png_2055643781;
         this._embed_css_images_Widget_HeaderBG_png_1272737619 = Tibia__embed_css_images_Widget_HeaderBG_png_1272737619;
         this._embed_css_images_slot_Hotkey_Disabled_png_494529356 = Tibia__embed_css_images_slot_Hotkey_Disabled_png_494529356;
         this._embed_css_images_slot_Hotkey_png_211611383 = Tibia__embed_css_images_slot_Hotkey_png_211611383;
         this._embed_css_images_slot_container_disabled_png_2007324257 = Tibia__embed_css_images_slot_container_disabled_png_2007324257;
         this._embed_css_images_slot_container_highlighted_png_1356436136 = Tibia__embed_css_images_slot_container_highlighted_png_1356436136;
         this._embed_css_images_slot_container_png_1518504204 = Tibia__embed_css_images_slot_container_png_1518504204;
         this._embed_css_images_slot_hotkey_highlighted_png_1938924189 = Tibia__embed_css_images_slot_hotkey_highlighted_png_1938924189;
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
         if(param1.type == Event.ACTIVATE)
         {
            FocusNotifier.s_Hide();
         }
         else
         {
            FocusNotifier.s_Show();
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
      
      public function get isRunning() : Boolean
      {
         return this.m_Connection != null && Boolean(this.m_Connection.isGameRunning);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIWorldMapWidget() : WorldMapWidget
      {
         return this._1314206572m_UIWorldMapWidget;
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
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarB() : SideBarWidget
      {
         return this._64278964m_UISideBarB;
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
      
      public function ___Tibia_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
      }
      
      public function ___Tibia_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialise(param1);
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
      public function get m_UIWorldMapWindow() : GameWindowContainer
      {
         return this._1313911232m_UIWorldMapWindow;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UICenterColumn() : CustomDividedBox
      {
         return this._1356021457m_UICenterColumn;
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
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
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
      public function get m_UIInputHandler() : InputHandler
      {
         return this._748017946m_UIInputHandler;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIRootContainer() : HBox
      {
         return this._1494180935m_UIRootContainer;
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

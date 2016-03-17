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
   import tibia.game.OptionsAsset;
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
   import flash.utils.getTimer;
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
   import mx.events.FlexEvent;
   import mx.managers.ToolTipManager;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.MouseEvent;
   import tibia.game.LoginWaitWidget;
   import mx.containers.HBox;
   import flash.utils.getDefinitionByName;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import mx.core.UIComponentDescriptor;
   
   use namespace mx_internal;
   
   public class Tibia extends Application implements IBindingClient, IGameClient
   {
      
      private static const BUNDLE:String = "Tibia";
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      private static const SHAREDOBJECT_NAME:String = "options";
      
      public static var s_FrameTimestamp:Number = 0;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const MAX_SESSION_KEY_LENGTH:int = 30;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1286278305:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1857351261:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_147389239:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_2050725772:Class;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1518081068:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_1421165213:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_3397475:Class;
      
      private var _embed_css_images_Button_Close_idle_png_1224602474:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_149434115:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_2102061103:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_908547227:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_550320066:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_241046738:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_923223900:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_1090853107:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1908291054:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1656018397:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_1093318839:Class;
      
      private var _embed_css_images_Border02_corners_png_2140998153:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_792548076:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_826094621:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1930650277:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_123930922:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_2006133815:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1742318931:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1481771186:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_1093584960:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_595251037:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1066784938:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_415709899:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Button_Maximize_over_png_658022582:Class;
      
      private var _embed_css_images_Border_Widget_png_661063931:Class;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_2073426700:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_916725911:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_2014202173:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_337611332:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_404373814:Class;
      
      private var _embed_css_images_slot_Hotkey_Disabled_png_1031923524:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_1257186516:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1464291369:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_1487016691:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_934109225:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_993989923:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_288036776:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_1101283655:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_1881839866:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1503053918:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1971173786:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_1338306288:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1835517634:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_1342782195:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_899764384:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_114313384:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1295886286:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_892669907:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_2092078262:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_54535288:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_866574713:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_620850762:Class;
      
      private var _embed_css_images_Button_Close_over_png_1484878954:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_476140284:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1777483563:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1945098751:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1541494231:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_994894466:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1526206109:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_689502872:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1206167849:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1973774917:Class;
      
      private var _embed_css_images_BarsXP_default__png_249023155:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1775522369:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1217894830:Class;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1523902495:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_243106276:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1226450796:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1870894953:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1027989551:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1634799741:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767755774:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1848851772:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_615283438:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1120145002:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_516849533:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1661840144:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_606771065:Class;
      
      private var m_UncommittedOptions:Boolean = false;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_1787338104:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_711633969:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_1148856909:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_618531322:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_801584171:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_788671457:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1181229427:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1730127707:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1112644553:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_16687908:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_550487592:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1620457665:Class;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_1285358943:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_374717911:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_851976005:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_527259939:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_465840720:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1223376555:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_941557510:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_2061465939:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_862146887:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_875072203:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1785171351:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_948639108:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1460470338:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1808203246:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_500449310:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_272781181:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_614969479:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_394297656:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_914963482:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_391793375:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1599232977:Class;
      
      private var _embed_css_images_slot_hotkey_highlighted_png_1274667925:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_746630336:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_781530302:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1038286032:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1216546154:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_108132242:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1904514450:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1391479615:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_1148474522:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1444013376:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_816743815:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_280680839:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_1657348297:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_726398520:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_150523092:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_667523952:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1466317403:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_148060927:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_844353547:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_2006950715:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_207844447:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_101567481:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1354945434:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_76432611:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_293326710:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Minimap_png_805688973:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_111284397:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_458955390:Class;
      
      private var _embed_css_images_Slot_container_png_459286860:Class;
      
      private var _embed_css_images_Slot_Statusicon_png_1205487926:Class;
      
      protected var m_Connection:Connection = null;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_703329883:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_1190877289:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_465865258:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1978403468:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_576765842:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1586722714:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_1424547504:Class;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_96682453:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1663386625:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_940395789:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_2029736576:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_511008536:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_472129902:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_251763409:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1287244317:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_205733412:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_301017113:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1056021440:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1138559151:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_1485686470:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_2084516628:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1544236536:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1939613901:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_906266634:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1591056110:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_1264212723:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_2067870927:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_629035431:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1581693430:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1349976539:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_494656513:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_896595726:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1454831582:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_884103854:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1257201637:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_925120658:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_283538387:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_2112389245:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_290573136:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_png_312170109:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1575094904:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1923374042:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_925303374:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1645080258:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_733280488:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_247231009:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_43575622:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_179902376:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_2042936514:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1253594020:Class;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_409216831:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_816161053:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_1202361439:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_130683957:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1781541748:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1808131561:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1724428160:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_882019128:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_501972871:Class;
      
      private var _embed_css_images_slot_container_png_1837356268:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_620874187:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_1973139:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1926040274:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1419162327:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_675224537:Class;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Button_Minimize_over_png_1784461404:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1804772742:Class;
      
      protected var m_CharacterList:Array = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1963201312:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_2075786565:Class;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_785395263:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1547955240:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_329806006:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_297960041:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_1874454563:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_617580176:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154572810:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1339033171:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_304389207:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1283109301:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_635557583:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Widget_HeaderBG_png_586854571:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_275251680:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1387279284:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1137502652:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1011645613:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1064404383:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_133703022:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1961168259:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1156907387:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1573473594:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1430847752:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_2119223978:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1055242388:Class;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_827693174:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_53860032:Class;
      
      private var _embed_css_images_slot_Hotkey_png_547672559:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_869669038:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_951184522:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_123128559:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_167610021:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1831434620:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_315736127:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_472236531:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_336321745:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_852833875:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_1472667664:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1712135745:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_537656603:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1319328207:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1144557439:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_1602972136:Class;
      
      private var _embed_css_images_Button_Close_pressed_png_1153805286:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_751523730:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_454778409:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1151654853:Class;
      
      protected var m_CharacterCurrent:int = -1;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_705338579:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_434734700:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1260682073:Class;
      
      private var _embed_css_images_BG_Combat_png_718071924:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1607456696:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_291091603:Class;
      
      private var _embed_css_images_Border02_png_793779546:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_1139032635:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_949444498:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1760163503:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_1092547935:Class;
      
      private var _embed_css_images_Inventory_png_115152550:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_787108119:Class;
      
      protected var m_CharacterPending:int = -1;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_323479401:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1057086539:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1557118268:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_21964554:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_1032838017:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_1034881282:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_817963291:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_101601950:Class;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1529499230:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_229823360:Class;
      
      mx_internal var _bindings:Array;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_827693174 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_827693174;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_472129902 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_472129902;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_949444498 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_949444498;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_994894466 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_994894466;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_866574713 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_866574713;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1391479615 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1391479615;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_315736127 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_315736127;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1523902495 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1523902495;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1339033171 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1339033171;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1011645613 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_1011645613;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1287244317 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1287244317;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_1547955240 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1547955240;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_1472667664 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_1472667664;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1661840144 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1661840144;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_290573136 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_290573136;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1831434620 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1831434620;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_1342782195 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_1342782195;
         this._embed_css_images_Arrow_WidgetToggle_over_png_472236531 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_472236531;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_76432611 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_76432611;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1066784938 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1066784938;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1064404383 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1064404383;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1257201637 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_1257201637;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1591056110 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1591056110;
         this._embed_css_images_BG_Bars_compact_tileable_png_1973774917 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1973774917;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1634799741 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1634799741;
         this._embed_css_images_BG_Bars_default_enpiece_png_53860032 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_53860032;
         this._embed_css_images_BG_Bars_default_tileable_png_614969479 = Tibia__embed_css_images_BG_Bars_default_tileable_png_614969479;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1283109301 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1283109301;
         this._embed_css_images_BG_Bars_fat_enpiece_png_288036776 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_288036776;
         this._embed_css_images_BG_Bars_fat_tileable_png_1663386625 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1663386625;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1526206109 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1526206109;
         this._embed_css_images_BG_BohemianTileable_Game_png_550487592 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_550487592;
         this._embed_css_images_BG_BohemianTileable_png_1421165213 = Tibia__embed_css_images_BG_BohemianTileable_png_1421165213;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_476140284 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_476140284;
         this._embed_css_images_BG_ChatTab_tileable_png_1481771186 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1481771186;
         this._embed_css_images_BG_Combat_png_718071924 = Tibia__embed_css_images_BG_Combat_png_718071924;
         this._embed_css_images_BG_Stone2_Tileable_png_2073426700 = Tibia__embed_css_images_BG_Stone2_Tileable_png_2073426700;
         this._embed_css_images_BG_Widget_Menu_png_792548076 = Tibia__embed_css_images_BG_Widget_Menu_png_792548076;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_391793375 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_391793375;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_884103854 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_884103854;
         this._embed_css_images_BarsHealth_compact_Mana_png_1978403468 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1978403468;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1181229427 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1181229427;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_337611332 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_337611332;
         this._embed_css_images_BarsHealth_compact_RedLow_png_1093584960 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_1093584960;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1760163503 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1760163503;
         this._embed_css_images_BarsHealth_default_GreenFull_png_272781181 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_272781181;
         this._embed_css_images_BarsHealth_default_GreenLow_png_1424547504 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1424547504;
         this._embed_css_images_BarsHealth_default_Mana_png_1216546154 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1216546154;
         this._embed_css_images_BarsHealth_default_RedFull_png_801584171 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_801584171;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1923374042 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1923374042;
         this._embed_css_images_BarsHealth_default_RedLow_png_1926040274 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1926040274;
         this._embed_css_images_BarsHealth_default_Yellow_png_3397475 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_3397475;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_817963291 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_817963291;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_689502872 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_689502872;
         this._embed_css_images_BarsHealth_fat_Mana_png_1904514450 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1904514450;
         this._embed_css_images_BarsHealth_fat_RedFull_png_852833875 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_852833875;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_2042936514 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_2042936514;
         this._embed_css_images_BarsHealth_fat_RedLow_png_293326710 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_293326710;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1930650277 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1930650277;
         this._embed_css_images_BarsXP_default__png_249023155 = Tibia__embed_css_images_BarsXP_default__png_249023155;
         this._embed_css_images_Bars_ProgressMarker_png_1226450796 = Tibia__embed_css_images_Bars_ProgressMarker_png_1226450796;
         this._embed_css_images_Border02_WidgetSidebar_png_312170109 = Tibia__embed_css_images_Border02_WidgetSidebar_png_312170109;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_826094621 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_826094621;
         this._embed_css_images_Border02_corners_png_2140998153 = Tibia__embed_css_images_Border02_corners_png_2140998153;
         this._embed_css_images_Border02_png_793779546 = Tibia__embed_css_images_Border02_png_793779546;
         this._embed_css_images_Border_Widget_corner_png_101567481 = Tibia__embed_css_images_Border_Widget_corner_png_101567481;
         this._embed_css_images_Border_Widget_png_661063931 = Tibia__embed_css_images_Border_Widget_png_661063931;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_711633969 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_711633969;
         this._embed_css_images_Button_ChatTabIgnore_over_png_635557583 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_635557583;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_123128559 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_123128559;
         this._embed_css_images_Button_ChatTabNew_idle_png_1599232977 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1599232977;
         this._embed_css_images_Button_ChatTabNew_over_png_336321745 = Tibia__embed_css_images_Button_ChatTabNew_over_png_336321745;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1319328207 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1319328207;
         this._embed_css_images_Button_ChatTab_Close_idle_png_733280488 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_733280488;
         this._embed_css_images_Button_ChatTab_Close_over_png_1602972136 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_1602972136;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1430847752 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1430847752;
         this._embed_css_images_Button_Close_idle_png_1224602474 = Tibia__embed_css_images_Button_Close_idle_png_1224602474;
         this._embed_css_images_Button_Close_over_png_1484878954 = Tibia__embed_css_images_Button_Close_over_png_1484878954;
         this._embed_css_images_Button_Close_pressed_png_1153805286 = Tibia__embed_css_images_Button_Close_pressed_png_1153805286;
         this._embed_css_images_Button_Combat_Stop_idle_png_2102061103 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_2102061103;
         this._embed_css_images_Button_Combat_Stop_over_png_251763409 = Tibia__embed_css_images_Button_Combat_Stop_over_png_251763409;
         this._embed_css_images_Button_Combat_Stop_pressed_png_2067870927 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_2067870927;
         this._embed_css_images_Button_ContainerUp_idle_png_751523730 = Tibia__embed_css_images_Button_ContainerUp_idle_png_751523730;
         this._embed_css_images_Button_ContainerUp_over_png_133703022 = Tibia__embed_css_images_Button_ContainerUp_over_png_133703022;
         this._embed_css_images_Button_ContainerUp_pressed_png_101601950 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_101601950;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_1092547935 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_1092547935;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_207844447 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_207844447;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_123930922 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_123930922;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_465865258 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_465865258;
         this._embed_css_images_Button_Maximize_idle_png_620850762 = Tibia__embed_css_images_Button_Maximize_idle_png_620850762;
         this._embed_css_images_Button_Maximize_over_png_658022582 = Tibia__embed_css_images_Button_Maximize_over_png_658022582;
         this._embed_css_images_Button_Maximize_pressed_png_941557510 = Tibia__embed_css_images_Button_Maximize_pressed_png_941557510;
         this._embed_css_images_Button_Minimize_idle_png_923223900 = Tibia__embed_css_images_Button_Minimize_idle_png_923223900;
         this._embed_css_images_Button_Minimize_over_png_1784461404 = Tibia__embed_css_images_Button_Minimize_over_png_1784461404;
         this._embed_css_images_Button_Minimize_pressed_png_2084516628 = Tibia__embed_css_images_Button_Minimize_pressed_png_2084516628;
         this._embed_css_images_Button_Standard_tileable_disabled_png_243106276 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_243106276;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1963201312 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1963201312;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_1202361439 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_1202361439;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1541494231 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1541494231;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1419162327 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1419162327;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_374717911 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_374717911;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_1787338104 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_1787338104;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1575094904 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1575094904;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_511008536 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_511008536;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_1874454563 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_1874454563;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_527259939 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_527259939;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_940395789 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_940395789;
         this._embed_css_images_Button_Standard_tileable_idle_png_16687908 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_16687908;
         this._embed_css_images_Button_Standard_tileable_over_png_205733412 = Tibia__embed_css_images_Button_Standard_tileable_over_png_205733412;
         this._embed_css_images_Button_Standard_tileable_pressed_png_2050725772 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_2050725772;
         this._embed_css_images_BuySellTab_active_png_1120145002 = Tibia__embed_css_images_BuySellTab_active_png_1120145002;
         this._embed_css_images_BuySellTab_idle_png_1557118268 = Tibia__embed_css_images_BuySellTab_idle_png_1557118268;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1038286032 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1038286032;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_1264212723 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_1264212723;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1223376555 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1223376555;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1454831582 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1454831582;
         this._embed_css_images_ChatTab_tileable_idle_png_297960041 = Tibia__embed_css_images_ChatTab_tileable_idle_png_297960041;
         this._embed_css_images_ChatTab_tileable_png_1485686470 = Tibia__embed_css_images_ChatTab_tileable_png_1485686470;
         this._embed_css_images_ChatWindow_Mover_png_1586722714 = Tibia__embed_css_images_ChatWindow_Mover_png_1586722714;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_844353547 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_844353547;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1645080258 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1645080258;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1444013376 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1444013376;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1056021440 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1056021440;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_150523092 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_150523092;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1808131561 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1808131561;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1785171351 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1785171351;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_916725911 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_916725911;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_951184522 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_951184522;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_816743815 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_816743815;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_620874187 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_620874187;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_415709899 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_415709899;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_667523952 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_667523952;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1742318931 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1742318931;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_703329883 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_703329883;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_167610021 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_167610021;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_1973139 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_1973139;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1971173786 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1971173786;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_726398520 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_726398520;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_394297656 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_394297656;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_21964554 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_21964554;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_906266634 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_906266634;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_925120658 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_925120658;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_576765842 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_576765842;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_705338579 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_705338579;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_892669907 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_892669907;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1961168259 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1961168259;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_516849533 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_516849533;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1775522369 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1775522369;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1138559151 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1138559151;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_1112644553 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_1112644553;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_147389239 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_147389239;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_2006950715 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_2006950715;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_1139032635 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_1139032635;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_606771065 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_606771065;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_280680839 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_280680839;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_595251037 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_595251037;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1857351261 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1857351261;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_96682453 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_96682453;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1777483563 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1777483563;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_1881839866 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_1881839866;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_618531322 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_618531322;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_869669038 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_869669038;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1217894830 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1217894830;
         this._embed_css_images_Icons_Conditions_Bleeding_png_54535288 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_54535288;
         this._embed_css_images_Icons_Conditions_Burning_png_816161053 = Tibia__embed_css_images_Icons_Conditions_Burning_png_816161053;
         this._embed_css_images_Icons_Conditions_Cursed_png_1034881282 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_1034881282;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1544236536 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1544236536;
         this._embed_css_images_Icons_Conditions_Drowning_png_404373814 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_404373814;
         this._embed_css_images_Icons_Conditions_Drunk_png_108132242 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_108132242;
         this._embed_css_images_Icons_Conditions_Electrified_png_1503053918 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1503053918;
         this._embed_css_images_Icons_Conditions_Freezing_png_1848851772 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1848851772;
         this._embed_css_images_Icons_Conditions_Haste_png_851976005 = Tibia__embed_css_images_Icons_Conditions_Haste_png_851976005;
         this._embed_css_images_Icons_Conditions_Hungry_png_283538387 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_283538387;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_1148856909 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_1148856909;
         this._embed_css_images_Icons_Conditions_MagicShield_png_275251680 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_275251680;
         this._embed_css_images_Icons_Conditions_PZ_png_2092078262 = Tibia__embed_css_images_Icons_Conditions_PZ_png_2092078262;
         this._embed_css_images_Icons_Conditions_PZlock_png_1156907387 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1156907387;
         this._embed_css_images_Icons_Conditions_Poisoned_png_2006133815 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_2006133815;
         this._embed_css_images_Icons_Conditions_Slowed_png_746630336 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_746630336;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_1032838017 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_1032838017;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_1338306288 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_1338306288;
         this._embed_css_images_Icons_PremmyPurse_active_png_1939613901 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1939613901;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_785395263 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_785395263;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_993989923 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_993989923;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_1657348297 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_1657348297;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_2075786565 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_2075786565;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_500449310 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_500449310;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_629035431 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_629035431;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_409216831 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_409216831;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_1285358943 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_1285358943;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1295886286 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1295886286;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_1101283655 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_1101283655;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1712135745 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1712135745;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_301017113 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_301017113;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_882019128 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_882019128;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_925303374 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_925303374;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1466317403 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1466317403;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1730127707 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1730127707;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_875072203 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_875072203;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1354945434 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_1354945434;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_1148474522 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_1148474522;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1581693430 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1581693430;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1518081068 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1518081068;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_241046738 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_241046738;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_43575622 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_43575622;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1607456696 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1607456696;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1620457665 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1620457665;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154572810 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1154572810;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_787108119 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_787108119;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_149434115 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_149434115;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_501972871 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_501972871;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_454778409 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_454778409;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_1257186516 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_1257186516;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_130683957 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_130683957;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767755774 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_767755774;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1260682073 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1260682073;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_329806006 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_329806006;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_862146887 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_862146887;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1137502652 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1137502652;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1151654853 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1151654853;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_179902376 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_179902376;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1206167849 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1206167849;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1804772742 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1804772742;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_788671457 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_788671457;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_948639108 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_948639108;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1656018397 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1656018397;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_2119223978 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_2119223978;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1144557439 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1144557439;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_781530302 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_781530302;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1027989551 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1027989551;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1387279284 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1387279284;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_114313384 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_114313384;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_537656603 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_537656603;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1573473594 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1573473594;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_291091603 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_291091603;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1460470338 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1460470338;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1057086539 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1057086539;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_434734700 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_434734700;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1464291369 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1464291369;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_458955390 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_458955390;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_247231009 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_247231009;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_617580176 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_617580176;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_111284397 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_111284397;
         this._embed_css_images_Inventory_png_115152550 = Tibia__embed_css_images_Inventory_png_115152550;
         this._embed_css_images_Minimap_Center_active_png_1253594020 = Tibia__embed_css_images_Minimap_Center_active_png_1253594020;
         this._embed_css_images_Minimap_Center_idle_png_1808203246 = Tibia__embed_css_images_Minimap_Center_idle_png_1808203246;
         this._embed_css_images_Minimap_Center_over_png_615283438 = Tibia__embed_css_images_Minimap_Center_over_png_615283438;
         this._embed_css_images_Minimap_ZoomIn_idle_png_148060927 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_148060927;
         this._embed_css_images_Minimap_ZoomIn_over_png_1945098751 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1945098751;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1286278305 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1286278305;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1835517634 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1835517634;
         this._embed_css_images_Minimap_ZoomOut_over_png_550320066 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_550320066;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_896595726 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_896595726;
         this._embed_css_images_Minimap_png_805688973 = Tibia__embed_css_images_Minimap_png_805688973;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_229823360 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_229823360;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_2029736576 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_2029736576;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1724428160 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1724428160;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_323479401 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_323479401;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_1190877289 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_1190877289;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_304389207 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_304389207;
         this._embed_css_images_Scrollbar_Handler_png_494656513 = Tibia__embed_css_images_Scrollbar_Handler_png_494656513;
         this._embed_css_images_Scrollbar_tileable_png_1487016691 = Tibia__embed_css_images_Scrollbar_tileable_png_1487016691;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_1090853107 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1090853107;
         this._embed_css_images_Slot_InventoryAmmo_png_1349976539 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1349976539;
         this._embed_css_images_Slot_InventoryArmor_png_1908291054 = Tibia__embed_css_images_Slot_InventoryArmor_png_1908291054;
         this._embed_css_images_Slot_InventoryBackpack_png_934109225 = Tibia__embed_css_images_Slot_InventoryBackpack_png_934109225;
         this._embed_css_images_Slot_InventoryBoots_png_1055242388 = Tibia__embed_css_images_Slot_InventoryBoots_png_1055242388;
         this._embed_css_images_Slot_InventoryHead_png_1093318839 = Tibia__embed_css_images_Slot_InventoryHead_png_1093318839;
         this._embed_css_images_Slot_InventoryLegs_png_1781541748 = Tibia__embed_css_images_Slot_InventoryLegs_png_1781541748;
         this._embed_css_images_Slot_InventoryNecklace_png_2014202173 = Tibia__embed_css_images_Slot_InventoryNecklace_png_2014202173;
         this._embed_css_images_Slot_InventoryRing_png_675224537 = Tibia__embed_css_images_Slot_InventoryRing_png_675224537;
         this._embed_css_images_Slot_InventoryShield_png_465840720 = Tibia__embed_css_images_Slot_InventoryShield_png_465840720;
         this._embed_css_images_Slot_InventoryWeapon_png_2061465939 = Tibia__embed_css_images_Slot_InventoryWeapon_png_2061465939;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1529499230 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1529499230;
         this._embed_css_images_Slot_Statusicon_png_1205487926 = Tibia__embed_css_images_Slot_Statusicon_png_1205487926;
         this._embed_css_images_Slot_container_png_459286860 = Tibia__embed_css_images_Slot_container_png_459286860;
         this._embed_css_images_Widget_Footer_tileable_end01_png_914963482 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_914963482;
         this._embed_css_images_Widget_Footer_tileable_end02_png_908547227 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_908547227;
         this._embed_css_images_Widget_Footer_tileable_png_2112389245 = Tibia__embed_css_images_Widget_Footer_tileable_png_2112389245;
         this._embed_css_images_Widget_HeaderBG_png_586854571 = Tibia__embed_css_images_Widget_HeaderBG_png_586854571;
         this._embed_css_images_slot_Hotkey_Disabled_png_1031923524 = Tibia__embed_css_images_slot_Hotkey_Disabled_png_1031923524;
         this._embed_css_images_slot_Hotkey_png_547672559 = Tibia__embed_css_images_slot_Hotkey_png_547672559;
         this._embed_css_images_slot_container_disabled_png_1870894953 = Tibia__embed_css_images_slot_container_disabled_png_1870894953;
         this._embed_css_images_slot_container_highlighted_png_899764384 = Tibia__embed_css_images_slot_container_highlighted_png_899764384;
         this._embed_css_images_slot_container_png_1837356268 = Tibia__embed_css_images_slot_container_png_1837356268;
         this._embed_css_images_slot_hotkey_highlighted_png_1274667925 = Tibia__embed_css_images_slot_hotkey_highlighted_png_1274667925;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
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
      public function get m_UIWorldMapWidget() : WorldMapWidget
      {
         return this._1314206572m_UIWorldMapWidget;
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
      
      private function onUploadOptionsComplete(param1:Event) : void
      {
         this.m_CurrentOptionsDirty = false;
         this.m_CurrentOptionsLastUpload = getTimer();
         this.m_CurrentOptionsUploading = false;
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
      
      public function get isRunning() : Boolean
      {
         return this.m_Connection != null && Boolean(this.m_Connection.isGameRunning) || Boolean(this.m_CurrentOptionsUploading);
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarLeft() : VActionBarWidget
      {
         return this._1174474338m_UIActionBarLeft;
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
      
      private function _Tibia_Array1_i() : Array
      {
         var _loc1_:Array = [undefined,undefined];
         this._Tibia_Array1 = _loc1_;
         BindingManager.executeBindings(this,"_Tibia_Array1",this._Tibia_Array1);
         return _loc1_;
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
      
      private function onSecondaryTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ > this.m_SecondaryTimestamp && this.m_Connection != null)
         {
            this.m_Connection.readSocketData();
         }
         if(_loc2_ > this.m_CurrentOptionsLastUpload + OPTIONS_SAVE_INTERVAL)
         {
            this.saveOptions();
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
         }
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
      
      private function updateCombatTactics() : void
      {
         if(this.m_Connection != null && Boolean(this.m_Connection.isGameRunning) && this.m_Options != null)
         {
            this.m_Connection.sendCSETTACTICS(this.m_Options.combatAttackMode,this.m_Options.combatChaseMode,this.m_Options.combatSecureMode);
         }
      }
      
      public function saveOptions() : void
      {
         if(!this.m_CurrentOptionsUploading && Boolean(this.m_CurrentOptionsDirty))
         {
            this.m_CurrentOptionsAsset.upload(this.options.marshall());
            this.m_CurrentOptionsUploading = true;
         }
      }
      
      public function ___Tibia_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete(param1);
      }
      
      public function ___Tibia_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialise(param1);
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
         if(this.options == null)
         {
            this.options = new OptionsStorage(this.m_DefaultOptionsAsset.xml,this.m_CurrentOptionsAsset.xml);
         }
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIInputHandler() : InputHandler
      {
         return this._748017946m_UIInputHandler;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UICenterColumn() : CustomDividedBox
      {
         return this._1356021457m_UICenterColumn;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
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
      
      public function setOptions(param1:OptionsAsset, param2:OptionsAsset) : void
      {
         if(this.m_CurrentOptionsAsset != null)
         {
            this.m_CurrentOptionsAsset.removeEventListener(Event.COMPLETE,this.onUploadOptionsComplete);
            this.m_CurrentOptionsAsset.removeEventListener(ErrorEvent.ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(IOErrorEvent.IO_ERROR,this.onUploadOptionsError);
            this.m_CurrentOptionsAsset.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadOptionsError);
         }
         if(param1 == null)
         {
            throw new ArgumentError("Tibia.setOptions: Invalid options.");
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
         if(param2 == null)
         {
            throw new ArgumentError("Tibia.setOptions: Invalid default options.");
         }
         this.m_DefaultOptionsAsset = param2;
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

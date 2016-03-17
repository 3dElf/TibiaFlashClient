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
       
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_2079680510:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_235679349:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_912217767:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1664187080:Class;
      
      private var _embed_css_images_Button_Close_over_png_1700861862:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_170048822:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_1967196951:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_471227305:Class;
      
      private var _embed_css_images_Border_corners_png_1812637245:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1255062242:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_101465201:Class;
      
      private var _embed_css_images_Button_ContainerUp_over_png_538033974:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1429144064:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_14805379:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1642595229:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_253302448:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_124700883:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_7784364:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_906543003:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_1906354049:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1300879928:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1482233819:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_1173128978:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_906411332:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_42625094:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_2096045363:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1277041418:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1063647832:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_1921476404:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_177520246:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_239304383:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1298013459:Class;
      
      private var _embed_css_images_slot_hotkey_highlighted_png_1945618397:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_244742025:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_1899281010:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_ChatWindow_Mover_png_2127912354:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_591964978:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_913391138:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_584802017:Class;
      
      private var _embed_css_images_BG_BohemianTileable_png_1228202197:Class;
      
      private var _embed_css_images_slot_container_png_1962775796:Class;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_607248114:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1916695626:Class;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1896264558:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_265318637:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_885341238:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1247554116:Class;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_146327784:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_919550538:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_1124321828:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_998403697:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1209490330:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_906154265:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_386111280:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_491803030:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1644212600:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_184050001:Class;
      
      private var _embed_css_images_Border_WidgetSidebar_png_846758931:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_742421462:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_1854916391:Class;
      
      private var _embed_css_images_BarsXP_default__png_166319621:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1596180902:Class;
      
      private var _embed_css_images_Minimap_png_60418491:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_1149171871:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_934757628:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_430237222:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1472424448:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_195173734:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_987726240:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1989203025:Class;
      
      private var _embed_css_images_Border_WidgetSidebar_slim_png_148791341:Class;
      
      private var _embed_css_images_BG_Combat_png_1525492272:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1612943243:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1474671236:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_1713513619:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1124498495:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_201954772:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_1322238583:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1472588095:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_2031953868:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1531185758:Class;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_2087725881:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_208403027:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_466608581:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_209216999:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_244286627:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_121739006:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1463670706:Class;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_869244461:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_1047123619:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_1277024276:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_922627122:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_345474952:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1492248522:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_280033647:Class;
      
      private var _embed_css_images_Border_png_482742080:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1684522055:Class;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_547117778:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_2009546532:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1850240620:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_481235397:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1468492955:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1711598710:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_492532136:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_2074838836:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_216900144:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1953471255:Class;
      
      private var _embed_css_images_slot_Hotkey_png_539168215:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_21167588:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_201229336:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_361081845:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_49273256:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_789667757:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_20271771:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_519926705:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_151420951:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_918254324:Class;
      
      private var _embed_css_images_Button_Close_idle_png_1885189798:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_116428121:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_241115920:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_796647511:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1840356743:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_1269024476:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_668276276:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1933249625:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_356104679:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_483464384:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1963099400:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_2124211205:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_1351282365:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_379178579:Class;
      
      private var _embed_css_images_slot_Hotkey_Disabled_png_234505836:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1370619448:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1069872237:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_209909171:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_37002083:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_262929109:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_2139578202:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1504618038:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1943614411:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1305140184:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1846312430:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_597840195:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_893737603:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_69622980:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_763042538:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_917012140:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_1155679049:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_552989910:Class;
      
      protected var m_Connection:Connection = null;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1837338209:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_1054621238:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_1087478794:Class;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_2096304181:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1490143958:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1073990741:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_260723065:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1392922736:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_448195458:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Border_Widget_png_402984883:Class;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_2145786073:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1872669104:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_597966251:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_830189618:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1451184677:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_560694696:Class;
      
      private var _embed_css_images_Inventory_png_344133534:Class;
      
      private var _embed_css_images_Slot_InventoryRing_png_397893341:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1542494677:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_140448567:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1132916884:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1566258324:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_427597147:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_680302347:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1881183451:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_45823202:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1329680655:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_640317793:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_1816599626:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1589977190:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_698382755:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_672707963:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Button_Maximize_idle_png_276926290:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_605191836:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1708194194:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_266312312:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_725782387:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1071959239:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_139664407:Class;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_870180377:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_296415580:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1527785379:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1989047129:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_333940401:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_816380251:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1026157458:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_606902602:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Slot_Statusicon_png_1067608562:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1792562024:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_880939927:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_376055216:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_204654553:Class;
      
      private var _embed_css_images_slot_container_disabled_png_2002484257:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1218078120:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_2009442825:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_233695846:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_937664315:Class;
      
      protected var m_CharacterList:Array = null;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_228939978:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_1091292852:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_621584980:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_834831025:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1956871298:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_1346447938:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_926119807:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_798769991:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_948004095:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_373559549:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_949521087:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_228927190:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_1844317768:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1393779549:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_1785394871:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_52201381:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_279577304:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_281035820:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_381963227:Class;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_669602947:Class;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1270099458:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1383608810:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_984388273:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_Button_Maximize_over_png_985202606:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_2071135855:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1352875123:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1616698637:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1859391748:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_282087431:Class;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_294063634:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_950788542:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_658305974:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_189401777:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_111547130:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1719048638:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1325495956:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_625868953:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_220287579:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1419247096:Class;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1075363007:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_594441633:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_1202517937:Class;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Scrollbar_Handler_png_81526505:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_547874213:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1212057875:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1609482918:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_16183192:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_917194679:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_725766683:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_282561362:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_893869586:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1919246614:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1954298907:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_303240596:Class;
      
      protected var m_CharacterCurrent:int = -1;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1525131667:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_870243189:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_468469461:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_1520145809:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_745310536:Class;
      
      private var _embed_css_images_Slot_container_png_584706388:Class;
      
      protected var m_CharacterPending:int = -1;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_806758231:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1524110293:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_55056944:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Button_Close_pressed_png_826657758:Class;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_42625094 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_42625094;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_195173734 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_195173734;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1209490330 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_1209490330;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1609482918 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1609482918;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_870243189 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_870243189;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1527785379 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1527785379;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_244286627 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_244286627;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_917194679 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_917194679;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_806758231 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_806758231;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_471227305 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_471227305;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1073990741 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_1073990741;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_1269024476 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_1269024476;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_2009546532 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_2009546532;
         this._embed_css_images_Arrow_ScrollTabs_over_png_1124321828 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_1124321828;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_49273256 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_49273256;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1300879928 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1300879928;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_937664315 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_937664315;
         this._embed_css_images_Arrow_WidgetToggle_over_png_466608581 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_466608581;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_209216999 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_209216999;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1463670706 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1463670706;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1468492955 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1468492955;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_789667757 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_789667757;
         this._embed_css_images_BG_Bars_compact_enpiece_png_919550538 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_919550538;
         this._embed_css_images_BG_Bars_compact_tileable_png_1837338209 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1837338209;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_2096304181 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_2096304181;
         this._embed_css_images_BG_Bars_default_enpiece_png_281035820 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_281035820;
         this._embed_css_images_BG_Bars_default_tileable_png_669602947 = Tibia__embed_css_images_BG_Bars_default_tileable_png_669602947;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1069872237 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1069872237;
         this._embed_css_images_BG_Bars_fat_enpiece_png_296415580 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_296415580;
         this._embed_css_images_BG_Bars_fat_tileable_png_2124211205 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_2124211205;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1524110293 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1524110293;
         this._embed_css_images_BG_BohemianTileable_Game_png_216900144 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_216900144;
         this._embed_css_images_BG_BohemianTileable_png_1228202197 = Tibia__embed_css_images_BG_BohemianTileable_png_1228202197;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_201954772 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_201954772;
         this._embed_css_images_BG_ChatTab_tileable_png_1490143958 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1490143958;
         this._embed_css_images_BG_Combat_png_1525492272 = Tibia__embed_css_images_BG_Combat_png_1525492272;
         this._embed_css_images_BG_Stone2_Tileable_png_1277024276 = Tibia__embed_css_images_BG_Stone2_Tileable_png_1277024276;
         this._embed_css_images_BG_Widget_Menu_png_918254324 = Tibia__embed_css_images_BG_Widget_Menu_png_918254324;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_381963227 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_381963227;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_547117778 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_547117778;
         this._embed_css_images_BarsHealth_compact_Mana_png_1844317768 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_1844317768;
         this._embed_css_images_BarsHealth_compact_RedFull_png_1322238583 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_1322238583;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_69622980 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_69622980;
         this._embed_css_images_BarsHealth_compact_RedLow_png_621584980 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_621584980;
         this._embed_css_images_BarsHealth_compact_Yellow_png_880939927 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_880939927;
         this._embed_css_images_BarsHealth_default_GreenFull_png_260723065 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_260723065;
         this._embed_css_images_BarsHealth_default_GreenLow_png_605191836 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_605191836;
         this._embed_css_images_BarsHealth_default_Mana_png_2139578202 = Tibia__embed_css_images_BarsHealth_default_Mana_png_2139578202;
         this._embed_css_images_BarsHealth_default_RedFull_png_140448567 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_140448567;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1255062242 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1255062242;
         this._embed_css_images_BarsHealth_default_RedLow_png_1711598710 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1711598710;
         this._embed_css_images_BarsHealth_default_Yellow_png_468469461 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_468469461;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_948004095 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_948004095;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_21167588 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_21167588;
         this._embed_css_images_BarsHealth_fat_Mana_png_1896264558 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1896264558;
         this._embed_css_images_BarsHealth_fat_RedFull_png_926119807 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_926119807;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1919246614 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1919246614;
         this._embed_css_images_BarsHealth_fat_RedLow_png_830189618 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_830189618;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1393779549 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1393779549;
         this._embed_css_images_BarsXP_default__png_166319621 = Tibia__embed_css_images_BarsXP_default__png_166319621;
         this._embed_css_images_Bars_ProgressMarker_png_1218078120 = Tibia__embed_css_images_Bars_ProgressMarker_png_1218078120;
         this._embed_css_images_Border_WidgetSidebar_png_846758931 = Tibia__embed_css_images_Border_WidgetSidebar_png_846758931;
         this._embed_css_images_Border_WidgetSidebar_slim_png_148791341 = Tibia__embed_css_images_Border_WidgetSidebar_slim_png_148791341;
         this._embed_css_images_Border_Widget_corner_png_361081845 = Tibia__embed_css_images_Border_Widget_corner_png_361081845;
         this._embed_css_images_Border_Widget_png_402984883 = Tibia__embed_css_images_Border_Widget_png_402984883;
         this._embed_css_images_Border_corners_png_1812637245 = Tibia__embed_css_images_Border_corners_png_1812637245;
         this._embed_css_images_Border_png_482742080 = Tibia__embed_css_images_Border_png_482742080;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_906154265 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_906154265;
         this._embed_css_images_Button_ChatTabIgnore_over_png_356104679 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_356104679;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_124700883 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_124700883;
         this._embed_css_images_Button_ChatTabNew_idle_png_1542494677 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1542494677;
         this._embed_css_images_Button_ChatTabNew_over_png_262929109 = Tibia__embed_css_images_Button_ChatTabNew_over_png_262929109;
         this._embed_css_images_Button_ChatTabNew_pressed_png_1785394871 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_1785394871;
         this._embed_css_images_Button_ChatTab_Close_idle_png_668276276 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_668276276;
         this._embed_css_images_Button_ChatTab_Close_over_png_2074838836 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_2074838836;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1429144064 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1429144064;
         this._embed_css_images_Button_Close_idle_png_1885189798 = Tibia__embed_css_images_Button_Close_idle_png_1885189798;
         this._embed_css_images_Button_Close_over_png_1700861862 = Tibia__embed_css_images_Button_Close_over_png_1700861862;
         this._embed_css_images_Button_Close_pressed_png_826657758 = Tibia__embed_css_images_Button_Close_pressed_png_826657758;
         this._embed_css_images_Button_Combat_Stop_idle_png_1967196951 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_1967196951;
         this._embed_css_images_Button_Combat_Stop_over_png_151420951 = Tibia__embed_css_images_Button_Combat_Stop_over_png_151420951;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1943614411 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1943614411;
         this._embed_css_images_Button_ContainerUp_idle_png_885341238 = Tibia__embed_css_images_Button_ContainerUp_idle_png_885341238;
         this._embed_css_images_Button_ContainerUp_over_png_538033974 = Tibia__embed_css_images_Button_ContainerUp_over_png_538033974;
         this._embed_css_images_Button_ContainerUp_pressed_png_491803030 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_491803030;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_816380251 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_816380251;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_52201381 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_52201381;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_591964978 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_591964978;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_922627122 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_922627122;
         this._embed_css_images_Button_Maximize_idle_png_276926290 = Tibia__embed_css_images_Button_Maximize_idle_png_276926290;
         this._embed_css_images_Button_Maximize_over_png_985202606 = Tibia__embed_css_images_Button_Maximize_over_png_985202606;
         this._embed_css_images_Button_Maximize_pressed_png_1346447938 = Tibia__embed_css_images_Button_Maximize_pressed_png_1346447938;
         this._embed_css_images_Button_Minimize_idle_png_1921476404 = Tibia__embed_css_images_Button_Minimize_idle_png_1921476404;
         this._embed_css_images_Button_Minimize_over_png_2031953868 = Tibia__embed_css_images_Button_Minimize_over_png_2031953868;
         this._embed_css_images_Button_Minimize_pressed_png_1872669104 = Tibia__embed_css_images_Button_Minimize_pressed_png_1872669104;
         this._embed_css_images_Button_Standard_tileable_disabled_png_987726240 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_987726240;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_1091292852 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_1091292852;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_597840195 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_597840195;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1482233819 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1482233819;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1881183451 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1881183451;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_101465201 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_101465201;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_906411332 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_906411332;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1247554116 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1247554116;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_241115920 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_241115920;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_2145786073 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_2145786073;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_204654553 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_204654553;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_481235397 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_481235397;
         this._embed_css_images_Button_Standard_tileable_idle_png_146327784 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_146327784;
         this._embed_css_images_Button_Standard_tileable_over_png_201229336 = Tibia__embed_css_images_Button_Standard_tileable_over_png_201229336;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1325495956 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1325495956;
         this._embed_css_images_BuySellTab_active_png_1596180902 = Tibia__embed_css_images_BuySellTab_active_png_1596180902;
         this._embed_css_images_BuySellTab_idle_png_1419247096 = Tibia__embed_css_images_BuySellTab_idle_png_1419247096;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1305140184 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_1305140184;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_597966251 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_597966251;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1352875123 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1352875123;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_658305974 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_658305974;
         this._embed_css_images_ChatTab_tileable_idle_png_834831025 = Tibia__embed_css_images_ChatTab_tileable_idle_png_834831025;
         this._embed_css_images_ChatTab_tileable_png_950788542 = Tibia__embed_css_images_ChatTab_tileable_png_950788542;
         this._embed_css_images_ChatWindow_Mover_png_2127912354 = Tibia__embed_css_images_ChatWindow_Mover_png_2127912354;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_379178579 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_379178579;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1383608810 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1383608810;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1370619448 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1370619448;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1664187080 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1664187080;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_16183192 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_16183192;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1954298907 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1954298907;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1525131667 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1525131667;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_1713513619 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_1713513619;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1026157458 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_1026157458;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_949521087 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_949521087;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_14805379 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_14805379;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_893737603 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_893737603;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_266312312 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_266312312;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1612943243 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1612943243;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_1047123619 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_1047123619;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_698382755 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_698382755;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_547874213 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_547874213;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1531185758 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1531185758;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_386111280 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_386111280;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_55056944 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_55056944;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_294063634 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_294063634;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_1173128978 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_1173128978;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_1054621238 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_1054621238;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_170048822 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_170048822;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_906543003 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_906543003;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_20271771 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_20271771;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1989203025 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1989203025;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_184050001 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_184050001;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1989047129 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1989047129;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1071959239 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1071959239;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_1520145809 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_1520145809;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_280033647 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_280033647;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1684522055 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1684522055;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_798769991 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_798769991;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_1202517937 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_1202517937;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_333940401 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_333940401;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_116428121 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_116428121;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1933249625 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1933249625;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_37002083 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_37002083;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1642595229 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_1642595229;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_2079680510 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_2079680510;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_121739006 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_121739006;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1277041418 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1277041418;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_1087478794 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_1087478794;
         this._embed_css_images_Icons_Conditions_Bleeding_png_917012140 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_917012140;
         this._embed_css_images_Icons_Conditions_Burning_png_870180377 = Tibia__embed_css_images_Icons_Conditions_Burning_png_870180377;
         this._embed_css_images_Icons_Conditions_Cursed_png_430237222 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_430237222;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1472424448 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1472424448;
         this._embed_css_images_Icons_Conditions_Drowning_png_607248114 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_607248114;
         this._embed_css_images_Icons_Conditions_Drunk_png_233695846 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_233695846;
         this._embed_css_images_Icons_Conditions_Electrified_png_1504618038 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1504618038;
         this._embed_css_images_Icons_Conditions_Freezing_png_1963099400 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1963099400;
         this._embed_css_images_Icons_Conditions_Haste_png_640317793 = Tibia__embed_css_images_Icons_Conditions_Haste_png_640317793;
         this._embed_css_images_Icons_Conditions_Hungry_png_680302347 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_680302347;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_1155679049 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_1155679049;
         this._embed_css_images_Icons_Conditions_MagicShield_png_279577304 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_279577304;
         this._embed_css_images_Icons_Conditions_PZ_png_1899281010 = Tibia__embed_css_images_Icons_Conditions_PZ_png_1899281010;
         this._embed_css_images_Icons_Conditions_PZlock_png_2096045363 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_2096045363;
         this._embed_css_images_Icons_Conditions_Poisoned_png_2071135855 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_2071135855;
         this._embed_css_images_Icons_Conditions_Slowed_png_7784364 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_7784364;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_625868953 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_625868953;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1124498495 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1124498495;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1472588095 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_1472588095;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1212057875 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_1212057875;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_742421462 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_742421462;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_552989910 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_552989910;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1846312430 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1846312430;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1859391748 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1859391748;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_111547130 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_111547130;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_448195458 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_448195458;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1474671236 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1474671236;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_1854916391 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_1854916391;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_893869586 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_893869586;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_725766683 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_725766683;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_282087431 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_282087431;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_239304383 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_239304383;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_584802017 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_584802017;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_934757628 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_934757628;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_265318637 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_265318637;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_228927190 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_228927190;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_594441633 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_594441633;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_282561362 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_282561362;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1329680655 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1329680655;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1132916884 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1132916884;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1616698637 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1616698637;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_253302448 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_253302448;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_998403697 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_998403697;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1956871298 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1956871298;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_373559549 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_373559549;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_483464384 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_483464384;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_984388273 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_984388273;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1708194194 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1708194194;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_672707963 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_672707963;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_45823202 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_45823202;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1298013459 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1298013459;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1392922736 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_1392922736;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_376055216 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_376055216;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_208403027 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_208403027;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1719048638 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1719048638;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_220287579 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_220287579;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1589977190 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1589977190;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_796647511 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_796647511;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_560694696 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_560694696;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1451184677 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1451184677;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_177520246 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_177520246;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_244742025 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_244742025;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_345474952 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_345474952;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_235679349 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_235679349;
         this._embed_css_images_Inventory_png_344133534 = Tibia__embed_css_images_Inventory_png_344133534;
         this._embed_css_images_Minimap_Center_active_png_1792562024 = Tibia__embed_css_images_Minimap_Center_active_png_1792562024;
         this._embed_css_images_Minimap_Center_idle_png_1816599626 = Tibia__embed_css_images_Minimap_Center_idle_png_1816599626;
         this._embed_css_images_Minimap_Center_over_png_606902602 = Tibia__embed_css_images_Minimap_Center_over_png_606902602;
         this._embed_css_images_Minimap_ZoomIn_idle_png_139664407 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_139664407;
         this._embed_css_images_Minimap_ZoomIn_over_png_1953471255 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1953471255;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_1351282365 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_1351282365;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1492248522 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1492248522;
         this._embed_css_images_Minimap_ZoomOut_over_png_228939978 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_228939978;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_763042538 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_763042538;
         this._embed_css_images_Minimap_png_60418491 = Tibia__embed_css_images_Minimap_png_60418491;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_303240596 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_303240596;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1566258324 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1566258324;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1644212600 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1644212600;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_189401777 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_189401777;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_519926705 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_519926705;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_427597147 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_427597147;
         this._embed_css_images_Scrollbar_Handler_png_81526505 = Tibia__embed_css_images_Scrollbar_Handler_png_81526505;
         this._embed_css_images_Scrollbar_tileable_png_2009442825 = Tibia__embed_css_images_Scrollbar_tileable_png_2009442825;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_1149171871 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1149171871;
         this._embed_css_images_Slot_InventoryAmmo_png_1075363007 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1075363007;
         this._embed_css_images_Slot_InventoryArmor_png_1916695626 = Tibia__embed_css_images_Slot_InventoryArmor_png_1916695626;
         this._embed_css_images_Slot_InventoryBackpack_png_869244461 = Tibia__embed_css_images_Slot_InventoryBackpack_png_869244461;
         this._embed_css_images_Slot_InventoryBoots_png_1063647832 = Tibia__embed_css_images_Slot_InventoryBoots_png_1063647832;
         this._embed_css_images_Slot_InventoryHead_png_209909171 = Tibia__embed_css_images_Slot_InventoryHead_png_209909171;
         this._embed_css_images_Slot_InventoryLegs_png_1850240620 = Tibia__embed_css_images_Slot_InventoryLegs_png_1850240620;
         this._embed_css_images_Slot_InventoryNecklace_png_2087725881 = Tibia__embed_css_images_Slot_InventoryNecklace_png_2087725881;
         this._embed_css_images_Slot_InventoryRing_png_397893341 = Tibia__embed_css_images_Slot_InventoryRing_png_397893341;
         this._embed_css_images_Slot_InventoryShield_png_745310536 = Tibia__embed_css_images_Slot_InventoryShield_png_745310536;
         this._embed_css_images_Slot_InventoryWeapon_png_1906354049 = Tibia__embed_css_images_Slot_InventoryWeapon_png_1906354049;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1270099458 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1270099458;
         this._embed_css_images_Slot_Statusicon_png_1067608562 = Tibia__embed_css_images_Slot_Statusicon_png_1067608562;
         this._embed_css_images_Slot_container_png_584706388 = Tibia__embed_css_images_Slot_container_png_584706388;
         this._embed_css_images_Widget_Footer_tileable_end01_png_913391138 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_913391138;
         this._embed_css_images_Widget_Footer_tileable_end02_png_912217767 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_912217767;
         this._embed_css_images_Widget_Footer_tileable_png_1840356743 = Tibia__embed_css_images_Widget_Footer_tileable_png_1840356743;
         this._embed_css_images_Widget_HeaderBG_png_725782387 = Tibia__embed_css_images_Widget_HeaderBG_png_725782387;
         this._embed_css_images_slot_Hotkey_Disabled_png_234505836 = Tibia__embed_css_images_slot_Hotkey_Disabled_png_234505836;
         this._embed_css_images_slot_Hotkey_png_539168215 = Tibia__embed_css_images_slot_Hotkey_png_539168215;
         this._embed_css_images_slot_container_disabled_png_2002484257 = Tibia__embed_css_images_slot_container_disabled_png_2002484257;
         this._embed_css_images_slot_container_highlighted_png_492532136 = Tibia__embed_css_images_slot_container_highlighted_png_492532136;
         this._embed_css_images_slot_container_png_1962775796 = Tibia__embed_css_images_slot_container_png_1962775796;
         this._embed_css_images_slot_hotkey_highlighted_png_1945618397 = Tibia__embed_css_images_slot_hotkey_highlighted_png_1945618397;
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
      public function get m_UIActionBarLeft() : VActionBarWidget
      {
         return this._1174474338m_UIActionBarLeft;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarC() : SideBarWidget
      {
         return this._64278963m_UISideBarC;
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
      
      public function ___Tibia_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreinitialise(param1);
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarD() : SideBarWidget
      {
         return this._64278962m_UISideBarD;
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

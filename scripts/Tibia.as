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
   import tibia.sidebar.ToggleBar;
   import tibia.game.TimeoutWaitWidget;
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
      
      public static const CLIENT_VERSION:uint = 1349;
      
      private static const OPTIONS_SAVE_INTERVAL:int = 30 * 60 * 1000;
      
      public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
      
      private static var s_LastTibiaFactorChangeTibiaTimestamp:uint = 0;
      
      public static const PREVIEW_STATE_REGULAR:uint = 0;
      
      private static var s_LastTibiaTimestamp:int = 0;
      
      mx_internal static var _Tibia_StylesInit_done:Boolean = false;
       
      private var _embed_css_images_Icons_CombatControls_StandOff_idle_png_2144676134:Class;
      
      private var _embed_css_images_Minimap_Center_active_png_1666601632:Class;
      
      private var _embed_css_images_Slot_InventoryLegs_png_1770687572:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_pressed_png_1462559263:Class;
      
      private var _embed_css_images_Icons_ProgressBars_AxeFighting_png_863006467:Class;
      
      protected var m_CurrentOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Button_ChatTab_Close_over_png_2144230324:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_over_png_554390786:Class;
      
      private var _embed_css_images_Button_Maximize_over_png_653976534:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_over_png_996496841:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_png_1653601666:Class;
      
      private var _embed_css_images_Button_Combat_Stop_pressed_png_1268200595:Class;
      
      private var _embed_css_images_Button_Minimize_idle_png_927296540:Class;
      
      private var _embed_css_images_Icons_ProgressBars_FistFighting_png_1219110463:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_png_1942225789:Class;
      
      private var _embed_css_images_BG_ChatTab_Tabdrop_png_471962684:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Shielding_png_1148874264:Class;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_css_images_Slot_InventoryBackpack_png_1072136453:Class;
      
      private var _1314206572m_UIWorldMapWidget:WorldMapWidget;
      
      private var _embed_css_images_Button_Close_over_png_1551963246:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_565305968:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedFull_png_787158423:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_over_png_665667993:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_disabled_png_2034495004:Class;
      
      protected var m_ContainerStorage:ContainerStorage = null;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1011953256:Class;
      
      protected var m_IsActive:Boolean = false;
      
      private var _embed_css_images_Slot_InventoryNecklace_png_1875912705:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_958285816:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2041601067:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_png_1093559463:Class;
      
      private var _embed_css_images_Icons_Conditions_Strenghtened_png_751812737:Class;
      
      private var _embed_css_images_Icons_Conditions_MagicShield_png_8396320:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1917883478:Class;
      
      private var _embed_css_images_slot_Hotkey_highlighted_png_1930802827:Class;
      
      private var _embed_css_images_Slot_Hotkey_Cooldown_png_1086649271:Class;
      
      private var _embed_css_images_ChatTab_tileable_idle_png_1162118089:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_pressed_png_1457443904:Class;
      
      protected var m_Options:OptionsStorage = null;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1492771498:Class;
      
      protected var m_CurrentOptionsLastUpload:int = -2.147483648E9;
      
      private var _embed_css_images_Button_Close_pressed_png_1157613766:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_idle_png_1394565798:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1210018985:Class;
      
      private var _embed_css_images_Icons_CombatControls_StandOff_over_png_186767398:Class;
      
      private var _embed_css_images_Icons_Conditions_Electrified_png_1775143710:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_idle_png_1175600896:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_idle_png_1109498491:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_png_1670854302:Class;
      
      private var _embed_css_images_Icons_Conditions_Freezing_png_1381179200:Class;
      
      private var _embed_css_images_Icons_Conditions_Hungry_png_351039795:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_png_448347528:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_BattleList_png_1188721388:Class;
      
      private var _1174474338m_UIActionBarLeft:VActionBarWidget;
      
      protected var m_CurrentOptionsDirty:Boolean = false;
      
      private var _embed_css_images_Button_Close_idle_png_1218294638:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_png_1939647142:Class;
      
      private var _embed_css_images_Icons_Conditions_Drunk_png_447748178:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_idle_png_267736575:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_over_png_1037695272:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_png_388101843:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow2_png_1116494842:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1921951062:Class;
      
      private var _embed_css_images_BarsHealth_default_RedFull_png_2438479:Class;
      
      private var m_GameClientReady:Boolean = false;
      
      private var _embed_css_images_slot_container_png_1524796916:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_idle_png_1239977521:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_idle_png_1749550303:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_idle_png_1683372450:Class;
      
      private var _embed_css_images_Icons_Conditions_Poisoned_png_1746048425:Class;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_active_over_png_777638187:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_over_png_545469859:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_over_png_913218715:Class;
      
      private var _embed_css_images_Scrollbar_Handler_png_487848961:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1063010071:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_over_png_1535578612:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_971709072:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_idle_png_852604073:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow_png_1157484874:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_png_19492319:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_pressed_png_884491423:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow2_png_68651684:Class;
      
      private var _embed_css_images_BuySellTab_idle_png_1813518400:Class;
      
      private var _embed_css_images_Slot_InventoryBoots_png_1938275472:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_499580335:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_over_png_254379147:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_idle_png_451139672:Class;
      
      private var _embed_css_images_slot_Hotkey_disabled_png_1139776804:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1498472403:Class;
      
      private var _embed_css_images_BarsHealth_default_RedLow_png_1387055326:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpiece_png_1387240418:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_pressed_png_1220997645:Class;
      
      private var _1404294856m_UIGameWindow:GridContainer;
      
      private var _embed_css_images_Icons_Conditions_Burning_png_1220928865:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1401325198:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_pressed_png_106428656:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_idle_png_2075764191:Class;
      
      protected var m_Connection:IServerConnection = null;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_536906987:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_over_png_1327393802:Class;
      
      private var _64278965m_UISideBarA:SideBarWidget;
      
      private var _embed_css_images_Button_ContainerUp_over_png_69852574:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1000643385:Class;
      
      private var _embed_css_images_Minimap_ZoomOut_pressed_png_962262274:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_943450909:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_over_png_853589918:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_BG_png_1644395136:Class;
      
      protected var m_ConnectionDataPending:int = -1;
      
      private var _embed_css_images_Arrow_ScrollTabs_disabled_png_672934468:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_906069205:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_idle_png_1329667852:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_over_png_114850745:Class;
      
      private var _embed_css_images_Icons_Conditions_Cursed_png_969214734:Class;
      
      private var _embed_css_images_Minimap_Center_idle_png_2086053406:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1720517198:Class;
      
      private var _embed_css_images_Icons_CombatControls_Mounted_idle_png_996457113:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_slim_png_626342685:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_VipList_png_432242855:Class;
      
      private var _embed_css_images_ChatTab_tileable_png_891668710:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedFull_png_923672751:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DefaultStyle_png_1812077861:Class;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1844528831:Class;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var _embed_css_images_Slot_Statusicon_highlighted_png_1731350362:Class;
      
      private var _embed_css_images_Slot_InventoryArmor_png_1986121246:Class;
      
      private var _embed_css_images_Button_Standard_tileable_disabled_png_924179912:Class;
      
      private var _embed_css_images_Icons_Conditions_PZ_png_2003666550:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_over_png_1433768060:Class;
      
      private var _embed_css_images_BarsHealth_fat_RedLow2_png_1901763458:Class;
      
      private var _embed_css_images_Arrow_HotkeyToggle_BG_png_703829874:Class;
      
      protected var m_SpellStorage:SpellStorage = null;
      
      private var _embed_css_images_BG_BohemianTileable_png_1620000669:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_png_279706907:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1671581321:Class;
      
      protected var m_CharacterDeath:Boolean = false;
      
      private var _embed_css_images_BG_Bars_default_tileable_png_482309035:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Spells_png_528765315:Class;
      
      private var _embed_css_images_Slot_Statusicon_png_1271145738:Class;
      
      private var _embed_css_images_Icons_Conditions_PZlock_png_1221525371:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackYes_idle_png_1185167518:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_over_png_1096946895:Class;
      
      protected var m_SecondaryTimestamp:int = 0;
      
      private var _embed_css_images_Icons_ProgressBars_LargeStyle_png_1488259167:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_over_png_561845963:Class;
      
      private var _embed_css_images_slot_container_highlighted_png_630804576:Class;
      
      private var _embed_css_images_Icons_ProgressBars_MagicLevel_png_1498653378:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenLow_png_1092246698:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_over_png_1554034499:Class;
      
      private var _embed_css_images_Icons_ProgressBars_SwordFighting_png_320929806:Class;
      
      private var _embed_css_images_Button_Minimize_pressed_png_1889087864:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_over_png_544718418:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_pressed_png_502750776:Class;
      
      private var _embed_css_images_Border02_WidgetSidebar_png_989951673:Class;
      
      private var _embed_css_images_BuySellTab_active_png_1448857198:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_png_1482272179:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_over_png_985907899:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_over_png_761929083:Class;
      
      private var _embed_css_images_Button_ContainerUp_idle_png_418208414:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_460352161:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOn_png_767116025:Class;
      
      private var _embed_css_images_Border_Widget_corner_png_97234701:Class;
      
      private var _embed_css_images_Icons_Conditions_Haste_png_183664137:Class;
      
      private var _embed_css_images_Button_Minimize_over_png_1788663068:Class;
      
      private var _64278964m_UISideBarB:SideBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_active_png_399020502:Class;
      
      private var _embed_css_images_Border02_png_258489466:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ParallelStyle_png_436085555:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_idle_png_664921289:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_idle_png_1854361531:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1922488614:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1318367641:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_over_png_839560426:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_png_1613024508:Class;
      
      private var _embed_css_images_Icons_CombatControls_AttackNo_idle_png_489114602:Class;
      
      private var _embed_css_images_BG_Bars_compact_enpieceOrnamented_png_584547301:Class;
      
      private var _embed_css_images_Icons_Conditions_Dazzled_png_1667984088:Class;
      
      mx_internal var _bindings:Array;
      
      private var _embed_css_images_Button_Standard_tileable_idle_png_197744608:Class;
      
      private var _embed_css_images_BG_BohemianTileable_ChatConsole_png_1243090589:Class;
      
      private var _embed_css_images_BG_BarsXP_default_tileable_png_1330218467:Class;
      
      private var _embed_css_images_BG_BohemianTileable_Game_png_221217288:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1480373397:Class;
      
      private var _embed_css_images_Button_Combat_Stop_over_png_177970641:Class;
      
      private var _embed_css_images_Button_ChatTabIgnore_pressed_png_42905147:Class;
      
      private var _embed_css_images_Button_ContainerUp_pressed_png_370569950:Class;
      
      private var _embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1186785697:Class;
      
      private var _embed_css_images_Button_Maximize_pressed_png_1014565850:Class;
      
      private var _embed_css_images_Button_ChatTabNew_idle_png_1730706573:Class;
      
      private var _2056921391m_UISideBarToggleLeft:ToggleBar;
      
      private var _embed_css_images_Icons_CombatControls_DoveOff_idle_png_784504280:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1500578858:Class;
      
      private var _embed_css_images_Button_Standard_tileable_gold_over_png_278071585:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_over_png_1553063167:Class;
      
      private var _embed_css_images_Button_Combat_Stop_idle_png_2120162001:Class;
      
      protected var m_AssetProvider:IAssetProvider = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_idle_png_1136343619:Class;
      
      private var _embed_css_images_Icons_CombatControls_AutochaseOn_over_png_627798739:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end01_png_642865466:Class;
      
      private var _embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_858104855:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_active_png_1461845359:Class;
      
      private var _embed_css_images_BarsHealth_default_Mana_png_1540948590:Class;
      
      private var _embed_css_images_BG_Bars_default_enpiece_png_249551292:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Combat_png_510137618:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_161215467:Class;
      
      private var _embed_css_images_BG_Bars_fat_enpiece_png_357381060:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOff_over_png_862580649:Class;
      
      private var _embed_css_images_BG_Bars_fat_tileable_png_1650647357:Class;
      
      protected var m_DefaultOptionsAsset:OptionsAsset = null;
      
      private var _embed_css_images_Button_Standard_tileable_end_over_png_1185179228:Class;
      
      private var _embed_css_images_Icons_Conditions_Bleeding_png_253641108:Class;
      
      private var _embed_css_images_Slot_InventoryHead_png_1095038683:Class;
      
      private var _embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1288816888:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_629742491:Class;
      
      private var _embed_css_images_Slot_InventoryWeapon_png_2057395095:Class;
      
      private var _embed_css_images_Button_LockHotkeys_UnLocked_idle_png_460000010:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_idle_png_133528589:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_active_over_png_953158762:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1589951190:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_active_over_png_450699582:Class;
      
      private var _embed_css_images_Icons_Conditions_Slowed_png_543074756:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_GeneralControls_png_216495590:Class;
      
      private var _embed_css_images_BarsHealth_default_Yellow_png_527690397:Class;
      
      private var _embed_css_images_Arrow_ScrollTabs_over_png_999008780:Class;
      
      private var _embed_css_images_Icons_BattleList_HideNPCs_active_over_png_943132624:Class;
      
      private var _64278963m_UISideBarC:SideBarWidget;
      
      private var _embed_css_images_Icons_BattleList_HideMonsters_over_png_1321679360:Class;
      
      private var _embed_css_images_Icons_ProgressBars_DistanceFighting_png_1314144530:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_png_176944461:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_over_png_139451379:Class;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      private var _embed_css_images_BarsHealth_fat_Mana_png_1998294378:Class;
      
      private var _embed_css_images_Minimap_png_476321933:Class;
      
      private var _embed_css_images_Button_LockHotkeys_Locked_idle_png_893327011:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1010209603:Class;
      
      private var _1356021457m_UICenterColumn:CustomDividedBox;
      
      private var _embed_css_images_Icons_ProgressBars_ProgressOff_png_1772969717:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_122833288:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_pressed_png_240394377:Class;
      
      private var _embed_css_images_BG_BarsXP_default_endpiece_png_1325396426:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Minimap_png_2095987393:Class;
      
      private var _embed_css_images_Button_ChatTabNew_over_png_1005712781:Class;
      
      private var _embed_css_images_BarsHealth_compact_RedLow_png_497477180:Class;
      
      protected var m_ConnectionDataList:Vector.<IConnectionData> = null;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1948052399:Class;
      
      private var _embed_css_images_Icons_Conditions_Logoutblock_png_692217617:Class;
      
      private var _embed_css_images_Button_Standard_tileable_pressed_png_1457624492:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_down_idle_png_382013060:Class;
      
      private var _embed_css_images_Icons_BattleList_HideSkulled_active_over_png_467647408:Class;
      
      private var _embed_css_images_Icons_PremmyPurse_active_png_1741057169:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2109320296:Class;
      
      private var _228925540m_UIStatusWidget:StatusWidget;
      
      private var _embed_css_images_BG_Stone2_Tileable_png_2077997612:Class;
      
      private var _embed_css_images_Border_Widget_png_127725563:Class;
      
      private var _2043305115m_UIActionBarRight:VActionBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1019732347:Class;
      
      private var _embed_css_images_Minimap_ZoomIn_pressed_png_608234453:Class;
      
      private var _embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1122206033:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_idle_png_410695582:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Inventory_active_png_47370426:Class;
      
      private var _embed_css_images_BarsHealth_compact_Yellow_png_1013592239:Class;
      
      private var _embed_css_images_Inventory_png_321074298:Class;
      
      private var _embed_css_images_Button_Maximize_idle_png_625709866:Class;
      
      protected var m_AppearanceStorage:AppearanceStorage = null;
      
      private var _embed_css_images_Border02_corners_png_2015171811:Class;
      
      private var _embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_339985070:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOff_over_png_424204887:Class;
      
      private var _629924354m_UIActionBarBottom:HActionBarWidget;
      
      public var _Tibia_Array1:Array;
      
      public var _Tibia_Array2:Array;
      
      protected var m_ConnectionDataCurrent:int = -1;
      
      private var _embed_css_images_BG_Bars_default_enpieceOrnamented_png_1764422781:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Trades_idle_png_1264544957:Class;
      
      private var _embed_css_images_Slot_InventoryShield_png_125994256:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1289566917:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_end02_png_641667519:Class;
      
      private var _embed_css_images_BarsHealth_compact_Mana_png_2044063888:Class;
      
      private var _embed_css_images_Icons_CombatControls_MediumOn_over_png_863798239:Class;
      
      private var _embed_css_images_Icons_ProgressBars_CompactStyle_png_1922114025:Class;
      
      private var _embed_css_images_Icons_CombatControls_RedFistOn_over_png_196873459:Class;
      
      private var _embed_css_images_Button_Standard_tileable_end_idle_png_843118940:Class;
      
      private var _embed_css_images_Icons_ProgressBars_ClubFighting_png_1268717091:Class;
      
      private var _embed_css_images_Icons_ProgressBars_Fishing_png_354963859:Class;
      
      private var _748017946m_UIInputHandler:InputHandler;
      
      private var _embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1393751737:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenFull_png_949577175:Class;
      
      private var _embed_css_images_Icons_CombatControls_Unmounted_over_png_941079202:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_disabled_png_600112781:Class;
      
      private var _embed_css_images_Widget_HeaderBG_png_331533643:Class;
      
      private var _1423351586m_UIActionBarTop:HActionBarWidget;
      
      private var _embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_418761040:Class;
      
      private var _64278962m_UISideBarD:SideBarWidget;
      
      private var _embed_css_images_BarsXP_default__png_23728205:Class;
      
      private var _embed_css_images_Widget_Footer_tileable_png_1991139393:Class;
      
      private var _embed_css_images_BarsHealth_fat_GreenLow_png_757293180:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Trades_png_116771265:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1328098599:Class;
      
      private var _embed_css_images_Bars_ProgressMarker_png_1417159536:Class;
      
      private var _embed_css_images_BG_Bars_compact_tileable_png_1835904521:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_394809621:Class;
      
      private var _embed_css_images_Icons_CombatControls_DoveOn_over_png_1063899558:Class;
      
      private var _embed_css_images_Arrow_ScrollHotkeys_idle_png_1515718539:Class;
      
      private var _embed_css_images_BarsHealth_fat_Yellow_png_1533633413:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_png_1962653882:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_png_991395604:Class;
      
      protected var m_CurrentOptionsUploading:Boolean = false;
      
      private var _embed_css_images_Slot_InventoryAmmo_png_1348526999:Class;
      
      private var _embed_css_images_Icons_WidgetHeaders_Inventory_png_1804456604:Class;
      
      private var _embed_css_images_slot_container_disabled_png_1545968009:Class;
      
      private var _embed_css_images_BarsHealth_compact_GreenFull_png_119664419:Class;
      
      private var _embed_css_images_Arrow_WidgetToggle_idle_png_1543716083:Class;
      
      private var _embed_css_images_Button_Standard_tileable_over_png_8469280:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_idle_png_1261255500:Class;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_Player:Player = null;
      
      private var _embed_css_images_Icons_WidgetMenu_Minimap_idle_png_362912147:Class;
      
      protected var m_SessionKey:String = null;
      
      private var _embed_css_images_Minimap_ZoomOut_idle_png_1822944258:Class;
      
      private var _1494180935m_UIRootContainer:HBox;
      
      private var _1313911232m_UIWorldMapWindow:GameWindowContainer;
      
      private var _embed_css_images_Icons_Conditions_Drowning_png_748290826:Class;
      
      private var _665607314m_UISideBarToggleRight:ToggleBar;
      
      protected var m_SeconaryTimer:Timer = null;
      
      private var _embed_css_images_slot_Hotkey_png_344241391:Class;
      
      private var _embed_css_images_Minimap_Center_over_png_470603490:Class;
      
      private var _embed_css_images_Scrollbar_tileable_png_1484543023:Class;
      
      private var _embed_css_images_BG_ChatTab_tileable_png_1559497918:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_over_png_81241256:Class;
      
      private var _embed_css_images_Button_ChatTab_Close_pressed_png_1158749480:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1205200911:Class;
      
      private var _embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1500200523:Class;
      
      protected var m_Communication:Communication = null;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      private var _embed_css_images_Slot_InventoryRing_png_670915893:Class;
      
      private var _embed_css_images_BG_Widget_Menu_png_651382796:Class;
      
      private var _embed_css_images_Arrow_ScrollTabsHighlighted_over_png_609657585:Class;
      
      private var _embed_css_images_ChatWindow_Mover_png_1984658938:Class;
      
      private var _embed_css_images_BarsHealth_default_GreenLow_png_1217453236:Class;
      
      private var _883427326m_UIChatWidget:ChatWidget;
      
      private var _embed_css_images_BarsHealth_default_GreenFull_png_6976577:Class;
      
      mx_internal var _watchers:Array;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_idle_png_633661502:Class;
      
      private var _embed_css_images_Icons_BattleList_PartyMembers_active_over_png_604627565:Class;
      
      private var _embed_css_images_Button_ChatTabNew_pressed_png_860036047:Class;
      
      private var _embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_55788873:Class;
      
      private var _embed_css_images_Icons_TradeLists_ListDisplay_over_png_742275230:Class;
      
      protected var m_ChannelsPending:Vector.<int> = null;
      
      private var m_ConnectionLostDialog:ConnectionLostWidget;
      
      private var _embed_css_images_Button_Standard_tileable_end_gold_disabled_png_937580587:Class;
      
      private var _embed_css_images_Scrollbar_Arrow_up_pressed_png_29793219:Class;
      
      private var _embed_css_images_Icons_BattleList_HidePlayers_idle_png_214541771:Class;
      
      private var _embed_css_images_BG_Combat_png_923993944:Class;
      
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
         this._embed_css_images_Arrow_HotkeyToggle_BG_png_703829874 = Tibia__embed_css_images_Arrow_HotkeyToggle_BG_png_703829874;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_339985070 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_idle_png_339985070;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_over_png_544718418 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_over_png_544718418;
         this._embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1401325198 = Tibia__embed_css_images_Arrow_Minimap_LevelUpDown_pressed_png_1401325198;
         this._embed_css_images_Arrow_ScrollHotkeys_disabled_png_600112781 = Tibia__embed_css_images_Arrow_ScrollHotkeys_disabled_png_600112781;
         this._embed_css_images_Arrow_ScrollHotkeys_idle_png_1515718539 = Tibia__embed_css_images_Arrow_ScrollHotkeys_idle_png_1515718539;
         this._embed_css_images_Arrow_ScrollHotkeys_over_png_254379147 = Tibia__embed_css_images_Arrow_ScrollHotkeys_over_png_254379147;
         this._embed_css_images_Arrow_ScrollHotkeys_pressed_png_1462559263 = Tibia__embed_css_images_Arrow_ScrollHotkeys_pressed_png_1462559263;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1205200911 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_idle_png_1205200911;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_over_png_609657585 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_over_png_609657585;
         this._embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_943450909 = Tibia__embed_css_images_Arrow_ScrollTabsHighlighted_pressed_png_943450909;
         this._embed_css_images_Arrow_ScrollTabs_disabled_png_672934468 = Tibia__embed_css_images_Arrow_ScrollTabs_disabled_png_672934468;
         this._embed_css_images_Arrow_ScrollTabs_idle_png_1329667852 = Tibia__embed_css_images_Arrow_ScrollTabs_idle_png_1329667852;
         this._embed_css_images_Arrow_ScrollTabs_over_png_999008780 = Tibia__embed_css_images_Arrow_ScrollTabs_over_png_999008780;
         this._embed_css_images_Arrow_ScrollTabs_pressed_png_106428656 = Tibia__embed_css_images_Arrow_ScrollTabs_pressed_png_106428656;
         this._embed_css_images_Arrow_WidgetToggle_BG_png_1644395136 = Tibia__embed_css_images_Arrow_WidgetToggle_BG_png_1644395136;
         this._embed_css_images_Arrow_WidgetToggle_idle_png_1543716083 = Tibia__embed_css_images_Arrow_WidgetToggle_idle_png_1543716083;
         this._embed_css_images_Arrow_WidgetToggle_over_png_139451379 = Tibia__embed_css_images_Arrow_WidgetToggle_over_png_139451379;
         this._embed_css_images_Arrow_WidgetToggle_pressed_png_884491423 = Tibia__embed_css_images_Arrow_WidgetToggle_pressed_png_884491423;
         this._embed_css_images_BG_BarsXP_default_endpiece_png_1325396426 = Tibia__embed_css_images_BG_BarsXP_default_endpiece_png_1325396426;
         this._embed_css_images_BG_BarsXP_default_tileable_png_1330218467 = Tibia__embed_css_images_BG_BarsXP_default_tileable_png_1330218467;
         this._embed_css_images_BG_Bars_compact_enpieceOrnamented_png_584547301 = Tibia__embed_css_images_BG_Bars_compact_enpieceOrnamented_png_584547301;
         this._embed_css_images_BG_Bars_compact_enpiece_png_1387240418 = Tibia__embed_css_images_BG_Bars_compact_enpiece_png_1387240418;
         this._embed_css_images_BG_Bars_compact_tileable_png_1835904521 = Tibia__embed_css_images_BG_Bars_compact_tileable_png_1835904521;
         this._embed_css_images_BG_Bars_default_enpieceOrnamented_png_1764422781 = Tibia__embed_css_images_BG_Bars_default_enpieceOrnamented_png_1764422781;
         this._embed_css_images_BG_Bars_default_enpiece_png_249551292 = Tibia__embed_css_images_BG_Bars_default_enpiece_png_249551292;
         this._embed_css_images_BG_Bars_default_tileable_png_482309035 = Tibia__embed_css_images_BG_Bars_default_tileable_png_482309035;
         this._embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1480373397 = Tibia__embed_css_images_BG_Bars_fat_enpieceOrnamented_png_1480373397;
         this._embed_css_images_BG_Bars_fat_enpiece_png_357381060 = Tibia__embed_css_images_BG_Bars_fat_enpiece_png_357381060;
         this._embed_css_images_BG_Bars_fat_tileable_png_1650647357 = Tibia__embed_css_images_BG_Bars_fat_tileable_png_1650647357;
         this._embed_css_images_BG_BohemianTileable_ChatConsole_png_1243090589 = Tibia__embed_css_images_BG_BohemianTileable_ChatConsole_png_1243090589;
         this._embed_css_images_BG_BohemianTileable_Game_png_221217288 = Tibia__embed_css_images_BG_BohemianTileable_Game_png_221217288;
         this._embed_css_images_BG_BohemianTileable_png_1620000669 = Tibia__embed_css_images_BG_BohemianTileable_png_1620000669;
         this._embed_css_images_BG_ChatTab_Tabdrop_png_471962684 = Tibia__embed_css_images_BG_ChatTab_Tabdrop_png_471962684;
         this._embed_css_images_BG_ChatTab_tileable_png_1559497918 = Tibia__embed_css_images_BG_ChatTab_tileable_png_1559497918;
         this._embed_css_images_BG_Combat_png_923993944 = Tibia__embed_css_images_BG_Combat_png_923993944;
         this._embed_css_images_BG_Stone2_Tileable_png_2077997612 = Tibia__embed_css_images_BG_Stone2_Tileable_png_2077997612;
         this._embed_css_images_BG_Widget_Menu_png_651382796 = Tibia__embed_css_images_BG_Widget_Menu_png_651382796;
         this._embed_css_images_BarsHealth_compact_GreenFull_png_119664419 = Tibia__embed_css_images_BarsHealth_compact_GreenFull_png_119664419;
         this._embed_css_images_BarsHealth_compact_GreenLow_png_1092246698 = Tibia__embed_css_images_BarsHealth_compact_GreenLow_png_1092246698;
         this._embed_css_images_BarsHealth_compact_Mana_png_2044063888 = Tibia__embed_css_images_BarsHealth_compact_Mana_png_2044063888;
         this._embed_css_images_BarsHealth_compact_RedFull_png_923672751 = Tibia__embed_css_images_BarsHealth_compact_RedFull_png_923672751;
         this._embed_css_images_BarsHealth_compact_RedLow2_png_68651684 = Tibia__embed_css_images_BarsHealth_compact_RedLow2_png_68651684;
         this._embed_css_images_BarsHealth_compact_RedLow_png_497477180 = Tibia__embed_css_images_BarsHealth_compact_RedLow_png_497477180;
         this._embed_css_images_BarsHealth_compact_Yellow_png_1013592239 = Tibia__embed_css_images_BarsHealth_compact_Yellow_png_1013592239;
         this._embed_css_images_BarsHealth_default_GreenFull_png_6976577 = Tibia__embed_css_images_BarsHealth_default_GreenFull_png_6976577;
         this._embed_css_images_BarsHealth_default_GreenLow_png_1217453236 = Tibia__embed_css_images_BarsHealth_default_GreenLow_png_1217453236;
         this._embed_css_images_BarsHealth_default_Mana_png_1540948590 = Tibia__embed_css_images_BarsHealth_default_Mana_png_1540948590;
         this._embed_css_images_BarsHealth_default_RedFull_png_2438479 = Tibia__embed_css_images_BarsHealth_default_RedFull_png_2438479;
         this._embed_css_images_BarsHealth_default_RedLow2_png_1116494842 = Tibia__embed_css_images_BarsHealth_default_RedLow2_png_1116494842;
         this._embed_css_images_BarsHealth_default_RedLow_png_1387055326 = Tibia__embed_css_images_BarsHealth_default_RedLow_png_1387055326;
         this._embed_css_images_BarsHealth_default_Yellow_png_527690397 = Tibia__embed_css_images_BarsHealth_default_Yellow_png_527690397;
         this._embed_css_images_BarsHealth_fat_GreenFull_png_949577175 = Tibia__embed_css_images_BarsHealth_fat_GreenFull_png_949577175;
         this._embed_css_images_BarsHealth_fat_GreenLow_png_757293180 = Tibia__embed_css_images_BarsHealth_fat_GreenLow_png_757293180;
         this._embed_css_images_BarsHealth_fat_Mana_png_1998294378 = Tibia__embed_css_images_BarsHealth_fat_Mana_png_1998294378;
         this._embed_css_images_BarsHealth_fat_RedFull_png_787158423 = Tibia__embed_css_images_BarsHealth_fat_RedFull_png_787158423;
         this._embed_css_images_BarsHealth_fat_RedLow2_png_1901763458 = Tibia__embed_css_images_BarsHealth_fat_RedLow2_png_1901763458;
         this._embed_css_images_BarsHealth_fat_RedLow_png_1157484874 = Tibia__embed_css_images_BarsHealth_fat_RedLow_png_1157484874;
         this._embed_css_images_BarsHealth_fat_Yellow_png_1533633413 = Tibia__embed_css_images_BarsHealth_fat_Yellow_png_1533633413;
         this._embed_css_images_BarsXP_default__png_23728205 = Tibia__embed_css_images_BarsXP_default__png_23728205;
         this._embed_css_images_Bars_ProgressMarker_png_1417159536 = Tibia__embed_css_images_Bars_ProgressMarker_png_1417159536;
         this._embed_css_images_Border02_WidgetSidebar_png_989951673 = Tibia__embed_css_images_Border02_WidgetSidebar_png_989951673;
         this._embed_css_images_Border02_WidgetSidebar_slim_png_626342685 = Tibia__embed_css_images_Border02_WidgetSidebar_slim_png_626342685;
         this._embed_css_images_Border02_corners_png_2015171811 = Tibia__embed_css_images_Border02_corners_png_2015171811;
         this._embed_css_images_Border02_png_258489466 = Tibia__embed_css_images_Border02_png_258489466;
         this._embed_css_images_Border_Widget_corner_png_97234701 = Tibia__embed_css_images_Border_Widget_corner_png_97234701;
         this._embed_css_images_Border_Widget_png_127725563 = Tibia__embed_css_images_Border_Widget_png_127725563;
         this._embed_css_images_Button_ChatTabIgnore_idle_png_1239977521 = Tibia__embed_css_images_Button_ChatTabIgnore_idle_png_1239977521;
         this._embed_css_images_Button_ChatTabIgnore_over_png_1096946895 = Tibia__embed_css_images_Button_ChatTabIgnore_over_png_1096946895;
         this._embed_css_images_Button_ChatTabIgnore_pressed_png_42905147 = Tibia__embed_css_images_Button_ChatTabIgnore_pressed_png_42905147;
         this._embed_css_images_Button_ChatTabNew_idle_png_1730706573 = Tibia__embed_css_images_Button_ChatTabNew_idle_png_1730706573;
         this._embed_css_images_Button_ChatTabNew_over_png_1005712781 = Tibia__embed_css_images_Button_ChatTabNew_over_png_1005712781;
         this._embed_css_images_Button_ChatTabNew_pressed_png_860036047 = Tibia__embed_css_images_Button_ChatTabNew_pressed_png_860036047;
         this._embed_css_images_Button_ChatTab_Close_idle_png_1261255500 = Tibia__embed_css_images_Button_ChatTab_Close_idle_png_1261255500;
         this._embed_css_images_Button_ChatTab_Close_over_png_2144230324 = Tibia__embed_css_images_Button_ChatTab_Close_over_png_2144230324;
         this._embed_css_images_Button_ChatTab_Close_pressed_png_1158749480 = Tibia__embed_css_images_Button_ChatTab_Close_pressed_png_1158749480;
         this._embed_css_images_Button_Close_idle_png_1218294638 = Tibia__embed_css_images_Button_Close_idle_png_1218294638;
         this._embed_css_images_Button_Close_over_png_1551963246 = Tibia__embed_css_images_Button_Close_over_png_1551963246;
         this._embed_css_images_Button_Close_pressed_png_1157613766 = Tibia__embed_css_images_Button_Close_pressed_png_1157613766;
         this._embed_css_images_Button_Combat_Stop_idle_png_2120162001 = Tibia__embed_css_images_Button_Combat_Stop_idle_png_2120162001;
         this._embed_css_images_Button_Combat_Stop_over_png_177970641 = Tibia__embed_css_images_Button_Combat_Stop_over_png_177970641;
         this._embed_css_images_Button_Combat_Stop_pressed_png_1268200595 = Tibia__embed_css_images_Button_Combat_Stop_pressed_png_1268200595;
         this._embed_css_images_Button_ContainerUp_idle_png_418208414 = Tibia__embed_css_images_Button_ContainerUp_idle_png_418208414;
         this._embed_css_images_Button_ContainerUp_over_png_69852574 = Tibia__embed_css_images_Button_ContainerUp_over_png_69852574;
         this._embed_css_images_Button_ContainerUp_pressed_png_370569950 = Tibia__embed_css_images_Button_ContainerUp_pressed_png_370569950;
         this._embed_css_images_Button_LockHotkeys_Locked_idle_png_893327011 = Tibia__embed_css_images_Button_LockHotkeys_Locked_idle_png_893327011;
         this._embed_css_images_Button_LockHotkeys_Locked_over_png_545469859 = Tibia__embed_css_images_Button_LockHotkeys_Locked_over_png_545469859;
         this._embed_css_images_Button_LockHotkeys_UnLocked_idle_png_460000010 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_idle_png_460000010;
         this._embed_css_images_Button_LockHotkeys_UnLocked_over_png_1327393802 = Tibia__embed_css_images_Button_LockHotkeys_UnLocked_over_png_1327393802;
         this._embed_css_images_Button_Maximize_idle_png_625709866 = Tibia__embed_css_images_Button_Maximize_idle_png_625709866;
         this._embed_css_images_Button_Maximize_over_png_653976534 = Tibia__embed_css_images_Button_Maximize_over_png_653976534;
         this._embed_css_images_Button_Maximize_pressed_png_1014565850 = Tibia__embed_css_images_Button_Maximize_pressed_png_1014565850;
         this._embed_css_images_Button_Minimize_idle_png_927296540 = Tibia__embed_css_images_Button_Minimize_idle_png_927296540;
         this._embed_css_images_Button_Minimize_over_png_1788663068 = Tibia__embed_css_images_Button_Minimize_over_png_1788663068;
         this._embed_css_images_Button_Minimize_pressed_png_1889087864 = Tibia__embed_css_images_Button_Minimize_pressed_png_1889087864;
         this._embed_css_images_Button_Standard_tileable_disabled_png_924179912 = Tibia__embed_css_images_Button_Standard_tileable_disabled_png_924179912;
         this._embed_css_images_Button_Standard_tileable_end_disabled_png_2034495004 = Tibia__embed_css_images_Button_Standard_tileable_end_disabled_png_2034495004;
         this._embed_css_images_Button_Standard_tileable_end_gold_disabled_png_937580587 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_disabled_png_937580587;
         this._embed_css_images_Button_Standard_tileable_end_gold_idle_png_1136343619 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_idle_png_1136343619;
         this._embed_css_images_Button_Standard_tileable_end_gold_over_png_1554034499 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_over_png_1554034499;
         this._embed_css_images_Button_Standard_tileable_end_gold_pressed_png_240394377 = Tibia__embed_css_images_Button_Standard_tileable_end_gold_pressed_png_240394377;
         this._embed_css_images_Button_Standard_tileable_end_idle_png_843118940 = Tibia__embed_css_images_Button_Standard_tileable_end_idle_png_843118940;
         this._embed_css_images_Button_Standard_tileable_end_over_png_1185179228 = Tibia__embed_css_images_Button_Standard_tileable_end_over_png_1185179228;
         this._embed_css_images_Button_Standard_tileable_end_pressed_png_502750776 = Tibia__embed_css_images_Button_Standard_tileable_end_pressed_png_502750776;
         this._embed_css_images_Button_Standard_tileable_gold_idle_png_2075764191 = Tibia__embed_css_images_Button_Standard_tileable_gold_idle_png_2075764191;
         this._embed_css_images_Button_Standard_tileable_gold_over_png_278071585 = Tibia__embed_css_images_Button_Standard_tileable_gold_over_png_278071585;
         this._embed_css_images_Button_Standard_tileable_gold_pressed_png_1220997645 = Tibia__embed_css_images_Button_Standard_tileable_gold_pressed_png_1220997645;
         this._embed_css_images_Button_Standard_tileable_idle_png_197744608 = Tibia__embed_css_images_Button_Standard_tileable_idle_png_197744608;
         this._embed_css_images_Button_Standard_tileable_over_png_8469280 = Tibia__embed_css_images_Button_Standard_tileable_over_png_8469280;
         this._embed_css_images_Button_Standard_tileable_pressed_png_1457624492 = Tibia__embed_css_images_Button_Standard_tileable_pressed_png_1457624492;
         this._embed_css_images_BuySellTab_active_png_1448857198 = Tibia__embed_css_images_BuySellTab_active_png_1448857198;
         this._embed_css_images_BuySellTab_idle_png_1813518400 = Tibia__embed_css_images_BuySellTab_idle_png_1813518400;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_971709072 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_idle_png_971709072;
         this._embed_css_images_ChatTab_tileable_EndpieceLeft_png_388101843 = Tibia__embed_css_images_ChatTab_tileable_EndpieceLeft_png_388101843;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1500200523 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_idle_png_1500200523;
         this._embed_css_images_ChatTab_tileable_EndpieceRound_png_1670854302 = Tibia__embed_css_images_ChatTab_tileable_EndpieceRound_png_1670854302;
         this._embed_css_images_ChatTab_tileable_idle_png_1162118089 = Tibia__embed_css_images_ChatTab_tileable_idle_png_1162118089;
         this._embed_css_images_ChatTab_tileable_png_891668710 = Tibia__embed_css_images_ChatTab_tileable_png_891668710;
         this._embed_css_images_ChatWindow_Mover_png_1984658938 = Tibia__embed_css_images_ChatWindow_Mover_png_1984658938;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_over_png_777638187 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_over_png_777638187;
         this._embed_css_images_Icons_BattleList_HideMonsters_active_png_1653601666 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_active_png_1653601666;
         this._embed_css_images_Icons_BattleList_HideMonsters_idle_png_1175600896 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_idle_png_1175600896;
         this._embed_css_images_Icons_BattleList_HideMonsters_over_png_1321679360 = Tibia__embed_css_images_Icons_BattleList_HideMonsters_over_png_1321679360;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_over_png_943132624 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_over_png_943132624;
         this._embed_css_images_Icons_BattleList_HideNPCs_active_png_1942225789 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_active_png_1942225789;
         this._embed_css_images_Icons_BattleList_HideNPCs_idle_png_1854361531 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_idle_png_1854361531;
         this._embed_css_images_Icons_BattleList_HideNPCs_over_png_985907899 = Tibia__embed_css_images_Icons_BattleList_HideNPCs_over_png_985907899;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_over_png_953158762 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_over_png_953158762;
         this._embed_css_images_Icons_BattleList_HidePlayers_active_png_1093559463 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_active_png_1093559463;
         this._embed_css_images_Icons_BattleList_HidePlayers_idle_png_214541771 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_idle_png_214541771;
         this._embed_css_images_Icons_BattleList_HidePlayers_over_png_561845963 = Tibia__embed_css_images_Icons_BattleList_HidePlayers_over_png_561845963;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_over_png_467647408 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_over_png_467647408;
         this._embed_css_images_Icons_BattleList_HideSkulled_active_png_1482272179 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_active_png_1482272179;
         this._embed_css_images_Icons_BattleList_HideSkulled_idle_png_1109498491 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_idle_png_1109498491;
         this._embed_css_images_Icons_BattleList_HideSkulled_over_png_761929083 = Tibia__embed_css_images_Icons_BattleList_HideSkulled_over_png_761929083;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_over_png_604627565 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_over_png_604627565;
         this._embed_css_images_Icons_BattleList_PartyMembers_active_png_1962653882 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_active_png_1962653882;
         this._embed_css_images_Icons_BattleList_PartyMembers_idle_png_451139672 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_idle_png_451139672;
         this._embed_css_images_Icons_BattleList_PartyMembers_over_png_81241256 = Tibia__embed_css_images_Icons_BattleList_PartyMembers_over_png_81241256;
         this._embed_css_images_Icons_CombatControls_AttackNo_idle_png_489114602 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_idle_png_489114602;
         this._embed_css_images_Icons_CombatControls_AttackNo_over_png_839560426 = Tibia__embed_css_images_Icons_CombatControls_AttackNo_over_png_839560426;
         this._embed_css_images_Icons_CombatControls_AttackYes_idle_png_1185167518 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_idle_png_1185167518;
         this._embed_css_images_Icons_CombatControls_AttackYes_over_png_853589918 = Tibia__embed_css_images_Icons_CombatControls_AttackYes_over_png_853589918;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1498472403 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_idle_png_1498472403;
         this._embed_css_images_Icons_CombatControls_AutochaseOn_over_png_627798739 = Tibia__embed_css_images_Icons_CombatControls_AutochaseOn_over_png_627798739;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1393751737 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_idle_png_1393751737;
         this._embed_css_images_Icons_CombatControls_DefensiveOff_over_png_114850745 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOff_over_png_114850745;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1844528831 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_active_png_1844528831;
         this._embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1948052399 = Tibia__embed_css_images_Icons_CombatControls_DefensiveOn_idle_png_1948052399;
         this._embed_css_images_Icons_CombatControls_DoveOff_idle_png_784504280 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_idle_png_784504280;
         this._embed_css_images_Icons_CombatControls_DoveOff_over_png_1037695272 = Tibia__embed_css_images_Icons_CombatControls_DoveOff_over_png_1037695272;
         this._embed_css_images_Icons_CombatControls_DoveOn_idle_png_1394565798 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_idle_png_1394565798;
         this._embed_css_images_Icons_CombatControls_DoveOn_over_png_1063899558 = Tibia__embed_css_images_Icons_CombatControls_DoveOn_over_png_1063899558;
         this._embed_css_images_Icons_CombatControls_MediumOff_idle_png_852604073 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_idle_png_852604073;
         this._embed_css_images_Icons_CombatControls_MediumOff_over_png_424204887 = Tibia__embed_css_images_Icons_CombatControls_MediumOff_over_png_424204887;
         this._embed_css_images_Icons_CombatControls_MediumOn_idle_png_1749550303 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_idle_png_1749550303;
         this._embed_css_images_Icons_CombatControls_MediumOn_over_png_863798239 = Tibia__embed_css_images_Icons_CombatControls_MediumOn_over_png_863798239;
         this._embed_css_images_Icons_CombatControls_Mounted_idle_png_996457113 = Tibia__embed_css_images_Icons_CombatControls_Mounted_idle_png_996457113;
         this._embed_css_images_Icons_CombatControls_Mounted_over_png_665667993 = Tibia__embed_css_images_Icons_CombatControls_Mounted_over_png_665667993;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_460352161 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_idle_png_460352161;
         this._embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1186785697 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOff_over_png_1186785697;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_906069205 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_idle_png_906069205;
         this._embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2041601067 = Tibia__embed_css_images_Icons_CombatControls_OffensiveOn_over_png_2041601067;
         this._embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1210018985 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_idle_png_1210018985;
         this._embed_css_images_Icons_CombatControls_RedFistOff_over_png_862580649 = Tibia__embed_css_images_Icons_CombatControls_RedFistOff_over_png_862580649;
         this._embed_css_images_Icons_CombatControls_RedFistOn_idle_png_133528589 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_idle_png_133528589;
         this._embed_css_images_Icons_CombatControls_RedFistOn_over_png_196873459 = Tibia__embed_css_images_Icons_CombatControls_RedFistOn_over_png_196873459;
         this._embed_css_images_Icons_CombatControls_StandOff_idle_png_2144676134 = Tibia__embed_css_images_Icons_CombatControls_StandOff_idle_png_2144676134;
         this._embed_css_images_Icons_CombatControls_StandOff_over_png_186767398 = Tibia__embed_css_images_Icons_CombatControls_StandOff_over_png_186767398;
         this._embed_css_images_Icons_CombatControls_Unmounted_idle_png_1683372450 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_idle_png_1683372450;
         this._embed_css_images_Icons_CombatControls_Unmounted_over_png_941079202 = Tibia__embed_css_images_Icons_CombatControls_Unmounted_over_png_941079202;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_958285816 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_idle_png_958285816;
         this._embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1288816888 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOff_over_png_1288816888;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1492771498 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_idle_png_1492771498;
         this._embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1917883478 = Tibia__embed_css_images_Icons_CombatControls_WhiteHandOn_over_png_1917883478;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_629742491 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_idle_png_629742491;
         this._embed_css_images_Icons_CombatControls_YellowHandOff_over_png_913218715 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOff_over_png_913218715;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_499580335 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_idle_png_499580335;
         this._embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1122206033 = Tibia__embed_css_images_Icons_CombatControls_YellowHandOn_over_png_1122206033;
         this._embed_css_images_Icons_Conditions_Bleeding_png_253641108 = Tibia__embed_css_images_Icons_Conditions_Bleeding_png_253641108;
         this._embed_css_images_Icons_Conditions_Burning_png_1220928865 = Tibia__embed_css_images_Icons_Conditions_Burning_png_1220928865;
         this._embed_css_images_Icons_Conditions_Cursed_png_969214734 = Tibia__embed_css_images_Icons_Conditions_Cursed_png_969214734;
         this._embed_css_images_Icons_Conditions_Dazzled_png_1667984088 = Tibia__embed_css_images_Icons_Conditions_Dazzled_png_1667984088;
         this._embed_css_images_Icons_Conditions_Drowning_png_748290826 = Tibia__embed_css_images_Icons_Conditions_Drowning_png_748290826;
         this._embed_css_images_Icons_Conditions_Drunk_png_447748178 = Tibia__embed_css_images_Icons_Conditions_Drunk_png_447748178;
         this._embed_css_images_Icons_Conditions_Electrified_png_1775143710 = Tibia__embed_css_images_Icons_Conditions_Electrified_png_1775143710;
         this._embed_css_images_Icons_Conditions_Freezing_png_1381179200 = Tibia__embed_css_images_Icons_Conditions_Freezing_png_1381179200;
         this._embed_css_images_Icons_Conditions_Haste_png_183664137 = Tibia__embed_css_images_Icons_Conditions_Haste_png_183664137;
         this._embed_css_images_Icons_Conditions_Hungry_png_351039795 = Tibia__embed_css_images_Icons_Conditions_Hungry_png_351039795;
         this._embed_css_images_Icons_Conditions_Logoutblock_png_692217617 = Tibia__embed_css_images_Icons_Conditions_Logoutblock_png_692217617;
         this._embed_css_images_Icons_Conditions_MagicShield_png_8396320 = Tibia__embed_css_images_Icons_Conditions_MagicShield_png_8396320;
         this._embed_css_images_Icons_Conditions_PZ_png_2003666550 = Tibia__embed_css_images_Icons_Conditions_PZ_png_2003666550;
         this._embed_css_images_Icons_Conditions_PZlock_png_1221525371 = Tibia__embed_css_images_Icons_Conditions_PZlock_png_1221525371;
         this._embed_css_images_Icons_Conditions_Poisoned_png_1746048425 = Tibia__embed_css_images_Icons_Conditions_Poisoned_png_1746048425;
         this._embed_css_images_Icons_Conditions_Slowed_png_543074756 = Tibia__embed_css_images_Icons_Conditions_Slowed_png_543074756;
         this._embed_css_images_Icons_Conditions_Strenghtened_png_751812737 = Tibia__embed_css_images_Icons_Conditions_Strenghtened_png_751812737;
         this._embed_css_images_Icons_PremmyPurse_active_over_png_1535578612 = Tibia__embed_css_images_Icons_PremmyPurse_active_over_png_1535578612;
         this._embed_css_images_Icons_PremmyPurse_active_png_1741057169 = Tibia__embed_css_images_Icons_PremmyPurse_active_png_1741057169;
         this._embed_css_images_Icons_ProgressBars_AxeFighting_png_863006467 = Tibia__embed_css_images_Icons_ProgressBars_AxeFighting_png_863006467;
         this._embed_css_images_Icons_ProgressBars_ClubFighting_png_1268717091 = Tibia__embed_css_images_Icons_ProgressBars_ClubFighting_png_1268717091;
         this._embed_css_images_Icons_ProgressBars_CompactStyle_png_1922114025 = Tibia__embed_css_images_Icons_ProgressBars_CompactStyle_png_1922114025;
         this._embed_css_images_Icons_ProgressBars_DefaultStyle_png_1812077861 = Tibia__embed_css_images_Icons_ProgressBars_DefaultStyle_png_1812077861;
         this._embed_css_images_Icons_ProgressBars_DistanceFighting_png_1314144530 = Tibia__embed_css_images_Icons_ProgressBars_DistanceFighting_png_1314144530;
         this._embed_css_images_Icons_ProgressBars_Fishing_png_354963859 = Tibia__embed_css_images_Icons_ProgressBars_Fishing_png_354963859;
         this._embed_css_images_Icons_ProgressBars_FistFighting_png_1219110463 = Tibia__embed_css_images_Icons_ProgressBars_FistFighting_png_1219110463;
         this._embed_css_images_Icons_ProgressBars_LargeStyle_png_1488259167 = Tibia__embed_css_images_Icons_ProgressBars_LargeStyle_png_1488259167;
         this._embed_css_images_Icons_ProgressBars_MagicLevel_png_1498653378 = Tibia__embed_css_images_Icons_ProgressBars_MagicLevel_png_1498653378;
         this._embed_css_images_Icons_ProgressBars_ParallelStyle_png_436085555 = Tibia__embed_css_images_Icons_ProgressBars_ParallelStyle_png_436085555;
         this._embed_css_images_Icons_ProgressBars_ProgressOff_png_1772969717 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOff_png_1772969717;
         this._embed_css_images_Icons_ProgressBars_ProgressOn_png_767116025 = Tibia__embed_css_images_Icons_ProgressBars_ProgressOn_png_767116025;
         this._embed_css_images_Icons_ProgressBars_Shielding_png_1148874264 = Tibia__embed_css_images_Icons_ProgressBars_Shielding_png_1148874264;
         this._embed_css_images_Icons_ProgressBars_SwordFighting_png_320929806 = Tibia__embed_css_images_Icons_ProgressBars_SwordFighting_png_320929806;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1063010071 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_idle_png_1063010071;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_858104855 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_over_png_858104855;
         this._embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_536906987 = Tibia__embed_css_images_Icons_TradeLists_ContainerDisplay_pressed_png_536906987;
         this._embed_css_images_Icons_TradeLists_ListDisplay_idle_png_410695582 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_idle_png_410695582;
         this._embed_css_images_Icons_TradeLists_ListDisplay_over_png_742275230 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_over_png_742275230;
         this._embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1589951190 = Tibia__embed_css_images_Icons_TradeLists_ListDisplay_pressed_png_1589951190;
         this._embed_css_images_Icons_WidgetHeaders_BattleList_png_1188721388 = Tibia__embed_css_images_Icons_WidgetHeaders_BattleList_png_1188721388;
         this._embed_css_images_Icons_WidgetHeaders_Combat_png_510137618 = Tibia__embed_css_images_Icons_WidgetHeaders_Combat_png_510137618;
         this._embed_css_images_Icons_WidgetHeaders_GeneralControls_png_216495590 = Tibia__embed_css_images_Icons_WidgetHeaders_GeneralControls_png_216495590;
         this._embed_css_images_Icons_WidgetHeaders_Inventory_png_1804456604 = Tibia__embed_css_images_Icons_WidgetHeaders_Inventory_png_1804456604;
         this._embed_css_images_Icons_WidgetHeaders_Minimap_png_2095987393 = Tibia__embed_css_images_Icons_WidgetHeaders_Minimap_png_2095987393;
         this._embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1500578858 = Tibia__embed_css_images_Icons_WidgetHeaders_SafeTrades_png_1500578858;
         this._embed_css_images_Icons_WidgetHeaders_Spells_png_528765315 = Tibia__embed_css_images_Icons_WidgetHeaders_Spells_png_528765315;
         this._embed_css_images_Icons_WidgetHeaders_Trades_png_116771265 = Tibia__embed_css_images_Icons_WidgetHeaders_Trades_png_116771265;
         this._embed_css_images_Icons_WidgetHeaders_VipList_png_432242855 = Tibia__embed_css_images_Icons_WidgetHeaders_VipList_png_432242855;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_55788873 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_over_png_55788873;
         this._embed_css_images_Icons_WidgetMenu_BattleList_active_png_991395604 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_active_png_991395604;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_394809621 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_over_png_394809621;
         this._embed_css_images_Icons_WidgetMenu_BattleList_idle_png_633661502 = Tibia__embed_css_images_Icons_WidgetMenu_BattleList_idle_png_633661502;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1000643385 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_over_png_1000643385;
         this._embed_css_images_Icons_WidgetMenu_Combat_active_png_399020502 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_active_png_399020502;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1328098599 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_over_png_1328098599;
         this._embed_css_images_Icons_WidgetMenu_Combat_idle_png_1613024508 = Tibia__embed_css_images_Icons_WidgetMenu_Combat_idle_png_1613024508;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1289566917 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_over_png_1289566917;
         this._embed_css_images_Icons_WidgetMenu_Containers_active_png_448347528 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_active_png_448347528;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1671581321 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_over_png_1671581321;
         this._embed_css_images_Icons_WidgetMenu_Containers_idle_png_1939647142 = Tibia__embed_css_images_Icons_WidgetMenu_Containers_idle_png_1939647142;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_161215467 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_over_png_161215467;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1011953256 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_active_png_1011953256;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1318367641 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_over_png_1318367641;
         this._embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1921951062 = Tibia__embed_css_images_Icons_WidgetMenu_GeneralControls_idle_png_1921951062;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1010209603 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_over_png_1010209603;
         this._embed_css_images_Icons_WidgetMenu_Inventory_active_png_47370426 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_active_png_47370426;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1019732347 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_over_png_1019732347;
         this._embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2109320296 = Tibia__embed_css_images_Icons_WidgetMenu_Inventory_idle_png_2109320296;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_122833288 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_over_png_122833288;
         this._embed_css_images_Icons_WidgetMenu_Minimap_active_png_279706907 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_active_png_279706907;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1922488614 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_over_png_1922488614;
         this._embed_css_images_Icons_WidgetMenu_Minimap_idle_png_362912147 = Tibia__embed_css_images_Icons_WidgetMenu_Minimap_idle_png_362912147;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1720517198 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_over_png_1720517198;
         this._embed_css_images_Icons_WidgetMenu_Trades_active_png_1461845359 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_active_png_1461845359;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_565305968 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_over_png_565305968;
         this._embed_css_images_Icons_WidgetMenu_Trades_idle_png_1264544957 = Tibia__embed_css_images_Icons_WidgetMenu_Trades_idle_png_1264544957;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_over_png_450699582 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_over_png_450699582;
         this._embed_css_images_Icons_WidgetMenu_VipList_active_png_19492319 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_active_png_19492319;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_418761040 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_over_png_418761040;
         this._embed_css_images_Icons_WidgetMenu_VipList_idle_png_176944461 = Tibia__embed_css_images_Icons_WidgetMenu_VipList_idle_png_176944461;
         this._embed_css_images_Inventory_png_321074298 = Tibia__embed_css_images_Inventory_png_321074298;
         this._embed_css_images_Minimap_Center_active_png_1666601632 = Tibia__embed_css_images_Minimap_Center_active_png_1666601632;
         this._embed_css_images_Minimap_Center_idle_png_2086053406 = Tibia__embed_css_images_Minimap_Center_idle_png_2086053406;
         this._embed_css_images_Minimap_Center_over_png_470603490 = Tibia__embed_css_images_Minimap_Center_over_png_470603490;
         this._embed_css_images_Minimap_ZoomIn_idle_png_267736575 = Tibia__embed_css_images_Minimap_ZoomIn_idle_png_267736575;
         this._embed_css_images_Minimap_ZoomIn_over_png_1553063167 = Tibia__embed_css_images_Minimap_ZoomIn_over_png_1553063167;
         this._embed_css_images_Minimap_ZoomIn_pressed_png_608234453 = Tibia__embed_css_images_Minimap_ZoomIn_pressed_png_608234453;
         this._embed_css_images_Minimap_ZoomOut_idle_png_1822944258 = Tibia__embed_css_images_Minimap_ZoomOut_idle_png_1822944258;
         this._embed_css_images_Minimap_ZoomOut_over_png_554390786 = Tibia__embed_css_images_Minimap_ZoomOut_over_png_554390786;
         this._embed_css_images_Minimap_ZoomOut_pressed_png_962262274 = Tibia__embed_css_images_Minimap_ZoomOut_pressed_png_962262274;
         this._embed_css_images_Minimap_png_476321933 = Tibia__embed_css_images_Minimap_png_476321933;
         this._embed_css_images_Scrollbar_Arrow_down_idle_png_382013060 = Tibia__embed_css_images_Scrollbar_Arrow_down_idle_png_382013060;
         this._embed_css_images_Scrollbar_Arrow_down_over_png_1433768060 = Tibia__embed_css_images_Scrollbar_Arrow_down_over_png_1433768060;
         this._embed_css_images_Scrollbar_Arrow_down_pressed_png_1457443904 = Tibia__embed_css_images_Scrollbar_Arrow_down_pressed_png_1457443904;
         this._embed_css_images_Scrollbar_Arrow_up_idle_png_664921289 = Tibia__embed_css_images_Scrollbar_Arrow_up_idle_png_664921289;
         this._embed_css_images_Scrollbar_Arrow_up_over_png_996496841 = Tibia__embed_css_images_Scrollbar_Arrow_up_over_png_996496841;
         this._embed_css_images_Scrollbar_Arrow_up_pressed_png_29793219 = Tibia__embed_css_images_Scrollbar_Arrow_up_pressed_png_29793219;
         this._embed_css_images_Scrollbar_Handler_png_487848961 = Tibia__embed_css_images_Scrollbar_Handler_png_487848961;
         this._embed_css_images_Scrollbar_tileable_png_1484543023 = Tibia__embed_css_images_Scrollbar_tileable_png_1484543023;
         this._embed_css_images_Slot_Hotkey_Cooldown_png_1086649271 = Tibia__embed_css_images_Slot_Hotkey_Cooldown_png_1086649271;
         this._embed_css_images_Slot_InventoryAmmo_png_1348526999 = Tibia__embed_css_images_Slot_InventoryAmmo_png_1348526999;
         this._embed_css_images_Slot_InventoryArmor_png_1986121246 = Tibia__embed_css_images_Slot_InventoryArmor_png_1986121246;
         this._embed_css_images_Slot_InventoryBackpack_png_1072136453 = Tibia__embed_css_images_Slot_InventoryBackpack_png_1072136453;
         this._embed_css_images_Slot_InventoryBoots_png_1938275472 = Tibia__embed_css_images_Slot_InventoryBoots_png_1938275472;
         this._embed_css_images_Slot_InventoryHead_png_1095038683 = Tibia__embed_css_images_Slot_InventoryHead_png_1095038683;
         this._embed_css_images_Slot_InventoryLegs_png_1770687572 = Tibia__embed_css_images_Slot_InventoryLegs_png_1770687572;
         this._embed_css_images_Slot_InventoryNecklace_png_1875912705 = Tibia__embed_css_images_Slot_InventoryNecklace_png_1875912705;
         this._embed_css_images_Slot_InventoryRing_png_670915893 = Tibia__embed_css_images_Slot_InventoryRing_png_670915893;
         this._embed_css_images_Slot_InventoryShield_png_125994256 = Tibia__embed_css_images_Slot_InventoryShield_png_125994256;
         this._embed_css_images_Slot_InventoryWeapon_png_2057395095 = Tibia__embed_css_images_Slot_InventoryWeapon_png_2057395095;
         this._embed_css_images_Slot_Statusicon_highlighted_png_1731350362 = Tibia__embed_css_images_Slot_Statusicon_highlighted_png_1731350362;
         this._embed_css_images_Slot_Statusicon_png_1271145738 = Tibia__embed_css_images_Slot_Statusicon_png_1271145738;
         this._embed_css_images_Widget_Footer_tileable_end01_png_642865466 = Tibia__embed_css_images_Widget_Footer_tileable_end01_png_642865466;
         this._embed_css_images_Widget_Footer_tileable_end02_png_641667519 = Tibia__embed_css_images_Widget_Footer_tileable_end02_png_641667519;
         this._embed_css_images_Widget_Footer_tileable_png_1991139393 = Tibia__embed_css_images_Widget_Footer_tileable_png_1991139393;
         this._embed_css_images_Widget_HeaderBG_png_331533643 = Tibia__embed_css_images_Widget_HeaderBG_png_331533643;
         this._embed_css_images_slot_Hotkey_disabled_png_1139776804 = Tibia__embed_css_images_slot_Hotkey_disabled_png_1139776804;
         this._embed_css_images_slot_Hotkey_highlighted_png_1930802827 = Tibia__embed_css_images_slot_Hotkey_highlighted_png_1930802827;
         this._embed_css_images_slot_Hotkey_png_344241391 = Tibia__embed_css_images_slot_Hotkey_png_344241391;
         this._embed_css_images_slot_container_disabled_png_1545968009 = Tibia__embed_css_images_slot_container_disabled_png_1545968009;
         this._embed_css_images_slot_container_highlighted_png_630804576 = Tibia__embed_css_images_slot_container_highlighted_png_630804576;
         this._embed_css_images_slot_container_png_1524796916 = Tibia__embed_css_images_slot_container_png_1524796916;
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
      
      private function onConnectionRecovered(param1:ConnectionEvent) : void
      {
         this.m_ConnectionLostDialog.hide();
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UIActionBarRight() : VActionBarWidget
      {
         return this._2043305115m_UIActionBarRight;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleRight() : ToggleBar
      {
         return this._665607314m_UISideBarToggleRight;
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
               this.m_Communication.disconnect(false);
            }
            else if(!this.m_Connection.isConnected)
            {
               this.loginCharacter();
            }
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
      public function get m_UISideBarA() : SideBarWidget
      {
         return this._64278965m_UISideBarA;
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
      
      [Bindable(event="propertyChange")]
      public function get m_UIGameWindow() : GridContainer
      {
         return this._1404294856m_UIGameWindow;
      }
      
      [Bindable(event="propertyChange")]
      public function get m_UISideBarToggleLeft() : ToggleBar
      {
         return this._2056921391m_UISideBarToggleLeft;
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

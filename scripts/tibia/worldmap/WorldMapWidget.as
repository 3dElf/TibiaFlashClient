package tibia.worldmap
{
    import __AS3__.vec.*;
    import build.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.help.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.mapping.*;
    import tibia.network.*;
    import tibia.options.*;
    import tibia.worldmap.widgetClasses.*;

    public class WorldMapWidget extends UIComponent implements IUseWidget, IMoveWidget
    {
        private var m_DragHandler:ObjectDragImpl;
        private var m_Player:Player = null;
        private var m_InfoTimestamp:Number = -1.#INF;
        private var m_UIBackdrop:FlexShape = null;
        private var m_Options:OptionsStorage = null;
        private var m_UIInfoFramerate:Label = null;
        private var m_WorldMapStorage:WorldMapStorage = null;
        private var m_MouseCursorOverRenderer:Boolean = false;
        private var m_UIRendererImpl:RendererImpl = null;
        private var m_CreatureStorage:CreatureStorage = null;
        private var m_UncommittedOptions:Boolean = false;
        private var m_UncommittedPlayer:Boolean = false;
        private var m_CursorHelper:CursorHelper;
        private var m_UncommittedWorldMapStorage:Boolean = false;
        private var m_UIInfoLatency:ShapeWrapper = null;
        private var m_UncommittedCreatureStorage:Boolean = false;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        private static const ACTION_LOOK:int = 6;
        static const NUM_EFFECTS:int = 200;
        private static const ACTION_SMARTCLICK:int = 100;
        private static const ACTION_TALK:int = 9;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        static const DRAG_TYPE_CHANNEL:String = "channel";
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const FIELD_HEIGHT:int = 24;
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        static const UNDERGROUND_LAYER:int = 2;
        private static const LATENCY_ICON_MEDIUM:Bitmap = new EMBED_LATENCY_ICON_MEDIUM();
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static const s_TempPoint:Point = new Point();
        static const FIELD_CACHESIZE:int = 32;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        static const DRAG_TYPE_ACTION:String = "action";
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        static const DRAG_TYPE_OBJECT:String = "object";
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        private static const ACTION_ATTACK:int = 1;
        private static const EMBED_LATENCY_ICON_LOW:Class = WorldMapWidget_EMBED_LATENCY_ICON_LOW;
        private static const ACTION_CONTEXT_MENU:int = 5;
        static const GROUND_LAYER:int = 7;
        private static const VALID_ACTIONS:Vector.<uint> = WorldMapWidget.Vector.<uint>([ACTION_AUTOWALK, ACTION_AUTOWALK_HIGHLIGHT, ACTION_TALK, ACTION_ATTACK, ACTION_USE, ACTION_OPEN, ACTION_LOOK, ACTION_CONTEXT_MENU]);
        private static const EMBED_LATENCY_ICON_HIGH:Class = WorldMapWidget_EMBED_LATENCY_ICON_HIGH;
        private static const BUNDLE:String = "WorldMapStorage";
        private static const LATENCY_ICON_HIGH:Bitmap = new EMBED_LATENCY_ICON_HIGH();
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        private static const ACTION_NONE:int = 0;
        private static const EMBED_LATENCY_ICON_MEDIUM:Class = WorldMapWidget_EMBED_LATENCY_ICON_MEDIUM;
        static const NUM_FIELDS:int = 2016;
        private static const ACTION_OPEN:int = 8;
        static const DRAG_TYPE_SPELL:String = "spell";
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const LATENCY_ICON_LOW:Bitmap = new EMBED_LATENCY_ICON_LOW();
        private static const ACTION_USE_OR_OPEN:int = 101;
        private static const ACTION_UNSET:int = -1;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        private static const ACTION_USE:int = 7;
        static const DRAG_OPACITY:Number = 0.75;
        private static const ACTION_AUTOWALK:int = 3;
        static const MAP_WIDTH:int = 15;
        private static const s_InteractiveObjectWrapper:Object = new Object();

        public function WorldMapWidget()
        {
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.MEDIUM);
            this.m_DragHandler = ObjectDragImplFactory.s_CreateObjectDragImpl();
            addEventListener(ResizeEvent.RESIZE, this.onResize);
            Tibia.s_GetUIEffectsManager().addEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            return;
        }// end function

        private function onUIEffectsCommandEvent(event:UIEffectsRetrieveComponentCommandEvent) : void
        {
            if (event.type == UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT && event.identifier == WorldMapWidget && event.subIdentifier == RendererImpl)
            {
                event.resultUIComponent = this.m_UIRendererImpl;
            }
            return;
        }// end function

        private function onMouseMove(event:MouseEvent) : void
        {
            if (event.type == MouseEvent.ROLL_OVER)
            {
                this.m_MouseCursorOverRenderer = true;
                if (this.m_MouseCursorOverRenderer)
                {
                    this.determineAction(event, false, true, true);
                }
            }
            else if (event.type == MouseEvent.ROLL_OUT)
            {
                this.m_MouseCursorOverRenderer = false;
                this.m_CursorHelper.resetCursor();
            }
            if (this.m_MouseCursorOverRenderer && this.m_UIRendererImpl != null && this.m_Options != null && this.m_Options.rendererHighlight > 0 && ContextMenuBase.getCurrent() == null && PopUpBase.getCurrent() == null)
            {
                if (event.type != MouseEvent.ROLL_OUT)
                {
                    this.m_UIRendererImpl.highlightTile = this.m_UIRendererImpl.pointToMap(event.localX, event.localY, false);
                }
                else
                {
                    this.m_UIRendererImpl.highlightTile = null;
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIBackdrop = new FlexShape();
            this.m_UIBackdrop.name = "backdrop";
            addChild(this.m_UIBackdrop);
            this.m_UIRendererImpl = new RendererImpl();
            this.m_UIRendererImpl.name = "renderer";
            this.m_UIRendererImpl.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.m_UIRendererImpl.addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseClick);
            this.m_UIRendererImpl.addEventListener(MouseEvent.MIDDLE_CLICK, this.onMouseClick);
            this.m_UIRendererImpl.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.m_UIRendererImpl.addEventListener(MouseEvent.ROLL_OUT, this.onMouseMove);
            this.m_UIRendererImpl.addEventListener(MouseEvent.ROLL_OVER, this.onMouseMove);
            addChild(this.m_UIRendererImpl);
            this.m_DragHandler.addDragComponent(this.m_UIRendererImpl);
            this.m_UIInfoLatency = new ShapeWrapper();
            this.m_UIInfoLatency.name = "latency";
            addChild(this.m_UIInfoLatency);
            this.m_UIInfoFramerate = new Label();
            this.m_UIInfoFramerate.name = "framerate";
            this.m_UIInfoFramerate.text = null;
            this.m_UIInfoFramerate.setStyle("color", 65280);
            this.m_UIInfoFramerate.setStyle("fontSize", 12);
            this.m_UIInfoFramerate.setStyle("fontWeight", "bold");
            addChild(this.m_UIInfoFramerate);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        private function onMouseClick(event:MouseEvent) : void
        {
            this.determineAction(event, true, false);
            return;
        }// end function

        public function getMoveObjectUnderPoint(param1:Point) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_UIRendererImpl != null && this.m_WorldMapStorage != null)
            {
                _loc_2 = this.m_UIRendererImpl.globalToLocal(param1);
                _loc_3 = this.m_UIRendererImpl.pointToMap(_loc_2.x, _loc_2.y, false);
                if (_loc_3 != null)
                {
                    _loc_4 = {absolute:this.m_WorldMapStorage.toAbsolute(_loc_3)};
                    this.m_WorldMapStorage.getTopMoveObject(_loc_3.x, _loc_3.y, _loc_3.z, _loc_4);
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public function getUseObjectUnderPoint(param1:Point) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_UIRendererImpl != null && this.m_WorldMapStorage != null)
            {
                _loc_2 = this.m_UIRendererImpl.globalToLocal(param1);
                _loc_3 = this.m_UIRendererImpl.pointToMap(_loc_2.x, _loc_2.y, false);
                if (_loc_3 != null)
                {
                    _loc_4 = {absolute:this.m_WorldMapStorage.toAbsolute(_loc_3)};
                    this.m_WorldMapStorage.getTopUseObject(_loc_3.x, _loc_3.y, _loc_3.z, _loc_4);
                    return _loc_4;
                }
            }
            return null;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.m_UIRendererImpl != null && this.m_Options != null && this.m_Options.rendererHighlight > 0 && ContextMenuBase.getCurrent() == null && PopUpBase.getCurrent() == null)
            {
                _loc_2 = this.m_UIRendererImpl.highlightTile;
                _loc_3 = this.m_UIRendererImpl.pointToMap(this.m_UIRendererImpl.mouseX, this.m_UIRendererImpl.mouseY, false);
                if (_loc_3 != null && _loc_2 != null)
                {
                    _loc_3.x = _loc_2.x;
                    _loc_3.y = _loc_2.y;
                }
                if (this.m_MouseCursorOverRenderer)
                {
                    this.m_UIRendererImpl.highlightTile = _loc_3;
                }
                else
                {
                    this.m_UIRendererImpl.highlightTile = null;
                }
            }
            if (this.m_MouseCursorOverRenderer)
            {
                this.determineAction(null, false, true, true);
            }
            else if (this.m_CreatureStorage != null && this.m_CreatureStorage.getAim() != null)
            {
                this.m_UIRendererImpl.highlightObject = this.m_CreatureStorage.getAim();
            }
            else
            {
                this.m_UIRendererImpl.highlightObject = null;
            }
            if (this.m_Options != null && this.m_Options.rendererShowFrameRate)
            {
                _loc_4 = getTimer();
                if (this.m_UIRendererImpl != null && this.m_WorldMapStorage != null && _loc_4 > this.m_InfoTimestamp + 500)
                {
                    this.m_InfoTimestamp = _loc_4;
                    _loc_5 = Tibia.s_GetConnection();
                    this.m_UIInfoLatency.removeChildren();
                    if (_loc_5 != null && _loc_5.isGameRunning)
                    {
                        if (_loc_5.latency < Connection.LATENCY_LOW)
                        {
                            this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE, "LATENCY_TOOTLIP_LOW");
                            this.m_UIInfoLatency.addChild(LATENCY_ICON_LOW);
                        }
                        else if (_loc_5.latency < Connection.LATENCY_MEDIUM)
                        {
                            this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE, "LATENCY_TOOTLIP_MEDIUM");
                            this.m_UIInfoLatency.addChild(LATENCY_ICON_MEDIUM);
                        }
                        else
                        {
                            this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE, "LATENCY_TOOTLIP_HIGH");
                            this.m_UIInfoLatency.addChild(LATENCY_ICON_HIGH);
                        }
                    }
                    else
                    {
                        this.m_UIInfoLatency.toolTip = resourceManager.getString(BUNDLE, "LATENCY_TOOTLIP_NO_CONNECTION");
                        this.m_UIInfoLatency.addChild(LATENCY_ICON_HIGH);
                    }
                    _loc_6 = this.m_UIRendererImpl.fps + " FPS";
                    this.m_UIInfoFramerate.text = _loc_6;
                }
            }
            return;
        }// end function

        public function get worldMapStorage() : WorldMapStorage
        {
            return this.m_WorldMapStorage;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_UncommittedOptions = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                this.m_Player = param1;
                this.m_UncommittedPlayer = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function get creatureStorage() : CreatureStorage
        {
            return this.m_CreatureStorage;
        }// end function

        public function reset() : void
        {
            if (this.m_UIRendererImpl != null)
            {
                this.m_UIRendererImpl.reset();
            }
            return;
        }// end function

        public function pointToAbsolute(param1:Point) : Vector3D
        {
            var _loc_2:* = null;
            if (this.m_UIRendererImpl != null)
            {
                _loc_2 = this.m_UIRendererImpl.globalToLocal(param1);
                return this.m_UIRendererImpl.pointToAbsolute(_loc_2.x, _loc_2.y, false);
            }
            return null;
        }// end function

        public function pointToMap(param1:Point) : Vector3D
        {
            var _loc_2:* = null;
            if (this.m_UIRendererImpl != null)
            {
                _loc_2 = this.m_UIRendererImpl.globalToLocal(param1);
                return this.m_UIRendererImpl.pointToMap(_loc_2.x, _loc_2.y, false);
            }
            return null;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedCreatureStorage)
            {
                this.m_UIRendererImpl.creatureStorage = this.m_CreatureStorage;
                this.m_UncommittedCreatureStorage = false;
            }
            if (this.m_UncommittedOptions)
            {
                this.m_UIRendererImpl.options = this.m_Options;
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedPlayer)
            {
                this.m_UIRendererImpl.player = this.m_Player;
                this.m_UncommittedPlayer = false;
            }
            if (this.m_UncommittedWorldMapStorage)
            {
                this.m_UIRendererImpl.worldMapStorage = this.m_WorldMapStorage;
                this.m_UncommittedWorldMapStorage = false;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredMinHeight = 2 + (!isNaN(this.m_UIRendererImpl.explicitMinHeight) ? (this.m_UIRendererImpl.explicitMinHeight) : (this.m_UIRendererImpl.measuredMinHeight));
            measuredMinWidth = 2 + (!isNaN(this.m_UIRendererImpl.explicitMinWidth) ? (this.m_UIRendererImpl.explicitMinWidth) : (this.m_UIRendererImpl.measuredMinWidth));
            measuredHeight = 2 + this.m_UIRendererImpl.getExplicitOrMeasuredHeight();
            measuredWidth = 2 + this.m_UIRendererImpl.getExplicitOrMeasuredWidth();
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function set worldMapStorage(param1:WorldMapStorage) : void
        {
            if (this.m_WorldMapStorage != param1)
            {
                this.m_WorldMapStorage = param1;
                this.m_UncommittedWorldMapStorage = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function calculateOptimalSize(param1:Number, param2:Number) : Rectangle
        {
            var _loc_3:* = NaN;
            if (MAP_WIDTH > MAP_HEIGHT)
            {
                return new Rectangle(0, 0, param1, Math.round(param1 * MAP_HEIGHT / MAP_WIDTH));
            }
            if (MAP_HEIGHT < MAP_WIDTH)
            {
                return new Rectangle(0, 0, Math.round(param2 * MAP_WIDTH / MAP_HEIGHT), param2);
            }
            _loc_3 = Math.min(param1, param2);
            return new Rectangle(0, 0, _loc_3, _loc_3);
        }// end function

        private function onOptionsChange(event:PropertyChangeEvent) : void
        {
            invalidateDisplayList();
            return;
        }// end function

        public function determineAction(event:MouseEvent, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : uint
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_5:* = null;
            var _loc_6:* = ACTION_NONE;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this.m_Options == null)
            {
                return ACTION_NONE;
            }
            if (event != null)
            {
                _loc_7 = this.m_Options.mouseMapping.findBindingByMouseEvent(event);
                s_TempPoint.setTo(event.localX, event.localY);
            }
            else
            {
                _loc_7 = this.m_Options.mouseMapping.findBindingForLeftMouseButtonAndPressedModifierKey();
                s_TempPoint.setTo(this.m_UIRendererImpl.mouseX, this.m_UIRendererImpl.mouseY);
            }
            if (_loc_7 != null)
            {
                _loc_6 = _loc_7.action;
            }
            var _loc_20:* = Tibia.s_GetCommunication();
            _loc_5 = Tibia.s_GetCommunication();
            var _loc_20:* = this.m_UIRendererImpl.pointToMap(s_TempPoint.x, s_TempPoint.y, false);
            _loc_8 = this.m_UIRendererImpl.pointToMap(s_TempPoint.x, s_TempPoint.y, false);
            if (this.m_WorldMapStorage != null && this.m_Player != null && _loc_20 != null && _loc_5.isGameRunning && this.m_UIRendererImpl != null && _loc_20 != null)
            {
                _loc_10 = this.m_WorldMapStorage.toAbsolute(_loc_8);
                if (_loc_6 != ACTION_SMARTCLICK && _loc_6 != ACTION_AUTOWALK || _loc_8.z == this.m_WorldMapStorage.m_PlayerZPlane)
                {
                    _loc_11 = this.m_UIRendererImpl.pointToCreature(s_TempPoint.x, s_TempPoint.y, true);
                    _loc_12 = new Object();
                    if (_loc_11 != null)
                    {
                        this.m_WorldMapStorage.getCreatureObjectForCreature(_loc_11, _loc_12);
                        _loc_17 = null;
                        if (_loc_12.object != null)
                        {
                            _loc_17 = _loc_11;
                        }
                    }
                    _loc_13 = new Object();
                    _loc_14 = new Object();
                    if (_loc_12.object == null)
                    {
                        this.m_WorldMapStorage.getTopLookObject(_loc_8.x, _loc_8.y, _loc_8.z, _loc_13);
                    }
                    else
                    {
                        _loc_13 = _loc_12;
                    }
                    this.m_WorldMapStorage.getTopUseObject(_loc_8.x, _loc_8.y, _loc_8.z, _loc_14);
                    _loc_15 = _loc_6;
                    _loc_16 = null;
                    if (_loc_17 != null && _loc_17 != this.m_Player)
                    {
                        _loc_6 = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc_6, _loc_17, VALID_ACTIONS);
                    }
                    else if (_loc_14.object != null && AppearanceInstance(_loc_14.object).type.isUsable)
                    {
                        _loc_16 = _loc_14.object as AppearanceInstance;
                        _loc_6 = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc_6, _loc_16, VALID_ACTIONS);
                    }
                    else if (_loc_13.object != null)
                    {
                        _loc_16 = _loc_13.object as AppearanceInstance;
                        _loc_6 = MouseActionHelper.resolveActionForAppearanceOrCreature(_loc_6, _loc_16, VALID_ACTIONS);
                    }
                }
                else
                {
                    _loc_6 = ACTION_AUTOWALK;
                }
                if (_loc_16 != null && (!_loc_16.type.isDefaultAction || _loc_16.type.isDefaultAction && _loc_16.type.defaultAction == ACTION_NONE) && _loc_15 != _loc_6 && _loc_6 == ACTION_LOOK && this.m_WorldMapStorage.getEnterPossibleFlag(_loc_8.x, _loc_8.y, this.m_WorldMapStorage.m_PlayerZPlane, true) != FIELD_ENTER_NOT_POSSIBLE)
                {
                    _loc_6 = ACTION_AUTOWALK;
                }
            }
            else
            {
                _loc_6 = ACTION_NONE;
            }
            if (param3 && this.m_Options != null && this.m_Options.mouseMapping != null && this.m_Options.mouseMapping.showMouseCursorForAction)
            {
                this.m_CursorHelper.setCursor(MouseActionHelper.actionToMouseCursor(_loc_6));
            }
            if (param4)
            {
                _loc_18 = null;
                switch(_loc_6)
                {
                    case ACTION_NONE:
                    case ACTION_AUTOWALK:
                    {
                        break;
                    }
                    case ACTION_AUTOWALK_HIGHLIGHT:
                    {
                        _loc_18 = _loc_13.object;
                        break;
                    }
                    case ACTION_TALK:
                    case ACTION_ATTACK:
                    {
                        if (_loc_17 != null && _loc_17 != this.m_Player)
                        {
                            _loc_18 = _loc_12.object;
                        }
                        break;
                    }
                    case ACTION_USE:
                    case ACTION_OPEN:
                    case ACTION_CONTEXT_MENU:
                    {
                        if (_loc_14.object != null)
                        {
                            _loc_18 = _loc_14.object;
                        }
                        break;
                    }
                    case ACTION_LOOK:
                    {
                        if (_loc_13.object != null)
                        {
                            _loc_18 = _loc_13.object;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_18 != null && ContextMenuBase.getCurrent() == null && PopUpBase.getCurrent() == null)
                {
                    this.m_UIRendererImpl.highlightObject = _loc_18;
                }
                else
                {
                    this.m_UIRendererImpl.highlightObject = null;
                }
            }
            if (param2)
            {
                switch(_loc_6)
                {
                    case ACTION_NONE:
                    {
                        break;
                    }
                    case ACTION_AUTOWALK:
                    case ACTION_AUTOWALK_HIGHLIGHT:
                    {
                        _loc_10 = this.m_UIRendererImpl.pointToAbsolute(s_TempPoint.x, s_TempPoint.y, true, _loc_10);
                        _loc_19 = Tibia.s_GameActionFactory.createAutowalkAction(_loc_10.x, _loc_10.y, _loc_10.z, false, true);
                        _loc_19.perform();
                        break;
                    }
                    case ACTION_ATTACK:
                    {
                        if (_loc_17 != null && _loc_17 != this.m_Player)
                        {
                            Tibia.s_GameActionFactory.createToggleAttackTargetAction(_loc_17, true).perform();
                        }
                        break;
                    }
                    case ACTION_USE:
                    case ACTION_OPEN:
                    {
                        if (_loc_14.object != null)
                        {
                            Tibia.s_GameActionFactory.createUseAction(_loc_10, _loc_14.object, _loc_14.position, UseActionImpl.TARGET_AUTO).perform();
                        }
                        break;
                    }
                    case ACTION_TALK:
                    {
                        if (_loc_17 != null && _loc_17 != this.m_Player)
                        {
                            Tibia.s_GameActionFactory.createGreetAction(_loc_17).perform();
                        }
                        break;
                    }
                    case ACTION_LOOK:
                    {
                        if (_loc_13.object != null)
                        {
                            if (_loc_13 == _loc_12)
                            {
                                _loc_10 = _loc_17.position;
                            }
                            new LookActionImpl(_loc_10, _loc_13.object, _loc_13.position).perform();
                        }
                        break;
                    }
                    case ACTION_CONTEXT_MENU:
                    {
                        s_TempPoint.copyFrom(this.m_UIRendererImpl.localToGlobal(s_TempPoint));
                        new ObjectContextMenu(_loc_10, _loc_13, _loc_14, _loc_17).display(this, s_TempPoint.x, s_TempPoint.y);
                        break;
                    }
                    case ACTION_UNSET:
                    {
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_6;
        }// end function

        public function getMultiUseObjectUnderPoint(param1:Point) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_UIRendererImpl != null && this.m_WorldMapStorage != null)
            {
                _loc_2 = this.m_UIRendererImpl.globalToLocal(param1);
                _loc_3 = this.m_UIRendererImpl.pointToMap(_loc_2.x, _loc_2.y, false);
                if (_loc_3 != null)
                {
                    _loc_4 = {absolute:this.m_WorldMapStorage.toAbsolute(_loc_3)};
                    this.m_WorldMapStorage.getTopMultiUseObject(_loc_3.x, _loc_3.y, _loc_3.z, _loc_4);
                    return _loc_4;
                }
            }
            return null;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_6:* = NaN;
            var _loc_8:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = Math.max(0, param2 - 2);
            var _loc_4:* = Math.max(0, param1 - 2);
            var _loc_5:* = MAP_HEIGHT * FIELD_SIZE;
            _loc_6 = MAP_WIDTH * FIELD_SIZE;
            if (this.m_Options != null && this.m_Options.rendererScaleMap || _loc_3 < _loc_5 || _loc_4 < _loc_6)
            {
                _loc_10 = Math.min(_loc_3 / _loc_5, _loc_4 / _loc_6);
                _loc_5 = Math.floor(_loc_5 * _loc_10);
                _loc_6 = Math.floor(_loc_6 * _loc_10);
            }
            var _loc_7:* = Math.floor((param1 - _loc_6) / 2);
            _loc_8 = Math.floor((param2 - _loc_5) / 2);
            this.m_UIBackdrop.x = _loc_7 - 1;
            this.m_UIBackdrop.y = _loc_8 - 1;
            var _loc_9:* = this.m_UIBackdrop.graphics;
            _loc_9.clear();
            _loc_9.beginFill(0, 1);
            _loc_9.drawRect(0, 0, _loc_6 + 2, _loc_5 + 2);
            _loc_9.endFill();
            this.m_UIRendererImpl.move(_loc_7, _loc_8);
            this.m_UIRendererImpl.setActualSize(_loc_6, _loc_5);
            if (this.m_Options != null && this.m_Options.rendererShowFrameRate)
            {
                _loc_6 = this.m_UIInfoLatency.getExplicitOrMeasuredWidth();
                _loc_5 = this.m_UIInfoLatency.getExplicitOrMeasuredHeight();
                _loc_11 = Math.max(_loc_5, this.m_UIInfoFramerate.getExplicitOrMeasuredHeight());
                _loc_7 = 5;
                _loc_8 = param2 - _loc_11 - 5;
                this.m_UIInfoLatency.visible = true;
                this.m_UIInfoLatency.move(_loc_7, _loc_8 + (_loc_11 - _loc_5) / 2);
                this.m_UIInfoLatency.setActualSize(_loc_6, _loc_5);
                _loc_7 = _loc_7 + _loc_6;
                _loc_6 = this.m_UIInfoFramerate.getExplicitOrMeasuredWidth();
                _loc_5 = this.m_UIInfoFramerate.getExplicitOrMeasuredHeight();
                this.m_UIInfoFramerate.visible = true;
                this.m_UIInfoFramerate.move(_loc_7, _loc_8 + (_loc_11 - _loc_5) / 2);
                this.m_UIInfoFramerate.setActualSize(_loc_6, _loc_5);
            }
            else
            {
                this.m_UIInfoLatency.visible = false;
                this.m_UIInfoFramerate.visible = false;
            }
            return;
        }// end function

        public function set creatureStorage(param1:CreatureStorage) : void
        {
            if (this.m_CreatureStorage != param1)
            {
                this.m_CreatureStorage = param1;
                this.m_UncommittedCreatureStorage = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function onResize(event:ResizeEvent) : void
        {
            if (this.m_WorldMapStorage != null)
            {
                this.m_WorldMapStorage.invalidateOnscreenMessages();
            }
            return;
        }// end function

    }
}

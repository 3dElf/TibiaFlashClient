package tibia.help
{
    import flash.geom.*;
    import mx.core.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.chat.chatWidgetClasses.*;
    import tibia.container.*;
    import tibia.container.bodyContainerViewWigdetClasses.*;
    import tibia.container.containerViewWidgetClasses.*;
    import tibia.worldmap.*;
    import tibia.worldmap.widgetClasses.*;

    public class GUIRectangle extends Object
    {
        private var m_Info:GUIRectangleInfo = null;
        private var m_RefreshRectangle:Boolean = true;
        private var m_CachedRectangle:Rectangle = null;

        public function GUIRectangle()
        {
            return;
        }// end function

        public function refresh() : void
        {
            this.m_RefreshRectangle = true;
            return;
        }// end function

        private function getMapRect(param1:Vector3D) : Rectangle
        {
            var _loc_4:* = null;
            var _loc_2:* = Tibia.s_GetUIEffectsManager().findUIElementByIdentifier(WorldMapWidget, RendererImpl) as RendererImpl;
            var _loc_3:* = null;
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.absoluteToRect(param1);
                _loc_4 = new Point(_loc_3.x, _loc_3.y);
                _loc_4 = _loc_2.localToGlobal(_loc_4);
                _loc_3.setTo(_loc_4.x, _loc_4.y, _loc_3.width, _loc_3.height);
            }
            return _loc_3;
        }// end function

        public function get rectangle() : Rectangle
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_RefreshRectangle)
            {
                this.m_RefreshRectangle = false;
                if (this.m_Info is CoordinateInfo)
                {
                    _loc_1 = this.m_Info as CoordinateInfo;
                    _loc_2 = s_GetCoordinateInfo(_loc_1.m_Coordinate);
                    if ("coordinate" in _loc_2)
                    {
                        this.m_CachedRectangle = this.getMapRect(_loc_2["coordinate"] as Vector3D);
                    }
                    else if ("identifier" in _loc_2)
                    {
                        this.m_CachedRectangle = this.getUIComponentRect(_loc_2["identifier"] as Class, _loc_2["subIdentifier"]);
                    }
                }
                else if (this.m_Info is UIComponentInfo)
                {
                    _loc_3 = this.m_Info as UIComponentInfo;
                    this.m_CachedRectangle = this.getUIComponentRect(_loc_3.m_Identifier, _loc_3.m_SubIdentifier);
                }
                else if (this.m_Info is KeywordInfo)
                {
                    _loc_4 = this.m_Info as KeywordInfo;
                    this.m_CachedRectangle = this.getKeywordRect(_loc_4.m_KeywordString);
                }
            }
            return this.m_CachedRectangle;
        }// end function

        private function getUIComponentRect(param1:Class, param2) : Rectangle
        {
            var _loc_5:* = null;
            var _loc_3:* = null;
            var _loc_4:* = Tibia.s_GetUIEffectsManager().findUIElementByIdentifier(param1, param2);
            if (Tibia.s_GetUIEffectsManager().findUIElementByIdentifier(param1, param2) != null)
            {
                _loc_5 = new Point(0, 0);
                _loc_5 = _loc_4.localToGlobal(_loc_5);
                _loc_3 = new Rectangle(_loc_5.x, _loc_5.y, _loc_4.width, _loc_4.height);
            }
            return _loc_3;
        }// end function

        public function get centerPoint() : Point
        {
            var _loc_1:* = null;
            if (this.rectangle != null)
            {
                _loc_1 = this.rectangle.topLeft.clone();
                _loc_1.x = _loc_1.x + this.rectangle.width / 2;
                _loc_1.y = _loc_1.y + this.rectangle.height / 2;
                return _loc_1;
            }
            return null;
        }// end function

        private function getKeywordRect(param1:String) : Rectangle
        {
            var _loc_4:* = null;
            var _loc_2:* = null;
            var _loc_3:* = Tibia.s_GetUIEffectsManager().findUIElementByIdentifier(ChannelMessageRenderer, param1) as ChannelMessageRenderer;
            if (_loc_3 != null)
            {
                for each (_loc_4 in _loc_3.hyperlinkInfos)
                {
                    
                    if (_loc_4.hyperlinkText == param1)
                    {
                        if (_loc_4.globalRectangles.length > 0)
                        {
                            _loc_2 = _loc_4.globalRectangles[0];
                        }
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function s_IsMapCoordinate(param1:Vector3D) : Boolean
        {
            return param1 != null && param1.x < 65535;
        }// end function

        public static function s_FromKeyword(param1:String) : GUIRectangle
        {
            var _loc_2:* = new GUIRectangle;
            var _loc_3:* = new KeywordInfo();
            _loc_3.m_KeywordString = param1;
            _loc_2.m_Info = _loc_3;
            return _loc_2;
        }// end function

        public static function s_FromUIComponent(param1:Class, param2) : GUIRectangle
        {
            var _loc_3:* = new GUIRectangle;
            var _loc_4:* = new UIComponentInfo();
            _loc_4.m_Identifier = param1;
            _loc_4.m_SubIdentifier = param2;
            _loc_3.m_Info = _loc_4;
            return _loc_3;
        }// end function

        public static function s_FromCoordinate(param1:Vector3D) : GUIRectangle
        {
            var _loc_2:* = new GUIRectangle;
            var _loc_3:* = new CoordinateInfo();
            _loc_3.m_Coordinate = param1;
            _loc_2.m_Info = _loc_3;
            return _loc_2;
        }// end function

        public static function s_GetCoordinateInfo(param1:Vector3D) : Object
        {
            var _loc_2:* = new Object();
            if (param1 == null)
            {
                return _loc_2;
            }
            if (param1.x == 65535 && param1.y == 0)
            {
                _loc_2["identifier"] = BodyContainerView;
                _loc_2["subIdentifier"] = null;
            }
            else
            {
                switch(param1.y)
                {
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                    case 7:
                    {
                        break;
                    }
                    case 8:
                    {
                        break;
                    }
                    case 9:
                    {
                        break;
                    }
                    case 10:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (param1.x == 65535 && param1.y == 254)
                {
                }
                else if (param1.x == 65535 && param1.y >= 64)
                {
                }
                else if (s_IsMapCoordinate(param1))
                {
                }
            }
            return _loc_2;
        }// end function

    }
}

import flash.geom.*;

import mx.core.*;

import shared.controls.*;

import shared.utility.*;

import tibia.chat.chatWidgetClasses.*;

import tibia.container.*;

import tibia.container.bodyContainerViewWigdetClasses.*;

import tibia.container.containerViewWidgetClasses.*;

import tibia.worldmap.*;

import tibia.worldmap.widgetClasses.*;

class KeywordInfo extends GUIRectangleInfo
{
    public var m_KeywordString:String = null;

    function KeywordInfo()
    {
        return;
    }// end function

}


import flash.geom.*;

import mx.core.*;

import shared.controls.*;

import shared.utility.*;

import tibia.chat.chatWidgetClasses.*;

import tibia.container.*;

import tibia.container.bodyContainerViewWigdetClasses.*;

import tibia.container.containerViewWidgetClasses.*;

import tibia.worldmap.*;

import tibia.worldmap.widgetClasses.*;

class UIComponentInfo extends GUIRectangleInfo
{
    public var m_Identifier:Class = null;
    public var m_SubIdentifier:Object = null;

    function UIComponentInfo()
    {
        return;
    }// end function

}


import flash.geom.*;

import mx.core.*;

import shared.controls.*;

import shared.utility.*;

import tibia.chat.chatWidgetClasses.*;

import tibia.container.*;

import tibia.container.bodyContainerViewWigdetClasses.*;

import tibia.container.containerViewWidgetClasses.*;

import tibia.worldmap.*;

import tibia.worldmap.widgetClasses.*;

class CoordinateInfo extends GUIRectangleInfo
{
    public var m_Coordinate:Vector3D = null;

    function CoordinateInfo()
    {
        return;
    }// end function

}


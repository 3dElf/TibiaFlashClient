package shared.controls
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;

    public class UIHyperlinksTextField extends UITextField
    {
        private var m_UncommitedRectangles:Boolean = true;
        private var m_HyperlinkInfos:Vector.<UIHyperlinksTextFieldHyperlinkInfo> = null;
        private var m_OldPosition:Point;
        private static var s_ZeroPoint:Point = new Point(0, 0);

        public function UIHyperlinksTextField()
        {
            this.m_OldPosition = new Point();
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function onUpdateHyperlinkInfos(event:Event) : void
        {
            this.m_UncommitedRectangles = true;
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            addEventListener(Event.SCROLL, this.onUpdateHyperlinkInfos);
            return;
        }// end function

        override public function invalidateDisplayList() : void
        {
            this.m_UncommitedRectangles = true;
            super.invalidateDisplayList();
            return;
        }// end function

        public function get containsHyperlink() : Boolean
        {
            return this.hyperlinkInfos.length > 0;
        }// end function

        override public function set htmlText(param1:String) : void
        {
            super.htmlText = param1;
            this.m_UncommitedRectangles = true;
            return;
        }// end function

        private function addRectangle(param1:Rectangle, param2:UIHyperlinksTextFieldHyperlinkInfo) : void
        {
            param2.rectangles.push(param1.clone());
            var _loc_3:* = localToGlobal(param1.topLeft);
            param2.globalRectangles.push(new Rectangle(_loc_3.x, _loc_3.y, param1.width, param1.height));
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            removeEventListener(Event.SCROLL, this.onUpdateHyperlinkInfos);
            removeEventListener(Event.RESIZE, this.onUpdateHyperlinkInfos);
            return;
        }// end function

        public function findHyperlinkInfo(param1:String) : UIHyperlinksTextFieldHyperlinkInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = this.hyperlinkInfos;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.hyperlinkText == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private function calculateHyperlinkInfos() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this.m_HyperlinkInfos = new Vector.<UIHyperlinksTextFieldHyperlinkInfo>;
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = this.text;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = getTextFormat(_loc_4);
                if (_loc_5.url != null && _loc_5.url.length != 0)
                {
                    _loc_6 = _loc_5.url.substr(6);
                    if (_loc_1 == null || _loc_1.hyperlinkText != _loc_6)
                    {
                        _loc_1 = new UIHyperlinksTextFieldHyperlinkInfo(_loc_6);
                        this.m_HyperlinkInfos.push(_loc_1);
                    }
                    _loc_7 = getCharBoundaries(_loc_4);
                    if (_loc_2 == null)
                    {
                        _loc_2 = _loc_7;
                    }
                    else if (_loc_2.x + _loc_2.width == _loc_7.x)
                    {
                        _loc_2.width = _loc_2.width + _loc_7.width;
                        _loc_2.height = Math.max(_loc_2.height, _loc_7.height);
                    }
                    else
                    {
                        this.addRectangle(_loc_2, _loc_1);
                        _loc_2 = _loc_7;
                    }
                }
                else
                {
                    if (_loc_2 != null && _loc_1 != null)
                    {
                        this.addRectangle(_loc_2, _loc_1);
                        _loc_2 = null;
                    }
                    _loc_2 = null;
                    _loc_1 = null;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function get hyperlinkInfos() : Vector.<UIHyperlinksTextFieldHyperlinkInfo>
        {
            var _loc_1:* = localToGlobal(s_ZeroPoint);
            if (this.m_UncommitedRectangles || _loc_1.equals(this.m_OldPosition) == false)
            {
                this.m_OldPosition = _loc_1;
                this.calculateHyperlinkInfos();
                this.m_UncommitedRectangles = false;
            }
            return this.m_HyperlinkInfos;
        }// end function

    }
}

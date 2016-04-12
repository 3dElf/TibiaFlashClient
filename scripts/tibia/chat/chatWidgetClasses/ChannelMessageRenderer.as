package tibia.chat.chatWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import shared.controls.*;
    import tibia.chat.*;
    import tibia.chat.chatWidgetClasses.*;
    import tibia.help.*;

    public class ChannelMessageRenderer extends UIComponent implements ISelectionProxy, IDataRenderer, IListItemRenderer
    {
        protected var m_Label:UIHyperlinksTextField = null;
        protected var m_Data:ChannelMessage = null;
        private var m_UncommittedData:Boolean = false;
        private var m_HasUIEffectsCommandEventListener:Boolean = false;
        private static const TEXT_STYLESHEET:StyleSheet = new StyleSheet();
        private static const TEXT_GUTTER:int = 2;
        public static const HEIGHT_HINT:int = 14;

        public function ChannelMessageRenderer()
        {
            return;
        }// end function

        public function selectAll() : void
        {
            this.m_Label.setSelection(0, this.m_Label.length);
            return;
        }// end function

        public function clearSelection() : void
        {
            this.m_Label.setSelection(-1, -1);
            return;
        }// end function

        public function get containsHyperlink() : Boolean
        {
            return this.m_Label.containsHyperlink;
        }// end function

        protected function onLabelScroll(event:Event) : void
        {
            if (this.m_Label.scrollV > 1)
            {
                this.m_Label.scrollV = 1;
            }
            return;
        }// end function

        public function getLabel() : String
        {
            if (this.m_Data is ChannelMessage)
            {
                return ChannelMessage(this.m_Data).plainText;
            }
            return "";
        }// end function

        public function get hyperlinkInfos() : Vector.<UIHyperlinksTextFieldHyperlinkInfo>
        {
            var _loc_1:* = this.m_Label.hyperlinkInfos;
            if (_loc_1 == null || _loc_1.length == 0)
            {
                Tibia.s_GetUIEffectsManager().removeEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
                this.m_HasUIEffectsCommandEventListener = false;
            }
            return this.m_Label.hyperlinkInfos;
        }// end function

        public function setSelection(param1:int, param2:int) : void
        {
            this.m_Label.setSelection(param1, param2);
            return;
        }// end function

        private function onUIEffectsCommandEvent(event:UIEffectsRetrieveComponentCommandEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.type == UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT && event.identifier == ChannelMessageRenderer)
            {
                _loc_2 = event.subIdentifier as String;
                if (_loc_2 != null)
                {
                    _loc_3 = this.m_Label.findHyperlinkInfo(_loc_2);
                    if (_loc_3 != null)
                    {
                        event.resultUIComponent = this;
                    }
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedData)
            {
                if (this.m_Data != null)
                {
                    if (!this.m_HasUIEffectsCommandEventListener)
                    {
                        Tibia.s_GetUIEffectsManager().addEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
                        this.m_HasUIEffectsCommandEventListener = true;
                    }
                    this.m_Label.htmlText = this.m_Data.htmlText;
                }
                else
                {
                    if (this.m_HasUIEffectsCommandEventListener)
                    {
                        Tibia.s_GetUIEffectsManager().removeEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
                        this.m_HasUIEffectsCommandEventListener = false;
                    }
                    this.m_Label.htmlText = "";
                }
                this.m_Label.setSelection(-1, -1);
                invalidateDisplayList();
                this.m_UncommittedData = false;
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this.m_Data = param1 as ChannelMessage;
            this.m_UncommittedData = true;
            invalidateProperties();
            return;
        }// end function

        public function getCharIndexAtPoint(param1:Number, param2:Number) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_3:* = this.m_Label.getCharIndexAtPoint(param1, param2);
            if (_loc_3 < 0 && this.m_Label.length > 0)
            {
                _loc_4 = this.m_Label.getCharBoundaries((this.m_Label.length - 1));
                if (_loc_4 == null || param2 >= _loc_4.bottom)
                {
                    return this.m_Label.length;
                }
                _loc_4 = this.m_Label.getCharBoundaries(0);
                if (_loc_4 == null || param2 <= _loc_4.y)
                {
                    return -1;
                }
                _loc_5 = this.m_Label.getLineIndexAtPoint(_loc_4.left, param2);
                _loc_6 = this.m_Label.getLineOffset(_loc_5);
                _loc_7 = this.m_Label.getLineLength(_loc_5);
                _loc_4 = this.m_Label.getCharBoundaries(_loc_6 + _loc_7 - 1);
                if (_loc_4 == null || param1 >= _loc_4.right)
                {
                    return _loc_6 + _loc_7;
                }
                return _loc_6;
            }
            return _loc_3;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = NaN;
            super.measure();
            if (!isNaN(explicitWidth))
            {
                this.m_Label.explicitWidth = explicitWidth;
                _loc_1 = this.m_Label.getExplicitOrMeasuredHeight() - 2 * TEXT_GUTTER;
                measuredWidth = explicitWidth;
                measuredHeight = _loc_1;
            }
            else
            {
                measuredWidth = this.m_Label.getExplicitOrMeasuredHeight() - 2 * TEXT_GUTTER;
                measuredHeight = this.m_Label.getExplicitOrMeasuredHeight() - 2 * TEXT_GUTTER;
            }
            return;
        }// end function

        public function get data() : Object
        {
            return this.m_Data;
        }// end function

        public function getCharCount() : int
        {
            if (this.m_Data is ChannelMessage)
            {
                return ChannelMessage(this.m_Data).plainText.length;
            }
            return 0;
        }// end function

        protected function onLabelClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = new Point(event.localX, event.localY);
                _loc_2 = this.transformTextFieldCoordinates(_loc_2);
                for each (_loc_3 in this.m_Label.hyperlinkInfos)
                {
                    
                    if (_loc_3.contains(_loc_2.x, _loc_2.y))
                    {
                        Tibia.s_GameActionFactory.createTalkAction(_loc_3.hyperlinkText, true).perform();
                        break;
                    }
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (this.m_Label != null)
            {
                this.m_Label.move(-TEXT_GUTTER, -TEXT_GUTTER);
                this.m_Label.setActualSize(param1 + 2 * TEXT_GUTTER, param2 + 2 * TEXT_GUTTER);
            }
            return;
        }// end function

        public function transformTextFieldCoordinates(param1:Point) : Point
        {
            var _loc_2:* = this.m_Label.transform.matrix;
            return _loc_2.transformPoint(param1);
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            if (this.m_Label == null)
            {
                this.m_Label = createInFontContext(UIHyperlinksTextField) as UIHyperlinksTextField;
                this.m_Label.alwaysShowSelection = true;
                this.m_Label.selectable = true;
                this.m_Label.styleSheet = TEXT_STYLESHEET;
                this.m_Label.wordWrap = true;
                addChild(this.m_Label);
                this.m_Label.addEventListener(Event.SCROLL, this.onLabelScroll);
                this.m_Label.addEventListener(MouseEvent.CLICK, this.onLabelClick);
            }
            return;
        }// end function

        private static function s_InitialiseStyleSheet() : void
        {
            TEXT_STYLESHEET.parseCSS("p {" + "font-family: Verdana;" + "font-size: 10;" + "margin-left: 15;" + "text-indent: -15;" + "}" + "a {" + "color:#36b0d9;" + "font-weight:bold;" + "}" + "a:hover {" + "text-decoration:underline;" + "}");
            return;
        }// end function

        s_InitialiseStyleSheet();
    }
}

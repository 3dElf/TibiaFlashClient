package tibia.actionbar.widgetClasses
{
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import shared.utility.*;

    public class TalkActionIconCache extends TextFieldCache
    {
        static var s_Matrix:Matrix = new Matrix(1, 0, 0, 1, 0, 0);

        public function TalkActionIconCache(param1:Number, param2:Number, param3:uint, param4:Boolean)
        {
            super(param1, param2, param3, param4);
            m_TextField = new TextField();
            m_TextField.width = param1 + 4;
            m_TextField.height = param2 + 4;
            m_TextField.wordWrap = true;
            m_TextField.multiline = true;
            m_TextField.defaultTextFormat = new TextFormat("Verdana", 11, 0, true);
            m_TextField.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
            return;
        }// end function

        override protected function addItem(param1:Rectangle, param2:Array) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (param2 == null || param2.length < 1)
            {
                return;
            }
            if (param2.length > 1)
            {
                m_TextField.textColor = uint(param2[1]);
            }
            else
            {
                m_TextField.textColor = uint(m_TextField.defaultTextFormat.color);
            }
            var _loc_3:* = String(param2[0]);
            m_TextField.text = _loc_3;
            if (m_TextField.textWidth > slotWidth || m_TextField.textHeight > slotHeight)
            {
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_6 = Number(m_TextField.defaultTextFormat.leading);
                _loc_7 = slotHeight + _loc_6;
                while (_loc_5 < m_TextField.numLines)
                {
                    
                    _loc_7 = _loc_7 - (m_TextField.getLineMetrics(_loc_5).height + _loc_6);
                    if (_loc_7 < 0)
                    {
                        break;
                    }
                    _loc_4 = _loc_4 + m_TextField.getLineLength(_loc_5);
                    _loc_5++;
                }
                if (m_AddEllipsis)
                {
                    m_TextField.text = _loc_3.substr(0, _loc_4 - 3) + "...";
                }
                else
                {
                    m_TextField.text = _loc_3.substr(0, _loc_4);
                }
            }
            s_Matrix.tx = param1.x - 2;
            s_Matrix.ty = param1.y - 2;
            draw(m_TextField, s_Matrix, null, null, null, false);
            return;
        }// end function

    }
}

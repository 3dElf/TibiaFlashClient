package shared.controls
{
    import __AS3__.vec.*;
    import flash.geom.*;

    public class UIHyperlinksTextFieldHyperlinkInfo extends Object
    {
        private var m_HyperlinkText:String = null;
        private var m_Rectangles:Vector.<Rectangle>;
        private var m_GlobalRectangles:Vector.<Rectangle>;

        public function UIHyperlinksTextFieldHyperlinkInfo(param1:String)
        {
            this.m_Rectangles = new Vector.<Rectangle>;
            this.m_GlobalRectangles = new Vector.<Rectangle>;
            this.m_HyperlinkText = param1;
            return;
        }// end function

        public function get rectangles() : Vector.<Rectangle>
        {
            return this.m_Rectangles;
        }// end function

        public function get globalRectangles() : Vector.<Rectangle>
        {
            return this.m_GlobalRectangles;
        }// end function

        public function get hyperlinkText() : String
        {
            return this.m_HyperlinkText;
        }// end function

        public function contains(param1:uint, param2:uint) : Boolean
        {
            var _loc_3:* = null;
            for each (_loc_3 in this.m_Rectangles)
            {
                
                if (_loc_3.contains(param1, param2))
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}

package tibia.appearances
{
    import flash.display.*;
    import flash.geom.*;
    import tibia.appearances.widgetClasses.*;

    public class ObjectInstance extends AppearanceInstance
    {
        protected var m_Hang:int = 0;
        protected var m_SpecialPatternY:int = 0;
        protected var m_Marks:Marks = null;
        protected var m_SpecialPatternX:int = 0;
        protected var m_Data:int = 0;
        protected var m_HasSpecialPattern:Boolean = false;
        private static var s_ObjectMarksView:MarksView = null;
        private static var s_HelperRect:Rectangle = new Rectangle();

        public function ObjectInstance(param1:int, param2:AppearanceType, param3:int)
        {
            super(param1, param2);
            this.m_Data = param3;
            this.m_Marks = new Marks();
            this.updateSpecialPattern();
            return;
        }// end function

        public function get marks() : Marks
        {
            return this.m_Marks;
        }// end function

        protected function updateSpecialPattern() : void
        {
            var _loc_1:* = 0;
            this.m_HasSpecialPattern = false;
            if (m_Type == null || m_ID == AppearanceInstance.CREATURE)
            {
                return;
            }
            if (m_Type.isCumulative)
            {
                this.m_HasSpecialPattern = true;
                if (this.m_Data < 2)
                {
                    this.m_SpecialPatternX = 0;
                    this.m_SpecialPatternY = 0;
                }
                else if (this.m_Data == 2)
                {
                    this.m_SpecialPatternX = 1;
                    this.m_SpecialPatternY = 0;
                }
                else if (this.m_Data == 3)
                {
                    this.m_SpecialPatternX = 2;
                    this.m_SpecialPatternY = 0;
                }
                else if (this.m_Data == 4)
                {
                    this.m_SpecialPatternX = 3;
                    this.m_SpecialPatternY = 0;
                }
                else if (this.m_Data < 10)
                {
                    this.m_SpecialPatternX = 0;
                    this.m_SpecialPatternY = 1;
                }
                else if (this.m_Data < 25)
                {
                    this.m_SpecialPatternX = 1;
                    this.m_SpecialPatternY = 1;
                }
                else if (this.m_Data < 50)
                {
                    this.m_SpecialPatternX = 2;
                    this.m_SpecialPatternY = 1;
                }
                else
                {
                    this.m_SpecialPatternX = 3;
                    this.m_SpecialPatternY = 1;
                }
                this.m_SpecialPatternX = this.m_SpecialPatternX % m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternWidth;
                this.m_SpecialPatternY = this.m_SpecialPatternY % m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternHeight;
            }
            else
            {
                switch(this.m_Data)
                {
                    case 0:
                    {
                        break;
                    }
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
                    case 11:
                    {
                        break;
                    }
                    case 12:
                    {
                        break;
                    }
                    case 13:
                    {
                        break;
                    }
                    case 14:
                    {
                        break;
                    }
                    case 15:
                    {
                        break;
                    }
                    case 16:
                    {
                        break;
                    }
                    case 17:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                if (m_Type.isHangable)
                {
                    if (this.m_Hang == AppearanceStorage.FLAG_HOOKSOUTH)
                    {
                    }
                    else if (this.m_Hang == AppearanceStorage.FLAG_HOOKEAST)
                    {
                    }
                    else
                    {
                    }
                }
            }
            return;
        }// end function

        public function get isCreature() : Boolean
        {
            return m_Type.isCreature;
        }// end function

        public function get data() : int
        {
            return this.m_Data;
        }// end function

        public function set hang(param1:int) : void
        {
            if (this.m_Hang != param1)
            {
                this.m_Hang = param1;
                this.updateSpecialPattern();
            }
            return;
        }// end function

        public function get hasMark() : Boolean
        {
            return this.marks.isMarkSet(Marks.MARK_TYPE_PERMANENT);
        }// end function

        override public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_7:* = param4;
            var _loc_8:* = param5;
            if (this.m_HasSpecialPattern)
            {
                _loc_7 = -1;
                _loc_8 = -1;
            }
            _loc_9 = getSprite(-1, _loc_7, _loc_8, param6, m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].isAnimation);
            m_CacheDirty = _loc_9.cacheMiss;
            var _loc_10:* = _loc_9.rectangle;
            s_TempPoint.setTo(param2 - _loc_10.width - m_Type.displacementX, param3 - _loc_10.height - m_Type.displacementY);
            param1.copyPixels(_loc_9.bitmapData, _loc_10, s_TempPoint, null, null, true);
            if (this.hasMark)
            {
                _loc_11 = s_ObjectMarksView.getMarksBitmap(this.marks, s_HelperRect);
                s_TempPoint.setTo(param2 - s_HelperRect.width - m_Type.displacementX, param3 - s_HelperRect.height - m_Type.displacementY);
                param1.copyPixels(_loc_11, s_HelperRect, s_TempPoint, null, null, true);
            }
            return;
        }// end function

        public function get hang() : int
        {
            return this.m_Hang;
        }// end function

        override public function getSpriteIndex(param1:int, param2:int, param3:int, param4:int) : uint
        {
            var _loc_5:* = param2 >= 0 ? (param2) : (this.m_SpecialPatternX);
            var _loc_6:* = param3 >= 0 ? (param3) : (this.m_SpecialPatternY);
            return super.getSpriteIndex(param1, _loc_5, _loc_6, param4);
        }// end function

        public function set data(param1:int) : void
        {
            if (this.m_Data != param1)
            {
                this.m_Data = param1;
                this.updateSpecialPattern();
            }
            return;
        }// end function

        private static function s_InitialiseMarksViews() : void
        {
            s_ObjectMarksView = new MarksView(0);
            s_ObjectMarksView.addMarkToView(Marks.MARK_TYPE_PERMANENT, MarksView.MARK_THICKNESS_THIN);
            return;
        }// end function

        s_InitialiseMarksViews();
    }
}

package tibia.imbuing
{
    import __AS3__.vec.*;
    import flash.events.*;

    public class ImbuingManager extends EventDispatcher
    {
        private var m_ExistingImbuements:Vector.<ExistingImbuement>;
        private var m_AvailableAstralSources:Vector.<AstralSource>;
        private var m_AppearanceTypeID:uint = 0;
        private var m_AvailableImbuements:Vector.<ImbuementData>;
        private static var s_Instance:ImbuingManager = null;

        public function ImbuingManager()
        {
            return;
        }// end function

        public function getAvailableImbuementWithID(param1:uint) : ImbuementData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.m_AvailableImbuements)
            {
                
                if (_loc_2.imbuementID == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function closeImbuingWindow() : void
        {
            if (ImbuingWidget.s_GetCurrentInstance() != null)
            {
                ImbuingWidget.s_GetCurrentInstance().hide();
            }
            return;
        }// end function

        public function getAvailableAstralSource(param1:uint) : AstralSource
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.m_AvailableAstralSources)
            {
                
                if (_loc_2.apperanceTypeID == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getImbuementsForCategory(param1:String) : Vector.<ImbuementData>
        {
            var _loc_3:* = null;
            var _loc_2:* = new Vector.<ImbuementData>;
            for each (_loc_3 in this.m_AvailableImbuements)
            {
                
                if (_loc_3.category == param1)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function get imbuementCategories() : Vector.<String>
        {
            var _loc_2:* = null;
            var _loc_1:* = new Vector.<String>;
            for each (_loc_2 in this.m_AvailableImbuements)
            {
                
                if (_loc_1.indexOf(_loc_2.category) == -1)
                {
                    _loc_1.push(_loc_2.category);
                }
            }
            return _loc_1;
        }// end function

        public function get availableImbuements() : Vector.<ImbuementData>
        {
            return this.m_AvailableImbuements;
        }// end function

        public function openImbuingWindow() : void
        {
            if (ImbuingWidget.s_GetCurrentInstance() == null)
            {
                new ImbuingWidget().show();
            }
            return;
        }// end function

        public function get apperanceTypeID() : uint
        {
            return this.m_AppearanceTypeID;
        }// end function

        public function showImbuingResultDialog(param1:String) : void
        {
            if (ImbuingWidget.s_GetCurrentInstance() != null)
            {
                ImbuingWidget.s_GetCurrentInstance().showImbuingResultDialog(param1);
            }
            return;
        }// end function

        public function get availableAstralSources() : Vector.<AstralSource>
        {
            return this.m_AvailableAstralSources;
        }// end function

        public function get existingImbuements() : Vector.<ExistingImbuement>
        {
            return this.m_ExistingImbuements;
        }// end function

        public function refreshImbuingData(param1:uint, param2:Vector.<ExistingImbuement>, param3:Vector.<ImbuementData>, param4:Vector.<AstralSource>) : void
        {
            this.m_AppearanceTypeID = param1;
            this.m_ExistingImbuements = param2;
            this.m_AvailableImbuements = param3;
            this.m_AvailableAstralSources = param4;
            var _loc_5:* = new ImbuingEvent(ImbuingEvent.IMBUEMENT_DATA_CHANGED);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public static function getInstance() : ImbuingManager
        {
            if (s_Instance == null)
            {
                s_Instance = new ImbuingManager;
            }
            return s_Instance;
        }// end function

    }
}

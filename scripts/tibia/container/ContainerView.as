package tibia.container
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import tibia.appearances.*;

    public class ContainerView extends EventDispatcher
    {
        private var m_NumberOfTotalObjects:int = 0;
        private var m_IsDragAndDropEnabled:Boolean = false;
        private var m_IsPaginationEnabled:Boolean = false;
        private var m_IsSubContainer:Boolean = false;
        private var m_Objects:Vector.<ObjectInstance> = null;
        private var m_NumberOfSlotsPerPage:int = 0;
        private var m_Icon:ObjectInstance = null;
        private var m_ID:int = 0;
        private var m_IndexOfFirstObject:int = 0;
        private var m_Name:String = null;

        public function ContainerView(param1:int, param2:ObjectInstance, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:int, param8:int, param9:int)
        {
            if (param1 < 0 || param1 >= ContainerStorage.MAX_CONTAINER_VIEWS)
            {
                throw new ArgumentError("ContainerView.ContainerView: Invalid ID: " + param1);
            }
            if (param2 == null)
            {
                throw new ArgumentError("ContainerView.ContainerView: Invalid icon: " + param2);
            }
            if (param3 == null || param3.length == 0 || param3.length >= ContainerStorage.MAX_NAME_LENGTH)
            {
                throw new ArgumentError("ContainerView.ContainerView: Invalid name: " + param3);
            }
            if (param7 <= 0)
            {
                throw new ArgumentError("ContainerView.ContainerView: Invalid number of slots per page: " + param7);
            }
            if (param9 < 0)
            {
                throw new ArgumentError("ContainerView.ContainerView: Invalid index of first object(1): " + param9);
            }
            if (param6 && param9 % param7 != 0)
            {
                throw new ArgumentError("ContainerView.ContainerView: Invalid index of first object(2): " + param9);
            }
            this.m_ID = param1;
            this.m_Icon = param2;
            this.m_Name = param3;
            this.m_IsSubContainer = param4;
            this.m_IsDragAndDropEnabled = param5;
            this.m_IsPaginationEnabled = param6;
            this.m_NumberOfSlotsPerPage = param7;
            this.m_NumberOfTotalObjects = param8;
            this.m_IndexOfFirstObject = param9;
            this.m_Objects = new Vector.<ObjectInstance>;
            return;
        }// end function

        public function addObject(param1:int, param2:ObjectInstance) : void
        {
            if (param2 != null)
            {
                if (param1 < this.m_IndexOfFirstObject || param1 > this.m_IndexOfFirstObject + this.m_Objects.length)
                {
                    throw new RangeError("ContainerView.addObject: Index out of range: " + param1);
                }
                if (this.m_NumberOfSlotsPerPage <= this.m_Objects.length)
                {
                    this.m_Objects.pop();
                }
                this.m_Objects.splice(param1 - this.m_IndexOfFirstObject, 0, param2);
            }
            var _loc_4:* = this;
            var _loc_5:* = this.m_NumberOfTotalObjects + 1;
            _loc_4.m_NumberOfTotalObjects = _loc_5;
            var _loc_3:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_3.property = "objects";
            _loc_3.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function get indexOfFirstObject() : int
        {
            return this.m_IndexOfFirstObject;
        }// end function

        public function get isPaginationEnabled() : Boolean
        {
            return this.m_IsPaginationEnabled;
        }// end function

        public function changeObject(param1:int, param2:ObjectInstance) : void
        {
            if (param1 < this.m_IndexOfFirstObject || param1 >= this.m_IndexOfFirstObject + this.m_Objects.length)
            {
                throw new RangeError("ContainerView.changeObject: Index out of range: " + param1);
            }
            if (param2 == null)
            {
                throw new ArgumentError("ContainerView.changeObject: Invalid object: " + param2);
            }
            this.m_Objects[param1 - this.m_IndexOfFirstObject] = param2;
            var _loc_3:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_3.property = "objects";
            _loc_3.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function get numberOfTotalObjects() : int
        {
            return this.m_NumberOfTotalObjects;
        }// end function

        public function removeAll() : void
        {
            var _loc_1:* = this.m_Objects.length;
            this.m_Objects.length = 0;
            this.m_NumberOfTotalObjects = this.m_NumberOfTotalObjects - _loc_1;
            var _loc_2:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_2.property = "objects";
            _loc_2.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function get isDragAndDropEnabled() : Boolean
        {
            return this.m_IsDragAndDropEnabled;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function removeObject(param1:int, param2:ObjectInstance) : void
        {
            if (param1 < 0 || param1 >= this.m_NumberOfTotalObjects)
            {
                throw new RangeError("ContainerView.removeObject: Index out of range: " + param1);
            }
            if (param1 >= this.m_IndexOfFirstObject && param1 < this.m_IndexOfFirstObject + this.m_Objects.length)
            {
                this.m_Objects.splice(param1 - this.m_IndexOfFirstObject, 1);
            }
            if (param2 != null)
            {
                this.m_Objects.push(param2);
            }
            var _loc_4:* = this;
            var _loc_5:* = this.m_NumberOfTotalObjects - 1;
            _loc_4.m_NumberOfTotalObjects = _loc_5;
            var _loc_3:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_3.property = "objects";
            _loc_3.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function get isSubContainer() : Boolean
        {
            return this.m_IsSubContainer;
        }// end function

        public function get numberOfObjects() : int
        {
            return this.m_Objects.length;
        }// end function

        public function getObject(param1:int) : ObjectInstance
        {
            if (param1 < this.m_IndexOfFirstObject || param1 >= this.m_IndexOfFirstObject + this.m_Objects.length)
            {
                throw new RangeError("ContainerView.getObject: Index out of range: " + param1);
            }
            return this.m_Objects[param1 - this.m_IndexOfFirstObject];
        }// end function

        public function get numberOfSlotsPerPage() : int
        {
            return this.m_NumberOfSlotsPerPage;
        }// end function

        public function get icon() : ObjectInstance
        {
            return this.m_Icon;
        }// end function

    }
}

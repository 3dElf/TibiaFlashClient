package mx.collections
{
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.collections.errors.*;
    import mx.events.*;
    import mx.resources.*;
    import mx.utils.*;

    public class ListCollectionView extends Proxy implements ICollectionView, IList, IMXMLObject
    {
        private var autoUpdateCounter:int;
        private var _list:IList;
        private var _filterFunction:Function;
        protected var localIndex:Array;
        var dispatchResetEvent:Boolean = true;
        private var pendingUpdates:Array;
        private var resourceManager:IResourceManager;
        private var eventDispatcher:EventDispatcher;
        private var revision:int;
        private var _sort:Sort;
        static const VERSION:String = "3.6.0.21751";

        public function ListCollectionView(param1:IList = null)
        {
            resourceManager = ResourceManager.getInstance();
            eventDispatcher = new EventDispatcher(this);
            this.list = param1;
            return;
        }// end function

        private function handlePendingUpdates() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (pendingUpdates)
            {
                _loc_1 = pendingUpdates;
                pendingUpdates = null;
                _loc_3 = 0;
                while (_loc_3 < _loc_1.length)
                {
                    
                    _loc_4 = _loc_1[_loc_3];
                    if (_loc_4.kind == CollectionEventKind.UPDATE)
                    {
                        if (!_loc_2)
                        {
                            _loc_2 = _loc_4;
                        }
                        else
                        {
                            _loc_5 = 0;
                            while (_loc_5 < _loc_4.items.length)
                            {
                                
                                _loc_2.items.push(_loc_4.items[_loc_5]);
                                _loc_5++;
                            }
                        }
                    }
                    else
                    {
                        listChangeHandler(_loc_4);
                    }
                    _loc_3++;
                }
                if (_loc_2)
                {
                    listChangeHandler(_loc_2);
                }
            }
            return;
        }// end function

        private function replaceItemsInView(param1:Array, param2:int, param3:Boolean = true) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (localIndex)
            {
                _loc_4 = param1.length;
                _loc_5 = [];
                _loc_6 = [];
                _loc_7 = 0;
                while (_loc_7 < _loc_4)
                {
                    
                    _loc_8 = param1[_loc_7];
                    _loc_5.push(_loc_8.oldValue);
                    _loc_6.push(_loc_8.newValue);
                    _loc_7++;
                }
                removeItemsFromView(_loc_5, param2, param3);
                addItemsToView(_loc_6, param2, param3);
            }
            else
            {
                _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_9.kind = CollectionEventKind.REPLACE;
                _loc_9.location = param2;
                _loc_9.items = param1;
                dispatchEvent(_loc_9);
            }
            return;
        }// end function

        private function getFilteredItemIndex(param1:Object) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = list.getItemIndex(param1);
            if (_loc_2 == 0)
            {
                return 0;
            }
            var _loc_3:* = _loc_2 - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = list.getItemAt(_loc_3);
                if (filterFunction(_loc_4))
                {
                    _loc_5 = localIndex.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5)
                    {
                        
                        if (localIndex[_loc_6] == _loc_4)
                        {
                            return (_loc_6 + 1);
                        }
                        _loc_6++;
                    }
                }
                _loc_3 = _loc_3 - 1;
            }
            return 0;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return eventDispatcher.willTrigger(param1);
        }// end function

        function findItem(param1:Object, param2:String, param3:Boolean = false) : int
        {
            var _loc_4:* = null;
            if (!sort)
            {
                _loc_4 = resourceManager.getString("collections", "itemNotFound");
                throw new CollectionViewError(_loc_4);
            }
            if (localIndex.length == 0)
            {
                return param3 ? (0) : (-1);
            }
            return sort.findItem(localIndex, param1, param2, param3);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            eventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function nextName(param1:int) : String
        {
            return ((param1 - 1)).toString();
        }// end function

        public function removeAll() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = length;
            if (_loc_1 > 0)
            {
                if (localIndex)
                {
                    _loc_2 = _loc_1 - 1;
                    while (_loc_2 >= 0)
                    {
                        
                        removeItemAt(_loc_2);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                else
                {
                    list.removeAll();
                }
            }
            return;
        }// end function

        public function hasProperty(param1) : Boolean
        {
            var n:Number;
            var name:* = param1;
            if (name is QName)
            {
                name = name.localName;
            }
            var index:int;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                }
            }
            catch (e:Error)
            {
            }
            if (index == -1)
            {
                return false;
            }
            return index >= 0 && index < length;
        }// end function

        public function addAllAt(param1:IList, param2:int) : void
        {
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this.addItemAt(param1.getItemAt(_loc_4), _loc_4 + param2);
                _loc_4++;
            }
            return;
        }// end function

        public function getItemAt(param1:int, param2:int = 0) : Object
        {
            var _loc_3:* = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            if (localIndex)
            {
                return localIndex[param1];
            }
            if (list)
            {
                return list.getItemAt(param1, param2);
            }
            return null;
        }// end function

        private function moveItemInView(param1:Object, param2:Boolean = true, param3:Array = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (localIndex)
            {
                _loc_4 = -1;
                _loc_5 = 0;
                while (_loc_5 < localIndex.length)
                {
                    
                    if (localIndex[_loc_5] == param1)
                    {
                        _loc_4 = _loc_5;
                        break;
                    }
                    _loc_5++;
                }
                if (_loc_4 > -1)
                {
                    localIndex.splice(_loc_4, 1);
                }
                _loc_6 = addItemsToView([param1], _loc_4, false);
                if (param2)
                {
                    _loc_7 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _loc_7.items.push(param1);
                    if (param3 && _loc_6 == _loc_4 && _loc_6 > -1)
                    {
                        param3.push(param1);
                        return;
                    }
                    if (_loc_6 > -1 && _loc_4 > -1)
                    {
                        _loc_7.kind = CollectionEventKind.MOVE;
                        _loc_7.location = _loc_6;
                        _loc_7.oldLocation = _loc_4;
                    }
                    else if (_loc_6 > -1)
                    {
                        _loc_7.kind = CollectionEventKind.ADD;
                        _loc_7.location = _loc_6;
                    }
                    else if (_loc_4 > -1)
                    {
                        _loc_7.kind = CollectionEventKind.REMOVE;
                        _loc_7.location = _loc_4;
                    }
                    else
                    {
                        param2 = false;
                    }
                    if (param2)
                    {
                        dispatchEvent(_loc_7);
                    }
                }
            }
            return;
        }// end function

        public function contains(param1:Object) : Boolean
        {
            return getItemIndex(param1) != -1;
        }// end function

        public function get sort() : Sort
        {
            return _sort;
        }// end function

        private function removeItemsFromView(param1:Array, param2:int, param3:Boolean = true) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_4:* = localIndex ? ([]) : (param1);
            var _loc_5:* = param2;
            if (localIndex)
            {
                _loc_6 = 0;
                while (_loc_6 < param1.length)
                {
                    
                    _loc_7 = param1[_loc_6];
                    _loc_8 = getItemIndex(_loc_7);
                    if (_loc_8 > -1)
                    {
                        localIndex.splice(_loc_8, 1);
                        _loc_4.push(_loc_7);
                        _loc_5 = _loc_8;
                    }
                    _loc_6++;
                }
            }
            if (param3 && _loc_4.length > 0)
            {
                _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_9.kind = CollectionEventKind.REMOVE;
                _loc_9.location = !localIndex || _loc_4.length == 1 ? (_loc_5) : (-1);
                _loc_9.items = _loc_4;
                dispatchEvent(_loc_9);
            }
            return;
        }// end function

        public function get list() : IList
        {
            return _list;
        }// end function

        public function addItemAt(param1:Object, param2:int) : void
        {
            var _loc_4:* = null;
            if (param2 < 0 || !list || param2 > length)
            {
                _loc_4 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_4);
            }
            var _loc_3:* = param2;
            if (localIndex && sort)
            {
                _loc_3 = list.length;
            }
            else if (localIndex && filterFunction != null)
            {
                if (_loc_3 == localIndex.length)
                {
                    _loc_3 = list.length;
                }
                else
                {
                    _loc_3 = list.getItemIndex(localIndex[param2]);
                }
            }
            list.addItemAt(param1, _loc_3);
            return;
        }// end function

        public function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void
        {
            list.itemUpdated(param1, param2, param3, param4);
            return;
        }// end function

        private function populateLocalIndex() : void
        {
            if (list)
            {
                localIndex = list.toArray();
            }
            else
            {
                localIndex = [];
            }
            return;
        }// end function

        private function handlePropertyChangeEvents(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_2:* = param1;
            if (sort || filterFunction != null)
            {
                _loc_3 = [];
                _loc_5 = 0;
                while (_loc_5 < _loc_2.length)
                {
                    
                    _loc_8 = _loc_2[_loc_5];
                    if (_loc_8.target)
                    {
                        _loc_9 = _loc_8.target;
                        _loc_10 = _loc_8.target != _loc_8.source;
                    }
                    else
                    {
                        _loc_9 = _loc_8.source;
                        _loc_10 = false;
                    }
                    _loc_11 = 0;
                    while (_loc_11 < _loc_3.length)
                    {
                        
                        if (_loc_3[_loc_11].item == _loc_9)
                        {
                            param1 = _loc_3[_loc_11].events;
                            _loc_12 = _loc_2.length;
                            _loc_13 = 0;
                            while (_loc_13 < _loc_12)
                            {
                                
                                if (_loc_2[_loc_13].property != _loc_8.property)
                                {
                                    _loc_2.push(_loc_8);
                                    break;
                                }
                                _loc_13++;
                            }
                            break;
                        }
                        _loc_11++;
                    }
                    if (_loc_11 < _loc_3.length)
                    {
                        _loc_4 = _loc_3[_loc_11];
                    }
                    else
                    {
                        _loc_4 = {item:_loc_9, move:_loc_10, events:[_loc_8]};
                        _loc_3.push(_loc_4);
                    }
                    _loc_4.move = _loc_4.move || filterFunction || !_loc_8.property || sort && sort.propertyAffectsSort(String(_loc_8.property));
                    _loc_5++;
                }
                _loc_2 = [];
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    _loc_4 = _loc_3[_loc_5];
                    if (_loc_4.move)
                    {
                        moveItemInView(_loc_4.item, _loc_4.item, _loc_2);
                    }
                    else
                    {
                        _loc_2.push(_loc_4.item);
                    }
                    _loc_5++;
                }
                _loc_6 = [];
                _loc_7 = 0;
                while (_loc_7 < _loc_2.length)
                {
                    
                    _loc_14 = 0;
                    while (_loc_14 < _loc_3.length)
                    {
                        
                        if (_loc_2[_loc_7] == _loc_3[_loc_14].item)
                        {
                            _loc_6 = _loc_6.concat(_loc_3[_loc_14].events);
                        }
                        _loc_14++;
                    }
                    _loc_7++;
                }
                _loc_2 = _loc_6;
            }
            if (_loc_2.length > 0)
            {
                _loc_15 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_15.kind = CollectionEventKind.UPDATE;
                _loc_15.items = _loc_2;
                dispatchEvent(_loc_15);
            }
            return;
        }// end function

        public function set sort(param1:Sort) : void
        {
            _sort = param1;
            dispatchEvent(new Event("sortChanged"));
            return;
        }// end function

        public function nextValue(param1:int)
        {
            return getItemAt((param1 - 1));
        }// end function

        public function setItemAt(param1:Object, param2:int) : Object
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param2 < 0 || !list || param2 >= length)
            {
                _loc_4 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_4);
            }
            var _loc_3:* = param2;
            if (localIndex)
            {
                if (param2 > localIndex.length)
                {
                    _loc_3 = list.length;
                }
                else
                {
                    _loc_5 = localIndex[param2];
                    _loc_3 = list.getItemIndex(_loc_5);
                }
            }
            return list.setItemAt(param1, _loc_3);
        }// end function

        function getBookmark(param1:int) : ListCollectionViewBookmark
        {
            var value:Object;
            var message:String;
            var index:* = param1;
            if (index < 0 || index > length)
            {
                message = resourceManager.getString("collections", "invalidIndex", [index]);
                throw new CollectionViewError(message);
            }
            try
            {
                value = getItemAt(index);
            }
            catch (e:Error)
            {
                value;
            }
            return new ListCollectionViewBookmark(value, this, revision, index);
        }// end function

        private function addItemsToView(param1:Array, param2:int, param3:Boolean = true) : int
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_4:* = localIndex ? ([]) : (param1);
            var _loc_5:* = param2;
            var _loc_6:* = true;
            if (localIndex)
            {
                _loc_7 = param2;
                _loc_8 = 0;
                while (_loc_8 < param1.length)
                {
                    
                    _loc_9 = param1[_loc_8];
                    if (filterFunction == null || filterFunction(_loc_9))
                    {
                        if (sort)
                        {
                            _loc_7 = findItem(_loc_9, Sort.ANY_INDEX_MODE, true);
                            if (_loc_6)
                            {
                                _loc_5 = _loc_7;
                                _loc_6 = false;
                            }
                        }
                        else
                        {
                            _loc_7 = getFilteredItemIndex(_loc_9);
                            if (_loc_6)
                            {
                                _loc_5 = _loc_7;
                                _loc_6 = false;
                            }
                        }
                        if (sort && sort.unique && sort.compareFunction(_loc_9, localIndex[_loc_7]) == 0)
                        {
                            _loc_10 = resourceManager.getString("collections", "incorrectAddition");
                            throw new CollectionViewError(_loc_10);
                        }
                        localIndex.splice(_loc_7++, 0, _loc_9);
                        _loc_4.push(_loc_9);
                    }
                    else
                    {
                        _loc_5 = -1;
                    }
                    _loc_8++;
                }
            }
            if (localIndex && _loc_4.length > 1)
            {
                _loc_5 = -1;
            }
            if (param3 && _loc_4.length > 0)
            {
                _loc_11 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_11.kind = CollectionEventKind.ADD;
                _loc_11.location = _loc_5;
                _loc_11.items = _loc_4;
                dispatchEvent(_loc_11);
            }
            return _loc_5;
        }// end function

        public function addAll(param1:IList) : void
        {
            addAllAt(param1, length);
            return;
        }// end function

        public function set list(param1:IList) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            if (_list != param1)
            {
                if (_list)
                {
                    _list.removeEventListener(CollectionEvent.COLLECTION_CHANGE, listChangeHandler);
                    _loc_2 = _list.length > 0;
                }
                _list = param1;
                if (_list)
                {
                    _list.addEventListener(CollectionEvent.COLLECTION_CHANGE, listChangeHandler, false, 0, true);
                    _loc_3 = _list.length > 0;
                }
                if (_loc_2 || _loc_3)
                {
                    reset();
                }
                dispatchEvent(new Event("listChanged"));
            }
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return eventDispatcher.dispatchEvent(event);
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (sort)
            {
                _loc_3 = sort.findItem(localIndex, param1, Sort.FIRST_INDEX_MODE);
                if (_loc_3 == -1)
                {
                    return -1;
                }
                _loc_4 = sort.findItem(localIndex, param1, Sort.LAST_INDEX_MODE);
                _loc_2 = _loc_3;
                while (_loc_2 <= _loc_4)
                {
                    
                    if (localIndex[_loc_2] == param1)
                    {
                        return _loc_2;
                    }
                    _loc_2++;
                }
                return -1;
            }
            else if (filterFunction != null)
            {
                _loc_5 = localIndex.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_5)
                {
                    
                    if (localIndex[_loc_2] == param1)
                    {
                        return _loc_2;
                    }
                    _loc_2++;
                }
                return -1;
            }
            return list.getItemIndex(param1);
        }// end function

        function getLocalItemIndex(param1:Object) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = localIndex.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                if (localIndex[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function getProperty(param1)
        {
            var n:Number;
            var message:String;
            var name:* = param1;
            if (name is QName)
            {
                name = name.localName;
            }
            var index:int;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                }
            }
            catch (e:Error)
            {
            }
            if (index == -1)
            {
                message = resourceManager.getString("collections", "unknownProperty", [name]);
                throw new Error(message);
            }
            return getItemAt(index);
        }// end function

        public function enableAutoUpdate() : void
        {
            if (autoUpdateCounter > 0)
            {
                var _loc_2:* = autoUpdateCounter - 1;
                autoUpdateCounter = _loc_2;
                if (autoUpdateCounter == 0)
                {
                    handlePendingUpdates();
                }
            }
            return;
        }// end function

        function reset() : void
        {
            var _loc_1:* = null;
            internalRefresh(false);
            if (dispatchResetEvent)
            {
                _loc_1 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_1.kind = CollectionEventKind.RESET;
                dispatchEvent(_loc_1);
            }
            return;
        }// end function

        public function toArray() : Array
        {
            var _loc_1:* = null;
            if (localIndex)
            {
                _loc_1 = localIndex.concat();
            }
            else
            {
                _loc_1 = list.toArray();
            }
            return _loc_1;
        }// end function

        public function removeItemAt(param1:int) : Object
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            var _loc_2:* = param1;
            if (localIndex)
            {
                _loc_4 = localIndex[param1];
                _loc_2 = list.getItemIndex(_loc_4);
            }
            return list.removeItemAt(_loc_2);
        }// end function

        public function callProperty(param1, ... args)
        {
            return null;
        }// end function

        public function initialized(param1:Object, param2:String) : void
        {
            refresh();
            return;
        }// end function

        public function setProperty(param1, param2) : void
        {
            var n:Number;
            var message:String;
            var name:* = param1;
            var value:* = param2;
            if (name is QName)
            {
                name = name.localName;
            }
            var index:int;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                }
            }
            catch (e:Error)
            {
            }
            if (index == -1)
            {
                message = resourceManager.getString("collections", "unknownProperty", [name]);
                throw new Error(message);
            }
            setItemAt(value, index);
            return;
        }// end function

        public function addItem(param1:Object) : void
        {
            addItemAt(param1, length);
            return;
        }// end function

        private function internalRefresh(param1:Boolean) : Boolean
        {
            var tmp:Array;
            var len:int;
            var i:int;
            var item:Object;
            var refreshEvent:CollectionEvent;
            var dispatch:* = param1;
            if (sort || filterFunction != null)
            {
                try
                {
                    populateLocalIndex();
                }
                catch (pending:ItemPendingError)
                {
                    pending.addResponder(new ItemResponder(function (param1:Object, param2:Object = null) : void
            {
                internalRefresh(dispatch);
                return;
            }// end function
            , function (param1:Object, param2:Object = null) : void
            {
                return;
            }// end function
            ));
                    return false;
                }
                if (filterFunction != null)
                {
                    tmp;
                    len = localIndex.length;
                    i;
                    while (i < len)
                    {
                        
                        item = localIndex[i];
                        if (filterFunction(item))
                        {
                            tmp.push(item);
                        }
                        i = (i + 1);
                    }
                    localIndex = tmp;
                }
                if (sort)
                {
                    sort.sort(localIndex);
                    dispatch;
                }
            }
            else if (localIndex)
            {
                localIndex = null;
            }
            var _loc_4:* = revision + 1;
            revision = _loc_4;
            pendingUpdates = null;
            if (dispatch)
            {
                refreshEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                refreshEvent.kind = CollectionEventKind.REFRESH;
                dispatchEvent(refreshEvent);
            }
            return true;
        }// end function

        public function set filterFunction(param1:Function) : void
        {
            _filterFunction = param1;
            dispatchEvent(new Event("filterFunctionChanged"));
            return;
        }// end function

        function getBookmarkIndex(param1:CursorBookmark) : int
        {
            var bm:ListCollectionViewBookmark;
            var message:String;
            var bookmark:* = param1;
            if (!(bookmark is ListCollectionViewBookmark) || ListCollectionViewBookmark(bookmark).view != this)
            {
                message = resourceManager.getString("collections", "bookmarkNotFound");
                throw new CollectionViewError(message);
            }
            bm = ListCollectionViewBookmark(bookmark);
            if (bm.viewRevision != revision)
            {
                if (bm.index < 0 || bm.index >= length || getItemAt(bm.index) != bm.value)
                {
                    try
                    {
                        bm.index = getItemIndex(bm.value);
                    }
                    catch (e:SortError)
                    {
                        bm.index = getLocalItemIndex(bm.value);
                    }
                }
                bm.viewRevision = revision;
            }
            return bm.index;
        }// end function

        public function refresh() : Boolean
        {
            return internalRefresh(true);
        }// end function

        public function get filterFunction() : Function
        {
            return _filterFunction;
        }// end function

        public function createCursor() : IViewCursor
        {
            return new ListCollectionViewCursor(this);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return eventDispatcher.hasEventListener(param1);
        }// end function

        public function get length() : int
        {
            if (localIndex)
            {
                return localIndex.length;
            }
            if (list)
            {
                return list.length;
            }
            return 0;
        }// end function

        public function nextNameIndex(param1:int) : int
        {
            return param1 < length ? ((param1 + 1)) : (0);
        }// end function

        public function disableAutoUpdate() : void
        {
            var _loc_2:* = autoUpdateCounter + 1;
            autoUpdateCounter = _loc_2;
            return;
        }// end function

        public function toString() : String
        {
            if (localIndex)
            {
                return ObjectUtil.toString(localIndex);
            }
            if (list && Object(list).toString)
            {
                return Object(list).toString();
            }
            return getQualifiedClassName(this);
        }// end function

        private function listChangeHandler(event:CollectionEvent) : void
        {
            if (autoUpdateCounter > 0)
            {
                if (!pendingUpdates)
                {
                    pendingUpdates = [];
                }
                pendingUpdates.push(event);
            }
            else
            {
                switch(event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        addItemsToView(event.items, event.location);
                        break;
                    }
                    case CollectionEventKind.RESET:
                    {
                        reset();
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        removeItemsFromView(event.items, event.location);
                        break;
                    }
                    case CollectionEventKind.REPLACE:
                    {
                        replaceItemsInView(event.items, event.location);
                        break;
                    }
                    case CollectionEventKind.UPDATE:
                    {
                        handlePropertyChangeEvents(event.items);
                        break;
                    }
                    default:
                    {
                        dispatchEvent(event);
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}

import flash.events.*;

import flash.utils.*;

import mx.collections.*;

import mx.collections.errors.*;

import mx.events.*;

import mx.resources.*;

import mx.utils.*;

class ListCollectionViewBookmark extends CursorBookmark
{
    var viewRevision:int;
    var index:int;
    var view:ListCollectionView;

    function ListCollectionViewBookmark(param1:Object, param2:ListCollectionView, param3:int, param4:int)
    {
        super(param1);
        this.view = param2;
        this.viewRevision = param3;
        this.index = param4;
        return;
    }// end function

    override public function getViewIndex() : int
    {
        return view.getBookmarkIndex(this);
    }// end function

}


import flash.events.*;

import flash.utils.*;

import mx.collections.*;

import mx.collections.errors.*;

import mx.events.*;

import mx.resources.*;

import mx.utils.*;

class ListCollectionViewCursor extends EventDispatcher implements IViewCursor
{
    private var _view:ListCollectionView;
    private var invalid:Boolean;
    private var resourceManager:IResourceManager;
    private var currentIndex:int;
    private var currentValue:Object;
    private static const BEFORE_FIRST_INDEX:int = -1;
    private static const AFTER_LAST_INDEX:int = -2;

    function ListCollectionViewCursor(param1:ListCollectionView)
    {
        var view:* = param1;
        resourceManager = ResourceManager.getInstance();
        _view = view;
        _view.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionEventHandler, false, 0, true);
        currentIndex = view.length > 0 ? (0) : (AFTER_LAST_INDEX);
        if (currentIndex == 0)
        {
            try
            {
                setCurrent(view.getItemAt(0), false);
            }
            catch (e:ItemPendingError)
            {
                currentIndex = BEFORE_FIRST_INDEX;
                setCurrent(null, false);
            }
        }
        return;
    }// end function

    public function findAny(param1:Object) : Boolean
    {
        var index:int;
        var values:* = param1;
        checkValid();
        var lcView:* = ListCollectionView(view);
        try
        {
            index = lcView.findItem(values, Sort.ANY_INDEX_MODE);
        }
        catch (e:SortError)
        {
            throw new CursorError(e.message);
        }
        if (index > -1)
        {
            currentIndex = index;
            setCurrent(lcView.getItemAt(currentIndex));
        }
        return index > -1;
    }// end function

    public function remove() : Object
    {
        var oldIndex:int;
        var message:String;
        if (beforeFirst || afterLast)
        {
            message = resourceManager.getString("collections", "invalidRemove");
            throw new CursorError(message);
        }
        oldIndex = currentIndex;
        var _loc_3:* = currentIndex + 1;
        currentIndex = _loc_3;
        if (currentIndex >= view.length)
        {
            currentIndex = AFTER_LAST_INDEX;
            setCurrent(null);
        }
        else
        {
            try
            {
                setCurrent(ListCollectionView(view).getItemAt(currentIndex));
            }
            catch (e:ItemPendingError)
            {
                setCurrent(null, false);
                ListCollectionView(view).removeItemAt(oldIndex);
                throw e;
            }
        }
        var removed:* = ListCollectionView(view).removeItemAt(oldIndex);
        return removed;
    }// end function

    private function setCurrent(param1:Object, param2:Boolean = true) : void
    {
        currentValue = param1;
        if (param2)
        {
            dispatchEvent(new FlexEvent(FlexEvent.CURSOR_UPDATE));
        }
        return;
    }// end function

    public function seek(param1:CursorBookmark, param2:int = 0, param3:int = 0) : void
    {
        var message:String;
        var bookmark:* = param1;
        var offset:* = param2;
        var prefetch:* = param3;
        checkValid();
        if (view.length == 0)
        {
            currentIndex = AFTER_LAST_INDEX;
            setCurrent(null, false);
            return;
        }
        var newIndex:* = currentIndex;
        if (bookmark == CursorBookmark.FIRST)
        {
            newIndex;
        }
        else if (bookmark == CursorBookmark.LAST)
        {
            newIndex = (view.length - 1);
        }
        else if (bookmark != CursorBookmark.CURRENT)
        {
            try
            {
                newIndex = ListCollectionView(view).getBookmarkIndex(bookmark);
                if (newIndex < 0)
                {
                    setCurrent(null);
                    message = resourceManager.getString("collections", "bookmarkInvalid");
                    throw new CursorError(message);
                }
            }
            catch (bmError:CollectionViewError)
            {
                message = resourceManager.getString("collections", "bookmarkInvalid");
                throw new CursorError(message);
            }
        }
        newIndex = newIndex + offset;
        var newCurrent:Object;
        if (newIndex >= view.length)
        {
            currentIndex = AFTER_LAST_INDEX;
        }
        else if (newIndex < 0)
        {
            currentIndex = BEFORE_FIRST_INDEX;
        }
        else
        {
            newCurrent = ListCollectionView(view).getItemAt(newIndex, prefetch);
            currentIndex = newIndex;
        }
        setCurrent(newCurrent);
        return;
    }// end function

    public function insert(param1:Object) : void
    {
        var _loc_2:* = 0;
        var _loc_3:* = null;
        if (afterLast)
        {
            _loc_2 = view.length;
        }
        else if (beforeFirst)
        {
            if (view.length > 0)
            {
                _loc_3 = resourceManager.getString("collections", "invalidInsert");
                throw new CursorError(_loc_3);
            }
            _loc_2 = 0;
        }
        else
        {
            _loc_2 = currentIndex;
        }
        ListCollectionView(view).addItemAt(param1, _loc_2);
        return;
    }// end function

    public function get afterLast() : Boolean
    {
        checkValid();
        return currentIndex == AFTER_LAST_INDEX || view.length == 0;
    }// end function

    private function checkValid() : void
    {
        var _loc_1:* = null;
        if (invalid)
        {
            _loc_1 = resourceManager.getString("collections", "invalidCursor");
            throw new CursorError(_loc_1);
        }
        return;
    }// end function

    private function collectionEventHandler(event:CollectionEvent) : void
    {
        var event:* = event;
        switch(event.kind)
        {
            case CollectionEventKind.ADD:
            {
                if (event.location <= currentIndex)
                {
                    currentIndex = currentIndex + event.items.length;
                }
                break;
            }
            case CollectionEventKind.REMOVE:
            {
                if (event.location < currentIndex)
                {
                    currentIndex = currentIndex - event.items.length;
                }
                else if (event.location == currentIndex)
                {
                    if (currentIndex < view.length)
                    {
                        try
                        {
                            setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                        }
                        catch (error:ItemPendingError)
                        {
                            setCurrent(null, false);
                        }
                    }
                    else
                    {
                        currentIndex = AFTER_LAST_INDEX;
                        setCurrent(null);
                    }
                }
                break;
            }
            case CollectionEventKind.MOVE:
            {
                if (event.oldLocation == currentIndex)
                {
                    currentIndex = event.location;
                }
                else
                {
                    if (event.oldLocation < currentIndex)
                    {
                        currentIndex = currentIndex - event.items.length;
                    }
                    if (event.location <= currentIndex)
                    {
                        currentIndex = currentIndex + event.items.length;
                    }
                }
                break;
            }
            case CollectionEventKind.REFRESH:
            {
                if (!(beforeFirst || afterLast))
                {
                    try
                    {
                        currentIndex = ListCollectionView(view).getItemIndex(currentValue);
                    }
                    catch (e:SortError)
                    {
                        if (ListCollectionView(view).sort)
                        {
                            currentIndex = ListCollectionView(view).getLocalItemIndex(currentValue);
                        }
                    }
                    if (currentIndex == -1)
                    {
                        setCurrent(null);
                    }
                }
                break;
            }
            case CollectionEventKind.REPLACE:
            {
                if (event.location == currentIndex)
                {
                    try
                    {
                        setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                    }
                    catch (error:ItemPendingError)
                    {
                        setCurrent(null, false);
                    }
                }
                break;
            }
            case CollectionEventKind.RESET:
            {
                currentIndex = BEFORE_FIRST_INDEX;
                setCurrent(null);
                break;
            }
            default:
            {
                break;
            }
        }
        return;
    }// end function

    public function moveNext() : Boolean
    {
        if (afterLast)
        {
            return false;
        }
        var _loc_1:* = beforeFirst ? (0) : ((currentIndex + 1));
        if (_loc_1 >= view.length)
        {
            _loc_1 = AFTER_LAST_INDEX;
            setCurrent(null);
        }
        else
        {
            setCurrent(ListCollectionView(view).getItemAt(_loc_1));
        }
        currentIndex = _loc_1;
        return !afterLast;
    }// end function

    public function get view() : ICollectionView
    {
        checkValid();
        return _view;
    }// end function

    public function movePrevious() : Boolean
    {
        if (beforeFirst)
        {
            return false;
        }
        var _loc_1:* = afterLast ? ((view.length - 1)) : ((currentIndex - 1));
        if (_loc_1 == -1)
        {
            _loc_1 = BEFORE_FIRST_INDEX;
            setCurrent(null);
        }
        else
        {
            setCurrent(ListCollectionView(view).getItemAt(_loc_1));
        }
        currentIndex = _loc_1;
        return !beforeFirst;
    }// end function

    public function findLast(param1:Object) : Boolean
    {
        var index:int;
        var values:* = param1;
        checkValid();
        var lcView:* = ListCollectionView(view);
        try
        {
            index = lcView.findItem(values, Sort.LAST_INDEX_MODE);
        }
        catch (sortError:SortError)
        {
            throw new CursorError(sortError.message);
        }
        if (index > -1)
        {
            currentIndex = index;
            setCurrent(lcView.getItemAt(currentIndex));
        }
        return index > -1;
    }// end function

    public function get beforeFirst() : Boolean
    {
        checkValid();
        return currentIndex == BEFORE_FIRST_INDEX || view.length == 0;
    }// end function

    public function get bookmark() : CursorBookmark
    {
        checkValid();
        if (view.length == 0 || beforeFirst)
        {
            return CursorBookmark.FIRST;
        }
        if (afterLast)
        {
            return CursorBookmark.LAST;
        }
        return ListCollectionView(view).getBookmark(currentIndex);
    }// end function

    public function findFirst(param1:Object) : Boolean
    {
        var index:int;
        var values:* = param1;
        checkValid();
        var lcView:* = ListCollectionView(view);
        try
        {
            index = lcView.findItem(values, Sort.FIRST_INDEX_MODE);
        }
        catch (sortError:SortError)
        {
            throw new CursorError(sortError.message);
        }
        if (index > -1)
        {
            currentIndex = index;
            setCurrent(lcView.getItemAt(currentIndex));
        }
        return index > -1;
    }// end function

    public function get current() : Object
    {
        checkValid();
        return currentValue;
    }// end function

}


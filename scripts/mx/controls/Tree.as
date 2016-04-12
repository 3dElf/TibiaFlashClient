package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.xml.*;
    import mx.collections.*;
    import mx.collections.errors.*;
    import mx.controls.listClasses.*;
    import mx.controls.treeClasses.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class Tree extends List implements IIMESupport
    {
        var wrappedCollection:ICollectionView;
        private var lastTreeSeekPending:TreeSeekPending;
        private var _openItems:Object;
        private var rowIndex:int;
        private var _dragMoveEnabled:Boolean = true;
        var collectionLength:int;
        private var eventAfterTween:Object;
        private var rowsTweened:int;
        var showRootChanged:Boolean = false;
        private var dontEdit:Boolean = false;
        private var openItemsChanged:Boolean = false;
        private var opening:Boolean;
        var _hasRoot:Boolean = false;
        private var rowNameID:Number = 0;
        private var tween:Object;
        private var expandedItem:Object;
        private var bSelectedItemRemoved:Boolean = false;
        private var IS_NEW_ROW_STYLE:Object;
        private var dataProviderChanged:Boolean = false;
        private var bFinishArrowKeySelection:Boolean = false;
        private var haveItemIndices:Boolean;
        var collectionThrowsIPE:Boolean;
        var _dropData:Object;
        private var eventPending:Object;
        private var rowList:Array;
        private var minScrollInterval:Number = 50;
        private var maskList:Array;
        public var itemIcons:Object;
        var isOpening:Boolean = false;
        private var _editable:Boolean = false;
        private var _userMaxHorizontalScrollPosition:Number = 0;
        private var lastUserInteraction:Event;
        private var proposedSelectedItem:Object;
        var _showRoot:Boolean = true;
        var _dataDescriptor:ITreeDataDescriptor;
        var _rootModel:ICollectionView;
        private var oldLength:int = -1;
        private var _itemEditor:IFactory;
        static const VERSION:String = "3.6.0.21751";
        static var createAccessibilityImplementation:Function;

        public function Tree()
        {
            IS_NEW_ROW_STYLE = {depthColors:true, indentation:true, disclosureOpenIcon:true, disclosureClosedIcon:true, folderOpenIcon:true, folderClosedIcon:true, defaultLeafIcon:true};
            _itemEditor = new ClassFactory(TextInput);
            _dataDescriptor = new DefaultDataDescriptor();
            _openItems = {};
            itemRenderer = new ClassFactory(TreeItemRenderer);
            editorXOffset = 12;
            editorWidthOffset = -12;
            addEventListener(TreeEvent.ITEM_OPENING, expandItemHandler, false, EventPriority.DEFAULT_HANDLER);
            return;
        }// end function

        public function removeClipMask() : void
        {
            return;
        }// end function

        override protected function dragOverHandler(event:DragEvent) : void
        {
            var event:* = event;
            if (event.isDefaultPrevented())
            {
                return;
            }
            lastDragEvent = event;
            try
            {
                if (iteratorValid && event.dragSource.hasFormat("treeItems"))
                {
                    if (collectionThrowsIPE)
                    {
                        checkItemIndices(event);
                    }
                    DragManager.showFeedback(event.ctrlKey ? (DragManager.COPY) : (DragManager.MOVE));
                    showDropFeedback(event);
                    return;
                }
            }
            catch (e:ItemPendingError)
            {
                if (!lastTreeSeekPending)
                {
                    lastTreeSeekPending = new TreeSeekPending(event, dragOverHandler);
                    e.addResponder(new ItemResponder(seekPendingDuringDragResultHandler, seekPendingDuringDragFailureHandler, lastTreeSeekPending));
                }
                ;
            }
            catch (e1:Error)
            {
            }
            hideDropFeedback(event);
            DragManager.showFeedback(DragManager.NONE);
            return;
        }// end function

        override protected function mouseUpHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseUpHandler(event);
            }
            return;
        }// end function

        private function buildUpCollectionEvents(param1:Boolean) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = false;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_6:* = [];
            var _loc_7:* = [];
            var _loc_8:* = [];
            var _loc_9:* = getItemIndex(expandedItem);
            if (param1)
            {
                _loc_10 = getChildren(expandedItem, iterator.view);
                if (!_loc_10)
                {
                    return [];
                }
                _loc_11 = _loc_10.createCursor();
                _loc_12 = true;
                while (!_loc_11.afterLast)
                {
                    
                    _loc_6.push(_loc_11.current);
                    _loc_11.moveNext();
                }
            }
            else
            {
                _loc_13 = [];
                _loc_14 = 0;
                _loc_13 = getOpenChildrenStack(expandedItem, _loc_13);
                while (_loc_14 < _loc_13.length)
                {
                    
                    _loc_3 = 0;
                    while (_loc_3 < selectedItems.length)
                    {
                        
                        if (selectedItems[_loc_3] == _loc_13[_loc_14])
                        {
                            bSelectedItemRemoved = true;
                        }
                        _loc_3++;
                    }
                    _loc_7.push(_loc_13[_loc_14]);
                    _loc_14++;
                }
            }
            if (_loc_6.length > 0)
            {
                _loc_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_2.kind = CollectionEventKind.ADD;
                _loc_2.location = _loc_9 + 1;
                _loc_2.items = _loc_6;
                _loc_8.push(_loc_2);
            }
            if (_loc_7.length > 0)
            {
                _loc_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_2.kind = CollectionEventKind.REMOVE;
                _loc_2.location = _loc_9 + 1;
                _loc_2.items = _loc_7;
                _loc_8.push(_loc_2);
            }
            return _loc_8;
        }// end function

        private function updateDropData(event:DragEvent) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_2:* = rowInfo.length;
            var _loc_3:* = 0;
            var _loc_4:* = rowInfo[_loc_3].height;
            var _loc_5:* = globalToLocal(new Point(event.stageX, event.stageY));
            while (rowInfo[_loc_3] && _loc_5.y >= _loc_4)
            {
                
                if (_loc_3 != (rowInfo.length - 1))
                {
                    _loc_3++;
                    _loc_4 = _loc_4 + rowInfo[_loc_3].height;
                    continue;
                }
                _loc_4 = _loc_4 + rowInfo[_loc_3].height;
                _loc_3++;
            }
            var _loc_6:* = _loc_3 < rowInfo.length ? (rowInfo[_loc_3].y) : (rowInfo[(_loc_3 - 1)].y + rowInfo[(_loc_3 - 1)].height);
            var _loc_7:* = _loc_5.y - _loc_6;
            var _loc_8:* = _loc_3 < rowInfo.length ? (rowInfo[_loc_3].height) : (rowInfo[(_loc_3 - 1)].height);
            _loc_3 = _loc_3 + verticalScrollPosition;
            var _loc_11:* = false;
            var _loc_12:* = collection ? (collection.length) : (0);
            var _loc_13:* = _loc_3 > _verticalScrollPosition && _loc_3 <= _loc_12 ? (listItems[_loc_3 - _verticalScrollPosition - 1][0].data) : (null);
            var _loc_14:* = _loc_3 - verticalScrollPosition < rowInfo.length && _loc_3 < _loc_12 ? (listItems[_loc_3 - _verticalScrollPosition][0].data) : (null);
            var _loc_15:* = collection ? (getParentItem(_loc_13)) : (null);
            var _loc_16:* = collection ? (getParentItem(_loc_14)) : (null);
            if (_loc_7 > _loc_8 * 0.5 && isItemOpen(_loc_14) && _dataDescriptor.isBranch(_loc_14, iterator.view) && (!_dataDescriptor.hasChildren(_loc_14, iterator.view) || _dataDescriptor.getChildren(_loc_14, iterator.view).length == 0))
            {
                _loc_9 = _loc_14;
                _loc_10 = 0;
                _loc_11 = true;
            }
            else if (!_loc_13 && !_loc_3 == _loc_2)
            {
                _loc_9 = collection ? (getParentItem(_loc_14)) : (null);
                _loc_10 = _loc_14 ? (getChildIndexInParent(_loc_9, _loc_14)) : (0);
                _loc_3 = 0;
            }
            else if (_loc_14 && _loc_16 == _loc_13)
            {
                _loc_9 = _loc_13;
                _loc_10 = 0;
            }
            else if (_loc_13 && _loc_14 && _loc_15 == _loc_16)
            {
                _loc_9 = collection ? (getParentItem(_loc_13)) : (null);
                _loc_10 = iterator ? (getChildIndexInParent(_loc_9, _loc_14)) : (0);
            }
            else if (_loc_13 && _loc_7 < _loc_8 * 0.5)
            {
                _loc_9 = _loc_15;
                _loc_10 = getChildIndexInParent(_loc_9, _loc_13) + 1;
            }
            else if (!_loc_14)
            {
                _loc_9 = null;
                if (_loc_3 - verticalScrollPosition == 0)
                {
                    _loc_10 = 0;
                }
                else if (collection)
                {
                    _loc_10 = collection.length;
                }
                else
                {
                    _loc_10 = 0;
                }
            }
            else
            {
                _loc_9 = _loc_16;
                _loc_10 = getChildIndexInParent(_loc_9, _loc_14);
            }
            _dropData = {parent:_loc_9, index:_loc_10, localX:event.localX, localY:event.localY, emptyFolder:_loc_11, rowHeight:_loc_8, rowIndex:_loc_3};
            return;
        }// end function

        function removeChildItem(param1:Object, param2:Object, param3:Number) : Boolean
        {
            return _dataDescriptor.removeChildAt(param1, param2, param3, iterator.view);
        }// end function

        public function set openItems(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            if (param1 != null)
            {
                for (_loc_2 in _openItems)
                {
                    
                    delete _loc_5[_loc_2];
                }
                for each (_loc_3 in param1)
                {
                    
                    _openItems[itemToUID(_loc_3)] = _loc_3;
                }
                openItemsChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function drawRowBackgrounds() : void
        {
            var color:Object;
            var colors:Array;
            var n:int;
            var d:int;
            var rowColor:uint;
            var rowBGs:* = Sprite(listContent.getChildByName("rowBGs"));
            if (!rowBGs)
            {
                rowBGs = new FlexSprite();
                rowBGs.name = "rowBGs";
                rowBGs.mouseEnabled = false;
                listContent.addChildAt(rowBGs, 0);
            }
            var depthColors:Boolean;
            colors = getStyle("depthColors");
            if (colors)
            {
                depthColors;
            }
            else
            {
                colors = getStyle("alternatingItemColors");
            }
            color = getStyle("backgroundColor");
            if (!colors || colors.length == 0)
            {
                while (rowBGs.numChildren > n)
                {
                    
                    rowBGs.removeChildAt((rowBGs.numChildren - 1));
                }
                return;
            }
            StyleManager.getColorNames(colors);
            var curRow:int;
            var actualRow:* = verticalScrollPosition;
            var i:int;
            n = listItems.length;
            while (curRow < n)
            {
                
                if (depthColors)
                {
                    try
                    {
                        if (listItems[curRow][0])
                        {
                            d = getItemDepth(listItems[curRow][0].data, curRow);
                            rowColor = colors[(d - 1)] ? (colors[(d - 1)]) : (uint(color));
                            i = (i + 1);
                            drawRowBackground(rowBGs, i, rowInfo[curRow].y, rowInfo[curRow].height, rowColor, curRow);
                        }
                        else
                        {
                            i = (i + 1);
                            drawRowBackground(rowBGs, i, rowInfo[curRow].y, rowInfo[curRow].height, uint(color), curRow);
                        }
                    }
                    catch (e:Error)
                    {
                    }
                }
                else
                {
                    i = (i + 1);
                    drawRowBackground(rowBGs, i, rowInfo[curRow].y, rowInfo[curRow].height, colors[actualRow % colors.length], actualRow);
                }
                curRow = (curRow + 1);
                actualRow = (actualRow + 1);
            }
            while (rowBGs.numChildren > n)
            {
                
                rowBGs.removeChildAt((rowBGs.numChildren - 1));
            }
            return;
        }// end function

        override public function showDropFeedback(event:DragEvent) : void
        {
            var _loc_5:* = 0;
            super.showDropFeedback(event);
            var _loc_2:* = viewMetrics;
            var _loc_3:* = 0;
            updateDropData(event);
            var _loc_4:* = 0;
            if (_dropData.parent)
            {
                _loc_3 = getItemIndex(iterator.current);
                _loc_5 = getItemDepth(_dropData.parent, Math.abs(_loc_3 - getItemIndex(_dropData.parent)));
                _loc_4 = (_loc_5 + 1) * getStyle("indentation");
            }
            else
            {
                _loc_4 = getStyle("indentation");
            }
            if (_loc_4 < 0)
            {
                _loc_4 = 0;
            }
            dropIndicator.width = listContent.width - _loc_4;
            dropIndicator.x = _loc_4 + _loc_2.left + 2;
            if (_dropData.emptyFolder)
            {
                dropIndicator.y = dropIndicator.y + _dropData.rowHeight / 2;
            }
            return;
        }// end function

        function dispatchTreeEvent(param1:String, param2:Object, param3:IListItemRenderer, param4:Event = null, param5:Boolean = true, param6:Boolean = true, param7:Boolean = true) : void
        {
            var _loc_8:* = null;
            if (param1 == TreeEvent.ITEM_OPENING)
            {
                _loc_8 = new TreeEvent(TreeEvent.ITEM_OPENING, false, true);
                _loc_8.opening = param5;
                _loc_8.animate = param6;
                _loc_8.dispatchEvent = param7;
            }
            if (!_loc_8)
            {
                _loc_8 = new TreeEvent(param1);
            }
            _loc_8.item = param2;
            _loc_8.itemRenderer = param3;
            _loc_8.triggerEvent = param4;
            dispatchEvent(_loc_8);
            return;
        }// end function

        private function finishArrowKeySelection() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            bFinishArrowKeySelection = false;
            if (proposedSelectedItem)
            {
                selectedItem = proposedSelectedItem;
            }
            if (selectedItem === proposedSelectedItem || !proposedSelectedItem)
            {
                _loc_1 = new ListEvent(ListEvent.CHANGE);
                _loc_1.itemRenderer = indexToItemRenderer(selectedIndex);
                _loc_2 = itemRendererToIndices(_loc_1.itemRenderer);
                if (_loc_2)
                {
                    _loc_1.rowIndex = _loc_2.y;
                    _loc_1.columnIndex = _loc_2.x;
                }
                dispatchEvent(_loc_1);
                _loc_3 = getItemIndex(selectedItem);
                if (_loc_3 != caretIndex)
                {
                    caretIndex = selectedIndex;
                }
                if (_loc_3 < _verticalScrollPosition)
                {
                    verticalScrollPosition = _loc_3;
                }
            }
            else
            {
                bFinishArrowKeySelection = true;
            }
            return;
        }// end function

        override protected function layoutEditor(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = rowMap[editedItemRenderer.name].indent;
            itemEditorInstance.move(param1 + _loc_5, param2);
            itemEditorInstance.setActualSize(param3 - _loc_5, param4);
            return;
        }// end function

        public function isItemOpen(param1:Object) : Boolean
        {
            var _loc_2:* = itemToUID(param1);
            return _openItems[_loc_2] != null;
        }// end function

        public function addClipMask(param1:Boolean) : void
        {
            var _loc_2:* = viewMetrics;
            if (horizontalScrollBar && horizontalScrollBar.visible)
            {
                _loc_2.bottom = _loc_2.bottom - horizontalScrollBar.minHeight;
            }
            if (verticalScrollBar && verticalScrollBar.visible)
            {
                _loc_2.right = _loc_2.right - verticalScrollBar.minWidth;
            }
            listContent.scrollRect = new Rectangle(0, 0, unscaledWidth - _loc_2.left - _loc_2.right, listContent.heightExcludingOffsets);
            return;
        }// end function

        private function collapseSelectedItems() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_1:* = new ArrayCollection(selectedItems);
            var _loc_2:* = 0;
            while (_loc_2 < selectedItems.length)
            {
                
                _loc_3 = selectedItems[_loc_2];
                _loc_4 = getParentStack(_loc_3);
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    if (_loc_1.contains(_loc_4[_loc_5]))
                    {
                        _loc_6 = _loc_1.getItemIndex(_loc_3);
                        _loc_7 = _loc_1.removeItemAt(_loc_6);
                        break;
                    }
                    _loc_5++;
                }
                _loc_2++;
            }
            return _loc_1.source;
        }// end function

        override public function isItemVisible(param1:Object) : Boolean
        {
            var _loc_3:* = null;
            if (visibleData[itemToUID(param1)])
            {
                return true;
            }
            var _loc_2:* = getParentItem(param1);
            if (_loc_2)
            {
                _loc_3 = itemToUID(_loc_2);
                if (visibleData[_loc_3] && _openItems[_loc_3])
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function getIndexItem(param1:int) : Object
        {
            var _loc_2:* = collection.createCursor();
            var _loc_3:* = param1;
            while (_loc_2.moveNext())
            {
                
                if (_loc_3 == 0)
                {
                    return _loc_2.current;
                }
                _loc_3 = _loc_3 - 1;
            }
            return null;
        }// end function

        private function seekPendingDuringDragResultHandler(param1:Object, param2:TreeSeekPending) : void
        {
            lastTreeSeekPending = null;
            if (lastDragEvent)
            {
                param2.retryFunction(param2.event);
            }
            return;
        }// end function

        private function getChildIndexInParent(param1:Object, param2:Object) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            if (!param1)
            {
                _loc_4 = ICollectionView(iterator.view).createCursor();
                while (!_loc_4.afterLast)
                {
                    
                    if (param2 === _loc_4.current)
                    {
                        break;
                    }
                    _loc_3++;
                    _loc_4.moveNext();
                }
            }
            else if (param1 != null && _dataDescriptor.isBranch(param1, iterator.view) && _dataDescriptor.hasChildren(param1, iterator.view))
            {
                _loc_5 = getChildren(param1, iterator.view);
                if (_loc_5.contains(param2))
                {
                    _loc_4 = _loc_5.createCursor();
                    while (!_loc_4.afterLast)
                    {
                        
                        if (param2 === _loc_4.current)
                        {
                            break;
                        }
                        _loc_4.moveNext();
                        _loc_3++;
                    }
                }
            }
            return _loc_3;
        }// end function

        override public function get dragMoveEnabled() : Boolean
        {
            return _dragMoveEnabled;
        }// end function

        override protected function mouseDownHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseDownHandler(event);
            }
            return;
        }// end function

        override public function calculateDropIndex(event:DragEvent = null) : int
        {
            if (event)
            {
                updateDropData(event);
            }
            return _dropData.rowIndex;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (isOpening)
            {
                event.stopImmediatePropagation();
                return;
            }
            if (itemEditorInstance)
            {
                return;
            }
            var _loc_4:* = selectedItem;
            if (event.ctrlKey)
            {
                super.keyDownHandler(event);
            }
            else if (event.keyCode == Keyboard.SPACE)
            {
                if (caretIndex != selectedIndex)
                {
                    _loc_5 = indexToItemRenderer(caretIndex);
                    if (_loc_5)
                    {
                        drawItem(_loc_5);
                    }
                    caretIndex = selectedIndex;
                }
                if (isBranch(_loc_4))
                {
                    _loc_6 = !isItemOpen(_loc_4);
                    dispatchTreeEvent(TreeEvent.ITEM_OPENING, _loc_4, null, event, _loc_6, true, true);
                }
                event.stopImmediatePropagation();
            }
            else if (event.keyCode == Keyboard.LEFT)
            {
                if (isItemOpen(_loc_4))
                {
                    dispatchTreeEvent(TreeEvent.ITEM_OPENING, _loc_4, null, event, false, true, true);
                }
                else
                {
                    _loc_7 = getParentItem(_loc_4);
                    if (_loc_7)
                    {
                        proposedSelectedItem = _loc_7;
                        finishArrowKeySelection();
                    }
                }
                event.stopImmediatePropagation();
            }
            else if (event.keyCode == Keyboard.RIGHT)
            {
                if (isBranch(_loc_4))
                {
                    if (isItemOpen(_loc_4))
                    {
                        if (_loc_4)
                        {
                            _loc_8 = getChildren(_loc_4, iterator.view);
                            if (_loc_8)
                            {
                                _loc_9 = _loc_8.createCursor();
                                if (_loc_9.current)
                                {
                                    proposedSelectedItem = _loc_9.current;
                                }
                            }
                            else
                            {
                                proposedSelectedItem = null;
                            }
                        }
                        else
                        {
                            var _loc_10:* = null;
                            proposedSelectedItem = null;
                            selectedItem = _loc_10;
                        }
                        finishArrowKeySelection();
                    }
                    else
                    {
                        dispatchTreeEvent(TreeEvent.ITEM_OPENING, _loc_4, null, event, true, true, true);
                    }
                }
                event.stopImmediatePropagation();
            }
            else if (event.keyCode == Keyboard.NUMPAD_MULTIPLY)
            {
                expandChildrenOf(_loc_4, !isItemOpen(_loc_4));
            }
            else if (event.keyCode == Keyboard.NUMPAD_ADD)
            {
                if (isBranch(_loc_4))
                {
                    if (!isItemOpen(_loc_4))
                    {
                        dispatchTreeEvent(TreeEvent.ITEM_OPENING, _loc_4, null, event, true, true, true);
                    }
                }
            }
            else if (event.keyCode == Keyboard.NUMPAD_SUBTRACT)
            {
                if (isItemOpen(_loc_4))
                {
                    dispatchTreeEvent(TreeEvent.ITEM_OPENING, _loc_4, null, event, false, true, true);
                }
            }
            else
            {
                super.keyDownHandler(event);
            }
            return;
        }// end function

        function onTweenEnd(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            UIComponent.resumeBackgroundProcessing();
            onTweenUpdate(param1);
            var _loc_5:* = listItems.length;
            isOpening = false;
            if (collection)
            {
                _loc_8 = opening ? (buildUpCollectionEvents(true)) : (buildUpCollectionEvents(false));
                _loc_2 = 0;
                while (_loc_2 < _loc_8.length)
                {
                    
                    collection.dispatchEvent(_loc_8[_loc_2]);
                    _loc_2++;
                }
            }
            if (opening)
            {
                _loc_9 = -1;
                _loc_2 = rowIndex;
                while (_loc_2 < _loc_5)
                {
                    
                    if (listItems[_loc_2].length)
                    {
                        _loc_3 = listItems[_loc_2][0];
                        _loc_10 = _loc_3.mask;
                        if (_loc_10)
                        {
                            listContent.removeChild(_loc_10);
                            _loc_3.mask = null;
                        }
                        rowMap[_loc_3.name].rowIndex = _loc_2;
                        if (_loc_3 is IDropInListItemRenderer)
                        {
                            _loc_4 = IDropInListItemRenderer(_loc_3);
                            if (_loc_4.listData)
                            {
                                _loc_4.listData.rowIndex = _loc_2;
                                _loc_4.listData = _loc_4.listData;
                            }
                        }
                        if (_loc_3.y > listContent.height)
                        {
                            addToFreeItemRenderers(_loc_3);
                            _loc_6 = itemToUID(_loc_3.data);
                            if (selectionIndicators[_loc_6])
                            {
                                _loc_7 = selectionIndicators[_loc_6];
                                if (_loc_7)
                                {
                                    _loc_10 = _loc_7.mask;
                                    if (_loc_10)
                                    {
                                        listContent.removeChild(_loc_10);
                                        _loc_7.mask = null;
                                    }
                                }
                                removeIndicators(_loc_6);
                            }
                            delete rowMap[_loc_3.name];
                            if (_loc_9 < 0)
                            {
                                _loc_9 = _loc_2;
                            }
                        }
                    }
                    else if (rowInfo[_loc_2].y >= listContent.height)
                    {
                        if (_loc_9 < 0)
                        {
                            _loc_9 = _loc_2;
                        }
                    }
                    _loc_2++;
                }
                if (_loc_9 >= 0)
                {
                    rowInfo.splice(_loc_9);
                    listItems.splice(_loc_9);
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < rowList.length)
                {
                    
                    _loc_10 = rowList[_loc_2].item.mask;
                    if (_loc_10)
                    {
                        listContent.removeChild(_loc_10);
                        rowList[_loc_2].item.mask = null;
                    }
                    addToFreeItemRenderers(rowList[_loc_2].item);
                    _loc_6 = itemToUID(rowList[_loc_2].item.data);
                    if (selectionIndicators[_loc_6])
                    {
                        _loc_7 = selectionIndicators[_loc_6];
                        if (_loc_7)
                        {
                            _loc_10 = _loc_7.mask;
                            if (_loc_10)
                            {
                                listContent.removeChild(_loc_10);
                                _loc_7.mask = null;
                            }
                        }
                        removeIndicators(_loc_6);
                    }
                    delete rowMap[rowList[_loc_2].item.name];
                    _loc_2++;
                }
                _loc_2 = rowIndex;
                while (_loc_2 < _loc_5)
                {
                    
                    if (listItems[_loc_2].length)
                    {
                        _loc_3 = listItems[_loc_2][0];
                        rowMap[_loc_3.name].rowIndex = _loc_2;
                        if (_loc_3 is IDropInListItemRenderer)
                        {
                            _loc_4 = IDropInListItemRenderer(_loc_3);
                            if (_loc_4.listData)
                            {
                                _loc_4.listData.rowIndex = _loc_2;
                                _loc_4.listData = _loc_4.listData;
                            }
                        }
                    }
                    _loc_2++;
                }
            }
            if (eventAfterTween)
            {
                dispatchTreeEvent(isItemOpen(eventAfterTween) ? (TreeEvent.ITEM_OPEN) : (TreeEvent.ITEM_CLOSE), eventAfterTween, visibleData[itemToUID(eventAfterTween)], lastUserInteraction);
                lastUserInteraction = null;
                eventAfterTween = false;
            }
            itemsSizeChanged = true;
            invalidateDisplayList();
            tween = null;
            return;
        }// end function

        override protected function adjustAfterRemove(param1:Array, param2:int, param3:Boolean) : Boolean
        {
            var _loc_4:* = selectedItems.length;
            var _loc_5:* = param3;
            var _loc_6:* = param1.length;
            if (_selectedIndex > param2)
            {
                _selectedIndex = _selectedIndex - _loc_6;
                _loc_5 = true;
            }
            if (bSelectedItemRemoved && _loc_4 < 1)
            {
                _selectedIndex = getItemIndex(expandedItem);
                _loc_5 = true;
                bSelectionChanged = true;
                bSelectedIndexChanged = true;
                invalidateDisplayList();
            }
            return _loc_5;
        }// end function

        public function set dataDescriptor(param1:ITreeDataDescriptor) : void
        {
            _dataDescriptor = param1;
            return;
        }// end function

        private function isBranch(param1:Object) : Boolean
        {
            if (param1 != null)
            {
                return _dataDescriptor.isBranch(param1, iterator.view);
            }
            return false;
        }// end function

        private function getVisibleChildrenCount(param1:Object) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = 0;
            if (param1 == null)
            {
                return _loc_2;
            }
            var _loc_3:* = itemToUID(param1);
            if (_openItems[_loc_3] && _dataDescriptor.isBranch(param1, iterator.view) && _dataDescriptor.hasChildren(param1, iterator.view))
            {
                _loc_4 = getChildren(param1, iterator.view);
            }
            if (_loc_4 != null)
            {
                _loc_5 = _loc_4.createCursor();
                while (!_loc_5.afterLast)
                {
                    
                    _loc_2++;
                    _loc_3 = itemToUID(_loc_5.current);
                    if (_openItems[_loc_3])
                    {
                        _loc_2 = _loc_2 + getVisibleChildrenCount(_loc_5.current);
                    }
                    _loc_5.moveNext();
                }
            }
            return _loc_2;
        }// end function

        function getChildren(param1:Object, param2:Object) : ICollectionView
        {
            var _loc_3:* = _dataDescriptor.getChildren(param1, param2);
            return _loc_3;
        }// end function

        public function expandChildrenOf(param1:Object, param2:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (iterator == null)
            {
                return;
            }
            if (isBranch(param1))
            {
                dispatchTreeEvent(TreeEvent.ITEM_OPENING, param1, null, null, param2, false, true);
                if (param1 != null && _dataDescriptor.isBranch(param1, iterator.view) && _dataDescriptor.hasChildren(param1, iterator.view))
                {
                    _loc_3 = getChildren(param1, iterator.view);
                }
                if (_loc_3)
                {
                    _loc_4 = _loc_3.createCursor();
                    while (!_loc_4.afterLast)
                    {
                        
                        if (isBranch(_loc_4.current))
                        {
                            expandChildrenOf(_loc_4.current, param2);
                        }
                        _loc_4.moveNext();
                    }
                }
            }
            return;
        }// end function

        override public function set dataProvider(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_rootModel)
            {
                _rootModel.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
            }
            if (typeof(param1) == "string")
            {
                param1 = new XML(param1);
            }
            else if (param1 is XMLNode)
            {
                param1 = new XML(XMLNode(param1).toString());
            }
            else if (param1 is XMLList)
            {
                param1 = new XMLListCollection(param1 as XMLList);
            }
            if (param1 is XML)
            {
                _hasRoot = true;
                _loc_2 = new XMLList();
                _loc_2 = _loc_2 + param1;
                _rootModel = new XMLListCollection(_loc_2);
            }
            else if (param1 is ICollectionView)
            {
                _rootModel = ICollectionView(param1);
                if (_rootModel.length == 1)
                {
                    _hasRoot = true;
                }
            }
            else if (param1 is Array)
            {
                _rootModel = new ArrayCollection(param1 as Array);
            }
            else if (param1 is Object)
            {
                _hasRoot = true;
                _loc_3 = [];
                _loc_3.push(param1);
                _rootModel = new ArrayCollection(_loc_3);
            }
            else
            {
                _rootModel = new ArrayCollection();
            }
            dataProviderChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get showRoot() : Boolean
        {
            return _showRoot;
        }// end function

        override protected function collectionChangeHandler(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (iterator == null)
            {
                return;
            }
            if (event is CollectionEvent)
            {
                _loc_4 = CollectionEvent(event);
                if (_loc_4.kind == CollectionEventKind.EXPAND)
                {
                    event.stopPropagation();
                }
                if (_loc_4.kind == CollectionEventKind.UPDATE)
                {
                    event.stopPropagation();
                    itemsSizeChanged = true;
                    invalidateDisplayList();
                }
                else
                {
                    super.collectionChangeHandler(event);
                }
            }
            return;
        }// end function

        override protected function makeListData(param1:Object, param2:String, param3:int) : BaseListData
        {
            var _loc_4:* = new TreeListData(itemToLabel(param1), param2, this, param3);
            initListData(param1, _loc_4);
            return _loc_4;
        }// end function

        override public function itemToIcon(param1:Object) : Class
        {
            var icon:*;
            var item:* = param1;
            if (item == null)
            {
                return null;
            }
            var open:* = isItemOpen(item);
            var branch:* = isBranch(item);
            var uid:* = itemToUID(item);
            var iconClass:* = itemIcons && itemIcons[uid] ? (itemIcons[uid][open ? ("iconID2") : ("iconID")]) : (null);
            if (iconClass)
            {
                return iconClass;
            }
            if (iconFunction != null)
            {
                return iconFunction(item);
            }
            if (branch)
            {
                return getStyle(open ? ("folderOpenIcon") : ("folderClosedIcon"));
            }
            else if (item is XML)
            {
                try
                {
                    if (item[iconField].length() != 0)
                    {
                        icon = String(item[iconField]);
                    }
                }
                catch (e:Error)
                {
                }
            }
            else if (item is Object)
            {
                try
                {
                    if (iconField && item[iconField])
                    {
                        icon = item[iconField];
                    }
                    else if (item.icon)
                    {
                        icon = item.icon;
                    }
                }
                catch (e:Error)
                {
                }
            }
            if (icon == null)
            {
                icon = getStyle("defaultLeafIcon");
            }
            if (icon is Class)
            {
                return icon;
            }
            if (icon is String)
            {
                iconClass = Class(systemManager.getDefinitionByName(String(icon)));
                if (iconClass)
                {
                    return iconClass;
                }
                return document[icon];
            }
            else
            {
                return Class(icon);
            }
        }// end function

        public function get openItems() : Object
        {
            var _loc_2:* = undefined;
            var _loc_1:* = [];
            for each (_loc_2 in _openItems)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public function selectionDataPendingResultHandler(param1:Object, param2:ListBaseSelectionDataPending) : void
        {
            super.selectionDataPendingResultHandler(param1, param2);
            if (bFinishArrowKeySelection && selectedItem === proposedSelectedItem)
            {
                finishArrowKeySelection();
            }
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (Tree.createAccessibilityImplementation != null)
            {
                Tree.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseOutHandler(event);
            }
            return;
        }// end function

        public function get hasRoot() : Boolean
        {
            return _hasRoot;
        }// end function

        override protected function dragEnterHandler(event:DragEvent) : void
        {
            var event:* = event;
            if (event.isDefaultPrevented())
            {
                return;
            }
            lastDragEvent = event;
            haveItemIndices = false;
            try
            {
                if (iteratorValid && event.dragSource.hasFormat("treeItems"))
                {
                    DragManager.acceptDragDrop(this);
                    DragManager.showFeedback(event.ctrlKey ? (DragManager.COPY) : (DragManager.MOVE));
                    showDropFeedback(event);
                    return;
                }
            }
            catch (e:ItemPendingError)
            {
                if (!lastTreeSeekPending)
                {
                    lastTreeSeekPending = new TreeSeekPending(event, dragEnterHandler);
                    e.addResponder(new ItemResponder(seekPendingDuringDragResultHandler, seekPendingDuringDragFailureHandler, lastTreeSeekPending));
                }
                ;
            }
            catch (e1:Error)
            {
            }
            hideDropFeedback(event);
            DragManager.showFeedback(DragManager.NONE);
            return;
        }// end function

        protected function initListData(param1:Object, param2:TreeListData) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_3:* = isItemOpen(param1);
            var _loc_4:* = isBranch(param1);
            var _loc_5:* = itemToUID(param1);
            param2.disclosureIcon = getStyle(_loc_3 ? ("disclosureOpenIcon") : ("disclosureClosedIcon"));
            param2.open = _loc_3;
            param2.hasChildren = _loc_4;
            param2.depth = getItemDepth(param1, param2.rowIndex);
            param2.indent = (param2.depth - 1) * getStyle("indentation");
            param2.item = param1;
            param2.icon = itemToIcon(param1);
            return;
        }// end function

        private function getIndent() : Number
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for (_loc_2 in _openItems)
            {
                
                _loc_1 = Math.max((getParentStack(_loc_4[_loc_2]).length + 1), _loc_1);
            }
            return _loc_1 * getStyle("indentation");
        }// end function

        public function setItemIcon(param1:Object, param2:Class, param3:Class) : void
        {
            if (!itemIcons)
            {
                itemIcons = {};
            }
            if (!param3)
            {
                param3 = param2;
            }
            itemIcons[itemToUID(param1)] = {iconID:param2, iconID2:param3};
            itemsSizeChanged = true;
            invalidateDisplayList();
            return;
        }// end function

        public function set firstVisibleItem(param1:Object) : void
        {
            var _loc_2:* = getItemIndex(param1);
            if (_loc_2 < 0)
            {
                return;
            }
            verticalScrollPosition = Math.min(maxVerticalScrollPosition, _loc_2);
            dispatchEvent(new Event("firstVisibleItemChanged"));
            return;
        }// end function

        override protected function mouseWheelHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseWheelHandler(event);
            }
            return;
        }// end function

        function onTweenUpdate(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            _loc_3 = listItems.length;
            _loc_4 = rowIndex;
            while (_loc_4 < _loc_3)
            {
                
                if (listItems[_loc_4].length)
                {
                    _loc_2 = IFlexDisplayObject(listItems[_loc_4][0]);
                    _loc_6 = _loc_2.y;
                    _loc_2.move(_loc_2.x, rowInfo[_loc_4].itemOldY + param1);
                    _loc_5 = _loc_2.y - _loc_6;
                }
                _loc_7 = selectionIndicators[rowInfo[_loc_4].uid];
                rowInfo[_loc_4].y = rowInfo[_loc_4].y + _loc_5;
                if (_loc_7)
                {
                    _loc_7.y = _loc_7.y + _loc_5;
                }
                _loc_4++;
            }
            _loc_3 = rowList.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_7 = null;
                _loc_2 = IFlexDisplayObject(rowList[_loc_4].item);
                if (rowMap[_loc_2.name] != null)
                {
                    _loc_7 = selectionIndicators[BaseListData(rowMap[_loc_2.name]).uid];
                }
                _loc_6 = _loc_2.y;
                _loc_2.move(_loc_2.x, rowList[_loc_4].itemOldY + param1);
                _loc_5 = _loc_2.y - _loc_6;
                if (_loc_7)
                {
                    _loc_7.y = _loc_7.y + _loc_5;
                }
                _loc_4++;
            }
            return;
        }// end function

        override public function set dragMoveEnabled(param1:Boolean) : void
        {
            _dragMoveEnabled = param1;
            return;
        }// end function

        public function get dataDescriptor() : ITreeDataDescriptor
        {
            return ITreeDataDescriptor(_dataDescriptor);
        }// end function

        override public function get dataProvider() : Object
        {
            if (_rootModel)
            {
                return _rootModel;
            }
            return null;
        }// end function

        override public function set maxHorizontalScrollPosition(param1:Number) : void
        {
            _userMaxHorizontalScrollPosition = param1;
            param1 = param1 + getIndent();
            super.maxHorizontalScrollPosition = param1;
            return;
        }// end function

        override protected function scrollHandler(event:Event) : void
        {
            if (isOpening)
            {
                return;
            }
            if (event is ScrollEvent)
            {
                super.scrollHandler(event);
            }
            return;
        }// end function

        override protected function addDragData(param1:Object) : void
        {
            param1.addHandler(collapseSelectedItems, "treeItems");
            return;
        }// end function

        function getItemDepth(param1:Object, param2:int) : int
        {
            if (!collection)
            {
                return 0;
            }
            if (!iterator)
            {
                listContent.iterator = collection.createCursor();
            }
            if (iterator.current == param1)
            {
                return getCurrentCursorDepth();
            }
            var _loc_3:* = iterator.bookmark;
            iterator.seek(_loc_3, param2);
            var _loc_4:* = getCurrentCursorDepth();
            iterator.seek(_loc_3, 0);
            return _loc_4;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (param1 == null || param1 == "styleName" || IS_NEW_ROW_STYLE[param1])
            {
                itemsSizeChanged = true;
                invalidateDisplayList();
            }
            super.styleChanged(param1);
            return;
        }// end function

        function expandItemHandler(event:TreeEvent) : void
        {
            if (event.isDefaultPrevented())
            {
                return;
            }
            if (event.type == TreeEvent.ITEM_OPENING)
            {
                expandItem(event.item, event.opening, event.animate, event.dispatchEvent, event.triggerEvent);
            }
            return;
        }// end function

        override protected function mouseDoubleClickHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseDoubleClickHandler(event);
            }
            return;
        }// end function

        function addChildItem(param1:Object, param2:Object, param3:Number) : Boolean
        {
            return _dataDescriptor.addChildAt(param1, param2, param3, iterator.view);
        }// end function

        private function getParentStack(param1:Object) : Array
        {
            var _loc_2:* = [];
            if (param1 == null)
            {
                return _loc_2;
            }
            var _loc_3:* = getParentItem(param1);
            while (_loc_3)
            {
                
                _loc_2.push(_loc_3);
                _loc_3 = getParentItem(_loc_3);
            }
            return _loc_2;
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            var _loc_2:* = collection.createCursor();
            var _loc_3:* = 0;
            do
            {
                
                if (_loc_2.current === param1)
                {
                    break;
                }
                _loc_3++;
            }while (_loc_2.moveNext())
            _loc_2.seek(CursorBookmark.FIRST, 0);
            return _loc_3;
        }// end function

        public function expandItem(param1:Object, param2:Boolean, param3:Boolean = false, param4:Boolean = false, param5:Event = null) : void
        {
            var i:int;
            var newRowIndex:int;
            var rowData:BaseListData;
            var tmpMask:DisplayObject;
            var tmpRowInfo:Object;
            var row:Array;
            var n:int;
            var eventArr:Array;
            var renderer:IListItemRenderer;
            var xx:Number;
            var ww:Number;
            var yy:Number;
            var hh:Number;
            var delta:int;
            var maxDist:Number;
            var oE:Function;
            var di:IDropInListItemRenderer;
            var treeListData:TreeListData;
            var data:Object;
            var referenceRowInfo:ListRowInfo;
            var rh:Number;
            var more:Boolean;
            var valid:Boolean;
            var startY:Number;
            var maskY:Number;
            var maskX:Number;
            var indicator:Object;
            var item:* = param1;
            var open:* = param2;
            var animate:* = param3;
            var dispatchEvent:* = param4;
            var cause:* = param5;
            if (iterator == null)
            {
                return;
            }
            if (cause)
            {
                lastUserInteraction = cause;
            }
            expandedItem = item;
            listContent.allowItemSizeChangeNotification = false;
            var bSelected:Boolean;
            var bHighlight:Boolean;
            var bCaret:Boolean;
            var uid:* = itemToUID(item);
            if (!isBranch(item) || isItemOpen(item) == open || isOpening)
            {
                return;
            }
            if (itemEditorInstance)
            {
                endEdit(ListEventReason.OTHER);
            }
            oldLength = collectionLength;
            var bookmark:* = iterator.bookmark;
            var event:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, CollectionEventKind.EXPAND);
            event.items = [item];
            if (open)
            {
                _openItems[uid] = item;
                collection.dispatchEvent(event);
                rowsTweened = Math.abs(oldLength - collection.length);
            }
            else
            {
                delete _openItems[uid];
                collection.dispatchEvent(event);
                rowsTweened = Math.abs(oldLength - collection.length);
            }
            if (isItemVisible(item))
            {
                if (visibleData[uid])
                {
                    n = listItems.length;
                    rowIndex = 0;
                    while (rowIndex < n)
                    {
                        
                        if (rowInfo[rowIndex].uid == uid)
                        {
                            var _loc_8:* = rowIndex + 1;
                            rowIndex = _loc_8;
                            break;
                        }
                        var _loc_8:* = rowIndex + 1;
                        rowIndex = _loc_8;
                    }
                }
            }
            else
            {
                eventArr = open ? (buildUpCollectionEvents(true)) : (buildUpCollectionEvents(false));
                i;
                while (i < eventArr.length)
                {
                    
                    collection.dispatchEvent(eventArr[i]);
                    i = (i + 1);
                }
                return;
            }
            var rC:* = listItems.length;
            var rowsToMove:* = rowsTweened;
            var dur:* = getStyle("openDuration");
            if (animate && rowIndex < rC && rowsToMove > 0 && rowsToMove < 20 && dur != 0)
            {
                if (tween)
                {
                    tween.endTween();
                }
                renderer = listItems[(rowIndex - 1)][0];
                if (renderer is IDropInListItemRenderer)
                {
                    di = IDropInListItemRenderer(renderer);
                    treeListData = TreeListData(di.listData);
                    treeListData = TreeListData(makeListData(treeListData.item, treeListData.uid, treeListData.rowIndex));
                    di.listData = treeListData;
                    renderer.mx.core:IDataRenderer::data = renderer.mx.core:IDataRenderer::data;
                }
                opening = open;
                isOpening = true;
                maskList = [];
                rowList = [];
                xx = getStyle("paddingLeft") - horizontalScrollPosition;
                ww = renderer.width;
                yy;
                delta = rowIndex;
                maxDist;
                if (open)
                {
                    newRowIndex = rowIndex;
                    maxDist = listContent.height - rowInfo[rowIndex].y;
                    iterator.seek(CursorBookmark.CURRENT, delta);
                    i;
                    while (i < rowsToMove && yy < maxDist)
                    {
                        
                        data = iterator.current;
                        if (freeItemRenderers.length)
                        {
                            renderer = freeItemRenderers.pop();
                        }
                        else
                        {
                            renderer = createItemRenderer(data);
                            renderer.owner = this;
                            renderer.styleName = listContent;
                            listContent.addChild(DisplayObject(renderer));
                        }
                        uid = itemToUID(data);
                        rowData = makeListData(data, uid, rowIndex + i);
                        rowMap[renderer.name] = rowData;
                        if (renderer is IDropInListItemRenderer)
                        {
                            IDropInListItemRenderer(renderer).listData = data ? (rowData) : (null);
                        }
                        renderer.mx.core:IDataRenderer::data = data;
                        renderer.enabled = enabled;
                        if (data)
                        {
                            visibleData[uid] = renderer;
                            renderer.visible = true;
                        }
                        else
                        {
                            renderer.visible = false;
                        }
                        renderer.explicitWidth = ww;
                        if (renderer is IInvalidating && (wordWrapChanged || variableRowHeight))
                        {
                            IInvalidating(renderer).invalidateSize();
                        }
                        UIComponentGlobals.layoutManager.validateClient(renderer, true);
                        hh = Math.ceil(variableRowHeight ? (renderer.getExplicitOrMeasuredHeight() + cachedPaddingTop + cachedPaddingBottom) : (rowHeight));
                        rh = renderer.getExplicitOrMeasuredHeight();
                        renderer.setActualSize(ww, variableRowHeight ? (rh) : (rowHeight - cachedPaddingTop - cachedPaddingBottom));
                        renderer.move(xx, yy + cachedPaddingTop);
                        bSelected = selectedData[uid] != null;
                        bHighlight = highlightUID == uid;
                        bCaret = caretUID == uid;
                        tmpRowInfo = new ListRowInfo(yy, hh, uid, data);
                        if (data)
                        {
                            drawItem(renderer, bSelected, bHighlight, bCaret);
                        }
                        yy = yy + hh;
                        rowInfo.splice(rowIndex + i, 0, tmpRowInfo);
                        row;
                        row.push(renderer);
                        listItems.splice(rowIndex + i, 0, row);
                        if (i < (rowsToMove - 1))
                        {
                            try
                            {
                                iterator.moveNext();
                            }
                            catch (e:ItemPendingError)
                            {
                                rowsToMove = (i + 1);
                                break;
                            }
                        }
                        i = (i + 1);
                    }
                    rowsTweened = i;
                    referenceRowInfo = rowInfo[rowIndex + rowsTweened];
                    i;
                    while (i < rowsTweened)
                    {
                        
                        renderer = listItems[rowIndex + i][0];
                        renderer.move(renderer.x, renderer.y - (yy - referenceRowInfo.y));
                        rowInfo[rowIndex + i].y = rowInfo[rowIndex + i].y - (yy - referenceRowInfo.y);
                        tmpMask = makeMask();
                        tmpMask.x = xx;
                        tmpMask.y = referenceRowInfo.y;
                        tmpMask.width = ww;
                        tmpMask.height = yy;
                        listItems[rowIndex + i][0].mask = tmpMask;
                        i = (i + 1);
                    }
                }
                else
                {
                    more;
                    valid;
                    var _loc_7:* = rowInfo[(listItems.length - 1)].y + rowInfo[(listItems.length - 1)].height;
                    yy = rowInfo[(listItems.length - 1)].y + rowInfo[(listItems.length - 1)].height;
                    startY = _loc_7;
                    i = rowIndex;
                    while (i < rowIndex + rowsToMove && i < rC)
                    {
                        
                        maxDist = maxDist + rowInfo[i].height;
                        rowList.push({item:listItems[i][0]});
                        tmpMask = makeMask();
                        tmpMask.x = xx;
                        tmpMask.y = listItems[rowIndex][0].y;
                        tmpMask.width = ww;
                        tmpMask.height = maxDist;
                        listItems[i][0].mask = tmpMask;
                        i = (i + 1);
                    }
                    rowsToMove = i - rowIndex;
                    rowInfo.splice(rowIndex, rowsToMove);
                    listItems.splice(rowIndex, rowsToMove);
                    iterator.seek(CursorBookmark.CURRENT, listItems.length);
                    more = iterator != null && !iterator.afterLast && iteratorValid;
                    maxDist = maxDist + yy;
                    i;
                    while (i < rowsToMove && yy < maxDist)
                    {
                        
                        uid;
                        data;
                        renderer;
                        valid = more;
                        data = more ? (iterator.current) : (null);
                        if (valid)
                        {
                            if (freeItemRenderers.length)
                            {
                                renderer = freeItemRenderers.pop();
                            }
                            else
                            {
                                renderer = createItemRenderer(data);
                                renderer.owner = this;
                                renderer.styleName = listContent;
                                listContent.addChild(DisplayObject(renderer));
                            }
                            uid = itemToUID(data);
                            rowData = makeListData(data, uid, rC - rowsToMove + i);
                            rowMap[renderer.name] = rowData;
                            if (renderer is IDropInListItemRenderer)
                            {
                                IDropInListItemRenderer(renderer).listData = data ? (rowData) : (null);
                            }
                            renderer.mx.core:IDataRenderer::data = data;
                            renderer.enabled = enabled;
                            if (data)
                            {
                                visibleData[uid] = renderer;
                                renderer.visible = true;
                            }
                            else
                            {
                                renderer.visible = false;
                            }
                            renderer.explicitWidth = ww;
                            if (renderer is IInvalidating && (wordWrapChanged || variableRowHeight))
                            {
                                IInvalidating(renderer).invalidateSize();
                            }
                            UIComponentGlobals.layoutManager.validateClient(renderer, true);
                            hh = Math.ceil(variableRowHeight ? (renderer.getExplicitOrMeasuredHeight() + cachedPaddingTop + cachedPaddingBottom) : (rowHeight));
                            rh = renderer.getExplicitOrMeasuredHeight();
                            renderer.setActualSize(ww, variableRowHeight ? (rh) : (rowHeight - cachedPaddingTop - cachedPaddingBottom));
                            renderer.move(xx, yy + cachedPaddingTop);
                        }
                        else if (!variableRowHeight)
                        {
                            hh = rowIndex + i > 0 ? (rowInfo[rowIndex + i - 1].height) : (rowHeight);
                        }
                        else if (rowList[i])
                        {
                            hh = Math.ceil(rowList[i].item.getExplicitOrMeasuredHeight() + cachedPaddingTop + cachedPaddingBottom);
                        }
                        else
                        {
                            hh = rowHeight;
                        }
                        bSelected = selectedData[uid] != null;
                        bHighlight = highlightUID == uid;
                        bCaret = caretUID == uid;
                        tmpRowInfo = new ListRowInfo(yy, hh, uid, data);
                        rowInfo.push(tmpRowInfo);
                        if (data)
                        {
                            drawItem(renderer, bSelected, bHighlight, bCaret);
                        }
                        yy = yy + hh;
                        if (valid)
                        {
                            row;
                            row.push(renderer);
                            listItems.push(row);
                        }
                        else
                        {
                            listItems.push([]);
                        }
                        if (more)
                        {
                            try
                            {
                                more = iterator.moveNext();
                            }
                            catch (e:ItemPendingError)
                            {
                                more;
                            }
                        }
                        i = (i + 1);
                    }
                    maskY = rowList[0].item.y - getStyle("paddingTop");
                    maskX = rowList[0].item.x - getStyle("paddingLeft");
                    i;
                    while (i < rowList.length)
                    {
                        
                        indicator = selectionIndicators[itemToUID(rowList[i].item.data)];
                        if (indicator)
                        {
                            tmpMask = makeMask();
                            tmpMask.x = maskX;
                            tmpMask.y = maskY;
                            tmpMask.width = rowList[i].item.width + getStyle("paddingLeft") + getStyle("paddingRight");
                            tmpMask.height = rowList[i].item.y + rowList[i].item.height + getStyle("paddingTop") + getStyle("paddingBottom") - maskY;
                            selectionIndicators[itemToUID(rowList[i].item.data)].mask = tmpMask;
                        }
                        i = (i + 1);
                    }
                }
                iterator.seek(bookmark, 0);
                rC = rowList.length;
                i;
                while (i < rC)
                {
                    
                    rowList[i].itemOldY = rowList[i].item.y;
                    i = (i + 1);
                }
                rC = listItems.length;
                i = rowIndex;
                while (i < rC)
                {
                    
                    if (listItems[i].length)
                    {
                        rowInfo[i].itemOldY = listItems[i][0].y;
                    }
                    rowInfo[i].oldY = rowInfo[i].y;
                    i = (i + 1);
                }
                dur = dur * Math.max(rowsToMove / 5, 1);
                if (dispatchEvent)
                {
                    eventAfterTween = item;
                }
                tween = new Tween(this, 0, open ? (yy) : (startY - yy), dur, 5);
                oE = getStyle("openEasingFunction") as Function;
                if (oE != null)
                {
                    tween.easingFunction = oE;
                }
                UIComponent.suspendBackgroundProcessing();
                UIComponentGlobals.layoutManager.validateNow();
            }
            else
            {
                if (dispatchEvent)
                {
                    dispatchTreeEvent(open ? (TreeEvent.ITEM_OPEN) : (TreeEvent.ITEM_CLOSE), item, visibleData[itemToUID(item)], lastUserInteraction);
                    lastUserInteraction = null;
                }
                itemsSizeChanged = true;
                invalidateDisplayList();
            }
            if (!wordWrap && initialized)
            {
                super.maxHorizontalScrollPosition = _userMaxHorizontalScrollPosition > 0 ? (_userMaxHorizontalScrollPosition + getIndent()) : (super.maxHorizontalScrollPosition);
            }
            listContent.allowItemSizeChangeNotification = variableRowHeight;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = undefined;
            if (showRootChanged)
            {
                if (!_hasRoot)
                {
                    showRootChanged = false;
                }
            }
            if (dataProviderChanged || showRootChanged || openItemsChanged)
            {
                dataProviderChanged = false;
                showRootChanged = false;
                if (!openItemsChanged)
                {
                    _openItems = {};
                }
                if (_rootModel && !_showRoot && _hasRoot)
                {
                    _loc_2 = _rootModel.createCursor().current;
                    if (_loc_2 != null && _dataDescriptor.isBranch(_loc_2, _rootModel) && _dataDescriptor.hasChildren(_loc_2, _rootModel))
                    {
                        _loc_1 = getChildren(_loc_2, _rootModel);
                    }
                }
                if (_rootModel)
                {
                    var _loc_3:* = _dataDescriptor is ITreeDataDescriptor2 ? (ITreeDataDescriptor2(_dataDescriptor).getHierarchicalCollectionAdaptor(_loc_1 != null ? (_loc_1) : (_rootModel), itemToUID, _openItems)) : (new HierarchicalCollectionView(_loc_1 != null ? (_loc_1) : (_rootModel), _dataDescriptor, itemToUID, _openItems));
                    wrappedCollection = _dataDescriptor is ITreeDataDescriptor2 ? (ITreeDataDescriptor2(_dataDescriptor).getHierarchicalCollectionAdaptor(_loc_1 != null ? (_loc_1) : (_rootModel), itemToUID, _openItems)) : (new HierarchicalCollectionView(_loc_1 != null ? (_loc_1) : (_rootModel), _dataDescriptor, itemToUID, _openItems));
                    super.dataProvider = _loc_3;
                    wrappedCollection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, EventPriority.DEFAULT_HANDLER, true);
                }
                else
                {
                    super.dataProvider = null;
                }
            }
            super.commitProperties();
            return;
        }// end function

        public function getParentItem(param1:Object)
        {
            if (param1 == null)
            {
                return null;
            }
            if (param1 && collection)
            {
                if (_dataDescriptor is ITreeDataDescriptor2)
                {
                    return ITreeDataDescriptor2(_dataDescriptor).getParent(param1, wrappedCollection, _rootModel);
                }
                return HierarchicalCollectionView(collection).getParentItem(param1);
            }
            return null;
        }// end function

        public function get firstVisibleItem() : Object
        {
            if (listItems.length > 0 && listItems[0].length > 0)
            {
                return listItems[0][0].data;
            }
            return null;
        }// end function

        private function getCurrentCursorDepth() : int
        {
            if (_dataDescriptor is ITreeDataDescriptor2)
            {
                return ITreeDataDescriptor2(_dataDescriptor).getNodeDepth(iterator.current, iterator, _rootModel);
            }
            return HierarchicalViewCursor(iterator).currentDepth;
        }// end function

        override public function get maxHorizontalScrollPosition() : Number
        {
            return _userMaxHorizontalScrollPosition > 0 ? (_userMaxHorizontalScrollPosition) : (super.maxHorizontalScrollPosition);
        }// end function

        private function getOpenChildrenStack(param1:Object, param2:Array) : Array
        {
            var _loc_3:* = null;
            if (param1 == null)
            {
                return param2;
            }
            var _loc_4:* = getChildren(param1, iterator.view);
            if (!getChildren(param1, iterator.view))
            {
                return [];
            }
            var _loc_5:* = _loc_4.createCursor();
            while (!_loc_5.afterLast)
            {
                
                _loc_3 = _loc_5.current;
                param2.push(_loc_3);
                if (isBranch(_loc_3) && isItemOpen(_loc_3))
                {
                    getOpenChildrenStack(_loc_3, param2);
                }
                _loc_5.moveNext();
            }
            return param2;
        }// end function

        override protected function dragDropHandler(event:DragEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (event.isDefaultPrevented())
            {
                return;
            }
            hideDropFeedback(event);
            if (event.dragSource.hasFormat("treeItems"))
            {
                _loc_2 = event.dragSource.dataForFormat("treeItems") as Array;
                if (event.action == DragManager.MOVE && dragMoveEnabled)
                {
                    if (event.dragInitiator == this)
                    {
                        calculateDropIndex(event);
                        _loc_8 = _dropData.index;
                        _loc_9 = getParentStack(_dropData.parent);
                        _loc_9.unshift(_dropData.parent);
                        _loc_4 = _loc_2.length;
                        _loc_3 = 0;
                        while (_loc_3 < _loc_4)
                        {
                            
                            _loc_6 = getParentItem(_loc_2[_loc_3]);
                            _loc_5 = getChildIndexInParent(_loc_6, _loc_2[_loc_3]);
                            for each (_loc_7 in _loc_9)
                            {
                                
                                if (_loc_2[_loc_3] === _loc_7)
                                {
                                    return;
                                }
                            }
                            removeChildItem(_loc_6, _loc_2[_loc_3], _loc_5);
                            if (_loc_6 == _dropData.parent && _loc_5 < _dropData.index)
                            {
                                _loc_8 = _loc_8 - 1;
                            }
                            addChildItem(_dropData.parent, _loc_2[_loc_3], _loc_8);
                            _loc_3++;
                        }
                        return;
                    }
                }
                if (event.action == DragManager.COPY)
                {
                    if (!dataProvider)
                    {
                        dataProvider = [];
                        validateNow();
                    }
                    _loc_4 = _loc_2.length;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_4)
                    {
                        
                        _loc_10 = copyItemWithUID(_loc_2[_loc_3]);
                        addChildItem(_dropData.parent, _loc_10, _dropData.index);
                        _loc_3++;
                    }
                }
            }
            lastDragEvent = null;
            return;
        }// end function

        private function checkItemIndices(event:DragEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (haveItemIndices)
            {
                return;
            }
            if ((event.action == DragManager.MOVE || event.action == DragManager.NONE) && dragMoveEnabled)
            {
                if (event.dragInitiator == this)
                {
                    _loc_2 = event.dragSource.dataForFormat("treeItems") as Array;
                    _loc_3 = _loc_2.length;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3)
                    {
                        
                        _loc_5 = getParentItem(_loc_2[_loc_4]);
                        getChildIndexInParent(_loc_5, _loc_2[_loc_4]);
                        _loc_4++;
                    }
                    haveItemIndices = true;
                }
            }
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseClickHandler(event);
            }
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!tween)
            {
                super.mouseOverHandler(event);
            }
            return;
        }// end function

        private function seekPendingDuringDragFailureHandler(param1:Object, param2:TreeSeekPending) : void
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            if (tween)
            {
                tween.endTween();
            }
            super.updateDisplayList(param1, param2);
            if (collection)
            {
                collectionLength = collection.length;
            }
            return;
        }// end function

        private function makeMask() : DisplayObject
        {
            var _loc_1:* = new FlexShape();
            _loc_1.name = "mask";
            var _loc_2:* = _loc_1.graphics;
            _loc_2.beginFill(16777215);
            _loc_2.moveTo(0, 0);
            _loc_2.lineTo(0, 10);
            _loc_2.lineTo(10, 10);
            _loc_2.lineTo(10, 0);
            _loc_2.lineTo(0, 0);
            _loc_2.endFill();
            listContent.addChild(_loc_1);
            return _loc_1;
        }// end function

        override protected function dragCompleteHandler(event:DragEvent) : void
        {
            var items:Array;
            var parent:*;
            var index:int;
            var i:int;
            var n:int;
            var targetTree:Tree;
            var item:Object;
            var event:* = event;
            isPressed = false;
            if (event.isDefaultPrevented())
            {
                return;
            }
            resetDragScrolling();
            try
            {
                if (event.dragSource.hasFormat("treeItems"))
                {
                    if (event.action == DragManager.MOVE && dragMoveEnabled)
                    {
                        if (event.relatedObject != this)
                        {
                            items = event.dragSource.dataForFormat("treeItems") as Array;
                            n = items.length;
                            i;
                            while (i < n)
                            {
                                
                                parent = getParentItem(items[i]);
                                index = getChildIndexInParent(parent, items[i]);
                                removeChildItem(parent, items[i], index);
                                i = (i + 1);
                            }
                            if (event.relatedObject is Tree)
                            {
                                targetTree = Tree(event.relatedObject);
                                if (!targetTree.dataProvider)
                                {
                                    targetTree.dataProvider = [];
                                    targetTree.validateNow();
                                }
                                n = items.length;
                                i;
                                while (i < n)
                                {
                                    
                                    item = items[i];
                                    targetTree.addChildItem(targetTree._dropData.parent, item, targetTree._dropData.index);
                                    i = (i + 1);
                                }
                            }
                        }
                        clearSelected(false);
                    }
                }
            }
            catch (e:ItemPendingError)
            {
                e.addResponder(new ItemResponder(seekPendingDuringDragResultHandler, seekPendingDuringDragFailureHandler, new TreeSeekPending(event, dragCompleteHandler)));
            }
            lastDragEvent = null;
            return;
        }// end function

        public function set showRoot(param1:Boolean) : void
        {
            if (_showRoot != param1)
            {
                _showRoot = param1;
                showRootChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.ui.*;

import flash.xml.*;

import mx.collections.*;

import mx.collections.errors.*;

import mx.controls.listClasses.*;

import mx.controls.treeClasses.*;

import mx.core.*;

import mx.effects.*;

import mx.events.*;

import mx.managers.*;

import mx.styles.*;

class TreeSeekPending extends Object
{
    public var retryFunction:Function;
    public var event:DragEvent;

    function TreeSeekPending(event:DragEvent, param2:Function)
    {
        this.event = event;
        this.retryFunction = param2;
        return;
    }// end function

}


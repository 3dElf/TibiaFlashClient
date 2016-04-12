package tibia.trade.npcTradeWidgetClasses
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.network.*;

    public class CategorySelector extends Tile
    {
        private var m_UncommittedDataProvider:Boolean = false;
        private var m_InvalidCategoryRenderers:Boolean = false;
        protected var m_Sort:Sort = null;
        protected var m_DataProvider:IList = null;

        public function CategorySelector()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            setStyle("horizontalAlign", "center");
            setStyle("horizontalGap", 0);
            setStyle("verticalGap", 0);
            this.m_Sort = new Sort();
            this.m_Sort.fields = [new SortField("name", true, false, false)];
            return;
        }// end function

        protected function onDataProviderChange(event:CollectionEvent) : void
        {
            if (event != null)
            {
                this.invalidateCategoryRenderers();
            }
            return;
        }// end function

        protected function onCategoryClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null && this.m_DataProvider != null)
            {
                _loc_2 = getChildIndex(SkinnedAppearanceRenderer(event.currentTarget));
                _loc_3 = this.dataProvider.getItemAt(_loc_2).id;
                _loc_4 = Tibia.s_GetCommunication();
                if (_loc_4 != null && _loc_4.isGameRunning)
                {
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.commitProperties();
            if (this.m_UncommittedDataProvider)
            {
                if (this.m_DataProvider is ICollectionView)
                {
                    ICollectionView(this.m_DataProvider).sort = this.m_Sort;
                    ICollectionView(this.m_DataProvider).refresh();
                }
                this.m_UncommittedDataProvider = false;
            }
            if (this.m_InvalidCategoryRenderers)
            {
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = null;
                _loc_4 = null;
                _loc_1 = numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_4 = SkinnedAppearanceRenderer(removeChildAt(_loc_1));
                    _loc_4.removeEventListener(MouseEvent.CLICK, this.onCategoryClick);
                    _loc_1 = _loc_1 - 1;
                }
                if (this.dataProvider != null)
                {
                    _loc_1 = 0;
                    _loc_2 = this.dataProvider.length;
                    while (_loc_1 < _loc_2)
                    {
                        
                        _loc_3 = this.dataProvider.getItemAt(_loc_1);
                        _loc_4 = new SkinnedAppearanceRenderer();
                        _loc_4.appearance = new AppearanceTypeRef(_loc_3.iconTypeID, _loc_3.iconTypeData);
                        _loc_4.styleName = getStyle("rendererStyle");
                        _loc_4.toolTip = _loc_3.name;
                        _loc_4.addEventListener(MouseEvent.CLICK, this.onCategoryClick);
                        addChild(_loc_4);
                        _loc_1++;
                    }
                }
                this.m_InvalidCategoryRenderers = false;
            }
            return;
        }// end function

        public function set dataProvider(param1:IList) : void
        {
            if (this.m_DataProvider != param1)
            {
                if (this.m_DataProvider != null)
                {
                    this.m_DataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onDataProviderChange);
                }
                this.m_DataProvider = param1;
                this.m_UncommittedDataProvider = true;
                this.invalidateCategoryRenderers();
                invalidateProperties();
                if (this.m_DataProvider != null)
                {
                    this.m_DataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onDataProviderChange);
                }
            }
            return;
        }// end function

        protected function invalidateCategoryRenderers() : void
        {
            this.m_InvalidCategoryRenderers = true;
            invalidateProperties();
            return;
        }// end function

        public function get dataProvider() : IList
        {
            return this.m_DataProvider;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.backgroundSkin = null;
                this.disabledSkin = null;
                this.highlightSkin = null;
                this.paddingBottom = 1;
                this.paddingLeft = 1;
                this.paddingRight = 1;
                this.paddingTop = 1;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            Selector;
            Decl = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.rendererStyle = "defaultCategoryAppearanceRendererStyle";
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}

package tibia.options.configurationWidgetClasses
{
   import mx.core.UIComponent;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import tibia.chat.MessageMode;
   import mx.controls.dataGridClasses.DataGridListData;
   import mx.events.DataGridEvent;
   import mx.events.ListEvent;
   import mx.controls.listClasses.ListData;
   import mx.controls.List;
   import mx.events.ListEventReason;
   import mx.controls.Tree;
   import mx.controls.DataGrid;
   import mx.events.DataGridEventReason;
   import mx.controls.listClasses.BaseListData;
   import flash.events.MouseEvent;
   import shared.controls.ColourRenderer;
   
   public class MessageModeColourSelector extends UIComponent implements IListItemRenderer, IDropInListItemRenderer
   {
      
      {
         s_InitializeStyle();
      }
      
      private var m_UncommittedColourCode:Boolean = false;
      
      protected var m_ColourCode:int = 0;
      
      protected var m_ListData:BaseListData = null;
      
      private var m_UncommittedData:Boolean = false;
      
      protected var m_Data:Object = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIColourRenderer:Vector.<ColourRenderer>;
      
      private var m_UncommittedListData:Boolean = false;
      
      public function MessageModeColourSelector()
      {
         this.m_UIColourRenderer = new Vector.<ColourRenderer>(MessageMode.MESSAGE_MODE_COLOURS.length,true);
         super();
      }
      
      private static function s_InitializeStyle() : void
      {
         var Selector:String = "MessageModeColourSelector";
         var Decl:CSSStyleDeclaration = StyleManager.getStyleDeclaration(Selector);
         if(Decl == null)
         {
            Decl = new CSSStyleDeclaration(Selector);
         }
         Decl.defaultFactory = function():void
         {
            MessageModeColourSelector.pickerSize = 10;
            MessageModeColourSelector.horizontalGap = 2;
            MessageModeColourSelector.verticalGap = 2;
            MessageModeColourSelector.paddingLeft = 0;
            MessageModeColourSelector.paddingRight = 0;
            MessageModeColourSelector.paddingTop = 0;
            MessageModeColourSelector.paddingBottom = 0;
         };
         StyleManager.setStyleDeclaration(Selector,Decl,true);
      }
      
      public function set colourCode(param1:int) : void
      {
         param1 = Math.max(0,Math.min(param1,MessageMode.MESSAGE_MODE_COLOURS.length - 1));
         if(this.m_ColourCode != param1)
         {
            this.m_ColourCode = param1;
            this.m_UncommittedColourCode = true;
            invalidateProperties();
         }
      }
      
      protected function endEdit() : void
      {
         var _loc2_:DataGridListData = null;
         var _loc3_:DataGridEvent = null;
         var _loc1_:ListEvent = null;
         if(this.m_ListData is ListData && owner is List)
         {
            _loc1_ = new ListEvent(ListEvent.ITEM_EDIT_END,false,true);
            _loc1_.columnIndex = this.m_ListData.columnIndex;
            _loc1_.rowIndex = this.m_ListData.rowIndex;
            _loc1_.reason = ListEventReason.NEW_ROW;
            _loc1_.itemRenderer = (owner as List).editedItemRenderer;
            owner.dispatchEvent(_loc1_);
         }
         else if(this.m_ListData is ListData && owner is Tree)
         {
            _loc1_ = new ListEvent(ListEvent.ITEM_EDIT_END,false,true);
            _loc1_.columnIndex = this.m_ListData.columnIndex;
            _loc1_.rowIndex = this.m_ListData.rowIndex;
            _loc1_.reason = ListEventReason.NEW_ROW;
            _loc1_.itemRenderer = (owner as Tree).editedItemRenderer;
            owner.dispatchEvent(_loc1_);
         }
         else if(this.m_ListData is DataGridListData && owner is DataGrid)
         {
            _loc2_ = this.m_ListData as DataGridListData;
            _loc3_ = new DataGridEvent(DataGridEvent.ITEM_EDIT_END,false,true);
            _loc3_.columnIndex = _loc2_.columnIndex;
            _loc3_.dataField = _loc2_.dataField;
            _loc3_.rowIndex = _loc2_.rowIndex;
            _loc3_.reason = DataGridEventReason.NEW_ROW;
            _loc3_.itemRenderer = (owner as DataGrid).editedItemRenderer;
            owner.dispatchEvent(_loc3_);
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.commitProperties();
         if(this.m_UncommittedData)
         {
            this.m_UncommittedData = false;
         }
         if(this.m_UncommittedListData)
         {
            this.m_UncommittedListData = false;
         }
         if(this.m_UncommittedColourCode)
         {
            _loc1_ = 0;
            _loc2_ = MessageMode.MESSAGE_MODE_COLOURS.length;
            while(_loc1_ < _loc2_)
            {
               if(this.m_UIColourRenderer[_loc1_] != null)
               {
                  this.m_UIColourRenderer[_loc1_].selected = this.m_ColourCode == _loc1_;
               }
               _loc1_++;
            }
            this.m_UncommittedColourCode = false;
         }
      }
      
      public function set listData(param1:BaseListData) : void
      {
         if(this.m_ListData != param1)
         {
            this.m_ListData = param1;
            this.m_UncommittedListData = true;
            invalidateProperties();
            this.updateColourCodeFromData();
         }
      }
      
      public function get colourCode() : int
      {
         return this.m_ColourCode;
      }
      
      protected function updateColourCodeFromData() : void
      {
         var _loc1_:String = null;
         if(this.m_Data is int)
         {
            this.colourCode = int(this.m_Data);
         }
         else if(this.m_ListData is DataGridListData)
         {
            _loc1_ = (this.m_ListData as DataGridListData).dataField;
            if(this.m_Data != null && Boolean(this.m_Data.hasOwnProperty(_loc1_)))
            {
               this.colourCode = int(this.m_Data[_loc1_]);
            }
            else
            {
               this.colourCode = 0;
            }
         }
         else
         {
            this.colourCode = 0;
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:int = 2;
         var _loc2_:int = Math.ceil(MessageMode.MESSAGE_MODE_COLOURS.length / _loc1_);
         var _loc3_:Number = getStyle("pickerSize");
         var _loc4_:Number = getStyle("horizontalGap");
         var _loc5_:Number = getStyle("verticalGap");
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(_loc1_ > 0 && _loc2_ > 0)
         {
            _loc6_ = -_loc4_ + _loc2_ * (_loc3_ + _loc4_);
            _loc7_ = -_loc5_ + _loc1_ * (_loc3_ + _loc5_);
         }
         _loc6_ = _loc6_ + (getStyle("paddingLeft") + getStyle("paddingRight"));
         _loc7_ = _loc7_ + (getStyle("paddingTop") + getStyle("paddingBottom"));
         measuredMinWidth = _loc6_;
         measuredWidth = _loc6_;
         measuredMinHeight = _loc7_;
         measuredHeight = _loc7_;
      }
      
      protected function onColourChange(param1:MouseEvent) : void
      {
         var _loc2_:ColourRenderer = null;
         if(param1 != null && (_loc2_ = param1.currentTarget as ColourRenderer) != null)
         {
            this.m_ColourCode = _loc2_.data;
            this.m_UncommittedColourCode = true;
            invalidateProperties();
            this.endEdit();
         }
      }
      
      public function set data(param1:Object) : void
      {
         if(this.m_Data != param1)
         {
            this.m_Data = param1;
            this.m_UncommittedData = true;
            invalidateProperties();
            this.updateColourCodeFromData();
         }
      }
      
      public function get listData() : BaseListData
      {
         return this.m_ListData;
      }
      
      public function get data() : Object
      {
         return this.m_Data;
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            _loc1_ = 0;
            _loc2_ = MessageMode.MESSAGE_MODE_COLOURS.length;
            while(_loc1_ < _loc2_)
            {
               this.m_UIColourRenderer[_loc1_] = new ColourRenderer();
               this.m_UIColourRenderer[_loc1_].ARGB = MessageMode.MESSAGE_MODE_COLOURS[_loc1_];
               this.m_UIColourRenderer[_loc1_].data = _loc1_;
               this.m_UIColourRenderer[_loc1_].selected = this.m_ColourCode == _loc1_;
               this.m_UIColourRenderer[_loc1_].styleName = this;
               this.m_UIColourRenderer[_loc1_].addEventListener(MouseEvent.CLICK,this.onColourChange);
               addChild(this.m_UIColourRenderer[_loc1_]);
               _loc1_++;
            }
            this.m_UIConstructed = true;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc14_:ColourRenderer = null;
         super.updateDisplayList(param1,param2);
         var _loc3_:int = 2;
         var _loc4_:int = Math.ceil(MessageMode.MESSAGE_MODE_COLOURS.length / _loc3_);
         var _loc5_:Number = getStyle("pickerSize");
         var _loc6_:Number = getStyle("horizontalGap");
         var _loc7_:Number = getStyle("verticalGap");
         var _loc8_:Number = getStyle("paddingLeft") + (param1 - getStyle("paddingLeft") - getStyle("paddingRight") - measuredWidth) / 2;
         var _loc9_:Number = getStyle("paddingTop") + (param2 - getStyle("paddingTop") - getStyle("paddingBottom") - measuredHeight) / 2;
         var _loc10_:Number = 0;
         var _loc11_:Number = _loc9_ - (_loc5_ + _loc7_);
         var _loc12_:int = 0;
         var _loc13_:int = MessageMode.MESSAGE_MODE_COLOURS.length;
         while(_loc12_ < _loc13_)
         {
            if(_loc12_ % _loc4_ == 0)
            {
               _loc10_ = _loc8_;
               _loc11_ = _loc11_ + (_loc5_ + _loc7_);
            }
            _loc14_ = this.m_UIColourRenderer[_loc12_];
            _loc14_.move(_loc10_,_loc11_);
            _loc14_.setActualSize(_loc5_,_loc5_);
            _loc10_ = _loc10_ + (_loc5_ + _loc6_);
            _loc12_++;
         }
      }
   }
}

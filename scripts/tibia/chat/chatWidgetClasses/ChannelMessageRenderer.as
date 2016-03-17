package tibia.chat.chatWidgetClasses
{
   import mx.core.UIComponent;
   import mx.core.IDataRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import flash.text.StyleSheet;
   import mx.core.UITextField;
   import flash.events.Event;
   import tibia.chat.ChannelMessage;
   import flash.geom.Rectangle;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import tibia.chat.ChatWidget;
   import tibia.chat.ns_chat_internal;
   
   public class ChannelMessageRenderer extends UIComponent implements ISelectionProxy, IDataRenderer, IListItemRenderer
   {
      
      private static const TEXT_STYLESHEET:StyleSheet = new StyleSheet();
      
      private static const TEXT_GUTTER:int = 2;
      
      public static const HEIGHT_HINT:int = 14;
      
      {
         s_InitialiseStyleSheet();
      }
      
      protected var m_Label:UITextField = null;
      
      protected var m_Data:ChannelMessage = null;
      
      private var m_UncommittedData:Boolean = false;
      
      public function ChannelMessageRenderer()
      {
         super();
      }
      
      private static function s_InitialiseStyleSheet() : void
      {
         TEXT_STYLESHEET.parseCSS("p {" + "font-family: Verdana;" + "font-size: 10;" + "margin-left: 15;" + "text-indent: -15;" + "}");
      }
      
      public function selectAll() : void
      {
         this.m_Label.setSelection(0,this.m_Label.length);
      }
      
      protected function onLabelScroll(param1:Event) : void
      {
         if(this.m_Label.scrollV > 1)
         {
            this.m_Label.scrollV = 1;
         }
      }
      
      public function getLabel() : String
      {
         if(this.m_Data is ChannelMessage)
         {
            return ChannelMessage(this.m_Data).plainText;
         }
         return "";
      }
      
      public function setSelection(param1:int, param2:int) : void
      {
         this.m_Label.setSelection(param1,param2);
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedData)
         {
            if(this.m_Data != null)
            {
               this.m_Label.htmlText = this.m_Data.htmlText;
            }
            else
            {
               this.m_Label.htmlText = "";
            }
            this.m_Label.setSelection(-1,-1);
            invalidateDisplayList();
            this.m_UncommittedData = false;
         }
      }
      
      public function set data(param1:Object) : void
      {
         this.m_Data = param1 as ChannelMessage;
         this.m_UncommittedData = true;
         invalidateProperties();
      }
      
      public function getCharIndexAtPoint(param1:Number, param2:Number) : int
      {
         var _loc4_:Rectangle = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = this.m_Label.getCharIndexAtPoint(param1,param2);
         if(_loc3_ < 0 && this.m_Label.length > 0)
         {
            _loc4_ = this.m_Label.getCharBoundaries(this.m_Label.length - 1);
            if(_loc4_ == null || param2 >= _loc4_.bottom)
            {
               return this.m_Label.length;
            }
            _loc4_ = this.m_Label.getCharBoundaries(0);
            if(_loc4_ == null || param2 <= _loc4_.y)
            {
               return -1;
            }
            _loc5_ = this.m_Label.getLineIndexAtPoint(_loc4_.left,param2);
            _loc6_ = this.m_Label.getLineOffset(_loc5_);
            _loc7_ = this.m_Label.getLineLength(_loc5_);
            _loc4_ = this.m_Label.getCharBoundaries(_loc6_ + _loc7_ - 1);
            if(_loc4_ == null || param1 >= _loc4_.right)
            {
               return _loc6_ + _loc7_;
            }
            return _loc6_;
         }
         return _loc3_;
      }
      
      override protected function measure() : void
      {
         var _loc1_:Number = NaN;
         super.measure();
         if(!isNaN(explicitWidth))
         {
            this.m_Label.explicitWidth = explicitWidth;
            _loc1_ = this.m_Label.getExplicitOrMeasuredHeight() - 2 * TEXT_GUTTER;
            measuredWidth = explicitWidth;
            measuredHeight = _loc1_;
         }
         else
         {
            measuredWidth = this.m_Label.getExplicitOrMeasuredHeight() - 2 * TEXT_GUTTER;
            measuredHeight = this.m_Label.getExplicitOrMeasuredHeight() - 2 * TEXT_GUTTER;
         }
      }
      
      public function get data() : Object
      {
         return this.m_Data;
      }
      
      public function getCharCount() : int
      {
         if(this.m_Data is ChannelMessage)
         {
            return ChannelMessage(this.m_Data).plainText.length;
         }
         return 0;
      }
      
      protected function onLabelClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:ChatWidget = null;
         if(param1 != null)
         {
            _loc2_ = this.m_Label.getCharIndexAtPoint(param1.localX,param1.localY);
            if(_loc2_ < 0)
            {
               return;
            }
            _loc3_ = this.m_Label.getTextFormat(_loc2_);
            if(_loc3_.url == null)
            {
               return;
            }
            _loc4_ = Tibia.s_GetChatWidget();
            if(_loc4_ != null)
            {
               _loc4_.text = _loc3_.url.substr(6);
               _loc4_.ns_chat_internal::onChatSend();
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         if(this.m_Label != null)
         {
            this.m_Label.move(-TEXT_GUTTER,-TEXT_GUTTER);
            this.m_Label.setActualSize(param1 + 2 * TEXT_GUTTER,param2 + 2 * TEXT_GUTTER);
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(this.m_Label == null)
         {
            this.m_Label = createInFontContext(UITextField) as UITextField;
            this.m_Label.alwaysShowSelection = true;
            this.m_Label.selectable = true;
            this.m_Label.styleSheet = TEXT_STYLESHEET;
            this.m_Label.wordWrap = true;
            this.m_Label.addEventListener(Event.SCROLL,this.onLabelScroll);
            this.m_Label.addEventListener(MouseEvent.CLICK,this.onLabelClick);
            addChild(this.m_Label);
         }
      }
      
      public function clearSelection() : void
      {
         this.m_Label.setSelection(-1,-1);
      }
   }
}

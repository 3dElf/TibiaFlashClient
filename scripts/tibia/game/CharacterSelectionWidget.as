package tibia.game
{
   import flash.events.TimerEvent;
   import mx.events.CloseEvent;
   import flash.events.MouseEvent;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.mx_internal;
   import shared.controls.CustomList;
   import mx.events.ListEvent;
   import mx.controls.List;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class CharacterSelectionWidget extends PopUpBase
   {
      
      private static const BUNDLE:String = "CharacterSelectionWidget";
      
      public static const TIMEOUT_EXPIRED:int = 2147483647;
      
      private static const CLOSE_TIMEOUT:Number = 60 * 1000;
       
      private var m_SelectedCharacter:int = -1;
      
      private var m_UncommittedCharacters:Boolean = false;
      
      private var m_UIList:List = null;
      
      private var m_Characters:Array = null;
      
      private var m_Timeout:Timer = null;
      
      private var m_UIConstructed:Boolean = false;
      
      private var m_UncommittedSelectedCharacter:Boolean = false;
      
      public function CharacterSelectionWidget()
      {
         super();
         height = 310;
         width = 350;
         buttonFlags = PopUpBase.BUTTON_CANCEL | PopUpBase.BUTTON_OKAY;
         title = resourceManager.getString(BUNDLE,"TITLE");
         addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyboardDown);
         if(!Tibia.s_GetInstance().isRunning)
         {
            this.m_Timeout = new Timer(CLOSE_TIMEOUT,1);
            this.m_Timeout.addEventListener(TimerEvent.TIMER,this.onTimeout);
            this.m_Timeout.start();
         }
      }
      
      override public function hide(param1:Boolean = false) : void
      {
         if(this.m_Timeout != null)
         {
            this.m_Timeout.stop();
         }
         super.hide(param1);
      }
      
      private function scrollToSelectedCharacter() : void
      {
         if(this.m_UIList != null)
         {
            this.m_UIList.validateNow();
            this.m_UIList.scrollToIndex(this.m_SelectedCharacter);
         }
      }
      
      private function onTimeout(param1:TimerEvent) : void
      {
         var _loc2_:CloseEvent = null;
         if(param1 != null)
         {
            _loc2_ = new CloseEvent(CloseEvent.CLOSE,true,false);
            _loc2_.detail = TIMEOUT_EXPIRED;
            dispatchEvent(_loc2_);
            if(!_loc2_.cancelable || !_loc2_.isDefaultPrevented())
            {
               this.hide(false);
            }
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedCharacters)
         {
            if(this.m_Characters != null)
            {
               this.m_Characters.sortOn("name");
            }
            this.m_UIList.dataProvider = this.m_Characters;
            this.m_UncommittedCharacters = false;
         }
         if(this.m_UncommittedSelectedCharacter)
         {
            this.m_UIList.selectedIndex = this.m_SelectedCharacter;
            if(this.m_Timeout != null)
            {
               this.m_Timeout.stop();
               this.m_Timeout.reset();
               this.m_Timeout.start();
            }
            callLater(this.scrollToSelectedCharacter,null);
            this.m_UncommittedSelectedCharacter = false;
         }
      }
      
      public function get selectedCharacter() : int
      {
         return this.m_SelectedCharacter;
      }
      
      public function set characters(param1:Array) : void
      {
         if(this.m_Characters != param1)
         {
            this.m_Characters = param1;
            this.m_UncommittedCharacters = true;
            invalidateProperties();
            this.selectedCharacter = -1;
         }
      }
      
      private function buildCharacterLabel(param1:Object) : String
      {
         return AccountCharacter(param1).name + " (" + AccountCharacter(param1).world + ")";
      }
      
      private function onListDoubleClick(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:CloseEvent = null;
         if(param1 != null)
         {
            _loc2_ = this.m_UIList.mx_internal::mouseEventToItemRendererOrEditor(param1);
            if(_loc2_ != null)
            {
               _loc3_ = new CloseEvent(CloseEvent.CLOSE,false,true);
               _loc3_.detail = PopUpBase.BUTTON_OKAY;
               dispatchEvent(_loc3_);
            }
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIList = new CustomList();
            this.m_UIList.doubleClickEnabled = true;
            this.m_UIList.labelFunction = this.buildCharacterLabel;
            this.m_UIList.percentWidth = 100;
            this.m_UIList.percentHeight = 100;
            this.m_UIList.addEventListener(ListEvent.CHANGE,this.onListChange);
            this.m_UIList.addEventListener(MouseEvent.DOUBLE_CLICK,this.onListDoubleClick);
            addChild(this.m_UIList);
            this.m_UIConstructed = true;
         }
      }
      
      public function set selectedCharacter(param1:int) : void
      {
         if(this.m_Characters != null)
         {
            param1 = Math.max(-1,Math.min(param1,this.m_Characters.length - 1));
         }
         else
         {
            param1 = -1;
         }
         if(this.m_SelectedCharacter != param1)
         {
            this.m_SelectedCharacter = param1;
            this.m_UncommittedSelectedCharacter = true;
            invalidateProperties();
         }
      }
      
      private function onKeyboardDown(param1:KeyboardEvent) : void
      {
         if(param1 != null)
         {
            switch(param1.keyCode)
            {
               case Keyboard.DOWN:
                  this.selectedCharacter = this.selectedCharacter + 1;
                  break;
               case Keyboard.UP:
                  this.selectedCharacter = Math.max(0,this.selectedCharacter - 1);
            }
         }
      }
      
      public function get characters() : Array
      {
         return this.m_Characters;
      }
      
      private function onListChange(param1:ListEvent) : void
      {
         if(param1 != null)
         {
            this.selectedCharacter = this.m_UIList.selectedIndex;
         }
      }
   }
}

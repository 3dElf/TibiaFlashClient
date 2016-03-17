package tibia.options.configurationWidgetClasses
{
   import mx.containers.VBox;
   import tibia.options.OptionsStorage;
   import mx.controls.CheckBox;
   import shared.controls.EmbeddedDialog;
   import tibia.game.PopUpBase;
   import mx.events.CloseEvent;
   import mx.core.EventPriority;
   import tibia.options.ConfigurationWidget;
   import flash.events.MouseEvent;
   import mx.containers.Form;
   import mx.containers.FormHeading;
   import mx.containers.FormItem;
   import flash.events.Event;
   import mx.containers.FormItemDirection;
   import mx.controls.Button;
   
   public class GeneralOptions extends VBox implements IOptionsEditor
   {
      
      private static const DIALOG_OPTIONS_RESET:int = 1;
      
      private static const DIALOG_NONE:int = 0;
       
      protected var m_UIInputClassicControls:CheckBox = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var m_UncommittedValues:Boolean = true;
      
      protected var m_UIResetAllOptions:Button = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIAutoChaseOff:CheckBox = null;
      
      protected var m_Options:OptionsStorage = null;
      
      public function GeneralOptions()
      {
         super();
         label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_LABEL");
      }
      
      public function set options(param1:OptionsStorage) : void
      {
         this.m_Options = param1;
         this.m_UncommittedOptions = true;
         invalidateProperties();
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedOptions)
         {
            if(this.m_Options != null)
            {
               this.m_UIInputClassicControls.selected = this.m_Options.generalInputClassicControls;
               this.m_UIAutoChaseOff.selected = this.m_Options.combatAutoChaseOff;
            }
            else
            {
               this.m_UIInputClassicControls.selected = false;
               this.m_UIAutoChaseOff.selected = false;
            }
            this.m_UncommittedOptions = false;
         }
      }
      
      private function showEmbeddedDialog(param1:int, param2:String = null) : void
      {
         var _loc3_:EmbeddedDialog = null;
         if(param1 != DIALOG_NONE && (_loc3_ = PopUpBase.s_GetInstance().embeddedDialog) == null)
         {
            _loc3_ = new EmbeddedDialog();
            _loc3_.addEventListener(CloseEvent.CLOSE,this.onCloseEmbeddedDialog,false,EventPriority.DEFAULT,true);
         }
         if(_loc3_ != null)
         {
            _loc3_.data = param1;
         }
         switch(param1)
         {
            case DIALOG_OPTIONS_RESET:
               _loc3_.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_OPTIONS_DLG_RESET_TITLE");
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_OPTIONS_DLG_RESET_TEXT");
         }
         PopUpBase.s_GetInstance().embeddedDialog = _loc3_;
      }
      
      private function onButtonClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.m_UIResetAllOptions)
         {
            this.showEmbeddedDialog(DIALOG_OPTIONS_RESET);
         }
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:Form = null;
         var _loc2_:FormHeading = null;
         var _loc3_:FormItem = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            _loc1_ = new Form();
            _loc1_.styleName = "optionsConfigurationWidgetRootContainer";
            _loc2_ = new FormHeading();
            _loc2_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_GENERAL_HEADING");
            _loc2_.percentHeight = NaN;
            _loc2_.percentWidth = 100;
            _loc1_.addChild(_loc2_);
            _loc3_ = new FormItem();
            _loc3_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_GENERAL_CLASSIC_CONTROLS");
            _loc3_.percentHeight = NaN;
            _loc3_.percentWidth = 100;
            this.m_UIInputClassicControls = new CheckBox();
            this.m_UIInputClassicControls.addEventListener(Event.CHANGE,this.onValueChange);
            _loc3_.addChild(this.m_UIInputClassicControls);
            _loc1_.addChild(_loc3_);
            _loc2_ = new FormHeading();
            _loc2_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_COMBAT_HEADING");
            _loc2_.percentHeight = NaN;
            _loc2_.percentWidth = 100;
            _loc1_.addChild(_loc2_);
            _loc3_ = new FormItem();
            _loc3_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_COMBAT_AUTOCHASEOFF");
            _loc3_.percentHeight = NaN;
            _loc3_.percentWidth = 100;
            this.m_UIAutoChaseOff = new CheckBox();
            this.m_UIAutoChaseOff.addEventListener(Event.CHANGE,this.onValueChange);
            _loc3_.addChild(this.m_UIAutoChaseOff);
            _loc1_.addChild(_loc3_);
            addChild(_loc1_);
            _loc2_ = new FormHeading();
            _loc2_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_OPTIONS_RESET_HEADING");
            _loc2_.percentHeight = NaN;
            _loc2_.percentWidth = 100;
            _loc1_.addChild(_loc2_);
            _loc3_ = new FormItem();
            _loc3_.direction = FormItemDirection.VERTICAL;
            _loc3_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_OPTIONS_RESET_LABEL");
            this.m_UIResetAllOptions = new Button();
            this.m_UIResetAllOptions.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_OPTIONS_RESET");
            this.m_UIResetAllOptions.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            _loc3_.addChild(this.m_UIResetAllOptions);
            _loc1_.addChild(_loc3_);
            addChild(_loc1_);
            this.m_UIConstructed = true;
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      private function onValueChange(param1:Event) : void
      {
         var _loc2_:OptionsEditorEvent = null;
         if(param1 != null)
         {
            _loc2_ = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
            dispatchEvent(_loc2_);
         }
      }
      
      private function onCloseEmbeddedDialog(param1:CloseEvent) : void
      {
         var _loc3_:ConfigurationWidget = null;
         var _loc4_:OptionsEditorEvent = null;
         var _loc2_:EmbeddedDialog = param1.currentTarget as EmbeddedDialog;
         if(_loc2_.data === DIALOG_OPTIONS_RESET)
         {
            if(param1.detail == EmbeddedDialog.YES)
            {
               this.m_Options.reset();
               _loc3_ = PopUpBase.s_GetParentPopUp(this) as ConfigurationWidget;
               if(_loc3_ != null)
               {
                  _loc3_.options = _loc3_.options;
               }
               _loc4_ = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
               dispatchEvent(_loc4_);
            }
         }
      }
      
      public function close(param1:Boolean = false) : void
      {
         if(this.m_Options != null && Boolean(param1) && Boolean(this.m_UncommittedValues))
         {
            this.m_Options.generalInputClassicControls = this.m_UIInputClassicControls.selected;
            this.m_Options.combatAutoChaseOff = this.m_UIAutoChaseOff.selected;
            this.m_UncommittedValues = false;
         }
      }
   }
}

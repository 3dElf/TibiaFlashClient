package tibia.options.configurationWidgetClasses
{
   import mx.containers.VBox;
   import mx.controls.CheckBox;
   import flash.events.Event;
   import tibia.options.OptionsStorage;
   import mx.containers.Form;
   import mx.containers.FormHeading;
   import mx.containers.FormItem;
   import tibia.options.ConfigurationWidget;
   
   public class GeneralOptions extends VBox implements IOptionsEditor
   {
       
      protected var m_UIInputClassicControls:CheckBox = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      private var m_UncommittedValues:Boolean = true;
      
      protected var m_UIAutoChaseOff:CheckBox = null;
      
      protected var m_Options:OptionsStorage = null;
      
      public function GeneralOptions()
      {
         super();
         label = resourceManager.getString(ConfigurationWidget.BUNDLE,"GENERAL_LABEL");
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
      
      public function set options(param1:OptionsStorage) : void
      {
         if(this.m_Options != param1)
         {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
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
            this.m_UIConstructed = true;
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
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

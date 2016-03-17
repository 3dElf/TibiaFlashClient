package tibia.options.configurationWidgetClasses
{
   import mx.containers.VBox;
   import tibia.controls.CustomSlider;
   import mx.core.IContainer;
   import mx.controls.CheckBox;
   import mx.containers.Form;
   import mx.containers.FormHeading;
   import mx.containers.FormItem;
   import tibia.options.ConfigurationWidget;
   import flash.events.Event;
   import mx.events.SliderEvent;
   import tibia.options.OptionsStorage;
   
   public class RendererOptions extends VBox implements IOptionsEditor
   {
       
      protected var m_UIAmbientBrightness:CustomSlider = null;
      
      protected var m_UILevelSeparator:CustomSlider = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      protected var m_UILightEnabled:CheckBox = null;
      
      private var m_UncommittedValues:Boolean = true;
      
      protected var m_UIShowFrameRate:CheckBox = null;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_UIMaxFrameRate:CustomSlider = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIScaleMap:CheckBox = null;
      
      public function RendererOptions()
      {
         super();
         label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_LABEL");
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedOptions)
         {
            if(this.m_Options != null)
            {
               this.m_UIAmbientBrightness.value = 100 * this.m_Options.rendererAmbientBrightness;
               this.m_UILevelSeparator.value = 100 * this.m_Options.rendererLevelSeparator;
               this.m_UILightEnabled.selected = this.m_Options.rendererLightEnabled;
               this.m_UIScaleMap.selected = this.m_Options.rendererScaleMap;
               this.m_UIMaxFrameRate.value = this.m_Options.rendererMaxFrameRate;
               this.m_UIShowFrameRate.selected = this.m_Options.rendererShowFrameRate;
            }
            else
            {
               this.m_UIAmbientBrightness.value = 0;
               this.m_UILevelSeparator.value = 0;
               this.m_UILightEnabled.selected = false;
               this.m_UIScaleMap.selected = false;
               this.m_UIMaxFrameRate.value = 0;
               this.m_UIShowFrameRate.selected = false;
            }
            IContainer(this.m_UIAmbientBrightness.parent).enabled = this.m_UILightEnabled.selected;
            IContainer(this.m_UILevelSeparator.parent).enabled = this.m_UILightEnabled.selected;
            this.m_UncommittedOptions = false;
         }
      }
      
      override protected function createChildren() : void
      {
         var Frm:Form = null;
         var Heading:FormHeading = null;
         var Item:FormItem = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            Frm = new Form();
            Frm.styleName = "optionsConfigurationWidgetRootContainer";
            Heading = new FormHeading();
            Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_LIGHT_HEADING");
            Heading.percentHeight = NaN;
            Heading.percentWidth = 100;
            Frm.addChild(Heading);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_LIGHT_ENABLED");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UILightEnabled = new CheckBox();
            this.m_UILightEnabled.addEventListener(Event.CHANGE,function(param1:Event):void
            {
               IContainer(m_UIAmbientBrightness.parent).enabled = m_UILightEnabled.selected;
               IContainer(m_UILevelSeparator.parent).enabled = m_UILightEnabled.selected;
            });
            this.m_UILightEnabled.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UILightEnabled);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_LIGHT_AMBIENT_BRIGHTNESS");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIAmbientBrightness = new CustomSlider();
            this.m_UIAmbientBrightness.minimum = 0;
            this.m_UIAmbientBrightness.maximum = 100;
            this.m_UIAmbientBrightness.snapInterval = 1;
            this.m_UIAmbientBrightness.percentWidth = 100;
            this.m_UIAmbientBrightness.addEventListener(SliderEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIAmbientBrightness);
            Item.setStyle("disabledOverlayAlpha",0);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_LIGHT_LEVEL_SEPARATOR");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UILevelSeparator = new CustomSlider();
            this.m_UILevelSeparator.minimum = 0;
            this.m_UILevelSeparator.maximum = 100;
            this.m_UILevelSeparator.snapInterval = 1;
            this.m_UILevelSeparator.percentWidth = 100;
            this.m_UILevelSeparator.addEventListener(SliderEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UILevelSeparator);
            Item.setStyle("disabledOverlayAlpha",0);
            Frm.addChild(Item);
            Heading = new FormHeading();
            Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_MAP_HEADING");
            Heading.percentHeight = NaN;
            Heading.percentWidth = 100;
            Frm.addChild(Heading);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_MAP_SCALE");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIScaleMap = new CheckBox();
            this.m_UIScaleMap.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIScaleMap);
            Frm.addChild(Item);
            Heading = new FormHeading();
            Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_PERF_HEADING");
            Heading.percentHeight = NaN;
            Heading.percentWidth = 100;
            Frm.addChild(Heading);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_PERF_MAX_FPS");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIMaxFrameRate = new CustomSlider();
            this.m_UIMaxFrameRate.minimum = 10;
            this.m_UIMaxFrameRate.maximum = 60;
            this.m_UIMaxFrameRate.snapInterval = 1;
            this.m_UIMaxFrameRate.liveDragging = true;
            this.m_UIMaxFrameRate.percentWidth = 100;
            this.m_UIMaxFrameRate.addEventListener(SliderEvent.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIMaxFrameRate);
            Frm.addChild(Item);
            Item = new FormItem();
            Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"RENDERER_PERF_SHOW_FPS");
            Item.percentHeight = NaN;
            Item.percentWidth = 100;
            this.m_UIShowFrameRate = new CheckBox();
            this.m_UIShowFrameRate.addEventListener(Event.CHANGE,this.onValueChange);
            Item.addChild(this.m_UIShowFrameRate);
            Frm.addChild(Item);
            addChild(Frm);
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
      
      public function set options(param1:OptionsStorage) : void
      {
         if(this.m_Options != param1)
         {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
         }
      }
      
      public function close(param1:Boolean = false) : void
      {
         if(this.m_Options != null && Boolean(param1) && Boolean(this.m_UncommittedValues))
         {
            this.m_Options.rendererAmbientBrightness = this.m_UIAmbientBrightness.value / 100;
            this.m_Options.rendererLevelSeparator = this.m_UILevelSeparator.value / 100;
            this.m_Options.rendererLightEnabled = this.m_UILightEnabled.selected;
            this.m_Options.rendererScaleMap = this.m_UIScaleMap.selected;
            this.m_Options.rendererMaxFrameRate = this.m_UIMaxFrameRate.value;
            this.m_Options.rendererShowFrameRate = this.m_UIShowFrameRate.selected;
            this.m_UncommittedValues = false;
         }
      }
   }
}

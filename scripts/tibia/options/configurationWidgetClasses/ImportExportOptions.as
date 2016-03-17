package tibia.options.configurationWidgetClasses
{
   import mx.containers.VBox;
   import mx.controls.Button;
   import flash.events.Event;
   import tibia.minimap.MiniMapStorage;
   import flash.system.System;
   import flash.events.MouseEvent;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.ProgressEvent;
   import shared.utility.FileReferenceWrapper;
   import flash.events.IOErrorEvent;
   import mx.containers.Form;
   import mx.containers.FormHeading;
   import mx.containers.FormItem;
   import tibia.options.ConfigurationWidget;
   import mx.containers.FormItemDirection;
   import tibia.options.OptionsStorage;
   import flash.utils.ByteArray;
   import tibia.game.PopUpBase;
   import mx.events.CloseEvent;
   import shared.controls.EmbeddedDialog;
   import tibia.creatures.BuddySet;
   import flash.net.FileReference;
   import mx.core.EventPriority;
   
   public class ImportExportOptions extends VBox implements IOptionsEditor
   {
      
      private static const DIALOG_OPTIONS_IMPORT_FAIL:int = 1;
      
      private static const DIALOG_MINIMAP_IMPORT_PROGRESS:int = 7;
      
      private static const DIALOG_ERROR_READ:int = 10;
      
      private static const DIALOG_NONE:int = 0;
      
      private static const DIALOG_OPTIONS_EXPORT_FAIL:int = 2;
      
      private static const DIALOG_ERROR_WRITE:int = 11;
      
      private static const DIALOG_ERROR_CONCURRENT:int = 9;
      
      private static const DIALOG_MINIMAP_EXPORT_PROGRESS:int = 5;
      
      private static const DIALOG_MINIMAP_EXPORT_SAVE:int = 4;
      
      private static const DIALOG_MINIMAP_EXPORT_FAIL:int = 6;
      
      private static const DIALOG_OPTIONS_RESET:int = 3;
      
      private static const DIALOG_MINIMAP_IMPORT_FAIL:int = 8;
       
      private var m_UIButtonMiniMapExport:Button = null;
      
      private var m_Options:OptionsStorage = null;
      
      private var m_File:FileReference = null;
      
      private var m_UIConstructed:Boolean = false;
      
      private var m_EmbeddedDialogID:int = 0;
      
      private var m_UIButtonOptionsImport:Button = null;
      
      private var m_UncommittedOptions:Boolean = false;
      
      private var m_MiniMapData:ByteArray = null;
      
      private var m_UIButtonOptionsExport:Button = null;
      
      private var m_UIButtonOptionsReset:Button = null;
      
      private var m_UIButtonMiniMapImport:Button = null;
      
      public function ImportExportOptions()
      {
         super();
         label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_LABEL");
         addEventListener(OptionsEditorEvent.VALUE_CHANGE,this.onValueChange);
      }
      
      private function onExportOptionsComplete(param1:Event) : void
      {
         if(param1 != null && this.m_File != null)
         {
            this.removeFileListeners();
            this.m_File = null;
            this.showEmbeddedDialog(DIALOG_NONE);
         }
      }
      
      private function onImportMiniMapError(param1:Event) : void
      {
         if(param1 != null)
         {
            this.removeFileListeners();
            this.m_File = null;
            this.removeMiniMapListeners();
            this.m_UIButtonMiniMapExport.enabled = true;
            this.showEmbeddedDialog(DIALOG_MINIMAP_IMPORT_FAIL);
         }
      }
      
      private function onImportOptionsError(param1:Event) : void
      {
         if(param1 != null && this.m_File != null)
         {
            this.removeFileListeners();
            this.m_File = null;
            this.showEmbeddedDialog(DIALOG_OPTIONS_IMPORT_FAIL);
         }
      }
      
      public function close(param1:Boolean = false) : void
      {
         removeEventListener(OptionsEditorEvent.VALUE_CHANGE,this.onValueChange);
         this.removeFileListeners();
         this.m_File = null;
         this.removeMiniMapListeners();
         this.m_MiniMapData = null;
         var _loc2_:MiniMapStorage = Tibia.s_GetMiniMapStorage();
         if(_loc2_ != null)
         {
            _loc2_.cancelImportExport();
         }
         System.pauseForGCIfCollectionImminent(0.5);
      }
      
      private function onExportMiniMapError(param1:Event) : void
      {
         if(param1 != null)
         {
            this.removeFileListeners();
            this.m_File = null;
            this.removeMiniMapListeners();
            this.m_MiniMapData = null;
            this.showEmbeddedDialog(DIALOG_MINIMAP_EXPORT_FAIL);
         }
      }
      
      private function onButtonClick(param1:MouseEvent) : void
      {
         var _MiniMapStorage:MiniMapStorage = null;
         var XMLString:String = null;
         var a_Event:MouseEvent = param1;
         if(a_Event.currentTarget == this.m_UIButtonMiniMapExport)
         {
            _MiniMapStorage = Tibia.s_GetMiniMapStorage();
            if(_MiniMapStorage != null)
            {
               try
               {
                  this.m_MiniMapData = _MiniMapStorage.exportMiniMap();
                  _MiniMapStorage.addEventListener(Event.COMPLETE,this.onExportMiniMapSave);
                  _MiniMapStorage.addEventListener(ErrorEvent.ERROR,this.onExportMiniMapError);
                  _MiniMapStorage.addEventListener(ProgressEvent.PROGRESS,this.onExportMiniMapProgress);
               }
               catch(_Error:*)
               {
                  m_MiniMapData = null;
                  showEmbeddedDialog(DIALOG_MINIMAP_EXPORT_FAIL);
               }
            }
         }
         else if(a_Event.currentTarget == this.m_UIButtonMiniMapImport)
         {
            this.showEmbeddedDialog(DIALOG_MINIMAP_IMPORT_PROGRESS,"0");
            try
            {
               this.m_File = new FileReferenceWrapper();
               this.m_File.browse();
               this.m_File.addEventListener(Event.SELECT,this.onImportMiniMapSelect);
               this.m_File.addEventListener(Event.CANCEL,this.onImportMiniMapSelect);
            }
            catch(_Error:IllegalOperationError)
            {
               m_File = null;
               showEmbeddedDialog(DIALOG_ERROR_CONCURRENT);
            }
            catch(_Error:*)
            {
               m_File = null;
               showEmbeddedDialog(DIALOG_ERROR_READ);
            }
         }
         else if(a_Event.currentTarget == this.m_UIButtonOptionsExport)
         {
            if(this.m_Options != null)
            {
               try
               {
                  XMLString = this.m_Options.marshall().toXMLString();
                  this.m_File = new FileReferenceWrapper();
                  this.m_File.save(XMLString,"tibia_options.dat");
                  this.m_File.addEventListener(Event.COMPLETE,this.onExportOptionsComplete);
                  this.m_File.addEventListener(Event.CANCEL,this.onExportOptionsComplete);
                  this.m_File.addEventListener(IOErrorEvent.IO_ERROR,this.onExportOptionsError);
               }
               catch(_Error:IllegalOperationError)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_CONCURRENT);
               }
               catch(_Error:*)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_WRITE);
               }
            }
         }
         else if(a_Event.currentTarget == this.m_UIButtonOptionsImport)
         {
            try
            {
               this.m_File = new FileReferenceWrapper();
               this.m_File.browse();
               this.m_File.addEventListener(Event.SELECT,this.onImportOptionsSelect);
               this.m_File.addEventListener(Event.CANCEL,this.onImportOptionsSelect);
            }
            catch(_Error:IllegalOperationError)
            {
               m_File = null;
               showEmbeddedDialog(DIALOG_ERROR_CONCURRENT);
            }
            catch(_Error:*)
            {
               m_File = null;
               showEmbeddedDialog(DIALOG_ERROR_READ);
            }
         }
         else if(a_Event.currentTarget == this.m_UIButtonOptionsReset)
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
            _loc1_.setStyle("indicatorGap",0);
            _loc1_.setStyle("labelWidth",0);
            _loc2_ = new FormHeading();
            _loc2_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_HEADING");
            _loc2_.percentHeight = NaN;
            _loc2_.percentWidth = 100;
            _loc1_.addChild(_loc2_);
            _loc3_ = new FormItem();
            _loc3_.direction = FormItemDirection.VERTICAL;
            _loc3_.percentHeight = NaN;
            _loc3_.percentWidth = 100;
            this.m_UIButtonOptionsImport = new Button();
            this.m_UIButtonOptionsImport.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_IMPORT");
            this.m_UIButtonOptionsImport.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            _loc3_.addChild(this.m_UIButtonOptionsImport);
            this.m_UIButtonOptionsExport = new Button();
            this.m_UIButtonOptionsExport.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_EXPORT");
            this.m_UIButtonOptionsExport.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            _loc3_.addChild(this.m_UIButtonOptionsExport);
            this.m_UIButtonOptionsReset = new Button();
            this.m_UIButtonOptionsReset.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_RESET");
            this.m_UIButtonOptionsReset.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            _loc3_.addChild(this.m_UIButtonOptionsReset);
            _loc1_.addChild(_loc3_);
            _loc2_ = new FormHeading();
            _loc2_.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_HEADING");
            _loc2_.percentHeight = NaN;
            _loc2_.percentWidth = 100;
            _loc1_.addChild(_loc2_);
            _loc3_ = new FormItem();
            _loc3_.direction = FormItemDirection.VERTICAL;
            _loc3_.percentHeight = NaN;
            _loc3_.percentWidth = 100;
            this.m_UIButtonMiniMapImport = new Button();
            this.m_UIButtonMiniMapImport.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_IMPORT");
            this.m_UIButtonMiniMapImport.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            _loc3_.addChild(this.m_UIButtonMiniMapImport);
            this.m_UIButtonMiniMapExport = new Button();
            this.m_UIButtonMiniMapExport.label = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_EXPORT");
            this.m_UIButtonMiniMapExport.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            _loc3_.addChild(this.m_UIButtonMiniMapExport);
            _loc1_.addChild(_loc3_);
            addChild(_loc1_);
            this.m_UIConstructed = true;
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      private function onImportMiniMapLoad(param1:Event) : void
      {
         var _MiniMapStorage:MiniMapStorage = null;
         var a_Event:Event = param1;
         if(a_Event != null && this.m_File != null)
         {
            this.removeMiniMapListeners();
            _MiniMapStorage = Tibia.s_GetMiniMapStorage();
            if(_MiniMapStorage != null)
            {
               try
               {
                  _MiniMapStorage.importMiniMap(this.m_File.data as ByteArray);
                  _MiniMapStorage.addEventListener(ErrorEvent.ERROR,this.onImportMiniMapError);
                  _MiniMapStorage.addEventListener(Event.COMPLETE,this.onImportMiniMapComplete);
                  _MiniMapStorage.addEventListener(ProgressEvent.PROGRESS,this.onImportMiniMapProgress);
               }
               catch(_Error:*)
               {
                  showEmbeddedDialog(DIALOG_MINIMAP_IMPORT_FAIL);
               }
            }
            this.removeFileListeners();
            this.m_File = null;
         }
      }
      
      private function onImportOptionsLoad(param1:Event) : void
      {
         var Bytes:ByteArray = null;
         var XMLString:String = null;
         var Options:OptionsStorage = null;
         var _Widget:ConfigurationWidget = null;
         var _Event:OptionsEditorEvent = null;
         var a_Event:Event = param1;
         if(a_Event != null && this.m_File != null)
         {
            try
            {
               Bytes = this.m_File.data;
               XMLString = Bytes.readUTFBytes(Bytes.bytesAvailable);
               Options = new OptionsStorage();
               Options.unmarshall(XMLString);
               _Widget = PopUpBase.s_GetParentPopUp(this) as ConfigurationWidget;
               if(_Widget != null)
               {
                  _Widget.options = Options;
               }
               _Event = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
               dispatchEvent(_Event);
               this.showEmbeddedDialog(DIALOG_NONE);
               return;
            }
            catch(_Error:*)
            {
               showEmbeddedDialog(DIALOG_OPTIONS_IMPORT_FAIL);
               return;
            }
            finally
            {
               this.removeFileListeners();
               this.m_File = null;
            }
         }
      }
      
      private function onValueChange(param1:OptionsEditorEvent) : void
      {
         if(param1 != null)
         {
            this.m_UIButtonOptionsExport.enabled = false;
         }
      }
      
      private function onExportOptionsError(param1:Event) : void
      {
         if(param1 != null && this.m_File != null)
         {
            this.removeFileListeners();
            this.m_File = null;
            this.showEmbeddedDialog(DIALOG_OPTIONS_EXPORT_FAIL);
         }
      }
      
      private function onCloseEmbeddedDialog(param1:CloseEvent) : void
      {
         var Options:OptionsStorage = null;
         var _BuddySet:BuddySet = null;
         var _Widget:ConfigurationWidget = null;
         var _Event:OptionsEditorEvent = null;
         var a_Event:CloseEvent = param1;
         var d:EmbeddedDialog = a_Event.currentTarget as EmbeddedDialog;
         var _MiniMapStorage:MiniMapStorage = Tibia.s_GetMiniMapStorage();
         if(d.data === DIALOG_MINIMAP_EXPORT_PROGRESS)
         {
            this.removeMiniMapListeners();
            this.m_MiniMapData = null;
            if(_MiniMapStorage != null)
            {
               _MiniMapStorage.cancelImportExport();
            }
         }
         else if(d.data === DIALOG_MINIMAP_IMPORT_PROGRESS)
         {
            this.removeFileListeners();
            if(this.m_File != null)
            {
               this.m_File.cancel();
               this.m_File = null;
            }
            this.removeMiniMapListeners();
            if(_MiniMapStorage != null)
            {
               _MiniMapStorage.cancelImportExport();
            }
         }
         else if(d.data === DIALOG_MINIMAP_EXPORT_SAVE)
         {
            if(a_Event.detail == EmbeddedDialog.YES)
            {
               try
               {
                  this.m_File = new FileReferenceWrapper();
                  this.m_File.save(this.m_MiniMapData,"tibia_minimap.dat");
                  this.m_File.addEventListener(Event.COMPLETE,this.onExportMiniMapComplete);
                  this.m_File.addEventListener(Event.CANCEL,this.onExportMiniMapComplete);
                  this.m_File.addEventListener(IOErrorEvent.IO_ERROR,this.onExportMiniMapError);
               }
               catch(_Error:IllegalOperationError)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_CONCURRENT);
               }
               catch(_Error:*)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_WRITE);
               }
            }
            this.removeMiniMapListeners();
            this.m_MiniMapData = null;
         }
         else if(d.data === DIALOG_OPTIONS_RESET)
         {
            if(a_Event.detail == EmbeddedDialog.YES)
            {
               Options = new OptionsStorage();
               _BuddySet = null;
               if(this.m_Options != null && (_BuddySet = this.m_Options.getBuddySet(BuddySet.DEFAULT_SET)) != null)
               {
                  Options.addBuddySet(_BuddySet.clone());
               }
               _Widget = PopUpBase.s_GetParentPopUp(this) as ConfigurationWidget;
               if(_Widget != null)
               {
                  _Widget.options = Options;
               }
               _Event = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
               dispatchEvent(_Event);
            }
         }
      }
      
      private function onExportMiniMapSave(param1:Event) : void
      {
         if(param1 != null)
         {
            this.removeMiniMapListeners();
            this.showEmbeddedDialog(DIALOG_MINIMAP_EXPORT_SAVE);
         }
      }
      
      private function onImportOptionsSelect(param1:Event) : void
      {
         var a_Event:Event = param1;
         if(a_Event != null && this.m_File != null)
         {
            this.removeFileListeners();
            if(a_Event.type == Event.SELECT)
            {
               try
               {
                  this.m_File.load();
                  this.m_File.addEventListener(Event.COMPLETE,this.onImportOptionsLoad);
                  this.m_File.addEventListener(IOErrorEvent.IO_ERROR,this.onImportOptionsError);
               }
               catch(_Error:IllegalOperationError)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_CONCURRENT);
               }
               catch(_Error:*)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_READ);
               }
            }
            else
            {
               this.m_File = null;
            }
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
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedOptions)
         {
            this.m_UncommittedOptions = false;
         }
      }
      
      private function onImportMiniMapProgress(param1:ProgressEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         if(param1 != null)
         {
            _loc2_ = "0";
            _loc3_ = Math.round(100 * param1.bytesLoaded / param1.bytesTotal);
            if(_loc3_ >= 1)
            {
               _loc2_ = _loc3_.toFixed(0);
            }
            this.showEmbeddedDialog(DIALOG_MINIMAP_IMPORT_PROGRESS,_loc2_);
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
            case DIALOG_ERROR_CONCURRENT:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_ERROR_DLG_CONCURRENT_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_ERROR_DLG_CONCURRENT_TITLE");
               break;
            case DIALOG_ERROR_READ:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_ERROR_DLG_READ_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_ERROR_DLG_READ_TITLE");
               break;
            case DIALOG_ERROR_WRITE:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_ERROR_DLG_WRITE_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_ERROR_DLG_WRITE_TITLE");
               break;
            case DIALOG_MINIMAP_EXPORT_FAIL:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_EXPORT_FAIL_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_EXPORT_FAIL_TITLE");
               break;
            case DIALOG_MINIMAP_EXPORT_PROGRESS:
               _loc3_.buttonFlags = EmbeddedDialog.CANCEL;
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_EXPORT_PROGRESS_TITLE");
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_EXPORT_PROGRESS_TEXT",[param2]);
               break;
            case DIALOG_MINIMAP_EXPORT_SAVE:
               _loc3_.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_EXPORT_SAVE_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_EXPORT_SAVE_TITLE");
               break;
            case DIALOG_MINIMAP_IMPORT_FAIL:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_IMPORT_FAIL_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_IMPORT_FAIL_TITLE");
               break;
            case DIALOG_MINIMAP_IMPORT_PROGRESS:
               _loc3_.buttonFlags = EmbeddedDialog.CANCEL;
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_IMPORT_PROGRESS_TITLE");
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_MINIMAP_DLG_IMPORT_PROGRESS_TEXT",[param2]);
               break;
            case DIALOG_OPTIONS_EXPORT_FAIL:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_DLG_EXPORT_FAIL_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_DLG_EXPORT_FAIL_TITLE");
               break;
            case DIALOG_OPTIONS_IMPORT_FAIL:
               _loc3_.buttonFlags = EmbeddedDialog.CLOSE;
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_DLG_IMPORT_FAIL_TEXT");
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_DLG_IMPORT_FAIL_TITLE");
               break;
            case DIALOG_OPTIONS_RESET:
               _loc3_.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
               _loc3_.title = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_DLG_RESET_TITLE");
               _loc3_.text = resourceManager.getString(ConfigurationWidget.BUNDLE,"IMPORTEXPORT_OPTIONS_DLG_RESET_TEXT");
         }
         PopUpBase.s_GetInstance().embeddedDialog = _loc3_;
      }
      
      private function onImportMiniMapComplete(param1:Event) : void
      {
         if(param1 != null)
         {
            this.removeMiniMapListeners();
            this.m_UIButtonMiniMapExport.enabled = false;
            this.showEmbeddedDialog(DIALOG_NONE);
         }
      }
      
      private function removeMiniMapListeners() : void
      {
         var _loc1_:MiniMapStorage = Tibia.s_GetMiniMapStorage();
         if(_loc1_ != null)
         {
            _loc1_.removeEventListener(ErrorEvent.ERROR,this.onImportMiniMapError);
            _loc1_.removeEventListener(Event.COMPLETE,this.onExportMiniMapSave);
            _loc1_.removeEventListener(Event.COMPLETE,this.onImportMiniMapComplete);
            _loc1_.removeEventListener(ProgressEvent.PROGRESS,this.onExportMiniMapProgress);
            _loc1_.removeEventListener(ProgressEvent.PROGRESS,this.onImportMiniMapProgress);
         }
      }
      
      private function onExportMiniMapProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1 != null)
         {
            _loc2_ = Math.round(100 * param1.bytesLoaded / param1.bytesTotal);
            this.showEmbeddedDialog(DIALOG_MINIMAP_EXPORT_PROGRESS,_loc2_.toFixed(0));
         }
      }
      
      private function onImportMiniMapSelect(param1:Event) : void
      {
         var a_Event:Event = param1;
         if(a_Event != null && this.m_File != null)
         {
            this.removeFileListeners();
            if(a_Event.type == Event.SELECT)
            {
               try
               {
                  this.m_File.load();
                  this.m_File.addEventListener(Event.COMPLETE,this.onImportMiniMapLoad);
                  this.m_File.addEventListener(IOErrorEvent.IO_ERROR,this.onImportMiniMapError);
               }
               catch(_Error:IllegalOperationError)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_CONCURRENT);
               }
               catch(_Error:*)
               {
                  m_File = null;
                  showEmbeddedDialog(DIALOG_ERROR_READ);
               }
            }
            else
            {
               this.m_File = null;
               this.showEmbeddedDialog(DIALOG_NONE);
            }
         }
      }
      
      private function onExportMiniMapComplete(param1:Event) : void
      {
         if(param1 != null)
         {
            this.removeFileListeners();
            this.m_File = null;
            this.removeMiniMapListeners();
            this.m_MiniMapData = null;
         }
      }
      
      private function removeFileListeners() : void
      {
         if(this.m_File != null)
         {
            this.m_File.removeEventListener(Event.CANCEL,this.onExportMiniMapComplete);
            this.m_File.removeEventListener(Event.CANCEL,this.onImportMiniMapSelect);
            this.m_File.removeEventListener(Event.CANCEL,this.onExportOptionsComplete);
            this.m_File.removeEventListener(Event.CANCEL,this.onImportOptionsSelect);
            this.m_File.removeEventListener(Event.COMPLETE,this.onExportMiniMapComplete);
            this.m_File.removeEventListener(Event.COMPLETE,this.onImportMiniMapLoad);
            this.m_File.removeEventListener(Event.COMPLETE,this.onExportOptionsComplete);
            this.m_File.removeEventListener(Event.COMPLETE,this.onImportOptionsLoad);
            this.m_File.removeEventListener(Event.SELECT,this.onImportMiniMapSelect);
            this.m_File.removeEventListener(Event.SELECT,this.onImportOptionsSelect);
            this.m_File.removeEventListener(IOErrorEvent.IO_ERROR,this.onExportMiniMapError);
            this.m_File.removeEventListener(IOErrorEvent.IO_ERROR,this.onExportOptionsError);
            this.m_File.removeEventListener(IOErrorEvent.IO_ERROR,this.onImportMiniMapError);
            this.m_File.removeEventListener(IOErrorEvent.IO_ERROR,this.onImportOptionsError);
         }
      }
   }
}

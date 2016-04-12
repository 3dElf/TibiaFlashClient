package tibia.input.gameaction
{
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import mx.collections.*;
    import mx.formatters.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.chat.*;
    import tibia.input.*;

    public class SaveChannelActionImpl extends Object implements IActionImpl
    {
        protected var m_Channel:Channel = null;
        protected var m_ChatStorage:ChatStorage = null;
        protected var m_File:FileReference = null;
        private static const CHAT_BUNDLE:String = "ChatWidget";
        private static const GLOBAL_BUNDLE:String = "Global";

        public function SaveChannelActionImpl(param1:ChatStorage, param2:Channel)
        {
            if (param1 == null)
            {
                throw new ArgumentError("SaveChannelActionImpl.SaveChannelActionImpl: Invalid chat storage.");
            }
            if (param1 == null)
            {
                throw new ArgumentError("SaveChannelActionImpl.SaveChannelActionImpl: Invalid channel.");
            }
            this.m_ChatStorage = param1;
            this.m_Channel = param2;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var EOL:String;
            var Data:String;
            var _List:IList;
            var i:int;
            var n:int;
            var Manager:IResourceManager;
            var _Formatter:DateFormatter;
            var Name:String;
            var a_Repeat:* = param1;
            if (this.m_File == null)
            {
                EOL;
                if (Capabilities.os.match(/^Mac OS/) || Capabilities.os.match(/^iPhone/))
                {
                    EOL;
                }
                else if (Capabilities.os.match(/^Linux/))
                {
                    EOL;
                }
                else
                {
                    EOL;
                }
                Data;
                _List = this.m_Channel.messages;
                i;
                n = _List.length;
                while (i < n)
                {
                    
                    Data = Data + (ChannelMessage(_List.getItemAt(i)).plainText + EOL);
                    i = (i + 1);
                }
                Manager = ResourceManager.getInstance();
                _Formatter = new DateFormatter();
                _Formatter.formatString = Manager.getString(GLOBAL_BUNDLE, "DATE_FORMAT_FILENAME");
                Name = this.m_Channel.name.replace(/\W/g, "_") + " - " + _Formatter.format(new Date()) + ".txt";
                try
                {
                    this.m_File = new FileReferenceWrapper();
                    this.m_File.save(Data, Name);
                    this.m_File.addEventListener(Event.COMPLETE, this.onSaveComplete);
                    this.m_File.addEventListener(IOErrorEvent.IO_ERROR, this.onSaveError);
                }
                catch (_Error:IllegalOperationError)
                {
                    onSaveError(null);
                    ;
                }
                catch (_Error)
                {
                    onSaveError(null);
                }
            }
            return;
        }// end function

        private function onSaveComplete(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null && this.m_File != null)
            {
                _loc_2 = ResourceManager.getInstance().getString(CHAT_BUNDLE, "ACTION_SAVE_SUCCESS", [this.m_Channel.name, this.m_File.name]);
                this.m_ChatStorage.addChannelMessage(this.m_Channel, -1, null, 0, MessageMode.MESSAGE_CHANNEL_MANAGEMENT, _loc_2);
                this.m_File.removeEventListener(Event.COMPLETE, this.onSaveComplete);
                this.m_File.removeEventListener(IOErrorEvent.IO_ERROR, this.onSaveError);
                this.m_File = null;
            }
            return;
        }// end function

        private function onSaveError(event:Event) : void
        {
            var _loc_2:* = ResourceManager.getInstance().getString(CHAT_BUNDLE, "ACTION_SAVE_FAILURE", [this.m_Channel.name]);
            this.m_ChatStorage.addChannelMessage(this.m_Channel, -1, null, 0, MessageMode.MESSAGE_CHANNEL_MANAGEMENT, _loc_2);
            if (this.m_File != null)
            {
                this.m_File.removeEventListener(Event.COMPLETE, this.onSaveComplete);
                this.m_File.removeEventListener(IOErrorEvent.IO_ERROR, this.onSaveError);
                this.m_File = null;
            }
            return;
        }// end function

    }
}

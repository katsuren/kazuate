package components
{
  import flash.events.Event;
  import spark.components.Group;

  [Event (name="select", type="flash.events.Event")]

  public class AbstractSelector extends Group
  {
    //---------------------------------
    // Constructor
    //---------------------------------
    public function AbstractSelector()
    {
      super();
    }


    //---------------------------------
    // Properties
    //---------------------------------
    [Bindable ("selectedLabelChanged")]
    public function get selectedLabel():String
    {
      return _selectedLabel;
    }
    public function set selectedLabel(value:String):void
    {
      _selectedLabel = value;
      var event:Event = new Event("selectedLabelChanged");
      dispatchEvent(event);
    }
    private var _selectedLabel:String;

    [Bindable ("selectedValueChanged")]
    public function get selectedValue():Object
    {
      return _selectedValue;
    }
    private var _selectedValue:Object;


    //---------------------------------
    // Functions
    //---------------------------------
    protected function select(label:String, value:Object=null):void
    {
      _selectedValue = value;
      selectedLabel= label;
      var event:Event = new Event("selectedValueChanged");
      dispatchEvent(event);
      event = new Event(Event.SELECT);
      dispatchEvent(event);
    }
  }
}

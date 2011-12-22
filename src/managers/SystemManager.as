package managers
{
  import spark.components.Application;

  public class SystemManager 
  {
    private static var _root:Application;

    public function SystemManager()
    {
      super();
    }

    public function getRootApplication():Application
    {
      return _root;
    }

    public function setRootApplication(value:Application):void
    {
      _root = value;
    }

    public function setModal(value:Boolean):void
    {
      _root["setModal"](value);
    }
  }
}

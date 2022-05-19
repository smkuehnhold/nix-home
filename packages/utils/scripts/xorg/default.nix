{ callPackage, ... }:

{

  getActiveMonitors = (callPackage ./get_active_monitors {});  
  isActiveMonitor = (callPackage ./is_active_monitor {});

}    


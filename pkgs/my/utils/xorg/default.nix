{ callPackage, ... }:

{
  getActiveMonitors = (callPackage ./get_active_monitors {});  
  getScalingFactor = (callPackage ./get_scaling_factor {});
  isActiveMonitor = (callPackage ./is_active_monitor {});
}    

{ callPackage, ... }:

{
  getActiveMonitors = (callPackage ./get_active_monitors {});
  getMonitorSize = (callPackage ./get_monitor_size {});  
  getScalingFactor = (callPackage ./get_scaling_factor {});
  getWindowSizeAndOffset = (callPackage ./get_window_size_and_offset {});
  isActiveMonitor = (callPackage ./is_active_monitor {});
  parseNodeSizeAndOffset = (callPackage ./parse_node_size_and_offset {});
}    

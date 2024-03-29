{ callPackage, ... }:

{
  createNewNumberedDesktop = (callPackage ./create-new-numbered-desktop {});
  deleteLargestNumberedDesktopGreaterThanLowerBound = (callPackage ./delete-largest-numbered-desktop-greater-than-lower-bound {});
  getFocusedMonitorName = (callPackage ./get-focused-monitor-name {});
  getLargestDesktopName = (callPackage ./get-largest-desktop-name {});
  getSmallestDesktopName = (callPackage ./get-smallest-desktop-name {});
  moveFloatingNodeToEdge = (callPackage ./move-floating-node-to-edge {});
}
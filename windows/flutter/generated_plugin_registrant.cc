//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"
#include <geolocator_windows/geolocator_windows.h>
#include <firebase_core/firebase_core_plugin_c_api.h>


void RegisterPlugins(flutter::PluginRegistry* registry) {
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
    FirebaseCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
}

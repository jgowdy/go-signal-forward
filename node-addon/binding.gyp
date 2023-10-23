{
  'targets': [
      {
      'target_name': 'addon',
      'include_dirs': ["<!(node -p \"require('node-addon-api').include_dir\")"],
      "cflags": ["-fexceptions", "-g", "-O3", "-std=c++17", "-fPIC"],
      "cflags_cc": ["-fexceptions", "-g", "-O3", "-std=c++17", "-fPIC"],
      "cflags!": [ "-fno-exceptions"],
      "cflags_cc!": [ "-fno-exceptions" ],
      'xcode_settings': {
        'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
        'OTHER_CFLAGS': [
          '-fexceptions',
          '-g',
          '-O3',
          '-std=c++17',
          '-fPIC'
        ],
      },
      'defines': [ 'NAPI_CPP_EXCEPTIONS', 'NODE_API_SWALLOW_UNTHROWABLE_EXCEPTIONS', 'NODE_ADDON_API_DISABLE_DEPRECATED', 'NODE_API_NO_EXTERNAL_BUFFERS_ALLOWED' ],
      'sources': [
        'addon.cc'
      ],
      'libraries': [ '../golib.a' ]
    }
  ]
}

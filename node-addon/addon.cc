#include "golib.h"
#include <napi.h>

class SampleAddon : public Napi::Addon<SampleAddon> {
public:
  SampleAddon(Napi::Env env, Napi::Object exports) {
    DefineAddon(exports, {InstanceMethod("add", &SampleAddon::Add)});
  }
  Napi::Value Add(const Napi::CallbackInfo &info) {
    return Napi::Number::New(info.Env(),
                             GoAdd(info[0].As<Napi::Number>().DoubleValue(),
                                   info[1].As<Napi::Number>().DoubleValue()));
  }
};

NODE_API_ADDON(SampleAddon);

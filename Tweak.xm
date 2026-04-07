#import <UIKit/UIKit.h>
#import <mach-o/dyld.h>

extern "C" void MSHookFunction(void *symbol, void *replace, void **result);

void (*old_recoil)(void *instance, float value);
void new_recoil(void *instance, float value) {
    old_recoil(instance, 0.0f); 
}

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        uintptr_t targetBase = (uintptr_t)_dyld_get_image_header(0);
        // Using a placeholder offset. Change 0x1234567 to your actual Free Fire offset.
        MSHookFunction((void*)(targetBase + 0x1234567), (void*)new_recoil, (void**)&old_recoil);
    });
}

#import <UIKit/UIKit.h>
#import <mach-o/dyld.h>

// This defines the hook function manually to avoid errors
extern "C" void MSHookFunction(void *symbol, void *replace, void **result);

void (*old_recoil)(void *instance, float value);
void new_recoil(void *instance, float value) {
    old_recoil(instance, 0.0f); 
}

void (*old_damage)(void *instance, int value);
void new_damage(void *instance, int value) {
    old_damage(instance, 999); 
}

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        uintptr_t targetBase = (uintptr_t)_dyld_get_image_header(0);
        
        // No Recoil Hook - Change 0x1234567 to real offset
        MSHookFunction((void*)(targetBase + 0x1234567), (void*)new_recoil, (void**)&old_recoil);
        
        // High Damage Hook - Change 0x7654321 to real offset
        MSHookFunction((void*)(targetBase + 0x7654321), (void*)new_damage, (void**)&old_damage);
    });
}

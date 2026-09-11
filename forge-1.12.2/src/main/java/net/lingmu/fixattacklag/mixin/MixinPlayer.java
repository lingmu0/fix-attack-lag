package net.lingmu.fixattacklag.mixin;

import net.minecraft.entity.player.EntityPlayer;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyArg;

/** Prevents one attack from allocating a large damage-indicator particle burst. */
@Mixin(EntityPlayer.class)
public abstract class MixinPlayer {
    @ModifyArg(
            method = "attackTargetEntityWithCurrentItem",
            at = @At(
                    value = "INVOKE",
                    target = "Lnet/minecraft/world/WorldServer;func_175739_a(Lnet/minecraft/util/EnumParticleTypes;DDDIDDDDI[I)V",
                    remap = false
            ),
            index = 4
    )
    private int fixAttackLag$disableDamageIndicatorBurst(int original) {
        return 0;
    }
}

package net.lingmu.fixattacklag.mixin;

import net.minecraft.entity.player.PlayerEntity;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyArg;

/** Prevents one attack from allocating a large damage-indicator particle burst. */
@Mixin(PlayerEntity.class)
public abstract class MixinPlayer {
    @ModifyArg(
            method = "attack",
            at = @At(
                    value = "INVOKE",
                    target = "Lnet/minecraft/world/server/ServerWorld;sendParticles(Lnet/minecraft/particles/IParticleData;DDDIDDDD)I"
            ),
            index = 4
    )
    private int fixAttackLag$disableDamageIndicatorBurst(int original) {
        return 0;
    }
}

package net.lingmu.fixattacklag.mixin;

import net.minecraft.world.entity.player.Player;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyArg;

/** Prevents one attack from allocating a large damage-indicator particle burst. */
@Mixin(Player.class)
public abstract class MixinPlayer {
    @ModifyArg(
            method = "attack",
            at = @At(
                    value = "INVOKE",
                    target = "Lnet/minecraft/server/level/ServerLevel;sendParticles(Lnet/minecraft/core/particles/ParticleOptions;DDDIDDDD)I"
            ),
            index = 4
    )
    private int fixAttackLag$disableDamageIndicatorBurst(int original) {
        return 0;
    }
}

package net.lingmu.gamechanics.mixin;

import net.minecraft.world.entity.player.Player;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyArg;

@Mixin(Player.class)
public class MixinPlayer {
    //    @Inject(method = "attack",at= @At(value = "INVOKE", target = "sendParticles"))
    @ModifyArg(
            method = "attack",
            at = @At(value = "INVOKE",
                    target = "Lnet/minecraft/server/level/ServerLevel;sendParticles(Lnet/minecraft/core/particles/ParticleOptions;DDDIDDDD)I"
            ),
            index = 4
    )
    protected int modifyParticleCount(int original) {
        return 0; // 将粒子数量强制设为0
    }
}

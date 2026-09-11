package net.lingmu.fixattacklag;

import net.fabricmc.api.ModInitializer;

/**
 * Prevents vanilla attack damage-indicator particle bursts from being sent to clients.
 */
public final class FixAttackLag implements ModInitializer {
    public static final String MOD_ID = "fix_attack_lag";

    @Override
    public void onInitialize() {
        // The behavior is implemented by the Player.attack mixin.
    }
}

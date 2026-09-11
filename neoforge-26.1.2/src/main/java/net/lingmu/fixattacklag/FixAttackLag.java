package net.lingmu.fixattacklag;

import net.neoforged.fml.common.Mod;

/**
 * Removes the attack damage indicator particle burst that can cause client
 * lag when a single attack damages many entities.
 */
@Mod(FixAttackLag.MODID)
public final class FixAttackLag {
    public static final String MODID = "fix_attack_lag";

    private FixAttackLag() {
    }
}

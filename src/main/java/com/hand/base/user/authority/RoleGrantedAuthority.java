package com.hand.base.user.authority;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;

/**
 * 基于角色的授权
 */
public class RoleGrantedAuthority implements GrantedAuthority {

    private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

    private final String role;

    public RoleGrantedAuthority(String role) {
       this.role = role;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof String) {
            return obj.equals(this.role);
        }

        if (obj instanceof GrantedAuthority) {
            GrantedAuthority attr = (GrantedAuthority) obj;

            return this.role.equals(attr.getAuthority());
        }

        return false;
    }

    public String getAuthority() {
        return this.role;
    }
    
    @Override
    public int hashCode() {
        return this.role.hashCode();
    }
    
    @Override
    public String toString() {
        return this.role;
    }
}

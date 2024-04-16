export def apt_build_cache [--installed(-i)] {
    $installed | describe
    if $installed {
        ((apt list --installed | complete).stdout | lines | split column "/" | select column1).column1 | skip | save --force $"($env.HOME)/.cache/apt_pkg_inst.cache"    
    } else {
        ((apt list | complete).stdout | lines | split column "/" | select column1).column1 | skip | save --force $"($env.HOME)/.cache/apt_pkg_all.cache"
    }
}

export def apt_load_cache [--installed(-i)] {
    if $installed {
        open $"($env.HOME)/.cache/apt_pkg_inst.cache" | lines
    } else {
        open $"($env.HOME)/.cache/apt_pkg_all.cache" | lines
    }
}

export def apt_comp_inst [] {
    $env.APT_CACHE_INST
}

export def apt_comp_all [] {
    $env.APT_CACHE_ALL
}

export extern "apt install" [packages: string@apt_comp_all]
export extern "apt remove" [packages: string@apt_comp_inst]
export extern "apt purge" [packages: string@apt_comp_inst]
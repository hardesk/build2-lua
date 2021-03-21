LUA_FILES = lapi

CORE=	lapi lcode lctype ldebug ldo ldump lfunc lgc llex \
		lmem lobject lopcodes lparser lstate lstring ltable \
		ltm lundump lvm lzio
#	ltests
AUX=	lauxlib
LIB=	lbaselib ldblib liolib lmathlib loslib ltablib lstrlib \
		lutf8lib loadlib lcorolib linit

lib{lua}: upstream/c{$CORE $AUX $LIB} upstream/h{lua luaconf}
{
	cc.poptions =+ "-I$out_root" "-I$src_root"
}

if ($cxx.targe.class == 'windows')
{
	objs{*}: cc.poptions += -DLUA_BUILD_AS_DLL
	libs{lua}: cc.export.poptions += -DLUA_SHARED
}

lib{lua}: cc.export.poptions = "-I$out_root" "-I$src_base/upstream"

h{*}:
{
	install = include/lua/
}

./: lib{lua} doc{README.md} manifest

#if $version.pre_release
#  lib{lua}: bin.lib.version = @"-$version.project_id"
#else
#  lib{lua}: bin.lib.version = @"-$version.major.$version.minor"


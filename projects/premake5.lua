SDK_FOLDER = "E:/Programming/source-sdk-2013/mp/src"
GARRYSMOD_MODULE_BASE_FOLDER = "../gmod-module-base"
SOURCE_FOLDER = "../source"
PROJECT_FOLDER = os.get() .. "/" .. _ACTION

solution("gm_stringtable")
	language("C++")
	location(PROJECT_FOLDER)
	warnings("Extra")
	flags({"NoPCH", "StaticRuntime"})
	platforms({"x86"})
	configurations({"Release", "Debug"})

	filter("platforms:x86")
		architecture("x32")

	filter("configurations:Release")
		optimize("On")
		vectorextensions("SSE2")
		objdir(PROJECT_FOLDER .. "/intermediate")
		targetdir(PROJECT_FOLDER .. "/release")

	filter("configurations:Debug")
		flags({"Symbols"})
		objdir(PROJECT_FOLDER .. "/intermediate")
		targetdir(PROJECT_FOLDER .. "/debug")

	project("gmsv_stringtable")
		kind("SharedLib")
		defines({
			"GMMODULE",
			"STRINGTABLE_SERVER",
			"SUPPRESS_INVALID_PARAMETER_NO_INFO"
		})
		includedirs({
			SOURCE_FOLDER,
			GARRYSMOD_MODULE_BASE_FOLDER .. "/include",
			SDK_FOLDER .. "/public",
			SDK_FOLDER .. "/public/tier0",
			SDK_FOLDER .. "/public/tier1"
		})
		files({
			SOURCE_FOLDER .. "/*.h",
			SOURCE_FOLDER .. "/*.cpp"
		})
		vpaths({
			["Header files"] = SOURCE_FOLDER .. "/**.h",
			["Source files"] = {
				SOURCE_FOLDER .. "/**.cpp",
				SDK_FOLDER .. "/**.cpp"
			}
		})

		targetprefix("")
		targetextension(".dll")

		filter("system:windows")
			files({SDK_FOLDER .. "/public/tier0/memoverride.cpp"})
			libdirs({SDK_FOLDER .. "/lib/public"})
			links({"tier0", "tier1"})
			targetsuffix("_win32")

			filter({"system:windows", "configurations:Debug"})
				linkoptions({"/NODEFAULTLIB:\"libcmt\""})

		filter("system:linux")
			defines({
				"COMPILER_GCC",
				"POSIX",
				"LINUX",
				"_LINUX",
				"GNUC",
				"NO_MALLOC_OVERRIDE"
			})
			libdirs({SDK_FOLDER .. "/lib/public/linux32"})
			links({"dl", "tier0_srv"})
			linkoptions({SDK_FOLDER .. "/lib/public/linux32/tier1.a"})
			buildoptions({"-std=c++11"})
			targetsuffix("_linux")

		filter({"system:macosx"})
			libdirs({SDK_FOLDER .. "/lib/public/osx32"})
			links({"dl", "tier0", "tier1"})
			buildoptions({"-std=c++11"})
			targetsuffix("_mac")

	project("gmcl_stringtable")
		kind("SharedLib")
		defines({
			"GMMODULE",
			"STRINGTABLE_CLIENT",
			"SUPPRESS_INVALID_PARAMETER_NO_INFO"
		})
		includedirs({
			SOURCE_FOLDER,
			GARRYSMOD_MODULE_BASE_FOLDER .. "/include",
			SDK_FOLDER .. "/public",
			SDK_FOLDER .. "/public/tier0",
			SDK_FOLDER .. "/public/tier1"
		})
		files({
			SOURCE_FOLDER .. "/*.h",
			SOURCE_FOLDER .. "/*.cpp"
		})
		vpaths({
			["Header files"] = SOURCE_FOLDER .. "/**.h",
			["Source files"] = {
				SOURCE_FOLDER .. "/**.cpp",
				SDK_FOLDER .. "/**.cpp"
			}
		})

		targetprefix("")
		targetextension(".dll")

		filter("system:windows")
			files({SDK_FOLDER .. "/public/tier0/memoverride.cpp"})
			libdirs({SDK_FOLDER .. "/lib/public"})
			links({"tier0", "tier1"})
			targetsuffix("_win32")

			filter({"system:windows", "configurations:Debug"})
				linkoptions({"/NODEFAULTLIB:\"libcmt\""})

		filter("system:linux")
			defines({
				"COMPILER_GCC",
				"POSIX",
				"LINUX",
				"_LINUX",
				"GNUC",
				"NO_MALLOC_OVERRIDE"
			})
			libdirs({SDK_FOLDER .. "/lib/public/linux32"})
			links({"dl", "tier0"})
			linkoptions({SDK_FOLDER .. "/lib/public/linux32/tier1.a"})
			buildoptions({"-std=c++11"})
			targetsuffix("_linux")

		filter({"system:macosx"})
			libdirs({SDK_FOLDER .. "/lib/public/osx32"})
			links({"dl", "tier0", "tier1"})
			buildoptions({"-std=c++11"})
			targetsuffix("_mac")

dnl
dnl Internal editor support.
dnl
AC_DEFUN([MC_WITH_EDIT], [

    AC_ARG_WITH([edit], AS_HELP_STRING([--with-edit], [Enable internal editor @<:@yes@:>@]))

    if test x$with_edit != xno; then
            AC_DEFINE(USE_INTERNAL_EDIT, 1, [Define to enable internal editor])
            use_edit=yes
            AC_MSG_NOTICE([using internal editor])
    else
            use_edit=no
            edit_msg="no"
    fi

    dnl ASpell support.
    AC_ARG_ENABLE([aspell],
        AS_HELP_STRING([--enable-aspell], [Enable aspell support for internal editor @<:@no@:>@]),
        [
            if test "x$enableval" = xno; then
                enable_aspell=no
            else
                enable_aspell=yes
            fi
        ],
        [enable_aspell=no]
    )

    if test x$with_edit != xno -a x$enable_aspell != xno; then
            AC_CHECK_HEADERS([aspell.h], [], [
                AC_ERROR([Could not find aspell development headers])
            ], [])

            if test x"$g_module_supported" != x; then
                AC_DEFINE(HAVE_ASPELL, 1, [Define to enable aspell support])
                edit_msg="yes with aspell support"
                AC_MSG_NOTICE([using aspell for internal editor])
            else
                enable_aspell=no
                AC_MSG_NOTICE([aspell support is disabled because gmodule support is not available])
            fi
    else
            edit_msg="yes"
    fi
])

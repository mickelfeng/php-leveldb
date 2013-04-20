dnl $Id$
dnl config.m4 for extension leveldb

PHP_ARG_WITH(leveldb, for leveldb support,
Make sure that the comment is aligned:
[  --with-leveldb[=Path]             Include leveldb support])

if test "$PHP_LEVELDB" != "no"; then
  dnl Write more examples of tests here...

  # --with-leveldb -> check with-path
  SEARCH_PATH="/usr/local /usr"     # you might want to change this
  SEARCH_FOR="include/leveldb/c.h"  # you most likely want to change this
  SEARCH_LIB="libleveldb.a"

  dnl search leveldb
  AC_MSG_CHECKING([for leveldb location])
  for i in $PHP_LEVELDB $SEARCH_PATH ; do
    if test -r $i/$SEARCH_FOR; then
	  LEVELDB_INCLUDE_DIR=$i
	  AC_MSG_RESULT(leveldb headers found in $i)
    fi

    if test -r $i/lib/$SEARCH_LIB; then
	  LEVELDB_LIB_DIR=$i/lib
	  AC_MSG_RESULT(leveldb lib found in $i/lib)
    fi

	dnl from Leveldb build dir
    if test -r $i/$SEARCH_LIB; then
	  LEVELDB_LIB_DIR=$i
	  AC_MSG_RESULT(leveldb lib found in $i)
    fi
  done
  
  if test -z "$LEVELDB_INCLUDE_DIR" || test -z "$LEVELDB_LIB_DIR"; then
    AC_MSG_RESULT([leveldb not found])
    AC_MSG_ERROR([Please reinstall the leveldb distribution])
  fi

  # --with-leveldb -> add include path
  PHP_ADD_INCLUDE($LEVELDB_INCLUDE_DIR/include)

  # --with-leveldb -> check for lib and symbol presence
  LIBNAME=leveldb # you may want to change this
  PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $LEVELDB_LIB_DIR, LEVELDB_SHARED_LIBADD)
  
  PHP_SUBST(LEVELDB_SHARED_LIBADD)

  PHP_NEW_EXTENSION(leveldb, leveldb.c, $ext_shared)
fi

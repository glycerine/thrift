dnl @synopsis AX_RUSTC_AND_RUST
dnl @synopsis AX_CHECK_RUST_CLASS(CLASSNAME)
dnl
dnl Test for the presence of RUST, and (optionally) specific classes.
dnl
dnl If "RUST" is defined in the environment, that will be the only
dnl rust command tested.  Otherwise, a hard-coded list will be used.
dnl Similarly for "RUSTC".
dnl
dnl AX_RUSTC_AND_RUST does not currenly support testing for a particular
dnl Rust version, testing for only one of "rust" and "rustc", or
dnl compiling or running user-provided Rust code.
dnl
dnl After AX_RUSTC_AND_RUST runs, the shell variables "success" and
dnl "ax_rustc_and_rust" are set to "yes" or "no", and "RUSTC" and
dnl "RUST" are set to the appropriate commands.
dnl
dnl AX_CHECK_RUST_CLASS must be run after AX_RUSTC_AND_RUST.
dnl It tests for the presence of a class based on a fully-qualified name.
dnl It sets the shell variable "success" to "yes" or "no".
dnl
dnl @category Rust
dnl @version 2009-02-09
dnl @license AllPermissive
dnl
dnl Copyright (C) 2009 David Reiss
dnl Copyright (C) 2013 Jason E. Aten
dnl Copying and distribution of this file, with or without modification,
dnl are permitted in any medium without royalty provided the copyright
dnl notice and this notice are preserved.


AC_DEFUN([AX_RUSTC_AND_RUST],
         [

          dnl Hard-coded default commands to test.
          RUSTC_PROGS="rustc"
          RUST_PROGS="rust run"

          dnl Allow the user to specify an alternative.
          if test -n "$RUSTC" ; then
            RUSTC_PROGS="$RUSTC"
          fi
          if test -n "$RUST" ; then
            RUST_PROGS="$RUST"
          fi

          AC_MSG_CHECKING(for rustc and rust)

          echo "fn main() { }" > configtest_ax_rustc_and_rust.rs
          success=no
          oIFS="$IFS"

          IFS=","
          for RUSTC in $RUSTC_PROGS ; do
            IFS="$oIFS"

            echo "Running \"$RUSTC configtest_ax_rustc_and_rust.rust\"" >&AS_MESSAGE_LOG_FD
            if $RUSTC configtest_ax_rustc_and_rust.rs >&AS_MESSAGE_LOG_FD 2>&1 ; then

              IFS=","
              for RUST in $RUST_PROGS ; do
                IFS="$oIFS"

                echo "Running \"$RUST configtest_ax_rustc_and_rust\"" >&AS_MESSAGE_LOG_FD
                if $RUST configtest_ax_rustc_and_rust >&AS_MESSAGE_LOG_FD 2>&1 ; then
                  success=yes
                  break 2
                fi

              done

            fi

          done

          rm -f configtest_ax_rustc_and_rust.rs configtest_ax_rustc_and_rust

          if test "$success" != "yes" ; then
            AC_MSG_RESULT(no)
            RUSTC=""
            RUST=""
          else
            AC_MSG_RESULT(yes)
          fi

          ax_rustc_and_rust="$success"

          ])




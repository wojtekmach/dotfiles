export CFLAGS="-O2"
export KERL_CONFIGURE_OPTIONS="--enable-hipe
                               --disable-debug
                               --disable-silent-rules
                               --without-javac
                               --enable-shared-zlib
                               --enable-dynamic-ssl-lib
                               --enable-sctp
                               --enable-smp-support
                               --enable-threads
                               --enable-kernel-poll
                               --enable-darwin-64bit
                               --enable-gettimeofday-as-os-system-time
                               --enable-dirty-schedulers
                               --with-ssl=/usr/local/opt/openssl"

#!/usr/bin/env zsh

RUBIES_TO_INSTALL=(3.2.2)
DEFAULT_RUBY_VERSION=${RUBIES_TO_INSTALL[1]}
mkdir -p $HOME/.rubies

echo "Installing rubies"
for ruby_ver in ${RUBIES_TO_INSTALL[*]}; do
  ls -x $HOME/.rubies | grep ${ruby_ver} 2> /dev/null
  if [[ "$?" -eq "1" ]]; then

    if [ -d /opt/homebrew/opt ]; then
      export PATH="/opt/homebrew/bin:/opt/homebrew/opt/openssl@1.1/bin:$PATH"
      export PATH="/opt/homebrew/sbin:$PATH"
      export CPPFLAGS="-I/opt/homebrew/opt/libffi/include -I/opt/homebrew/opt/openssl@1.1/include -I/opt/homebrew/opt/readline/include -I/opt/homebrew/opt/binutils/include"
      export LDFLAGS="-L/opt/homebrew/opt/bison/lib -L/opt/homebrew/opt/libffi/lib -L/opt/homebrew/opt/openssl@1.1/lib -L/opt/homebrew/opt/readline/lib -L/opt/homebrew/opt/binutils/lib"
      export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig:/opt/homebrew/opt/openssl@1.1/lib/pkgconfig:/opt/homebrew/opt/readline/lib/pkgconfig"
      export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"
    else
      export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
      export CPPFLAGS="-I/usr/local/opt/libffi/include -I/usr/local/opt/openssl@1.1/include -I/usr/local/opt/readline/include -I/usr/local/opt/binutils/include"
      export LDFLAGS="-L/usr/local/opt/bison/lib -L/usr/local/opt/libffi/lib -L/usr/local/opt/openssl@1.1/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/binutils/lib"
      export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig:/usr/local/opt/openssl@1.1/lib/pkgconfig:/usr/local/opt/readline/lib/pkgconfig"
      export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
    fi

    echo "Installing: ruby-${ruby_ver}"
    ruby-install ruby ${ruby_ver}
  else
    echo "ruby-${ruby_ver} already installed"
  fi
done

echo "Setting default ruby to ${DEFAULT_RUBY_VERSION}"
echo ${DEFAULT_RUBY_VERSION} > $HOME/.ruby-version

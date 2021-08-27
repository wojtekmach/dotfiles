#!/bin/sh
set -e

cd ~/src

for i in elixir-lang/{elixir,ex_doc} \
  wojtekmach/{req,mix_install_examples,notebooks,private_notebooks} \
  hexpm/{hex,hexpm,hex_core,bob,diff,preview,hexdocs} \
  phoenixframework/{phoenix,phoenix_live_dashboard,phoenix_live_view,phoenix_view,phoenix_html,phoenix_ecto} \
  elixir-ecto/{ecto,ecto_sql,postgrex,myxql,db_connection,connection} \
  dashbitco/nimble_{csv,options,parsec,pool,publisher,totp} \
  dashbitco/broadway{,_dashboard,_website,_sqs,_rabbitmq,_cloud_pub_sub,_kafka} \
  livebook-dev/{livebook,kino} \
  keathley/finch \
  erlang/otp \
; do
  echo $i

  if [[ -d $HOME/src/$(basename "$i") ]]; then
    current="$(git rev-parse --abbrev-ref HEAD)"
    main=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

    if [[ "$current" == "$main" ]] && [[ -z "$(git status --porcelain)" ]]; then
      git pull
    fi
  else
    gh repo clone $i
  fi
done

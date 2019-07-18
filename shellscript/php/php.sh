#!/bin/sh
clear
COMMAND=$1
SCRIPT_PATH=$(pwd)
BRANCH="feature/SCIII-188"
DEPLOY_PATH="YOUR DEPLPOY PATH"
DIRECTORY="build"
GITURL="YOUR GIT URL"
cd $DEPLOY_PATH

if [ -d "$DIRECTORY" ]; then
  if [ "$COMMAND" = "--fresh" ]; then
     echo "in"
     rm -rf $DIRECTORY
  fi
fi

if [ ! -d "$DIRECTORY" ]; then
  # fresh install
  IS_NEW=true 
  echo "fresh installation"
  pwd
  echo $DIRECTORY 
  mkdir $DIRECTORY
else
  echo "update installation"
  IS_NEW=false
fi

echo "change to working directory" $DIRECTORY

cd $DIRECTORY

if [ "$IS_NEW" = true ]; then 
  echo "clone "
  git clone $GITURL .
fi

git fetch --all 
git checkout $BRANCH
git pull

if [ "$IS_NEW" = true ]; then 
  composer install 
fi

composer update 


#php artisan passport:install

php artisan clear-compiled 
composer dump-autoload
php artisan optimize
 

cp $SCRIPT_PATH/.env .env

sudo chmod -R 777 bootstrap/cache/

sudo chmod -R 777 storage/


if [ "$IS_NEW" = true ]; then
	php artisan migrate:fresh
	php artisan passport:install
else  
	php artisan migrate
fi

#php artisan db:seed

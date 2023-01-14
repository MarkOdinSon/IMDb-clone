#My IMDb clone
Mark H. 2023
<hr>

### Running this app on your local machine

Run the following algorithm to deploy this project on your local machine <br><br>
Installation algorithm (steps): <br>
1. git clone https://github.com/MarkOdinSon/IMDb-clone.git AppIMBbClone <br>
2. cd AppIMBbClone <br>
3. cp .env.example .env <br>
4. docker-compose up --build <br>
5. ./run rails db:setup <br>
6. go to http://localhost:8000/ <br>
   Enjoy!
<hr>
./run bundle:install (now not necessary anymore, command #4 do it automatically) <br>
<hr>

### Files of interest

I recommend checking out most files and searching the code base for `TODO:`,
but please review the `.env` and `run` files before diving into the rest of the
code and customizing it. Also, you should hold off on changing anything until
we cover how to customize this example app's name with an automated script
(coming up next in the docs).

### `.env`

This file is ignored from version control so it will never be commit. There's a
number of environment variables defined here that control certain options and
behavior of the application. Everything is documented there.

Feel free to add new variables as needed. This is where you should put all of
your secrets as well as configuration that might change depending on your
environment (specific dev boxes, CI, production, etc.).

### `run`

You can run `./run` to get a list of commands and each command has
documentation in the `run` file itself.

It's a shell script that has a number of functions defined to help you interact
with this project. It's basically a `Makefile` except with [less
limitations](https://nickjanetakis.com/blog/replacing-make-with-a-shell-script-for-running-your-projects-tasks).
For example as a shell script it allows us to pass any arguments to another
program.

This comes in handy to run various Docker commands because sometimes these
commands can be a bit long to type. Feel free to add as many convenience
functions as you want. This file's purpose is to make your experience better!

*If you get tired of typing `./run` you can always create a shell alias with
`alias run=./run` in your `~/.bash_aliases` or equivalent file. Then you'll be
able to run `run` instead of `./run`.*

<hr>

### In development
### Updating dependencies

Let's say you've customized your app and it's time to make a change to your
`Gemfile` or `package.json` file.

Without Docker you'd normally run `bundle install` or `yarn install`. With
Docker it's basically the same thing and since these commands are in our
`Dockerfile` we can get away with doing a `docker compose build` but don't run
that just yet.

You can run `./run bundle:outdated` or `./run yarn:outdated` to get a list of
outdated dependencies based on what you currently have installed. Once you've
figured out what you want to update, go make those updates in your `Gemfile`
and / or `package.json` file.

Then to update your dependencies you can run `./run bundle:install` or `./run
yarn:install`. That'll make sure any lock files get copied from Docker's image
(thanks to volumes) into your code repo and now you can commit those files to
version control like usual.

Alternatively for updating your gems based on specific version ranges defined
in your `Gemfile` you can run `./run bundle:update` which will install the
latest versions of your gems and then write out a new lock file.

You can check out the `run` file to see what these commands do in more detail.
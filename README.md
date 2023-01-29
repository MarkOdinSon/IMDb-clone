# My IMDb clone pet-app Rails + Docker
Mark Hladkov - 2023 year
<br><br>
![Log in page](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/log_in.png)
<br><br>
![Index (main) page](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/index_1.png)

## Running this app on your local machine

Run the following algorithm to deploy this project on your local machine <br><br>
Installation algorithm (steps): <br>
1. `git clone https://github.com/MarkOdinSon/IMDb-clone.git AppIMBbClone` <br>
2. `cd AppIMBbClone` <br>
3. `cp .env.example .env` <br>
4. `docker-compose up --build` <br>
5. `./run rails db:setup` (input in database some users and categories by default) file: db/seeds.rb <br>
6. `./run rails db:seed`
7. go to http://localhost:8000/ <br>
   Enjoy!
<hr>
./run bundle:install (now not necessary anymore, command #4 do it automatically) <br>
<hr>

## General information

This app is using Rails 7.0.4, Ruby 3.2.0, Redis 7.0.7, PostgreSQL 15.1. <br>

### Tech stack

If you don't like some of these choices that's no problem, you can swap them
out for something else on your own.

#### Back-end

- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)
- [Sidekiq](https://github.com/mperham/sidekiq) (not necessary in this case)
- [Action Cable](https://guides.rubyonrails.org/action_cable_overview.html) (not necessary in this case)
- [ERB](https://guides.rubyonrails.org/layouts_and_rendering.html)
- [Rspec-Rails](https://github.com/rspec/rspec-rails)

#### Front-end

- [esbuild](https://esbuild.github.io/)
- [Hotwire Turbo](https://hotwired.dev/)
- [StimulusJS](https://stimulus.hotwired.dev/)
- [TailwindCSS](https://tailwindcss.com/)
- [Flowbite](https://flowbite.com/)
- [Heroicons](https://heroicons.com/)
- [jQuery UI](https://jquery.com/)

<hr>

## Files of interest

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

If the commands you run with the ./run ... file don't work then try changing all the entries in the run file from "docker-compose" to "docker compose". 
Everything works for me when docker-compose is written.

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

## In development
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

### Action with test environmental

run rails:db seed for test environmental: `./run rails db:seed RAILS_ENV=test --trace` <br>
<br>
run rails console in test environmental: `./run rails console -e test` <br>
<br>
run RSpec with Docker in test environmental => `docker-compose run -e "RAILS_ENV=test" web bundle exec rspec`
<br><br>
Also, you can run all these commands in development environmental: <br><br>
`./run rails db:seed RAILS_ENV=development --trace` <br><br>
`./run rails console` <br><br>
`docker-compose run -e "RAILS_ENV=test" web bundle exec rspec`
<hr>

## Main changes vs a newly generated Rails app

Here's a run down on what's different. You can also use this as a guide to
Dockerize an existing Rails app.

- **Core**:
   - Use PostgreSQL (`-d postgresql)` as the primary SQL database
   - Use Redis as the cache back-end
   - Use Sidekiq as a background worker through Active Job
   - Use a standalone Action Cable process
- **App Features**:
   - Add `pages` controller with a home page
   - Add `up` controller with 2 health check related actions
- **Config**:
   - Log to STDOUT so that Docker can consume and deal with log output
   - Credentials are removed (secrets are loaded in with an `.env` file)
   - Extract a bunch of configuration settings into environment variables
   - Rewrite `config/database.yml` to use environment variables
   - `.yarnc` sets a custom `node_modules/` directory
   - `config/initializers/rack_mini_profiler.rb` to enable profiling Hotwire Turbo Drive
   - `config/initializers/assets.rb` references a custom `node_modules/` directory
   - `config/routes.rb` has Sidekiq's dashboard ready to be used but commented out for safety
   - `Procifile.dev` has been removed since Docker Compose handles this for us
- **Assets**:
   - Use esbuild (`-j esbuild`) and TailwindCSS (`-c tailwind`)
   - Add `postcss-import` support for `tailwindcss` by using the `--postcss` flag
   - Add ActiveStorage JavaScript package
- **Public:**
   - Custom `502.html` and `maintenance.html` pages
   - Generate favicons using modern best practices

Besides the Rails app itself, a number of new Docker related files were added
to the project which would be any file having `*docker*` in its name. Also
GitHub Actions have been set up.

<hr>

## About the author

- Docker + Rails template origin: Nick Janetakis | https://nickjanetakis.com | @nickjanetakis [https://github.com/nickjj/docker-rails-example]
- Developer of this site: Mark Hladkov (web developer) | [Telegram](https://t.me/MarkOdinSon)

Developed this project as my Rails pet-project with Docker. <br><br>
In order to demonstrate my knowledge of web application development. <br><br>
Such as: server-side (databases + SQL (ORM) DDL & DML, business logic, API, authorization, unit testing and other debugging tools, Docker, Git)
and front-end JavaScript, AJAX or fetch, Tailwind CSS, dynamic pages without reloading (turbo frames), 
WYSIWYG Trix editor to create and edit posts with attachments, responsive page layout (HTML Responsive Web Design), page paganation, seach by title or selected categories and etc.)

<hr>

## Gallery of photos

![Edit page sample 1](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/edit_1.png)
<br><br>
![Edit page sample 2](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/edit_2.png)
<br><br>
![Index (main) page on phone](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/index_2.png)
<br><br>
![Movie post adding sample 1](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/new_1.png)
<br><br>
![Movie post adding sample 2](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/new_2.png)
<br><br>
![Page pagination sample 1](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/pagination_1.png)
<br><br>
![Page pagination sample 2](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/pagination_2.png)
<br><br>
![Rating modal sample 1](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/rating_1.png)
<br><br>
![Rating modal sample 2](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/rating_2.png)
<br><br>
![Search on site](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/search_1.png)
<br><br>
![Movie details page 1](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/show_movie_1.png)
<br><br>
![Movie details page 2](https://github.com/MarkOdinSon/IMDb-clone/blob/main/img_for_readme/show_movie_2.png)
<br><br>

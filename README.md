# Rails on Replit

This is a template to get you started with Rails on Replit. It's ready to go so you can just hit run and start coding!

This template was generated using `rails new` (after you install the `rails` gem from the packager sidebar) so you can always do that if you prefer to set it up from scratch. The only had two make config changes we had to make to run it on Replit:

- bind the app on `0.0.0.0` instead of `localhost` (see `.replit`)
- allow `*.repl.co` hosts (see `config/environments/development.rb`)
- allow the app to be iframed on `replit.com` (see `config/application.rb`)

## Running the app

Simple hit run! You can edit the run command from the `.replit` file.

## Running commands

Start every command with `bundle exec` so that it runs in the context of the installed gems environment. The console pane will give you output from the server but you can run arbitrary command from the shell without stopping the server.

## Database

SQLite would work in development but we don't recommend running it in production. Instead look into using the built-in [Replit database](http://docs.replit.com/misc/database). Otherwise you are welcome to connect databases from your favorite provider. 

## Help

If you need help you might be able to find an answer on our [docs](https://docs.replit.com) page. Feel free to report bugs and give us feedback [here](https://replit.com/support).

#  Inventory Web Application and JSON API

### Features
* Allows user to create, edit, view, and delete inventory items. 
* Inventory item data stored includes: SKU, Item Name, Item Description, Price, and Count.
* Exposes all data via JSON REST API 
* Allows deletion comments 
* Allows undeletion (restore) and removes deletion comment

### Development Technologies and Process

* Ruby on Rails scaffolding was used to create most of the application, including JSON API endpoints.
* Visual Studio and Replit were used as IDEs
* Mac Terminal, git command line, and Github Desktop were used as well.
* Unit testing was done with built in `rails test` and fixtures.
* I exposed the JSON endpoints by adding `skip_before_action :verify_authenticity_token` to my `items_controller.rb` to skip the CSRF check that was stopping my PUT requests.


## Dependencies/Software Needed

### Ensure that Ruby on Rails and Relevant Dependencies Installed

If the dependencies and versions below are installed you can skip ahead to Cloning and Installing the App Locally. Otherwise, read on and I will link to the Ruby on Rails documentation that includes how to get set up.

### Dependency Versions

You may already have the dependencies installed.  Please ensure that the versions are the same as the ones the project was made with, or reasonably compatible.  


Project was made using:
* Ruby version: `3.0.3`
* Rails Version: `7.0.1`
* sqlite3 Version: `3.36.0 2021-06-18 18:58:49 d24547a13b6b119c43ca2ede05fecaa707068f18c7430d47fc95fb5a2232aapl`
* node Version: `v16.13.1`
* yarn version: `1.22.17`
* git version: `2.32.0 (Apple Git-132)` 

To check, please use the following commands in terminal to confirm which versions of the dependencies you have (or if they are missing). 

*Please note: I have made them extended code blocks so you should see a copy to clipboard button on the right if you mouse over the code block.*
```
ruby -v
```
```
rails -v
```
```
sqlite3 --version
```
```
node --version
```
```
yarn --version
```

```
git --version
```

### Installing Ruby On Rails

If you do not have all the above dependencies, it is hard to know what your starting point is and your operating system.  You will need to install the above dependencies and I have instructions to do so from the Terminal/Command Line.

So please follow these instructions in section 3.1 for installing Ruby on Rails: [Ruby on Rails Getting Started Guide: Installing Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails).  You can stop when you reach section 3.2

#### Potential Mac Issue: Errors with Ruby Version?

I had trouble installing Ruby on my Mac.  The built-in Mac Ruby version is too low for Ruby on Rails, but kept responding to `which ruby` and `ruby --version`.  To install Ruby 3.0.3 I had to follow this guide to install it with `rbenv`: [How To Install Ruby On Rails with rbenv on Macos](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos)


## Cloning and Installing App Locally

### Git versus Zip File Alternative
`git` is needed to checkout the project.  Alternatively, you can download the archive and extract it from here: [Zip Archive Main.Zip](https://github.com/nhICS314/inventory/archive/refs/heads/main.zip).  

In that case, please extract the folder in terminal using your choice of extractor and then continue from step 2 or 3 below in directory `inventory-main` (or wherever you chose to extract it: for me, that was where it was extracted.)


*Please note: I have made them extended code blocks so you should see a copy to clipboard button on the right if you mouse over the code block.*


### Clone and Installation via Command Line
Open terminal or similar application
1. Clone the repository: 
```
git clone https://github.com/nhICS314/inventory.git
```
2. Navigate to where the project folder is located:  

```
cd inventory
```
3. Once in the correct folder use command:  
```
bundle install
```
4. Create database:  
```
rails db:migrate
```

5. Optional, but useful to save some time:  add test data to the database
```
rails db:seed
```


## Starting Server and Viewing App

*This assumes you completed the prior section on Clone and Installation via Command line*

* Start the server: 
```
rails server
```
* Visit app:  
    * In your web browser navigate to: http://localhost:3000/items

### Brief Explanation of App

The first page will show all the items in the inventory. You can also:
* Create a new item in the inventory using the `New item` link at the bottom of the list. 
* Under each item is a link labeled `Show this item` to see the item's details and edit or delete the item. 
* Deleted Items shown on bottom of the show all items page.
* Each deleted item has a link to undelete the item which will clear the deleted comment and restore the item to the active items.
* JSON REST APIs are exposed and described below

### JSON REST API Endpoints
<details>

I initially started writing out the data model and APIs by hand here. I wanted to try auto-generating them, but I had a lot of problems getting APIPIE to work [(see: APIPIE Tutorial on Youtube)](https://www.youtube.com/watch?v=fkACBI0fcRI).  So in the end I am writing out my documentation here.

I'll lay out the APIs first, then easy to copy and paste `curl` examples, and the data model in JSON will be explained immediately following.

*I essentially have two URL endpoints, but the different HTTP method and request body will result in different behavior.*

|Function| HTTP Method | API Endpoint |
|--------|-------------|--------------|
|Read All Items| `GET`|`http://localhost:3000/items.json`| 
|Create single item| `POST` | `http://localhost:3000/items.json`  | 
|Read Single Item | `GET`|`http://localhost:3000/items/[id].json`|
|Update Single Item | `PUT` / `PATCH`|  `http://localhost:3000/items/[id].json`  |
|Delete single item | `DELETE` |  `http://localhost:3000/items/[id].json` |
</details>

### curl Examples
<details>

I used [Postman](https://www.postman.com/downloads/) to test, and then I used the `code` button to download the `curl` command.  

*Please note: If you want to run the `curl` commands from your terminal, you should note down the **specific ids** that you have after running `db:seed` and/or using the application, or after you read all items with the first command.*

*If it doesn't work you may need to remove the `|json_pp` from the end. It worked on my computer and I felt it was easier to read so I am hoping it works for you. `json_pp` also seems to reorder the output to alphabetize based on the name of each property.*


#### Read all items

```
curl --request GET 'http://localhost:3000/items.json' | json_pp
```

#### Create Single Item
```
curl --request POST 'http://localhost:3000/items.json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "item": {
        "name": "Naan Bread",
        "price": "2.99",
        "description": "Specialty bread.",
        "sku": "NAANSKU",
        "count": 10
    }
}' | json_pp
```

#### Read Single Item
```
curl --request GET 'http://localhost:3000/items/3.json' | json_pp
```

#### Update Single Item
```
curl --request PUT 'http://localhost:3000/items/3.json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "item":{
    "name": "Wheat Bread",
    "price": "2.99",
    "description": "Sandwich sliced bread.",
    "sku": "WHEATBREADSKU",
    "count": 10
    }
}' | json_pp
```

#### Delete Single Item
```
curl --request DELETE 'http://localhost:3000/items/3.json' | json_pp
```
</details>

### Data Model and Example JSON Object
<details>

I built this with a single item table. All fields are readable, but `id`,`created_at` and `updated_at` may not be updated via the APIs, they are automatically created and updated by Rails.


| Field      | Type |  Required | Constraints / Notes|
| ----------- | ----------- |-------|------|
| `id`      | Unique ID Integer| N/A | Unique and Auto-generated|
| `name`   | String (Short Text) | Yes | None |
| `price`   | Decimal | Yes | Greater than or equal to zero |
| `description`   | Text | Yes | None |
| `sku`   | Text | Yes | Unique and case sensitive  |
| `count`   | Integer | Yes | Greater than or equal to zero  |
| `deletedComment` | String | No | None |
| `created_at`   | Timestamp | N/A | Auto-generated, not exposed|
| `updated_at`   | Timestamp | N/A | Auto-generated, not exposed|
| `deleted_at`   | Timestamp | N/A | Auto-generated, not exposed, paranoia feature|


#### Example JSON Object (A sample response to an object at https://localhost:3000/items/1.json)
```
   {
        "id": 1,
        "name": "bread",
        "price": "2.5",
        "description": "white",
        "sku": "fg543",
        "count": 3,
        "created_at": "2022-01-09T20:27:46.823Z",
        "updated_at": "2022-01-09T20:27:46.823Z",
        "url": "http://localhost:3000/items/1.json"
    }
```
</details>


### Running Tests
<details>

You can run the tests with the following commands, ensure you are at the top level `inventory` folder to run these commands in terminal:

```
rails test -v
```

If you have [Google Chrome](https://www.google.com/chrome/) installed, you can also run system tests.  You can also run system tests with the following:
```
rails test:system TESTOPTS="-v"
```

If I continue working on this or similar projects, I would like to learn how to directly access the JSON apis and test that the JSON key:value pairs matched.  I also would like to try testing the file download like this: [How to write a Rails system test for downloading a file?](https://medium.com/@petervandeput/how-to-write-a-rails-system-test-for-downloading-a-file-d4f972e174dc) and validating the contents. 
</details>

## Tutorials Used

I used some tutorials to help:
* [Ruby on Rails Blog with Post and Comment](https://www.bogotobogo.com/RubyOnRails/RubyOnRails_Blog_with_post_and_comment.php)
* [Getting Started With Rails](https://guides.rubyonrails.org/getting_started.html)
* [How To Install Ruby On Rails with rbenv on Macos](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos)
* [Rails: Turn off CSRF Token](https://stackoverflow.com/questions/5669322/turn-off-csrf-token-in-rails-3)
* [Seeding Database in Ruby on Rails](https://ninjadevel.com/seeding-database-ruby-on-rails/)
* [Pretty Print JSON with curl](https://mkyong.com/web/how-to-pretty-print-json-output-in-curl/)
* [Rails HTTP Status Code](https://gist.github.com/mlanett/a31c340b132ddefa9cca)
* [Testing Rails 5 In Postman](https://medium.com/@spaquet/testing-rails-5-api-with-postman-36f1e79dc4d)
* [Comparing Paranoia and Discard](https://entrision.com/blog/comparing-paranoia-vs-discard/)
* [Basic Routing](https://www.sitepoint.com/an-in-depth-look-at-basic-rails-routing/)
* [How to Pass IDs in a Route](https://stackoverflow.com/questions/42363756/rails-how-to-pass-id-to-custom-controller)
* [How to Use Paranoia](https://www.driftingruby.com/episodes/deleting-and-undeleting-with-paranoia)

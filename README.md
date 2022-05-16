# Rails on Replit
Default Replit ReadMe
<details>

* bind the app on `0.0.0.0` instead of `localhost` (see `.replit`)
* allow `*.repl.co` hosts (see `config/environments/development.rb`)
* allow the app to be iframed on `replit.com` (see `config/application.rb`)

### Running the app

Simple hit run! You can edit the run command from the `.replit` file.

### Running commands

Start every command with `bundle exec` so that it runs in the context of the installed gems environment. The console pane will give you output from the server but you can run arbitrary command from the shell without stopping the server.

### Help

If you need help you might be able to find an answer on our [docs](https://docs.replit.com) page. Feel free to report bugs and give us feedback [here](https://replit.com/support).
</details>

#  Inventory Web Application and JSON API

### Features
* Allows user to create, edit, view, and delete inventory items. 
* Inventory item data stored includes: SKU, Item Name, Item Description, Price, Count, and Deletion Comments.
* Exposes all data via JSON REST API 
* Allows deletion comments 
* Allows undeletion (restore) and removes deletion comment

### Development Technologies and Process

* Ruby on Rails scaffolding was used to create most of the application, including JSON API endpoints.
* Visual Studio and Replit were used as IDEs
* Mac Terminal, git command line, and Github Desktop were used as well.
* Unit testing was done with built in `rails test` and fixtures.
* JSON endpoints were exposed by adding `skip_before_action :verify_authenticity_token` to my `items_controller.rb` to skip the CSRF check that was stopping my PUT requests.
* Used the ruby gem paranoia to do the restore and soft delete features.
* Used the ruby gem package [api_error_handler](https://github.com/jamesstonehill/api_error_handler) to create nicer error handling


## Dependencies/Software Needed

### Ensure that Ruby on Rails and Relevant Dependencies Installed
* If using Replit to run the program this section is not necessary and you can skip to the explanation of the app.
<details>

If the dependencies and versions below are installed, you can skip ahead to Cloning and Installing the App Locally. Otherwise, read on and I will link to the Ruby on Rails documentation that includes how to get set up.

### Dependency Versions

You may already have the dependencies installed.  Please ensure that the versions are the same as the ones the project was made with, or reasonably compatible.  

Project was made using:
* Ruby version: `3.0.3`
* Rails Version: `7.0.1`
* sqlite3 Version: `3.36.0 2021-06-18 18:58:49 d24547a13b6b119c43ca2ede05fecaa707068f18c7430d47fc95fb5a2232aapl`
* node Version: `v16.13.1`
* yarn version: `1.22.17`
* git version: `2.32.0 (Apple Git-132)` 

<details>

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
</details>

*Please note: I have made them extended code blocks so you should see a copy to clipboard button on the right if you mouse over the code block.*


#### Installation via Command Line
Open terminal or similar application to the folder the project is located in.

1. Once in the correct folder use command:  
```
bundle install
```
2. Create database:  
```
rails db:migrate
```
3. Optional, but useful to save some time:  add test data to the database
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

</details>    

## Brief Explanation of App

The first page will show all the active items in the inventory on the left and all the deleted items on the right. 

#### You can also:
* Create a new item in the inventory using the `New item` link at the top of the page. 
* Under each active item is a link labeled `Show this item` to see the item's details and edit or delete the item. 
* Under each deleted item is a link to undelete the item which will clear the deleted comment and restore the item to the active items.
* JSON REST APIs are exposed and described below

#### Undelete Functionality
* If a bad ID is passed in it will show an error message that says it couldn't find item with that ID.
* If an item is deleted (with or without a comment) it will restore the item to the active record and set comment to nil if applicable.
* If an item is not deleted it will still restore the item 'successfully' and return the http created code.

### JSON REST API Endpoints
<details>

|Function| HTTP Method | API Endpoint |
|--------|-------------|--------------|
|Read All Non-Deleted Items| `GET`|`http://localhost:3000/items.json`| 
|Create single item| `POST` | `http://localhost:3000/items.json`  | 
|Read Single Item | `GET`|`http://localhost:3000/items/[id].json`|
|Update Single Item | `PUT` / `PATCH`|  `http://localhost:3000/items/[id].json`  |
|Delete single item | `DELETE` |  `http://localhost:3000/items/[id].json` |
|Restore Single Item | `GET`|`http://localhost:3000/items/[id]/restore.json`|
</details>

### curl Examples
<details>

I used [Postman](https://www.postman.com/downloads/) to test, and then I used the `code` button to download the `curl` command.  

*Please note: If you want to run the `curl` commands from your terminal, you should note down the **specific ids** that you have after running `db:seed` and/or using the application, or after you read all items with the first command.*

*If it doesn't work you may need to remove the `|json_pp` from the end. It worked on my computer and I felt it was easier to read so I am hoping it works for you. `json_pp` also seems to reorder the output to alphabetize based on the name of each property.*


#### Read all non-deleted items

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
curl --request DELETE 'http://localhost:3000/items/1.json' | json_pp
```

#### Restore Single Item
```
curl --request GET 'http://127.0.0.1:3000/items/1/restore.json' | json_pp
```

</details>

### Data Model and Example JSON Object
<details>

I built this with a single item table. All fields are readable, but `id`,`created_at`, `updated_at`, and `deleted_at` may not be updated via the APIs, they are automatically created and updated by Rails/Paranoia.


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


#### Example JSON Object (A sample response to an object at http://localhost:3000/items/1.json)
```
   {
       "id":1,
       "name":"formula",
       "price":"8.99",
       "description":"similac",
       "sku":"MILK",
       "count":7,
       "deletedComment":null,
       "created_at":"2022-05-12T05:28:56.802Z",
       "updated_at":"2022-05-16T01:50:08.936Z",
       "url":"http://localhost:3000/items/1.json"
       }
```
</details>


### Running Tests
<details>
Some of the tests were auto-generated by rails.  One of the tests I added checks the functionality of the soft delete and restore methods. It deletes an item, checks that the deleted comment was set, then it restores the item and checks that the deleted comment was set to nil.

You can run the tests with the following commands, ensure you are at the top level folder to run these commands in terminal:

```
rails test -v
```

If you have [Google Chrome](https://www.google.com/chrome/) installed, you can also run system tests.  You can also run system tests with the following:
```
rails test:system TESTOPTS="-v"
```

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

[![Run on Repl.it](https://repl.it/badge/github/nhICS314/InventoryFall2022)](https://repl.it/github/nhICS314/InventoryFall2022)